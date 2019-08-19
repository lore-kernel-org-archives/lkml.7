Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C967CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E162070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfHSPqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:46:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47797 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfHSPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:54 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqx-00071Q-Jx; Mon, 19 Aug 2019 17:45:51 +0200
Message-Id: <20190819143804.931754993@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:18 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 37/44] posix-cpu-timers: Consolidate timer expiry further
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the array based samples and expiry cache, the expiry function can use
a loop to collect timers from the clock specific lists.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   48 +++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -746,6 +746,17 @@ check_timers_list(struct list_head *time
 	return U64_MAX;
 }
 
+static void collect_posix_cputimers(struct posix_cputimers *pct,
+				    u64 *samples, struct list_head *firing)
+{
+	struct list_head *timers = pct->cpu_timers;
+	u64 *expiries = pct->expiries;
+	int i;
+
+	for (i = 0; i < CPUCLOCK_MAX; i++, timers++)
+		expiries[i] = check_timers_list(timers, firing, samples[i]);
+}
+
 static inline void check_dl_overrun(struct task_struct *tsk)
 {
 	if (tsk->dl.dl_overrun) {
@@ -762,21 +773,18 @@ static inline void check_dl_overrun(stru
 static void check_thread_timers(struct task_struct *tsk,
 				struct list_head *firing)
 {
-	struct list_head *timers = tsk->posix_cputimers.cpu_timers;
-	u64 stime, utime, *expires = tsk->posix_cputimers.expiries;
+	struct posix_cputimers *pct = &tsk->posix_cputimers;
+	u64 samples[CPUCLOCK_MAX];
 	unsigned long soft;
 
 	if (dl_task(tsk))
 		check_dl_overrun(tsk);
 
-	if (expiry_cache_is_inactive(tsk->posix_cputimers.expiries))
+	if (expiry_cache_is_inactive(pct->expiries))
 		return;
 
-	task_cputime(tsk, &utime, &stime);
-
-	*expires++ = check_timers_list(timers, firing, utime + stime);
-	*expires++ = check_timers_list(++timers, firing, utime);
-	*expires = check_timers_list(++timers, firing, tsk->se.sum_exec_runtime);
+	task_sample_cputime(tsk, samples);
+	collect_posix_cputimers(pct, samples, firing);
 
 	/*
 	 * Check for the special case thread timers.
@@ -815,7 +823,7 @@ static void check_thread_timers(struct t
 		}
 	}
 
-	if (expiry_cache_is_inactive(tsk->posix_cputimers.expiries))
+	if (expiry_cache_is_inactive(pct->expiries))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -859,15 +867,15 @@ static void check_process_timers(struct
 				 struct list_head *firing)
 {
 	struct signal_struct *const sig = tsk->signal;
-	struct list_head *timers = sig->posix_cputimers.cpu_timers;
-	u64 virt_exp, prof_exp, sched_exp, samples[CPUCLOCK_MAX];
+	struct posix_cputimers *pct = &sig->posix_cputimers;
+	u64 samples[CPUCLOCK_MAX], *exp = pct->expiries;
 	unsigned long soft;
 
 	/*
 	 * If cputimer is not running, then there are no active
 	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).
 	 */
-	if (!READ_ONCE(tsk->signal->cputimer.running))
+	if (!READ_ONCE(sig->cputimer.running))
 		return;
 
        /*
@@ -881,17 +889,14 @@ static void check_process_timers(struct
 	 * so the sample can be taken directly.
 	 */
 	proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic, samples);
-
-	prof_exp = check_timers_list(timers, firing, samples[CPUCLOCK_PROF]);
-	virt_exp = check_timers_list(++timers, firing, samples[CPUCLOCK_VIRT]);
-	sched_exp = check_timers_list(++timers, firing, samples[CPUCLOCK_SCHED]);
+	collect_posix_cputimers(pct, samples, firing);
 
 	/*
 	 * Check for the special case process timers.
 	 */
-	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_PROF], &prof_exp,
+	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_PROF], &exp[CPUCLOCK_PROF],
 			 samples[CPUCLOCK_PROF], SIGPROF);
-	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_VIRT], &virt_exp,
+	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_VIRT], &exp[CPUCLOCK_VIRT],
 			 samples[CPUCLOCK_VIRT], SIGVTALRM);
 
 	soft = task_rlimit(tsk, RLIMIT_CPU);
@@ -927,13 +932,10 @@ static void check_process_timers(struct
 			}
 		}
 		softns = soft * NSEC_PER_SEC;
-		if (softns < prof_exp)
-			prof_exp = softns;
+		if (softns < exp[CPUCLOCK_PROF])
+			exp[CPUCLOCK_PROF] = softns;
 	}
 
-	store_samples(sig->posix_cputimers.expiries, prof_exp, virt_exp,
-		      sched_exp);
-
 	if (expiry_cache_is_inactive(sig->posix_cputimers.expiries))
 		stop_process_timers(sig);
 


