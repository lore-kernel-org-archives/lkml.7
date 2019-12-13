Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE087C4BA10
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC7F246B3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YP+aqaGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfLMQZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:25:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37825 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfLMQZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:25:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so59061wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 08:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLT1e2T23rfEKTL040zrZ7HriwO91F/zhgf2KbqmGZA=;
        b=YP+aqaGqwk8OblwomUNyhZfX7wgsgVnp9++7lxasBFocG/7JVdQaVK95BHxTqy2TjT
         mcJgAeycv3ZOPz2NPyRWP5JonYLYwCJZhGD5/Knf2AC5AjVD79kcrG5ihaRNEWCDT1H7
         MD0qN5MDQxmPLvqPKFL8abRQb/ZcrIdHUm5WktlK9qGwXRwUn/+tqG+hww7dkrC1g2vP
         6wqkQt9qiGMBfBO2L1Q3eG7Cev8VzIC2xiZrTE67IF/uxRlzFzoQMd1xDLytIYpkvQTc
         iwQpIqYezz2QQAp/IBb9ZmCxZr+4X/0USe9wZoqyXSKY9fBnTb7J4IW4DuGTf9UqtCp+
         xOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLT1e2T23rfEKTL040zrZ7HriwO91F/zhgf2KbqmGZA=;
        b=bZ2+sANRyI+BEEDJY8CO8dnccLgf+y4FnFFKRo4oZBlv6WsorXHjT1fOwQlOVmTWPR
         cxfXAv17GbL4j2rHdFqkKAPTMSWqZv+d609Bnxo67bbSAYbrUnDnSCKYzwqKiQBZDHGC
         UN1rJl0fNlkRSxNT3QSnMp1qSa3pAry02sjmoCiO0m8MBcFv7NNhgp/27AHhb7IhMqwY
         O4O1IZbdUbMarNDl2aqzrnjsCNl42dtJzKWM0o1cGgGRuXw5He1OcqxX2DYEv+rxP9aj
         TYsB3r3JF3HrNmeEtJVKouKRONrPnI+OZ02TrqZGNaYtexxijvJkpKUqO3pW2GtWkaar
         GvmQ==
X-Gm-Message-State: APjAAAU591H5wB8WLUtgS/OARjg0yyY3lxa7i4YiTS0spxtj3ML9CWqw
        l4bV2CndVVCfa59mzOsdGXLKYQ==
X-Google-Smtp-Source: APXvYqz/bc5f7O+geBQtEzKdNkYnCe8JtWtUTtzOXIzEFLqefwV99wAatK0RvKqCFKLMxKS+aTtt7g==
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr14039823wrw.233.1576254309736;
        Fri, 13 Dec 2019 08:25:09 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:3d17:b245:8f4:3043])
        by smtp.gmail.com with ESMTPSA id h8sm11139330wrx.63.2019.12.13.08.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:25:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/3] ARM: davinci: remove legacy timer support
Date:   Fri, 13 Dec 2019 17:24:53 +0100
Message-Id: <20191213162453.15691-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191213162453.15691-1-brgl@bgdev.pl>
References: <20191213162453.15691-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All platforms have now been switched to the new clocksource driver.
Remove the old code and various no longer needed bits and pieces.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/Makefile              |   3 +-
 arch/arm/mach-davinci/devices-da8xx.c       |   1 -
 arch/arm/mach-davinci/devices.c             |  19 -
 arch/arm/mach-davinci/include/mach/common.h |  17 -
 arch/arm/mach-davinci/include/mach/time.h   |  33 --
 arch/arm/mach-davinci/time.c                | 400 --------------------
 6 files changed, 1 insertion(+), 472 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
 delete mode 100644 arch/arm/mach-davinci/time.c

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index a03d8443ef08..58838a9de651 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -7,8 +7,7 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
 # Common objects
-obj-y 					:= time.o serial.o usb.o \
-					   common.o sram.o
+obj-y 					:= serial.o usb.o common.o sram.o
 
 obj-$(CONFIG_DAVINCI_MUX)		+= mux.o
 
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 2d69e704f7f6..feb206bdf6e1 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -21,7 +21,6 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/time.h>
 
 #include "asp.h"
 #include "cpuidle.h"
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 3e447d468845..d912d62a0eca 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -17,7 +17,6 @@
 #include <mach/hardware.h>
 #include <mach/cputype.h>
 #include <mach/mux.h>
-#include <mach/time.h>
 
 #include "davinci.h"
 #include "irqs.h"
@@ -303,21 +302,3 @@ int davinci_gpio_register(struct resource *res, int size, void *pdata)
 	davinci_gpio_device.dev.platform_data = pdata;
 	return platform_device_register(&davinci_gpio_device);
 }
-
-/*-------------------------------------------------------------------------*/
-
-/*-------------------------------------------------------------------------*/
-
-struct davinci_timer_instance davinci_timer_instance[2] = {
-	{
-		.base		= DAVINCI_TIMER0_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34),
-	},
-	{
-		.base		= DAVINCI_TIMER1_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_TINT1_TINT12),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34),
-	},
-};
-
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 9526e5da0d33..139b83de011d 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -22,22 +22,6 @@
 #define DAVINCI_INTC_START		NR_IRQS
 #define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
 
-void davinci_timer_init(struct clk *clk);
-
-struct davinci_timer_instance {
-	u32		base;
-	u32		bottom_irq;
-	u32		top_irq;
-	unsigned long	cmp_off;
-	unsigned int	cmp_irq;
-};
-
-struct davinci_timer_info {
-	struct davinci_timer_instance	*timers;
-	unsigned int			clockevent_id;
-	unsigned int			clocksource_id;
-};
-
 struct davinci_gpio_controller;
 
 /*
@@ -58,7 +42,6 @@ struct davinci_soc_info {
 	u32				pinmux_base;
 	const struct mux_config		*pinmux_pins;
 	unsigned long			pinmux_pins_num;
-	struct davinci_timer_info	*timer_info;
 	int				gpio_type;
 	u32				gpio_base;
 	unsigned			gpio_num;
diff --git a/arch/arm/mach-davinci/include/mach/time.h b/arch/arm/mach-davinci/include/mach/time.h
deleted file mode 100644
index ba913736990f..000000000000
--- a/arch/arm/mach-davinci/include/mach/time.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * Local header file for DaVinci time code.
- *
- * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef __ARCH_ARM_MACH_DAVINCI_TIME_H
-#define __ARCH_ARM_MACH_DAVINCI_TIME_H
-
-#define DAVINCI_TIMER1_BASE		(IO_PHYS + 0x21800)
-
-enum {
-	T0_BOT,
-	T0_TOP,
-	T1_BOT,
-	T1_TOP,
-	NUM_TIMERS
-};
-
-#define IS_TIMER1(id)		(id & 0x2)
-#define IS_TIMER0(id)		(!IS_TIMER1(id))
-#define IS_TIMER_TOP(id)	((id & 0x1))
-#define IS_TIMER_BOT(id)	(!IS_TIMER_TOP(id))
-
-#define ID_TO_TIMER(id)		(IS_TIMER1(id) != 0)
-
-extern struct davinci_timer_instance davinci_timer_instance[];
-
-#endif /* __ARCH_ARM_MACH_DAVINCI_TIME_H */
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
deleted file mode 100644
index 740410a3bb6a..000000000000
--- a/arch/arm/mach-davinci/time.c
+++ /dev/null
@@ -1,400 +0,0 @@
-/*
- * DaVinci timer subsystem
- *
- * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/sched_clock.h>
-
-#include <asm/mach/irq.h>
-#include <asm/mach/time.h>
-
-#include <mach/cputype.h>
-#include <mach/hardware.h>
-#include <mach/time.h>
-
-static struct clock_event_device clockevent_davinci;
-static unsigned int davinci_clock_tick_rate;
-
-/*
- * This driver configures the 2 64-bit count-up timers as 4 independent
- * 32-bit count-up timers used as follows:
- */
-
-enum {
-	TID_CLOCKEVENT,
-	TID_CLOCKSOURCE,
-};
-
-/* Timer register offsets */
-#define PID12			0x0
-#define TIM12			0x10
-#define TIM34			0x14
-#define PRD12			0x18
-#define PRD34			0x1c
-#define TCR			0x20
-#define TGCR			0x24
-#define WDTCR			0x28
-
-/* Offsets of the 8 compare registers */
-#define	CMP12_0			0x60
-#define	CMP12_1			0x64
-#define	CMP12_2			0x68
-#define	CMP12_3			0x6c
-#define	CMP12_4			0x70
-#define	CMP12_5			0x74
-#define	CMP12_6			0x78
-#define	CMP12_7			0x7c
-
-/* Timer register bitfields */
-#define TCR_ENAMODE_DISABLE          0x0
-#define TCR_ENAMODE_ONESHOT          0x1
-#define TCR_ENAMODE_PERIODIC         0x2
-#define TCR_ENAMODE_MASK             0x3
-
-#define TGCR_TIMMODE_SHIFT           2
-#define TGCR_TIMMODE_64BIT_GP        0x0
-#define TGCR_TIMMODE_32BIT_UNCHAINED 0x1
-#define TGCR_TIMMODE_64BIT_WDOG      0x2
-#define TGCR_TIMMODE_32BIT_CHAINED   0x3
-
-#define TGCR_TIM12RS_SHIFT           0
-#define TGCR_TIM34RS_SHIFT           1
-#define TGCR_RESET                   0x0
-#define TGCR_UNRESET                 0x1
-#define TGCR_RESET_MASK              0x3
-
-struct timer_s {
-	char *name;
-	unsigned int id;
-	unsigned long period;
-	unsigned long opts;
-	unsigned long flags;
-	void __iomem *base;
-	unsigned long tim_off;
-	unsigned long prd_off;
-	unsigned long enamode_shift;
-	struct irqaction irqaction;
-};
-static struct timer_s timers[];
-
-/* values for 'opts' field of struct timer_s */
-#define TIMER_OPTS_DISABLED		0x01
-#define TIMER_OPTS_ONESHOT		0x02
-#define TIMER_OPTS_PERIODIC		0x04
-#define TIMER_OPTS_STATE_MASK		0x07
-
-#define TIMER_OPTS_USE_COMPARE		0x80000000
-#define USING_COMPARE(t)		((t)->opts & TIMER_OPTS_USE_COMPARE)
-
-static char *id_to_name[] = {
-	[T0_BOT]	= "timer0_0",
-	[T0_TOP]	= "timer0_1",
-	[T1_BOT]	= "timer1_0",
-	[T1_TOP]	= "timer1_1",
-};
-
-static int timer32_config(struct timer_s *t)
-{
-	u32 tcr;
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
-
-	if (USING_COMPARE(t)) {
-		struct davinci_timer_instance *dtip =
-				soc_info->timer_info->timers;
-		int event_timer = ID_TO_TIMER(timers[TID_CLOCKEVENT].id);
-
-		/*
-		 * Next interrupt should be the current time reg value plus
-		 * the new period (using 32-bit unsigned addition/wrapping
-		 * to 0 on overflow).  This assumes that the clocksource
-		 * is setup to count to 2^32-1 before wrapping around to 0.
-		 */
-		__raw_writel(__raw_readl(t->base + t->tim_off) + t->period,
-			t->base + dtip[event_timer].cmp_off);
-	} else {
-		tcr = __raw_readl(t->base + TCR);
-
-		/* disable timer */
-		tcr &= ~(TCR_ENAMODE_MASK << t->enamode_shift);
-		__raw_writel(tcr, t->base + TCR);
-
-		/* reset counter to zero, set new period */
-		__raw_writel(0, t->base + t->tim_off);
-		__raw_writel(t->period, t->base + t->prd_off);
-
-		/* Set enable mode */
-		if (t->opts & TIMER_OPTS_ONESHOT)
-			tcr |= TCR_ENAMODE_ONESHOT << t->enamode_shift;
-		else if (t->opts & TIMER_OPTS_PERIODIC)
-			tcr |= TCR_ENAMODE_PERIODIC << t->enamode_shift;
-
-		__raw_writel(tcr, t->base + TCR);
-	}
-	return 0;
-}
-
-static inline u32 timer32_read(struct timer_s *t)
-{
-	return __raw_readl(t->base + t->tim_off);
-}
-
-static irqreturn_t timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = &clockevent_davinci;
-
-	evt->event_handler(evt);
-	return IRQ_HANDLED;
-}
-
-/* called when 32-bit counter wraps */
-static irqreturn_t freerun_interrupt(int irq, void *dev_id)
-{
-	return IRQ_HANDLED;
-}
-
-static struct timer_s timers[] = {
-	[TID_CLOCKEVENT] = {
-		.name      = "clockevent",
-		.opts      = TIMER_OPTS_DISABLED,
-		.irqaction = {
-			.flags   = IRQF_TIMER,
-			.handler = timer_interrupt,
-		}
-	},
-	[TID_CLOCKSOURCE] = {
-		.name       = "free-run counter",
-		.period     = ~0,
-		.opts       = TIMER_OPTS_PERIODIC,
-		.irqaction = {
-			.flags   = IRQF_TIMER,
-			.handler = freerun_interrupt,
-		}
-	},
-};
-
-static void __init timer_init(void)
-{
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
-	struct davinci_timer_instance *dtip = soc_info->timer_info->timers;
-	void __iomem *base[2];
-	int i;
-
-	/* Global init of each 64-bit timer as a whole */
-	for(i=0; i<2; i++) {
-		u32 tgcr;
-
-		base[i] = ioremap(dtip[i].base, SZ_4K);
-		if (WARN_ON(!base[i]))
-			continue;
-
-		/* Disabled, Internal clock source */
-		__raw_writel(0, base[i] + TCR);
-
-		/* reset both timers, no pre-scaler for timer34 */
-		tgcr = 0;
-		__raw_writel(tgcr, base[i] + TGCR);
-
-		/* Set both timers to unchained 32-bit */
-		tgcr = TGCR_TIMMODE_32BIT_UNCHAINED << TGCR_TIMMODE_SHIFT;
-		__raw_writel(tgcr, base[i] + TGCR);
-
-		/* Unreset timers */
-		tgcr |= (TGCR_UNRESET << TGCR_TIM12RS_SHIFT) |
-			(TGCR_UNRESET << TGCR_TIM34RS_SHIFT);
-		__raw_writel(tgcr, base[i] + TGCR);
-
-		/* Init both counters to zero */
-		__raw_writel(0, base[i] + TIM12);
-		__raw_writel(0, base[i] + TIM34);
-	}
-
-	/* Init of each timer as a 32-bit timer */
-	for (i=0; i< ARRAY_SIZE(timers); i++) {
-		struct timer_s *t = &timers[i];
-		int timer = ID_TO_TIMER(t->id);
-		u32 irq;
-
-		t->base = base[timer];
-		if (!t->base)
-			continue;
-
-		if (IS_TIMER_BOT(t->id)) {
-			t->enamode_shift = 6;
-			t->tim_off = TIM12;
-			t->prd_off = PRD12;
-			irq = dtip[timer].bottom_irq;
-		} else {
-			t->enamode_shift = 22;
-			t->tim_off = TIM34;
-			t->prd_off = PRD34;
-			irq = dtip[timer].top_irq;
-		}
-
-		/* Register interrupt */
-		t->irqaction.name = t->name;
-		t->irqaction.dev_id = (void *)t;
-
-		if (t->irqaction.handler != NULL) {
-			irq = USING_COMPARE(t) ? dtip[i].cmp_irq : irq;
-			setup_irq(irq, &t->irqaction);
-		}
-	}
-}
-
-/*
- * clocksource
- */
-static u64 read_cycles(struct clocksource *cs)
-{
-	struct timer_s *t = &timers[TID_CLOCKSOURCE];
-
-	return (cycles_t)timer32_read(t);
-}
-
-static struct clocksource clocksource_davinci = {
-	.rating		= 300,
-	.read		= read_cycles,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-/*
- * Overwrite weak default sched_clock with something more precise
- */
-static u64 notrace davinci_read_sched_clock(void)
-{
-	return timer32_read(&timers[TID_CLOCKSOURCE]);
-}
-
-/*
- * clockevent
- */
-static int davinci_set_next_event(unsigned long cycles,
-				  struct clock_event_device *evt)
-{
-	struct timer_s *t = &timers[TID_CLOCKEVENT];
-
-	t->period = cycles;
-	timer32_config(t);
-	return 0;
-}
-
-static int davinci_shutdown(struct clock_event_device *evt)
-{
-	struct timer_s *t = &timers[TID_CLOCKEVENT];
-
-	t->opts &= ~TIMER_OPTS_STATE_MASK;
-	t->opts |= TIMER_OPTS_DISABLED;
-	return 0;
-}
-
-static int davinci_set_oneshot(struct clock_event_device *evt)
-{
-	struct timer_s *t = &timers[TID_CLOCKEVENT];
-
-	t->opts &= ~TIMER_OPTS_STATE_MASK;
-	t->opts |= TIMER_OPTS_ONESHOT;
-	return 0;
-}
-
-static int davinci_set_periodic(struct clock_event_device *evt)
-{
-	struct timer_s *t = &timers[TID_CLOCKEVENT];
-
-	t->period = davinci_clock_tick_rate / (HZ);
-	t->opts &= ~TIMER_OPTS_STATE_MASK;
-	t->opts |= TIMER_OPTS_PERIODIC;
-	timer32_config(t);
-	return 0;
-}
-
-static struct clock_event_device clockevent_davinci = {
-	.features		= CLOCK_EVT_FEAT_PERIODIC |
-				  CLOCK_EVT_FEAT_ONESHOT,
-	.set_next_event		= davinci_set_next_event,
-	.set_state_shutdown	= davinci_shutdown,
-	.set_state_periodic	= davinci_set_periodic,
-	.set_state_oneshot	= davinci_set_oneshot,
-};
-
-void __init davinci_timer_init(struct clk *timer_clk)
-{
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
-	unsigned int clockevent_id;
-	unsigned int clocksource_id;
-	int i;
-
-	clockevent_id = soc_info->timer_info->clockevent_id;
-	clocksource_id = soc_info->timer_info->clocksource_id;
-
-	timers[TID_CLOCKEVENT].id = clockevent_id;
-	timers[TID_CLOCKSOURCE].id = clocksource_id;
-
-	/*
-	 * If using same timer for both clock events & clocksource,
-	 * a compare register must be used to generate an event interrupt.
-	 * This is equivalent to a oneshot timer only (not periodic).
-	 */
-	if (clockevent_id == clocksource_id) {
-		struct davinci_timer_instance *dtip =
-				soc_info->timer_info->timers;
-		int event_timer = ID_TO_TIMER(clockevent_id);
-
-		/* Only bottom timers can use compare regs */
-		if (IS_TIMER_TOP(clockevent_id))
-			pr_warn("%s: Invalid use of system timers.  Results unpredictable.\n",
-				__func__);
-		else if ((dtip[event_timer].cmp_off == 0)
-				|| (dtip[event_timer].cmp_irq == 0))
-			pr_warn("%s: Invalid timer instance setup.  Results unpredictable.\n",
-				__func__);
-		else {
-			timers[TID_CLOCKEVENT].opts |= TIMER_OPTS_USE_COMPARE;
-			clockevent_davinci.features = CLOCK_EVT_FEAT_ONESHOT;
-		}
-	}
-
-	BUG_ON(IS_ERR(timer_clk));
-	clk_prepare_enable(timer_clk);
-
-	/* init timer hw */
-	timer_init();
-
-	davinci_clock_tick_rate = clk_get_rate(timer_clk);
-
-	/* setup clocksource */
-	clocksource_davinci.name = id_to_name[clocksource_id];
-	if (clocksource_register_hz(&clocksource_davinci,
-				    davinci_clock_tick_rate))
-		pr_err("%s: can't register clocksource!\n",
-		       clocksource_davinci.name);
-
-	sched_clock_register(davinci_read_sched_clock, 32,
-			  davinci_clock_tick_rate);
-
-	/* setup clockevent */
-	clockevent_davinci.name = id_to_name[timers[TID_CLOCKEVENT].id];
-
-	clockevent_davinci.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&clockevent_davinci,
-					davinci_clock_tick_rate, 1, 0xfffffffe);
-
-	for (i=0; i< ARRAY_SIZE(timers); i++)
-		timer32_config(&timers[i]);
-}
-- 
2.23.0

