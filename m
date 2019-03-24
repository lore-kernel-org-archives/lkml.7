Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E43C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C785A222EB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfCXOOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:14:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43630 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfCXOOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 10:14:06 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h83sy-0001zI-6I; Sun, 24 Mar 2019 15:14:04 +0100
Date:   Sun, 24 Mar 2019 14:12:21 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers updates for 5.1
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
Message-ID: <155343674152.28403.6243688206829902894.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

A set of small fixes plus the removal of stale board support code:

  - Remove the board support code from the clpx711x clocksource
    driver. This change had fallen through the cracks and I'm sending it
    now rather than dealing with people who want to improve that stale code
    for 3 month.

  - Use the proper clocksource mask on RICSV

  - Make local scope functions and variables static


Thanks,

	tglx

------------------>
Alexander Shiyan (1):
      clocksource/drivers/clps711x: Remove board support

Atish Patra (1):
      clocksource/drivers/riscv: Fix clocksource mask

Valdis Kletnieks (1):
      time/jiffies: Make refined_jiffies static

YueHaibing (4):
      clocksource/drivers/clps711x: Make clps711x_clksrc_init() static
      clocksource/drivers/tcb_clksrc: Make tc_clksrc_suspend/resume() static
      clocksource/drivers/timer-ti-dm: Make omap_dm_timer_set_load_start() static
      clocksource/drivers/mips-gic-timer: Make gic_compare_irqaction static


 drivers/clocksource/clps711x-timer.c | 44 +++++++++++-------------------------
 drivers/clocksource/mips-gic-timer.c |  2 +-
 drivers/clocksource/tcb_clksrc.c     |  4 ++--
 drivers/clocksource/timer-riscv.c    |  5 ++--
 drivers/clocksource/timer-ti-dm.c    |  4 ++--
 kernel/time/jiffies.c                |  2 +-
 6 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index a8dd80576c95..857f8c086274 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -31,16 +31,9 @@ static u64 notrace clps711x_sched_clock_read(void)
 	return ~readw(tcd);
 }
 
-static int __init _clps711x_clksrc_init(struct clk *clock, void __iomem *base)
+static void __init clps711x_clksrc_init(struct clk *clock, void __iomem *base)
 {
-	unsigned long rate;
-
-	if (!base)
-		return -ENOMEM;
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
-
-	rate = clk_get_rate(clock);
+	unsigned long rate = clk_get_rate(clock);
 
 	tcd = base;
 
@@ -48,8 +41,6 @@ static int __init _clps711x_clksrc_init(struct clk *clock, void __iomem *base)
 			      clocksource_mmio_readw_down);
 
 	sched_clock_register(clps711x_sched_clock_read, 16, rate);
-
-	return 0;
 }
 
 static irqreturn_t clps711x_timer_interrupt(int irq, void *dev_id)
@@ -67,13 +58,6 @@ static int __init _clps711x_clkevt_init(struct clk *clock, void __iomem *base,
 	struct clock_event_device *clkevt;
 	unsigned long rate;
 
-	if (!irq)
-		return -EINVAL;
-	if (!base)
-		return -ENOMEM;
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
-
 	clkevt = kzalloc(sizeof(*clkevt), GFP_KERNEL);
 	if (!clkevt)
 		return -ENOMEM;
@@ -93,31 +77,29 @@ static int __init _clps711x_clkevt_init(struct clk *clock, void __iomem *base,
 			   "clps711x-timer", clkevt);
 }
 
-void __init clps711x_clksrc_init(void __iomem *tc1_base, void __iomem *tc2_base,
-				 unsigned int irq)
-{
-	struct clk *tc1 = clk_get_sys("clps711x-timer.0", NULL);
-	struct clk *tc2 = clk_get_sys("clps711x-timer.1", NULL);
-
-	BUG_ON(_clps711x_clksrc_init(tc1, tc1_base));
-	BUG_ON(_clps711x_clkevt_init(tc2, tc2_base, irq));
-}
-
-#ifdef CONFIG_TIMER_OF
 static int __init clps711x_timer_init(struct device_node *np)
 {
 	unsigned int irq = irq_of_parse_and_map(np, 0);
 	struct clk *clock = of_clk_get(np, 0);
 	void __iomem *base = of_iomap(np, 0);
 
+	if (!base)
+		return -ENOMEM;
+	if (!irq)
+		return -EINVAL;
+	if (IS_ERR(clock))
+		return PTR_ERR(clock);
+
 	switch (of_alias_get_id(np, "timer")) {
 	case CLPS711X_CLKSRC_CLOCKSOURCE:
-		return _clps711x_clksrc_init(clock, base);
+		clps711x_clksrc_init(clock, base);
+		break;
 	case CLPS711X_CLKSRC_CLOCKEVENT:
 		return _clps711x_clkevt_init(clock, base, irq);
 	default:
 		return -EINVAL;
 	}
+
+	return 0;
 }
 TIMER_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);
-#endif
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 54f8a331b53a..37671a5d4ed9 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -67,7 +67,7 @@ static irqreturn_t gic_compare_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-struct irqaction gic_compare_irqaction = {
+static struct irqaction gic_compare_irqaction = {
 	.handler = gic_compare_interrupt,
 	.percpu_dev_id = &gic_clockevent_device,
 	.flags = IRQF_PERCPU | IRQF_TIMER,
diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 43f4d5c4d6fa..f987027ca566 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -71,7 +71,7 @@ static u64 tc_get_cycles32(struct clocksource *cs)
 	return readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
-void tc_clksrc_suspend(struct clocksource *cs)
+static void tc_clksrc_suspend(struct clocksource *cs)
 {
 	int i;
 
@@ -86,7 +86,7 @@ void tc_clksrc_suspend(struct clocksource *cs)
 	bmr_cache = readl(tcaddr + ATMEL_TC_BMR);
 }
 
-void tc_clksrc_resume(struct clocksource *cs)
+static void tc_clksrc_resume(struct clocksource *cs)
 {
 	int i;
 
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index e8163693e936..5e6038fbf115 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -58,7 +58,7 @@ static u64 riscv_sched_clock(void)
 static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
 	.name		= "riscv_clocksource",
 	.rating		= 300,
-	.mask		= CLOCKSOURCE_MASK(BITS_PER_LONG),
+	.mask		= CLOCKSOURCE_MASK(64),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.read		= riscv_clocksource_rdtime,
 };
@@ -120,8 +120,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 		return error;
 	}
 
-	sched_clock_register(riscv_sched_clock,
-			BITS_PER_LONG, riscv_timebase);
+	sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
 
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index c364027638e1..3352da6ed61f 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -586,8 +586,8 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 }
 
 /* Optimized set_load which removes costly spin wait in timer_start */
-int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
-                            unsigned int load)
+static int omap_dm_timer_set_load_start(struct omap_dm_timer *timer,
+					int autoreload, unsigned int load)
 {
 	u32 l;
 
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index dc1b6f1929f9..ac9c03dd6c7d 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -89,7 +89,7 @@ struct clocksource * __init __weak clocksource_default_clock(void)
 	return &clocksource_jiffies;
 }
 
-struct clocksource refined_jiffies;
+static struct clocksource refined_jiffies;
 
 int register_refined_jiffies(long cycles_per_second)
 {

