Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87383C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B32205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCMX4F8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfFZOro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:47:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55345 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfFZOrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so2400767wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xsTfqRnHu+yQAKX4GSdpcV7YIOXv0BcnKYn3cggw+uw=;
        b=uCMX4F8iGggQQEfo1YHDs45vJQldgTNLLEWqA4bs5uJ8rgruvQst/74UEEZ2RuIn0U
         3xs4hD0OgMFKcfgRUhQZO+1778f1C383ur2O5UOslKkS2Yy+sPQqJpmBEYv0bJKsKNd0
         m4Rph0JSrHIzvhZp0txs0xx4bnu9I4a+ekrRKxBcXIjRguk84EdWFaJNJO48kOrazebt
         nGA91F8hY/grVHXOzwDUdCChFzqLm5QD3FVjAlfrR6DvunWUhV9HgR74dN64hJRJbD59
         JsN8aVDRXbIT8PWUmPmBDTjnVEy/kOBhEoKxdO7d6HnvE8sfN/7AEBgN4URyIlBE22Ux
         m1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xsTfqRnHu+yQAKX4GSdpcV7YIOXv0BcnKYn3cggw+uw=;
        b=Ut6Q22nW/fD7EEC2NyurZkEVAR2uZUFsjW/0Ha3QcbbMUjigJRWfo+8zGyX6reZG+1
         o+JQ9DMd4Ls7/I3ESHDBafkm5Ie6MEpFjcYi5d3K3owXNsTO3BapR9bMFG3GePAXvQt6
         7M6Lmg5p1vFNQ8M0Pa+olbzBCNCp0jw7yNSOYJqz/Iz1PYICpNxcagGPVOoi8JlM397w
         yVW4j/ILwXy4MHkfljgL7zpUviS7BiS9NqFvPWAXiPcCpKbIaungE7Czy2vDTvPBgWw7
         fGNawAWFRsH08dUlZuAwpo/0ytWa4yppwP5wnVZe35XxvcDmQZcggbxyI1yAMnvyPjiy
         Ub6A==
X-Gm-Message-State: APjAAAWth7ProRPVmKpDjZ+FqEOTykckbdzRYHx7CMzc1r9qUo5S+8jw
        +UYQEH59DFGynh/NzuNA7hMDQA==
X-Google-Smtp-Source: APXvYqyNKMpip8WgGg3+itTl/Rh4ircBsj+OVmz7Sn4sXjY6lFQpeUlWQ0M8NbmK90waZ3glavLAPA==
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr2975708wma.20.1561560455437;
        Wed, 26 Jun 2019 07:47:35 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:34 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Bai Ping <ping.bai@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH 14/25] clocksource/drivers/sysctr: Add nxp system counter timer driver support
Date:   Wed, 26 Jun 2019 16:46:40 +0200
Message-Id: <20190626144651.16742-14-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bai Ping <ping.bai@nxp.com>

The system counter (sys_ctr) is a programmable system counter
which provides a shared time base to the Cortex A15, A7, A53 etc cores.
It is intended for use in applications where the counter is always
powered on and supports multiple, unrelated clocks. The sys_ctr hardware
supports:
 - 56-bit counter width (roll-over time greater than 40 years)
 - compare frame(64-bit compare value) contains programmable interrupt
   generation when compare value <= counter value.

[dlezcano] Fixed over 80 chars length warning

Signed-off-by: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../bindings/timer/nxp,sysctr-timer.txt       |  25 +++
 drivers/clocksource/Kconfig                   |   7 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-imx-sysctr.c        | 145 ++++++++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
 create mode 100644 drivers/clocksource/timer-imx-sysctr.c

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
new file mode 100644
index 000000000000..d57659996d62
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
@@ -0,0 +1,25 @@
+NXP System Counter Module(sys_ctr)
+
+The system counter(sys_ctr) is a programmable system counter which provides
+a shared time base to Cortex A15, A7, A53, A73, etc. it is intended for use in
+applications where the counter is always powered and support multiple,
+unrelated clocks. The compare frame inside can be used for timer purpose.
+
+Required properties:
+
+- compatible :      should be "nxp,sysctr-timer"
+- reg :             Specifies the base physical address and size of the comapre
+                    frame and the counter control, read & compare.
+- interrupts :      should be the first compare frames' interrupt
+- clocks : 	    Specifies the counter clock.
+- clock-names: 	    Specifies the clock's name of this module
+
+Example:
+
+	system_counter: timer@306a0000 {
+		compatible = "nxp,sysctr-timer";
+		reg = <0x306a0000 0x20000>;/* system-counter-rd & compare */
+		clocks = <&clk_8m>;
+		clock-names = "per";
+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+	};
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index d17a347e813a..e9936992934a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -617,6 +617,13 @@ config CLKSRC_IMX_TPM
 	  Enable this option to use IMX Timer/PWM Module (TPM) timer as
 	  clocksource.
 
+config TIMER_IMX_SYS_CTR
+	bool "i.MX system counter timer" if COMPILE_TEST
+	select TIMER_OF
+	help
+	  Enable this option to use i.MX system counter timer as a
+	  clockevent.
+
 config CLKSRC_ST_LPC
 	bool "Low power clocksource found in the LPC" if COMPILE_TEST
 	select TIMER_OF if OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 4145b21eaed3..0939886b305f 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= timer-tango-xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
 obj-$(CONFIG_CLKSRC_IMX_TPM)		+= timer-imx-tpm.o
+obj-$(CONFIG_TIMER_IMX_SYS_CTR)		+= timer-imx-sysctr.o
 obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
 obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
new file mode 100644
index 000000000000..fd7d68066efb
--- /dev/null
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2017-2019 NXP
+
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include "timer-of.h"
+
+#define CMP_OFFSET	0x10000
+
+#define CNTCV_LO	0x8
+#define CNTCV_HI	0xc
+#define CMPCV_LO	(CMP_OFFSET + 0x20)
+#define CMPCV_HI	(CMP_OFFSET + 0x24)
+#define CMPCR		(CMP_OFFSET + 0x2c)
+
+#define SYS_CTR_EN		0x1
+#define SYS_CTR_IRQ_MASK	0x2
+
+static void __iomem *sys_ctr_base;
+static u32 cmpcr;
+
+static void sysctr_timer_enable(bool enable)
+{
+	writel(enable ? cmpcr | SYS_CTR_EN : cmpcr, sys_ctr_base + CMPCR);
+}
+
+static void sysctr_irq_acknowledge(void)
+{
+	/*
+	 * clear the enable bit(EN =0) will clear
+	 * the status bit(ISTAT = 0), then the interrupt
+	 * signal will be negated(acknowledged).
+	 */
+	sysctr_timer_enable(false);
+}
+
+static inline u64 sysctr_read_counter(void)
+{
+	u32 cnt_hi, tmp_hi, cnt_lo;
+
+	do {
+		cnt_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
+		cnt_lo = readl_relaxed(sys_ctr_base + CNTCV_LO);
+		tmp_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
+	} while (tmp_hi != cnt_hi);
+
+	return  ((u64) cnt_hi << 32) | cnt_lo;
+}
+
+static int sysctr_set_next_event(unsigned long delta,
+				 struct clock_event_device *evt)
+{
+	u32 cmp_hi, cmp_lo;
+	u64 next;
+
+	sysctr_timer_enable(false);
+
+	next = sysctr_read_counter();
+
+	next += delta;
+
+	cmp_hi = (next >> 32) & 0x00fffff;
+	cmp_lo = next & 0xffffffff;
+
+	writel_relaxed(cmp_hi, sys_ctr_base + CMPCV_HI);
+	writel_relaxed(cmp_lo, sys_ctr_base + CMPCV_LO);
+
+	sysctr_timer_enable(true);
+
+	return 0;
+}
+
+static int sysctr_set_state_oneshot(struct clock_event_device *evt)
+{
+	return 0;
+}
+
+static int sysctr_set_state_shutdown(struct clock_event_device *evt)
+{
+	sysctr_timer_enable(false);
+
+	return 0;
+}
+
+static irqreturn_t sysctr_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	sysctr_irq_acknowledge();
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct timer_of to_sysctr = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
+	.clkevt = {
+		.name			= "i.MX system counter timer",
+		.features		= CLOCK_EVT_FEAT_ONESHOT |
+						CLOCK_EVT_FEAT_DYNIRQ,
+		.set_state_oneshot	= sysctr_set_state_oneshot,
+		.set_next_event		= sysctr_set_next_event,
+		.set_state_shutdown	= sysctr_set_state_shutdown,
+		.rating			= 200,
+	},
+	.of_irq = {
+		.handler		= sysctr_timer_interrupt,
+		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
+	},
+	.of_clk = {
+		.name = "per",
+	},
+};
+
+static void __init sysctr_clockevent_init(void)
+{
+	to_sysctr.clkevt.cpumask = cpumask_of(0);
+
+	clockevents_config_and_register(&to_sysctr.clkevt,
+					timer_of_rate(&to_sysctr),
+					0xff, 0x7fffffff);
+}
+
+static int __init sysctr_timer_init(struct device_node *np)
+{
+	int ret = 0;
+
+	ret = timer_of_init(np, &to_sysctr);
+	if (ret)
+		return ret;
+
+	sys_ctr_base = timer_of_base(&to_sysctr);
+	cmpcr = readl(sys_ctr_base + CMPCR);
+	cmpcr &= ~SYS_CTR_EN;
+
+	sysctr_clockevent_init();
+
+	return 0;
+}
+TIMER_OF_DECLARE(sysctr_timer, "nxp,sysctr-timer", sysctr_timer_init);
-- 
2.17.1

