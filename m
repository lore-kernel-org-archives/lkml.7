Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C430BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3112173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="11NgPL/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfDQOrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:47:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40363 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbfDQOrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:47:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so32337727wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mc/iHx/tdBV2Y5Ce2UuCUBJZk5uyVXng+F7fF5vVZk8=;
        b=11NgPL/kqhVvr9A5En6hn/7biPkGRMMZH+xgqoSDiSotkwpeD5OLbQkJm6ZFMlpfJP
         7SQtMK16c5Aywtoo/Vi2A/66c0Vr5BCQQ7ztvnpepedTx3ZnbGPoTHa9rJJ4fQSfqj2W
         yQqCrBw2xr37ymWIsALAB2ve1YcGXr0aDYdS6e6SUb7QQaY3E5BFsr1bvoLPvzR70Q56
         qdUtf+rKSntP2+aHE06aknjPUd4VdNNYNQZ5n+I5pp7JvDScIwI2v53IHE5s/kjEeEX4
         /z96HPc19jDe+kajfrvETD3EPNsijEJzUpIDm5EZ+ZUC9jjttUSztFDAdmyQMm8i1DIm
         R0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mc/iHx/tdBV2Y5Ce2UuCUBJZk5uyVXng+F7fF5vVZk8=;
        b=N1bsFvsRc5UUH0yuZvetCNGiit+qLKBiXDHVrbJIgI+oWYt4D/P76mfiUcYxtgz0QO
         dBqhUOzKeuoxCwmcjDQjJiLttfNpqAj5m+nf0MaW+UqOBqnMSI1QzkgCk4H1LOym+fLO
         f8gJYi5vcmvVyGsld2m8Glqth2ej6DnkZ/VqHbXxkBh1dP4bJmCxeDC0fbF+JX5iLGoa
         FnpWioPegeOr62Flqv/IEDdIY1Ev/sV4dX7UTWeH+WpzXbcm3D7kPfdXJcgu88qPmuUR
         PbPYnYmoju4h3/xwrSoqF8sRB8s48/6fFmkTsBTEiXMiiBH1N6SizA/xcQDbMBDaB+b3
         F30w==
X-Gm-Message-State: APjAAAXivGLyucnCk6frhZ6RzoPvtT37tsP1xJDC64J1SvLM5xUxsmtq
        tE1mAjhsONzfSzmP6F4In3Whmw==
X-Google-Smtp-Source: APXvYqz1JNp+hmnyeMYsmo81RrcxiYrpbco/5O/fdKkmVJLzjK+feb1WhtI1rgKKgG1teLv7m18/Tg==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr34932552wrm.14.1555512435753;
        Wed, 17 Apr 2019 07:47:15 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-15-216.w90-86.abo.wanadoo.fr. [90.86.218.216])
        by smtp.gmail.com with ESMTPSA id u17sm5582862wmu.36.2019.04.17.07.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:47:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RFC 1/2] clocksource: davinci-timer: add support for clockevents
Date:   Wed, 17 Apr 2019 16:47:08 +0200
Message-Id: <20190417144709.19588-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417144709.19588-1-brgl@bgdev.pl>
References: <20190417144709.19588-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
mode (both chained and unchained). We're using dual 32-bit mode to
have separate counters for clockevents and clocksource.

This patch contains the core code and support for clockevent. The
clocksource code will be included in a subsequent patch.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clocksource/Kconfig         |   5 +
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-davinci.c | 272 ++++++++++++++++++++++++++++
 include/clocksource/timer-davinci.h |  44 +++++
 4 files changed, 322 insertions(+)
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 171502a356aa..974f9b50ebf4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -42,6 +42,11 @@ config BCM_KONA_TIMER
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
index be6e0fbc7489..3c73d0e58b45 100644
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
index 000000000000..d30f81a4088e
--- /dev/null
+++ b/drivers/clocksource/timer-davinci.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// TI DaVinci clocksource driver
+//
+// Copyright (C) 2019 Texas Instruments
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+// (with tiny parts adopted from code by Kevin Hilman <khilman@baylibre.com>)
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
+
+	unsigned int tim_off;
+	unsigned int prd_off;
+	unsigned int cmp_off;
+
+	unsigned int enamode_disabled;
+	unsigned int enamode_oneshot;
+	unsigned int enamode_periodic;
+	unsigned int enamode_mask;
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
+static void davinci_reg_update(void __iomem *base, unsigned int reg,
+			       unsigned int mask, unsigned int val)
+{
+	unsigned int new, orig;
+
+	orig = readl_relaxed(base + reg);
+	new = orig & ~mask;
+	new |= val & mask;
+
+	writel_relaxed(new, base + reg);
+}
+
+static void davinci_clockevent_update(struct davinci_clockevent *clockevent,
+				      unsigned int reg, unsigned int mask,
+				      unsigned int val)
+{
+	davinci_reg_update(clockevent->base, reg, mask, val);
+}
+
+static int
+davinci_clockevent_set_next_event_std(unsigned long cycles,
+				      struct clock_event_device *dev)
+{
+	struct davinci_clockevent *clockevent;
+	unsigned int enamode;
+
+	clockevent = to_davinci_clockevent(dev);
+	enamode = clockevent->enamode_disabled;
+
+	davinci_clockevent_update(clockevent, DAVINCI_TIMER_REG_TCR,
+				  clockevent->enamode_mask,
+				  clockevent->enamode_disabled);
+
+	davinci_clockevent_write(clockevent, clockevent->tim_off, 0x0);
+	davinci_clockevent_write(clockevent, clockevent->prd_off, cycles);
+
+	if (clockevent_state_oneshot(&clockevent->dev))
+		enamode = clockevent->enamode_oneshot;
+	else if (clockevent_state_periodic(&clockevent->dev))
+		enamode = clockevent->enamode_periodic;
+
+	davinci_clockevent_update(clockevent, DAVINCI_TIMER_REG_TCR,
+				  clockevent->enamode_mask, enamode);
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
+	curr_time = davinci_clockevent_read(clockevent, clockevent->tim_off);
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
+	unsigned int tick_rate, shift;
+	void __iomem *base;
+	int rv;
+
+	rv = clk_prepare_enable(clk);
+	if (rv) {
+		pr_err("Unable to prepare and enable the timer clock");
+		return rv;
+	}
+
+	base = request_mem_region(timer_cfg->reg.start,
+				  resource_size(&timer_cfg->reg),
+				  "davinci-timer");
+	if (!base) {
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
+	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL);
+	if (!clockevent) {
+		pr_err("Error allocating memory for clockevent data");
+		return -ENOMEM;
+	}
+
+	clockevent->dev.name = "tim12";
+	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
+	clockevent->dev.cpumask = cpumask_of(0);
+
+	clockevent->base = base;
+	clockevent->tim_off = DAVINCI_TIMER_REG_TIM12;
+	clockevent->prd_off = DAVINCI_TIMER_REG_PRD12;
+
+	shift = DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
+	clockevent->enamode_disabled = DAVINCI_TIMER_ENAMODE_DISABLED << shift;
+	clockevent->enamode_oneshot = DAVINCI_TIMER_ENAMODE_ONESHOT << shift;
+	clockevent->enamode_periodic = DAVINCI_TIMER_ENAMODE_PERIODIC << shift;
+	clockevent->enamode_mask = DAVINCI_TIMER_ENAMODE_MASK << shift;
+
+	if (timer_cfg->cmp_off) {
+		clockevent->cmp_off = timer_cfg->cmp_off;
+		clockevent->dev.set_next_event =
+				davinci_clockevent_set_next_event_cmp;
+	} else {
+		clockevent->dev.set_next_event =
+				davinci_clockevent_set_next_event_std;
+	}
+
+	rv = request_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKEVENT_IRQ].start,
+			 davinci_timer_irq_timer, IRQF_TIMER,
+			 "clockevent", clockevent);
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
2.21.0

