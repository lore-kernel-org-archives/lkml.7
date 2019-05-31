Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D30FC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6CC22C7D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559266605;
	bh=AmlRorUBVMJZaHo0Cis43tmnvYXcJMorudKBs2IbYfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YrS4WLh4csuCHI2avNFyC+l1rtJOYBGudoxlTbXIN0IOd8Z/R55QWi/uMKlxl+aPN
	 pEEwnSkNu1IGtlnsEU7dfLAmKDTdBuLywell5urq1Vh2zD0sCdi0nUMMSmwSMkXX8Q
	 vddUwSynUAkmY1ztP1FHWDGBOYNcZiAs2HnCRhMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEaBgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaBgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:36:44 -0400
Received: from localhost (lfbn-1-18355-218.w90-101.abo.wanadoo.fr [90.101.143.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B911C22387;
        Fri, 31 May 2019 01:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559266603;
        bh=AmlRorUBVMJZaHo0Cis43tmnvYXcJMorudKBs2IbYfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+1Gv6Y0d53W6iZFQ7HBc+/KQ57UGTRW5g89FGkr7W6mviqyUwXfKwYhj0Pc0yzWP
         259T3f3SyY3AylyWbCJMSEcucVoKjGxxSDPKgw4HR4JYPXgbycsVvCidUUKyupZScz
         jw/jALLnZPeX8mJGUXGfqPf+ZnjG4KNEMe7wUNXU=
Date:   Fri, 31 May 2019 03:36:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, fweisbec@gmail.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190531013639.GA32307@lerouge>
References: <20190527143932.GA10527@linux.ibm.com>
 <alpine.DEB.2.21.1905281300340.1859@nanos.tec.linutronix.de>
 <20190529181941.GZ28207@linux.ibm.com>
 <20190530125809.GA25376@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530125809.GA25376@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 05:58:09AM -0700, Paul E. McKenney wrote:
>     It turns out that tick_broadcast_offline() was an innocent bystander.
>     After all, interrupts are supposed to be disabled throughout
>     take_cpu_down(), and therefore should have been disabled upon entry to
>     tick_offline_cpu() and thus to tick_broadcast_offline().  This suggests
>     that one of the CPU-hotplug notifiers was incorrectly enabling interrupts,
>     and leaving them enabled on return.
>     
>     Some debugging code showed that the culprit was sched_cpu_dying().
>     It had irqs enabled after return from sched_tick_stop().  Which in turn
>     had irqs enabled after return from cancel_delayed_work_sync().  Which is a
>     wrapper around __cancel_work_timer().  Which can sleep in the case where
>     something else is concurrently trying to cancel the same delayed work,
>     and as Thomas Gleixner pointed out on IRC, sleeping is a decidedly bad
>     idea when you are invoked from take_cpu_down(), regardless of the state
>     you leave interrupts in upon return.

Nice catch! Sorry for leaving that puzzle behind.

>     
>     Code inspection located no reason why the delayed work absolutely
>     needed to be canceled from sched_tick_stop():  The work is not
>     bound to the outgoing CPU by design, given that the whole point is
>     to collect statistics without disturbing the outgoing CPU.
>     
>     This commit therefore simply drops the cancel_delayed_work_sync() from
>     sched_tick_stop().  Instead, a new ->state field is added to the tick_work
>     structure so that the delayed-work handler function sched_tick_remote()
>     can avoid reposting itself.  A cpu_is_offline() check is also added to
>     sched_tick_remote() to avoid mucking with the state of an offlined CPU
>     (though it does appear safe to do so).

I can't guarantee that it is safe myself to call the tick of an offline
CPU. Better have that check indeed.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 102dfcf0a29a..9a10ee9afcbf 100644
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
> +#define TICK_SCHED_REMOTE_IDLE		0

So it took me some time to understand that the IDLE state is the
tick work that ackowledged OFFLINING and finally completes the
offline process. Therefore perhaps we can rename it to
TICK_SCHED_REMOTE_OFFLINE so that we instantly get the state
machine scenario.

> +#define TICK_SCHED_REMOTE_RUNNING	1
> +#define TICK_SCHED_REMOTE_OFFLINING	2
> +
> +// State diagram for ->state:
> +//
> +//
> +//      +----->IDLE-----------------------------+
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
>  
>  static struct tick_work __percpu *tick_work_cpu;
>  
>  static void sched_tick_remote(struct work_struct *work)
>  {
>  	struct delayed_work *dwork = to_delayed_work(work);
> +	int os;
>  	struct tick_work *twork = container_of(dwork, struct tick_work, work);
>  	int cpu = twork->cpu;
>  	struct rq *rq = cpu_rq(cpu);
> @@ -3077,7 +3107,7 @@ static void sched_tick_remote(struct work_struct *work)
>  
>  	rq_lock_irq(rq, &rf);
>  	curr = rq->curr;
> -	if (is_idle_task(curr))
> +	if (is_idle_task(curr) || cpu_is_offline(cpu))

Or we could simply check rq->online, while we have rq locked.

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
> +		WARN_ON_ONCE(os == TICK_SCHED_REMOTE_IDLE);
> +		if (os == TICK_SCHED_REMOTE_RUNNING)
> +			break;
> +	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_IDLE) != os);
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
> +		if (os == TICK_SCHED_REMOTE_RUNNING)

Is it possible to have RUNNING at this stage? sched_tick_start()
shouldn't be called twice without a sched_tick_stop() in the middle.

In which case we should even warn if we meet that value here.

> +			break;
> +		// Either idle or offline for a short period
> +	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_RUNNING) != os);
> +	if (os == TICK_SCHED_REMOTE_IDLE) {
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

I ran the state machine for a few hours inside my head through FWEISBEC_TORTURE
and I see no error message. Which is of course not a guarantee of anything but:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Also, I believe that /* */ is the preferred comment style, FWIW ;-)
