Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB0E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PkpDTFEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCSHUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:20:10 -0400
Received: from mail-eopbgr730069.outbound.protection.outlook.com ([40.107.73.69]:64198
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfCSHUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 03:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYY8ptyZMv3SGVRX/R7Em9XeqeEHJf/UmvcxY6EVD8w=;
 b=PkpDTFEVMoqPcXdgnVQ8/q+6im9hkZr3ClzCEgi2Phiig4ZfmB4uI3xyiuYhj6nAiXtnchtUGKdmZQNRIEtb9OzO4eCCB/Q120jDenV/qvanbDeQixHwdA4NAXdAx/Ra9sf7WN6NPBNq8EVkcnNk/ELanOLzsGvYZdfXrkYXku4=
Received: from SN4PR0201CA0070.namprd02.prod.outlook.com
 (2603:10b6:803:20::32) by BN7PR02MB4049.namprd02.prod.outlook.com
 (2603:10b6:406:fe::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Tue, 19 Mar
 2019 07:20:06 +0000
Received: from CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by SN4PR0201CA0070.outlook.office365.com
 (2603:10b6:803:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 07:20:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT057.mail.protection.outlook.com (10.152.75.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 07:20:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h692b-0001Bv-5u; Tue, 19 Mar 2019 00:20:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h692W-0007fn-2Y; Tue, 19 Mar 2019 00:20:00 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2J7JswA027664;
        Tue, 19 Mar 2019 00:19:54 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1h692Q-0007ew-1b; Tue, 19 Mar 2019 00:19:54 -0700
Subject: Re: [PATCH] drivers: clk: zynqmp: Allow zero divisor value
To:     Stephen Boyd <sboyd@kernel.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        <linux-clk@vger.kernel.org>, <michal.simek@xilinx.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
References: <1551742066-10825-1-git-send-email-jollys@xilinx.com>
 <15f0f82f-0607-4cf5-f5a5-5edd7c5321bc@xilinx.com>
 <155293817691.20095.7275560826051843640@swboyd.mtv.corp.google.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <c9f01ef3-a692-6f15-46d8-8ce4226161bf@xilinx.com>
Date:   Tue, 19 Mar 2019 08:19:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <155293817691.20095.7275560826051843640@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(199004)(189003)(2486003)(31686004)(76176011)(23676004)(305945005)(64126003)(44832011)(2201001)(5660300002)(356004)(6666004)(81156014)(81166006)(126002)(486006)(31696002)(446003)(63266004)(2616005)(4326008)(54906003)(336012)(316002)(476003)(8676002)(11346002)(110136005)(58126008)(36386004)(426003)(106466001)(47776003)(65956001)(26005)(230700001)(36756003)(186003)(65806001)(2906002)(50466002)(77096007)(8936002)(229853002)(9786002)(478600001)(65826007)(6246003)(107886003)(106002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB4049;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38884b13-4b28-47b1-d127-08d6ac3b4fbb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN7PR02MB4049;
X-MS-TrafficTypeDiagnostic: BN7PR02MB4049:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB404955DD426BBBA46327B34DC6400@BN7PR02MB4049.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WqkT3dXCFgaKAtLdDb7Jj+QykERS4yY+LoPul5PRM2vs1cx4ohfMmF5Ht8pOZCUXG0bEUctN7KsuX+tBjebswT4fwe+JVAcMEKa6Oui1fF/StSjMWWoDxjYkEP0RB4gvDdu9OAzNzyDH9HLQ7SjrkJ9oKNJ+u1pe5B35UiD1pnY5UN48HtOFVJNQRF6kF66eW1MmheRdAoZ8hbHs3iA7IxPSOnYShp5XkWrptly/eE2VyHHOoqZnOQDqaWcAHtl7BdVTMMQxq5qNXYK1Jz2IGlO2uxbNOZ8URRDRkXrpLoatmmgW0rvWLJ7ygI6lzRGp84bgi5pfDqhySYQnViqvevLRG4wA7b7P3Q8dMV+J54Ns3yddxAEu37f0gmHIvOKhqbuMVq/qTWd7iA6Vbz6kpeIPcWaQXgnnAtUHN8kUGVA=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 07:20:05.6372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38884b13-4b28-47b1-d127-08d6ac3b4fbb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 03. 19 20:42, Stephen Boyd wrote:
> Quoting Michal Simek (2019-03-18 05:48:52)
>> On 05. 03. 19 0:27, Jolly Shah wrote:
>>> From: Rajan Vaja <rajan.vaja@xilinx.com>
>>>
>>> Zero divider is valid and default for some of ZynqMP
>>> clocks. Allow zero divisor when CLK_DIVIDER_ALLOW_ZERO
>>> for the clock is set.
>>>
>>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
>>> ---
>>>  drivers/clk/zynqmp/divider.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
>>> index a371c66..e146b6f 100644
>>> --- a/drivers/clk/zynqmp/divider.c
>>> +++ b/drivers/clk/zynqmp/divider.c
>>> @@ -76,6 +76,13 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
>>>       else
>>>               value = div >> 16;
>>>  
>>> +     if (!value) {
>>> +             WARN(!(divider->flags & CLK_DIVIDER_ALLOW_ZERO),
>>> +                  "%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
>>> +                  clk_name);
>>> +             return parent_rate;
>>> +     }
>>> +
>>>       return DIV_ROUND_UP_ULL(parent_rate, value);
>>>  }
>>>  
>>>
>>
>> Stephen: Do you want to take it via your tree?
>>
> 
> Sure.

ok. Then your turn with that two patches when you have time.

Thanks,
Michal


