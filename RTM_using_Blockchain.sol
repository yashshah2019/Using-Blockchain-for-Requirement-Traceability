pragma solidity ^0.5.1;
import "@nomiclabs/buidler/console.sol";
pragma experimental ABIEncoderV2;

contract MyContract {
    RTM[] public Requirements; // RTM Matrix
    uint public myint = 0; // assign testcase ID 
    uint256 public ReqCount=0; // Total no of Requirements for any specific system

    struct RTM {
        uint ReqNo;  // Requirement No
        string ReqDes;   // Description of the requirement.
        string userstories; // userstory corresponding to requirement
        string test_designer;  // information about person who designed test case
        uint[] TcId;       // Testcases for that specific Requirements
        uint[] status;      // status of TestCases i.e. either 1/0.
        uint[] unit_testing;  // whether unit testing is required or not for any testcase
        uint[] system_testing; // whether system testing is required or not for any testcase
        uint[] integration_testing; // whether integration testing is required or not for any testcase
    }

    mapping(uint => uint[]) private map;   // forward Traceability by mapping of Requirements with Testcases
    mapping(uint => uint) private map1;  // mapping of Testcases with their status
    mapping(uint => uint) private unit_map; // displays status of unit testing for any testcase
    mapping(uint => uint) private system_map; // displays status of system testing for any testcase
    mapping(uint => uint) private integration_map; // displays status of integration testing for any testcase
    mapping(uint => string) private testcase_map; // mapping of testcase with their description

    // function to add any requirements by providing sufficient information

    function addReq(uint _ReqNo,string memory _ReqDes,string memory _userstories,string memory person) public {
        uint[] memory newarray = new uint[](4);

        newarray[0] = 0 + myint;
        newarray[1] = 1 + myint;    // Testcase ID for the requirements
        newarray[2] = 2 + myint;
        newarray[3] = 3 + myint;

        uint[] memory newarray1 = new uint[](4);

        newarray1[0] = 1;
        newarray1[1] = 0;
        newarray1[2] = 1;       // boolean values denoting status of test cases.
        newarray1[3] = 0;

        map1[newarray[0]] = newarray1[0];
        map1[newarray[1]] = newarray1[1];
        map1[newarray[2]] = newarray1[2];   // mapping testcases with their status
        map1[newarray[3]] = newarray1[3];

        mapping_unit(newarray,newarray1);
        mapping_system(newarray,newarray1);
        mapping_integration(newarray,newarray1);
        mapping_testcase(newarray,person);

        Requirements.push(RTM(_ReqNo,_ReqDes,_userstories,person,newarray,newarray1,newarray1,newarray1,newarray1));  // storing all above information inside the matrix
        map[_ReqNo] = newarray;  // mapping of requirements with RTM
        ReqCount += 1;
        myint += 4;
    }

    // mapping_unit function is used to store the values inside mapping ("unit_map") data structure

    function mapping_unit(uint[] memory arr,uint[] memory arr1) public 
    {
        for(uint i=0;i<4;i++)
            unit_map[arr[i]] = arr1[i];
    }

    // mapping_unit function is used to store the values inside mapping ("system_map") data structure

    function mapping_system(uint[] memory arr,uint[] memory arr1) public 
    {
        for(uint i=0;i<4;i++)
            system_map[arr[i]] = arr1[i];
    }

    // mapping_unit function is used to store the values inside mapping ("integration_map") data structure 

    function mapping_integration(uint[] memory arr,uint[] memory arr1) public 
    {
        for(uint i=0;i<4;i++)
            integration_map[arr[i]] = arr1[i];
    }

    // mapping_unit function is used to store the values inside mapping ("unit_map") data structure

    function mapping_testcase(uint[] memory arr,string memory _val) public 
    {
        for(uint i=0;i<4;i++)
            testcase_map[arr[i]] = _val;
    }

    // function returns all information for that particular Req No.

    function get(uint no) public view returns(RTM memory) {
        return Requirements[no-1];
    }

    // BLOCKCHAIN IMMUTABLE PROPERTY is enhanced using below function

    // function changestatus(uint256 no, string memory _val) public view  {
    //     map1[no] = 5;
    // }

    function getTCfromReqNo(uint no) public view returns(uint[] memory) {
        return map[no];
    }

    // Below mentioned functions are used to change the value of unit testing, system testing, integration testing and
    // status if in future some changes have occured in software.

    function change_unit_testing(uint no,uint[] memory arr) public {
        Requirements[no-1].unit_testing = arr;
        mapping_unit(Requirements[no-1].TcId,arr);
    }

    function change_system_testing(uint no,uint[] memory arr) public {
        Requirements[no-1].system_testing = arr;
        mapping_unit(Requirements[no-1].TcId,arr);
    }

    function change_integration_testing(uint no,uint[] memory arr) public {
        Requirements[no-1].integration_testing = arr;
        mapping_unit(Requirements[no-1].TcId,arr);
    }

    // Whether the testcase is successfully implemented or not is displayed using "getstatusofTC" function

    function getstatusofTC(uint _val) public view returns(uint) {
        console.log("The status of testcase" , _val ," is" , map1[_val]);
        return map1[_val];
    }
    

}