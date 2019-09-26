Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91DDC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47726217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="idEFDSqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfIZKKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:10:14 -0400
Received: from mail-eopbgr810059.outbound.protection.outlook.com ([40.107.81.59]:13216
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfIZKKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:10:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn163GnJfnbjIWP8kvweqN0tuf8KqzeEOox6epcuolg3ieCp3Xx8RfZqqZ0BKTODn5JkSdeqaZEun9sSpsmWtJO1eDR+GAnBYVj9w7IuwgE5DlDCdjpKNslmyMfdWlKEeSVGQDpN1qnD3lYACFWdhMHgkN+Tls0Q6c3Vkab9ETqDCDI4/5P/KyR+6CEp34J34iZEDXH7GHGZZWv3bQnYq9pCzx1ooMHk2KwR0m3abJpGKP2IHRWxklYtPfPtc4JQ/BYjYjYOvV0D/Wd+hDQpA9UtN4uVU0CiQzgXiqxgi7uUItAsMemM8r570g0ZkUVamb+6nJfR9R5cWBcb9KPPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNzLumkYVP64xbiwLTo1WTcaduWtCrFwudq6VMlgtBU=;
 b=k50GGXrFOk1D2TJPlLLYX0bM8eP26FGhM+osugmeThZboh2D/F8wvkYioqR//AacKEU78SayXD+cWN4eytBlR3lGE9xc4b1LRZps8QkPevlNp/GPu4fPE2PLTm+OsP3f40f7hB5IXMUPndujqBjgerh0hNTXiVszKSgSC3j4SrTGggALmw9bVMPkCLlONbd5AKKHjcVV6suztppy0E+/cMblgS3frlp/3TYsaF96hApcvY8n3XqnX5jwJEQAT0P6jPa2xRIfsMQCmTQ5SKpLhfwTZQeG264wIgq6Vp3ES/tS818UntGWYcAkR+vIkYPhvOAA3xUzrxFl/oV34LdMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNzLumkYVP64xbiwLTo1WTcaduWtCrFwudq6VMlgtBU=;
 b=idEFDSqqpBjjCOA1QOlkAWhCDLtlYWGOtbXoJdlVhKgSY/D8u1fZgvp3w6+3EBKBBdwHwx7Laua+JFJ5v9YR7sraE/ce0R1C771OuNMqIjSkj5OGMU7yEjwYacm8IY7eIrZwxsWmouJiQybIgsj28r0GJ/DxGA07SyCl3fnMQLE=
Received: from SN4PR0201CA0013.namprd02.prod.outlook.com
 (2603:10b6:803:2b::23) by DM5PR0201MB3431.namprd02.prod.outlook.com
 (2603:10b6:4:76::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.25; Thu, 26 Sep
 2019 10:10:10 +0000
Received: from SN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by SN4PR0201CA0013.outlook.office365.com
 (2603:10b6:803:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17 via Frontend
 Transport; Thu, 26 Sep 2019 10:10:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT049.mail.protection.outlook.com (10.152.72.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:10:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iDQiw-0003Bs-13; Thu, 26 Sep 2019 03:10:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iDQiq-0007m2-Ry; Thu, 26 Sep 2019 03:10:04 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8QA9rPC012561;
        Thu, 26 Sep 2019 03:09:54 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iDQif-0007Wk-Lg; Thu, 26 Sep 2019 03:09:53 -0700
Subject: Re: [PATCH v2] soc: xilinx: Set CAP_UNUSABLE requirement for versal
 while powering down domain
To:     Jolly Shah <jolly.shah@xilinx.com>, matthias.bgg@gmail.com,
        andy.gross@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, bjorn.andersson@linaro.org,
        sean.wang@mediatek.com, m.szyprowski@samsung.com,
        michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>
References: <1566851444-22842-1-git-send-email-jolly.shah@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0f695009-6785-6576-3882-8e1cf69fe13d@xilinx.com>
Date:   Thu, 26 Sep 2019 12:09:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566851444-22842-1-git-send-email-jolly.shah@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(478600001)(23676004)(186003)(44832011)(446003)(58126008)(336012)(5660300002)(36386004)(31696002)(106002)(305945005)(229853002)(50466002)(316002)(36756003)(81156014)(8676002)(11346002)(9786002)(81166006)(2906002)(47776003)(230700001)(65806001)(2486003)(6246003)(2616005)(8936002)(65956001)(126002)(4326008)(76176011)(356004)(70586007)(26005)(476003)(486006)(426003)(31686004)(70206006)(107886003)(14444005)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3431;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ba62e1c-8e0b-4fdb-a35e-08d74269b725
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM5PR0201MB3431;
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3431:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3431ABCAA65011D24493B20EC6860@DM5PR0201MB3431.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ETdX7p6wJQF04jGpRV3BlzY6OUy8GryyhG6tacTaivQAb87r1oFNqdVwSR0LVUiEqBZ8GMcKbpazNWrRRXYoz24cCkypnbkVwvO5MBtfzDcNCEu7+X9mVhclmClazidU51picZewYsenldm8X3hpu6NVl5YKoIeRvlqzaRuitLBSMjUeG8GeHqemIaOCgVRKUx0X7i37sKI30CLCYSZA4phZbWQkqZMh5DY3yCZqfKJmyj3aXmfm9yPa+IZQO7IMjIn2NG9ivwSRPraqzIa2BxvswcE2eWrAwGA4ka/VoV4YIFL2FoZLk/9FHEj7D+dSG2mUacuW9w4wVELN4WOeEC1bsxORvdFIBTx18WhMeOzcM+SJ376XtYpPgl9XiKTS/sI6m+LiSTQlUeP6P5RkFah00r1g0N68o2d3dkGvDa0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:10:10.6439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba62e1c-8e0b-4fdb-a35e-08d74269b725
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3431
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 08. 19 22:30, Jolly Shah wrote:
> From: Tejas Patel <tejas.patel@xilinx.com>
> 
> For "0" requirement which is used to inform firmware that device is
> not required currently by master, Versal PLM (Platform Loader and
> Manager) which runs on Platform Management Controller and is responsible
> platform management of devices that disables clock, power it down
> and reset the device. genpd_power_off() is being called during runtime
> suspend also. So, if any device goes to runtime suspend state during
> resumes it needs to be re-initialized again. It is possible that
> drivers do not reinitialize device upon resume from runtime suspend
> every time ans so dont want it to be powered down or get reset
> during runtime suspend.
> 
> In Versal PLM new PM_CAP_UNUSABLE capability is added, which disables
> clock only and avoids power down and reset during runtime suspend. Power
> and reset will be gated with core suspend.So, this patch sets 
> CAPABILITY_UNUSABLE requirement during gpd_power_off()
> if platform is other than zynqmp.
> 
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---

Where is the version log?

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

I have not a problem with this patch but versal firmware is not wired in
firmware yet that's why this code shouldn't be called at all.

Can you please wire it?

Thanks,
Michal
