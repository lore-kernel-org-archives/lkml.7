Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4726AC34967
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882EB246EF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLMLTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 06:19:48 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:44990 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 06:19:48 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: gLILAU94dJtVQVxw2Piwv+xtaZidvzGDu3v8+JJqIGcOVc7Ie6H64PIm6kWB2BcHq4d97qtHYH
 Mi2Pk0xxCYpTtSD4RDwRkkoAGTHd16PsYPj0Uh2ndpb522R6z7Z9oYwoeF3GntYkvCLLYvwGTG
 7Ji63bsEhRT5uzCSLAQSHRDX7JWSFJz7YBAxk1yepPxtWuyWSMxKA4E/ozi8LSK+6vTbVWLFdS
 /+Xl8iw/uwMKy4fPR6ur2W6Kr6ZJzmoNARIjZ3g88weE6YZ2D0TVfP4BA8UdYjUG87EwXOPkQZ
 hXk=
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="61625824"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2019 04:19:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Dec 2019 04:19:46 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 13 Dec 2019 04:19:42 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 2/2] clocksource/drivers/timer-microchip-pit64b: add Microchip PIT64B support
Date:   Fri, 13 Dec 2019 13:19:22 +0200
Message-ID: <1576235962-30123-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576235962-30123-1-git-send-email-claudiu.beznea@microchip.com>
References: <1576235962-30123-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for Microchip PIT64B timer. Timer could be used in continuous
mode or oneshot mode. The hardware has 2x32 bit registers for period
emulating a 64 bit timer. The LSB_PR and MSB_PR registers are used to
set the period value (compare value). TLSB and TMSB keeps the current
value of the counter. After a compare the TLSB and TMSB register resets.
The driver uses PIT64B timer for clocksource or clockevent. First
requested timer would be registered as clockevent, second one would be
registered as clocksource. Individual PIT64B hardware resources were
used for clocksource and clockevent to be able to support high resolution
timers with this hardware implementation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/Kconfig                  |   7 +
 drivers/clocksource/Makefile                 |   1 +
 drivers/clocksource/timer-microchip-pit64b.c | 449 +++++++++++++++++++++++++++
 3 files changed, 457 insertions(+)
 create mode 100644 drivers/clocksource/timer-microchip-pit64b.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5fdd76cb1768..6c3907b54c65 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -697,4 +697,11 @@ config INGENIC_TIMER
 	help
 	  Support for the timer/counter unit of the Ingenic JZ SoCs.
 
+config MICROCHIP_PIT64B
+	bool "Microchip PIT64B support"
+	depends on OF || COMPILE_TEST
+	select CLKSRC_MMIO
+	help
+	  This option enables Microchip PIT64B timer.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 4dfe4225ece7..713686faa549 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
+obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
new file mode 100644
index 000000000000..27a389a7e078
--- /dev/null
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 64-bit Periodic Interval Timer driver
+ *
+ * Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+
+#define MCHP_PIT64B_CR			0x00	/* Control Register */
+#define MCHP_PIT64B_CR_START		BIT(0)
+#define MCHP_PIT64B_CR_SWRST		BIT(8)
+
+#define MCHP_PIT64B_MR			0x04	/* Mode Register */
+#define MCHP_PIT64B_MR_CONT		BIT(0)
+#define MCHP_PIT64B_MR_ONE_SHOT		(0)
+#define MCHP_PIT64B_MR_SGCLK		BIT(3)
+#define MCHP_PIT64B_MR_PRES		GENMASK(11, 8)
+
+#define MCHP_PIT64B_LSB_PR		0x08	/* LSB Period Register */
+
+#define MCHP_PIT64B_MSB_PR		0x0C	/* MSB Period Register */
+
+#define MCHP_PIT64B_IER			0x10	/* Interrupt Enable Register */
+#define MCHP_PIT64B_IER_PERIOD		BIT(0)
+
+#define MCHP_PIT64B_ISR			0x1C	/* Interrupt Status Register */
+
+#define MCHP_PIT64B_TLSBR		0x20	/* Timer LSB Register */
+
+#define MCHP_PIT64B_TMSBR		0x24	/* Timer MSB Register */
+
+#define MCHP_PIT64B_PRES_MAX		0x10
+#define MCHP_PIT64B_LSBMASK		GENMASK_ULL(31, 0)
+#define MCHP_PIT64B_PRES_TO_MODE(p)	(MCHP_PIT64B_MR_PRES & ((p) << 8))
+#define MCHP_PIT64B_MODE_TO_PRES(m)	((MCHP_PIT64B_MR_PRES & (m)) >> 8)
+#define MCHP_PIT64B_DEF_CS_FREQ		5000000UL	/* 5 MHz */
+#define MCHP_PIT64B_DEF_CE_FREQ		32768		/* 32 KHz */
+
+#define MCHP_PIT64B_NAME		"pit64b"
+
+/**
+ * struct mchp_pit64b_timer - PIT64B timer data structure
+ * @base: base address of PIT64B hardware block
+ * @pclk: PIT64B's peripheral clock
+ * @gclk: PIT64B's generic clock
+ * @mode: precomputed value for mode register
+ */
+struct mchp_pit64b_timer {
+	void __iomem	*base;
+	struct clk	*pclk;
+	struct clk	*gclk;
+	u32		mode;
+};
+
+/**
+ * mchp_pit64b_clkevt - PIT64B clockevent data structure
+ * @timer: PIT64B timer
+ * @clkevt: clockevent
+ */
+struct mchp_pit64b_clkevt {
+	struct mchp_pit64b_timer	timer;
+	struct clock_event_device	clkevt;
+};
+
+#define to_mchp_pit64b_timer(x) \
+	((struct mchp_pit64b_timer *)container_of(x,\
+		struct mchp_pit64b_clkevt, clkevt))
+
+/* Base address for clocksource timer. */
+static void __iomem *mchp_pit64b_cs_base;
+/* Default cycles for clockevent timer. */
+static u64 mchp_pit64b_ce_cycles;
+
+static inline u64 mchp_pit64b_cnt_read(void __iomem *base)
+{
+	unsigned long	flags;
+	u32		low, high;
+
+	raw_local_irq_save(flags);
+
+	/*
+	 * When using a 64 bit period TLSB must be read first, followed by the
+	 * read of TMSB. This sequence generates an atomic read of the 64 bit
+	 * timer value whatever the lapse of time between the accesses.
+	 */
+	low = readl_relaxed(base + MCHP_PIT64B_TLSBR);
+	high = readl_relaxed(base + MCHP_PIT64B_TMSBR);
+
+	raw_local_irq_restore(flags);
+
+	return (((u64)high << 32) | low);
+}
+
+static inline void mchp_pit64b_reset(struct mchp_pit64b_timer *timer,
+				     u64 cycles, u32 mode, u32 irqs)
+{
+	u32 low, high;
+
+	low = cycles & MCHP_PIT64B_LSBMASK;
+	high = cycles >> 32;
+
+	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
+	writel_relaxed(mode | timer->mode, timer->base + MCHP_PIT64B_MR);
+	writel_relaxed(high, timer->base + MCHP_PIT64B_MSB_PR);
+	writel_relaxed(low, timer->base + MCHP_PIT64B_LSB_PR);
+	writel_relaxed(irqs, timer->base + MCHP_PIT64B_IER);
+	writel_relaxed(MCHP_PIT64B_CR_START, timer->base + MCHP_PIT64B_CR);
+}
+
+static u64 mchp_pit64b_clksrc_read(struct clocksource *cs)
+{
+	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
+}
+
+static u64 mchp_pit64b_sched_read_clk(void)
+{
+	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
+}
+
+static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
+{
+	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+
+	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
+
+	return 0;
+}
+
+static int mchp_pit64b_clkevt_set_periodic(struct clock_event_device *cedev)
+{
+	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+
+	mchp_pit64b_reset(timer, mchp_pit64b_ce_cycles, MCHP_PIT64B_MR_CONT,
+			  MCHP_PIT64B_IER_PERIOD);
+
+	return 0;
+}
+
+static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
+					     struct clock_event_device *cedev)
+{
+	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+
+	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT,
+			  MCHP_PIT64B_IER_PERIOD);
+
+	return 0;
+}
+
+static void mchp_pit64b_clkevt_suspend(struct clock_event_device *cedev)
+{
+	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+
+	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
+	if (timer->mode & MCHP_PIT64B_MR_SGCLK)
+		clk_disable_unprepare(timer->gclk);
+	clk_disable_unprepare(timer->pclk);
+}
+
+static void mchp_pit64b_clkevt_resume(struct clock_event_device *cedev)
+{
+	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+
+	clk_prepare_enable(timer->pclk);
+	if (timer->mode & MCHP_PIT64B_MR_SGCLK)
+		clk_prepare_enable(timer->gclk);
+}
+
+static irqreturn_t mchp_pit64b_interrupt(int irq, void *dev_id)
+{
+	struct mchp_pit64b_clkevt *irq_data = dev_id;
+
+	/* Need to clear the interrupt. */
+	readl_relaxed(irq_data->timer.base + MCHP_PIT64B_ISR);
+
+	irq_data->clkevt.event_handler(&irq_data->clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static void __init mchp_pit64b_pres_compute(u32 *pres, u32 clk_rate,
+					    u32 max_rate)
+{
+	u32 tmp;
+
+	for (*pres = 0; *pres < MCHP_PIT64B_PRES_MAX; (*pres)++) {
+		tmp = clk_rate / (*pres + 1);
+		if (tmp <= max_rate)
+			break;
+	}
+
+	/* Use the bigest prescaler if we didn't match one. */
+	if (*pres == MCHP_PIT64B_PRES_MAX)
+		*pres = MCHP_PIT64B_PRES_MAX - 1;
+}
+
+/**
+ * mchp_pit64b_init_mode - prepare PIT64B mode register value to be used at
+ *			   runtime; this includes prescaler and SGCLK bit
+ *
+ * PIT64B timer may be fed by gclk or pclk. When gclk is used its rate has to
+ * be at least 3 times lower that pclk's rate. pclk rate is fixed, gclk rate
+ * could be changed via clock APIs. The chosen clock (pclk or gclk) could be
+ * divided by the internal PIT64B's divider.
+ *
+ * This function, first tries to use GCLK by requesting the desired rate from
+ * PMC and then using the internal PIT64B prescaler, if any, to reach the
+ * requested rate. If PCLK/GCLK < 3 (condition requested by PIT64B hardware)
+ * then the function falls back on using PCLK as clock source for PIT64B timer
+ * choosing the highest prescaler in case it doesn't locate one to match the
+ * requested frequency.
+ *
+ * Below is presented the PIT64B block in relation with PMC:
+ *
+ *                                PIT64B
+ *  PMC             +------------------------------------+
+ * +----+           |   +-----+                          |
+ * |    |-->gclk -->|-->|     |    +---------+  +-----+  |
+ * |    |           |   | MUX |--->| Divider |->|timer|  |
+ * |    |-->pclk -->|-->|     |    +---------+  +-----+  |
+ * +----+           |   +-----+                          |
+ *                  |      ^                             |
+ *                  |     sel                            |
+ *                  +------------------------------------+
+ *
+ * Where:
+ *	- gclk rate <= pclk rate/3
+ *	- gclk rate could be requested from PMC
+ *	- pclk rate is fixed (cannot be requested from PMC)
+ */
+static int __init mchp_pit64b_init_mode(struct mchp_pit64b_timer *timer,
+					unsigned long max_rate)
+{
+	unsigned long pclk_rate, diff = 0, best_diff = ULONG_MAX;
+	long gclk_round = 0;
+	u32 pres, best_pres = 0;
+
+	pclk_rate = clk_get_rate(timer->pclk);
+	if (!pclk_rate)
+		return -EINVAL;
+
+	/* Try using GCLK. */
+	gclk_round = clk_round_rate(timer->gclk, max_rate);
+	if (gclk_round < 0)
+		goto pclk;
+
+	if (pclk_rate / gclk_round < 3)
+		goto pclk;
+
+	mchp_pit64b_pres_compute(&pres, gclk_round, max_rate);
+	best_diff = abs(gclk_round / (pres + 1) - max_rate);
+	best_pres = pres;
+
+	if (!best_diff) {
+		timer->mode |= MCHP_PIT64B_MR_SGCLK;
+		goto done;
+	}
+
+pclk:
+	/* Check if requested rate could be obtained using PCLK. */
+	mchp_pit64b_pres_compute(&pres, pclk_rate, max_rate);
+	diff = abs(pclk_rate / (pres + 1) - max_rate);
+
+	if (best_diff > diff) {
+		/* Use PCLK. */
+		best_pres = pres;
+	} else {
+		/* Use GCLK. */
+		timer->mode |= MCHP_PIT64B_MR_SGCLK;
+		clk_set_rate(timer->gclk, gclk_round);
+	}
+
+done:
+	timer->mode |= MCHP_PIT64B_PRES_TO_MODE(best_pres);
+
+	pr_info("PIT64B: using clk=%s with prescaler %u, freq=%lu [Hz]\n",
+		timer->mode & MCHP_PIT64B_MR_SGCLK ? "gclk" : "pclk", best_pres,
+		timer->mode & MCHP_PIT64B_MR_SGCLK ?
+		gclk_round / (best_pres + 1) : pclk_rate / (best_pres + 1));
+
+	return 0;
+}
+
+static int __init mchp_pit64b_init_clksrc(struct mchp_pit64b_timer *timer,
+					  u32 clk_rate)
+{
+	int ret;
+
+	mchp_pit64b_reset(timer, ULLONG_MAX, MCHP_PIT64B_MR_CONT, 0);
+
+	mchp_pit64b_cs_base = timer->base;
+
+	ret = clocksource_mmio_init(timer->base, MCHP_PIT64B_NAME, clk_rate,
+				    210, 64, mchp_pit64b_clksrc_read);
+	if (ret) {
+		pr_debug("clksrc: Failed to register PIT64B clocksource!\n");
+
+		/* Stop timer. */
+		writel_relaxed(MCHP_PIT64B_CR_SWRST,
+			       timer->base + MCHP_PIT64B_CR);
+
+		return ret;
+	}
+
+	sched_clock_register(mchp_pit64b_sched_read_clk, 64, clk_rate);
+
+	return 0;
+}
+
+static int __init mchp_pit64b_init_clkevt(struct mchp_pit64b_timer *timer,
+					  u32 clk_rate, u32 irq)
+{
+	struct mchp_pit64b_clkevt *ce;
+	int ret;
+
+	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
+	if (!ce)
+		return -ENOMEM;
+
+	mchp_pit64b_ce_cycles = DIV_ROUND_CLOSEST(clk_rate, HZ);
+
+	ce->timer.base = timer->base;
+	ce->timer.pclk = timer->pclk;
+	ce->timer.gclk = timer->gclk;
+	ce->timer.mode = timer->mode;
+	ce->clkevt.name = MCHP_PIT64B_NAME;
+	ce->clkevt.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC;
+	ce->clkevt.rating = 150;
+	ce->clkevt.set_state_shutdown = mchp_pit64b_clkevt_shutdown;
+	ce->clkevt.set_state_periodic = mchp_pit64b_clkevt_set_periodic;
+	ce->clkevt.set_next_event = mchp_pit64b_clkevt_set_next_event;
+	ce->clkevt.suspend = mchp_pit64b_clkevt_suspend;
+	ce->clkevt.resume = mchp_pit64b_clkevt_resume;
+	ce->clkevt.cpumask = cpumask_of(0);
+	ce->clkevt.irq = irq;
+
+	ret = request_irq(irq, mchp_pit64b_interrupt, IRQF_TIMER,
+			  "pit64b_tick", ce);
+	if (ret) {
+		pr_debug("clkevt: Failed to setup PIT64B IRQ\n");
+		kfree(ce);
+		return ret;
+	}
+
+	clockevents_config_and_register(&ce->clkevt, clk_rate, 1, ULONG_MAX);
+
+	return 0;
+}
+
+static int __init mchp_pit64b_dt_init_timer(struct device_node *node,
+					    bool clkevt)
+{
+	u32 freq = clkevt ? MCHP_PIT64B_DEF_CE_FREQ : MCHP_PIT64B_DEF_CS_FREQ;
+	struct mchp_pit64b_timer timer = { 0 };
+	unsigned long clk_rate;
+	u32 irq = 0;
+	int ret;
+
+	/* Parse DT node. */
+	timer.pclk = of_clk_get_by_name(node, "pclk");
+	if (IS_ERR(timer.pclk))
+		return PTR_ERR(timer.pclk);
+
+	timer.gclk = of_clk_get_by_name(node, "gclk");
+	if (IS_ERR(timer.gclk))
+		return PTR_ERR(timer.gclk);
+
+	timer.base = of_iomap(node, 0);
+	if (!timer.base)
+		return -ENXIO;
+
+	if (clkevt) {
+		irq = irq_of_parse_and_map(node, 0);
+		if (!irq) {
+			ret = -ENODEV;
+			goto io_unmap;
+		}
+	}
+
+	/* Initialize mode (prescaler + SGCK bit). To be used at runtime. */
+	ret = mchp_pit64b_init_mode(&timer, freq);
+	if (ret)
+		goto irq_unmap;
+
+	ret = clk_prepare_enable(timer.pclk);
+	if (ret)
+		goto irq_unmap;
+
+	if (timer.mode & MCHP_PIT64B_MR_SGCLK) {
+		ret = clk_prepare_enable(timer.gclk);
+		if (ret)
+			goto pclk_unprepare;
+
+		clk_rate = clk_get_rate(timer.gclk);
+	} else {
+		clk_rate = clk_get_rate(timer.pclk);
+	}
+	clk_rate = clk_rate / (MCHP_PIT64B_MODE_TO_PRES(timer.mode) + 1);
+
+	if (clkevt)
+		ret = mchp_pit64b_init_clkevt(&timer, clk_rate, irq);
+	else
+		ret = mchp_pit64b_init_clksrc(&timer, clk_rate);
+
+	if (ret)
+		goto gclk_unprepare;
+
+	return 0;
+
+gclk_unprepare:
+	if (timer.mode & MCHP_PIT64B_MR_SGCLK)
+		clk_disable_unprepare(timer.gclk);
+pclk_unprepare:
+	clk_disable_unprepare(timer.pclk);
+irq_unmap:
+	irq_dispose_mapping(irq);
+io_unmap:
+	iounmap(timer.base);
+
+	return ret;
+}
+
+static int __init mchp_pit64b_dt_init(struct device_node *node)
+{
+	static int inits;
+
+	switch (inits++) {
+	case 0:
+		/* 1st request, register clockevent. */
+		return mchp_pit64b_dt_init_timer(node, true);
+	case 1:
+		/* 2nd request, register clocksource. */
+		return mchp_pit64b_dt_init_timer(node, false);
+	}
+
+	/* The rest, don't care. */
+	return -EINVAL;
+}
+
+TIMER_OF_DECLARE(mchp_pit64b, "microchip,sam9x60-pit64b", mchp_pit64b_dt_init);
-- 
2.7.4

