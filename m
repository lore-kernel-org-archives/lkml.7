Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3B6C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8D420872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558171616;
	bh=AyreAJqLNWN25nttKdZ2BtIT3AaXdC38Q+ce2o+E0yQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CdGd4c/ktruYbQQA4Kzot5k/T8ngR4hf2+c8GpTrxkvJbl9SmYSLg97cqNdUHF2W5
	 Lg89iwRDXQsKnY3BPbTR8L9rwCw1GwdVwMMWM4YoT5dzezFU0GXMHa2NrESis/WYMN
	 zJWcAnXyn8L0Fhkj3ISygLIxci3QcNTvxTBRt4Aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfERJ0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:26:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53088 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:26:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so8969446wmm.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 02:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3f5PhMRUhA2xTNb+16UXf6zoeX+ooqc3zGa3dZzi/4g=;
        b=nhUGaypQQmTVRe2qyddwBfk4hMRWeQA84HATmjXM2xDcxy+P2nryW7tpLkR4BGzmNF
         WDIdJBO501yxTXq7r84WS7UwAdA1InyH52eEJorivKv7bnXc7/BA61qrceit41fmJUXG
         5G7BseqUhsBZZ5mrrIoEAWcStUGimlTsuM5UIMA/PcChN+GhIO8y3sRCCulVwijRDsSi
         B79om9B6RRZ7S6Me7Dq7lWiR0eWjBt4um6a2DO9H5uL+jEEme7n0bdX+RKquBJj3K6tp
         JUtyXi6lujOOfbeIemWxnUcgPhFKzlZH5HbonD7mvTfczzqpPQpyXxFL6hahB/FNrHoL
         BW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=3f5PhMRUhA2xTNb+16UXf6zoeX+ooqc3zGa3dZzi/4g=;
        b=PjX96KOgdRtdMbQ9lhB6Uv56ch4kUm8oLrQN6w5UZ/UmKkiGL5deShOZt78j0BbFnx
         tvXO03QR6VeL/JGE5r1J7w+/v773j9JEBsn5irjykfJkXNy1vi29r50bAaWY9jGpA5jm
         ay6T0Tr6BvxsC47rMAp0HW3CwFbETfP4Lr1OedB8m8AScRUeiYKV1gjlHZhNTGl3xeh8
         jho0s5+AA+onJp/56asoBBluCmeA7RBblfmkEdixNAM9Cx4FUihYDQy6wK+P36M0ybQf
         KztFULf0Rg+S5Ak6mexaTBTiEnW/sTJQBfVPUeSN+RLInleH7tBakEWtvFUo7PXzWEGh
         T9iA==
X-Gm-Message-State: APjAAAWIWw57mONbHw9QTtnoxsSHd+BOqpAfFVqvzbL0WFWD1OslaPbR
        nmroS86K3bOBujY6wuXhC3cdDAKC
X-Google-Smtp-Source: APXvYqzAoESs1JqgGhYeIa1qaWT/dQJjJuSujuV0NsmiTi5jPVewJe/QltG82LGPPmc76f77EfzGSQ==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr5442944wml.29.1558171609068;
        Sat, 18 May 2019 02:26:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m13sm9792735wrs.87.2019.05.18.02.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 02:26:48 -0700 (PDT)
Date:   Sat, 18 May 2019 11:26:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC GIT PULL] Clocksource/clockevents driver updates for v5.2
Message-ID: <20190518092646.GA24066@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

   # HEAD: ea7a5f90f103591f1f38dede52e731ec95ef3c55 Merge tag 'timers-v5.2' of http://git.linaro.org/people/daniel.lezcano/linux into timers/core

Misc clocksource/clockevent driver updates that came in a bit late but 
are ready for v5.2.

Marked it RFC due to the late date.

 Thanks,

	Ingo

------------------>
Alexandre Belloni (8):
      ARM: at91: move SoC specific definitions to SoC folder
      clocksource/drivers/tcb_clksrc: Stop depending on atmel_tclib
      clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
      ARM: at91: Implement clocksource selection
      clocksource/drivers/tcb_clksrc: Move Kconfig option
      clocksource/drivers/timer-atmel-pit: Rework Kconfig option
      clocksource/drivers/tcb_clksrc: Rename the file for consistency
      misc: atmel_tclib: Do not probe already used TCBs

David Abdurachmanov (1):
      clocksource/drivers/sp804: Add COMPILE_TEST to CONFIG_ARM_TIMER_SP804

Joseph Lo (1):
      clocksource/drivers/tegra: Rework for compensation of suspend time

Mesih Kilinc (2):
      dt-bindings: timer: Add Allwinner suniv timer
      clocksource/drivers/sun4i: Add a compatible for suniv

Sugaya Taichi (3):
      clocksource/drivers/timer-milbeaut: Fix to enable one-shot timer
      clocksource/drivers/timer-milbeaut: Add shutdown function
      clocksource/drivers/timer-milbeaut: Cleanup common register accesses

kbuild test robot (1):
      clocksource/drivers/timer-atmel-tcb: Convert tc_clksrc_suspend|resume() to static


 .../bindings/timer/allwinner,sun4i-timer.txt       |   4 +-
 arch/arm/mach-at91/Kconfig                         |  23 ++++
 drivers/clocksource/Kconfig                        |  14 ++-
 drivers/clocksource/Makefile                       |   2 +-
 .../{tcb_clksrc.c => timer-atmel-tcb.c}            | 130 ++++++++++++++-------
 drivers/clocksource/timer-milbeaut.c               |  66 ++++++++---
 drivers/clocksource/timer-sun4i.c                  |   5 +-
 drivers/clocksource/timer-tegra20.c                |  63 ++++------
 drivers/misc/Kconfig                               |  24 ----
 drivers/misc/atmel_tclib.c                         |   5 +-
 drivers/pwm/pwm-atmel-tcb.c                        |   2 +-
 include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} |   4 +-
 12 files changed, 204 insertions(+), 138 deletions(-)
 rename drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} (79%)
 rename include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} (99%)

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
index 5c2e23574ca0..3da9d515c03a 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
@@ -2,7 +2,9 @@ Allwinner A1X SoCs Timer Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun4i-a10-timer"
+- compatible : should be one of the following:
+              "allwinner,sun4i-a10-timer"
+              "allwinner,suniv-f1c100s-timer"
 - reg : Specifies base physical address and size of the registers.
 - interrupts : The interrupt of the first timer
 - clocks: phandle to the source clock (usually a 24 MHz fixed clock)
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 903f23c309df..da1d97a06c53 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -107,6 +107,29 @@ config SOC_AT91SAM9
 	    AT91SAM9X35
 	    AT91SAM9XE
 
+comment "Clocksource driver selection"
+
+config ATMEL_CLOCKSOURCE_PIT
+	bool "Periodic Interval Timer (PIT) support"
+	depends on SOC_AT91SAM9 || SOC_SAMA5
+	default SOC_AT91SAM9 || SOC_SAMA5
+	select ATMEL_PIT
+	help
+	  Select this to get a clocksource based on the Atmel Periodic Interval
+	  Timer. It has a relatively low resolution and the TC Block clocksource
+	  should be preferred.
+
+config ATMEL_CLOCKSOURCE_TCB
+	bool "Timer Counter Blocks (TCB) support"
+	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
+	select ATMEL_TCB_CLKSRC
+	help
+	  Select this to get a high precision clocksource based on a
+	  TC block with a 5+ MHz base clock rate.
+	  On platforms with 16-bit counters, two timer channels are combined
+	  to make a single 32-bit timer.
+	  It can also be used as a clock event device supporting oneshot mode.
+
 config HAVE_AT91_UTMI
 	bool
 
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 171502a356aa..2137f672a12f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -379,7 +379,7 @@ config ARM_GLOBAL_TIMER
 	  This options enables support for the ARM global timer unit
 
 config ARM_TIMER_SP804
-	bool "Support for Dual Timer SP804 module"
+	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select TIMER_OF if OF
@@ -399,8 +399,11 @@ config ARMV7M_SYSTICK
 	  This options enables support for the ARMv7M system timer unit
 
 config ATMEL_PIT
+	bool "Atmel PIT support" if COMPILE_TEST
+	depends on HAS_IOMEM
 	select TIMER_OF if OF
-	def_bool SOC_AT91SAM9 || SOC_SAMA5
+	help
+	  Support for the Periodic Interval Timer found on Atmel SoCs.
 
 config ATMEL_ST
 	bool "Atmel ST timer support" if COMPILE_TEST
@@ -410,6 +413,13 @@ config ATMEL_ST
 	help
 	  Support for the Atmel ST timer.
 
+config ATMEL_TCB_CLKSRC
+	bool "Atmel TC Block timer driver" if COMPILE_TEST
+	depends on HAS_IOMEM
+	select TIMER_OF if OF
+	help
+	  Support for Timer Counter Blocks on Atmel SoCs.
+
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index be6e0fbc7489..923b9b60c909 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_TIMER_OF)		+= timer-of.o
 obj-$(CONFIG_TIMER_PROBE)	+= timer-probe.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
 obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
-obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
+obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= timer-atmel-tcb.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= timer-cs5535.o
diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/timer-atmel-tcb.c
similarity index 79%
rename from drivers/clocksource/tcb_clksrc.c
rename to drivers/clocksource/timer-atmel-tcb.c
index 43f4d5c4d6fa..6ed31f9def7e 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -9,9 +9,11 @@
 #include <linux/err.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
-#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
 #include <linux/syscore_ops.h>
-#include <linux/atmel_tc.h>
+#include <soc/at91/atmel_tcb.h>
 
 
 /*
@@ -28,13 +30,6 @@
  *     source, used in either periodic or oneshot mode.  This runs
  *     at 32 KiHZ, and can handle delays of up to two seconds.
  *
- * A boot clocksource and clockevent source are also currently needed,
- * unless the relevant platforms (ARM/AT91, AVR32/AT32) are changed so
- * this code can be used when init_timers() is called, well before most
- * devices are set up.  (Some low end AT91 parts, which can run uClinux,
- * have only the timers in one TC block... they currently don't support
- * the tclib code, because of that initialization issue.)
- *
  * REVISIT behavior during system suspend states... we should disable
  * all clocks and save the power.  Easily done for clockevent devices,
  * but clocksources won't necessarily get the needed notifications.
@@ -71,7 +66,7 @@ static u64 tc_get_cycles32(struct clocksource *cs)
 	return readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
-void tc_clksrc_suspend(struct clocksource *cs)
+static void tc_clksrc_suspend(struct clocksource *cs)
 {
 	int i;
 
@@ -86,7 +81,7 @@ void tc_clksrc_suspend(struct clocksource *cs)
 	bmr_cache = readl(tcaddr + ATMEL_TC_BMR);
 }
 
-void tc_clksrc_resume(struct clocksource *cs)
+static void tc_clksrc_resume(struct clocksource *cs)
 {
 	int i;
 
@@ -112,7 +107,6 @@ void tc_clksrc_resume(struct clocksource *cs)
 }
 
 static struct clocksource clksrc = {
-	.name           = "tcb_clksrc",
 	.rating         = 200,
 	.read           = tc_get_cycles,
 	.mask           = CLOCKSOURCE_MASK(32),
@@ -121,6 +115,16 @@ static struct clocksource clksrc = {
 	.resume		= tc_clksrc_resume,
 };
 
+static u64 notrace tc_sched_clock_read(void)
+{
+	return tc_get_cycles(&clksrc);
+}
+
+static u64 notrace tc_sched_clock_read32(void)
+{
+	return tc_get_cycles32(&clksrc);
+}
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 struct tc_clkevt_device {
@@ -214,7 +218,6 @@ static int tc_next_event(unsigned long delta, struct clock_event_device *d)
 
 static struct tc_clkevt_device clkevt = {
 	.clkevt	= {
-		.name			= "tc_clkevt",
 		.features		= CLOCK_EVT_FEAT_PERIODIC |
 					  CLOCK_EVT_FEAT_ONESHOT,
 		/* Should be lower than at91rm9200's system timer */
@@ -330,39 +333,74 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
 	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
-static int __init tcb_clksrc_init(void)
-{
-	static char bootinfo[] __initdata
-		= KERN_DEBUG "%s: tc%d at %d.%03d MHz\n";
+static const u8 atmel_tcb_divisors[5] = { 2, 8, 32, 128, 0, };
+
+static const struct of_device_id atmel_tcb_of_match[] = {
+	{ .compatible = "atmel,at91rm9200-tcb", .data = (void *)16, },
+	{ .compatible = "atmel,at91sam9x5-tcb", .data = (void *)32, },
+	{ /* sentinel */ }
+};
 
-	struct platform_device *pdev;
-	struct atmel_tc *tc;
+static int __init tcb_clksrc_init(struct device_node *node)
+{
+	struct atmel_tc tc;
 	struct clk *t0_clk;
+	const struct of_device_id *match;
+	u64 (*tc_sched_clock)(void);
 	u32 rate, divided_rate = 0;
 	int best_divisor_idx = -1;
 	int clk32k_divisor_idx = -1;
+	int bits;
 	int i;
 	int ret;
 
-	tc = atmel_tc_alloc(CONFIG_ATMEL_TCB_CLKSRC_BLOCK);
-	if (!tc) {
-		pr_debug("can't alloc TC for clocksource\n");
-		return -ENODEV;
+	/* Protect against multiple calls */
+	if (tcaddr)
+		return 0;
+
+	tc.regs = of_iomap(node->parent, 0);
+	if (!tc.regs)
+		return -ENXIO;
+
+	t0_clk = of_clk_get_by_name(node->parent, "t0_clk");
+	if (IS_ERR(t0_clk))
+		return PTR_ERR(t0_clk);
+
+	tc.slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
+	if (IS_ERR(tc.slow_clk))
+		return PTR_ERR(tc.slow_clk);
+
+	tc.clk[0] = t0_clk;
+	tc.clk[1] = of_clk_get_by_name(node->parent, "t1_clk");
+	if (IS_ERR(tc.clk[1]))
+		tc.clk[1] = t0_clk;
+	tc.clk[2] = of_clk_get_by_name(node->parent, "t2_clk");
+	if (IS_ERR(tc.clk[2]))
+		tc.clk[2] = t0_clk;
+
+	tc.irq[2] = of_irq_get(node->parent, 2);
+	if (tc.irq[2] <= 0) {
+		tc.irq[2] = of_irq_get(node->parent, 0);
+		if (tc.irq[2] <= 0)
+			return -EINVAL;
 	}
-	tcaddr = tc->regs;
-	pdev = tc->pdev;
 
-	t0_clk = tc->clk[0];
+	match = of_match_node(atmel_tcb_of_match, node->parent);
+	bits = (uintptr_t)match->data;
+
+	for (i = 0; i < ARRAY_SIZE(tc.irq); i++)
+		writel(ATMEL_TC_ALL_IRQ, tc.regs + ATMEL_TC_REG(i, IDR));
+
 	ret = clk_prepare_enable(t0_clk);
 	if (ret) {
 		pr_debug("can't enable T0 clk\n");
-		goto err_free_tc;
+		return ret;
 	}
 
 	/* How fast will we be counting?  Pick something over 5 MHz.  */
 	rate = (u32) clk_get_rate(t0_clk);
-	for (i = 0; i < 5; i++) {
-		unsigned divisor = atmel_tc_divisors[i];
+	for (i = 0; i < ARRAY_SIZE(atmel_tcb_divisors); i++) {
+		unsigned divisor = atmel_tcb_divisors[i];
 		unsigned tmp;
 
 		/* remember 32 KiHz clock for later */
@@ -381,27 +419,31 @@ static int __init tcb_clksrc_init(void)
 		best_divisor_idx = i;
 	}
 
-
-	printk(bootinfo, clksrc.name, CONFIG_ATMEL_TCB_CLKSRC_BLOCK,
-			divided_rate / 1000000,
+	clksrc.name = kbasename(node->parent->full_name);
+	clkevt.clkevt.name = kbasename(node->parent->full_name);
+	pr_debug("%s at %d.%03d MHz\n", clksrc.name, divided_rate / 1000000,
 			((divided_rate % 1000000) + 500) / 1000);
 
-	if (tc->tcb_config && tc->tcb_config->counter_width == 32) {
+	tcaddr = tc.regs;
+
+	if (bits == 32) {
 		/* use apropriate function to read 32 bit counter */
 		clksrc.read = tc_get_cycles32;
 		/* setup ony channel 0 */
-		tcb_setup_single_chan(tc, best_divisor_idx);
+		tcb_setup_single_chan(&tc, best_divisor_idx);
+		tc_sched_clock = tc_sched_clock_read32;
 	} else {
-		/* tclib will give us three clocks no matter what the
+		/* we have three clocks no matter what the
 		 * underlying platform supports.
 		 */
-		ret = clk_prepare_enable(tc->clk[1]);
+		ret = clk_prepare_enable(tc.clk[1]);
 		if (ret) {
 			pr_debug("can't enable T1 clk\n");
 			goto err_disable_t0;
 		}
 		/* setup both channel 0 & 1 */
-		tcb_setup_dual_chan(tc, best_divisor_idx);
+		tcb_setup_dual_chan(&tc, best_divisor_idx);
+		tc_sched_clock = tc_sched_clock_read;
 	}
 
 	/* and away we go! */
@@ -410,24 +452,26 @@ static int __init tcb_clksrc_init(void)
 		goto err_disable_t1;
 
 	/* channel 2:  periodic and oneshot timer support */
-	ret = setup_clkevents(tc, clk32k_divisor_idx);
+	ret = setup_clkevents(&tc, clk32k_divisor_idx);
 	if (ret)
 		goto err_unregister_clksrc;
 
+	sched_clock_register(tc_sched_clock, 32, divided_rate);
+
 	return 0;
 
 err_unregister_clksrc:
 	clocksource_unregister(&clksrc);
 
 err_disable_t1:
-	if (!tc->tcb_config || tc->tcb_config->counter_width != 32)
-		clk_disable_unprepare(tc->clk[1]);
+	if (bits != 32)
+		clk_disable_unprepare(tc.clk[1]);
 
 err_disable_t0:
 	clk_disable_unprepare(t0_clk);
 
-err_free_tc:
-	atmel_tc_free(tc);
+	tcaddr = NULL;
+
 	return ret;
 }
-arch_initcall(tcb_clksrc_init);
+TIMER_OF_DECLARE(atmel_tcb_clksrc, "atmel,tcb-timer", tcb_clksrc_init);
diff --git a/drivers/clocksource/timer-milbeaut.c b/drivers/clocksource/timer-milbeaut.c
index f2019a88e3ee..fa9fb4eacade 100644
--- a/drivers/clocksource/timer-milbeaut.c
+++ b/drivers/clocksource/timer-milbeaut.c
@@ -26,8 +26,8 @@
 #define MLB_TMR_TMCSR_CSL_DIV2	0
 #define MLB_TMR_DIV_CNT		2
 
-#define MLB_TMR_SRC_CH  (1)
-#define MLB_TMR_EVT_CH  (0)
+#define MLB_TMR_SRC_CH		1
+#define MLB_TMR_EVT_CH		0
 
 #define MLB_TMR_SRC_CH_OFS	(MLB_TMR_REGSZPCH * MLB_TMR_SRC_CH)
 #define MLB_TMR_EVT_CH_OFS	(MLB_TMR_REGSZPCH * MLB_TMR_EVT_CH)
@@ -43,6 +43,8 @@
 #define MLB_TMR_EVT_TMRLR2_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMRLR2_OFS)
 
 #define MLB_TIMER_RATING	500
+#define MLB_TIMER_ONESHOT	0
+#define MLB_TIMER_PERIODIC	1
 
 static irqreturn_t mlb_timer_interrupt(int irq, void *dev_id)
 {
@@ -59,27 +61,53 @@ static irqreturn_t mlb_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int mlb_set_state_periodic(struct clock_event_device *clk)
+static void mlb_evt_timer_start(struct timer_of *to, bool periodic)
 {
-	struct timer_of *to = to_timer_of(clk);
 	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
 
+	val |= MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
+	if (periodic)
+		val |= MLB_TMR_TMCSR_RELD;
 	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+}
 
-	writel_relaxed(to->of_clk.period, timer_of_base(to) +
-				MLB_TMR_EVT_TMRLR1_OFS);
-	val |= MLB_TMR_TMCSR_RELD | MLB_TMR_TMCSR_CNTE |
-		MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
+static void mlb_evt_timer_stop(struct timer_of *to)
+{
+	u32 val = readl_relaxed(timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+
+	val &= ~MLB_TMR_TMCSR_CNTE;
 	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+}
+
+static void mlb_evt_timer_register_count(struct timer_of *to, unsigned long cnt)
+{
+	writel_relaxed(cnt, timer_of_base(to) + MLB_TMR_EVT_TMRLR1_OFS);
+}
+
+static int mlb_set_state_periodic(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+
+	mlb_evt_timer_stop(to);
+	mlb_evt_timer_register_count(to, to->of_clk.period);
+	mlb_evt_timer_start(to, MLB_TIMER_PERIODIC);
 	return 0;
 }
 
 static int mlb_set_state_oneshot(struct clock_event_device *clk)
 {
 	struct timer_of *to = to_timer_of(clk);
-	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
 
-	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	mlb_evt_timer_stop(to);
+	mlb_evt_timer_start(to, MLB_TIMER_ONESHOT);
+	return 0;
+}
+
+static int mlb_set_state_shutdown(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+
+	mlb_evt_timer_stop(to);
 	return 0;
 }
 
@@ -88,22 +116,21 @@ static int mlb_clkevt_next_event(unsigned long event,
 {
 	struct timer_of *to = to_timer_of(clk);
 
-	writel_relaxed(event, timer_of_base(to) + MLB_TMR_EVT_TMRLR1_OFS);
-	writel_relaxed(MLB_TMR_TMCSR_CSL_DIV2 |
-			MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_INTE |
-			MLB_TMR_TMCSR_TRG, timer_of_base(to) +
-			MLB_TMR_EVT_TMCSR_OFS);
+	mlb_evt_timer_stop(to);
+	mlb_evt_timer_register_count(to, event);
+	mlb_evt_timer_start(to, MLB_TIMER_ONESHOT);
 	return 0;
 }
 
 static int mlb_config_clock_source(struct timer_of *to)
 {
-	writel_relaxed(0, timer_of_base(to) + MLB_TMR_SRC_TMCSR_OFS);
-	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMR_OFS);
+	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
+
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_SRC_TMCSR_OFS);
 	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMRLR1_OFS);
 	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMRLR2_OFS);
-	writel_relaxed(BIT(4) | BIT(1) | BIT(0), timer_of_base(to) +
-		MLB_TMR_SRC_TMCSR_OFS);
+	val |= MLB_TMR_TMCSR_RELD | MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_TRG;
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_SRC_TMCSR_OFS);
 	return 0;
 }
 
@@ -123,6 +150,7 @@ static struct timer_of to = {
 		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT,
 		.set_state_oneshot = mlb_set_state_oneshot,
 		.set_state_periodic = mlb_set_state_periodic,
+		.set_state_shutdown = mlb_set_state_shutdown,
 		.set_next_event = mlb_clkevt_next_event,
 	},
 
diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index 6e0180aaf784..65f38f6ca714 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -186,7 +186,8 @@ static int __init sun4i_timer_init(struct device_node *node)
 	 */
 	if (of_machine_is_compatible("allwinner,sun4i-a10") ||
 	    of_machine_is_compatible("allwinner,sun5i-a13") ||
-	    of_machine_is_compatible("allwinner,sun5i-a10s"))
+	    of_machine_is_compatible("allwinner,sun5i-a10s") ||
+	    of_machine_is_compatible("allwinner,suniv-f1c100s"))
 		sched_clock_register(sun4i_timer_sched_read, 32,
 				     timer_of_rate(&to));
 
@@ -218,3 +219,5 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
+TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
+		       sun4i_timer_init);
diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index fdb3d795a409..919b3568c495 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -60,9 +60,6 @@
 static u32 usec_config;
 static void __iomem *timer_reg_base;
 #ifdef CONFIG_ARM
-static void __iomem *rtc_base;
-static struct timespec64 persistent_ts;
-static u64 persistent_ms, last_persistent_ms;
 static struct delay_timer tegra_delay_timer;
 #endif
 
@@ -199,40 +196,30 @@ static unsigned long tegra_delay_timer_read_counter_long(void)
 	return readl(timer_reg_base + TIMERUS_CNTR_1US);
 }
 
+static struct timer_of suspend_rtc_to = {
+	.flags = TIMER_OF_BASE | TIMER_OF_CLOCK,
+};
+
 /*
  * tegra_rtc_read - Reads the Tegra RTC registers
  * Care must be taken that this funciton is not called while the
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
-static u64 tegra_rtc_read_ms(void)
+static u64 tegra_rtc_read_ms(struct clocksource *cs)
 {
-	u32 ms = readl(rtc_base + RTC_MILLISECONDS);
-	u32 s = readl(rtc_base + RTC_SHADOW_SECONDS);
+	u32 ms = readl(timer_of_base(&suspend_rtc_to) + RTC_MILLISECONDS);
+	u32 s = readl(timer_of_base(&suspend_rtc_to) + RTC_SHADOW_SECONDS);
 	return (u64)s * MSEC_PER_SEC + ms;
 }
 
-/*
- * tegra_read_persistent_clock64 -  Return time from a persistent clock.
- *
- * Reads the time from a source which isn't disabled during PM, the
- * 32k sync timer.  Convert the cycles elapsed since last read into
- * nsecs and adds to a monotonically increasing timespec64.
- * Care must be taken that this funciton is not called while the
- * tegra_rtc driver could be executing to avoid race conditions
- * on the RTC shadow register
- */
-static void tegra_read_persistent_clock64(struct timespec64 *ts)
-{
-	u64 delta;
-
-	last_persistent_ms = persistent_ms;
-	persistent_ms = tegra_rtc_read_ms();
-	delta = persistent_ms - last_persistent_ms;
-
-	timespec64_add_ns(&persistent_ts, delta * NSEC_PER_MSEC);
-	*ts = persistent_ts;
-}
+static struct clocksource suspend_rtc_clocksource = {
+	.name	= "tegra_suspend_timer",
+	.rating	= 200,
+	.read	= tegra_rtc_read_ms,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
+};
 #endif
 
 static int tegra_timer_common_init(struct device_node *np, struct timer_of *to)
@@ -385,25 +372,15 @@ static int __init tegra_init_timer(struct device_node *np)
 
 static int __init tegra20_init_rtc(struct device_node *np)
 {
-	struct clk *clk;
+	int ret;
 
-	rtc_base = of_iomap(np, 0);
-	if (!rtc_base) {
-		pr_err("Can't map RTC registers\n");
-		return -ENXIO;
-	}
+	ret = timer_of_init(np, &suspend_rtc_to);
+	if (ret)
+		return ret;
 
-	/*
-	 * rtc registers are used by read_persistent_clock, keep the rtc clock
-	 * enabled
-	 */
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk))
-		pr_warn("Unable to get rtc-tegra clock\n");
-	else
-		clk_prepare_enable(clk);
+	clocksource_register_hz(&suspend_rtc_clocksource, 1000);
 
-	return register_persistent_clock(tegra_read_persistent_clock64);
+	return 0;
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
 #endif
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 42ab8ec92a04..c84033909395 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -59,30 +59,6 @@ config ATMEL_TCLIB
 	  blocks found on many Atmel processors.  This facilitates using
 	  these blocks by different drivers despite processor differences.
 
-config ATMEL_TCB_CLKSRC
-	bool "TC Block Clocksource"
-	depends on ATMEL_TCLIB
-	default y
-	help
-	  Select this to get a high precision clocksource based on a
-	  TC block with a 5+ MHz base clock rate.  Two timer channels
-	  are combined to make a single 32-bit timer.
-
-	  When GENERIC_CLOCKEVENTS is defined, the third timer channel
-	  may be used as a clock event device supporting oneshot mode
-	  (delays of up to two seconds) based on the 32 KiHz clock.
-
-config ATMEL_TCB_CLKSRC_BLOCK
-	int
-	depends on ATMEL_TCB_CLKSRC
-	default 0
-	range 0 1
-	help
-	  Some chips provide more than one TC block, so you have the
-	  choice of which one to use for the clock framework.  The other
-	  TC can be used for other purposes, such as PWM generation and
-	  interval timing.
-
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	default n
diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index ac24a4bd63f7..2c6850ef0e9c 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -1,4 +1,3 @@
-#include <linux/atmel_tc.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -10,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/of.h>
+#include <soc/at91/atmel_tcb.h>
 
 /*
  * This is a thin library to solve the problem of how to portably allocate
@@ -111,6 +111,9 @@ static int __init tc_probe(struct platform_device *pdev)
 	struct resource	*r;
 	unsigned int	i;
 
+	if (of_get_child_count(pdev->dev.of_node))
+		return -EBUSY;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return -EINVAL;
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 0d0f8376bc35..7da1fdb4d269 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -17,10 +17,10 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
-#include <linux/atmel_tc.h>
 #include <linux/pwm.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
+#include <soc/at91/atmel_tcb.h>
 
 #define NPWM	6
 
diff --git a/include/linux/atmel_tc.h b/include/soc/at91/atmel_tcb.h
similarity index 99%
rename from include/linux/atmel_tc.h
rename to include/soc/at91/atmel_tcb.h
index 468fdfa643f0..c3c7200ce151 100644
--- a/include/linux/atmel_tc.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -7,8 +7,8 @@
  * (at your option) any later version.
  */
 
-#ifndef ATMEL_TC_H
-#define ATMEL_TC_H
+#ifndef __SOC_ATMEL_TCB_H
+#define __SOC_ATMEL_TCB_H
 
 #include <linux/compiler.h>
 #include <linux/list.h>
