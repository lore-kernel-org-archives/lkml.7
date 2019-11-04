Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241D1CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8184222C1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNkPRKZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfKDOXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:23:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46758 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfKDOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:23:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id b3so11530184wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8PT3lzS5kgHvAaeJFeb5r3uf3YM7EgRuHSrYbt0bMFk=;
        b=SNkPRKZdYBvp+Jra5t5LVndKlS22wZNjS01AGgztYnVuSJdig02jSagBkDkPSGJ3VQ
         ieOLceDMwHWW6D8zYvxX80WnD/5CvAxzIXlxzrEZhA3ro4g6pGdTlJd6OJKGKGgLKQp9
         VOPN3p4Czyv3Hva2rnNNsdqX516gIliU3ABxR6gHWjc/PI/NqupKLqBmAcQN+tjFzUiH
         4ogMDxNFwHSAMDUCnYGafFEsnSlBIoabg41lMHjv/bI1McdsYdrooFSsshoqqOIpAoIk
         q2isgyU4wGAERUP78PrK1GwIbL8mBzYAUabQKZKzf8RrbbK4ccq2ZZq0X2sjj64zkwzk
         aF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8PT3lzS5kgHvAaeJFeb5r3uf3YM7EgRuHSrYbt0bMFk=;
        b=lKHuqLOcRF4mYrEXFYjB64V7HA/zQ+CuGurUq8XFq1J6ult8FRrsnLVSdLdMamt821
         sborq9aAeQNLDsYL33KswN+IGuQQZbYC0slK7WMCKEAFdbM/5lK5JbYNqqDw+o8Otcs3
         QyXhE+ng1v6voXDVX7sb4HBtvKUTJ4de8qhDCxkb+JDteFi038ppF/r/9N/lR6ton63z
         PZm9uWjzUWXezKOy+uPqwd+kmm74nZR9qcCEt2lSp/wrot3N3tLMEdxbhlk1cxBvdZXI
         aXgwF1KgDrmGtyGtWOutsKMf8TUxMTphLF5CEeAu6Rn68bPyyvw/+R4Vj3U/XY77I9t/
         3JEQ==
X-Gm-Message-State: APjAAAUatDyAE/QNfdKgUIZ3J9GbPsKpvbGAF4wOuiwacTlWszGofyE9
        Fb052gWqrmyHQvEdZFgPtBnntw==
X-Google-Smtp-Source: APXvYqw9heJyuT88QXFmWV6rLfXGXLrq0AsYBrPzlbFXhj2lixT9fLCy+Fb21pC6Q75L5eIpuzEfnw==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr10060725wrn.377.1572877393588;
        Mon, 04 Nov 2019 06:23:13 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:58da:b044:f184:d281])
        by smtp.gmail.com with ESMTPSA id l18sm21692446wrn.48.2019.11.04.06.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 06:23:12 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE)
Subject: [PATCH 3/5] clocksource/drivers/renesas-ostm: Convert to timer_of
Date:   Mon,  4 Nov 2019 15:22:55 +0100
Message-Id: <20191104142257.30029-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104142257.30029-1-daniel.lezcano@linaro.org>
References: <6fd4d800-b1f8-d757-458e-23742d20884c@linaro.org>
 <20191104142257.30029-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Convert the Renesas OSTM driver to use the timer_of framework.
This reduces the driver object size by 367 bytes (with gcc 7.4.0).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191016144747.29538-4-geert+renesas@glider.be
---
 drivers/clocksource/Kconfig        |   1 +
 drivers/clocksource/renesas-ostm.c | 189 +++++++++++------------------
 2 files changed, 73 insertions(+), 117 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f35a53ce8988..5fdd76cb1768 100644
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
index 37c39b901bb1..46012d905604 100644
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
-- 
2.17.1

