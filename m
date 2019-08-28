Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964D9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657792189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfH1KRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:17:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46476 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfH1KQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0K-0000OR-Np; Wed, 28 Aug 2019 12:16:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CE3CB1C0DE2;
        Wed, 28 Aug 2019 12:16:35 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:35 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Move state tracking to struct
 posix_cputimers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192922.743229404@linutronix.de>
References: <20190821192922.743229404@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739574.5798.3829487610828402232.tip-bot2@tip-bot2>
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

Commit-ID:     244d49e30653658d4e7e9b2b8427777cbbc5affe
Gitweb:        https://git.kernel.org/tip/244d49e30653658d4e7e9b2b8427777cbbc5affe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:42 +02:00

posix-cpu-timers: Move state tracking to struct posix_cputimers

Put it where it belongs and clean up the ifdeffery in fork completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190821192922.743229404@linutronix.de

---
 include/linux/posix-timers.h   |  8 ++++-
 include/linux/sched/cputime.h  |  9 ++--
 include/linux/sched/signal.h   |  6 +---
 init/init_task.c               |  2 +-
 kernel/fork.c                  |  6 +---
 kernel/time/posix-cpu-timers.c | 73 ++++++++++++++++++---------------
 6 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 3ea920e..a9e3f69 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -77,15 +77,23 @@ struct posix_cputimer_base {
 /**
  * posix_cputimers - Container for posix CPU timer related data
  * @bases:		Base container for posix CPU clocks
+ * @timers_active:	Timers are queued.
+ * @expiry_active:	Timer expiry is active. Used for
+ *			process wide timers to avoid multiple
+ *			task trying to handle expiry concurrently
  *
  * Used in task_struct and signal_struct
  */
 struct posix_cputimers {
 	struct posix_cputimer_base	bases[CPUCLOCK_MAX];
+	unsigned int			timers_active;
+	unsigned int			expiry_active;
 };
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
+	pct->timers_active = 0;
+	pct->expiry_active = 0;
 	pct->bases[0].nextevt = U64_MAX;
 	pct->bases[1].nextevt = U64_MAX;
 	pct->bases[2].nextevt = U64_MAX;
diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index eefa5df..6c9f19a 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -70,7 +70,7 @@ void thread_group_sample_cputime(struct task_struct *tsk, u64 *samples);
  */
 
 /**
- * get_running_cputimer - return &tsk->signal->cputimer if cputimer is running
+ * get_running_cputimer - return &tsk->signal->cputimer if cputimers are active
  *
  * @tsk:	Pointer to target task.
  */
@@ -80,8 +80,11 @@ struct thread_group_cputimer *get_running_cputimer(struct task_struct *tsk)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
 
-	/* Check if cputimer isn't running. This is accessed without locking. */
-	if (!READ_ONCE(cputimer->running))
+	/*
+	 * Check whether posix CPU timers are active. If not the thread
+	 * group accounting is not active either. Lockless check.
+	 */
+	if (!READ_ONCE(tsk->signal->posix_cputimers.timers_active))
 		return NULL;
 
 	/*
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 729bd89..8805025 100644
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
diff --git a/init/init_task.c b/init/init_task.c
index 7ab773b..d49692a 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -30,8 +30,6 @@ static struct signal_struct init_signals = {
 	.posix_timers = LIST_HEAD_INIT(init_signals.posix_timers),
 	.cputimer	= {
 		.cputime_atomic	= INIT_CPUTIME_ATOMIC,
-		.running	= false,
-		.checking_timer = false,
 	},
 #endif
 	INIT_CPU_TIMERS(init_signals)
diff --git a/kernel/fork.c b/kernel/fork.c
index 52bfe7c..f1228d9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1517,7 +1517,6 @@ void __cleanup_sighand(struct sighand_struct *sighand)
 	}
 }
 
-#ifdef CONFIG_POSIX_TIMERS
 /*
  * Initialize POSIX timer handling for a thread group.
  */
@@ -1528,12 +1527,7 @@ static void posix_cpu_timers_init_group(struct signal_struct *sig)
 
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
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index ef39a7a..52f4c99 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -23,8 +23,10 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer);
 void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit)
 {
 	posix_cputimers_init(pct);
-	if (cpu_limit != RLIM_INFINITY)
+	if (cpu_limit != RLIM_INFINITY) {
 		pct->bases[CPUCLOCK_PROF].nextevt = cpu_limit * NSEC_PER_SEC;
+		pct->timers_active = true;
+	}
 }
 
 /*
@@ -248,8 +250,9 @@ static void update_gt_cputime(struct task_cputime_atomic *cputime_atomic,
 void thread_group_sample_cputime(struct task_struct *tsk, u64 *samples)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
+	struct posix_cputimers *pct = &tsk->signal->posix_cputimers;
 
-	WARN_ON_ONCE(!cputimer->running);
+	WARN_ON_ONCE(!pct->timers_active);
 
 	proc_sample_cputime_atomic(&cputimer->cputime_atomic, samples);
 }
@@ -269,9 +272,10 @@ void thread_group_sample_cputime(struct task_struct *tsk, u64 *samples)
 static void thread_group_start_cputime(struct task_struct *tsk, u64 *samples)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
+	struct posix_cputimers *pct = &tsk->signal->posix_cputimers;
 
 	/* Check if cputimer isn't running. This is accessed without locking. */
-	if (!READ_ONCE(cputimer->running)) {
+	if (!READ_ONCE(pct->timers_active)) {
 		struct task_cputime sum;
 
 		/*
@@ -283,13 +287,13 @@ static void thread_group_start_cputime(struct task_struct *tsk, u64 *samples)
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
@@ -313,9 +317,10 @@ static u64 cpu_clock_sample_group(const clockid_t clkid, struct task_struct *p,
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
@@ -834,10 +839,10 @@ static void check_thread_timers(struct task_struct *tsk,
 
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
 
@@ -877,17 +882,17 @@ static void check_process_timers(struct task_struct *tsk,
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
@@ -933,7 +938,7 @@ static void check_process_timers(struct task_struct *tsk,
 	if (expiry_cache_is_inactive(pct))
 		stop_process_timers(sig);
 
-	sig->cputimer.checking_timer = false;
+	pct->expiry_active = false;
 }
 
 /*
@@ -1027,39 +1032,41 @@ task_cputimers_expired(const u64 *sample, struct posix_cputimers *pct)
  */
 static inline bool fastpath_timer_check(struct task_struct *tsk)
 {
+	struct posix_cputimers *pct = &tsk->posix_cputimers;
 	struct signal_struct *sig;
 
-	if (!expiry_cache_is_inactive(&tsk->posix_cputimers)) {
+	if (!expiry_cache_is_inactive(pct)) {
 		u64 samples[CPUCLOCK_MAX];
 
 		task_sample_cputime(tsk, samples);
-		if (task_cputimers_expired(samples, &tsk->posix_cputimers))
+		if (task_cputimers_expired(samples, pct))
 			return true;
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
 
-		if (task_cputimers_expired(samples, &sig->posix_cputimers))
+		if (task_cputimers_expired(samples, pct))
 			return true;
 	}
 
