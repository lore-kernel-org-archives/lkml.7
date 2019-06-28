Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA44DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05FE208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfF1Dj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:39:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58604 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbfF1Dj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:39:56 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DEF1E200307;
        Fri, 28 Jun 2019 05:39:53 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E19A2200304;
        Fri, 28 Jun 2019 05:39:42 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DE51D402F6;
        Fri, 28 Jun 2019 11:39:29 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, daniel.baluta@nxp.com, ping.bai@nxp.com,
        l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, ccaione@baylibre.com, angus@akkea.ca,
        agx@sigxcpu.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 1/5] clocksource: timer-of: Support getting clock frequency from DT
Date:   Fri, 28 Jun 2019 11:30:37 +0800
Message-Id: <20190628033041.8513-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

More and more platforms use platform driver model for clock driver,
so the clock driver is NOT ready during timer initialization phase,
it will cause timer initialization failed.

To support those platforms with upper scenario, introducing a new
flag TIMER_OF_CLOCK_FREQUENCY which is mutually exclusive with
TIMER_OF_CLOCK flag to support getting timer clock frequency from
DT, then of_clk operations can be skipped.

User needs to select either TIMER_OF_CLOCK_FREQUENCY or TIMER_OF_CLOCK
flag if want to use timer-of driver to initialize the clock rate,
and the corresponding clock name or property name needs to be specified.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
New patch:
	- Add new flag of TIMER_OF_CLOCK_FREQUENCY, mutually exclusive with TIMER_OF_CLOCK, to support
	  getting clock frequency from DT directly;
	- Add prop_name to of_timer_clk structure, if using TIMER_OF_CLOCK_FREQUENCY flag, user needs
	  to pass the property name for timer-of driver to get clock frequency from DT, this is to avoid
	  the couple of timer-of driver and DT, so timer-of driver does NOT use a fixed property name.
---
 drivers/clocksource/timer-of.c | 23 +++++++++++++++++++++++
 drivers/clocksource/timer-of.h |  8 +++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 8054228..c91a8b6 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -161,6 +161,21 @@ static __init int timer_of_base_init(struct device_node *np,
 	return 0;
 }
 
+static __init int timer_of_clk_frequency_init(struct device_node *np,
+					      struct of_timer_clk *of_clk)
+{
+	int ret;
+	u32 rate;
+
+	ret = of_property_read_u32(np, of_clk->prop_name, &rate);
+	if (!ret) {
+		of_clk->rate = rate;
+		of_clk->period = DIV_ROUND_UP(rate, HZ);
+	}
+
+	return ret;
+}
+
 int __init timer_of_init(struct device_node *np, struct timer_of *to)
 {
 	int ret = -EINVAL;
@@ -178,6 +193,11 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
 		if (ret)
 			goto out_fail;
 		flags |= TIMER_OF_CLOCK;
+	} else if (to->flags & TIMER_OF_CLOCK_FREQUENCY) {
+		ret = timer_of_clk_frequency_init(np, &to->of_clk);
+		if (ret)
+			goto out_fail;
+		flags |= TIMER_OF_CLOCK_FREQUENCY;
 	}
 
 	if (to->flags & TIMER_OF_IRQ) {
@@ -201,6 +221,9 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
 	if (flags & TIMER_OF_CLOCK)
 		timer_of_clk_exit(&to->of_clk);
 
+	if (flags & TIMER_OF_CLOCK_FREQUENCY)
+		to->of_clk.rate = 0;
+
 	if (flags & TIMER_OF_BASE)
 		timer_of_base_exit(&to->of_base);
 	return ret;
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index a5478f3..f1a083e 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -4,9 +4,10 @@
 
 #include <linux/clockchips.h>
 
-#define TIMER_OF_BASE	0x1
-#define TIMER_OF_CLOCK	0x2
-#define TIMER_OF_IRQ	0x4
+#define TIMER_OF_BASE			0x1
+#define TIMER_OF_CLOCK			0x2
+#define TIMER_OF_IRQ			0x4
+#define TIMER_OF_CLOCK_FREQUENCY	0x8
 
 struct of_timer_irq {
 	int irq;
@@ -26,6 +27,7 @@ struct of_timer_base {
 struct of_timer_clk {
 	struct clk *clk;
 	const char *name;
+	const char *prop_name;
 	int index;
 	unsigned long rate;
 	unsigned long period;
-- 
2.7.4

