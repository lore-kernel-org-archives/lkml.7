Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03300C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD11120578
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FKNBOHiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfHTPU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:20:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfHTPU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lTrxKJWJ1V5+H9Zx2GoSJdvehR3qwMhTd7GGcPVOEKw=; b=FKNBOHiL6fP7kr6OuoTLQFekYS
        fHpSlNehy9ddqSFiY4WutN1Qxf+NwMUUwcAXzQo83E1o5m2Tbtah1DEhxfN1yjItmRTOHM7fiBzlD
        yvhtLlL8ryStM8SD8v1Bjl9RdeehvCisC+rs/ePeftKPPmTP8OCEhFYA+vU9lBZZOsxhXzjZMJ2if
        TTdIvtGZGLTDZCCrKXWs7atQPgNArKJaZntr8BGuWzj5JjtnPs866/Pwf2ffSyezjlJGxj1fpJ6CY
        HXoE9pKPQxGv59sYVRoEmr50yjbiaNc2YfqGqBK9hFX6t4Gj5vYeCp+JWYVPCfw+gNo9Xa7hCPXdg
        u/koS1qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i05vu-0001KK-VL; Tue, 20 Aug 2019 15:20:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D2ACE3075FF;
        Tue, 20 Aug 2019 17:19:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22AB720CF5B03; Tue, 20 Aug 2019 17:20:25 +0200 (CEST)
Date:   Tue, 20 Aug 2019 17:20:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/core: Schedule new worker even if PI-blocked
Message-ID: <20190820152025.GU2349@hirez.programming.kicks-ass.net>
References: <20190816160626.12742-1-bigeasy@linutronix.de>
 <20190820135014.GQ2332@hirez.programming.kicks-ass.net>
 <20190820145926.jhnpwiicv73z6ol3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190820145926.jhnpwiicv73z6ol3@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 04:59:26PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-20 15:50:14 [+0200], Peter Zijlstra wrote:
> > On Fri, Aug 16, 2019 at 06:06:26PM +0200, Sebastian Andrzej Siewior wrote:
> > > If a task is PI-blocked (blocking on sleeping spinlock) then we don't want to
> > > schedule a new kworker if we schedule out due to lock contention because !RT
> > > does not do that as well.
> > 
> >  s/as well/either/
> > 
> > > A spinning spinlock disables preemption and a worker
> > > does not schedule out on lock contention (but spin).
> > 
> > I'm not much liking this; it means that rt_mutex and mutex have
> > different behaviour, and there are 'normal' rt_mutex users in the tree.
> 
> There isc RCU (boosting) and futex. I'm sceptical about the i2c users…

Well, yes, I too was/am sceptical, but it was tglx who twisted my arm
and said the i2c people were right and rt_mutex is/should-be a generic
usable interface.

This then resulted in the futex specific interface and lockdep support
for rt_mutex:

  5293c2efda37 ("futex,rt_mutex: Provide futex specific rt_mutex API")
  f5694788ad8d ("rt_mutex: Add lockdep annotations")

> > > On RT the RW-semaphore implementation uses an rtmutex so
> > > tsk_is_pi_blocked() will return true if a task blocks on it. In this case we
> > > will now start a new worker
> > 
> > I'm confused, by bailing out early it does _NOT_ start a new worker; or
> > am I reading it wrong?
> 
> s@now@not@. Your eyes work good, soory for that.

All good, just trying to make sense of things :-)

> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -3945,7 +3945,7 @@ void __noreturn do_task_dead(void)
> > >  
> > >  static inline void sched_submit_work(struct task_struct *tsk)
> > >  {
> > > -	if (!tsk->state || tsk_is_pi_blocked(tsk))
> > > +	if (!tsk->state)
> > >  		return;
> > >  
> > >  	/*

So this part actually makes rt_mutex less special and is good.

> > > @@ -3961,6 +3961,9 @@ static inline void sched_submit_work(str
> > >  		preempt_enable_no_resched();
> > >  	}
> > >  
> > > +	if (tsk_is_pi_blocked(tsk))
> > > +		return;
> > > +
> > >  	/*
> > >  	 * If we are going to sleep and we have plugged IO queued,
> > >  	 * make sure to submit it to avoid deadlocks.
> > 
> > What do we need that clause for? Why is pi_blocked special _at_all_?
> 
> so !RT the scheduler does nothing special if a task blocks on sleeping
> lock. 
> If I remember correctly then blk_schedule_flush_plug() is the problem.
> It may require a lock which is held by the task. 
> It may hold A and wait for B while another task has B and waits for A. 
> If my memory does bot betray me then ext+jbd can lockup without this.

And am I right in thinking that that, again, is specific to the
sleeping-spinlocks from PREEMPT_RT? Is there really nothing else that
identifies those more specifically? It's been a while since I looked at
them.

Also, I suppose it would be really good to put that in a comment.
