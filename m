Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343CBC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB442080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0V/F294/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbfFTMKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:10:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41708 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFTMKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fxW8ydtmH6aRRnWloZEZHdSBP1Wi2WjSp4rL5ESFHAc=; b=0V/F294/nM0p2dOVesrx9jlsz
        xHHKl9MPm/RliH2cpv3pCbwh0Ro1TDNZ7R2+vRTj96aThAWRZRzd7Nka5zj08k3VjRDTXA6JNif1e
        ewh/B79s5Ba65xXT5vwsADn6AMBdyW9bphlzkdZARlC/8nKIpKbscPyTveE6Nw64dWAxykT1B7MjH
        TKwenClVN+jzrVdprBBZenMA1LZc1Z+HhG39fNOFoiRAHOdZYl0y6NPnZo0X2toDkCzyYTE8usEsU
        e7embtxiNjgTnjQq5/Yhx4K0mdJJjYTSjzx7tcQM6/OUY/NX7O6Hu/zKsrk7uVn39h2QatCt3+0sX
        OlLjZVJcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdvtk-0006jI-3S; Thu, 20 Jun 2019 12:10:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 956F9209D2C92; Thu, 20 Jun 2019 14:10:32 +0200 (CEST)
Date:   Thu, 20 Jun 2019 14:10:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        frederic@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190620121032.GU3436@hirez.programming.kicks-ass.net>
References: <20190619181903.GA14233@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619181903.GA14233@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 11:19:03AM -0700, Paul E. McKenney wrote:
> [ Hearing no objections and given no test failures in multiple weeks of
>   rcutorture testing, I intend to submit this to the upcoming merge
>   window.  Thoughts? ]

I can't remember seeing this before; but then, there's a ton of unread
email in the inbox :-(

> Some debugging code showed that the culprit was sched_cpu_dying().
> It had irqs enabled after return from sched_tick_stop().  Which in turn
> had irqs enabled after return from cancel_delayed_work_sync().  Which is a
> wrapper around __cancel_work_timer().  Which can sleep in the case where
> something else is concurrently trying to cancel the same delayed work,
> and as Thomas Gleixner pointed out on IRC, sleeping is a decidedly bad
> idea when you are invoked from take_cpu_down(), regardless of the state
> you leave interrupts in upon return.
> 
> Code inspection located no reason why the delayed work absolutely
> needed to be canceled from sched_tick_stop():  The work is not
> bound to the outgoing CPU by design, given that the whole point is
> to collect statistics without disturbing the outgoing CPU.
> 
> This commit therefore simply drops the cancel_delayed_work_sync() from
> sched_tick_stop().  Instead, a new ->state field is added to the tick_work
> structure so that the delayed-work handler function sched_tick_remote()
> can avoid reposting itself.  A cpu_is_offline() check is also added to
> sched_tick_remote() to avoid mucking with the state of an offlined CPU
> (though it does appear safe to do so).  The sched_tick_start() and
> sched_tick_stop() functions also update ->state, and sched_tick_start()
> also schedules the delayed work if ->state indicates that it is not
> already in flight.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 102dfcf0a29a..8409c83aa5fa 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3050,14 +3050,44 @@ void scheduler_tick(void)
>  
>  struct tick_work {
>  	int			cpu;
> +	int			state;
>  	struct delayed_work	work;
>  };
> +// Values for ->state, see diagram below.
> +#define TICK_SCHED_REMOTE_OFFLINE	0
> +#define TICK_SCHED_REMOTE_RUNNING	1
> +#define TICK_SCHED_REMOTE_OFFLINING	2

That seems a daft set of values; consider { RUNNING, OFFLINING, OFFLINE }
and see below.

> +
> +// State diagram for ->state:
> +//
> +//
> +//      +----->OFFLINE--------------------------+
> +//      |                                       |
> +//      |                                       |
> +//      |                                       | sched_tick_start()
> +//      | sched_tick_remote()                   |
> +//      |                                       |
> +//      |                                       V
> +//      |                        +---------->RUNNING
> +//      |                        |              |
> +//      |                        |              |
> +//      |                        |              |
> +//      |     sched_tick_start() |              | sched_tick_stop()
> +//      |                        |              |
> +//      |                        |              |
> +//      |                        |              |
> +//      +--------------------OFFLINING<---------+
> +//
> +//
> +// Other transitions get WARN_ON_ONCE(), except that sched_tick_remote()
> +// and sched_tick_start() are happy to leave the state in RUNNING.

Can we please stick to old skool C comments?

Also, I find it harder to read that needed, maybe a little something
like so:

/*
 *              OFFLINE
 *               |   ^
 *               |   | tick_remote()
 *               |   |
 *               +--OFFLINING
 *               |   ^
 *  tick_start() |   | tick_stop()
 *               v   |
 *              RUNNING
 */

>  static struct tick_work __percpu *tick_work_cpu;
>  
>  static void sched_tick_remote(struct work_struct *work)
>  {
>  	struct delayed_work *dwork = to_delayed_work(work);
> +	int os;

this should go at the end, reverse xmas tree preference and all that.

>  	struct tick_work *twork = container_of(dwork, struct tick_work, work);
>  	int cpu = twork->cpu;
>  	struct rq *rq = cpu_rq(cpu);
> @@ -3077,7 +3107,7 @@ static void sched_tick_remote(struct work_struct *work)
>  
>  	rq_lock_irq(rq, &rf);
>  	curr = rq->curr;
> -	if (is_idle_task(curr))
> +	if (is_idle_task(curr) || cpu_is_offline(cpu))
>  		goto out_unlock;
>  
>  	update_rq_clock(rq);
> @@ -3097,13 +3127,22 @@ static void sched_tick_remote(struct work_struct *work)
>  	/*
>  	 * Run the remote tick once per second (1Hz). This arbitrary
>  	 * frequency is large enough to avoid overload but short enough
> -	 * to keep scheduler internal stats reasonably up to date.
> +	 * to keep scheduler internal stats reasonably up to date.  But
> +	 * first update state to reflect hotplug activity if required.
>  	 */
> -	queue_delayed_work(system_unbound_wq, dwork, HZ);
> +	do {
> +		os = READ_ONCE(twork->state);
> +		WARN_ON_ONCE(os == TICK_SCHED_REMOTE_OFFLINE);
> +		if (os == TICK_SCHED_REMOTE_RUNNING)
> +			break;
> +	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_OFFLINE) != os);
> +	if (os == TICK_SCHED_REMOTE_RUNNING)
> +		queue_delayed_work(system_unbound_wq, dwork, HZ);
>  }
>  
>  static void sched_tick_start(int cpu)
>  {
> +	int os;
>  	struct tick_work *twork;
>  
>  	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
> @@ -3112,14 +3151,23 @@ static void sched_tick_start(int cpu)
>  	WARN_ON_ONCE(!tick_work_cpu);
>  
>  	twork = per_cpu_ptr(tick_work_cpu, cpu);
> -	twork->cpu = cpu;
> -	INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
> -	queue_delayed_work(system_unbound_wq, &twork->work, HZ);
> +	do {
> +		os = READ_ONCE(twork->state);
> +		if (WARN_ON_ONCE(os == TICK_SCHED_REMOTE_RUNNING))
> +			break;
> +		// Either idle or offline for a short period
> +	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_RUNNING) != os);
> +	if (os == TICK_SCHED_REMOTE_OFFLINE) {
> +		twork->cpu = cpu;
> +		INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
> +		queue_delayed_work(system_unbound_wq, &twork->work, HZ);
> +	}
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  static void sched_tick_stop(int cpu)
>  {
> +	int os;
>  	struct tick_work *twork;
>  
>  	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
> @@ -3128,7 +3176,13 @@ static void sched_tick_stop(int cpu)
>  	WARN_ON_ONCE(!tick_work_cpu);
>  
>  	twork = per_cpu_ptr(tick_work_cpu, cpu);
> -	cancel_delayed_work_sync(&twork->work);
> +	// There cannot be competing actions, but don't rely on stop_machine.
> +	do {
> +		os = READ_ONCE(twork->state);
> +		WARN_ON_ONCE(os != TICK_SCHED_REMOTE_RUNNING);
> +		// Either idle or offline for a short period
> +	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_OFFLINING) != os);
> +	// Don't cancel, as this would mess up the state machine.
>  }
>  #endif /* CONFIG_HOTPLUG_CPU */

While not wrong, it seems overly complicated; can't we do something
like:

tick:
	state = atomic_read(->state);
	if (state) {
		WARN_ON_ONCE(state != OFFLINING);
		if (atomic_inc_not_zero(->state))
			return;
	}
	queue_delayed_work();


stop:
	/*
	 * This is hotplug; even without stop-machine, there cannot be
	 * concurrency on offlining specific CPUs.
	 */
	state = atomic_read(->state);
	WARN_ON_ONCE(state != RUNNING);
	atomic_set(->state, OFFLINING);


start:
	state = atomic_xchg(->state, RUNNING);
	WARN_ON_ONCE(state == RUNNING);
	if (state == OFFLINE) {
		// ...
		queue_delayed_work();
	}


