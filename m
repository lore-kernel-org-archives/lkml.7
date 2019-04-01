Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40B8C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7C220857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="naz5PB4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbfDAIcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:32:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35876 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbfDAIcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZiqamekpcbOgOzQb4BcvViC7kD6nWNNZq+kIKhnHbGg=; b=naz5PB4EAxCvqQbEDKvRaLhK0
        CnxxdXelaHxsz5uhczWHeGeKT0/cHYMuqhlrQTPq8f1qqYeMcyWHkloy1lyn3HGd8pxz1RQ9a4/so
        t+Lyq/ee6dhVVouABB3KsStqXvVuNMVM5APOBUjAyfXEqaIb0ElR+KyQqrSWyt5H0X9n6M8Rjq4Ve
        LHV2Rn9u85dBYFMKhpXphym/zcmzkdk7ZoN6IyV1QQRnNayHY11ZYnsh5NO0J1tN5yy4MXzn2vgTm
        rmN0pYG+TLiC9e5UnVvxOSkChJmCjUd21ZwCgI/hbFSlN75Pt2ep4PpIbR/zEXuEFrrT6mFVEwNEA
        G9uGVMd1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAsMY-0007Xe-IA; Mon, 01 Apr 2019 08:32:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7ED72026BE95; Mon,  1 Apr 2019 10:32:11 +0200 (CEST)
Date:   Mon, 1 Apr 2019 10:32:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH tip/core/rcu 2/2] rcu: Check for wakeup-safe conditions
 in rcu_read_unlock_special()
Message-ID: <20190401083211.GD11158@hirez.programming.kicks-ass.net>
References: <20190329182608.GA23877@linux.ibm.com>
 <20190329182634.24994-2-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329182634.24994-2-paulmck@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 11:26:34AM -0700, Paul E. McKenney wrote:
> When RCU core processing is offloaded from RCU_SOFTIRQ to the rcuc
> kthreads, a full and unconditional wakeup is required to initiate RCU
> core processing.  In contrast, when RCU core processing is carried
> out by RCU_SOFTIRQ, a raise_softirq() suffices.  Of course, there are
> situations where raise_softirq() does a full wakeup, but these do not
> occur with normal usage of rcu_read_unlock().

Do we have a comment somewhere explaining why?

> The initial solution to this problem was to use set_tsk_need_resched() and
> set_preempt_need_resched() to force a future context switch, which allows
> rcu_preempt_note_context_switch() to report the deferred quiescent state
> to RCU's core processing.  Unfortunately for expedited grace periods,
> there can be a significant delay between the call for a context switch
> and the actual context switch.

This is all PREEMPT=y kernels, right? Where is the latency coming from?
Because PREEMPT=y _should_ react quite quickly.

> This commit therefore introduces a ->deferred_qs flag to the task_struct
> structure's rcu_special structure.  This flag is initially false, and
> is set to true by the first call to rcu_read_unlock() requiring special
> attention, then finally reset back to false when the quiescent state is
> finally reported.  Then rcu_read_unlock() attempts full wakeups only when
> ->deferred_qs is false, that is, on the first rcu_read_unlock() requiring
> special attention.  Note that a chain of RCU readers linked by some other
> sort of reader may find that a later rcu_read_unlock() is once again able
> to do a full wakeup, courtesy of an intervening preemption:
> 
> 	rcu_read_lock();
> 	/* preempted */
> 	local_irq_disable();
> 	rcu_read_unlock(); /* Can do full wakeup, sets ->deferred_qs. */
> 	rcu_read_lock();
> 	local_irq_enable();
> 	preempt_disable()
> 	rcu_read_unlock(); /* Cannot do full wakeup, ->deferred_qs set. */
> 	rcu_read_lock();
> 	preempt_enable();
> 	/* preempted, >deferred_qs reset. */

As it would have without ->deferred_sq and just having done the above
which was deemed insufficient.

So I'm really puzzled by the need for all this.

> 	local_irq_disable();
> 	rcu_read_unlock(); /* Can again do full wakeup, sets ->deferred_qs. */
> 
> Such linked RCU readers do not yet seem to appear in the Linux kernel, and
> it is probably best if they don't.  However, RCU needs to handle them, and
> some variations on this theme could make even raise_softirq() unsafe due to
> the possibility of its doing a full wakeup.  This commit therefore also
> avoids invoking raise_softirq() when the ->deferred_qs set flag is set.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/sched.h    |  2 +-
>  kernel/rcu/tree_plugin.h | 19 ++++++++++++++-----
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1549584a1538..3164b6798fe5 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -566,7 +566,7 @@ union rcu_special {
>  		u8			blocked;
>  		u8			need_qs;
>  		u8			exp_hint; /* Hint for performance. */
> -		u8			pad; /* No garbage from compiler! */
> +		u8			deferred_qs;
>  	} b; /* Bits. */
>  	u32 s; /* Set of bits. */
>  };
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 21611862e083..75110ea75d01 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -455,6 +455,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  		local_irq_restore(flags);
>  		return;
>  	}
> +	t->rcu_read_unlock_special.b.deferred_qs = false;
>  	if (special.b.need_qs) {
>  		rcu_qs();
>  		t->rcu_read_unlock_special.b.need_qs = false;
> @@ -605,16 +606,24 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  	local_irq_save(flags);
>  	irqs_were_disabled = irqs_disabled_flags(flags);
>  	if (preempt_bh_were_disabled || irqs_were_disabled) {
> -		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> -		/* Need to defer quiescent state until everything is enabled. */
> -		if (irqs_were_disabled && use_softirq) {
> -			/* Enabling irqs does not reschedule, so... */
> +		t->rcu_read_unlock_special.b.exp_hint = false;
> +		// Need to defer quiescent state until everything is enabled.
> +		if (irqs_were_disabled && use_softirq &&
> +		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
> +			// Using softirq, safe to awaken, and we get
> +			// no help from enabling irqs, unlike bh/preempt.
>  			raise_softirq_irqoff(RCU_SOFTIRQ);
> +		} else if (irqs_were_disabled && !use_softirq &&
> +			   !t->rcu_read_unlock_special.b.deferred_qs) {
> +			// Safe to awaken and we get no help from enabling
> +			// irqs, unlike bh/preempt.
> +			invoke_rcu_core();
>  		} else {
> -			/* Enabling BH or preempt does reschedule, so... */
> +			// Enabling BH or preempt does reschedule, so...
>  			set_tsk_need_resched(current);
>  			set_preempt_need_resched();
>  		}
> +		t->rcu_read_unlock_special.b.deferred_qs = true;
>  		local_irq_restore(flags);
>  		return;
>  	}

That is all quite horrible and begging for sane solution. Would not
something like:

static void rcu_force_resched(struct irq_work *work)
{
	set_tsk_need_resched(current);
	set_preempt_need_resched();
}


	if (irqs_were_disabled)
		irq_work_queue(&t->irq_work, rcu_force_resched);


Solve the whole thing?
