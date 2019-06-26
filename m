Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3E8C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6023E216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vfdE/2zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfFZOsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:48:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37289 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbfFZOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so3077159wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dy8jnockowGt8dviHenRA8qAp72zLWbVdawq1Q1woVo=;
        b=vfdE/2zvPULDGkDvomVCQtujeHtNfBI8QXc7MZ+EPs/m/7eULjp5+b2AdZX6LQ2Sr/
         MMnFxjoXkbMcHQajkncEilwrB2gVp+0PHjsVrLTDGJjMqHHcCc57px60Wfz7LX4wrWdj
         Nssjo9qGr3ojqf6h+IsNAzKpvDTfkfW5cRGTmCr48nNkgraj2kP/Vu8eJxuVE5tQIIiw
         VKcoyfgA6HTMy+Nx5171IHUEEHk2rhWeW7qj10J+5k8ZmW0Jn/7EXcewnWxwDfE3KCxG
         5Awi7zh9z+FAfib4Z9b0gKqb/W8rFl390rVFQIZUVNgLIptDJ8RNx7ZJcQPOMrYvCV9x
         2ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dy8jnockowGt8dviHenRA8qAp72zLWbVdawq1Q1woVo=;
        b=U+pQgqkq3DlXccmdrRgcRLeWY/tGzzhaxk5R0GhdBqdP+Lkyuhjk5oa43pDFNJgid6
         GOLt4a8SUoUfOAFHKIoXD+DKJXbP8kf35QKo5xnZdWJz8Z2ZBZlV/7BZZSohVMBOvNlE
         SC3wVWrzI7PenYDDirxqsiOcwKUwp7aycKLp3JfdaGWSGhbfRUVKptUccvIhZxJT1ySI
         HbOzJtcNBkWoGd6C+UTZUGpfrJh5aTw3W8WKPUq1Yw9fLAOQp5Xxkg9vZPYssMgID0gA
         9epTnoFeqbJC9Y6yNJM+sN7NU4DW3o1M5Q1ejG/UO6BreoBmqWIKwPHnz2D1QnfIK0tI
         3WMg==
X-Gm-Message-State: APjAAAVk+dxxIqZQA1Rju0NP+SzOWgGHwezbmlo4HWfWjj2ZZFsVvQb1
        MAt6arZGyP+IqEDW+VrM2zoidA==
X-Google-Smtp-Source: APXvYqzbgHKAL0NZKcTAAwJY0e15f5R3IWwAHtyMvJQ+bSOJgJATDzESk1DI9y2a/ktJSapkqM3AMg==
X-Received: by 2002:adf:f7c8:: with SMTP id a8mr3930355wrq.246.1561560475035;
        Wed, 26 Jun 2019 07:47:55 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:54 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 24/25] clocksource/drivers/davinci: Add support for clockevents
Date:   Wed, 26 Jun 2019 16:46:50 +0200
Message-Id: <20190626144651.16742-24-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the clocksource and clockevent support for davinci platforms
lives in mach-davinci. It hard-codes many things, uses global variables,
implements functionalities unused by any platform and has code fragments
scattered across many (often unrelated) files.

Implement a new, modern and simplified timer driver and put it into
drivers/clocksource. We still need to support legacy board files so
export a config structure and a function that allows machine code to
register the timer.

The timer we're using is 64-bit but can be programmed in dual 32-bit
mode (both chained and unchained).

On all davinci SoCs except for da830 we're using both halves. Lower half
for clockevents and upper half for clocksource. On da830 we're using the
lower half for both with the help of a compare register.

This patch contains the core code and support for clockevent. The
clocksource code will be included in a subsequent patch.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig         |   5 +
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-davinci.c | 284 ++++++++++++++++++++++++++++
 include/clocksource/timer-davinci.h |  44 +++++
 4 files changed, 334 insertions(+)
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index e9936992934a..5e9317dc3d39 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -43,6 +43,11 @@ config BCM_KONA_TIMER
 	help
 	  Enables the support for the BCM Kona mobile timer driver.
 
+config DAVINCI_TIMER
+	bool "Texas Instruments DaVinci timer driver" if COMPILE_TEST
+	help
+	  Enables the support for the TI DaVinci timer driver.
+
 config DIGICOLOR_TIMER
 	bool "Digicolor timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 0939886b305f..5582252efb31 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
 obj-$(CONFIG_EM_TIMER_STI)	+= em_sti.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
+obj-$(CONFIG_DAVINCI_TIMER)	+= timer-davinci.o
 obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
 obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
new file mode 100644
index 000000000000..246a5564495d
--- /dev/null
+++ b/drivers/clocksource/timer-davinci.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * TI DaVinci clocksource driver
+ *
+ * Copyright (C) 2019 Texas Instruments
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ * (with tiny parts adopted from code by Kevin Hilman <khilman@baylibre.com>)
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#include <clocksource/timer-davinci.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt "\n", __func__
+
+#define DAVINCI_TIMER_REG_TIM12			0x10
+#define DAVINCI_TIMER_REG_TIM34			0x14
+#define DAVINCI_TIMER_REG_PRD12			0x18
+#define DAVINCI_TIMER_REG_PRD34			0x1c
+#define DAVINCI_TIMER_REG_TCR			0x20
+#define DAVINCI_TIMER_REG_TGCR			0x24
+
+#define DAVINCI_TIMER_TIMMODE_MASK		GENMASK(3, 2)
+#define DAVINCI_TIMER_RESET_MASK		GENMASK(1, 0)
+#define DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED	BIT(2)
+#define DAVINCI_TIMER_UNRESET			GENMASK(1, 0)
+
+#define DAVINCI_TIMER_ENAMODE_MASK		GENMASK(1, 0)
+#define DAVINCI_TIMER_ENAMODE_DISABLED		0x00
+#define DAVINCI_TIMER_ENAMODE_ONESHOT		BIT(0)
+#define DAVINCI_TIMER_ENAMODE_PERIODIC		BIT(1)
+
+#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM12	6
+#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM34	22
+
+#define DAVINCI_TIMER_MIN_DELTA			0x01
+#define DAVINCI_TIMER_MAX_DELTA			0xfffffffe
+
+#define DAVINCI_TIMER_TGCR_DEFAULT \
+		(DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED | DAVINCI_TIMER_UNRESET)
+
+struct davinci_clockevent {
+	struct clock_event_device dev;
+	void __iomem *base;
+	unsigned int cmp_off;
+};
+
+static struct davinci_clockevent *
+to_davinci_clockevent(struct clock_event_device *clockevent)
+{
+	return container_of(clockevent, struct davinci_clockevent, dev);
+}
+
+static unsigned int
+davinci_clockevent_read(struct davinci_clockevent *clockevent,
+			unsigned int reg)
+{
+	return readl_relaxed(clockevent->base + reg);
+}
+
+static void davinci_clockevent_write(struct davinci_clockevent *clockevent,
+				     unsigned int reg, unsigned int val)
+{
+	writel_relaxed(val, clockevent->base + reg);
+}
+
+static void davinci_tim12_shutdown(void __iomem *base)
+{
+	unsigned int tcr;
+
+	tcr = DAVINCI_TIMER_ENAMODE_DISABLED <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
+	/*
+	 * This function is only ever called if we're using both timer
+	 * halves. In this case TIM34 runs in periodic mode and we must
+	 * not modify it.
+	 */
+	tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
+
+	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
+}
+
+static void davinci_tim12_set_oneshot(void __iomem *base)
+{
+	unsigned int tcr;
+
+	tcr = DAVINCI_TIMER_ENAMODE_ONESHOT <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
+	/* Same as above. */
+	tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
+
+	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
+}
+
+static int davinci_clockevent_shutdown(struct clock_event_device *dev)
+{
+	struct davinci_clockevent *clockevent;
+
+	clockevent = to_davinci_clockevent(dev);
+
+	davinci_tim12_shutdown(clockevent->base);
+
+	return 0;
+}
+
+static int davinci_clockevent_set_oneshot(struct clock_event_device *dev)
+{
+	struct davinci_clockevent *clockevent = to_davinci_clockevent(dev);
+
+	davinci_clockevent_write(clockevent, DAVINCI_TIMER_REG_TIM12, 0x0);
+
+	davinci_tim12_set_oneshot(clockevent->base);
+
+	return 0;
+}
+
+static int
+davinci_clockevent_set_next_event_std(unsigned long cycles,
+				      struct clock_event_device *dev)
+{
+	struct davinci_clockevent *clockevent = to_davinci_clockevent(dev);
+
+	davinci_clockevent_shutdown(dev);
+
+	davinci_clockevent_write(clockevent, DAVINCI_TIMER_REG_TIM12, 0x0);
+	davinci_clockevent_write(clockevent, DAVINCI_TIMER_REG_PRD12, cycles);
+
+	davinci_clockevent_set_oneshot(dev);
+
+	return 0;
+}
+
+static int
+davinci_clockevent_set_next_event_cmp(unsigned long cycles,
+				      struct clock_event_device *dev)
+{
+	struct davinci_clockevent *clockevent = to_davinci_clockevent(dev);
+	unsigned int curr_time;
+
+	curr_time = davinci_clockevent_read(clockevent,
+					    DAVINCI_TIMER_REG_TIM12);
+	davinci_clockevent_write(clockevent,
+				 clockevent->cmp_off, curr_time + cycles);
+
+	return 0;
+}
+
+static irqreturn_t davinci_timer_irq_timer(int irq, void *data)
+{
+	struct davinci_clockevent *clockevent = data;
+
+	if (!clockevent_state_oneshot(&clockevent->dev))
+		davinci_tim12_shutdown(clockevent->base);
+
+	clockevent->dev.event_handler(&clockevent->dev);
+
+	return IRQ_HANDLED;
+}
+
+static void davinci_timer_init(void __iomem *base)
+{
+	/* Set clock to internal mode and disable it. */
+	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TCR);
+	/*
+	 * Reset both 32-bit timers, set no prescaler for timer 34, set the
+	 * timer to dual 32-bit unchained mode, unreset both 32-bit timers.
+	 */
+	writel_relaxed(DAVINCI_TIMER_TGCR_DEFAULT,
+		       base + DAVINCI_TIMER_REG_TGCR);
+	/* Init both counters to zero. */
+	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM12);
+	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM34);
+}
+
+int __init davinci_timer_register(struct clk *clk,
+				  const struct davinci_timer_cfg *timer_cfg)
+{
+	struct davinci_clockevent *clockevent;
+	unsigned int tick_rate;
+	void __iomem *base;
+	int rv;
+
+	rv = clk_prepare_enable(clk);
+	if (rv) {
+		pr_err("Unable to prepare and enable the timer clock");
+		return rv;
+	}
+
+	if (!request_mem_region(timer_cfg->reg.start,
+				resource_size(&timer_cfg->reg),
+				"davinci-timer")) {
+		pr_err("Unable to request memory region");
+		return -EBUSY;
+	}
+
+	base = ioremap(timer_cfg->reg.start, resource_size(&timer_cfg->reg));
+	if (!base) {
+		pr_err("Unable to map the register range");
+		return -ENOMEM;
+	}
+
+	davinci_timer_init(base);
+	tick_rate = clk_get_rate(clk);
+
+	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL | __GFP_NOFAIL);
+	if (!clockevent) {
+		pr_err("Error allocating memory for clockevent data");
+		return -ENOMEM;
+	}
+
+	clockevent->dev.name = "tim12";
+	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
+	clockevent->dev.cpumask = cpumask_of(0);
+	clockevent->base = base;
+
+	if (timer_cfg->cmp_off) {
+		clockevent->cmp_off = timer_cfg->cmp_off;
+		clockevent->dev.set_next_event =
+				davinci_clockevent_set_next_event_cmp;
+	} else {
+		clockevent->dev.set_next_event =
+				davinci_clockevent_set_next_event_std;
+		clockevent->dev.set_state_oneshot =
+				davinci_clockevent_set_oneshot;
+		clockevent->dev.set_state_shutdown =
+				davinci_clockevent_shutdown;
+	}
+
+	rv = request_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKEVENT_IRQ].start,
+			 davinci_timer_irq_timer, IRQF_TIMER,
+			 "clockevent/tim12", clockevent);
+	if (rv) {
+		pr_err("Unable to request the clockevent interrupt");
+		return rv;
+	}
+
+	clockevents_config_and_register(&clockevent->dev, tick_rate,
+					DAVINCI_TIMER_MIN_DELTA,
+					DAVINCI_TIMER_MAX_DELTA);
+
+	return 0;
+}
+
+static int __init of_davinci_timer_register(struct device_node *np)
+{
+	struct davinci_timer_cfg timer_cfg = { };
+	struct clk *clk;
+	int rv;
+
+	rv = of_address_to_resource(np, 0, &timer_cfg.reg);
+	if (rv) {
+		pr_err("Unable to get the register range for timer");
+		return rv;
+	}
+
+	rv = of_irq_to_resource_table(np, timer_cfg.irq,
+				      DAVINCI_TIMER_NUM_IRQS);
+	if (rv != DAVINCI_TIMER_NUM_IRQS) {
+		pr_err("Unable to get the interrupts for timer");
+		return rv;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Unable to get the timer clock");
+		return PTR_ERR(clk);
+	}
+
+	rv = davinci_timer_register(clk, &timer_cfg);
+	if (rv)
+		clk_put(clk);
+
+	return rv;
+}
+TIMER_OF_DECLARE(davinci_timer, "ti,da830-timer", of_davinci_timer_register);
diff --git a/include/clocksource/timer-davinci.h b/include/clocksource/timer-davinci.h
new file mode 100644
index 000000000000..1dcc1333fbc8
--- /dev/null
+++ b/include/clocksource/timer-davinci.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * TI DaVinci clocksource driver
+ *
+ * Copyright (C) 2019 Texas Instruments
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ */
+
+#ifndef __TIMER_DAVINCI_H__
+#define __TIMER_DAVINCI_H__
+
+#include <linux/clk.h>
+#include <linux/ioport.h>
+
+enum {
+	DAVINCI_TIMER_CLOCKEVENT_IRQ,
+	DAVINCI_TIMER_CLOCKSOURCE_IRQ,
+	DAVINCI_TIMER_NUM_IRQS,
+};
+
+/**
+ * struct davinci_timer_cfg - davinci clocksource driver configuration struct
+ * @reg:        register range resource
+ * @irq:        clockevent and clocksource interrupt resources
+ * @cmp_off:    if set - it specifies the compare register used for clockevent
+ *
+ * Note: if the compare register is specified, the driver will use the bottom
+ * clock half for both clocksource and clockevent and the compare register
+ * to generate event irqs. The user must supply the correct compare register
+ * interrupt number.
+ *
+ * This is only used by da830 the DSP of which uses the top half. The timer
+ * driver still configures the top half to run in free-run mode.
+ */
+struct davinci_timer_cfg {
+	struct resource reg;
+	struct resource irq[DAVINCI_TIMER_NUM_IRQS];
+	unsigned int cmp_off;
+};
+
+int __init davinci_timer_register(struct clk *clk,
+				  const struct davinci_timer_cfg *data);
+
+#endif /* __TIMER_DAVINCI_H__ */
-- 
2.17.1

