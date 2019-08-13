Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2536C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC48E20578
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfHMNaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:30:55 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37887 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfHMNaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:30:55 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5B75740007;
        Tue, 13 Aug 2019 13:30:52 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2] clocksource/drivers/tcb_clksrc: register delay timer
Date:   Tue, 13 Aug 2019 15:30:50 +0200
Message-Id: <20190813133050.20482-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement and register delay timer to allow get_cycles() to work properly.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

Change in v2:
 - depend on ARM to prevent build issue

 drivers/clocksource/Kconfig           |  2 +-
 drivers/clocksource/timer-atmel-tcb.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5e9317dc3d39..a642c23b2fba 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -429,7 +429,7 @@ config ATMEL_ST
 
 config ATMEL_TCB_CLKSRC
 	bool "Atmel TC Block timer driver" if COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on ARM && HAS_IOMEM
 	select TIMER_OF if OF
 	help
 	  Support for Timer Counter Blocks on Atmel SoCs.
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 6ed31f9def7e..7427b07495a8 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -6,6 +6,7 @@
 #include <linux/irq.h>
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
@@ -125,6 +126,18 @@ static u64 notrace tc_sched_clock_read32(void)
 	return tc_get_cycles32(&clksrc);
 }
 
+static struct delay_timer tc_delay_timer;
+
+static unsigned long tc_delay_timer_read(void)
+{
+	return tc_get_cycles(&clksrc);
+}
+
+static unsigned long notrace tc_delay_timer_read32(void)
+{
+	return tc_get_cycles32(&clksrc);
+}
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 struct tc_clkevt_device {
@@ -432,6 +445,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		/* setup ony channel 0 */
 		tcb_setup_single_chan(&tc, best_divisor_idx);
 		tc_sched_clock = tc_sched_clock_read32;
+		tc_delay_timer.read_current_timer = tc_delay_timer_read32;
 	} else {
 		/* we have three clocks no matter what the
 		 * underlying platform supports.
@@ -444,6 +458,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		/* setup both channel 0 & 1 */
 		tcb_setup_dual_chan(&tc, best_divisor_idx);
 		tc_sched_clock = tc_sched_clock_read;
+		tc_delay_timer.read_current_timer = tc_delay_timer_read;
 	}
 
 	/* and away we go! */
@@ -458,6 +473,9 @@ static int __init tcb_clksrc_init(struct device_node *node)
 
 	sched_clock_register(tc_sched_clock, 32, divided_rate);
 
+	tc_delay_timer.freq = divided_rate;
+	register_current_timer_delay(&tc_delay_timer);
+
 	return 0;
 
 err_unregister_clksrc:
-- 
2.21.0

