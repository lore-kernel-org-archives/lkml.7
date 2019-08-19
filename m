Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DDAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2922070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfHSPqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:46:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47837 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfHSPp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:57 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjr0-000736-Fb; Mon, 19 Aug 2019 17:45:54 +0200
Message-Id: <20190819143805.605704599@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:25 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 44/44] posix-cpu-timers: Expire timers directly
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving the posix cpu timers from on list to another and then expiring them
from the second list is avoiding to drop and reacquire sighand lock for
each timer expiry, but on the other hand it's more complicated code and
suboptimal for a small number of timers.

Remove the extra list and expire them directly from the rbtree. Tests with
a large number of timers did not show a difference outside of the noise
range.

This also allows to switch the crude heuristics of limiting the expiry of
timers to 20 for each type to a time based limitation which is way more
sensible.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    2 
 kernel/time/posix-cpu-timers.c |   85 +++++++++++++----------------------------
 2 files changed, 29 insertions(+), 58 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -63,14 +63,12 @@ static inline int clockid_to_fd(const cl
  * @node:	timerqueue node to queue in the task/sig
  * @head:	timerqueue head on which this timer is queued
  * @task:	Pointer to target task
- * @elist:	List head for the expiry list
  * @firing:	Timer is currently firing
  */
 struct cpu_timer {
 	struct timerqueue_node	node;
 	struct timerqueue_head	*head;
 	struct task_struct	*task;
-	struct list_head	elist;
 	int			firing;
 };
 
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -723,14 +723,15 @@ static void posix_cpu_timer_get(struct k
 
 #define MAX_COLLECTED	20
 
-static u64 collect_timerqueue(struct timerqueue_head *head,
-			      struct list_head *firing, u64 now)
+static u64 expire_timerqueue(struct timerqueue_head *head, u64 now)
 {
 	struct timerqueue_node *next;
 	int i = 0;
 
 	while ((next = timerqueue_getnext(head))) {
 		struct cpu_timer *ctmr;
+		struct k_itimer *timer;
+		int cpu_firing;
 		u64 expires;
 
 		ctmr = container_of(next, struct cpu_timer, node);
@@ -739,23 +740,38 @@ static u64 collect_timerqueue(struct tim
 		if (++i == MAX_COLLECTED || now < expires)
 			return expires;
 
+		/* Mark is as firing so timer deletion code has to wait */
 		ctmr->firing = 1;
 		cpu_timer_dequeue(ctmr);
-		list_add_tail(&ctmr->elist, firing);
+		spin_unlock(&current->sighand->siglock);
+
+		timer = container_of(ctmr, struct k_itimer, it.cpu);
+		spin_lock(&timer->it_lock);
+		cpu_firing = timer->it.cpu.firing;
+		timer->it.cpu.firing = 0;
+		/*
+		 * The firing flag is -1 if we collided with a reset
+		 * of the timer, which already reported this
+		 * almost-firing as an overrun.  So don't generate an event.
+		 */
+		if (likely(cpu_firing >= 0))
+			cpu_timer_fire(timer);
+		spin_unlock(&timer->it_lock);
+
+		spin_lock(&current->sighand->siglock);
 	}
 
 	return U64_MAX;
 }
 
-static void collect_posix_cputimers(struct posix_cputimers *pct,
-				    u64 *samples, struct list_head *firing)
+static void expire_posix_cputimers(struct posix_cputimers *pct, u64 *samples)
 {
 	struct timerqueue_head *timers = pct->cpu_timers;
 	u64 *expiries = pct->expiries;
 	int i;
 
 	for (i = 0; i < CPUCLOCK_MAX; i++, timers++)
-		expiries[i] = collect_timerqueue(timers, firing, samples[i]);
+		expiries[i] = expire_timerqueue(timers, samples[i]);
 }
 
 static inline void check_dl_overrun(struct task_struct *tsk)
@@ -785,8 +801,7 @@ static bool check_rlimit(u64 time, u64 l
  * the tsk->cpu_timers[N] list onto the firing list.  Here we update the
  * tsk->it_*_expires values to reflect the remaining thread CPU timers.
  */
-static void check_thread_timers(struct task_struct *tsk,
-				struct list_head *firing)
+static void expire_thread_timers(struct task_struct *tsk)
 {
 	struct posix_cputimers *pct = &tsk->posix_cputimers;
 	u64 samples[CPUCLOCK_MAX];
@@ -799,7 +814,7 @@ static void check_thread_timers(struct t
 		return;
 
 	task_sample_cputime(tsk, samples);
-	collect_posix_cputimers(pct, samples, firing);
+	expire_posix_cputimers(pct, samples);
 
 	/*
 	 * Check for the special case thread timers.
@@ -858,12 +873,9 @@ static void check_cpu_itimer(struct task
 }
 
 /*
- * Check for any per-thread CPU timers that have fired and move them
- * off the tsk->*_timers list onto the firing list.  Per-thread timers
- * have already been taken off.
+ * Expire per-process CPU timers
  */
-static void check_process_timers(struct task_struct *tsk,
-				 struct list_head *firing)
+static void expire_process_timers(struct task_struct *tsk)
 {
 	struct signal_struct *const sig = tsk->signal;
 	struct posix_cputimers *pct = &sig->posix_cputimers;
@@ -888,7 +900,7 @@ static void check_process_timers(struct
 	 * so the sample can be taken directly.
 	 */
 	proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic, samples);
-	collect_posix_cputimers(pct, samples, firing);
+	expire_posix_cputimers(pct, samples);
 
 	/*
 	 * Check for the special case process timers.
@@ -1072,8 +1084,6 @@ static inline bool fastpath_timer_check(
 void run_posix_cpu_timers(void)
 {
 	struct task_struct *tsk = current;
-	struct k_itimer *timer, *next;
-	LIST_HEAD(firing);
 
 	lockdep_assert_irqs_disabled();
 
@@ -1101,47 +1111,10 @@ void run_posix_cpu_timers(void)
 	 */
 	spin_lock(&tsk->sighand->siglock);
 
-	/*
-	 * Here we take off tsk->signal->cpu_timers[N] and
-	 * tsk->cpu_timers[N] all the timers that are firing, and
-	 * put them on the firing list.
-	 */
-	check_thread_timers(tsk, &firing);
+	expire_thread_timers(tsk);
+	expire_process_timers(tsk);
 
-	check_process_timers(tsk, &firing);
-
-	/*
-	 * We must release these locks before taking any timer's lock.
-	 * There is a potential race with timer deletion here, as the
-	 * siglock now protects our private firing list.  We have set
-	 * the firing flag in each timer, so that a deletion attempt
-	 * that gets the timer lock before we do will give it up and
-	 * spin until we've taken care of that timer below.
-	 */
 	spin_unlock(&tsk->sighand->siglock);
-
-	/*
-	 * Now that all the timers on our list have the firing flag,
-	 * no one will touch their list entries but us.  We'll take
-	 * each timer's lock before clearing its firing flag, so no
-	 * timer call will interfere.
-	 */
-	list_for_each_entry_safe(timer, next, &firing, it.cpu.elist) {
-		int cpu_firing;
-
-		spin_lock(&timer->it_lock);
-		list_del_init(&timer->it.cpu.elist);
-		cpu_firing = timer->it.cpu.firing;
-		timer->it.cpu.firing = 0;
-		/*
-		 * The firing flag is -1 if we collided with a reset
-		 * of the timer, which already reported this
-		 * almost-firing as an overrun.  So don't generate an event.
-		 */
-		if (likely(cpu_firing >= 0))
-			cpu_timer_fire(timer);
-		spin_unlock(&timer->it_lock);
-	}
 }
 
 /*


