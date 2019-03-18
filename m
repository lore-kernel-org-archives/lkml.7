Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4811C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9099220850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="d4ljDQgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfCRMtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:49:10 -0400
Received: from mail-eopbgr770050.outbound.protection.outlook.com ([40.107.77.50]:9351
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfCRMtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4LZHfgjWHzpKeiYhDEcvnYEzXQuZeJkh2LyG/suNHY=;
 b=d4ljDQgPbOfmKDBRFxcehxubattnEYebnIZmneeYFXc3GajERVaP55OrnTjZNloJ8HkosYWH+AhVaMT2ziaOKiFAmBc7jrKet9MfnWP5GougPhhp9gx6edrIBEa3/rH2ChhacmEuGL87aicrqlj5DcoU9Z2yF3ND+sjsGJGZOBw=
Received: from MN2PR02CA0003.namprd02.prod.outlook.com (2603:10b6:208:fc::16)
 by CY4PR02MB2358.namprd02.prod.outlook.com (2603:10b6:903:c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Mon, 18 Mar
 2019 12:49:04 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by MN2PR02CA0003.outlook.office365.com
 (2603:10b6:208:fc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 12:49:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 12:49:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50127 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h5rhP-0005Cy-5M; Mon, 18 Mar 2019 05:49:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h5rhJ-0005LC-Sh; Mon, 18 Mar 2019 05:48:57 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2ICmtSR019293;
        Mon, 18 Mar 2019 05:48:55 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1h5rhH-0005KX-60; Mon, 18 Mar 2019 05:48:55 -0700
Subject: Re: [PATCH] drivers: clk: zynqmp: Allow zero divisor value
To:     Jolly Shah <jolly.shah@xilinx.com>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
References: <1551742066-10825-1-git-send-email-jollys@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <15f0f82f-0607-4cf5-f5a5-5edd7c5321bc@xilinx.com>
Date:   Mon, 18 Mar 2019 13:48:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551742066-10825-1-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(189003)(199004)(230700001)(126002)(476003)(2616005)(426003)(446003)(11346002)(486006)(2906002)(65826007)(8676002)(81166006)(81156014)(8936002)(36756003)(229853002)(65806001)(31696002)(478600001)(6666004)(356004)(2201001)(47776003)(65956001)(106002)(5660300002)(9786002)(36386004)(316002)(63266004)(107886003)(54906003)(64126003)(58126008)(110136005)(6246003)(44832011)(305945005)(336012)(2486003)(23676004)(76176011)(31686004)(50466002)(26005)(77096007)(186003)(106466001)(4326008)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2358;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25f98283-a795-492b-9f92-08d6aba01a00
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR02MB2358;
X-MS-TrafficTypeDiagnostic: CY4PR02MB2358:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB23588E70AF34C92C3534471DC6470@CY4PR02MB2358.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: M+//ZuC0gXwBF1TJmF5OfrMfm4lxvsvtm+HsnLiMNe0D0ONpHKif7N0bdfxjns6InNqoIMSq4N9I8a5OXyVqpmsBKoRwbnQQwv4O0+06W9/iS+IfIqWsJLas3rYxXTcl7rgOlBOv9Qi5OWWRmdgdMzEMGZl30jNFupgT+cW9lDpsKhgiljHoPBTdJ852u82qoBN90BeNrdM12KV4GV9kSW0K33L5F31cTl2oKzye/GP2Czb85O87gDCbHZcMpBVEs+nwif73zQ4//VhdyAIiYsWmmqx+1TzXOkqqAmW7iqFZH81m4/ZTEtuOdDAVTYrSxTcYuIyfIJ6/YlaNdiPpIyUixUf4tlhX7ajJQibpSONstbW15FyKGr8KCEN8rHXOFrXa23/s89tP30VPTpPFEY6hr+MdClvkbtmKv1nMsu8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 12:49:03.7125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f98283-a795-492b-9f92-08d6aba01a00
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 03. 19 0:27, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Zero divider is valid and default for some of ZynqMP
> clocks. Allow zero divisor when CLK_DIVIDER_ALLOW_ZERO
> for the clock is set.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/clk/zynqmp/divider.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> index a371c66..e146b6f 100644
> --- a/drivers/clk/zynqmp/divider.c
> +++ b/drivers/clk/zynqmp/divider.c
> @@ -76,6 +76,13 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
>  	else
>  		value = div >> 16;
>  
> +	if (!value) {
> +		WARN(!(divider->flags & CLK_DIVIDER_ALLOW_ZERO),
> +		     "%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
> +		     clk_name);
> +		return parent_rate;
> +	}
> +
>  	return DIV_ROUND_UP_ULL(parent_rate, value);
>  }
>  
> 

Stephen: Do you want to take it via your tree?

Thanks,
Michal

