Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BABC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8984217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfH1KQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46484 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfH1KQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0M-0000P6-8j; Wed, 28 Aug 2019 12:16:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5E5C21C0DE8;
        Wed, 28 Aug 2019 12:16:36 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:36 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Utilize timerqueue for storage
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.1908272129220.1939@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1908272129220.1939@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739628.5801.10963462243249374829.tip-bot2@tip-bot2>
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

Commit-ID:     60bda037f1dd8151e0c9ee5b09f0c091a0f643cd
Gitweb:        https://git.kernel.org/tip/60bda037f1dd8151e0c9ee5b09f0c091a0f643cd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 27 Aug 2019 21:31:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:43 +02:00

posix-cpu-timers: Utilize timerqueue for storage

Using a linear O(N) search for timer insertion affects execution time and
D-cache footprint badly with a larger number of timers.

Switch the storage to a timerqueue which is already used for hrtimers and
alarmtimers. It does not affect the size of struct k_itimer as it.alarm is
still larger.

The extra list head for the expiry list will go away later once the expiry
is moved into task work context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1908272129220.1939@nanos.tec.linutronix.de

---
 include/linux/posix-timers.h   |  65 ++++++++---
 include/linux/timerqueue.h     |  10 ++-
 kernel/time/posix-cpu-timers.c | 189 ++++++++++++++++----------------
 3 files changed, 155 insertions(+), 109 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index a9e3f69..f9fbb4c 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -5,17 +5,11 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/alarmtimer.h>
+#include <linux/timerqueue.h>
 
 struct kernel_siginfo;
 struct task_struct;
 
-struct cpu_timer_list {
-	struct list_head entry;
-	u64 expires;
-	struct task_struct *task;
-	int firing;
-};
-
 /*
  * Bit fields within a clockid:
  *
@@ -65,13 +59,57 @@ static inline int clockid_to_fd(const clockid_t clk)
 #ifdef CONFIG_POSIX_TIMERS
 
 /**
+ * cpu_timer - Posix CPU timer representation for k_itimer
+ * @node:	timerqueue node to queue in the task/sig
+ * @head:	timerqueue head on which this timer is queued
+ * @task:	Pointer to target task
+ * @elist:	List head for the expiry list
+ * @firing:	Timer is currently firing
+ */
+struct cpu_timer {
+	struct timerqueue_node	node;
+	struct timerqueue_head	*head;
+	struct task_struct	*task;
+	struct list_head	elist;
+	int			firing;
+};
+
+static inline bool cpu_timer_requeue(struct cpu_timer *ctmr)
+{
+	return timerqueue_add(ctmr->head, &ctmr->node);
+}
+
+static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
+				     struct cpu_timer *ctmr)
+{
+	ctmr->head = head;
+	return timerqueue_add(head, &ctmr->node);
+}
+
+static inline void cpu_timer_dequeue(struct cpu_timer *ctmr)
+{
+	if (!RB_EMPTY_NODE(&ctmr->node.node))
+		timerqueue_del(ctmr->head, &ctmr->node);
+}
+
+static inline u64 cpu_timer_getexpires(struct cpu_timer *ctmr)
+{
+	return ctmr->node.expires;
+}
+
+static inline void cpu_timer_setexpires(struct cpu_timer *ctmr, u64 exp)
+{
+	ctmr->node.expires = exp;
+}
+
+/**
  * posix_cputimer_base - Container per posix CPU clock
  * @nextevt:		Earliest-expiration cache
- * @cpu_timers:		List heads to queue posix CPU timers
+ * @tqhead:		timerqueue head for cpu_timers
  */
 struct posix_cputimer_base {
 	u64			nextevt;
-	struct list_head	cpu_timers;
+	struct timerqueue_head	tqhead;
 };
 
 /**
@@ -92,14 +130,10 @@ struct posix_cputimers {
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
-	pct->timers_active = 0;
-	pct->expiry_active = 0;
+	memset(pct, 0, sizeof(*pct));
 	pct->bases[0].nextevt = U64_MAX;
 	pct->bases[1].nextevt = U64_MAX;
 	pct->bases[2].nextevt = U64_MAX;
-	INIT_LIST_HEAD(&pct->bases[0].cpu_timers);
-	INIT_LIST_HEAD(&pct->bases[1].cpu_timers);
-	INIT_LIST_HEAD(&pct->bases[2].cpu_timers);
 }
 
 void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit);
@@ -113,7 +147,6 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
 	.nextevt	= U64_MAX,					\
-	.cpu_timers	= LIST_HEAD_INIT(b.cpu_timers),			\
 }
 
 #define INIT_CPU_TIMERBASES(b) {					\
@@ -182,7 +215,7 @@ struct k_itimer {
 		struct {
 			struct hrtimer	timer;
 		} real;
-		struct cpu_timer_list	cpu;
+		struct cpu_timer	cpu;
 		struct {
 			struct alarm	alarmtimer;
 		} alarm;
diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index aff122f..9388408 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -43,6 +43,16 @@ static inline void timerqueue_init(struct timerqueue_node *node)
 	RB_CLEAR_NODE(&node->node);
 }
 
+static inline bool timerqueue_node_queued(struct timerqueue_node *node)
+{
+	return !RB_EMPTY_NODE(&node->node);
+}
+
+static inline bool timerqueue_node_expires(struct timerqueue_node *node)
+{
+	return node->expires;
+}
+
 static inline void timerqueue_init_head(struct timerqueue_head *head)
 {
 	head->rb_root = RB_ROOT_CACHED;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 52f4c99..73c492c 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -96,19 +96,19 @@ static inline int validate_clock_permissions(const clockid_t clock)
  * Update expiry time from increment, and increase overrun count,
  * given the current clock sample.
  */
-static void bump_cpu_timer(struct k_itimer *timer, u64 now)
+static u64 bump_cpu_timer(struct k_itimer *timer, u64 now)
 {
+	u64 delta, incr, expires = timer->it.cpu.node.expires;
 	int i;
-	u64 delta, incr;
 
 	if (!timer->it_interval)
-		return;
+		return expires;
 
-	if (now < timer->it.cpu.expires)
-		return;
+	if (now < expires)
+		return expires;
 
 	incr = timer->it_interval;
-	delta = now + incr - timer->it.cpu.expires;
+	delta = now + incr - expires;
 
 	/* Don't use (incr*2 < delta), incr*2 might overflow. */
 	for (i = 0; incr < delta - incr; i++)
@@ -118,10 +118,11 @@ static void bump_cpu_timer(struct k_itimer *timer, u64 now)
 		if (delta < incr)
 			continue;
 
-		timer->it.cpu.expires += incr;
+		timer->it.cpu.node.expires += incr;
 		timer->it_overrun += 1LL << i;
 		delta -= incr;
 	}
+	return timer->it.cpu.node.expires;
 }
 
 /* Check whether all cache entries contain U64_MAX, i.e. eternal expiry time */
@@ -365,7 +366,7 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 		return -EINVAL;
 
 	new_timer->kclock = &clock_posix_cpu;
-	INIT_LIST_HEAD(&new_timer->it.cpu.entry);
+	timerqueue_init(&new_timer->it.cpu.node);
 	new_timer->it.cpu.task = p;
 	return 0;
 }
@@ -378,10 +379,11 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
  */
 static int posix_cpu_timer_del(struct k_itimer *timer)
 {
-	int ret = 0;
-	unsigned long flags;
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	struct task_struct *p = ctmr->task;
 	struct sighand_struct *sighand;
-	struct task_struct *p = timer->it.cpu.task;
+	unsigned long flags;
+	int ret = 0;
 
 	if (WARN_ON_ONCE(!p))
 		return -EINVAL;
@@ -393,15 +395,15 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 	sighand = lock_task_sighand(p, &flags);
 	if (unlikely(sighand == NULL)) {
 		/*
-		 * We raced with the reaping of the task.
-		 * The deletion should have cleared us off the list.
+		 * This raced with the reaping of the task. The exit cleanup
+		 * should have removed this timer from the timer queue.
 		 */
-		WARN_ON_ONCE(!list_empty(&timer->it.cpu.entry));
+		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
 	} else {
 		if (timer->it.cpu.firing)
 			ret = TIMER_RETRY;
 		else
-			list_del(&timer->it.cpu.entry);
+			cpu_timer_dequeue(ctmr);
 
 		unlock_task_sighand(p, &flags);
 	}
@@ -412,12 +414,16 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 	return ret;
 }
 
-static void cleanup_timers_list(struct list_head *head)
+static void cleanup_timerqueue(struct timerqueue_head *head)
 {
-	struct cpu_timer_list *timer, *next;
+	struct timerqueue_node *node;
+	struct cpu_timer *ctmr;
 
-	list_for_each_entry_safe(timer, next, head, entry)
-		list_del_init(&timer->entry);
+	while ((node = timerqueue_getnext(head))) {
+		timerqueue_del(head, node);
+		ctmr = container_of(node, struct cpu_timer, node);
+		ctmr->head = NULL;
+	}
 }
 
 /*
@@ -429,9 +435,9 @@ static void cleanup_timers_list(struct list_head *head)
  */
 static void cleanup_timers(struct posix_cputimers *pct)
 {
-	cleanup_timers_list(&pct->bases[CPUCLOCK_PROF].cpu_timers);
-	cleanup_timers_list(&pct->bases[CPUCLOCK_VIRT].cpu_timers);
-	cleanup_timers_list(&pct->bases[CPUCLOCK_SCHED].cpu_timers);
+	cleanup_timerqueue(&pct->bases[CPUCLOCK_PROF].tqhead);
+	cleanup_timerqueue(&pct->bases[CPUCLOCK_VIRT].tqhead);
+	cleanup_timerqueue(&pct->bases[CPUCLOCK_SCHED].tqhead);
 }
 
 /*
@@ -454,28 +460,18 @@ void posix_cpu_timers_exit_group(struct task_struct *tsk)
  */
 static void arm_timer(struct k_itimer *timer)
 {
-	struct cpu_timer_list *const nt = &timer->it.cpu;
 	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
-	struct task_struct *p = timer->it.cpu.task;
-	u64 newexp = timer->it.cpu.expires;
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	u64 newexp = cpu_timer_getexpires(ctmr);
+	struct task_struct *p = ctmr->task;
 	struct posix_cputimer_base *base;
-	struct list_head *head, *listpos;
-	struct cpu_timer_list *next;
 
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		base = p->posix_cputimers.bases + clkidx;
 	else
 		base = p->signal->posix_cputimers.bases + clkidx;
 
-	listpos = head = &base->cpu_timers;
-	list_for_each_entry(next,head, entry) {
-		if (nt->expires < next->expires)
-			break;
-		listpos = &next->entry;
-	}
-	list_add(&nt->entry, listpos);
-
-	if (listpos != head)
+	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
 		return;
 
 	/*
@@ -498,24 +494,26 @@ static void arm_timer(struct k_itimer *timer)
  */
 static void cpu_timer_fire(struct k_itimer *timer)
 {
+	struct cpu_timer *ctmr = &timer->it.cpu;
+
 	if ((timer->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
 		/*
 		 * User don't want any signal.
 		 */
-		timer->it.cpu.expires = 0;
+		cpu_timer_setexpires(ctmr, 0);
 	} else if (unlikely(timer->sigq == NULL)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
 		 */
 		wake_up_process(timer->it_process);
-		timer->it.cpu.expires = 0;
+		cpu_timer_setexpires(ctmr, 0);
 	} else if (!timer->it_interval) {
 		/*
 		 * One-shot timer.  Clear it as soon as it's fired.
 		 */
 		posix_timer_event(timer, 0);
-		timer->it.cpu.expires = 0;
+		cpu_timer_setexpires(ctmr, 0);
 	} else if (posix_timer_event(timer, ++timer->it_requeue_pending)) {
 		/*
 		 * The signal did not get queued because the signal
@@ -539,10 +537,11 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 {
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
-	struct task_struct *p = timer->it.cpu.task;
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	struct task_struct *p = ctmr->task;
 	struct sighand_struct *sighand;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	if (WARN_ON_ONCE(!p))
 		return -EINVAL;
@@ -562,22 +561,21 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * If p has just been reaped, we can no
 	 * longer get any information about it at all.
 	 */
-	if (unlikely(sighand == NULL)) {
+	if (unlikely(sighand == NULL))
 		return -ESRCH;
-	}
 
 	/*
 	 * Disarm any old timer after extracting its expiry time.
 	 */
-
-	ret = 0;
 	old_incr = timer->it_interval;
-	old_expires = timer->it.cpu.expires;
+	old_expires = cpu_timer_getexpires(ctmr);
+
 	if (unlikely(timer->it.cpu.firing)) {
 		timer->it.cpu.firing = -1;
 		ret = TIMER_RETRY;
-	} else
-		list_del_init(&timer->it.cpu.entry);
+	} else {
+		cpu_timer_dequeue(ctmr);
+	}
 
 	/*
 	 * We need to sample the current value to convert the new
@@ -598,18 +596,16 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			old->it_value.tv_nsec = 0;
 		} else {
 			/*
-			 * Update the timer in case it has
-			 * overrun already.  If it has,
-			 * we'll report it as having overrun
-			 * and with the next reloaded timer
-			 * already ticking, though we are
-			 * swallowing that pending
-			 * notification here to install the
-			 * new setting.
+			 * Update the timer in case it has overrun already.
+			 * If it has, we'll report it as having overrun and
+			 * with the next reloaded timer already ticking,
+			 * though we are swallowing that pending
+			 * notification here to install the new setting.
 			 */
-			bump_cpu_timer(timer, val);
-			if (val < timer->it.cpu.expires) {
-				old_expires = timer->it.cpu.expires - val;
+			u64 exp = bump_cpu_timer(timer, val);
+
+			if (val < exp) {
+				old_expires = exp - val;
 				old->it_value = ns_to_timespec64(old_expires);
 			} else {
 				old->it_value.tv_nsec = 1;
@@ -638,7 +634,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * For a timer with no notification action, we don't actually
 	 * arm the timer (we'll just fake it for timer_gettime).
 	 */
-	timer->it.cpu.expires = new_expires;
+	cpu_timer_setexpires(ctmr, new_expires);
 	if (new_expires != 0 && val < new_expires) {
 		arm_timer(timer);
 	}
@@ -680,8 +676,9 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
 {
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	struct task_struct *p = timer->it.cpu.task;
-	u64 now;
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	u64 now, expires = cpu_timer_getexpires(ctmr);
+	struct task_struct *p = ctmr->task;
 
 	if (WARN_ON_ONCE(!p))
 		return;
@@ -691,7 +688,7 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	 */
 	itp->it_interval = ktime_to_timespec64(timer->it_interval);
 
-	if (!timer->it.cpu.expires)
+	if (!expires)
 		return;
 
 	/*
@@ -713,9 +710,9 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 			/*
 			 * The process has been reaped.
 			 * We can't even collect a sample any more.
-			 * Call the timer disarmed, nothing else to do.
+			 * Disarm the timer, nothing else to do.
 			 */
-			timer->it.cpu.expires = 0;
+			cpu_timer_setexpires(ctmr, 0);
 			return;
 		} else {
 			now = cpu_clock_sample_group(clkid, p, false);
@@ -723,8 +720,8 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 		}
 	}
 
-	if (now < timer->it.cpu.expires) {
-		itp->it_value = ns_to_timespec64(timer->it.cpu.expires - now);
+	if (now < expires) {
+		itp->it_value = ns_to_timespec64(expires - now);
 	} else {
 		/*
 		 * The timer should have expired already, but the firing
@@ -735,37 +732,41 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	}
 }
 
-static unsigned long long
-check_timers_list(struct list_head *timers,
-		  struct list_head *firing,
-		  unsigned long long curr)
-{
-	int maxfire = 20;
-
-	while (!list_empty(timers)) {
-		struct cpu_timer_list *t;
-
-		t = list_first_entry(timers, struct cpu_timer_list, entry);
+#define MAX_COLLECTED	20
 
-		if (!--maxfire || curr < t->expires)
-			return t->expires;
-
-		t->firing = 1;
-		list_move_tail(&t->entry, firing);
+static u64 collect_timerqueue(struct timerqueue_head *head,
+			      struct list_head *firing, u64 now)
+{
+	struct timerqueue_node *next;
+	int i = 0;
+
+	while ((next = timerqueue_getnext(head))) {
+		struct cpu_timer *ctmr;
+		u64 expires;
+
+		ctmr = container_of(next, struct cpu_timer, node);
+		expires = cpu_timer_getexpires(ctmr);
+		/* Limit the number of timers to expire at once */
+		if (++i == MAX_COLLECTED || now < expires)
+			return expires;
+
+		ctmr->firing = 1;
+		cpu_timer_dequeue(ctmr);
+		list_add_tail(&ctmr->elist, firing);
 	}
 
 	return U64_MAX;
 }
 
-static void collect_posix_cputimers(struct posix_cputimers *pct,
-				    u64 *samples, struct list_head *firing)
+static void collect_posix_cputimers(struct posix_cputimers *pct, u64 *samples,
+				    struct list_head *firing)
 {
 	struct posix_cputimer_base *base = pct->bases;
 	int i;
 
 	for (i = 0; i < CPUCLOCK_MAX; i++, base++) {
-		base->nextevt = check_timers_list(&base->cpu_timers, firing,
-						   samples[i]);
+		base->nextevt = collect_timerqueue(&base->tqhead, firing,
+						    samples[i]);
 	}
 }
 
@@ -948,7 +949,8 @@ static void check_process_timers(struct task_struct *tsk,
 static void posix_cpu_timer_rearm(struct k_itimer *timer)
 {
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	struct task_struct *p = timer->it.cpu.task;
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	struct task_struct *p = ctmr->task;
 	struct sighand_struct *sighand;
 	unsigned long flags;
 	u64 now;
@@ -980,7 +982,7 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 			 * The process has been reaped.
 			 * We can't even collect a sample any more.
 			 */
-			timer->it.cpu.expires = 0;
+			cpu_timer_setexpires(ctmr, 0);
 			return;
 		} else if (unlikely(p->exit_state) && thread_group_empty(p)) {
 			/* If the process is dying, no need to rearm */
@@ -1124,11 +1126,11 @@ void run_posix_cpu_timers(void)
 	 * each timer's lock before clearing its firing flag, so no
 	 * timer call will interfere.
 	 */
-	list_for_each_entry_safe(timer, next, &firing, it.cpu.entry) {
+	list_for_each_entry_safe(timer, next, &firing, it.cpu.elist) {
 		int cpu_firing;
 
 		spin_lock(&timer->it_lock);
-		list_del_init(&timer->it.cpu.entry);
+		list_del_init(&timer->it.cpu.elist);
 		cpu_firing = timer->it.cpu.firing;
 		timer->it.cpu.firing = 0;
 		/*
@@ -1204,6 +1206,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 	timer.it_overrun = -1;
 	error = posix_cpu_timer_create(&timer);
 	timer.it_process = current;
+
 	if (!error) {
 		static struct itimerspec64 zero_it;
 		struct restart_block *restart;
@@ -1219,7 +1222,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		}
 
 		while (!signal_pending(current)) {
-			if (timer.it.cpu.expires == 0) {
+			if (!cpu_timer_getexpires(&timer.it.cpu)) {
 				/*
 				 * Our timer fired and was reset, below
 				 * deletion can not fail.
@@ -1241,7 +1244,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		/*
 		 * We were interrupted by a signal.
 		 */
-		expires = timer.it.cpu.expires;
+		expires = cpu_timer_getexpires(&timer.it.cpu);
 		error = posix_cpu_timer_set(&timer, 0, &zero_it, &it);
 		if (!error) {
 			/*
