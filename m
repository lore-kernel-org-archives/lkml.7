Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28AAC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7592178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mCuoLXt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfKGKcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:32:01 -0500
Received: from mail-eopbgr820089.outbound.protection.outlook.com ([40.107.82.89]:49024
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388099AbfKGKbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:31:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adzY267q7Nfhg+qyBjUO18omGQ43TAi7kyLpT6jMJelBsdNMcSBONt1BXubIOMmG7rNqBXEDh+p0dtIHpQli9v+O+xjLLy8tLSJO+MtfxVRprmUPiObX/ReUhjidognTBi8tGRnJMgS6jhjMUq456JpERgxFokr0JlfsxYAMHlnoQwifjS3//9xgM0w+/Sp1N44LR05bThZCjYWpeTBAq3jOSL8+vkr+eCYsoWJFlRlm7/8qWU4yU8Fl/5xLMs6A8Bwse55kZbYjVjEVMYbfvpasuDuqV2Q+MvPl71GGciXjYCTxbbWHhmGzk7XTKgT8QnJFiXtV3aWKQeU3HHICLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FfM9peuImQcLNVHerNP+tLmwkHVjmfQC2uP9FIKvuk=;
 b=AVbWkqwuXZwPvtAwnO5z93XI4ACunb4TVn15VlROVGkKmn3dbgRN4O/IcDLMXkw+J9lxDOjuhlwT0prL+XVR+4GhRXHl0UHkwQTY5b8LTAchqGd7qDmprJfYvSVVNpgDeum2vpZsZepED62aIu51EjCTNdISDoQFg6S5iSyKgfdwhkx4v0dbw7MKN1gHzKsBsoj8wJhyiAh2dq3ugaLEEXtLWBqqs3xDQHnKSem+yHhmx1r7MnS2XfL5F4K+1b3BBjteut00Z3ZbRy20dngqovzYBU7oy4Z/3gatIxNQiISO00vLCYbWmSHXGbsOdzVaLGZ2PP41FWWVS0kwIjvkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FfM9peuImQcLNVHerNP+tLmwkHVjmfQC2uP9FIKvuk=;
 b=mCuoLXt2/n4CQNGhTMcZZPM70nLaMIoKbmCq17b4li5y8lRnkWZtESHijEdJTqSQdrJSZXvOsoK6x1+VXtmib+dxZTmwz/x4Z4zwJw6hHZjWUFizfI4IFYYz4t2MfJOgpqCWFn+DRHJ6RTmlafcy2cYkySqZeg2r5cHWWI97wzA=
Received: from DM6PR02CA0082.namprd02.prod.outlook.com (2603:10b6:5:1f4::23)
 by MWHPR02MB2702.namprd02.prod.outlook.com (2603:10b6:300:107::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 7 Nov
 2019 10:31:48 +0000
Received: from BL2NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by DM6PR02CA0082.outlook.office365.com
 (2603:10b6:5:1f4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 10:31:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT031.mail.protection.outlook.com (10.152.77.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Thu, 7 Nov 2019 10:31:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSf4t-0004Km-1Z; Thu, 07 Nov 2019 02:31:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSf4n-0000QF-O8; Thu, 07 Nov 2019 02:31:41 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSf4e-0000PE-PQ; Thu, 07 Nov 2019 02:31:32 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     ichal.simek@xilinx.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH] drivers: clocksource: Use ttc driver as platform driver
Date:   Thu,  7 Nov 2019 02:30:59 -0800
Message-Id: <1573122659-13947-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(189003)(199004)(48376002)(70206006)(336012)(70586007)(2616005)(16586007)(316002)(426003)(186003)(50466002)(106002)(81156014)(36756003)(8676002)(81166006)(476003)(305945005)(486006)(8936002)(126002)(9786002)(44832011)(50226002)(7696005)(51416003)(5660300002)(36386004)(2906002)(356004)(4326008)(47776003)(6666004)(107886003)(478600001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2702;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3df0ae74-5ab6-415b-b136-08d7636db19d
X-MS-TrafficTypeDiagnostic: MWHPR02MB2702:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2702AB50C86B820BC0B7586AB7780@MWHPR02MB2702.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFe8L54pt0Auj3VkiveXG7Bk37YPF8stS7L7WrGWGBf+cWIX01GXrRoVY+fm1zQOM6TTZuy95M9aSz3rM4oKS/e8C0qIcPPvpQKWZWhYvX9Frz0O56mE+xGAGdYHH0KR0KPi/60NMRa+PeyEMJ8NdQ9Mgxlykz428piaEVlc2zqUl/SpG90isZva8P5HdwgAyn/wqip3hwjgp3azx/OzTzCD/UHdYu7G26Aw3X4KQycsCXW0QKRj5TStV9OC9UhXg3wQHJODA53k0lgTt+C4Azk50hs1O4ZJnH5+oUm7LZGLPDW7hvGA4BVwC5Vbq6X13fWe/oqj3PS3RoW5bKhEvftXatr7LG0oe/LeVI1sqQdMjFT4OWniDEoFuYGSR+l7onBzKU1jjPh9A5t5TL5ha3csM8Uf3bYaBE4YftYWlEPeTjwDfPEqmKwOp/UZfB9H
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 10:31:47.6969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df0ae74-5ab6-415b-b136-08d7636db19d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2702
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

