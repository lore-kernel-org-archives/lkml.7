Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740C9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B87E20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kI16SkBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfDOIei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:34:38 -0400
Received: from mail-eopbgr800054.outbound.protection.outlook.com ([40.107.80.54]:14432
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbfDOIeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak7BP+kudwuiGOHMoLGXVz9w1sjL7wfkABOIToG2U7U=;
 b=kI16SkBYvlbuqPc/dr78NeqS6R67HNV1yONcI5Aa4F0QNYKfTUz+0VoSRx0azF0htsRstbvwFqgvz8v4VSmUA+TOP5wBdHd9IVtZJedUsgsxwiEsAgue5x6a9PHuG5xkU/vCLRIox96xDjNhNfbmNxjXS3EBW0N2hMfTw4gYqbE=
Received: from DM6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:5:1f4::36)
 by BL2PR02MB2002.namprd02.prod.outlook.com (2a01:111:e400:c749::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.17; Mon, 15 Apr
 2019 08:34:33 +0000
Received: from SN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by DM6PR02CA0095.outlook.office365.com
 (2603:10b6:5:1f4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.16 via Frontend
 Transport; Mon, 15 Apr 2019 08:34:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT049.mail.protection.outlook.com (10.152.72.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 15 Apr 2019 08:34:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:33749 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hFx4R-0004kD-W4; Mon, 15 Apr 2019 01:34:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hFx4M-0002U6-Sm; Mon, 15 Apr 2019 01:34:26 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x3F8YGYO020244;
        Mon, 15 Apr 2019 01:34:16 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hFx4C-0002Rn-1e; Mon, 15 Apr 2019 01:34:16 -0700
Subject: Re: [PATCH v5 1/3] firmware: xilinx: Add fpga API's
To:     Nava kishore Manne <nava.manne@xilinx.com>, <atull@kernel.org>,
        <mdf@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <jollys@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
References: <20190415071748.32275-1-nava.manne@xilinx.com>
 <20190415071748.32275-2-nava.manne@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <24f666c6-50e7-36d9-62a9-73efb9d66dda@xilinx.com>
Date:   Mon, 15 Apr 2019 10:34:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415071748.32275-2-nava.manne@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(189003)(199004)(8936002)(230700001)(2486003)(23676004)(63266004)(6246003)(356004)(2906002)(4744005)(316002)(6666004)(106002)(36756003)(64126003)(106466001)(8676002)(81166006)(81156014)(110136005)(58126008)(229853002)(5660300002)(2201001)(126002)(44832011)(31696002)(76176011)(36386004)(336012)(426003)(26005)(77096007)(9786002)(305945005)(186003)(65826007)(11346002)(446003)(2616005)(31686004)(476003)(47776003)(478600001)(486006)(65806001)(65956001)(50466002)(921003)(2101003)(1121003)(83996005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB2002;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b47fc281-db2c-4909-a902-08d6c17d2f43
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BL2PR02MB2002;
X-MS-TrafficTypeDiagnostic: BL2PR02MB2002:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB2002F9181614674E361B33D5C62B0@BL2PR02MB2002.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000800954F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jFAdCm/t2eW2Q1+3KlAh35pbr0Spi8ihjv+uif9q6iphPAZRvhLQ3G1V3dY8lRGDxXMvJDbXGKi3v5wxJ8HFKX+dv2hLe0xUBONFsfYczD6H2RcdkbGr/nNJ6S5ysWjhW5hPFUTOj8naaCgTOZo5sCf+/R5jM0hoafCut+q4ixg9SwaG2Jy+ZY2k5mJ5MtvrVLXvrS9LFWFoP17I0jOwW8ixZ7r7Uhwt7ok62eCrSI7XeksoYQ37FYe3skInLv6VlEe90baCPwZMxBA2iS41b2jyoEwkbAiNxjOeykGb6Zgw22ObFLHoIkLlbluMjwWbRrET6u8BGNoy8txRw2yUcP/w5suvVCtc1qhYpXga8mpRh0UipIiZ5t9fMP4cwzynzv8XTsdzQvDFVxXDxX5az2GzYJ4IwkUHYiAaH2UiGyM=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2019 08:34:32.4307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b47fc281-db2c-4909-a902-08d6c17d2f43
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB2002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15. 04. 19 9:17, Nava kishore Manne wrote:
> This Patch Adds fpga API's to support the Bitstream loading
> by using firmware interface.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> Changes for v5:
> 		-Modified API's doc as suggested by Moritz.
> 
>  drivers/firmware/xilinx/zynqmp.c     | 45 ++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 98f936125643..f355ad42917c 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -537,6 +537,49 @@ static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
>  	return ret;
>  }
>  
> +/*

This should be /**

I have fixed it myself and applied the whole series to zynqmp/soc branch
and this will go via arm-soc tree.

Thanks,
Michal
