Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40DCC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9352084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CSHNcbQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfHNHdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:33:13 -0400
Received: from mail-eopbgr750085.outbound.protection.outlook.com ([40.107.75.85]:56788
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfHNHdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:33:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyXVxLdKZ8FXMSJSCLkxC1Qw/geASkO+s9GqBbYDM2bl1M4ND1zgngo0nBagGTsHj4Zyg5t+JksgDDUuLTwts2RJyIuMRDVR/JDpr5XeqcMkx0r34vTYPjzqBhiNUW4kFXpzUP0bnnVgFnNSGB3cR6sn6LxJhHVib8TXL6t2r1MuZ5eke8SiZoZgasHqc1WSK8FTgoLCmdyRt1DXWRB7EdRTBBQpdu9vI3EYjpADDWWuLSWCvr2fdn2jsmeakBw5Ls/T4jjGB+euoQNe4i3Wt9FZviYqiOpjqGyyIGv02PXSw3MCbTA2DOzo/rGTOAKq4mETpC9SEAQn3qKWT0eIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFrGQvCJFlu19/qWI8WtMszBIy8CygzG4wJJpLg3cLI=;
 b=j4KM8jQYhUNlzz/QLWG4SM4j6c0E/0HGZa88qjvnjEjBHXyQOF23ygOUl2fHJ1y9KQ1NJrjiZAbKS3U/uylrj6kqzKtAI4GHI3AIP2LzgDRt0k8m3oMN0dGHz2pS5wJX0/C8wUlUVwq7jKU8qDNBrKCW6GC04T5phyzMQrg12T6Sni6hpmW9oZgJHc3s1V/JMg4YBTlW/+1J6GkqTnAtyF5UReGHWXkV/sDGUAVfdB0Yi4WajwLnXmxlWcumVPVsvoLUgYawXcAY3YLXfsbCHKqZ9X6bioEzl1vxMBbGbZvbXTs9e8+oc2WRq+F1sw/0G8LjU8GLIbCqXWg3ry5Nzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFrGQvCJFlu19/qWI8WtMszBIy8CygzG4wJJpLg3cLI=;
 b=CSHNcbQTHH5GRJ03xr1s+0Vfq1t/byt9Ubd57y1sh6HkRCOb2B1FJw5UGmAIBBOqzRp1wIeWLFCLI2KxMkELywG0sfkQxfRGzXXFvENva+KLo7RyZf1aoZNGQPYryY64Q1Wwh8Uoc9Sc85Grz06776y7/FbjfGyalGWBDFcqV8M=
Received: from DM6PR02CA0124.namprd02.prod.outlook.com (2603:10b6:5:1b4::26)
 by MW2PR02MB3803.namprd02.prod.outlook.com (2603:10b6:907:3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16; Wed, 14 Aug
 2019 07:33:08 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by DM6PR02CA0124.outlook.office365.com
 (2603:10b6:5:1b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.14 via Frontend
 Transport; Wed, 14 Aug 2019 07:33:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2178.16
 via Frontend Transport; Wed, 14 Aug 2019 07:33:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hxnmN-0004fI-0i; Wed, 14 Aug 2019 00:33:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hxnmH-0001yI-SH; Wed, 14 Aug 2019 00:33:01 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x7E7WvV3028655;
        Wed, 14 Aug 2019 00:32:57 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hxnmC-0001ww-Ug; Wed, 14 Aug 2019 00:32:57 -0700
Subject: Re: [PATCH] soc: xilinx: Set CAP_UNUSABLE requirement for versal
 while powering down domain
To:     Jolly Shah <jolly.shah@xilinx.com>, matthias.bgg@gmail.com,
        andy.gross@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, bjorn.andersson@linaro.org,
        sean.wang@mediatek.com, m.szyprowski@samsung.com,
        michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
References: <1565290836-18204-1-git-send-email-jolly.shah@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d775ff32-5004-b01b-e9a6-b2f947317ed8@xilinx.com>
Date:   Wed, 14 Aug 2019 09:32:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565290836-18204-1-git-send-email-jolly.shah@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(199004)(189003)(31686004)(47776003)(229853002)(8676002)(5660300002)(186003)(26005)(4326008)(63266004)(107886003)(36756003)(6246003)(65956001)(305945005)(65806001)(316002)(106002)(230700001)(81156014)(76176011)(478600001)(64126003)(6666004)(356004)(2486003)(23676004)(58126008)(8936002)(31696002)(81166006)(36386004)(70586007)(486006)(70206006)(44832011)(50466002)(426003)(476003)(446003)(11346002)(336012)(126002)(2616005)(54906003)(14444005)(65826007)(52146003)(9786002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR02MB3803;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca89710-5c58-4ff4-3dbb-08d72089a6e6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MW2PR02MB3803;
X-MS-TrafficTypeDiagnostic: MW2PR02MB3803:
X-Microsoft-Antispam-PRVS: <MW2PR02MB38038DE6C5EA680F8C9EE008C6AD0@MW2PR02MB3803.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01294F875B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xsWW4Idy8GehgySll5q0uBCFYjpLAudAxeM3eeQU6EtcWlveqXRISx5trJ+5mJmom/buKnQAdurs2LujBtTBRfFIP4vfdItVYWLShG2IjPkLFFUUNcLjVnnuRnLUB+yU59ftCGAAaH7Uth7yAexUSjVuH58GeqNvfSKYybmv9RkiAR00bft068k685lBiy5smKojV6E4W+Fza9MLl3bCaNkrNATqzh09aGwH0gPEmmrdhqe1UH8zIoT6L8HOobTXcV9rL5yyg6Q5KUoxHBnJFfWeJpy7a08sJ4q/eQ0spwsWlWOYG8VMYkNMkAdZ35XfPctc1hZVEt15s+JqfaOrGk1YdlBPWsDbs2zX3OZkIober4v21LLqiIT9cHufbQt6ZJdzfmx6gxwOl5r72frpcIikBXXeDcew3beOqGKvv9g=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2019 07:33:07.4906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca89710-5c58-4ff4-3dbb-08d72089a6e6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 08. 19 21:00, Jolly Shah wrote:
> From: Tejas Patel <tejas.patel@xilinx.com>
> 
> For "0" requirement which is used to inform firmware that
> device is not required currently by master, Versal LibPM disables

This could be the first time when LibPM is mentioned in connection to
Versal. That's why you should also say what's that and when it runs to
make it clear.

> clock, power it down and reset the device. genpd_power_off()
> is being called during runtime suspend also. So, if any device
> goes to runtime suspend state during resumes it needs to be
> re-initialized again. It is possible that drivers do not
> reinitialize device upon resume from runtime suspend every time.
> 
> In LibPM new PM_CAP_UNUSABLE capability is added, which disables
> clock only and avoids power down and reset.
> So, set CAPABILITY_UNUSABLE requirement during zynqmp_gpd_power_off()
> if platform is other than zynqmp.
> 
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/soc/xilinx/zynqmp_pm_domains.c | 10 ++++++++--
>  include/linux/firmware/xlnx-zynqmp.h   |  3 ++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
> index 600f57c..23d90cb 100644
> --- a/drivers/soc/xilinx/zynqmp_pm_domains.c
> +++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
> @@ -2,7 +2,7 @@
>  /*
>   * ZynqMP Generic PM domain support
>   *
> - *  Copyright (C) 2015-2018 Xilinx, Inc.
> + *  Copyright (C) 2015-2019 Xilinx, Inc.
>   *
>   *  Davorin Mista <davorin.mista@aggios.com>
>   *  Jolly Shah <jollys@xilinx.com>
> @@ -25,6 +25,8 @@
>  
>  static const struct zynqmp_eemi_ops *eemi_ops;
>  
> +static int min_capability;
> +
>  /**
>   * struct zynqmp_pm_domain - Wrapper around struct generic_pm_domain
>   * @gpd:		Generic power domain
> @@ -106,7 +108,7 @@ static int zynqmp_gpd_power_off(struct generic_pm_domain *domain)
>  	int ret;
>  	struct pm_domain_data *pdd, *tmp;
>  	struct zynqmp_pm_domain *pd;
> -	u32 capabilities = 0;
> +	u32 capabilities = min_capability;
>  	bool may_wakeup;
>  
>  	if (!eemi_ops->set_requirement)
> @@ -283,6 +285,10 @@ static int zynqmp_gpd_probe(struct platform_device *pdev)
>  	if (!domains)
>  		return -ENOMEM;
>  
> +	if (!of_device_is_compatible(dev->parent->of_node,
> +				     "xlnx,zynqmp-firmware"))
> +		min_capability = ZYNQMP_PM_CAPABILITY_UNUSABLE;
> +
>  	for (i = 0; i < ZYNQMP_NUM_DOMAINS; i++, pd++) {
>  		pd->node_id = 0;
>  		pd->gpd.name = kasprintf(GFP_KERNEL, "domain%d", i);
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 778abbb..b8a7c22 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -2,7 +2,7 @@
>  /*
>   * Xilinx Zynq MPSoC Firmware layer
>   *
> - *  Copyright (C) 2014-2018 Xilinx
> + *  Copyright (C) 2014-2019 Xilinx
>   *
>   *  Michal Simek <michal.simek@xilinx.com>
>   *  Davorin Mista <davorin.mista@aggios.com>
> @@ -46,6 +46,7 @@
>  #define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
>  #define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
>  #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
> +#define ZYNQMP_PM_CAPABILITY_UNUSABLE	0x8U

Please align it with other macros (or fix that macros).

Other then two small nits patch is fine.

Thanks,
Michal
