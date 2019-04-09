Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A66BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2506C2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="awBGEUgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDIGeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:34:06 -0400
Received: from mail-eopbgr750050.outbound.protection.outlook.com ([40.107.75.50]:58094
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfDIGeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMeXMHl6lyCw20jV6XEqW4SWa4MMShYinCmRXIJYxb4=;
 b=awBGEUgggTUYfUCCB1PiJwZhswt8oNhUjwoFe1GHKkICOd97IIp+Kr6mEOzjEPtvm7q0177Mc3w6kcIlYdbyfG7suwtQnyCW689jo4mLl/f06GALJ+KlWB3q5C4x4n2pMPgBi08/C1nAi04VgqDwsrNdUr2Lu0bq2KPMKAzNIZk=
Received: from DM6PR02CA0101.namprd02.prod.outlook.com (2603:10b6:5:1f4::42)
 by CY1PR02MB2010.namprd02.prod.outlook.com (2a01:111:e400:c5aa::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.15; Tue, 9 Apr
 2019 06:33:59 +0000
Received: from CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by DM6PR02CA0101.outlook.office365.com
 (2603:10b6:5:1f4::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16 via Frontend
 Transport; Tue, 9 Apr 2019 06:33:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT033.mail.protection.outlook.com (10.152.75.179) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Tue, 9 Apr 2019 06:33:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:60442 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hDkKU-0004ih-51; Mon, 08 Apr 2019 23:33:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hDkKP-0007UT-1A; Mon, 08 Apr 2019 23:33:53 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hDkKF-0007Sk-Jj; Mon, 08 Apr 2019 23:33:43 -0700
Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add fpga API's
To:     Moritz Fischer <mdf@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>
CC:     <atull@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <jollys@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-2-nava.manne@xilinx.com> <20190408171456.GA4293@archbook>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <9ab8f7fb-0936-3635-60fe-164402780429@xilinx.com>
Date:   Tue, 9 Apr 2019 08:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408171456.GA4293@archbook>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(2980300002)(189003)(199004)(58126008)(23676004)(65956001)(11346002)(110136005)(106466001)(31686004)(106002)(2616005)(63266004)(54906003)(356004)(316002)(50466002)(230700001)(126002)(36756003)(426003)(476003)(44832011)(8936002)(486006)(65826007)(446003)(4326008)(65806001)(229853002)(81166006)(31696002)(81156014)(6246003)(9786002)(36386004)(5660300002)(26005)(64126003)(77096007)(186003)(2906002)(14444005)(47776003)(336012)(6636002)(76176011)(8676002)(478600001)(2486003)(305945005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB2010;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a808a54-ee90-443d-c1bd-08d6bcb5593b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:CY1PR02MB2010;
X-MS-TrafficTypeDiagnostic: CY1PR02MB2010:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB20109AA949BD5CFE3177FF44C62D0@CY1PR02MB2010.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: VR3QtXCfMFTg7hg5sZir17p/NnUX4C6FD+O+kwUzxi/d3eqSG/fbCnOjWRZHST18OIJgLHT+8QFq6q+XgsD+F70uVjXzGkFIr9es1G3WY7mPYh/mjhdg5lOUw5J7H3UTsw4VcYUrFvVR+OWZN5mjV83CjYOAE4iaBEnKdHnAxi0WQvE8YayjanbLecBGfRRBlcMskFrnEk0iOxuGMOdHYZKiO7ROkXk+ROlxAJRA6wN+BGgb9wiZxQgQyXsKxl4J8QAMDzlzbUCPjW9iMcsNOBp+5DCJjQd3LNp4wFAt9JgXEzhMImf6YVxObxk8QWwOZtvffUbkFtiJf4jS8NtvVvl2w9kR3aAQbiD1dQA+jUWfMf0MlMyJPytPNJb2KMHe6fvW30wrVttMXumDQhaZx1E6DvFoVosWAQ5ndH65xIw=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 06:33:58.6180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a808a54-ee90-443d-c1bd-08d6bcb5593b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB2010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 04. 19 19:14, Moritz Fischer wrote:
> Hi Nava,
> 
> On Tue, Apr 02, 2019 at 06:01:21PM +0530, Nava kishore Manne wrote:
>> This Patch Adds fpga API's to support the Bitstream loading
>> by using firmware interface.
>>
>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>> ---
>> Changes for v4:
>> 		-None.
>>
>> Chnages for v3:
>> 		-Created patches on top of 5.0-rc5.
>> 		 No functional changes.
>>
>> Changes for v2:
>> 		-Added Firmware FPGA Manager flags As suggested by
>> 		 Moritz.
>>
>> Changes for v1:
>> 		-None.
>>
>> Changes for RFC-V2:
>> 		-New Patch
>>
>>  drivers/firmware/xilinx/zynqmp.c     | 46 ++++++++++++++++++++++++++++
>>  include/linux/firmware/xlnx-zynqmp.h | 10 ++++++
>>  2 files changed, 56 insertions(+)
>>
>> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
>> index 98f936125643..7159a90abc44 100644
>> --- a/drivers/firmware/xilinx/zynqmp.c
>> +++ b/drivers/firmware/xilinx/zynqmp.c
>> @@ -537,6 +537,50 @@ static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
>>  	return ret;
>>  }
>>  
>> +/*
>> + * zynqmp_pm_fpga_load - Perform the fpga load
>> + * @address:	Address to write to
>> + * @size:	pl bitstream size
>> + * @flags:
>> + *	BIT(0) - Bit-stream type.
>> + *		 0 - Full Bitstream.
>> + *		 1 - Partial Bitstream.
>> + *
>> + * This function provides access to pmufw. To transfer
>> + * the required bitstream into PL.
>> + *
>> + * Return: Returns status, either success or error+reason
>> + */
>> +static int zynqmp_pm_fpga_load(const u64 address, const u32 size,
>> +			       const u32 flags)
>> +{
>> +	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
>> +				   upper_32_bits(address), size, flags, NULL);
>> +}
>> +
>> +/**
>> + * zynqmp_pm_fpga_get_status - Read value from PCAP status register
>> + * @value: Value to read
>> + *
>> + * This function provides access to the xilfpga library to get
> 
> xilfpga? Is that PMU firmware you're talking about?
> 
>> + * the PCAP status
>> + *
>> + * Return: Returns status, either success or error+reason
>> + */
>> +static int zynqmp_pm_fpga_get_status(u32 *value)
>> +{
>> +	u32 ret_payload[PAYLOAD_ARG_CNT];
>> +	int ret;
>> +
>> +	if (!value)
>> +		return -EINVAL;
>> +
>> +	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
>> +	*value = ret_payload[1];
>> +
>> +	return ret;
>> +}
>> +
>>  /**
>>   * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
>>   *			       master has initialized its own power management
>> @@ -640,6 +684,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
>>  	.request_node = zynqmp_pm_request_node,
>>  	.release_node = zynqmp_pm_release_node,
>>  	.set_requirement = zynqmp_pm_set_requirement,
>> +	.fpga_load = zynqmp_pm_fpga_load,
>> +	.fpga_get_status = zynqmp_pm_fpga_get_status,
>>  };
>>  
>>  /**
>> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
>> index 642dab10f65d..4df226b6ab0f 100644
>> --- a/include/linux/firmware/xlnx-zynqmp.h
>> +++ b/include/linux/firmware/xlnx-zynqmp.h
>> @@ -48,6 +48,12 @@
>>  #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
>>  #define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
>>  
>> +/*
>> + * Firmware FPGA Manager flags
>> + * XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration
>> + */
>> +#define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
>> +
>>  enum pm_api_id {
>>  	PM_GET_API_VERSION = 1,
>>  	PM_REQUEST_NODE = 13,
>> @@ -56,6 +62,8 @@ enum pm_api_id {
>>  	PM_RESET_ASSERT = 17,
>>  	PM_RESET_GET_STATUS,
>>  	PM_PM_INIT_FINALIZE = 21,
>> +	PM_FPGA_LOAD = 22,
>> +	PM_FPGA_GET_STATUS,
> 
> Any reason you can't do 'PM_FPGA_GET_STATUS = 23' here? Trying to
> understand your reasoning. Are you planning to move them around?

It is 23 by design. In xilinx repo there was only the first value which
is recommended practice. But upstreaming is not done in the same order
that's why if there is a gap you need to assign values there.
Even that 22 can be removed in this case but it is just nit.

Thanks,
Michal
