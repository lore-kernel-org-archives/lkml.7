Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC887C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B495C2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfHSPqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:46:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47826 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfHSPp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:57 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqz-00072i-Lz; Mon, 19 Aug 2019 17:45:53 +0200
Message-Id: <20190819143805.419809496@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:23 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 42/44] posix-cpu-timers: Move state tracking to struct
 posix_cputimers
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put it where it belongs and cleanup the ifdeffery in fork completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |   12 ++++++-
 include/linux/sched/cputime.h  |    9 +++--
 include/linux/sched/signal.h   |    6 ---
 init/init_task.c               |    2 -
 kernel/fork.c                  |    6 ---
 kernel/time/posix-cpu-timers.c |   68 +++++++++++++++++++++--------------------
 6 files changed, 53 insertions(+), 50 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -66,18 +66,26 @@ static inline int clockid_to_fd(const cl
 /**
  * posix_cputimers - Container for posix CPU timer related data
  * @expiries:		Earliest-expiration cache array based
+ * @timers_active:	Timers are queued.
+ * @expiry_active:	Timer expiry is active. Used for
+ *			process wide timers to avoid multiple
+ *			trying to handle expiry
  * @cpu_timers:		List heads to queue posix CPU timers
  *
  * Used in task_struct and signal_struct
  */
 struct posix_cputimers {
 	u64			expiries[CPUCLOCK_MAX];
+	unsigned int		timers_active;
+	unsigned int		expiry_active;
 	struct list_head	cpu_timers[CPUCLOCK_MAX];
 };
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
 	memset(&pct->expiries, 0xff, sizeof(pct->expiries));
+	pct->timers_active = 0;
+	pct->expiry_active = 0;
 	INIT_LIST_HEAD(&pct->cpu_timers[0]);
 	INIT_LIST_HEAD(&pct->cpu_timers[1]);
 	INIT_LIST_HEAD(&pct->cpu_timers[2]);
@@ -87,8 +95,10 @@ static inline void posix_cputimers_group
 					      u64 cpu_limit)
 {
 	posix_cputimers_init(pct);
-	if (cpu_limit != RLIM_INFINITY)
+	if (cpu_limit != RLIM_INFINITY) {
 		pct->expiries[CPUCLOCK_PROF] = cpu_limit * NSEC_PER_SEC;
+		pct->timers_active = true;
+	}
 }
 
 static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -70,7 +70,7 @@ void thread_group_sample_cputime(struct
  */
 
 /**
- * get_running_cputimer - return &tsk->signal->cputimer if cputimer is running
+ * get_running_cputimer - return &tsk->signal->cputimer if cputimers are active
  *
  * @tsk:	Pointer to target task.
  */
@@ -80,8 +80,11 @@ struct thread_group_cputimer *get_runnin
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
 
-	/* Check if cputimer isn't running. This is accessed without locking. */
-	if (!READ_ONCE(cputimer->running))
+	/*
+	 * Check whether posix cpu timers are active. If not the thread
+	 * group accounting is not active either. Lockless check.
+	 */
+	if (!READ_ONCE(tsk->signal->posix_cputimers.timers_active))
 		return NULL;
 
 	/*
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -57,18 +57,12 @@ struct task_cputime_atomic {
 /**
  * struct thread_group_cputimer - thread group interval timer counts
  * @cputime_atomic:	atomic thread group interval timers.
- * @running:		true when there are timers running and
- *			@cputime_atomic receives updates.
- * @checking_timer:	true when a thread in the group is in the
- *			process of checking for thread group timers.
  *
  * This structure contains the version of task_cputime, above, that is
  * used for thread group CPU timer calculations.
  */
 struct thread_group_cputimer {
 	struct task_cputime_atomic cputime_atomic;
-	bool running;
-	bool checking_timer;
 };
 
 struct multiprocess_signals {
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -30,8 +30,6 @@ static struct signal_struct init_signals
 	.posix_timers = LIST_HEAD_INIT(init_signals.posix_timers),
 	.cputimer	= {
 		.cputime_atomic	= INIT_CPUTIME_ATOMIC,
-		.running	= false,
-		.checking_timer = false,
 	},
 #endif
 	INIT_CPU_TIMERS(init_signals)
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1517,7 +1517,6 @@ void __cleanup_sighand(struct sighand_st
 	}
 }
 
-#ifdef CONFIG_POSIX_TIMERS
 /*
  * Initialize POSIX timer handling for a thread group.
  */
@@ -1528,12 +1527,7 @@ static void posix_cpu_timers_init_group(
 
 	cpu_limit = READ_ONCE(sig->rlim[RLIMIT_CPU].rlim_cur);
 	posix_cputimers_group_init(pct, cpu_limit);
-	if (cpu_limit != RLIM_INFINITY)
-		sig->cputimer.running = true;
 }
-#else
-static inline void posix_cpu_timers_init_group(struct signal_struct *sig) { }
-#endif
 
 static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 {
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -239,8 +239,9 @@ static void update_gt_cputime(struct tas
 void thread_group_sample_cputime(struct task_struct *tsk, u64 *samples)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
+	struct posix_cputimers *pct = &tsk->signal->posix_cputimers;
 
-	WARN_ON_ONCE(!cputimer->running);
+	WARN_ON_ONCE(!pct->timers_active);
 
 	proc_sample_cputime_atomic(&cputimer->cputime_atomic, samples);
 }
@@ -261,9 +262,10 @@ static void
 thread_group_start_cputime(struct task_struct *tsk, u64 *samples)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
+	struct posix_cputimers *pct = &tsk->signal->posix_cputimers;
 
 	/* Check if cputimer isn't running. This is accessed without locking. */
-	if (!READ_ONCE(cputimer->running)) {
+	if (!READ_ONCE(pct->timers_active)) {
 		struct task_cputime sum;
 
 		/*
@@ -275,13 +277,13 @@ thread_group_start_cputime(struct task_s
 		update_gt_cputime(&cputimer->cputime_atomic, &sum);
 
 		/*
-		 * We're setting cputimer->running without a lock. Ensure
-		 * this only gets written to in one operation. We set
-		 * running after update_gt_cputime() as a small optimization,
-		 * but barriers are not required because update_gt_cputime()
+		 * We're setting timers_active without a lock. Ensure this
+		 * only gets written to in one operation. We set it after
+		 * update_gt_cputime() as a small optimization, but
+		 * barriers are not required because update_gt_cputime()
 		 * can handle concurrent updates.
 		 */
-		WRITE_ONCE(cputimer->running, true);
+		WRITE_ONCE(pct->timers_active, true);
 	}
 	proc_sample_cputime_atomic(&cputimer->cputime_atomic, samples);
 }
@@ -305,9 +307,10 @@ static u64 cpu_clock_sample_group(const
 				  bool start)
 {
 	struct thread_group_cputimer *cputimer = &p->signal->cputimer;
+	struct posix_cputimers *pct = &p->signal->posix_cputimers;
 	u64 samples[CPUCLOCK_MAX];
 
-	if (!READ_ONCE(cputimer->running)) {
+	if (!READ_ONCE(pct->timers_active)) {
 		if (start)
 			thread_group_start_cputime(p, samples);
 		else
@@ -827,10 +830,10 @@ static void check_thread_timers(struct t
 
 static inline void stop_process_timers(struct signal_struct *sig)
 {
-	struct thread_group_cputimer *cputimer = &sig->cputimer;
+	struct posix_cputimers *pct = &sig->posix_cputimers;
 
-	/* Turn off cputimer->running. This is done without locking. */
-	WRITE_ONCE(cputimer->running, false);
+	/* Turn off the active flag. This is done without locking. */
+	WRITE_ONCE(pct->timers_active, false);
 	tick_dep_clear_signal(sig, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -870,17 +873,17 @@ static void check_process_timers(struct
 	unsigned long soft;
 
 	/*
-	 * If cputimer is not running, then there are no active
-	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).
+	 * If there are no active process wide timers (POSIX 1.b, itimers,
+	 * RLIMIT_CPU) nothing to check.
 	 */
-	if (!READ_ONCE(sig->cputimer.running))
+	if (!READ_ONCE(pct->timers_active))
 		return;
 
        /*
 	 * Signify that a thread is checking for process timers.
 	 * Write access to this field is protected by the sighand lock.
 	 */
-	sig->cputimer.checking_timer = true;
+	pct->timers_active = true;
 
 	/*
 	 * Collect the current process totals. Group accounting is active
@@ -924,7 +927,7 @@ static void check_process_timers(struct
 	if (expiry_cache_is_inactive(sig->posix_cputimers.expiries))
 		stop_process_timers(sig);
 
-	sig->cputimer.checking_timer = false;
+	pct->expiry_active = false;
 }
 
 /*
@@ -1017,7 +1020,8 @@ static inline bool task_cputimers_expire
  */
 static inline bool fastpath_timer_check(struct task_struct *tsk)
 {
-	u64 *expiries = tsk->posix_cputimers.expiries;
+	struct posix_cputimers *pct = &tsk->posix_cputimers;
+	u64 *expiries = pct->expiries;
 	struct signal_struct *sig;
 
 	if (!expiry_cache_is_inactive(expiries)) {
@@ -1029,29 +1033,29 @@ static inline bool fastpath_timer_check(
 	}
 
 	sig = tsk->signal;
+	pct = &sig->posix_cputimers;
 	/*
-	 * Check if thread group timers expired when the cputimer is
-	 * running and no other thread in the group is already checking
-	 * for thread group cputimers. These fields are read without the
-	 * sighand lock. However, this is fine because this is meant to
-	 * be a fastpath heuristic to determine whether we should try to
-	 * acquire the sighand lock to check/handle timers.
+	 * Check if thread group timers expired when timers are active and
+	 * no other thread in the group is already handling expiry for
+	 * thread group cputimers. These fields are read without the
+	 * sighand lock. However, this is fine because this is meant to be
+	 * a fastpath heuristic to determine whether we should try to
+	 * acquire the sighand lock to handle timer expiry.
 	 *
-	 * In the worst case scenario, if 'running' or 'checking_timer' gets
-	 * set but the current thread doesn't see the change yet, we'll wait
-	 * until the next thread in the group gets a scheduler interrupt to
-	 * handle the timer. This isn't an issue in practice because these
-	 * types of delays with signals actually getting sent are expected.
+	 * In the worst case scenario, if concurrently timers_active is set
+	 * or expiry_active is cleared, but the current thread doesn't see
+	 * the change yet, the timer checks are delayed until the next
+	 * thread in the group gets a scheduler interrupt to handle the
+	 * timer. This isn't an issue in practice because these types of
+	 * delays with signals actually getting sent are expected.
 	 */
-	if (READ_ONCE(sig->cputimer.running) &&
-	    !READ_ONCE(sig->cputimer.checking_timer)) {
+	if (READ_ONCE(pct->timers_active) && !READ_ONCE(pct->expiry_active)) {
 		u64 samples[CPUCLOCK_MAX];
 
 		proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic,
 					   samples);
 
-		if (task_cputimers_expired(samples,
-					   sig->posix_cputimers.expiries))
+		if (task_cputimers_expired(samples, pct->expiries))
 			return true;
 	}
 


