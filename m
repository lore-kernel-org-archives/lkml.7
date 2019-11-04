Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64CBCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BC620B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfKDRyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:54:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38034 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfKDRyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:54:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRgYR-0002ZP-5h; Mon, 04 Nov 2019 18:54:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B9F301C0017;
        Mon,  4 Nov 2019 18:54:14 +0100 (CET)
Date:   Mon, 04 Nov 2019 17:54:14 -0000
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/renesas-ostm: Convert to timer_of
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191016144747.29538-4-geert+renesas@glider.be>
References: <20191016144747.29538-4-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <157289005441.29376.13656654044336938620.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     227314239a5e87fb531cbf3bd8953b2d1d2694bd
Gitweb:        https://git.kernel.org/tip/227314239a5e87fb531cbf3bd8953b2d1d2694bd
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 16 Oct 2019 16:47:46 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 04 Nov 2019 10:38:46 +01:00

clocksource/drivers/renesas-ostm: Convert to timer_of

Convert the Renesas OSTM driver to use the timer_of framework.
This reduces the driver object size by 367 bytes (with gcc 7.4.0).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191016144747.29538-4-geert+renesas@glider.be
---
 drivers/clocksource/Kconfig        |   1 +-
 drivers/clocksource/renesas-ostm.c | 189 ++++++++++------------------
 2 files changed, 73 insertions(+), 117 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f35a53c..5fdd76c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -528,6 +528,7 @@ config SH_TIMER_MTU2
 config RENESAS_OSTM
 	bool "Renesas OSTM timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
+	select TIMER_OF
 	help
 	  Enables the support for the Renesas OSTM.
 
diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 37c39b9..46012d9 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -6,14 +6,14 @@
  * Copyright (C) 2017 Chris Brandt
  */
 
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
 
+#include "timer-of.h"
+
 /*
  * The OSTM contains independent channels.
  * The first OSTM channel probed will be set up as a free running
@@ -24,12 +24,6 @@
  * driven clock event.
  */
 
-struct ostm_device {
-	void __iomem *base;
-	unsigned long ticks_per_jiffy;
-	struct clock_event_device ced;
-};
-
 static void __iomem *system_clock;	/* For sched_clock() */
 
 /* OSTM REGISTERS */
@@ -47,41 +41,32 @@ static void __iomem *system_clock;	/* For sched_clock() */
 #define	CTL_ONESHOT		0x02
 #define	CTL_FREERUN		0x02
 
-static struct ostm_device *ced_to_ostm(struct clock_event_device *ced)
-{
-	return container_of(ced, struct ostm_device, ced);
-}
-
-static void ostm_timer_stop(struct ostm_device *ostm)
+static void ostm_timer_stop(struct timer_of *to)
 {
-	if (readb(ostm->base + OSTM_TE) & TE) {
-		writeb(TT, ostm->base + OSTM_TT);
+	if (readb(timer_of_base(to) + OSTM_TE) & TE) {
+		writeb(TT, timer_of_base(to) + OSTM_TT);
 
 		/*
 		 * Read back the register simply to confirm the write operation
 		 * has completed since I/O writes can sometimes get queued by
 		 * the bus architecture.
 		 */
-		while (readb(ostm->base + OSTM_TE) & TE)
+		while (readb(timer_of_base(to) + OSTM_TE) & TE)
 			;
 	}
 }
 
-static int __init ostm_init_clksrc(struct ostm_device *ostm, unsigned long rate)
+static int __init ostm_init_clksrc(struct timer_of *to)
 {
-	/*
-	 * irq not used (clock sources don't use interrupts)
-	 */
-
-	ostm_timer_stop(ostm);
+	ostm_timer_stop(to);
 
-	writel(0, ostm->base + OSTM_CMP);
-	writeb(CTL_FREERUN, ostm->base + OSTM_CTL);
-	writeb(TS, ostm->base + OSTM_TS);
+	writel(0, timer_of_base(to) + OSTM_CMP);
+	writeb(CTL_FREERUN, timer_of_base(to) + OSTM_CTL);
+	writeb(TS, timer_of_base(to) + OSTM_TS);
 
-	return clocksource_mmio_init(ostm->base + OSTM_CNT,
-			"ostm", rate,
-			300, 32, clocksource_mmio_readl_up);
+	return clocksource_mmio_init(timer_of_base(to) + OSTM_CNT, "ostm",
+				     timer_of_rate(to), 300, 32,
+				     clocksource_mmio_readl_up);
 }
 
 static u64 notrace ostm_read_sched_clock(void)
@@ -89,87 +74,75 @@ static u64 notrace ostm_read_sched_clock(void)
 	return readl(system_clock);
 }
 
-static void __init ostm_init_sched_clock(struct ostm_device *ostm,
-			unsigned long rate)
+static void __init ostm_init_sched_clock(struct timer_of *to)
 {
-	system_clock = ostm->base + OSTM_CNT;
-	sched_clock_register(ostm_read_sched_clock, 32, rate);
+	system_clock = timer_of_base(to) + OSTM_CNT;
+	sched_clock_register(ostm_read_sched_clock, 32, timer_of_rate(to));
 }
 
 static int ostm_clock_event_next(unsigned long delta,
-				     struct clock_event_device *ced)
+				 struct clock_event_device *ced)
 {
-	struct ostm_device *ostm = ced_to_ostm(ced);
+	struct timer_of *to = to_timer_of(ced);
 
-	ostm_timer_stop(ostm);
+	ostm_timer_stop(to);
 
-	writel(delta, ostm->base + OSTM_CMP);
-	writeb(CTL_ONESHOT, ostm->base + OSTM_CTL);
-	writeb(TS, ostm->base + OSTM_TS);
+	writel(delta, timer_of_base(to) + OSTM_CMP);
+	writeb(CTL_ONESHOT, timer_of_base(to) + OSTM_CTL);
+	writeb(TS, timer_of_base(to) + OSTM_TS);
 
 	return 0;
 }
 
 static int ostm_shutdown(struct clock_event_device *ced)
 {
-	struct ostm_device *ostm = ced_to_ostm(ced);
+	struct timer_of *to = to_timer_of(ced);
 
-	ostm_timer_stop(ostm);
+	ostm_timer_stop(to);
 
 	return 0;
 }
 static int ostm_set_periodic(struct clock_event_device *ced)
 {
-	struct ostm_device *ostm = ced_to_ostm(ced);
+	struct timer_of *to = to_timer_of(ced);
 
 	if (clockevent_state_oneshot(ced) || clockevent_state_periodic(ced))
-		ostm_timer_stop(ostm);
+		ostm_timer_stop(to);
 
-	writel(ostm->ticks_per_jiffy - 1, ostm->base + OSTM_CMP);
-	writeb(CTL_PERIODIC, ostm->base + OSTM_CTL);
-	writeb(TS, ostm->base + OSTM_TS);
+	writel(timer_of_period(to) - 1, timer_of_base(to) + OSTM_CMP);
+	writeb(CTL_PERIODIC, timer_of_base(to) + OSTM_CTL);
+	writeb(TS, timer_of_base(to) + OSTM_TS);
 
 	return 0;
 }
 
 static int ostm_set_oneshot(struct clock_event_device *ced)
 {
-	struct ostm_device *ostm = ced_to_ostm(ced);
+	struct timer_of *to = to_timer_of(ced);
 
-	ostm_timer_stop(ostm);
+	ostm_timer_stop(to);
 
 	return 0;
 }
 
 static irqreturn_t ostm_timer_interrupt(int irq, void *dev_id)
 {
-	struct ostm_device *ostm = dev_id;
+	struct clock_event_device *ced = dev_id;
 
-	if (clockevent_state_oneshot(&ostm->ced))
-		ostm_timer_stop(ostm);
+	if (clockevent_state_oneshot(ced))
+		ostm_timer_stop(to_timer_of(ced));
 
 	/* notify clockevent layer */
-	if (ostm->ced.event_handler)
-		ostm->ced.event_handler(&ostm->ced);
+	if (ced->event_handler)
+		ced->event_handler(ced);
 
 	return IRQ_HANDLED;
 }
 
-static int __init ostm_init_clkevt(struct ostm_device *ostm, int irq,
-			unsigned long rate)
+static int __init ostm_init_clkevt(struct timer_of *to)
 {
-	struct clock_event_device *ced = &ostm->ced;
-	int ret = -ENXIO;
-
-	ret = request_irq(irq, ostm_timer_interrupt,
-			  IRQF_TIMER | IRQF_IRQPOLL,
-			  "ostm", ostm);
-	if (ret) {
-		pr_err("ostm: failed to request irq\n");
-		return ret;
-	}
+	struct clock_event_device *ced = &to->clkevt;
 
-	ced->name = "ostm";
 	ced->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC;
 	ced->set_state_shutdown = ostm_shutdown;
 	ced->set_state_periodic = ostm_set_periodic;
@@ -178,79 +151,61 @@ static int __init ostm_init_clkevt(struct ostm_device *ostm, int irq,
 	ced->shift = 32;
 	ced->rating = 300;
 	ced->cpumask = cpumask_of(0);
-	clockevents_config_and_register(ced, rate, 0xf, 0xffffffff);
+	clockevents_config_and_register(ced, timer_of_rate(to), 0xf,
+					0xffffffff);
 
 	return 0;
 }
 
 static int __init ostm_init(struct device_node *np)
 {
-	struct ostm_device *ostm;
-	int ret = -EFAULT;
-	struct clk *ostm_clk = NULL;
-	int irq;
-	unsigned long rate;
-
-	ostm = kzalloc(sizeof(*ostm), GFP_KERNEL);
-	if (!ostm)
-		return -ENOMEM;
-
-	ostm->base = of_iomap(np, 0);
-	if (!ostm->base) {
-		pr_err("ostm: failed to remap I/O memory\n");
-		goto err;
-	}
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (irq < 0) {
-		pr_err("ostm: Failed to get irq\n");
-		goto err;
-	}
+	struct timer_of *to;
+	int ret;
 
-	ostm_clk = of_clk_get(np, 0);
-	if (IS_ERR(ostm_clk)) {
-		pr_err("ostm: Failed to get clock\n");
-		ostm_clk = NULL;
-		goto err;
-	}
+	to = kzalloc(sizeof(*to), GFP_KERNEL);
+	if (!to)
+		return -ENOMEM;
 
-	ret = clk_prepare_enable(ostm_clk);
-	if (ret) {
-		pr_err("ostm: Failed to enable clock\n");
-		goto err;
+	to->flags = TIMER_OF_BASE | TIMER_OF_CLOCK;
+	if (system_clock) {
+		/*
+		 * clock sources don't use interrupts, clock events do
+		 */
+		to->flags |= TIMER_OF_IRQ;
+		to->of_irq.flags = IRQF_TIMER | IRQF_IRQPOLL;
+		to->of_irq.handler = ostm_timer_interrupt;
 	}
 
-	rate = clk_get_rate(ostm_clk);
-	ostm->ticks_per_jiffy = DIV_ROUND_CLOSEST(rate, HZ);
+	ret = timer_of_init(np, to);
+	if (ret)
+		goto err_free;
 
 	/*
 	 * First probed device will be used as system clocksource. Any
 	 * additional devices will be used as clock events.
 	 */
 	if (!system_clock) {
-		ret = ostm_init_clksrc(ostm, rate);
-
-		if (!ret) {
-			ostm_init_sched_clock(ostm, rate);
-			pr_info("ostm: used for clocksource\n");
-		}
+		ret = ostm_init_clksrc(to);
+		if (ret)
+			goto err_cleanup;
 
+		ostm_init_sched_clock(to);
+		pr_info("ostm: used for clocksource\n");
 	} else {
-		ret = ostm_init_clkevt(ostm, irq, rate);
+		ret = ostm_init_clkevt(to);
+		if (ret)
+			goto err_cleanup;
 
-		if (!ret)
-			pr_info("ostm: used for clock events\n");
-	}
-
-err:
-	if (ret) {
-		clk_disable_unprepare(ostm_clk);
-		iounmap(ostm->base);
-		kfree(ostm);
-		return ret;
+		pr_info("ostm: used for clock events\n");
 	}
 
 	return 0;
+
+err_cleanup:
+	timer_of_cleanup(to);
+err_free:
+	kfree(to);
+	return ret;
 }
 
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
