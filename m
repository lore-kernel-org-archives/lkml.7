Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDDFC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 04:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C85722CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 04:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfICEwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 00:52:55 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53171 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfICEwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 00:52:54 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i50oG-00028h-JL; Mon, 02 Sep 2019 22:52:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i50oE-0002zt-He; Mon, 02 Sep 2019 22:52:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
        <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
        <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
        <20190830160957.GC2634@redhat.com>
        <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
        <87o906wimo.fsf@x220.int.ebiederm.org>
        <20190902134003.GA14770@redhat.com>
        <87tv9uiq9r.fsf@x220.int.ebiederm.org>
        <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
        <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 02 Sep 2019 23:52:35 -0500
In-Reply-To: <87k1aqt23r.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 02 Sep 2019 23:50:32 -0500")
Message-ID: <8736het20c.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i50oE-0002zt-He;;;mid=<8736het20c.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/QuA/3u+CPQrjPaXULeIRCVjvgysxX7fM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 3/3] task: Clean house now that tasks on the runqueue are rcu protected
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Use rcu_dereference instead of task_rcu_dereference.

Remove task_rcu_dereference.

Remove the complications of rcuwait that were in place because tasks
on the runqueue were not rcu protected.  It is now safe to call
wake_up_process if the target was know to be on the runqueue in the
current rcu interval.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Ref: 8f95c90ceb54 ("sched/wait, RCU: Introduce rcuwait machinery")
Ref: 150593bf8693 ("sched/api: Introduce task_rcu_dereference() and try_get_task_struct()")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/rcuwait.h    | 20 +++---------
 include/linux/sched/task.h |  1 -
 kernel/exit.c              | 67 --------------------------------------
 kernel/sched/fair.c        |  2 +-
 kernel/sched/membarrier.c  |  4 +--
 5 files changed, 7 insertions(+), 87 deletions(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 563290fc194f..75c97e4bbc57 100644
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
index 4c44c37236b2..8bd51af44bf8 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -115,7 +115,6 @@ static inline void put_task_struct(struct task_struct *t)
 		__put_task_struct(t);
 }
 
-struct task_struct *task_rcu_dereference(struct task_struct **ptask);
 void put_task_struct_rcu_user(struct task_struct *task);
 
 #ifdef CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT
diff --git a/kernel/exit.c b/kernel/exit.c
index 2e259286f4e7..f943773622fc 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -234,69 +234,6 @@ void release_task(struct task_struct *p)
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
index bc9cfeaac8bd..215c640e2a6b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1644,7 +1644,7 @@ static void task_numa_compare(struct task_numa_env *env,
 		return;
 
 	rcu_read_lock();
-	cur = task_rcu_dereference(&dst_rq->curr);
+	cur = rcu_dereference(dst_rq->curr);
 	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
 		cur = NULL;
 
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index aa8d75804108..b14250a11608 100644
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
-- 
2.21.0.dirty

