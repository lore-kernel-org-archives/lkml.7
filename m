Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4C7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9640021773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNcWoluk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfDXXPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:15:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46824 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfDXXPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:15:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so18440463ljk.13;
        Wed, 24 Apr 2019 16:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=00FuVnKBEH4a7oaUW0d/bzJViPdkkk41NjY8HlXUn0o=;
        b=SNcWoluk9HaqRqPz5suzWiOzBsgH+FEWwvymHg1bmp6sWGcLkCgffaJixz7n98ztAO
         oq9VJ1SD5G7szRy2hjoPyJR3IHna4fqAxN7Epq9MhtlfEJndCoDqI96mK9K0u7bQj0B6
         jZM/Dfh3npIpM9aBMp31yePqtIjN8+svtjI2yOCzIxTIVXdjOKTPU+6j7nywsx7T61ow
         e0NqcqIO7b3KAY0fNnSEy+Lq4kaaTScDLb4dWbGIbqksUa8NJdzBfCiQydpGf4PQssCQ
         ZthtRDtyreH19VDZqyjcSl7yZvyp7qYzWyS68GA92TUHfTWVpw3tnb8RvdroOZpFDrIc
         zbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=00FuVnKBEH4a7oaUW0d/bzJViPdkkk41NjY8HlXUn0o=;
        b=CP0IBbRzxYD/GM9orzRx2z2ANczzcTDMVkr+LYEZncymvMTz3GUssFbCXg+W6PT0+z
         zqS8wwRgjO4vjFCHPBvtuSXslLTHteWJCAImDkl2uBYevjpiAGrTjqLqz3DspB01jGm4
         SrMkIj+13mNnsgzXB+3jmZHtGVy8DMjya0ZjyWyhpkptEiUgK0wZNy2RThKU9okhLNIl
         7WReIndG5cBqj27FdRbXYQawe3jlSDmlFjwiosTPtZspoHKT/0+/NYWZroloS7uhRTNn
         7+bOk6Tx84Vd+NG5+IpZ3SHZMphpcmQGnAlaTiBkpVMT7he0L6zWenh9f7cdiJBv7x49
         Ov9g==
X-Gm-Message-State: APjAAAVmbZwuHnqKa/ROSD4EwR/SLZbtR5xA/Pb4MtxyDoXZtCEZexYl
        KSMQA7WXk3fokRYsOpp6zG0=
X-Google-Smtp-Source: APXvYqxStW7HoBjkLIBiPEmhOJEcaSf6Fc9EIWW1rv/lYQ4YZoRXYJcBGsH/Ew8AGsKuZGY5NcUZfQ==
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr19231179ljg.182.1556147707649;
        Wed, 24 Apr 2019 16:15:07 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j13sm830192lfb.34.2019.04.24.16.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:15:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/7] clocksource/drivers/tegra: Support per-CPU timers on all Tegra's
Date:   Thu, 25 Apr 2019 02:14:38 +0300
Message-Id: <20190424231444.20876-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424231444.20876-1-digetx@gmail.com>
References: <20190424231444.20876-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign TMR1-4 per-CPU core on 32bit Tegra's in a way it is done for
Tegra210. In a result each core can handle its own timer events, less
code is unique to ARM64 and Tegra's clock events driver now has higher
rating on all Tegra's, replacing the ARM's TWD timer which isn't very
accurate due to the clock rate jitter caused by CPU frequency scaling.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 133 ++++++++++++----------------
 1 file changed, 56 insertions(+), 77 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index fdb3d795a409..5a7732055c1f 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -49,13 +49,18 @@
 #define TIMER_PCR_INTR_CLR	BIT(30)
 
 #ifdef CONFIG_ARM
-#define TIMER_CPU0		0x50 /* TIMER3 */
+#define TIMER_CPU0		0x00 /* TIMER1 */
+#define TIMER_CPU2		0x50 /* TIMER3 */
+#define TIMER1_IRQ_IDX		0
+#define IRQ_IDX_FOR_CPU(cpu)	(TIMER1_IRQ_IDX + cpu)
+#define TIMER_BASE_FOR_CPU(cpu)	\
+	(((cpu) & 1) * 8 + ((cpu) < 2 ? TIMER_CPU0 : TIMER_CPU2))
 #else
 #define TIMER_CPU0		0x90 /* TIMER10 */
 #define TIMER10_IRQ_IDX		10
 #define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
-#endif
 #define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)
+#endif
 
 static u32 usec_config;
 static void __iomem *timer_reg_base;
@@ -87,6 +92,16 @@ static int tegra_timer_shutdown(struct clock_event_device *evt)
 	return 0;
 }
 
+static int tegra_timer_set_periodic_fixed_rate(struct clock_event_device *evt)
+{
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	writel(TIMER_PTV_EN | TIMER_PTV_PER | (1000000 / HZ - 1),
+	       reg_base + TIMER_PTV);
+
+	return 0;
+}
+
 static int tegra_timer_set_periodic(struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
@@ -121,7 +136,6 @@ static void tegra_timer_resume(struct clock_event_device *evt)
 	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
 }
 
-#ifdef CONFIG_ARM64
 static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
 	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE,
 
@@ -162,33 +176,8 @@ static int tegra_timer_stop(unsigned int cpu)
 
 	return 0;
 }
-#else /* CONFIG_ARM */
-static struct timer_of tegra_to = {
-	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE | TIMER_OF_IRQ,
-
-	.clkevt = {
-		.name = "tegra_timer",
-		.rating	= 300,
-		.features = CLOCK_EVT_FEAT_ONESHOT |
-			    CLOCK_EVT_FEAT_PERIODIC |
-			    CLOCK_EVT_FEAT_DYNIRQ,
-		.set_next_event	= tegra_timer_set_next_event,
-		.set_state_shutdown = tegra_timer_shutdown,
-		.set_state_periodic = tegra_timer_set_periodic,
-		.set_state_oneshot = tegra_timer_shutdown,
-		.tick_resume = tegra_timer_shutdown,
-		.suspend = tegra_timer_suspend,
-		.resume = tegra_timer_resume,
-		.cpumask = cpu_possible_mask,
-	},
-
-	.of_irq = {
-		.index = 2,
-		.flags = IRQF_TIMER | IRQF_TRIGGER_HIGH,
-		.handler = tegra_timer_isr,
-	},
-};
 
+#ifdef CONFIG_ARM
 static u64 notrace tegra_read_sched_clock(void)
 {
 	return readl(timer_reg_base + TIMERUS_CNTR_1US);
@@ -235,10 +224,12 @@ static void tegra_read_persistent_clock64(struct timespec64 *ts)
 }
 #endif
 
-static int tegra_timer_common_init(struct device_node *np, struct timer_of *to)
+static int tegra_init_timer(struct device_node *np, bool tegra20)
 {
-	int ret = 0;
+	struct timer_of *to;
+	int cpu, ret;
 
+	to = this_cpu_ptr(&tegra_to);
 	ret = timer_of_init(np, to);
 	if (ret < 0)
 		goto out;
@@ -280,29 +271,22 @@ static int tegra_timer_common_init(struct device_node *np, struct timer_of *to)
 		goto out;
 	}
 
-	writel(usec_config, timer_of_base(to) + TIMERUS_USEC_CFG);
-
-out:
-	return ret;
-}
-
-#ifdef CONFIG_ARM64
-static int __init tegra_init_timer(struct device_node *np)
-{
-	int cpu, ret = 0;
-	struct timer_of *to;
-
-	to = this_cpu_ptr(&tegra_to);
-	ret = tegra_timer_common_init(np, to);
-	if (ret < 0)
-		goto out;
+	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
 
 	for_each_possible_cpu(cpu) {
-		struct timer_of *cpu_to;
+		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
+
+		/*
+		 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
+		 * parent clock.
+		 */
+		if (tegra20) {
+			cpu_to->of_clk.rate = 1000000;
+			cpu_to->clkevt.set_state_periodic =
+				tegra_timer_set_periodic_fixed_rate;
+		}
 
-		cpu_to = per_cpu_ptr(&tegra_to, cpu);
 		cpu_to->of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(cpu);
-		cpu_to->of_clk.rate = timer_of_rate(to);
 		cpu_to->clkevt.cpumask = cpumask_of(cpu);
 		cpu_to->clkevt.irq =
 			irq_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
@@ -344,43 +328,39 @@ static int __init tegra_init_timer(struct device_node *np)
 	timer_of_cleanup(to);
 	return ret;
 }
+
+#ifdef CONFIG_ARM64
+static int __init tegra210_init_timer(struct device_node *np)
+{
+	return tegra_init_timer(np, false);
+}
+TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_init_timer);
 #else /* CONFIG_ARM */
-static int __init tegra_init_timer(struct device_node *np)
+static int __init tegra20_init_timer(struct device_node *np)
 {
-	int ret = 0;
+	struct timer_of *to;
+	int err;
 
-	ret = tegra_timer_common_init(np, &tegra_to);
-	if (ret < 0)
-		goto out;
+	err = tegra_init_timer(np, true);
+	if (err < 0)
+		return err;
 
-	tegra_to.of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(0);
-	tegra_to.of_clk.rate = 1000000; /* microsecond timer */
+	to = this_cpu_ptr(&tegra_to);
 
 	sched_clock_register(tegra_read_sched_clock, 32,
-			     timer_of_rate(&tegra_to));
-	ret = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
-				    "timer_us", timer_of_rate(&tegra_to),
+			     timer_of_rate(to));
+	err = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
+				    "timer_us", timer_of_rate(to),
 				    300, 32, clocksource_mmio_readl_up);
-	if (ret) {
-		pr_err("Failed to register clocksource\n");
-		goto out;
-	}
+	if (err)
+		pr_err("Failed to register clocksource: %d\n", err);
 
 	tegra_delay_timer.read_current_timer =
 			tegra_delay_timer_read_counter_long;
-	tegra_delay_timer.freq = timer_of_rate(&tegra_to);
+	tegra_delay_timer.freq = timer_of_rate(to);
 	register_current_timer_delay(&tegra_delay_timer);
 
-	clockevents_config_and_register(&tegra_to.clkevt,
-					timer_of_rate(&tegra_to),
-					0x1,
-					0x1fffffff);
-
-	return ret;
-out:
-	timer_of_cleanup(&tegra_to);
-
-	return ret;
+	return 0;
 }
 
 static int __init tegra20_init_rtc(struct device_node *np)
@@ -406,6 +386,5 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	return register_persistent_clock(tegra_read_persistent_clock64);
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
+TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 #endif
-TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra_init_timer);
-TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra_init_timer);
-- 
2.21.0

