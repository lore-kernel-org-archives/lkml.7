Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E22C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C0F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfHSPqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:46:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47780 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfHSPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:53 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqw-00070d-8w; Mon, 19 Aug 2019 17:45:50 +0200
Message-Id: <20190819143804.745966802@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:16 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 35/44] posix-cpu-timers: Switch thread group sampling to array
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That allows more simplifications in various places.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/cputime.h  |    2 
 kernel/time/itimer.c           |   11 +---
 kernel/time/posix-cpu-timers.c |   96 +++++++++++++++++------------------------
 3 files changed, 45 insertions(+), 64 deletions(-)

--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -61,7 +61,7 @@ extern void cputime_adjust(struct task_c
  * Thread group CPU time accounting.
  */
 void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times);
-void thread_group_sample_cputime(struct task_struct *tsk, struct task_cputime *times);
+void thread_group_sample_cputime(struct task_struct *tsk, u64 *samples);
 
 /*
  * The following are functions that support scheduler-internal time accounting.
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -55,15 +55,10 @@ static void get_cpu_itimer(struct task_s
 	val = it->expires;
 	interval = it->incr;
 	if (val) {
-		struct task_cputime cputime;
-		u64 t;
+		u64 t, samples[CPUCLOCK_MAX];
 
-		thread_group_sample_cputime(tsk, &cputime);
-		if (clock_id == CPUCLOCK_PROF)
-			t = cputime.utime + cputime.stime;
-		else
-			/* CPUCLOCK_VIRT */
-			t = cputime.utime;
+		thread_group_sample_cputime(tsk, samples);
+		t = samples[clock_id];
 
 		if (val < t)
 			/* about to fire */
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -216,22 +216,14 @@ static inline void __update_gt_cputime(a
 	}
 }
 
-static void update_gt_cputime(struct task_cputime_atomic *cputime_atomic, struct task_cputime *sum)
+static void update_gt_cputime(struct task_cputime_atomic *cputime_atomic,
+			      struct task_cputime *sum)
 {
 	__update_gt_cputime(&cputime_atomic->utime, sum->utime);
 	__update_gt_cputime(&cputime_atomic->stime, sum->stime);
 	__update_gt_cputime(&cputime_atomic->sum_exec_runtime, sum->sum_exec_runtime);
 }
 
-/* Sample task_cputime_atomic values in "atomic_timers", store results in "times". */
-static inline void sample_cputime_atomic(struct task_cputime *times,
-					 struct task_cputime_atomic *atomic_times)
-{
-	times->utime = atomic64_read(&atomic_times->utime);
-	times->stime = atomic64_read(&atomic_times->stime);
-	times->sum_exec_runtime = atomic64_read(&atomic_times->sum_exec_runtime);
-}
-
 /**
  * thread_group_sample_cputime - Sample cputime for a given task
  * @tsk:	Task for which cputime needs to be started
@@ -243,20 +235,19 @@ static inline void sample_cputime_atomic
  *
  * Updates @times with an uptodate sample of the thread group cputimes.
  */
-void thread_group_sample_cputime(struct task_struct *tsk,
-				struct task_cputime *times)
+void thread_group_sample_cputime(struct task_struct *tsk, u64 *samples)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
 
 	WARN_ON_ONCE(!cputimer->running);
 
-	sample_cputime_atomic(times, &cputimer->cputime_atomic);
+	proc_sample_cputime_atomic(&cputimer->cputime_atomic, samples);
 }
 
 /**
  * thread_group_start_cputime - Start cputime and return a sample
  * @tsk:	Task for which cputime needs to be started
- * @iimes:	Storage for time samples
+ * @samples:	Storage for time samples
  *
  * The thread group cputime accouting is avoided when there are no posix
  * CPU timers armed. Before starting a timer it's required to check whether
@@ -266,13 +257,14 @@ void thread_group_sample_cputime(struct
  * Updates @times with an uptodate sample of the thread group cputimes.
  */
 static void
-thread_group_start_cputime(struct task_struct *tsk, struct task_cputime *times)
+thread_group_start_cputime(struct task_struct *tsk, u64 *samples)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
-	struct task_cputime sum;
 
 	/* Check if cputimer isn't running. This is accessed without locking. */
 	if (!READ_ONCE(cputimer->running)) {
+		struct task_cputime sum;
+
 		/*
 		 * The POSIX timer interface allows for absolute time expiry
 		 * values through the TIMER_ABSTIME flag, therefore we have
@@ -290,7 +282,15 @@ thread_group_start_cputime(struct task_s
 		 */
 		WRITE_ONCE(cputimer->running, true);
 	}
-	sample_cputime_atomic(times, &cputimer->cputime_atomic);
+	proc_sample_cputime_atomic(&cputimer->cputime_atomic, samples);
+}
+
+static void __thread_group_cputime(struct task_struct *tsk, u64 *samples)
+{
+	struct task_cputime ct;
+
+	thread_group_cputime(tsk, &ct);
+	store_samples(samples, ct.stime, ct.utime, ct.sum_exec_runtime);
 }
 
 /*
@@ -304,28 +304,18 @@ static u64 cpu_clock_sample_group(const
 				  bool start)
 {
 	struct thread_group_cputimer *cputimer = &p->signal->cputimer;
-	struct task_cputime cputime;
+	u64 samples[CPUCLOCK_MAX];
 
 	if (!READ_ONCE(cputimer->running)) {
 		if (start)
-			thread_group_start_cputime(p, &cputime);
+			thread_group_start_cputime(p, samples);
 		else
-			thread_group_cputime(p, &cputime);
+			__thread_group_cputime(p, samples);
 	} else {
-		sample_cputime_atomic(&cputime, &cputimer->cputime_atomic);
+		proc_sample_cputime_atomic(&cputimer->cputime_atomic, samples);
 	}
 
-	switch (clkid) {
-	case CPUCLOCK_PROF:
-		return cputime.utime + cputime.stime;
-	case CPUCLOCK_VIRT:
-		return cputime.utime;
-	case CPUCLOCK_SCHED:
-		return cputime.sum_exec_runtime;
-	default:
-		WARN_ON_ONCE(1);
-	}
-	return 0;
+	return samples[clkid];
 }
 
 static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
@@ -878,9 +868,7 @@ static void check_process_timers(struct
 {
 	struct signal_struct *const sig = tsk->signal;
 	struct list_head *timers = sig->posix_cputimers.cpu_timers;
-	u64 utime, ptime, virt_expires, prof_expires;
-	u64 sum_sched_runtime, sched_expires;
-	struct task_cputime cputime;
+	u64 virt_exp, prof_exp, sched_exp, samples[CPUCLOCK_MAX];
 	unsigned long soft;
 
 	/*
@@ -900,27 +888,26 @@ static void check_process_timers(struct
 	 * Collect the current process totals. Group accounting is active
 	 * so the sample can be taken directly.
 	 */
-	sample_cputime_atomic(&cputime, &sig->cputimer.cputime_atomic);
-	utime = cputime.utime;
-	ptime = utime + cputime.stime;
-	sum_sched_runtime = cputime.sum_exec_runtime;
-
-	prof_expires = check_timers_list(timers, firing, ptime);
-	virt_expires = check_timers_list(++timers, firing, utime);
-	sched_expires = check_timers_list(++timers, firing, sum_sched_runtime);
+	proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic, samples);
+
+	prof_exp = check_timers_list(timers, firing, samples[CPUCLOCK_PROF]);
+	virt_exp = check_timers_list(++timers, firing, samples[CPUCLOCK_VIRT]);
+	sched_exp = check_timers_list(++timers, firing, samples[CPUCLOCK_SCHED]);
 
 	/*
 	 * Check for the special case process timers.
 	 */
-	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_PROF], &prof_expires, ptime,
-			 SIGPROF);
-	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_VIRT], &virt_expires, utime,
-			 SIGVTALRM);
+	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_PROF], &prof_exp,
+			 samples[CPUCLOCK_PROF], SIGPROF);
+	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_VIRT], &virt_exp,
+			 samples[CPUCLOCK_VIRT], SIGVTALRM);
+
 	soft = task_rlimit(tsk, RLIMIT_CPU);
 	if (soft != RLIM_INFINITY) {
-		unsigned long psecs = div_u64(ptime, NSEC_PER_SEC);
 		unsigned long hard = task_rlimit_max(tsk, RLIMIT_CPU);
-		u64 x;
+		u64 softns, ptime = samples[CPUCLOCK_PROF];
+		unsigned long psecs = div_u64(ptime, NSEC_PER_SEC);
+
 		if (psecs >= hard) {
 			/*
 			 * At the hard limit, we just die.
@@ -947,14 +934,13 @@ static void check_process_timers(struct
 				sig->rlim[RLIMIT_CPU].rlim_cur = soft;
 			}
 		}
-		x = soft * NSEC_PER_SEC;
-		if (!prof_expires || x < prof_expires)
-			prof_expires = x;
+		softns = soft * NSEC_PER_SEC;
+		if (!prof_exp || softns < prof_exp)
+			prof_exp = softns;
 	}
 
-	sig->posix_cputimers.expiries[CPUCLOCK_PROF] = prof_expires;
-	sig->posix_cputimers.expiries[CPUCLOCK_VIRT] = virt_expires;
-	sig->posix_cputimers.expiries[CPUCLOCK_SCHED] = sched_expires;
+	store_samples(sig->posix_cputimers.expiries, prof_exp, virt_exp,
+		      sched_exp);
 
 	if (expiry_cache_is_zero(sig->posix_cputimers.expiries))
 		stop_process_timers(sig);


