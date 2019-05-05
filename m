Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06010C04AAB
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 16:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C34206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 16:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmVCSieg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfEEQZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 12:25:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40313 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfEEQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 12:25:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id o16so7474078lfl.7;
        Sun, 05 May 2019 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tpVUDO2/ycyiz3ZOTdaeI/ZMXDWP2S2W90SegzHFcO8=;
        b=VmVCSiegqnIvXiAI4WM1o2MZiEJPN/N1sT8uPw8uwB7Z4vN9ixZyV7fo0QC4qBNHbh
         S0IDiA8kd+3epvuuBCqN+yVI5cdjial4zOvUa9LvA56Fa7CzryIbxQmFMIloDtBL+VJO
         /pgvY91U25IB7/jP/OgbxSpgVcabKHP6QtK7sDqK3glPSjuty1n8zfeHRAb7TELRIsoW
         V7PZGxUWWZmRktDKGJzdHdWhh/5uG3+5/G1lHcGgSgADMhE5KcZuRF/HfN1QAZrmxm7u
         f+jO9gLgI0aIUCWm8UfKnRMUBWcul7MCxwx//gO6uko68U155McuqSOoIXu3SOC0YtO7
         7SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpVUDO2/ycyiz3ZOTdaeI/ZMXDWP2S2W90SegzHFcO8=;
        b=hA5df0hvCBSPXdD+/HKZdqMWjdYEc0f3Ur91a6OIBUH+6V7GmlP6MUr2QtxlDms+VG
         zF+E4LJdgs62HXZowHiqBfLrHWZheq1T33Q+cwQgVEfnbiFSEmbeZ9XDi7Cy7pMtms0m
         h99XJXNo2HITZm1A1BbtYQ9O9E/2CKQ269o4O/Mg5SngMrb+tjg1/qrB6LMt6q0EZXUb
         T12iil4CwNMB8fHJCZ4VBRoe/WTXvmMC3LezXDHKGj5PyCO6f3wBO0png/IRVmq/eVyk
         buL3WUwbtPCkBX87men+dB9OHnZrpVS3jK0slQJTmYe5HWy+ZFUE8RlRspwle9n9uuOU
         Z9Aw==
X-Gm-Message-State: APjAAAXNPUKEx2hOQRW/EWJ+sUnGasJ892uQAF550jCykX6VNNikzOl2
        KhYcJIlC3YrQBjY5kfVNLTk=
X-Google-Smtp-Source: APXvYqyFaztz0dPZl6u0LakoFfmXFJxX+bdXVZi2WhWXStJtrUWogOOakTJ1OT9ODqgs9LBHlccj8A==
X-Received: by 2002:a19:7d42:: with SMTP id y63mr10566126lfc.92.1557073518482;
        Sun, 05 May 2019 09:25:18 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id g13sm1581649lfh.49.2019.05.05.09.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 09:25:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] clocksource/drivers/tegra: Replace readl/writel with relaxed versions
Date:   Sun,  5 May 2019 19:24:33 +0300
Message-Id: <20190505162436.23125-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505162436.23125-1-digetx@gmail.com>
References: <20190505162436.23125-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The readl/writel functions are inserting memory barrier to ensure that
outstanding memory writes are completed, this results in L2 cache syncing
being done on Tegra20 and Tegra30 which isn't a very cheap operation.
Replace all readl/writel occurrences in the code with the relaxed versions
since there is no need for the memory-access syncing.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 35 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index b7d1e6221348..cdac9e240714 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -61,9 +61,9 @@ static int tegra_timer_set_next_event(unsigned long cycles,
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(TIMER_PTV_EN |
-	       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
-	       reg_base + TIMER_PTV);
+	writel_relaxed(TIMER_PTV_EN |
+		       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
+		       reg_base + TIMER_PTV);
 
 	return 0;
 }
@@ -72,7 +72,7 @@ static int tegra_timer_shutdown(struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(0, reg_base + TIMER_PTV);
+	writel_relaxed(0, reg_base + TIMER_PTV);
 
 	return 0;
 }
@@ -81,9 +81,9 @@ static int tegra_timer_set_periodic(struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(TIMER_PTV_EN | TIMER_PTV_PER |
-	       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
-	       reg_base + TIMER_PTV);
+	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER |
+		       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
+		       reg_base + TIMER_PTV);
 
 	return 0;
 }
@@ -93,7 +93,7 @@ static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
 	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+	writel_relaxed(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
@@ -103,12 +103,12 @@ static void tegra_timer_suspend(struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+	writel_relaxed(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
 }
 
 static void tegra_timer_resume(struct clock_event_device *evt)
 {
-	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
+	writel_relaxed(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
 }
 
 static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
@@ -132,8 +132,8 @@ static int tegra_timer_setup(unsigned int cpu)
 {
 	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
 
-	writel(0, timer_of_base(to) + TIMER_PTV);
-	writel(TIMER_PCR_INTR_CLR, timer_of_base(to) + TIMER_PCR);
+	writel_relaxed(0, timer_of_base(to) + TIMER_PTV);
+	writel_relaxed(TIMER_PCR_INTR_CLR, timer_of_base(to) + TIMER_PCR);
 
 	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
 	enable_irq(to->clkevt.irq);
@@ -157,12 +157,12 @@ static int tegra_timer_stop(unsigned int cpu)
 
 static u64 notrace tegra_read_sched_clock(void)
 {
-	return readl(timer_reg_base + TIMERUS_CNTR_1US);
+	return readl_relaxed(timer_reg_base + TIMERUS_CNTR_1US);
 }
 
 static unsigned long tegra_delay_timer_read_counter_long(void)
 {
-	return readl(timer_reg_base + TIMERUS_CNTR_1US);
+	return readl_relaxed(timer_reg_base + TIMERUS_CNTR_1US);
 }
 
 static struct delay_timer tegra_delay_timer = {
@@ -182,8 +182,9 @@ static struct timer_of suspend_rtc_to = {
  */
 static u64 tegra_rtc_read_ms(struct clocksource *cs)
 {
-	u32 ms = readl(timer_of_base(&suspend_rtc_to) + RTC_MILLISECONDS);
-	u32 s = readl(timer_of_base(&suspend_rtc_to) + RTC_SHADOW_SECONDS);
+	void __iomem *reg_base = timer_of_base(&suspend_rtc_to);
+	u32 ms = readl_relaxed(reg_base + RTC_MILLISECONDS);
+	u32 s = readl_relaxed(reg_base + RTC_SHADOW_SECONDS);
 	return (u64)s * MSEC_PER_SEC + ms;
 }
 
@@ -268,7 +269,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 		goto out;
 	}
 
-	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
+	writel_relaxed(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
 
 	for_each_possible_cpu(cpu) {
 		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
-- 
2.21.0

