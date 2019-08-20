Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2692DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048B4205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfHTPyG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:54:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52516 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfHTPyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:54:04 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i06SP-0002IT-Jc; Tue, 20 Aug 2019 17:54:01 +0200
Date:   Tue, 20 Aug 2019 17:54:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/core: Schedule new worker even if PI-blocked
Message-ID: <20190820155401.c5apbxjntdz5n2gk@linutronix.de>
References: <20190816160626.12742-1-bigeasy@linutronix.de>
 <20190820135014.GQ2332@hirez.programming.kicks-ass.net>
 <20190820145926.jhnpwiicv73z6ol3@linutronix.de>
 <20190820152025.GU2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190820152025.GU2349@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-20 17:20:25 [+0200], Peter Zijlstra wrote:
> > There isc RCU (boosting) and futex. I'm sceptical about the i2c users…
> 
> Well, yes, I too was/am sceptical, but it was tglx who twisted my arm
> and said the i2c people were right and rt_mutex is/should-be a generic
> usable interface.

I don't mind the generic interface I just find the use-case odd. So by
now rtmutex is used by i2c core and not a single driver like it the case
the last time I looked at it. But still, why is it (PI-boosting)
important for I2C to use it and not for other subsystems? Moving on…

> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -3945,7 +3945,7 @@ void __noreturn do_task_dead(void)
> > > >  
> > > >  static inline void sched_submit_work(struct task_struct *tsk)
> > > >  {
> > > > -	if (!tsk->state || tsk_is_pi_blocked(tsk))
> > > > +	if (!tsk->state)
> > > >  		return;
> > > >  
> > > >  	/*
> 
> So this part actually makes rt_mutex less special and is good.
> 
> > > > @@ -3961,6 +3961,9 @@ static inline void sched_submit_work(str
> > > >  		preempt_enable_no_resched();
> > > >  	}
> > > >  
> > > > +	if (tsk_is_pi_blocked(tsk))
> > > > +		return;
> > > > +
> > > >  	/*
> > > >  	 * If we are going to sleep and we have plugged IO queued,
> > > >  	 * make sure to submit it to avoid deadlocks.
> > > 
> > > What do we need that clause for? Why is pi_blocked special _at_all_?
> > 
> > so !RT the scheduler does nothing special if a task blocks on sleeping
> > lock. 
> > If I remember correctly then blk_schedule_flush_plug() is the problem.
> > It may require a lock which is held by the task. 
> > It may hold A and wait for B while another task has B and waits for A. 
> > If my memory does bot betray me then ext+jbd can lockup without this.
> 
> And am I right in thinking that that, again, is specific to the
> sleeping-spinlocks from PREEMPT_RT? Is there really nothing else that
> identifies those more specifically? It's been a while since I looked at
> them.

Not really. I hacked "int sleeping_lock" into task_struct which is
incremented each time a "sleeping lock" version of rtmutex is requested.
We have two users as of now:
- RCU, which checks if we schedule() while holding rcu_read_lock() which
  is okay if it is a sleeping lock.

- NOHZ's pending softirq detection while going to idle. It is possible
  that "ksoftirqd" and "current" are blocked on locks and the CPU goes
  to idle (because nothing else is runnable) with pending softirqs.

I wanted to let rtmutex invoke another schedule() function in case of a
sleeping lock to avoid the RCU warning. This would avoid incrementing
"sleeping_lock" in the fast path. But then I had no idea what to do with
the NOHZ thing.

> Also, I suppose it would be really good to put that in a comment.
So, what does that mean for that patch. According to my inbox it has
applied to an "urgent" branch. Do I resubmit the whole thing or just a
comment on top?

Sebastian
