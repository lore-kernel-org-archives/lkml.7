Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73678C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DBC20679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfFWN1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:27:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33495 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfFWN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:48 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X4-0001kr-6V; Sun, 23 Jun 2019 15:27:46 +0200
Message-Id: <20190623132435.637420368@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:57 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [patch 17/29] x86/hpet: Coding style cleanup
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -131,26 +131,33 @@ EXPORT_SYMBOL_GPL(is_hpet_enabled);
 
 static void _hpet_print_config(const char *function, int line)
 {
-	u32 i, timers, l, h;
+	u32 i, id, period, cfg, status, channels, l, h;
+
 	pr_info("%s(%d):\n", function, line);
-	l = hpet_readl(HPET_ID);
-	h = hpet_readl(HPET_PERIOD);
-	timers = ((l & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
-	pr_info("ID: 0x%x, PERIOD: 0x%x\n", l, h);
-	l = hpet_readl(HPET_CFG);
-	h = hpet_readl(HPET_STATUS);
-	pr_info("CFG: 0x%x, STATUS: 0x%x\n", l, h);
+
+	id = hpet_readl(HPET_ID);
+	period = hpet_readl(HPET_PERIOD);
+	pr_info("ID: 0x%x, PERIOD: 0x%x\n", id, period);
+
+	cfg = hpet_readl(HPET_CFG);
+	status = hpet_readl(HPET_STATUS);
+	pr_info("CFG: 0x%x, STATUS: 0x%x\n", cfg, status);
+
 	l = hpet_readl(HPET_COUNTER);
 	h = hpet_readl(HPET_COUNTER+4);
 	pr_info("COUNTER_l: 0x%x, COUNTER_h: 0x%x\n", l, h);
 
-	for (i = 0; i < timers; i++) {
+	channels = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
+
+	for (i = 0; i < channels; i++) {
 		l = hpet_readl(HPET_Tn_CFG(i));
 		h = hpet_readl(HPET_Tn_CFG(i)+4);
 		pr_info("T%d: CFG_l: 0x%x, CFG_h: 0x%x\n", i, l, h);
+
 		l = hpet_readl(HPET_Tn_CMP(i));
 		h = hpet_readl(HPET_Tn_CMP(i)+4);
 		pr_info("T%d: CMP_l: 0x%x, CMP_h: 0x%x\n", i, l, h);
+
 		l = hpet_readl(HPET_Tn_ROUTE(i));
 		h = hpet_readl(HPET_Tn_ROUTE(i)+4);
 		pr_info("T%d ROUTE_l: 0x%x, ROUTE_h: 0x%x\n", i, l, h);
@@ -216,6 +223,7 @@ static void hpet_reserve_platform_timers
 static void hpet_stop_counter(void)
 {
 	u32 cfg = hpet_readl(HPET_CFG);
+
 	cfg &= ~HPET_CFG_ENABLE;
 	hpet_writel(cfg, HPET_CFG);
 }
@@ -229,6 +237,7 @@ static void hpet_reset_counter(void)
 static void hpet_start_counter(void)
 {
 	unsigned int cfg = hpet_readl(HPET_CFG);
+
 	cfg |= HPET_CFG_ENABLE;
 	hpet_writel(cfg, HPET_CFG);
 }
@@ -393,7 +402,7 @@ static int hpet_legacy_resume(struct clo
 }
 
 static int hpet_legacy_next_event(unsigned long delta,
-			struct clock_event_device *evt)
+				  struct clock_event_device *evt)
 {
 	return hpet_next_event(delta, 0);
 }
@@ -1142,6 +1151,7 @@ EXPORT_SYMBOL_GPL(hpet_rtc_timer_init);
 static void hpet_disable_rtc_channel(void)
 {
 	u32 cfg = hpet_readl(HPET_T1_CFG);
+
 	cfg &= ~HPET_TN_ENABLE;
 	hpet_writel(cfg, HPET_T1_CFG);
 }
@@ -1183,8 +1193,7 @@ int hpet_set_rtc_irq_bit(unsigned long b
 }
 EXPORT_SYMBOL_GPL(hpet_set_rtc_irq_bit);
 
-int hpet_set_alarm_time(unsigned char hrs, unsigned char min,
-			unsigned char sec)
+int hpet_set_alarm_time(unsigned char hrs, unsigned char min, unsigned char sec)
 {
 	if (!is_hpet_enabled())
 		return 0;
@@ -1204,15 +1213,16 @@ int hpet_set_periodic_freq(unsigned long
 	if (!is_hpet_enabled())
 		return 0;
 
-	if (freq <= DEFAULT_RTC_INT_FREQ)
+	if (freq <= DEFAULT_RTC_INT_FREQ) {
 		hpet_pie_limit = DEFAULT_RTC_INT_FREQ / freq;
-	else {
+	} else {
 		clc = (uint64_t) hpet_clockevent.mult * NSEC_PER_SEC;
 		do_div(clc, freq);
 		clc >>= hpet_clockevent.shift;
 		hpet_pie_delta = clc;
 		hpet_pie_limit = 0;
 	}
+
 	return 1;
 }
 EXPORT_SYMBOL_GPL(hpet_set_periodic_freq);
@@ -1272,8 +1282,7 @@ irqreturn_t hpet_rtc_interrupt(int irq,
 		hpet_prev_update_sec = curr_time.tm_sec;
 	}
 
-	if (hpet_rtc_flags & RTC_PIE &&
-	    ++hpet_pie_count >= hpet_pie_limit) {
+	if (hpet_rtc_flags & RTC_PIE && ++hpet_pie_count >= hpet_pie_limit) {
 		rtc_int_flag |= RTC_PF;
 		hpet_pie_count = 0;
 	}
@@ -1282,7 +1291,7 @@ irqreturn_t hpet_rtc_interrupt(int irq,
 	    (curr_time.tm_sec == hpet_alarm_time.tm_sec) &&
 	    (curr_time.tm_min == hpet_alarm_time.tm_min) &&
 	    (curr_time.tm_hour == hpet_alarm_time.tm_hour))
-			rtc_int_flag |= RTC_AF;
+		rtc_int_flag |= RTC_AF;
 
 	if (rtc_int_flag) {
 		rtc_int_flag |= (RTC_IRQF | (RTC_NUM_INTS << 8));


