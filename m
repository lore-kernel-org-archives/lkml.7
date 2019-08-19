Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE0BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793902070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfHSPr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:47:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47709 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfHSPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:48 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqs-0006y2-Ho; Mon, 19 Aug 2019 17:45:46 +0200
Message-Id: <20190819143803.868533633@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:07 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 26/44] posix-cpu-timers: Move expiry cache into struct
 posix_cputimers
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The expiry cache belongs into the posix_cputimers container where the other
cpu timers information is.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |   31 ++++++++++++++++++++++++++++++-
 include/linux/sched.h          |    6 ------
 include/linux/sched/signal.h   |    3 ---
 kernel/fork.c                  |   25 +++----------------------
 kernel/sched/rt.c              |    6 ++++--
 kernel/time/posix-cpu-timers.c |   38 ++++++++++++++++++++------------------
 6 files changed, 57 insertions(+), 52 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -62,24 +62,49 @@ static inline int clockid_to_fd(const cl
 	return ~(clk >> 3);
 }
 
+/*
+ * Alternate field names for struct task_cputime when used on cache
+ * expirations. Will go away soon.
+ */
+#define virt_exp			utime
+#define prof_exp			stime
+#define sched_exp			sum_exec_runtime
+
+#ifdef CONFIG_POSIX_TIMERS
 /**
  * posix_cputimers - Container for posix CPU timer related data
+ * @cputime_expires:	Earliest-expiration cache
  * @cpu_timers:		List heads to queue posix CPU timers
  *
  * Used in task_struct and signal_struct
  */
 struct posix_cputimers {
+	struct task_cputime	cputime_expires;
 	struct list_head	cpu_timers[CPUCLOCK_MAX];
 };
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
+	memset(&pct->cputime_expires, 0, sizeof(pct->cputime_expires));
 	INIT_LIST_HEAD(&pct->cpu_timers[0]);
 	INIT_LIST_HEAD(&pct->cpu_timers[1]);
 	INIT_LIST_HEAD(&pct->cpu_timers[2]);
 }
 
-#ifdef CONFIG_POSIX_TIMERS
+static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
+					      u64 cpu_limit)
+{
+	posix_cputimers_init(pct);
+	if (cpu_limit != RLIM_INFINITY)
+		pct->cputime_expires.prof_exp = cpu_limit * NSEC_PER_SEC;
+}
+
+static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
+					       u64 runtime)
+{
+	pct->cputime_expires.sched_exp = runtime;
+}
+
 /* Init task static initializer */
 #define INIT_CPU_TIMERLISTS(c)	{					\
 	LIST_HEAD_INIT(c.cpu_timers[0]),				\
@@ -92,7 +117,11 @@ static inline void posix_cputimers_init(
 		.cpu_timers = INIT_CPU_TIMERLISTS(s.posix_cputimers),	\
 	},
 #else
+struct posix_cputimers { };
 #define INIT_CPU_TIMERS(s)
+static inline void posix_cputimers_init(struct posix_cputimers *pct) { }
+static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
+					      u64 cpu_limit) { }
 #endif
 
 #define REQUEUE_PENDING 1
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -246,11 +246,6 @@ struct prev_cputime {
 #endif
 };
 
-/* Alternate field names when used on cache expirations: */
-#define virt_exp			utime
-#define prof_exp			stime
-#define sched_exp			sum_exec_runtime
-
 enum vtime_state {
 	/* Task is sleeping or running in a CPU with VTIME inactive: */
 	VTIME_INACTIVE = 0,
@@ -863,7 +858,6 @@ struct task_struct {
 	unsigned long			maj_flt;
 
 #ifdef CONFIG_POSIX_TIMERS
-	struct task_cputime		cputime_expires;
 	struct posix_cputimers		posix_cputimers;
 #endif
 
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -149,9 +149,6 @@ struct signal_struct {
 	 */
 	struct thread_group_cputimer cputimer;
 
-	/* Earliest-expiration cache. */
-	struct task_cputime cputime_expires;
-
 	struct posix_cputimers posix_cputimers;
 #endif
 
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1527,12 +1527,9 @@ static void posix_cpu_timers_init_group(
 	unsigned long cpu_limit;
 
 	cpu_limit = READ_ONCE(sig->rlim[RLIMIT_CPU].rlim_cur);
-	if (cpu_limit != RLIM_INFINITY) {
-		sig->cputime_expires.prof_exp = cpu_limit * NSEC_PER_SEC;
+	posix_cputimers_group_init(pct, cpu_limit);
+	if (cpu_limit != RLIM_INFINITY)
 		sig->cputimer.running = true;
-	}
-
-	posix_cputimers_init(pct);
 }
 #else
 static inline void posix_cpu_timers_init_group(struct signal_struct *sig) { }
@@ -1638,22 +1635,6 @@ static void rt_mutex_init_task(struct ta
 #endif
 }
 
-#ifdef CONFIG_POSIX_TIMERS
-/*
- * Initialize POSIX timer handling for a single task.
- */
-static void posix_cpu_timers_init(struct task_struct *tsk)
-{
-	tsk->cputime_expires.prof_exp = 0;
-	tsk->cputime_expires.virt_exp = 0;
-	tsk->cputime_expires.sched_exp = 0;
-
-	posix_cputimers_init(&tsk->posix_cputimers);
-}
-#else
-static inline void posix_cpu_timers_init(struct task_struct *tsk) { }
-#endif
-
 static inline void init_task_pid_links(struct task_struct *task)
 {
 	enum pid_type type;
@@ -1932,7 +1913,7 @@ static __latent_entropy struct task_stru
 	task_io_accounting_init(&p->ioac);
 	acct_clear_integrals(p);
 
-	posix_cpu_timers_init(p);
+	posix_cputimers_init(&p->posix_cputimers);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2305,8 +2305,10 @@ static void watchdog(struct rq *rq, stru
 		}
 
 		next = DIV_ROUND_UP(min(soft, hard), USEC_PER_SEC/HZ);
-		if (p->rt.timeout > next)
-			p->cputime_expires.sched_exp = p->se.sum_exec_runtime;
+		if (p->rt.timeout > next) {
+			posix_cputimers_rt_watchdog(&p->posix_cputimers,
+						    p->se.sum_exec_runtime);
+		}
 	}
 }
 #else
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -22,9 +22,9 @@ static void posix_cpu_timer_rearm(struct
 
 /*
  * Called after updating RLIMIT_CPU to run cpu timer and update
- * tsk->signal->cputime_expires expiration cache if necessary. Needs
- * siglock protection since other code may update expiration cache as
- * well.
+ * tsk->signal->posix_cputimers.cputime_expires expiration cache if
+ * necessary. Needs siglock protection since other code may update
+ * expiration cache as well.
  */
 void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
 {
@@ -447,10 +447,10 @@ static void arm_timer(struct k_itimer *t
 
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
 		head = p->posix_cputimers.cpu_timers;
-		cputime_expires = &p->cputime_expires;
+		cputime_expires = &p->posix_cputimers.cputime_expires;
 	} else {
 		head = p->signal->posix_cputimers.cpu_timers;
-		cputime_expires = &p->signal->cputime_expires;
+		cputime_expires = &p->signal->posix_cputimers.cputime_expires;
 	}
 	head += CPUCLOCK_WHICH(timer->it_clock);
 
@@ -774,7 +774,7 @@ static void check_thread_timers(struct t
 				struct list_head *firing)
 {
 	struct list_head *timers = tsk->posix_cputimers.cpu_timers;
-	struct task_cputime *tsk_expires = &tsk->cputime_expires;
+	struct task_cputime *tsk_expires = &tsk->posix_cputimers.cputime_expires;
 	u64 expires, stime, utime;
 	unsigned long soft;
 
@@ -785,7 +785,7 @@ static void check_thread_timers(struct t
 	 * If cputime_expires is zero, then there are no active
 	 * per thread CPU timers.
 	 */
-	if (task_cputime_zero(&tsk->cputime_expires))
+	if (task_cputime_zero(tsk_expires))
 		return;
 
 	task_cputime(tsk, &utime, &stime);
@@ -954,10 +954,10 @@ static void check_process_timers(struct
 			prof_expires = x;
 	}
 
-	sig->cputime_expires.prof_exp = prof_expires;
-	sig->cputime_expires.virt_exp = virt_expires;
-	sig->cputime_expires.sched_exp = sched_expires;
-	if (task_cputime_zero(&sig->cputime_expires))
+	sig->posix_cputimers.cputime_expires.prof_exp = prof_expires;
+	sig->posix_cputimers.cputime_expires.virt_exp = virt_expires;
+	sig->posix_cputimers.cputime_expires.sched_exp = sched_expires;
+	if (task_cputime_zero(&sig->posix_cputimers.cputime_expires))
 		stop_process_timers(sig);
 
 	sig->cputimer.checking_timer = false;
@@ -1058,12 +1058,13 @@ static inline int fastpath_timer_check(s
 {
 	struct signal_struct *sig;
 
-	if (!task_cputime_zero(&tsk->cputime_expires)) {
+	if (!task_cputime_zero(&tsk->posix_cputimers.cputime_expires)) {
 		struct task_cputime task_sample;
 
 		task_cputime(tsk, &task_sample.utime, &task_sample.stime);
 		task_sample.sum_exec_runtime = tsk->se.sum_exec_runtime;
-		if (task_cputime_expired(&task_sample, &tsk->cputime_expires))
+		if (task_cputime_expired(&task_sample,
+					 &tsk->posix_cputimers.cputime_expires))
 			return 1;
 	}
 
@@ -1088,7 +1089,8 @@ static inline int fastpath_timer_check(s
 
 		sample_cputime_atomic(&group_sample, &sig->cputimer.cputime_atomic);
 
-		if (task_cputime_expired(&group_sample, &sig->cputime_expires))
+		if (task_cputime_expired(&group_sample,
+					 &sig->posix_cputimers.cputime_expires))
 			return 1;
 	}
 
@@ -1218,12 +1220,12 @@ void set_process_cpu_timer(struct task_s
 	 */
 	switch (clock_idx) {
 	case CPUCLOCK_PROF:
-		if (expires_gt(tsk->signal->cputime_expires.prof_exp, *newval))
-			tsk->signal->cputime_expires.prof_exp = *newval;
+		if (expires_gt(tsk->signal->posix_cputimers.cputime_expires.prof_exp, *newval))
+			tsk->signal->posix_cputimers.cputime_expires.prof_exp = *newval;
 		break;
 	case CPUCLOCK_VIRT:
-		if (expires_gt(tsk->signal->cputime_expires.virt_exp, *newval))
-			tsk->signal->cputime_expires.virt_exp = *newval;
+		if (expires_gt(tsk->signal->posix_cputimers.cputime_expires.virt_exp, *newval))
+			tsk->signal->posix_cputimers.cputime_expires.virt_exp = *newval;
 		break;
 	}
 


