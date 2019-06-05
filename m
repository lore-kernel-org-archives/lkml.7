Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD121C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6322075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sXfd9FzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfFEIdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:33:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51305 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfFEIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:33:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id f10so1327905wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sPW0jjhcLgAmYpGbPfTj63bhw/QGKlVnitPoeh65CjE=;
        b=sXfd9FzYY672m5QTnRisfc7ml7bOfW/2SexZ4HwCh/gIittWoMkE8TxbhNJtTtcNHq
         WycjV8baIDLGu4lBK7y08/UaMljEJnWMn34mQfZUX6xj9bsOqZBP0RfcUAbs4T1lLY1M
         vht6Sf2JfqJnYhC89r6jIhFes1td5hMXlCTn3wJfc74YSnCBdsJG1Q4zKp7fTDI1hFKd
         vpC64IVKnu/UhwVpRNY43Mu+smsaorQ3/xpQUP90leSckKJy/0H2CShnUT1dWjL/Oq3c
         JzR8nzcjIET+4bt5d+bGfcK2LzqIsgy9xBuEJKAWUqqSIwOPho+uM/k5JPsRg5qBTLU6
         yVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sPW0jjhcLgAmYpGbPfTj63bhw/QGKlVnitPoeh65CjE=;
        b=kcMr7x8xBOHwriBjfhNya4trGG3MH6xeUfn40rsuY38jnOqG83Ecsc9N+hq4LopSue
         Mp+9JQPsLE21zqFjuxu3yhKH4pBqjLXGk3+bbzZLHWY8qENgQwn2U7VdWMJNNByW4TNv
         fse2h5zrIDJWG9hUokedyeZCmOBV3eaTzTZmxZ+VGJGASXvpnvZStl0maMaNclSGi2C2
         M7hczIFjaFmr1fHPyduyqRAcHOhNgQ3if4df1/SmbF6nHo+W+F0uqOvjLgN5JQgFlNoi
         DO9y4vX1w1y9FHd5dcGoDlKUhwxnPVqxZa5dsFYcIKFiz4XCS7z7FEavAcU4U0Og9IOG
         z7ww==
X-Gm-Message-State: APjAAAXrk5TPfi9IXVz86KER8E0yTzWrMCPVAV8g8YgswEF15zQk9L1S
        ZyY7QbK0TWr0g4tJYR7UfiT7dQ==
X-Google-Smtp-Source: APXvYqxL21tTXIVl+WqbCUH0eOk2UX3anKH3+1r0y0JL3DZoOfJhz2XefHoMZqBtW3IjGk015ss7Fg==
X-Received: by 2002:a1c:5412:: with SMTP id i18mr20476798wmb.11.1559723619797;
        Wed, 05 Jun 2019 01:33:39 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b5sm15274471wrx.22.2019.06.05.01.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 01:33:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RFC v3 1/2] clocksource: davinci-timer: add support for clockevents
Date:   Wed,  5 Jun 2019 10:33:33 +0200
Message-Id: <20190605083334.22383-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605083334.22383-1-brgl@bgdev.pl>
References: <20190605083334.22383-1-brgl@bgdev.pl>
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
mode (both chained and unchained).

On all davinci SoCs except for da830 we're using both halves. Lower half
for clockevents and upper half for clocksource. On da830 we're using the
lower half for both with the help of a compare register.

This patch contains the core code and support for clockevent. The
clocksource code will be included in a subsequent patch.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clocksource/Kconfig         |   5 +
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-davinci.c | 285 ++++++++++++++++++++++++++++
 include/clocksource/timer-davinci.h |  44 +++++
 4 files changed, 335 insertions(+)
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3300739edce4..6717a09500ab 100644
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
index 236858fa7fbf..021831bcc567 100644
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
index 000000000000..f8959dccae54
--- /dev/null
+++ b/drivers/clocksource/timer-davinci.c
@@ -0,0 +1,285 @@
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
2.21.0

