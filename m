Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB998C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2CD214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568555683;
	bh=N0vWoqK+eDQvtTNXths4QzYT07cwK9BO7VguOvyN3r0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jd543qY1bezojT15LvQPiTY1fJGxqRfhu/32feJa4oW2ECRbEiSfJ/bdP3Lz7PkXS
	 9aWgJ1lt3yf3kgeUOhDRqmeLb68wPEBIiRhxRR2TeY1Wcg1YLCBEgt9L4EDDiVptaA
	 IGYxMUpzYkUPcpDYhSFsyccsyLlV5Ig4f9PeR6aY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbfIONym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 09:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387483AbfIONym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 09:54:42 -0400
Received: from paulmck-ThinkPad-P72 (96-84-246-146-static.hfc.comcastbusiness.net [96.84.246.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6CC8214C6;
        Sun, 15 Sep 2019 13:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568555680;
        bh=N0vWoqK+eDQvtTNXths4QzYT07cwK9BO7VguOvyN3r0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Loc1Z5rLWnYSj8zzYGBsi/p9aUYvgARlv8P6vpxIU4KXaPK5Mz/PPc7/XRozONJLi
         sw9S9byDp/rCq06YZOn59LC1aQHQlcSdVCyFgO0mDFZKcWZIDy7lLR8WYE1KiRjXHh
         cOotVmyqkpIJZJR3OWblI/V58XAUgZiwSlvRIwEs=
Date:   Sun, 15 Sep 2019 06:54:37 -0700
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
Subject: Re: [PATCH v2 1/4] task: Add a count of task rcu users
Message-ID: <20190915135437.GI30224@paulmck-ThinkPad-P72>
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
 <87woebdplt.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woebdplt.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 07:33:34AM -0500, Eric W. Biederman wrote:
> 
> Add a count of the number of rcu users (currently 1) of the task
> struct so that we can later add the scheduler case and get rid of the
> very subtle task_rcu_dereference, and just use rcu_dereference.
> 
> As suggested by Oleg have the count overlap rcu_head so that no
> additional space in task_struct is required.
> 
> Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
> Inspired-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/sched.h      | 5 ++++-
>  include/linux/sched/task.h | 1 +
>  kernel/exit.c              | 7 ++++++-
>  kernel/fork.c              | 7 +++----
>  4 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9f51932bd543..99a4518b9b17 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1142,7 +1142,10 @@ struct task_struct {
>  
>  	struct tlbflush_unmap_batch	tlb_ubc;
>  
> -	struct rcu_head			rcu;
> +	union {
> +		refcount_t		rcu_users;
> +		struct rcu_head		rcu;
> +	};
>  
>  	/* Cache last used pipe for splice(): */
>  	struct pipe_inode_info		*splice_pipe;
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 0497091e40c1..4c44c37236b2 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -116,6 +116,7 @@ static inline void put_task_struct(struct task_struct *t)
>  }
>  
>  struct task_struct *task_rcu_dereference(struct task_struct **ptask);
> +void put_task_struct_rcu_user(struct task_struct *task);
>  
>  #ifdef CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  extern int arch_task_struct_size __read_mostly;
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 5b4a5dcce8f8..2e259286f4e7 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -182,6 +182,11 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
>  	put_task_struct(tsk);
>  }
>  
> +void put_task_struct_rcu_user(struct task_struct *task)
> +{
> +	if (refcount_dec_and_test(&task->rcu_users))
> +		call_rcu(&task->rcu, delayed_put_task_struct);

We "instantly" transition from the union being ->rcu_user to being ->rcu,
so there needs to be some mechanism that has previously made sure that
nothing is going to attempt to use ->rcu on this task.

We cannot be relying solely on something like atomic_add_unless(),
because call_rcu() will likely result in ->rcu being non-zero.

> +}
>  
>  void release_task(struct task_struct *p)
>  {
> @@ -222,7 +227,7 @@ void release_task(struct task_struct *p)
>  
>  	write_unlock_irq(&tasklist_lock);
>  	release_thread(p);
> -	call_rcu(&p->rcu, delayed_put_task_struct);
> +	put_task_struct_rcu_user(p);

This, along with the pre-existing initialization of ->rcu_user to two 
below gives some hope, at least assuming that release_task() is invoked
after no one can possibly try to increment ->rcu_user.  And in v5.2,
release_task() is invoked from these places:

o	de_thread().  On this one, I must defer to Oleg, Peter, and crew.
	It might be that the list removals while write-holding the
	tasklist_lock do the trick, but that assumes that this lock is
	involved in acquiring a reference.

o	find_child_reaper().  This is invoked via exit_notify() from
	do_exit(), just after the call to exit_tasks_rcu_start().
	This is OK from a Tasks RCU perspective because it is using
	separate synchornization.  Something earlier must prevent
	new ->rcu_user references.

o	wait_task_zombie().  Here is hoping that the check for
	EXIT_DEAD is helpful here.

I am not seeing how this would be safe, but then again this is only the
first patch.  Plus there is much about this use case that I do not know.
OK, on to the other patches...

							Thanx, Paul

>  
>  	p = leader;
>  	if (unlikely(zap_leader))
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2852d0e76ea3..9f04741d5c70 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -900,10 +900,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  	if (orig->cpus_ptr == &orig->cpus_mask)
>  		tsk->cpus_ptr = &tsk->cpus_mask;
>  
> -	/*
> -	 * One for us, one for whoever does the "release_task()" (usually
> -	 * parent)
> -	 */
> +	/* One for the user space visible state that goes away when reaped. */
> +	refcount_set(&tsk->rcu_users, 1);
> +	/* One for the rcu users, and one for the scheduler */
>  	refcount_set(&tsk->usage, 2);
>  #ifdef CONFIG_BLK_DEV_IO_TRACE
>  	tsk->btrace_seq = 0;
> -- 
> 2.21.0.dirty
> 
