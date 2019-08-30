Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E925C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF16721897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfH3Tgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:36:32 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56479 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfH3Tgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:36:31 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i3mh9-0008W2-Sp; Fri, 30 Aug 2019 13:36:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i3mh8-0001ij-KN; Fri, 30 Aug 2019 13:36:27 -0600
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
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
        <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
        <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
        <20190830160957.GC2634@redhat.com>
        <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
Date:   Fri, 30 Aug 2019 14:36:15 -0500
In-Reply-To: <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 30 Aug 2019 09:21:31 -0700")
Message-ID: <87o906wimo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i3mh8-0001ij-KN;;;mid=<87o906wimo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+hg6msJMXAr0qDofmUEK7im4uo7cyS1tc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference() without checking return value
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Aug 30, 2019 at 9:10 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>
>>
>> Yes, please see
>>
>>         [PATCH 2/3] introduce probe_slab_address()
>>         https://lore.kernel.org/lkml/20141027195425.GC11736@redhat.com/
>>
>> I sent 5 years ago ;) Do you think
>>
>>         /*
>>          * Same as probe_kernel_address(), but @addr must be the valid pointer
>>          * to a slab object, potentially freed/reused/unmapped.
>>          */
>>         #ifdef CONFIG_DEBUG_PAGEALLOC
>>         #define probe_slab_address(addr, retval)        \
>>                 probe_kernel_address(addr, retval)
>>         #else
>>         #define probe_slab_address(addr, retval)        \
>>                 ({                                                      \
>>                         (retval) = *(typeof(retval) *)(addr);           \
>>                         0;                                              \
>>                 })
>>         #endif
>>
>> can work?
>
> Ugh. I would much rather handle the general case, because honestly,
> tracing has had a lot of issues with our hacky "probe_kernel_read()"
> stuff that bases itself on user addresses.
>
> It's also one of the few remaining users of "set_fs()" in core code,
> and we really should try to get rid of those.
>
> So your code would work for this particular case, but not for other
> cases that can trap simply because the pointer isn't reliable (tracing
> being the main case for that - but if the source of the pointer itself
> might have been free'd, you would also have that situation).
>
> So I'd really prefer to have something a bit fancier. On most
> architectures, doing a good exception fixup for kernel addresses is
> really not that hard.
>
> On x86, for example, we actually have *exactly* that. The
> "__get_user_asm()" macro is basically it. It purely does a load
> instruction from an unchecked address.
>
> (It's a really odd syntax, but you could remove the __chk_user_ptr()
> from the __get_user_size() macro, and now you'd have basically a "any
> regular size kernel access with exception handlng").
>
> But yes, your hack is I guess optimal for this particular case where
> you simply can depend on "we know the pointer was valid, we just don't
> know if it was freed".
>
> Hmm. Don't we RCU-free the task struct? Because then we don't even
> need to care about CONFIG_DEBUG_PAGEALLOC. We can just always access
> the pointer as long as we have the RCU read lock. We do that in other
> cases.

Sort of.  The rcu delay happens when release_task calls
delayed_put_task_struct.  Which unfortunately means that anytime after
exit_notify, release_task can operate on a task.  So it is possible
that by the time do_dead_task is called the rcu grace period is up.


Which is the problem the users of task_rcu_dereference are fighting.
They are performing an rcu walk on the set of cups in task_numa_migrate
and in the userspace membarrier system calls.

For a short while we the rcu delay in put_task_struct but that required
changes all of the place and was just a pain to work with.

Then I did:
> commit 8c7904a00b06d2ee51149794b619e07369fcf9d4
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Fri Mar 31 02:31:37 2006 -0800
> 
>     [PATCH] task: RCU protect task->usage
>     
>     A big problem with rcu protected data structures that are also reference
>     counted is that you must jump through several hoops to increase the reference
>     count.  I think someone finally implemented atomic_inc_not_zero(&count) to
>     automate the common case.  Unfortunately this means you must special case the
>     rcu access case.
>     
>     When data structures are only visible via rcu in a manner that is not
>     determined by the reference count on the object (i.e.  tasks are visible until
>     their zombies are reaped) there is a much simpler technique we can employ.
>     Simply delaying the decrement of the reference count until the rcu interval is
>     over.
>     
>     What that means is that the proc code that looks up a task and later
>     wants to sleep can now do:
>     
>     rcu_read_lock();
>     task = find_task_by_pid(some_pid);
>     if (task) {
>             get_task_struct(task);
>     }
>     rcu_read_unlock();
>     
>     The effect on the rest of the kernel is that put_task_struct becomes cheaper
>     and immediate, and in the case where the task has been reaped it frees the
>     task immediate instead of unnecessarily waiting an until the rcu interval is
>     over.
>     
>     Cleanup of task_struct does not happen when its reference count drops to
>     zero, instead cleanup happens when release_task is called.  Tasks can only
>     be looked up via rcu before release_task is called.  All rcu protected
>     members of task_struct are freed by release_task.
>     
>     Therefore we can move call_rcu from put_task_struct into release_task.  And
>     we can modify release_task to not immediately release the reference count
>     but instead have it call put_task_struct from the function it gives to
>     call_rcu.
>     
>     The end result:
>     
>     - get_task_struct is safe in an rcu context where we have just looked
>       up the task.
>     
>     - put_task_struct() simplifies into its old pre rcu self.
>     
>     This reorganization also makes put_task_struct uncallable from modules as
>     it is not exported but it does not appear to be called from any modules so
>     this should not be an issue, and is trivially fixed.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>

About a decade later task_struct grew some new rcu users and Oleg
introduced task_rcu_dereference to deal with them:

> commit 150593bf869393d10a79f6bd3df2585ecc20a9bb
> Author: Oleg Nesterov <oleg@redhat.com>
> Date:   Wed May 18 19:02:18 2016 +0200
> 
>     sched/api: Introduce task_rcu_dereference() and try_get_task_struct()
>     
>     Generally task_struct is only protected by RCU if it was found on a
>     RCU protected list (say, for_each_process() or find_task_by_vpid()).
>     
>     As Kirill pointed out rq->curr isn't protected by RCU, the scheduler
>     drops the (potentially) last reference without RCU gp, this means
>     that we need to fix the code which uses foreign_rq->curr under
>     rcu_read_lock().
>     
>     Add a new helper which can be used to dereference rq->curr or any
>     other pointer to task_struct assuming that it should be cleared or
>     updated before the final put_task_struct(). It returns non-NULL
>     only if this task can't go away before rcu_read_unlock().
>     
>     ( Also add try_get_task_struct() to make it easier to use this API
>       correctly. )

So I think it makes a lot of sense to change how we do this.  Either
moving the rcu delay back into put_task_struct or doing halfway like
creating a put_dead_task_struct that will perform the rcu delay after
a task has been taken off the run queues and has stopped being a zombie.

Something like:
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0497091e40c1..bf323418094e 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -115,7 +115,7 @@ static inline void put_task_struct(struct task_struct *t)
 		__put_task_struct(t);
 }
 
-struct task_struct *task_rcu_dereference(struct task_struct **ptask);
+void put_dead_task_struct(struct task_struct *task);
 
 #ifdef CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT
 extern int arch_task_struct_size __read_mostly;
diff --git a/kernel/exit.c b/kernel/exit.c
index 5b4a5dcce8f8..3a85bc2e8031 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -182,6 +182,24 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 	put_task_struct(tsk);
 }
 
+void put_dead_task_struct(struct task_struct *task)
+{
+	bool delay = false;
+	unsigned long flags;
+
+	/* Is the task both reaped and no longer being scheduled? */
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	if ((task->state == TASK_DEAD) &&
+	    (cmpxchg(&task->exit_state, EXIT_DEAD, EXIT_RCU) == EXIT_DEAD))
+		delay = true;
+	raw_spin_lock_irqrestore(&task->pi_lock, flags);
+
+	/* If both are true use rcu delay the put_task_struct */
+	if (delay)
+		call_rcu(&task->rcu, delayed_put_task_struct);
+	else
+		put_task_struct(task);
+}
 
 void release_task(struct task_struct *p)
 {
@@ -222,76 +240,13 @@ void release_task(struct task_struct *p)
 
 	write_unlock_irq(&tasklist_lock);
 	release_thread(p);
-	call_rcu(&p->rcu, delayed_put_task_struct);
+	put_dead_task_struct(p);
 
 	p = leader;
 	if (unlikely(zap_leader))
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..5b697c0572ce 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3135,7 +3135,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		/* Task is done with its stack. */
 		put_task_stack(prev);
 
-		put_task_struct(prev);
+		put_dead_task_struct(prev);
 	}
 
 	tick_nohz_task_switch();
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc9cfeaac8bd..c3e1a302211a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1644,7 +1644,7 @@ static void task_numa_compare(struct task_numa_env *env,
 		return;
 
 	rcu_read_lock();
-	cur = task_rcu_dereference(&dst_rq->curr);
+	cur = rcu_dereference(&dst_rq->curr);
 	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
 		cur = NULL;
 
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index aa8d75804108..74df8e0dfc84 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -71,7 +71,7 @@ static int membarrier_global_expedited(void)
 			continue;
 
 		rcu_read_lock();
-		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
+		p = rcu_dereference(&cpu_rq(cpu)->curr);
 		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
 				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
 			if (!fallback)
@@ -150,7 +150,7 @@ static int membarrier_private_expedited(int flags)
 		if (cpu == raw_smp_processor_id())
 			continue;
 		rcu_read_lock();
-		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
+		p = rcu_dereference(&cpu_rq(cpu)->curr);
 		if (p && p->mm == current->mm) {
 			if (!fallback)
 				__cpumask_set_cpu(cpu, tmpmask);



Eric
