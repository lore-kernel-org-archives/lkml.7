Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DB7C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8501F2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfHSKrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:47:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:57668 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfHSKrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:47:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19F37B0B3;
        Mon, 19 Aug 2019 10:47:39 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/3] watchdog/softlockup: Preserve original timestamp when touching watchdog externally
Date:   Mon, 19 Aug 2019 12:47:30 +0200
Message-Id: <20190819104732.20966-2-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190819104732.20966-1-pmladek@suse.com>
References: <20190819104732.20966-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bug report included the same softlockups in flush_tlb_kernel_range()
in regular intervals. Unfortunately was not clear if there was a progress
or not.

The situation can be simulated with a simply busy loop:

	while (true)
	      cpu_relax();

The softlockup detector produces:

[  168.277520] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
[  196.277604] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
[  236.277522] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [cat:4865]

One would expect only one softlockup report or several reports with
an increased duration.

The problem are touch_*_watchdog() calls spread all over the code. They are
typically used in code producing many printk() messages, for example:

   + touch_softlockup_watchdog() in nmi_trigger_cpumask_backtrace()
   + touch_all_softlockup_watchdogs() in show_state_filter()
   + touch_nmi_watchdog() in printk_stack_address()

One solution would be to remove all these calls. They are actually hiding
information about that the system is not working properly.

On the other hand, the watchdogs are touched in situations when the system
prints information about another problem. It might be confusing to report
softlockups caused by printing the other problem. In the worst situation,
a softlockup report might cause softlockup on its own and livelock.

This patch takes another approach. The softlockup is detected when
softlockup_fn() is not scheduled within the given time threshold.
All the externally called touch_*_watchdog() functions restart
the period that is used to check the threshold.

The result is that each softlockup is reported only once unless
another process get scheduled:

[  320.248948] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4916]

Note that the logic preventing repeated reports is horrible. It will
get removed in a separate patch.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7f9e7b9306fe..bd249676ee3d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -169,7 +169,9 @@ static bool softlockup_initialized __read_mostly;
 static u64 __read_mostly sample_period;
 
 static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
+static DEFINE_PER_CPU(unsigned long, watchdog_period_ts);
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
+static DEFINE_PER_CPU(bool, watchdog_restart_period);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
@@ -254,10 +256,19 @@ static void set_sample_period(void)
 	watchdog_update_hrtimer_threshold(sample_period);
 }
 
+/* Commands for restarting the watchdog period */
+static void __restart_watchdog_period(void)
+{
+	__this_cpu_write(watchdog_period_ts, get_timestamp());
+	__this_cpu_write(watchdog_restart_period, false);
+}
+
 /* Commands for resetting the watchdog */
 static void __touch_watchdog(void)
 {
 	__this_cpu_write(watchdog_touch_ts, get_timestamp());
+	__restart_watchdog_period();
+	__this_cpu_write(soft_watchdog_warn, false);
 }
 
 /**
@@ -271,10 +282,10 @@ static void __touch_watchdog(void)
 notrace void touch_softlockup_watchdog_sched(void)
 {
 	/*
-	 * Preemption can be enabled.  It doesn't matter which CPU's timestamp
-	 * gets zeroed here, so use the raw_ operation.
+	 * Preemption can be enabled.  It doesn't matter which CPU's watchdog
+	 * period gets restarted here, so use the raw_ operation.
 	 */
-	raw_cpu_write(watchdog_touch_ts, 0);
+	raw_cpu_write(watchdog_restart_period, true);
 }
 
 notrace void touch_softlockup_watchdog(void)
@@ -298,23 +309,23 @@ void touch_all_softlockup_watchdogs(void)
 	 * the softlockup check.
 	 */
 	for_each_cpu(cpu, &watchdog_allowed_mask)
-		per_cpu(watchdog_touch_ts, cpu) = 0;
+		per_cpu(watchdog_restart_period, cpu) = true;
 	wq_watchdog_touch(-1);
 }
 
 void touch_softlockup_watchdog_sync(void)
 {
 	__this_cpu_write(softlockup_touch_sync, true);
-	__this_cpu_write(watchdog_touch_ts, 0);
+	__this_cpu_write(watchdog_restart_period, true);
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
@@ -362,6 +373,7 @@ static int softlockup_fn(void *data)
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
 	unsigned long touch_ts = __this_cpu_read(watchdog_touch_ts);
+	unsigned long period_ts = __this_cpu_read(watchdog_period_ts);
 	struct pt_regs *regs = get_irq_regs();
 	int duration;
 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
@@ -383,7 +395,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	/* .. and repeat */
 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
 
-	if (touch_ts == 0) {
+	if (__this_cpu_read(watchdog_restart_period)) {
+		__restart_watchdog_period();
+
 		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
 			/*
 			 * If the time stamp was touched atomically
@@ -395,7 +409,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 
 		/* Clear the guest paused flag on watchdog reset */
 		kvm_check_and_clear_guest_paused();
-		__touch_watchdog();
+
 		return HRTIMER_RESTART;
 	}
 
@@ -405,7 +419,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	 * indicate it is getting cpu time.  If it hasn't then
 	 * this is a good indication some task is hogging the cpu
 	 */
-	duration = is_softlockup(touch_ts);
+	duration = is_softlockup(touch_ts, period_ts);
 	if (unlikely(duration)) {
 		/*
 		 * If a virtual machine is stopped by the host it can look to
@@ -428,7 +442,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			if (__this_cpu_read(softlockup_task_ptr_saved) !=
 			    current) {
 				__this_cpu_write(soft_watchdog_warn, false);
-				__touch_watchdog();
+				__restart_watchdog_period();
 			}
 			return HRTIMER_RESTART;
 		}
@@ -470,8 +484,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
 		__this_cpu_write(soft_watchdog_warn, true);
-	} else
-		__this_cpu_write(soft_watchdog_warn, false);
+	}
 
 	return HRTIMER_RESTART;
 }
-- 
2.16.4

