Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF792C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C362184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QdBlNuBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbfHHTBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:01:13 -0400
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:57570
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732375AbfHHTBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:01:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXa/yh5T6BBzQTbJOfyXWG2ecPf3oNEKqaEe4UiTztLAfsCUUDi8JjvlXYjq8j8OSIcLGYXKFUTwhntTbiS/JWY6fnsfG5U3axqtDshN3y1xpkDQywbA86eROMGbucvdNeqvR9vPRbGBExP9W19gw6EAYla0G2JUTmSk/sfJBobYY0EiyBmxKjKOkGPbyt8iE6jk9bwDFry6U4RHl1cFuDs5t00sIoY0SZL0W7LFrSrX+UgE4Aqnb4tFwZOyLOhjDHnO4apeS7JOOKeHmEmL9Jh2s4iKsWPKPgYY6+yv7WIpi3F7+YvI7exd+1r/HKDVsQrNOcfWVqOpgRvBy/S0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIGYYFurdZJEDWrUVgLQJxGefrpqgP2r5e0FtazLb8g=;
 b=P35UPPlhk7mwV/g9vlWQrO518rEHxWtIXtXNTiYJjMckr8jyQ7/2bPuKOyKZ1Zo+DfglgLYPI6HROZboXIgTo8TG2pF54tCX524QTfAXDKn/ez/0LtkgPf6YXnwRZAWDaEXGuLIuWej95kcBgG8kcGOkoNWERSn+XLTmqX3+eYy/OaBnuy8R9/ctznkyHx8R1AeR+DywFYWzAi9AMDmOduc7weztKUfucxJsGb85d3+/mtUzsj7pUjvjGc72W1HfbTVjUN4gbSJwL7SCySuRMXCjdHL0o6eYmvWuRooJZZJhCdX59QwPFrYnzuI86R/RHE7NXrnElREJs9lrVjOQ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIGYYFurdZJEDWrUVgLQJxGefrpqgP2r5e0FtazLb8g=;
 b=QdBlNuBTcOBaoz9Gi3l50z6m0RIpdNEZBQEpBkrfZDFKKNTkqhIEG9mIbR27Iiht0PdAxlf2M/YuprUfavGGe4yRnSX6P8fCgaoeGOQ1hWvHol/MO23Ifoqr0a4NRKcYvxZu9dxH+YkoASbuH+hBGU2MGPeSZbuPoWggbvBLjZg=
Received: from CY4PR02CA0004.namprd02.prod.outlook.com (2603:10b6:903:18::14)
 by SN6PR02MB4832.namprd02.prod.outlook.com (2603:10b6:805:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18; Thu, 8 Aug
 2019 19:01:08 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by CY4PR02CA0004.outlook.office365.com
 (2603:10b6:903:18::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Thu, 8 Aug 2019 19:01:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Thu, 8 Aug 2019 19:01:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1hvnet-0002c3-BN; Thu, 08 Aug 2019 12:01:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1hvneo-0004w0-6C; Thu, 08 Aug 2019 12:01:02 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x78J0vKi011972;
        Thu, 8 Aug 2019 12:00:57 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1hvnej-0004rm-A1; Thu, 08 Aug 2019 12:00:57 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     matthias.bgg@gmail.com, andy.gross@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, bjorn.andersson@linaro.org,
        sean.wang@mediatek.com, m.szyprowski@samsung.com,
        michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH] soc: xilinx: Set CAP_UNUSABLE requirement for versal while powering down domain
Date:   Thu,  8 Aug 2019 12:00:36 -0700
Message-Id: <1565290836-18204-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(189003)(199004)(305945005)(36386004)(316002)(4326008)(106002)(70586007)(16586007)(63266004)(107886003)(54906003)(70206006)(8936002)(50226002)(47776003)(81156014)(48376002)(8676002)(36756003)(81166006)(356004)(9786002)(50466002)(5660300002)(2906002)(6636002)(6666004)(7696005)(336012)(51416003)(2616005)(476003)(426003)(26005)(186003)(14444005)(486006)(44832011)(478600001)(126002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4832;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f567b420-3067-4415-8f8c-08d71c32c599
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:SN6PR02MB4832;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4832:
X-Microsoft-Antispam-PRVS: <SN6PR02MB48329BF0F3F9D1B1F06EEFC9B8D70@SN6PR02MB4832.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 012349AD1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: JMa9VvUkPAmEw4BkzZlXqS7WVFk9Y0S2tiTJHH6PHFZ3E3iFfpd6etJ87tvVxLPQs9RqZI0+W/P1mOjxOmBNsmkziUT+LXEUiY0Ur5LOSjFdeFY8AQnFAonV2AgkbrTr1kDth3i/mztxJd6XsE329m7WFw4q7JwJKgAEWPha4/2zWKh31qcUxxiZz/KFiSdtJcY+Wn4/C10BhIi1lUfitBo7kr9043h2ggoqxhR1H+EwL7MjW7M3Cj7X1zi/7MOD0Fhe5ESAIUQUa689gIgAq3lTGjWKafiG/VSfGtPg8SsbTdFadNMlQXcsg+Vk9PnjcoqLrN5QQ9WdKfqoE8v8zHT0EXWTsPiUu35K36pmaF7IGidiMbdA7HdyNVpXWqOYYdrfiJ7RartgcrTo7Fm6n+ItggXOd8ikmi+1qo9yyOQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2019 19:01:07.9247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f567b420-3067-4415-8f8c-08d71c32c599
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

For "0" requirement which is used to inform firmware that
device is not required currently by master, Versal LibPM disables
clock, power it down and reset the device. genpd_power_off()
is being called during runtime suspend also. So, if any device
goes to runtime suspend state during resumes it needs to be
re-initialized again. It is possible that drivers do not
reinitialize device upon resume from runtime suspend every time.

In LibPM new PM_CAP_UNUSABLE capability is added, which disables
clock only and avoids power down and reset.
So, set CAPABILITY_UNUSABLE requirement during zynqmp_gpd_power_off()
if platform is other than zynqmp.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/soc/xilinx/zynqmp_pm_domains.c | 10 ++++++++--
 include/linux/firmware/xlnx-zynqmp.h   |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
index 600f57c..23d90cb 100644
--- a/drivers/soc/xilinx/zynqmp_pm_domains.c
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -2,7 +2,7 @@
 /*
  * ZynqMP Generic PM domain support
  *
- *  Copyright (C) 2015-2018 Xilinx, Inc.
+ *  Copyright (C) 2015-2019 Xilinx, Inc.
  *
  *  Davorin Mista <davorin.mista@aggios.com>
  *  Jolly Shah <jollys@xilinx.com>
@@ -25,6 +25,8 @@
 
 static const struct zynqmp_eemi_ops *eemi_ops;
 
+static int min_capability;
+
 /**
  * struct zynqmp_pm_domain - Wrapper around struct generic_pm_domain
  * @gpd:		Generic power domain
@@ -106,7 +108,7 @@ static int zynqmp_gpd_power_off(struct generic_pm_domain *domain)
 	int ret;
 	struct pm_domain_data *pdd, *tmp;
 	struct zynqmp_pm_domain *pd;
-	u32 capabilities = 0;
+	u32 capabilities = min_capability;
 	bool may_wakeup;
 
 	if (!eemi_ops->set_requirement)
@@ -283,6 +285,10 @@ static int zynqmp_gpd_probe(struct platform_device *pdev)
 	if (!domains)
 		return -ENOMEM;
 
+	if (!of_device_is_compatible(dev->parent->of_node,
+				     "xlnx,zynqmp-firmware"))
+		min_capability = ZYNQMP_PM_CAPABILITY_UNUSABLE;
+
 	for (i = 0; i < ZYNQMP_NUM_DOMAINS; i++, pd++) {
 		pd->node_id = 0;
 		pd->gpd.name = kasprintf(GFP_KERNEL, "domain%d", i);
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 778abbb..b8a7c22 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -2,7 +2,7 @@
 /*
  * Xilinx Zynq MPSoC Firmware layer
  *
- *  Copyright (C) 2014-2018 Xilinx
+ *  Copyright (C) 2014-2019 Xilinx
  *
  *  Michal Simek <michal.simek@xilinx.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -46,6 +46,7 @@
 #define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
 #define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
 #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
+#define ZYNQMP_PM_CAPABILITY_UNUSABLE	0x8U
 
 /*
  * Firmware FPGA Manager flags
-- 
2.7.4

