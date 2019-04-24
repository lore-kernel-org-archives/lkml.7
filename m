Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308A7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80E421773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9iGqKQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfDXXPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:15:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41362 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfDXXPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:15:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so16001497lfd.8;
        Wed, 24 Apr 2019 16:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SkytVJh9nqGGNEFP4wT2QVEgaWnaNXHWHkmE/CaufGQ=;
        b=a9iGqKQjGJUZ1hBJzAeoUjR/qjQVXvr68+tGaFonETGYHlbKYdHyph3Z4y3nIGGtiH
         WwJwBT5mZiGL5PL0qnhnn6+FntKa9MNWGOmDHCPVNEC8HfoGSFrUylv0A/qxY3Zab9tO
         Hasrm0QU1YR/7mPUK4FiWhBgfDPicsrZEAeXvk3UbBuIjt4zXlYVVEtBZJ043khYVl1K
         0SQ0MwwVUz0fjCuUbqqCbzdpCwh0pR736iffHguWXgPmQ6VAJNEgyppLmYlqzEeBfSbA
         A/fOjUfdeM96WzvyOdCC4acX59VYOhOjEHoHy3gaoo5eHZjVDbu+l9P8v2vawSIIxqum
         qkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SkytVJh9nqGGNEFP4wT2QVEgaWnaNXHWHkmE/CaufGQ=;
        b=r/t+wefDdWPnFZKeGoF4VM3jlBo4l70q/hO1wq+8QUjbDtrg9AZS9PD38gluniKIkm
         3NipLUj5fNWBu7z9ZdGCf25nUebGYGJFr/W5uHm/qR6T0YEXjOiePN1TXPP/krC2nc1b
         YZjOeotT1rnTGosxoBQIYeauG1hxl6luT7NmxYA75QSK9rzfLqLTT5Ch8rTVMcorsVxD
         JU7H/nl7/5leNOgGHA7mqNgIngjWB44uBRnF8y+nBxLshlKkFRiITwe6NNJFP9KqVllV
         xQd41hYKY/HTk+3WtpXYyQzNZ04X98IXW3A11Fkxad6LMsqE4KSL960CoOGicKUXtqS5
         uI3A==
X-Gm-Message-State: APjAAAXRNy4kGnlOdv/+sctpGZHphF3p3pVHQAQZfQg5C6evjf5fyjNu
        N2lBqdOeCy2UJDpjo182Uv4=
X-Google-Smtp-Source: APXvYqy5tdnHF8Zp3Rguo4shxZ6p6zdbHNsb0/eI33sqUMdBmX1I+fsUj/O2oSdzQ78lXgDP8VFFsA==
X-Received: by 2002:ac2:538a:: with SMTP id g10mr9714029lfh.141.1556147711558;
        Wed, 24 Apr 2019 16:15:11 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j13sm830192lfb.34.2019.04.24.16.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:15:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/7] clocksource/drivers/tegra: Replace readl/writel with relaxed versions
Date:   Thu, 25 Apr 2019 02:14:41 +0300
Message-Id: <20190424231444.20876-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424231444.20876-1-digetx@gmail.com>
References: <20190424231444.20876-1-digetx@gmail.com>
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
 drivers/clocksource/timer-tegra20.c | 38 ++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 01d713f20a85..d171a214f066 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -64,9 +64,9 @@ static int tegra_timer_set_next_event(unsigned long cycles,
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
@@ -75,7 +75,7 @@ static int tegra_timer_shutdown(struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(0, reg_base + TIMER_PTV);
+	writel_relaxed(0, reg_base + TIMER_PTV);
 
 	return 0;
 }
@@ -84,8 +84,8 @@ static int tegra_timer_set_periodic_fixed_rate(struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(TIMER_PTV_EN | TIMER_PTV_PER | (1000000 / HZ - 1),
-	       reg_base + TIMER_PTV);
+	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER | (1000000 / HZ - 1),
+		       reg_base + TIMER_PTV);
 
 	return 0;
 }
@@ -94,9 +94,9 @@ static int tegra_timer_set_periodic(struct clock_event_device *evt)
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
@@ -106,7 +106,7 @@ static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
 	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+	writel_relaxed(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
@@ -116,12 +116,12 @@ static void tegra_timer_suspend(struct clock_event_device *evt)
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
@@ -145,8 +145,8 @@ static int tegra_timer_setup(unsigned int cpu)
 {
 	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
 
-	writel(0, timer_of_base(to) + TIMER_PTV);
-	writel(TIMER_PCR_INTR_CLR, timer_of_base(to) + TIMER_PCR);
+	writel_relaxed(0, timer_of_base(to) + TIMER_PTV);
+	writel_relaxed(TIMER_PCR_INTR_CLR, timer_of_base(to) + TIMER_PCR);
 
 	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
 	enable_irq(to->clkevt.irq);
@@ -170,12 +170,12 @@ static int tegra_timer_stop(unsigned int cpu)
 
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
@@ -191,8 +191,8 @@ static struct delay_timer tegra_delay_timer = {
  */
 static u64 tegra_rtc_read_ms(void)
 {
-	u32 ms = readl(rtc_base + RTC_MILLISECONDS);
-	u32 s = readl(rtc_base + RTC_SHADOW_SECONDS);
+	u32 ms = readl_relaxed(rtc_base + RTC_MILLISECONDS);
+	u32 s = readl_relaxed(rtc_base + RTC_SHADOW_SECONDS);
 	return (u64)s * MSEC_PER_SEC + ms;
 }
 
@@ -291,7 +291,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 		goto out;
 	}
 
-	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
+	writel_relaxed(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
 
 	for_each_possible_cpu(cpu) {
 		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
-- 
2.21.0

