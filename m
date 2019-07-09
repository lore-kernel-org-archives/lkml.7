Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49F8C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E29C20844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfGINYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:24:46 -0400
Received: from mail.sssup.it ([193.205.80.98]:38767 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfGINYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:24:45 -0400
Received: from [10.30.3.195] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 140673049; Tue, 09 Jul 2019 15:24:41 +0200
Date:   Tue, 9 Jul 2019 15:24:36 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH 3/6] sched/dl: Try better placement even for
 deadline tasks that do not block
Message-ID: <20190709152436.51825f98@luca64>
In-Reply-To: <20190708135536.GK3402@hirez.programming.kicks-ass.net>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
        <20190506044836.2914-4-luca.abeni@santannapisa.it>
        <20190708135536.GK3402@hirez.programming.kicks-ass.net>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, 8 Jul 2019 15:55:36 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, May 06, 2019 at 06:48:33AM +0200, Luca Abeni wrote:
> > @@ -1223,8 +1250,17 @@ static void update_curr_dl(struct rq *rq)
> >  			dl_se->dl_overrun = 1;
> >  
> >  		__dequeue_task_dl(rq, curr, 0);
> > -		if (unlikely(dl_se->dl_boosted
> > || !start_dl_timer(curr)))
> > +		if (unlikely(dl_se->dl_boosted
> > || !start_dl_timer(curr))) { enqueue_task_dl(rq, curr,
> > ENQUEUE_REPLENISH); +#ifdef CONFIG_SMP
> > +		} else if (dl_se->dl_adjust) {
> > +			if (rq->migrating_task == NULL) {
> > +				queue_balance_callback(rq,
> > &per_cpu(dl_migrate_head, rq->cpu), migrate_dl_task);  
> 
> I'm not entirely sure about this one.
> 
> That is, we only do those callbacks from:
> 
>   schedule_tail()
>   __schedule()
>   rt_mutex_setprio()
>   __sched_setscheduler()
> 
> and the above looks like it can happen outside of those.

Sorry, I did not know the constraints or requirements for using
queue_balance_callback()...

I used it because I wanted to trigger a migration from
update_curr_dl(), but invoking double_lock_balance() from this function
obviously resulted in a warning. So, I probably misunderstood the
purpose of the balance callback API, and I misused it.

What would have been the "right way" to trigger a migration for a task
when it is throttled?


> 
> The pattern in those sites is:
> 
> 	rq_lock();
> 	... do crap that leads to queue_balance_callback()
> 	rq_unlock()
> 	if (rq->balance_callback) {
> 		raw_spin_lock_irqsave(rq->lock, flags);
> 		... do callbacks
> 		raw_spin_unlock_irqrestore(rq->lock, flags);
> 	}
> 
> So I suppose can catch abuse of this API by doing something like the
> below; can you validate?

Sorry; right now I cannot run tests on big.LITTLE machines... 
Maybe Dietmar (added in cc), who is working on mainlining this patcset,
can test?



				Thanks,
					Luca

> 
> ---
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index aaca0e743776..89e615f1eae6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1134,6 +1134,14 @@ static inline void rq_pin_lock(struct rq *rq,
> struct rq_flags *rf) rf->cookie = lockdep_pin_lock(&rq->lock);
>  
>  #ifdef CONFIG_SCHED_DEBUG
> +#ifdef CONFIG_SMP
> +	/*
> +	 * There should not be pending callbacks at the start of
> rq_lock();
> +	 * all sites that handle them flush them at the end.
> +	 */
> +	WARN_ON_ONCE(rq->balance_callback);
> +#endif
> +
>  	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
>  	rf->clock_update_flags = 0;
>  #endif

