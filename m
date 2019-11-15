Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA9AC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4083A20740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573836833;
	bh=iqa2VgMhrt2aB+p1sb2tJk0Xa1Bpa8AmODLk3wv8qjo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ghKJ7bzGERtxqKQIEvRsNsEwoEt0DcvEEx9qlasaa9lJNHQrMcHFmATCEFHGagXC1
	 92Xcbk7DqFntPJrvKDoFCXwAsU8iuUzGpkZxAn01kmGvJLneimNK4G5Gx+/HuyV00O
	 5ME28I+3TLCUcc9A3f7TZ7mWdUyYBkzsKPXIOu8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfKOQxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:53:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbfKOQxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:53:51 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC5332072A;
        Fri, 15 Nov 2019 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573836831;
        bh=iqa2VgMhrt2aB+p1sb2tJk0Xa1Bpa8AmODLk3wv8qjo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GQkkwKerfikMRcMW73319WJPScvBJwOJ7xz2tGoYpCSVwAKeDl3ssWmn6bDsG8UnD
         rOkTc3CdBLY4LTOMTGAFhS6hNy1UafxPrnXsqntB96AeH1CN/wAJy/jMQkxhXy3brH
         LSOEEAVQ4UAjeJwJqNdaSehbl6DjknEZHC41YBXs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 51DA735207BD; Fri, 15 Nov 2019 08:53:50 -0800 (PST)
Date:   Fri, 15 Nov 2019 08:53:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 1/7] rcu: use preempt_count to test whether scheduler
 locks is held
Message-ID: <20191115165350.GV2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-2-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102124559.1135-2-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 12:45:53PM +0000, Lai Jiangshan wrote:
> Ever since preemption was introduced to linux kernel,
> irq disabled spinlocks are always held with preemption
> disabled. One of the reason is that sometimes we need
> to use spin_unlock() which will do preempt_enable()
> to unlock the irq disabled spinlock with keeping irq
> disabled. So preempt_count can be used to test whether
> scheduler locks is possible held.
> 
> CC: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

Again, your point that RCU flavor consolidation allows some
simplifications is an excellent one, so thank you again.

And sorry to be slow, but the interaction with the rest of RCU must
be taken into account.  Therefore, doing this patch series justice
does require some time.

> ---
>  kernel/rcu/tree_plugin.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 0982e9886103..aba5896d67e3 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -603,10 +603,14 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		      tick_nohz_full_cpu(rdp->cpu);
>  		// Need to defer quiescent state until everything is enabled.
>  		if (irqs_were_disabled && use_softirq &&
> -		    (in_interrupt() ||
> -		     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
> +		    (in_interrupt() || (exp && !preempt_bh_were_disabled))) {

My concern here is that this relies on a side-effect of the _irq locking
primitives.  What if someone similar to you comes along and is able to
show significant performance benefits from making raw_spin_lock_irqsave()
and friends leave preempt_count alone?  After all, these primitives
disable interrupts, so the bits in preempt_count can be argued to have
no effect.

But this patch is not central to simplifying __rcu_read_unlock().
Plus RCU now re-enables the scheduler clock tick on nohz_full CPUs that
are blocking normal grace periods, which gives additional flexibility
on this code path -- one of the big concerns when this was written was
that in a PREEMPT=y kernel, a nohz_full CPU spinning in kernel code might
never pass through a quiescent state.  And expedited grace periods need
to be fast on average, not worst case.

So another approach might be to:

1.	Simplfy the above expression to only do raise_softirq_irqoff()
	if we are actually in an interrupt handler.

2.	Make expedited grace periods re-enable the scheduler-clock
	interrupt on CPUs that are slow to pass through quiescent states.
	(Taking care to disable them again, which might require
	coordination with the similar logic in normal grace periods.)

As a second step, it might still be possible to continue using
raise_softirq_irqoff() in some of the non-interrupt-handler cases
involving __rcu_read_unlock() with interrupts disabled.

Thoughts?

						Thanx, Paul

>  			// Using softirq, safe to awaken, and we get
>  			// no help from enabling irqs, unlike bh/preempt.
> +			// in_interrupt(): raise_softirq_irqoff() is
> +			// guaranteed not to not do wakeup
> +			// !preempt_bh_were_disabled: scheduler locks cannot
> +			// be held, since spinlocks are always held with
> +			// preempt_disable(), so the wakeup will be safe.
>  			raise_softirq_irqoff(RCU_SOFTIRQ);
>  		} else {
>  			// Enabling BH or preempt does reschedule, so...
> -- 
> 2.20.1
> 
