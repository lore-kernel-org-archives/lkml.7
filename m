Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A613C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD20F2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569020574;
	bh=vjuJszDGdjNl5fjcZGN5BXjP8AC6EQlRGWZ1X6s6d6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KZUAN9NDi6wnMdR8l2lYIB2i0My3C5MOuv4hvWOpSUaJFZYke60K8M+OUgWYH3x25
	 /IcjLO+0GdEga0qrnKWHBrcUYN0XZ5V0EhjK6qWaTL/bwng4uMlbs+dNI1QHFhp7tT
	 IxZgL0CotgZ47MEOWZErmc/dgO5tphLcKCiTQDLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406986AbfITXCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406972AbfITXCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:02:53 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C74A2073F;
        Fri, 20 Sep 2019 23:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569020572;
        bh=vjuJszDGdjNl5fjcZGN5BXjP8AC6EQlRGWZ1X6s6d6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vdjxsbUL7NEIEibiajio4Qy8Ts7N3BOfyqR92UqAhFtXgvn01uVHNMMZSYJ/trxpN
         AHEA0w7aNheCH0WYiI6EK1xDhnSVp4L6H4o/uc+J9eYjgMbv6cANqvUCykPIL5NP9t
         0449aOnfTWEbCS2QVXNBbkc/O7KUmiMNZMAOsmpM=
Date:   Sat, 21 Sep 2019 01:02:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 4/4] task: RCUify the assignment of rq->curr
Message-ID: <20190920230247.GA6449@lenoir>
References: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
 <87ftkzdpjd.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftkzdpjd.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 07:35:02AM -0500, Eric W. Biederman wrote:
> 
> The current task on the runqueue is currently read with rcu_dereference().
> 
> To obtain ordinary rcu semantics for an rcu_dereference of rq->curr it needs
> to be paird with rcu_assign_pointer of rq->curr.  Which provides the
> memory barrier necessary to order assignments to the task_struct
> and the assignment to rq->curr.
> 
> Unfortunately the assignment of rq->curr in __schedule is a hot path,
> and it has already been show that additional barriers in that code
> will reduce the performance of the scheduler.  So I will attempt to
> describe below why you can effectively have ordinary rcu semantics
> without any additional barriers.
> 
> The assignment of rq->curr in init_idle is a slow path called once
> per cpu and that can use rcu_assign_pointer() without any concerns.
> 
> As I write this there are effectively two users of rcu_dereference on
> rq->curr.  There is the membarrier code in kernel/sched/membarrier.c
> that only looks at "->mm" after the rcu_dereference.  Then there is
> task_numa_compare() in kernel/sched/fair.c.  My best reading of the
> code shows that task_numa_compare only access: "->flags",
> "->cpus_ptr", "->numa_group", "->numa_faults[]",
> "->total_numa_faults", and "->se.cfs_rq".
> 
> The code in __schedule() essentially does:
> 	rq_lock(...);
> 	smp_mb__after_spinlock();
> 
> 	next = pick_next_task(...);
> 	rq->curr = next;
> 
> 	context_switch(prev, next);
> 
> At the start of the function the rq_lock/smp_mb__after_spinlock
> pair provides a full memory barrier.  Further there is a full memory barrier
> in context_switch().
> 
> This means that any task that has already run and modified itself (the
> common case) has already seen two memory barriers before __schedule()
> runs and begins executing.  A task that modifies itself then sees a
> third full memory barrier pair with the rq_lock();
> 
> For a brand new task that is enqueued with wake_up_new_task() there
> are the memory barriers present from the taking and release the
> pi_lock and the rq_lock as the processes is enqueued as well as the
> full memory barrier at the start of __schedule() assuming __schedule()
> happens on the same cpu.
> 
> This means that by the time we reach the assignment of rq->curr
> except for values on the task struct modified in pick_next_task
> the code has the same guarantees as if it used rcu_assign_pointer.
> 
> Reading through all of the implementations of pick_next_task it
> appears pick_next_task is limited to modifying the task_struct fields
> "->se", "->rt", "->dl".  These fields are the sched_entity structures
> of the varies schedulers.
> 
> Further "->se.cfs_rq" is only changed in cgroup attach/move operations
> initialized by userspace.
> 
> Unless I have missed something this means that in practice that the
> users of "rcu_dereerence(rq->curr)" get normal rcu semantics of
> rcu_dereference() for the fields the care about, despite the
> assignment of rq->curr in __schedule() ot using rcu_assign_pointer.
> 
> Link: https://lore.kernel.org/r/20190903200603.GW2349@hirez.programming.kicks-ass.net
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/sched/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 69015b7c28da..668262806942 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3857,7 +3857,11 @@ static void __sched notrace __schedule(bool preempt)
>  
>  	if (likely(prev != next)) {
>  		rq->nr_switches++;
> -		rq->curr = next;
> +		/*
> +		 * RCU users of rcu_dereference(rq->curr) may not see
> +		 * changes to task_struct made by pick_next_task().
> +		 */
> +		RCU_INIT_POINTER(rq->curr, next);

It would be nice to have more explanations in the comments as to why we
don't use rcu_assign_pointer() here (the very fast-path issue) and why
it is expected to be fine (the rq_lock() + post spinlock barrier) under
which condition. Some short summary of the changelog. Because that line
implies way too many subtleties.

Thanks.
