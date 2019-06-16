Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F04C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 11:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD22D216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 11:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfFPLdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 07:33:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfFPLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 07:33:05 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcTPD-0008No-Lr; Sun, 16 Jun 2019 13:33:03 +0200
Date:   Sun, 16 Jun 2019 11:29:52 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timer fixes for 5.2
References: <156068459205.30217.15980952927216488865.tglx@nanos.tec.linutronix.de>
Message-ID: <156068459205.30217.17659593879245974125.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

up to:  e3ff9c3678b4: timekeeping: Repair ktime_get_coarse*() granularity

A set of small fixes:

 - Repair the ktime_get_coarse() functions so they actually deliver what
   they are supposed to: tick granular time stamps. The current code missed
   to add the accumulated nanoseconds part of the timekeeper so the
   resulting granularity was 1 second.

 - Prevent the tracer from infinitely recursing into time getter functions
   in the arm architectured timer by marking these functions notrace

 - Fix a trivial compiler warning caused by wrong qualifier ordering.

Thanks,

	tglx

------------------>
Julien Thierry (1):
      clocksource/drivers/arm_arch_timer: Don't trace count reader functions

Philippe Mazenauer (1):
      clocksource/drivers/timer-ti-dm: Change to new style declaration

Thomas Gleixner (1):
      timekeeping: Repair ktime_get_coarse*() granularity


 drivers/clocksource/arm_arch_timer.c | 8 ++++----
 drivers/clocksource/timer-ti-dm.c    | 2 +-
 kernel/time/timekeeping.c            | 5 +++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index b2a951a798e2..5c69c9a9a6a4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -149,22 +149,22 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 	return val;
 }
 
-static u64 arch_counter_get_cntpct_stable(void)
+static notrace u64 arch_counter_get_cntpct_stable(void)
 {
 	return __arch_counter_get_cntpct_stable();
 }
 
-static u64 arch_counter_get_cntpct(void)
+static notrace u64 arch_counter_get_cntpct(void)
 {
 	return __arch_counter_get_cntpct();
 }
 
-static u64 arch_counter_get_cntvct_stable(void)
+static notrace u64 arch_counter_get_cntvct_stable(void)
 {
 	return __arch_counter_get_cntvct_stable();
 }
 
-static u64 arch_counter_get_cntvct(void)
+static notrace u64 arch_counter_get_cntvct(void)
 {
 	return __arch_counter_get_cntvct();
 }
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index e40b55a7086f..5394d9dbdfbc 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -896,7 +896,7 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 	return ret;
 }
 
-const static struct omap_dm_timer_ops dmtimer_ops = {
+static const struct omap_dm_timer_ops dmtimer_ops = {
 	.request_by_node = omap_dm_timer_request_by_node,
 	.request_specific = omap_dm_timer_request_specific,
 	.request = omap_dm_timer_request,
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 85f5912d8f70..44b726bab4bd 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -808,17 +808,18 @@ ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned int seq;
 	ktime_t base, *offset = offsets[offs];
+	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 		base = ktime_add(tk->tkr_mono.base, *offset);
+		nsecs = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	return base;
-
+	return base + nsecs;
 }
 EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
 

