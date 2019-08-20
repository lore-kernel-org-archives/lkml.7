Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B7AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00FB22DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfHTO7c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:59:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52346 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbfHTO73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:59:29 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i05bb-0000ic-08; Tue, 20 Aug 2019 16:59:27 +0200
Date:   Tue, 20 Aug 2019 16:59:26 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/core: Schedule new worker even if PI-blocked
Message-ID: <20190820145926.jhnpwiicv73z6ol3@linutronix.de>
References: <20190816160626.12742-1-bigeasy@linutronix.de>
 <20190820135014.GQ2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190820135014.GQ2332@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-20 15:50:14 [+0200], Peter Zijlstra wrote:
> On Fri, Aug 16, 2019 at 06:06:26PM +0200, Sebastian Andrzej Siewior wrote:
> > If a task is PI-blocked (blocking on sleeping spinlock) then we don't want to
> > schedule a new kworker if we schedule out due to lock contention because !RT
> > does not do that as well.
> 
>  s/as well/either/
> 
> > A spinning spinlock disables preemption and a worker
> > does not schedule out on lock contention (but spin).
> 
> I'm not much liking this; it means that rt_mutex and mutex have
> different behaviour, and there are 'normal' rt_mutex users in the tree.

There isc RCU (boosting) and futex. I'm sceptical about the i2c users…

> > On RT the RW-semaphore implementation uses an rtmutex so
> > tsk_is_pi_blocked() will return true if a task blocks on it. In this case we
> > will now start a new worker
> 
> I'm confused, by bailing out early it does _NOT_ start a new worker; or
> am I reading it wrong?

s@now@not@. Your eyes work good, soory for that.

> > which may deadlock if one worker is waiting on
> > progress from another worker.
> 
> > Since a RW-semaphore starts a new worker on !RT, we should do the same on RT.
> > 
> > XFS is able to trigger this deadlock.
> > 
> > Allow to schedule new worker if the current worker is PI-blocked.
> 
> Which contradicts earlier parts of this changelog.
> 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/sched/core.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3945,7 +3945,7 @@ void __noreturn do_task_dead(void)
> >  
> >  static inline void sched_submit_work(struct task_struct *tsk)
> >  {
> > -	if (!tsk->state || tsk_is_pi_blocked(tsk))
> > +	if (!tsk->state)
> >  		return;
> >  
> >  	/*
> > @@ -3961,6 +3961,9 @@ static inline void sched_submit_work(str
> >  		preempt_enable_no_resched();
> >  	}
> >  
> > +	if (tsk_is_pi_blocked(tsk))
> > +		return;
> > +
> >  	/*
> >  	 * If we are going to sleep and we have plugged IO queued,
> >  	 * make sure to submit it to avoid deadlocks.
> 
> What do we need that clause for? Why is pi_blocked special _at_all_?

so !RT the scheduler does nothing special if a task blocks on sleeping
lock. 
If I remember correctly then blk_schedule_flush_plug() is the problem.
It may require a lock which is held by the task. 
It may hold A and wait for B while another task has B and waits for A. 
If my memory does bot betray me then ext+jbd can lockup without this.

Sebastian
