Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF2DC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C392178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fjseMZvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfKGKhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:37:42 -0500
Received: from mail-eopbgr800051.outbound.protection.outlook.com ([40.107.80.51]:39360
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387611AbfKGKhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:37:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYjFKNcT5qNphoXkEgRNSwfdlbXPWyq4zyCF/JY/Q4mdAJnF+F5F2Y4ALMWdwhArGcta3txmgNKtWMwzTImTdGcxFutQViufkrEGuXkYdrZ2VraKubaKSkbnWm/YvuPlGHaLWoP8t+TwoB3P1+PbNeUIxWoznK8Ml1tGEfIHOD12VJ9cOhNMVXNc9nsdrY8glUcvc+iYUQxJCqcmHJ7Gw0LnlkIuFEwRgwtf+XycDrhnU5Xnuj7oJ9wcdsIxXaEO3EcBLJlJAfEC78moLiVii15G/CRfQMqGPWRZ7ANXvnFye4UYkxAwX9B9IFwhcSFvYI/w48DGuvPpGVyVTEk8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FfM9peuImQcLNVHerNP+tLmwkHVjmfQC2uP9FIKvuk=;
 b=YVndQMB0Jz1ZTXH+X2uQjmFg61N0ev6gN2WuDbyEdesNb3OokNt1st10MHQrSPURrqnzWbGXeLBL/lquLn6PwxwHP5Ho5cqKLMpha7sr9VKVMYdcY8Ny8sbCzP6BBN1ZNDuEU6L0y06A1wCQ2ejtZHIiJOf90rqaC4zyQHnw30+qrKv5E5ldnOB89FSl++r9Nv6R6joIJwiFTxglNAibqe5+2O8aiPkgHA0QeVFIgtZYS14/t50/q78V4AYQ8Mf1M9c0/3pnqQtHbi9Uub0K1fCfeqmXVYQoVr/QkKIx2EAKLFCudotBwJG1QTqkSNz8d5tpEPHdCtRCZEBXuu/VFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FfM9peuImQcLNVHerNP+tLmwkHVjmfQC2uP9FIKvuk=;
 b=fjseMZvhxgslgVFUdD8xN0H7Tec1fI5xUakS7l9F1R3aIEhJmgw+0iL/4zn/Uof80ZeOhvfKJfJqdXGTeVGu9woi0qpRqMhZmMcM7CSmTcy96A+TIvWOCvULeSgGWNCDzsbSCzacWirlmjqnE/7DknagMuw30XPAPoIZHF4PJBk=
Received: from BN6PR02CA0040.namprd02.prod.outlook.com (2603:10b6:404:5f::26)
 by BYAPR02MB4040.namprd02.prod.outlook.com (2603:10b6:a02:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.23; Thu, 7 Nov
 2019 10:36:58 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BN6PR02CA0040.outlook.office365.com
 (2603:10b6:404:5f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Thu, 7 Nov 2019 10:36:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Thu, 7 Nov 2019 10:36:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSf9t-0004Zo-RV; Thu, 07 Nov 2019 02:36:57 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSf9o-00026Z-Hg; Thu, 07 Nov 2019 02:36:52 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xA7AahHX027859;
        Thu, 7 Nov 2019 02:36:43 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSf9e-00024W-S3; Thu, 07 Nov 2019 02:36:42 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     michal.simek@xilinx.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, JOLLYS@xilinx.com,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH] drivers: clocksource: Use ttc driver as platform driver
Date:   Thu,  7 Nov 2019 02:36:28 -0800
Message-Id: <1573122988-18399-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(51416003)(9786002)(47776003)(16586007)(7696005)(48376002)(126002)(476003)(107886003)(478600001)(70586007)(70206006)(5660300002)(316002)(50466002)(106002)(26005)(186003)(426003)(36756003)(81156014)(81166006)(8936002)(336012)(50226002)(36386004)(486006)(44832011)(305945005)(2616005)(356004)(8676002)(6666004)(2906002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4040;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e1620ee-395b-4d7c-f361-08d7636e6ab1
X-MS-TrafficTypeDiagnostic: BYAPR02MB4040:
X-Microsoft-Antispam-PRVS: <BYAPR02MB404083E7AC41B941D745E772B7780@BYAPR02MB4040.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97L3NulMGWqSa+MVucHsTXhtOOqoQcP9fgxXUCniySPO+j/zPQdbppY190Krj12FlMZcjqYasIkSEQrkzhEBC2GI1IooX+EySPn1y1xHeYhGZrO6p3Ap7eeMFGgF2XnKXh0uOGhqReOfGENHt6QdaYBD1LQWI9L6/jgcBFQTzLvpQK3qmapm7L3Li8Sn5MQzW2Nk5X7tyns8mVq3oIjhCkqaQqOBKxRHzIV0gE7kWJysCKxqCoKTpmjy3VflRZYRMpfMT8iWmNO1CHARwKljrbYga90He9afUFpmTY3UJ+wSitbzmL0jM65thIJyGNMuvBad/K6jsr3aWUow72ysRoxY88led0XqPTcbjDMVWpXzpe0l78py4N0Ym5wPDrGtp16WAY11j2EL7II6dwBQexcKZOJV3tKKPQKIDCpiW/ywUvjHHUwSolcY5eTQOe3z
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 10:36:58.2703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1620ee-395b-4d7c-f361-08d7636e6ab1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently TTC driver is TIMER_OF_DECLARE type driver. Because of
that, TTC driver may be initialized before other clock drivers. If
TTC driver is dependent on that clock driver then initialization of
TTC driver will failed.

So use TTC driver as platform driver instead of using
TIMER_OF_DECLARE.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/clocksource/timer-cadence-ttc.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 88fe2e9..38858e1 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -15,6 +15,8 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/sched_clock.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
 
 /*
  * This driver configures the 2 16/32-bit count-up timers as follows:
@@ -464,13 +466,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 	return 0;
 }
 
-/**
- * ttc_timer_init - Initialize the timer
- *
- * Initializes the timer hardware and register the clock source and clock event
- * timers with Linux kernal timer framework
- */
-static int __init ttc_timer_init(struct device_node *timer)
+static int __init ttc_timer_probe(struct platform_device *pdev)
 {
 	unsigned int irq;
 	void __iomem *timer_baseaddr;
@@ -478,6 +474,7 @@ static int __init ttc_timer_init(struct device_node *timer)
 	static int initialized;
 	int clksel, ret;
 	u32 timer_width = 16;
+	struct device_node *timer = pdev->dev.of_node;
 
 	if (initialized)
 		return 0;
@@ -532,4 +529,17 @@ static int __init ttc_timer_init(struct device_node *timer)
 	return 0;
 }
 
-TIMER_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
+static const struct of_device_id ttc_timer_of_match[] = {
+	{.compatible = "cdns,ttc"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, ttc_timer_of_match);
+
+static struct platform_driver ttc_timer_driver = {
+	.driver = {
+		.name	= "cdns_ttc_timer",
+		.of_match_table = ttc_timer_of_match,
+	},
+};
+builtin_platform_driver_probe(ttc_timer_driver, ttc_timer_probe);
-- 
2.7.4

