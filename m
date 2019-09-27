Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90972C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DCC2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfI0ILG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:11:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45265 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfI0ILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:11:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlKz-0005fj-4y; Fri, 27 Sep 2019 10:10:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5F7B01C079B;
        Fri, 27 Sep 2019 10:10:44 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:44 -0000
From:   "tip-bot2 for Eric W. Biederman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] tasks, sched/core: With a grace period after
 finish_task_switch(), remove unnecessary code
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kirill Tkhai <tkhai@yandex.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Russell King - ARM Linux admin" <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <87lfurdpk9.fsf_-_@x220.int.ebiederm.org>
References: <87lfurdpk9.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Message-ID: <156957184434.9866.8980212388435648779.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     154abafc68bfb7c2ef2ad5308a3b2de8968c3f61
Gitweb:        https://git.kernel.org/tip/154abafc68bfb7c2ef2ad5308a3b2de8968c3f61
Author:        Eric W. Biederman <ebiederm@xmission.com>
AuthorDate:    Sat, 14 Sep 2019 07:34:30 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 17:42:29 +02:00

tasks, sched/core: With a grace period after finish_task_switch(), remove unnecessary code

Remove work arounds that were written before there was a grace period
after tasks left the runqueue in finish_task_switch().

In particular now that there tasks exiting the runqueue exprience
a RCU grace period none of the work performed by task_rcu_dereference()
excpet the rcu_dereference() is necessary so replace task_rcu_dereference()
with rcu_dereference().

Remove the code in rcuwait_wait_event() that checks to ensure the current
task has not exited.  It is no longer necessary as it is guaranteed
that any running task will experience a RCU grace period after it
leaves the run queueue.

Remove the comment in rcuwait_wake_up() as it is no longer relevant.

Ref: 8f95c90ceb54 ("sched/wait, RCU: Introduce rcuwait machinery")
Ref: 150593bf8693 ("sched/api: Introduce task_rcu_dereference() and try_get_task_struct()")
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/87lfurdpk9.fsf_-_@x220.int.ebiederm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/rcuwait.h    | 20 ++---------
 include/linux/sched/task.h |  1 +-
 kernel/exit.c              | 67 +-------------------------------------
 kernel/sched/fair.c        |  2 +-
 kernel/sched/membarrier.c  |  4 +-
 5 files changed, 7 insertions(+), 87 deletions(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 563290f..75c97e4 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -6,16 +6,11 @@
 
 /*
  * rcuwait provides a way of blocking and waking up a single
- * task in an rcu-safe manner; where it is forbidden to use
- * after exit_notify(). task_struct is not properly rcu protected,
- * unless dealing with rcu-aware lists, ie: find_task_by_*().
+ * task in an rcu-safe manner.
  *
- * Alternatively we have task_rcu_dereference(), but the return
- * semantics have different implications which would break the
- * wakeup side. The only time @task is non-nil is when a user is
- * blocked (or checking if it needs to) on a condition, and reset
- * as soon as we know that the condition has succeeded and are
- * awoken.
+ * The only time @task is non-nil is when a user is blocked (or
+ * checking if it needs to) on a condition, and reset as soon as we
+ * know that the condition has succeeded and are awoken.
  */
 struct rcuwait {
 	struct task_struct __rcu *task;
@@ -37,13 +32,6 @@ extern void rcuwait_wake_up(struct rcuwait *w);
  */
 #define rcuwait_wait_event(w, condition)				\
 ({									\
-	/*								\
-	 * Complain if we are called after do_exit()/exit_notify(),     \
-	 * as we cannot rely on the rcu critical region for the		\
-	 * wakeup side.							\
-	 */                                                             \
-	WARN_ON(current->exit_state);                                   \
-									\
 	rcu_assign_pointer((w)->task, current);				\
 	for (;;) {							\
 		/*							\
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 153a683..4b1c3b6 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -119,7 +119,6 @@ static inline void put_task_struct(struct task_struct *t)
 		__put_task_struct(t);
 }
 
-struct task_struct *task_rcu_dereference(struct task_struct **ptask);
 void put_task_struct_rcu_user(struct task_struct *task);
 
 #ifdef CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT
diff --git a/kernel/exit.c b/kernel/exit.c
index 3bcaec2..a46a50d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -234,69 +234,6 @@ repeat:
 		goto repeat;
 }
 
-/*
- * Note that if this function returns a valid task_struct pointer (!NULL)
- * task->usage must remain >0 for the duration of the RCU critical section.
- */
-struct task_struct *task_rcu_dereference(struct task_struct **ptask)
-{
-	struct sighand_struct *sighand;
-	struct task_struct *task;
-
-	/*
-	 * We need to verify that release_task() was not called and thus
-	 * delayed_put_task_struct() can't run and drop the last reference
-	 * before rcu_read_unlock(). We check task->sighand != NULL,
-	 * but we can read the already freed and reused memory.
-	 */
-retry:
-	task = rcu_dereference(*ptask);
-	if (!task)
-		return NULL;
-
-	probe_kernel_address(&task->sighand, sighand);
-
-	/*
-	 * Pairs with atomic_dec_and_test() in put_task_struct(). If this task
-	 * was already freed we can not miss the preceding update of this
-	 * pointer.
-	 */
-	smp_rmb();
-	if (unlikely(task != READ_ONCE(*ptask)))
-		goto retry;
-
-	/*
-	 * We've re-checked that "task == *ptask", now we have two different
-	 * cases:
-	 *
-	 * 1. This is actually the same task/task_struct. In this case
-	 *    sighand != NULL tells us it is still alive.
-	 *
-	 * 2. This is another task which got the same memory for task_struct.
-	 *    We can't know this of course, and we can not trust
-	 *    sighand != NULL.
-	 *
-	 *    In this case we actually return a random value, but this is
-	 *    correct.
-	 *
-	 *    If we return NULL - we can pretend that we actually noticed that
-	 *    *ptask was updated when the previous task has exited. Or pretend
-	 *    that probe_slab_address(&sighand) reads NULL.
-	 *
-	 *    If we return the new task (because sighand is not NULL for any
-	 *    reason) - this is fine too. This (new) task can't go away before
-	 *    another gp pass.
-	 *
-	 *    And note: We could even eliminate the false positive if re-read
-	 *    task->sighand once again to avoid the falsely NULL. But this case
-	 *    is very unlikely so we don't care.
-	 */
-	if (!sighand)
-		return NULL;
-
-	return task;
-}
-
 void rcuwait_wake_up(struct rcuwait *w)
 {
 	struct task_struct *task;
@@ -316,10 +253,6 @@ void rcuwait_wake_up(struct rcuwait *w)
 	 */
 	smp_mb(); /* (B) */
 
-	/*
-	 * Avoid using task_rcu_dereference() magic as long as we are careful,
-	 * see comment in rcuwait_wait_event() regarding ->exit_state.
-	 */
 	task = rcu_dereference(w->task);
 	if (task)
 		wake_up_process(task);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3101c66..5bc2399 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1602,7 +1602,7 @@ static void task_numa_compare(struct task_numa_env *env,
 		return;
 
 	rcu_read_lock();
-	cur = task_rcu_dereference(&dst_rq->curr);
+	cur = rcu_dereference(dst_rq->curr);
 	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
 		cur = NULL;
 
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index aa8d758..b14250a 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -71,7 +71,7 @@ static int membarrier_global_expedited(void)
 			continue;
 
 		rcu_read_lock();
-		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
+		p = rcu_dereference(cpu_rq(cpu)->curr);
 		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
 				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
 			if (!fallback)
@@ -150,7 +150,7 @@ static int membarrier_private_expedited(int flags)
 		if (cpu == raw_smp_processor_id())
 			continue;
 		rcu_read_lock();
-		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
+		p = rcu_dereference(cpu_rq(cpu)->curr);
 		if (p && p->mm == current->mm) {
 			if (!fallback)
 				__cpumask_set_cpu(cpu, tmpmask);
