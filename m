Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF32C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B5C217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfH1KQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46442 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfH1KQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:40 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0F-0000Kw-GA; Wed, 28 Aug 2019 12:16:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 084FF1C0DE9;
        Wed, 28 Aug 2019 12:16:32 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:31 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Switch thread group sampling to array
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192921.988426956@linutronix.de>
References: <20190821192921.988426956@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739192.5774.13704611665497160820.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b7be4ef1365dcb56fdffc6689e41058b23f5996d
Gitweb:        https://git.kernel.org/tip/b7be4ef1365dcb56fdffc6689e41058b23f5996d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:39 +02:00

posix-cpu-timers: Switch thread group sampling to array

That allows more simplifications in various places.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192921.988426956@linutronix.de

---
 include/linux/sched/cputime.h  |   2 +-
 kernel/time/itimer.c           |  11 +---
 kernel/time/posix-cpu-timers.c | 104 +++++++++++++-------------------
 3 files changed, 49 insertions(+), 68 deletions(-)

diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index 2638fd0..eefa5df 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -61,7 +61,7 @@ extern void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
  * Thread group CPU time accounting.
  */
 void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times);
-void thread_group_sample_cputime(struct task_struct *tsk, struct task_cputime *times);
+void thread_group_sample_cputime(struct task_struct *tsk, u64 *samples);
 
 /*
  * The following are functions that support scheduler-internal time accounting.
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index ae04bc2..77f1e56 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -55,15 +55,10 @@ static void get_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
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
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 9ac601a..e62139a 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -225,22 +225,14 @@ static inline void __update_gt_cputime(atomic64_t *cputime, u64 sum_cputime)
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
@@ -252,20 +244,19 @@ static inline void sample_cputime_atomic(struct task_cputime *times,
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
@@ -274,14 +265,14 @@ void thread_group_sample_cputime(struct task_struct *tsk,
  *
  * Updates @times with an uptodate sample of the thread group cputimes.
  */
-static void
-thread_group_start_cputime(struct task_struct *tsk, struct task_cputime *times)
+static void thread_group_start_cputime(struct task_struct *tsk, u64 *samples)
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
@@ -299,7 +290,15 @@ thread_group_start_cputime(struct task_struct *tsk, struct task_cputime *times)
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
@@ -313,28 +312,18 @@ static u64 cpu_clock_sample_group(const clockid_t clkid, struct task_struct *p,
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
@@ -889,9 +878,7 @@ static void check_process_timers(struct task_struct *tsk,
 {
 	struct signal_struct *const sig = tsk->signal;
 	struct posix_cputimer_base *base = sig->posix_cputimers.bases;
-	u64 utime, ptime, virt_expires, prof_expires;
-	u64 sum_sched_runtime, sched_expires;
-	struct task_cputime cputime;
+	u64 virt_exp, prof_exp, sched_exp, samples[CPUCLOCK_MAX];
 	unsigned long soft;
 
 	/*
@@ -911,30 +898,29 @@ static void check_process_timers(struct task_struct *tsk,
 	 * Collect the current process totals. Group accounting is active
 	 * so the sample can be taken directly.
 	 */
-	sample_cputime_atomic(&cputime, &sig->cputimer.cputime_atomic);
-	utime = cputime.utime;
-	ptime = utime + cputime.stime;
-	sum_sched_runtime = cputime.sum_exec_runtime;
-
-	prof_expires = check_timers_list(&base[CPUCLOCK_PROF].cpu_timers,
-					 firing, ptime);
-	virt_expires = check_timers_list(&base[CPUCLOCK_VIRT].cpu_timers,
-					 firing, utime);
-	sched_expires = check_timers_list(&base[CPUCLOCK_SCHED].cpu_timers,
-					  firing, sum_sched_runtime);
+	proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic, samples);
+
+	prof_exp = check_timers_list(&base[CPUCLOCK_PROF].cpu_timers,
+				     firing, samples[CPUCLOCK_PROF]);
+	virt_exp = check_timers_list(&base[CPUCLOCK_VIRT].cpu_timers,
+				     firing, samples[CPUCLOCK_VIRT]);
+	sched_exp = check_timers_list(&base[CPUCLOCK_SCHED].cpu_timers,
+				      firing, samples[CPUCLOCK_SCHED]);
 
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
+			 samples[CPUCLOCK_PROF], SIGVTALRM);
+
 	soft = task_rlimit(tsk, RLIMIT_CPU);
 	if (soft != RLIM_INFINITY) {
-		unsigned long psecs = div_u64(ptime, NSEC_PER_SEC);
+		u64 softns, ptime = samples[CPUCLOCK_PROF];
 		unsigned long hard = task_rlimit_max(tsk, RLIMIT_CPU);
-		u64 x;
+		unsigned long psecs = div_u64(ptime, NSEC_PER_SEC);
+
 		if (psecs >= hard) {
 			/*
 			 * At the hard limit, we just die.
@@ -961,14 +947,14 @@ static void check_process_timers(struct task_struct *tsk,
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
 
-	base[CPUCLOCK_PROF].nextevt = prof_expires;
-	base[CPUCLOCK_VIRT].nextevt = virt_expires;
-	base[CPUCLOCK_SCHED].nextevt = sched_expires;
+	base[CPUCLOCK_PROF].nextevt = prof_exp;
+	base[CPUCLOCK_VIRT].nextevt = virt_exp;
+	base[CPUCLOCK_SCHED].nextevt = sched_exp;
 
 	if (expiry_cache_is_zero(&sig->posix_cputimers))
 		stop_process_timers(sig);
