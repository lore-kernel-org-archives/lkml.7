Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05895C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEF42082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M46WGSA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbfIFIYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:24:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51722 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbfIFIYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xVYPN++5cIIM85JchVjIDq7KBYiMudCALZcZl3Pfhdo=; b=M46WGSA7UDpIRJy0xVeLHV27A
        PWN7n8BJXINxvkzbuN5PHCmm8lWkvR/TMaKygMBOPhoxgmm7okgv9qo4SIyVg+6ZdKY5T5BsxzzFz
        nUabzNDCuyyE+xGNmtaVWv62+6/f5rFGphMQEXuJ9vLSnJ6tvD/FdsIJjwG6ZjIqCIqGEBwTGqAte
        +GRUzK0Tgq13FhVHXVDohU9JmhEZ6QJlngh9sPcn9yzn6uwGlOSFfvvnHm4FOPLMrzQWWmvsw+Bnl
        xiQbFcX/ishLl88P9TdOFmVhrg6acO7jMHtqw++0eiKYnvpt5xJDpVcYiOGtwqMXA95Fksvv/OBt9
        /sraKhebg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i69WO-0003fL-5f; Fri, 06 Sep 2019 08:23:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E1C8306027;
        Fri,  6 Sep 2019 10:22:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7AB429DE7809; Fri,  6 Sep 2019 10:23:05 +0200 (CEST)
Date:   Fri, 6 Sep 2019 10:23:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 4/4] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
Message-ID: <20190906082305.GU2349@hirez.programming.kicks-ass.net>
References: <20190906031300.1647-1-mathieu.desnoyers@efficios.com>
 <20190906031300.1647-5-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906031300.1647-5-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 11:13:00PM -0400, Mathieu Desnoyers wrote:

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6a7a1083b6fb..7020572eb605 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -382,6 +382,9 @@ struct mm_struct {
>  		unsigned long task_size;	/* size of task vm space */
>  		unsigned long highest_vm_end;	/* highest vma end address */
>  		pgd_t * pgd;
> +#ifdef CONFIG_MEMBARRIER

Stick in a comment, on why here. To be close to data already used by
switch_mm().

> +		atomic_t membarrier_state;
> +#endif
>  
>  		/**
>  		 * @mm_users: The number of users including userspace.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 010d578118d6..1cffc1aa403c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3038,6 +3038,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
>  	perf_event_task_sched_out(prev, next);
>  	rseq_preempt(prev);
>  	fire_sched_out_preempt_notifiers(prev, next);
> +	membarrier_prepare_task_switch(rq, prev, next);

This had me confused for a while, because I initially thought we'd only
do this for switch_mm(), but you're made it agressive and track kernel
threads too.

I think we can do that slightly different. See below...

>  	prepare_task(next);
>  	prepare_arch_switch(next);
>  }

> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 7e0a0d6535f3..5744c300d29e 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -30,6 +30,28 @@ static void ipi_mb(void *info)

> +void membarrier_execve(struct task_struct *t)
> +{
> +	atomic_set(&t->mm->membarrier_state, 0);
> +	WRITE_ONCE(this_rq()->membarrier_state, 0);

It is the callsite of this one that had me puzzled and confused. I
think it works by accident more than anything else.

You see; I thought the rules were that we'd change it near/before
switch_mm(), and this is quite a way _after_.

I think it might be best to place the call in exec_mmap(), right before
activate_mm().

But that then had me wonder about the membarrier_prepate_task_switch()
thing...

> +/*
> + * The scheduler provides memory barriers required by membarrier between:
> + * - prior user-space memory accesses and store to rq->membarrier_state,
> + * - store to rq->membarrier_state and following user-space memory accesses.
> + * In the same way it provides those guarantees around store to rq->curr.
> + */
> +static inline void membarrier_prepare_task_switch(struct rq *rq,
> +						  struct task_struct *prev,
> +						  struct task_struct *next)
> +{
> +	int membarrier_state = 0;
> +	struct mm_struct *next_mm = next->mm;
> +
> +	if (prev->mm == next_mm)
> +		return;
> +	if (next_mm)
> +		membarrier_state = atomic_read(&next_mm->membarrier_state);
> +	if (READ_ONCE(rq->membarrier_state) != membarrier_state)
> +		WRITE_ONCE(rq->membarrier_state, membarrier_state);
> +}

So if you make the above something like:

static inline void
membarrier_switch_mm(struct rq *rq, struct mm_struct *prev_mm, struct mm_struct *next_mm)
{
	int membarrier_state;

	if (prev_mm == next_mm)
		return;

	membarrier_state = atomic_read(&next_mm->membarrier_state);
	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
		return;

	WRITE_ONCE(rq->membarrier_state, membarrier_state);
}

And put it right in front of switch_mm() in context_switch() then we'll
deal with kernel on the other side, like so:

> @@ -70,16 +90,13 @@ static int membarrier_global_expedited(void)
>  		if (cpu == raw_smp_processor_id())
>  			continue;
>  
> -		rcu_read_lock();
> -		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
> -		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
> -				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
> +		if (READ_ONCE(cpu_rq(cpu)->membarrier_state) &
> +		    MEMBARRIER_STATE_GLOBAL_EXPEDITED) {

		p = rcu_dereference(rq->curr);
		if ((READ_ONCE(cpu_rq(cpu)->membarrier_state) & MEMBARRIER_STATE_GLOBAL_EXPEDITED) &&
		    !(p->flags & PF_KTHREAD))

>  			if (!fallback)
>  				__cpumask_set_cpu(cpu, tmpmask);
>  			else
>  				smp_call_function_single(cpu, ipi_mb, NULL, 1);
>  		}
> -		rcu_read_unlock();
>  	}
>  	if (!fallback) {
>  		preempt_disable();

does that make sense?

(also, I hate how long all these membarrier names are)
