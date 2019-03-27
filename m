Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1380C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB082082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VwBeUAVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfC0XRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:17:10 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58540 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbfC0XRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553728625; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2HjsG60H2GgJjgPPTcQEt4g9NWXUCEtxTAIaggqC49E=;
        b=VwBeUAVd457o0BLGb5bjmGTz+yb/xWDGe4Obuw4txA06/dFH2xyINX5Uta2LtUlWwYcZcD
        nE2+zJuHXEPln9+mp18DS3tX6pv/wnMqJYWb2RrYn1oLwFNur8xRZWhV4HITKiAS8YeFcL
        6axnn8cnfwRfi6IlP/cFzMnIRCxrzMk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v11 05/27] clocksource: Add driver for the Ingenic JZ47xx OST
Date:   Thu, 28 Mar 2019 00:16:09 +0100
Message-Id: <20190327231631.15708-6-paul@crapouillou.net>
In-Reply-To: <20190327231631.15708-1-paul@crapouillou.net>
References: <20190327231631.15708-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maarten ter Huurne <maarten@treewalker.org>

OST is the OS Timer, a 64-bit timer/counter with buffered reading.

SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
JZ4780 have a 64-bit OST.

This driver will register both a clocksource and a sched_clock to the
system.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/clocksource/Kconfig       |   8 ++
 drivers/clocksource/Makefile      |   1 +
 drivers/clocksource/ingenic-ost.c | 220 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 drivers/clocksource/ingenic-ost.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c6fb17233ff2..d58ca614e852 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -655,6 +655,14 @@ config INGENIC_TIMER
 	help
 	  Support for the timer/counter unit of the Ingenic JZ SoCs.
 
+config INGENIC_OST
+	bool "Ingenic JZ47xx Operating System Timer"
+	depends on MIPS || COMPILE_TEST
+	depends on COMMON_CLK
+	select INGENIC_TIMER
+	help
+	  Support for the OS Timer of the Ingenic JZ4770 or similar SoC.
+
 config MILBEAUT_TIMER
 	bool "Milbeaut timer driver" if COMPILE_TEST
 	depends on OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 0e360da7b74d..b3d304ec7072 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
 obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
+obj-$(CONFIG_INGENIC_OST)		+= ingenic-ost.o
 obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
new file mode 100644
index 000000000000..66ad328c74cc
--- /dev/null
+++ b/drivers/clocksource/ingenic-ost.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ47xx SoCs TCU Operating System Timer driver
+ *
+ * Copyright (C) 2016 Maarten ter Huurne <maarten@treewalker.org>
+ * Copyright (C) 2019 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/mfd/ingenic-tcu.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/sched_clock.h>
+
+#include "ingenic-timer.h"
+
+#define TCU_OST_TCSR_MASK	0xffc0
+#define TCU_OST_TCSR_CNT_MD	BIT(15)
+
+#define TCU_OST_CHANNEL		15
+
+struct ingenic_ost_soc_info {
+	bool is64bit;
+};
+
+struct ingenic_ost {
+	struct regmap *map;
+	struct clk *clk;
+
+	struct clocksource cs;
+};
+
+static inline struct ingenic_ost *cs_to_ingenic_ost(struct clocksource *cs)
+{
+	return container_of(cs, struct ingenic_ost, cs);
+}
+
+static u64 notrace ingenic_ost_read_cntl(void)
+{
+	/* Bypass the regmap here as we must return as soon as possible */
+	return readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
+}
+
+static u64 notrace ingenic_ost_read_cnth(void)
+{
+	/* Bypass the regmap here as we must return as soon as possible */
+	return readl(ingenic_tcu_base + TCU_REG_OST_CNTH);
+}
+
+static u64 notrace ingenic_ost_clocksource_read64(struct clocksource *cs)
+{
+	struct ingenic_ost *ost = cs_to_ingenic_ost(cs);
+	unsigned int val1, val2;
+	u64 count, recount;
+	s64 diff;
+
+	/*
+	 * The buffering of the upper 32 bits of the timer prevents wrong
+	 * results from the bottom 32 bits overflowing due to the timer ticking
+	 * along. However, it does not prevent wrong results from simultaneous
+	 * reads of the timer, which could reset the buffer mid-read.
+	 * Since this kind of wrong read can happen only when the bottom bits
+	 * overflow, there will be minutes between wrong reads, so if we read
+	 * twice in succession, at least one of the reads will be correct.
+	 */
+	regmap_read(ost->map, TCU_REG_OST_CNTL, &val1);
+	regmap_read(ost->map, TCU_REG_OST_CNTHBUF, &val2);
+	count = (u64)val1 | (u64)val2 << 32;
+
+	regmap_read(ost->map, TCU_REG_OST_CNTL, &val1);
+	regmap_read(ost->map, TCU_REG_OST_CNTHBUF, &val2);
+	recount = (u64)val1 | (u64)val2 << 32;
+
+	/*
+	 * A wrong read will produce a result that is 1<<32 too high: the bottom
+	 * part from before overflow and the upper part from after overflow.
+	 * Therefore, the lower value of the two reads is the correct value.
+	 */
+	diff = (s64)(recount - count);
+	if (unlikely(diff < 0))
+		count = recount;
+
+	return count;
+}
+
+static u64 notrace ingenic_ost_clocksource_read32(struct clocksource *cs)
+{
+	struct ingenic_ost *ost = cs_to_ingenic_ost(cs);
+	unsigned int val;
+
+	regmap_read(ost->map, TCU_REG_OST_CNTH, &val);
+
+	return val;
+}
+
+static int __init ingenic_ost_probe(struct platform_device *pdev)
+{
+	const struct ingenic_ost_soc_info *soc_info;
+	struct device *dev = &pdev->dev;
+	struct ingenic_ost *ost;
+	struct clocksource *cs;
+	unsigned long rate, flags;
+	int err;
+
+	soc_info = device_get_match_data(dev);
+	if (!soc_info)
+		return -EINVAL;
+
+	ost = devm_kzalloc(dev, sizeof(*ost), GFP_KERNEL);
+	if (!ost)
+		return -ENOMEM;
+
+	ost->map = dev_get_regmap(dev->parent, NULL);
+	if (!ost->map) {
+		dev_err(dev, "regmap not found\n");
+		return -EINVAL;
+	}
+
+	ost->clk = devm_clk_get(dev, "ost");
+	if (IS_ERR(ost->clk))
+		return PTR_ERR(ost->clk);
+
+	err = clk_prepare_enable(ost->clk);
+	if (err)
+		return err;
+
+	/* Clear counter high/low registers */
+	if (soc_info->is64bit)
+		regmap_write(ost->map, TCU_REG_OST_CNTL, 0);
+	regmap_write(ost->map, TCU_REG_OST_CNTH, 0);
+
+	/* Don't reset counter at compare value. */
+	regmap_update_bits(ost->map, TCU_REG_OST_TCSR,
+			   TCU_OST_TCSR_MASK, TCU_OST_TCSR_CNT_MD);
+
+	rate = clk_get_rate(ost->clk);
+
+	/* Enable OST TCU channel */
+	regmap_write(ost->map, TCU_REG_TESR, BIT(TCU_OST_CHANNEL));
+
+	cs = &ost->cs;
+	cs->name	= "ingenic-ost";
+	cs->rating	= 320;
+	cs->flags	= CLOCK_SOURCE_IS_CONTINUOUS;
+
+	if (soc_info->is64bit) {
+		cs->mask = CLOCKSOURCE_MASK(64);
+		cs->read = ingenic_ost_clocksource_read64;
+	} else {
+		cs->mask = CLOCKSOURCE_MASK(32);
+		cs->read = ingenic_ost_clocksource_read32;
+	}
+
+	err = clocksource_register_hz(cs, rate);
+	if (err) {
+		dev_err(dev, "clocksource registration failed: %d\n", err);
+		clk_disable_unprepare(ost->clk);
+		return err;
+	}
+
+	/* Cannot register a sched_clock with interrupts on */
+	local_irq_save(flags);
+	if (soc_info->is64bit)
+		sched_clock_register(ingenic_ost_read_cntl, 32, rate);
+	else
+		sched_clock_register(ingenic_ost_read_cnth, 32, rate);
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ingenic_ost_suspend(struct device *dev)
+{
+	struct ingenic_ost *ost = dev_get_drvdata(dev);
+
+	clk_disable(ost->clk);
+
+	return 0;
+}
+
+static int ingenic_ost_resume(struct device *dev)
+{
+	struct ingenic_ost *ost = dev_get_drvdata(dev);
+
+	return clk_enable(ost->clk);
+}
+
+static SIMPLE_DEV_PM_OPS(ingenic_ost_pm_ops, ingenic_ost_suspend,
+			 ingenic_ost_resume);
+#define INGENIC_OST_PM_OPS (&ingenic_ost_pm_ops)
+#else
+#define INGENIC_OST_PM_OPS NULL
+#endif /* CONFIG_PM_SUSPEND */
+
+static const struct ingenic_ost_soc_info jz4725b_ost_soc_info = {
+	.is64bit = false,
+};
+
+static const struct ingenic_ost_soc_info jz4770_ost_soc_info = {
+	.is64bit = true,
+};
+
+static const struct of_device_id ingenic_ost_of_match[] = {
+	{ .compatible = "ingenic,jz4725b-ost", .data = &jz4725b_ost_soc_info, },
+	{ .compatible = "ingenic,jz4770-ost", .data = &jz4770_ost_soc_info, },
+	{ }
+};
+
+static struct platform_driver ingenic_ost_driver = {
+	.driver = {
+		.name = "ingenic-ost",
+		.pm = INGENIC_OST_PM_OPS,
+		.of_match_table = ingenic_ost_of_match,
+	},
+};
+builtin_platform_driver_probe(ingenic_ost_driver, ingenic_ost_probe);
-- 
2.11.0

