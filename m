Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CF9CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DE721655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439373AbfJXLtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:49:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:50080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439352AbfJXLtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:49:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06135AD95;
        Thu, 24 Oct 2019 11:49:48 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/3] watchdog/softlockup: Report the overall time of softlockups
Date:   Thu, 24 Oct 2019 13:49:27 +0200
Message-Id: <20191024114928.15377-3-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191024114928.15377-1-pmladek@suse.com>
References: <20191024114928.15377-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The softlockup detector currently shows the time spent since the last
report. As a result it is not clear whether a CPU is infinitely hogged
by a single task or if it is a repeated event.

The situation can be simulated with a simply busy loop:

	while (true)
	      cpu_relax();

The softlockup detector produces:

[  168.277520] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
[  196.277604] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
[  236.277522] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [cat:4865]

But it should be, something like:

[  480.372418] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4943]
[  508.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 52s! [cat:4943]
[  548.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 89s! [cat:4943]
[  576.372351] watchdog: BUG: soft lockup - CPU#2 stuck for 115s! [cat:4943]

For the better output, an additional timestamp, of the last report, must
be stored. And only this timestamp must get reset when the watchdog
is intentionally touched from code paths that are slow for a reason.

Also the timestamp should get reset explicitly. It is done also by the code
printing the backtrace. But it is just a side effect and far from obvious.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b7e2046380cf..1eca651daf59 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -168,7 +168,10 @@ unsigned int __read_mostly softlockup_panic =
 static bool softlockup_initialized __read_mostly;
 static u64 __read_mostly sample_period;
 
+/* Timestamp taken after the last successful reschedule. */
 static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
+/* Timestamp of the last softlockup report period. */
+static DEFINE_PER_CPU(unsigned long, report_period_ts);
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
@@ -253,10 +256,16 @@ static void set_sample_period(void)
 	watchdog_update_hrtimer_threshold(sample_period);
 }
 
+static void reset_report_period_ts(void)
+{
+	__this_cpu_write(report_period_ts, get_timestamp());
+}
+
 /* Commands for resetting the watchdog */
 static void __touch_watchdog(void)
 {
 	__this_cpu_write(watchdog_touch_ts, get_timestamp());
+	reset_report_period_ts();
 }
 
 /**
@@ -270,10 +279,10 @@ static void __touch_watchdog(void)
 notrace void touch_softlockup_watchdog_sched(void)
 {
 	/*
-	 * Preemption can be enabled.  It doesn't matter which CPU's timestamp
-	 * gets zeroed here, so use the raw_ operation.
+	 * Preemption can be enabled.  It doesn't matter which CPU's watchdog
+	 * report period gets restarted here, so use the raw_ operation.
 	 */
-	raw_cpu_write(watchdog_touch_ts, 0);
+	raw_cpu_write(report_period_ts, 0);
 }
 
 notrace void touch_softlockup_watchdog(void)
@@ -297,23 +306,23 @@ void touch_all_softlockup_watchdogs(void)
 	 * the softlockup check.
 	 */
 	for_each_cpu(cpu, &watchdog_allowed_mask)
-		per_cpu(watchdog_touch_ts, cpu) = 0;
+		per_cpu(report_period_ts, cpu) = 0;
 	wq_watchdog_touch(-1);
 }
 
 void touch_softlockup_watchdog_sync(void)
 {
 	__this_cpu_write(softlockup_touch_sync, true);
-	__this_cpu_write(watchdog_touch_ts, 0);
+	__this_cpu_write(report_period_ts, 0);
 }
 
-static int is_softlockup(unsigned long touch_ts)
+static int is_softlockup(unsigned long touch_ts, unsigned long period_ts)
 {
 	unsigned long now = get_timestamp();
 
 	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh){
 		/* Warn about unreasonable delays. */
-		if (time_after(now, touch_ts + get_softlockup_thresh()))
+		if (time_after(now, period_ts + get_softlockup_thresh()))
 			return now - touch_ts;
 	}
 	return 0;
@@ -361,6 +370,7 @@ static int softlockup_fn(void *data)
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
 	unsigned long touch_ts = __this_cpu_read(watchdog_touch_ts);
+	unsigned long period_ts = __this_cpu_read(report_period_ts);
 	struct pt_regs *regs = get_irq_regs();
 	int duration;
 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
@@ -382,7 +392,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	/* .. and repeat */
 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
 
-	if (touch_ts == 0) {
+	/* Was the watchdog touched externally by a known slow code? */
+	if (period_ts == 0) {
 		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
 			/*
 			 * If the time stamp was touched atomically
@@ -394,7 +405,12 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 
 		/* Clear the guest paused flag on watchdog reset */
 		kvm_check_and_clear_guest_paused();
-		__touch_watchdog();
+		/*
+		 * The above kvm*() function could touch the watchdog.
+		 * Set the real timestamp later to avoid an infinite loop.
+		 */
+		reset_report_period_ts();
+
 		return HRTIMER_RESTART;
 	}
 
@@ -404,8 +420,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	 * indicate it is getting cpu time.  If it hasn't then
 	 * this is a good indication some task is hogging the cpu
 	 */
-	duration = is_softlockup(touch_ts);
+	duration = is_softlockup(touch_ts, period_ts);
 	if (unlikely(duration)) {
+		reset_report_period_ts();
 		/*
 		 * If a virtual machine is stopped by the host it can look to
 		 * the watchdog like a soft lockup, check to see if the host
-- 
2.16.4

