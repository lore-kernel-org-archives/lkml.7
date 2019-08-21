Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13DDC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF6520679
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfHUTbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:31:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57346 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbfHUTbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:11 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WK4-0004GU-MX; Wed, 21 Aug 2019 21:31:08 +0200
Message-Id: <20190821192922.365469982@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:20 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 33/38] posix-cpu-timers: Consolidate timer expiry further
References: <20190821190847.665673890@linutronix.de>
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
V2: Adopt to the per clock base struct
---
 kernel/time/posix-cpu-timers.c |   63 +++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -752,6 +752,18 @@ check_timers_list(struct list_head *time
 	return U64_MAX;
 }
 
+static void collect_posix_cputimers(struct posix_cputimers *pct,
+				    u64 *samples, struct list_head *firing)
+{
+	struct posix_cputimer_base *base = pct->bases;
+	int i;
+
+	for (i = 0; i < CPUCLOCK_MAX; i++, base++) {
+		base->nextevt = check_timers_list(&base->cpu_timers, firing,
+						   samples[i]);
+	}
+}
+
 static inline void check_dl_overrun(struct task_struct *tsk)
 {
 	if (tsk->dl.dl_overrun) {
@@ -768,25 +780,18 @@ static inline void check_dl_overrun(stru
 static void check_thread_timers(struct task_struct *tsk,
 				struct list_head *firing)
 {
-	struct posix_cputimer_base *base = tsk->posix_cputimers.bases;
+	struct posix_cputimers *pct = &tsk->posix_cputimers;
+	u64 samples[CPUCLOCK_MAX];
 	unsigned long soft;
-	u64 stime, utime;
 
 	if (dl_task(tsk))
 		check_dl_overrun(tsk);
 
-	if (expiry_cache_is_inactive(&tsk->posix_cputimers))
+	if (expiry_cache_is_inactive(pct))
 		return;
 
-	task_cputime(tsk, &utime, &stime);
-
-	base->nextevt = check_timers_list(&base->cpu_timers, firing,
-					  utime + stime);
-	base++;
-	base->nextevt = check_timers_list(&base->cpu_timers, firing, utime);
-	base++;
-	base->nextevt = check_timers_list(&base->cpu_timers, firing,
-					  tsk->se.sum_exec_runtime);
+	task_sample_cputime(tsk, samples);
+	collect_posix_cputimers(pct, samples, firing);
 
 	/*
 	 * Check for the special case thread timers.
@@ -825,7 +830,7 @@ static void check_thread_timers(struct t
 		}
 	}
 
-	if (expiry_cache_is_inactive(&tsk->posix_cputimers))
+	if (expiry_cache_is_inactive(pct))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -869,15 +874,15 @@ static void check_process_timers(struct
 				 struct list_head *firing)
 {
 	struct signal_struct *const sig = tsk->signal;
-	struct posix_cputimer_base *base = sig->posix_cputimers.bases;
-	u64 virt_exp, prof_exp, sched_exp, samples[CPUCLOCK_MAX];
+	struct posix_cputimers *pct = &sig->posix_cputimers;
+	u64 samples[CPUCLOCK_MAX];
 	unsigned long soft;
 
 	/*
 	 * If cputimer is not running, then there are no active
 	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).
 	 */
-	if (!READ_ONCE(tsk->signal->cputimer.running))
+	if (!READ_ONCE(sig->cputimer.running))
 		return;
 
        /*
@@ -891,21 +896,17 @@ static void check_process_timers(struct
 	 * so the sample can be taken directly.
 	 */
 	proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic, samples);
-
-	prof_exp = check_timers_list(&base[CPUCLOCK_PROF].cpu_timers,
-				     firing, samples[CPUCLOCK_PROF]);
-	virt_exp = check_timers_list(&base[CPUCLOCK_VIRT].cpu_timers,
-				     firing, samples[CPUCLOCK_VIRT]);
-	sched_exp = check_timers_list(&base[CPUCLOCK_SCHED].cpu_timers,
-				      firing, samples[CPUCLOCK_SCHED]);
+	collect_posix_cputimers(pct, samples, firing);
 
 	/*
 	 * Check for the special case process timers.
 	 */
-	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_PROF], &prof_exp,
+	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_PROF],
+			 &pct->bases[CPUCLOCK_PROF].nextevt,
 			 samples[CPUCLOCK_PROF], SIGPROF);
-	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_VIRT], &virt_exp,
-			 samples[CPUCLOCK_PROF], SIGVTALRM);
+	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_VIRT],
+			 &pct->bases[CPUCLOCK_VIRT].nextevt,
+			 samples[CPUCLOCK_VIRT], SIGVTALRM);
 
 	soft = task_rlimit(tsk, RLIMIT_CPU);
 	if (soft != RLIM_INFINITY) {
@@ -940,15 +941,11 @@ static void check_process_timers(struct
 			}
 		}
 		softns = soft * NSEC_PER_SEC;
-		if (softns < prof_exp)
-			prof_exp = softns;
+		if (softns < pct->bases[CPUCLOCK_PROF].nextevt)
+			pct->bases[CPUCLOCK_PROF].nextevt = softns;
 	}
 
-	base[CPUCLOCK_PROF].nextevt = prof_exp;
-	base[CPUCLOCK_VIRT].nextevt = virt_exp;
-	base[CPUCLOCK_SCHED].nextevt = sched_exp;
-
-	if (expiry_cache_is_inactive(&sig->posix_cputimers))
+	if (expiry_cache_is_inactive(pct))
 		stop_process_timers(sig);
 
 	sig->cputimer.checking_timer = false;


