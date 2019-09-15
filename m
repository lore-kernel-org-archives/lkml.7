Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB43C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 14:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C072214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568557938;
	bh=9CIz5cIANl7TBTZ36u1/+wNQozhW0QXXyrYwAO3nbz4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=AOgzltyK5wlHFdSwr7vwO10gC7jsHpr4ipFN/srPcbfPiHWTq8foD49dTWkwfhkej
	 Vrynz85ZygnT/416WNnTMAnEPTT0hvfacGoYxCzx92xcnovVTyVQQgdyK4l9XoaBfi
	 o82+6HXLVIdCre8x7pBAH4QjGTrfiT4ie6t/JUFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbfIOOcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 10:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731350AbfIOOcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 10:32:17 -0400
Received: from paulmck-ThinkPad-P72 (96-84-246-146-static.hfc.comcastbusiness.net [96.84.246.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3675C214C6;
        Sun, 15 Sep 2019 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568557935;
        bh=9CIz5cIANl7TBTZ36u1/+wNQozhW0QXXyrYwAO3nbz4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1iuzgtYyOM6yt5xkIZ6DeI4Ixk3lDrN3+HRhYVOQeRrfFqMLlnpyNN6Is2PD09zgd
         OQIjzyfWyc31T3j8Y9XO7mN6BQPNJzOw6LdEoAxhMu5XkpY6Z7k4gBH4o6XE6ZbhqF
         S7mcQ8mdJkBRE2I4Hg9WHNQ6c3olObnAEWpqWZyU=
Date:   Sun, 15 Sep 2019 07:32:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 3/4] task: With a grace period after
 finish_task_switch, remove unnecessary code
Message-ID: <20190915143212.GK30224@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
 <87lfurdpk9.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfurdpk9.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 07:34:30AM -0500, Eric W. Biederman wrote:
> 
> Remove work arounds that were written before there was a grace period
> after tasks left the runqueue in finish_task_switch.
> 
> In particular now that there tasks exiting the runqueue exprience
> a rcu grace period none of the work performed by task_rcu_dereference
> excpet the rcu_dereference is necessary so replace task_rcu_dereference
> with rcu_dereference.
> 
> Remove the code in rcuwait_wait_event that checks to ensure the current
> task has not exited.  It is no longer necessary as it is guaranteed
> that any running task will experience a rcu grace period after it
> leaves the run queueue.
> 
> Remove the comment in rcuwait_wake_up as it is no longer relevant.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Ref: 8f95c90ceb54 ("sched/wait, RCU: Introduce rcuwait machinery")
> Ref: 150593bf8693 ("sched/api: Introduce task_rcu_dereference() and try_get_task_struct()")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

First, what am I looking for?

I am looking for something that prevents the following:

o	Task A acquires a reference to Task B's task_struct while
	protected only by RCU, and is just about to increment ->rcu_users
	when it is delayed.  Maybe its vCPU is preempted or something.

o	Task B begins exiting.

o	Task B removes itself from all the lists.  (Which doesn't
	matter to Task A, which already has an RCU-protected reference
	to Task B's task_struct structure.

o	Task B does a bunch of stuff protected by various locks and atomic
	operations, but does not wait for an RCU grace period to elapse.
	(Or am I wrong about that?)

o	Task B does its final context switch, invoking finish_task_switch(),
	in turn invoking put_task_struct_rcu_user(), which does the
	final decrement of ->rcu_user to zero.	And then immediately
	overwrites that value by invoking call_rcu().

o	Task A resumes, sees a (bogus) non-zero ->rcu_user and proceeds
	to mangle the freelist.  Or worse yet, something just now
	allocated as some other data structure.

(If this really can happen, one easy fix is of course to remove the
union so that ->rcu and ->rcu_users don't sit on top of each other.)

With that, on to the patch!

Which does not do anything that I can see to prevent the above sequence
of events.

On to the next patch!

							Thanx, Paul

> ---
>  include/linux/rcuwait.h    | 20 +++---------
>  include/linux/sched/task.h |  1 -
>  kernel/exit.c              | 67 --------------------------------------
>  kernel/sched/fair.c        |  2 +-
>  kernel/sched/membarrier.c  |  4 +--
>  5 files changed, 7 insertions(+), 87 deletions(-)
> 
> diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
> index 563290fc194f..75c97e4bbc57 100644
> --- a/include/linux/rcuwait.h
> +++ b/include/linux/rcuwait.h
> @@ -6,16 +6,11 @@
>  
>  /*
>   * rcuwait provides a way of blocking and waking up a single
> - * task in an rcu-safe manner; where it is forbidden to use
> - * after exit_notify(). task_struct is not properly rcu protected,
> - * unless dealing with rcu-aware lists, ie: find_task_by_*().
> + * task in an rcu-safe manner.
>   *
> - * Alternatively we have task_rcu_dereference(), but the return
> - * semantics have different implications which would break the
> - * wakeup side. The only time @task is non-nil is when a user is
> - * blocked (or checking if it needs to) on a condition, and reset
> - * as soon as we know that the condition has succeeded and are
> - * awoken.
> + * The only time @task is non-nil is when a user is blocked (or
> + * checking if it needs to) on a condition, and reset as soon as we
> + * know that the condition has succeeded and are awoken.
>   */
>  struct rcuwait {
>  	struct task_struct __rcu *task;
> @@ -37,13 +32,6 @@ extern void rcuwait_wake_up(struct rcuwait *w);
>   */
>  #define rcuwait_wait_event(w, condition)				\
>  ({									\
> -	/*								\
> -	 * Complain if we are called after do_exit()/exit_notify(),     \
> -	 * as we cannot rely on the rcu critical region for the		\
> -	 * wakeup side.							\
> -	 */                                                             \
> -	WARN_ON(current->exit_state);                                   \
> -									\
>  	rcu_assign_pointer((w)->task, current);				\
>  	for (;;) {							\
>  		/*							\
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 4c44c37236b2..8bd51af44bf8 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -115,7 +115,6 @@ static inline void put_task_struct(struct task_struct *t)
>  		__put_task_struct(t);
>  }
>  
> -struct task_struct *task_rcu_dereference(struct task_struct **ptask);
>  void put_task_struct_rcu_user(struct task_struct *task);
>  
>  #ifdef CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 2e259286f4e7..f943773622fc 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -234,69 +234,6 @@ void release_task(struct task_struct *p)
>  		goto repeat;
>  }
>  
> -/*
> - * Note that if this function returns a valid task_struct pointer (!NULL)
> - * task->usage must remain >0 for the duration of the RCU critical section.
> - */
> -struct task_struct *task_rcu_dereference(struct task_struct **ptask)
> -{
> -	struct sighand_struct *sighand;
> -	struct task_struct *task;
> -
> -	/*
> -	 * We need to verify that release_task() was not called and thus
> -	 * delayed_put_task_struct() can't run and drop the last reference
> -	 * before rcu_read_unlock(). We check task->sighand != NULL,
> -	 * but we can read the already freed and reused memory.
> -	 */
> -retry:
> -	task = rcu_dereference(*ptask);
> -	if (!task)
> -		return NULL;
> -
> -	probe_kernel_address(&task->sighand, sighand);
> -
> -	/*
> -	 * Pairs with atomic_dec_and_test() in put_task_struct(). If this task
> -	 * was already freed we can not miss the preceding update of this
> -	 * pointer.
> -	 */
> -	smp_rmb();
> -	if (unlikely(task != READ_ONCE(*ptask)))
> -		goto retry;
> -
> -	/*
> -	 * We've re-checked that "task == *ptask", now we have two different
> -	 * cases:
> -	 *
> -	 * 1. This is actually the same task/task_struct. In this case
> -	 *    sighand != NULL tells us it is still alive.
> -	 *
> -	 * 2. This is another task which got the same memory for task_struct.
> -	 *    We can't know this of course, and we can not trust
> -	 *    sighand != NULL.
> -	 *
> -	 *    In this case we actually return a random value, but this is
> -	 *    correct.
> -	 *
> -	 *    If we return NULL - we can pretend that we actually noticed that
> -	 *    *ptask was updated when the previous task has exited. Or pretend
> -	 *    that probe_slab_address(&sighand) reads NULL.
> -	 *
> -	 *    If we return the new task (because sighand is not NULL for any
> -	 *    reason) - this is fine too. This (new) task can't go away before
> -	 *    another gp pass.
> -	 *
> -	 *    And note: We could even eliminate the false positive if re-read
> -	 *    task->sighand once again to avoid the falsely NULL. But this case
> -	 *    is very unlikely so we don't care.
> -	 */
> -	if (!sighand)
> -		return NULL;
> -
> -	return task;
> -}
> -
>  void rcuwait_wake_up(struct rcuwait *w)
>  {
>  	struct task_struct *task;
> @@ -316,10 +253,6 @@ void rcuwait_wake_up(struct rcuwait *w)
>  	 */
>  	smp_mb(); /* (B) */
>  
> -	/*
> -	 * Avoid using task_rcu_dereference() magic as long as we are careful,
> -	 * see comment in rcuwait_wait_event() regarding ->exit_state.
> -	 */
>  	task = rcu_dereference(w->task);
>  	if (task)
>  		wake_up_process(task);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bc9cfeaac8bd..215c640e2a6b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1644,7 +1644,7 @@ static void task_numa_compare(struct task_numa_env *env,
>  		return;
>  
>  	rcu_read_lock();
> -	cur = task_rcu_dereference(&dst_rq->curr);
> +	cur = rcu_dereference(dst_rq->curr);
>  	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
>  		cur = NULL;
>  
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index aa8d75804108..b14250a11608 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -71,7 +71,7 @@ static int membarrier_global_expedited(void)
>  			continue;
>  
>  		rcu_read_lock();
> -		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
> +		p = rcu_dereference(cpu_rq(cpu)->curr);
>  		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
>  				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
>  			if (!fallback)
> @@ -150,7 +150,7 @@ static int membarrier_private_expedited(int flags)
>  		if (cpu == raw_smp_processor_id())
>  			continue;
>  		rcu_read_lock();
> -		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
> +		p = rcu_dereference(cpu_rq(cpu)->curr);
>  		if (p && p->mm == current->mm) {
>  			if (!fallback)
>  				__cpumask_set_cpu(cpu, tmpmask);
> -- 
> 2.21.0.dirty
> 
