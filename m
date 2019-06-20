Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46109C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2F82084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="osV60pJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfFTVK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:10:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfFTVKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5PW4XZmchu+Ac4QXAmqxzBgwKjq7Qa2xaIQiv21ft7E=; b=osV60pJeOxlnA0nBYxb6H6iEL
        QD+A5Xyszd79qwuxf/BTivUsNmY8boZjaDaojawGFTn56QfsDcLcdyAhLsY5XIPn8nfCcfugeBg8W
        7y8pcyulw47UhinYfwmbkCsgNiwcHiIwLrYnrKjg9vm09ZFG/8+0Zn6QrdOu1tEsUttoYZJWSlD9e
        XvHhEwbUJaJWy/vSiVKRA20OnCstqh9Tf7xMUT1EBzNSjUjftAVGuh47FqUU0pVXOWT1RKItIPd1U
        tEhN84+rL0k8lRKJpJ9OUjV+9Y7ha4UszeNIYnFUnUbB/crgM00uKs8SO3Ocyc2qjGFOO6Y5I/Iyx
        gkbvWlTbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he4K5-0001NI-OL; Thu, 20 Jun 2019 21:10:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6C4C2021E583; Thu, 20 Jun 2019 23:10:19 +0200 (CEST)
Date:   Thu, 20 Jun 2019 23:10:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        frederic@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190620211019.GA3436@hirez.programming.kicks-ass.net>
References: <20190619181903.GA14233@linux.ibm.com>
 <20190620121032.GU3436@hirez.programming.kicks-ass.net>
 <20190620160118.GQ26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620160118.GQ26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 09:01:18AM -0700, Paul E. McKenney wrote:

> > > +#define TICK_SCHED_REMOTE_OFFLINE	0
> > > +#define TICK_SCHED_REMOTE_RUNNING	1
> > > +#define TICK_SCHED_REMOTE_OFFLINING	2
> > 
> > That seems a daft set of values; consider { RUNNING, OFFLINING, OFFLINE }
> > and see below.
> 
> As in make it an enum?  I could do that.

Enum or define, I don't much care, but the 'natural' ordering of the
states is either: running -> offlining -> offline, or the other way
around, the given order in the patch just didn't make sense.

The one with running=0 just seems to work out nicer.

> > > +
> > > +// State diagram for ->state:
> > > +//
> > > +//
> > > +//      +----->OFFLINE--------------------------+
> > > +//      |                                       |
> > > +//      |                                       |
> > > +//      |                                       | sched_tick_start()
> > > +//      | sched_tick_remote()                   |
> > > +//      |                                       |
> > > +//      |                                       V
> > > +//      |                        +---------->RUNNING
> > > +//      |                        |              |
> > > +//      |                        |              |
> > > +//      |                        |              |
> > > +//      |     sched_tick_start() |              | sched_tick_stop()
> > > +//      |                        |              |
> > > +//      |                        |              |
> > > +//      |                        |              |
> > > +//      +--------------------OFFLINING<---------+
> > > +//
> > > +//
> > > +// Other transitions get WARN_ON_ONCE(), except that sched_tick_remote()
> > > +// and sched_tick_start() are happy to leave the state in RUNNING.

> > Also, I find it harder to read that needed, maybe a little something
> > like so:
> > 
> > /*
> >  *              OFFLINE
> >  *               |   ^
> >  *               |   | tick_remote()
> >  *               |   |
> >  *               +--OFFLINING
> >  *               |   ^
> >  *  tick_start() |   | tick_stop()
> >  *               v   |
> >  *              RUNNING
> >  */
> 
> As in remove the leading "sched_" from the function names?  (The names
> were already there, so I left them be.)

That was just me being lazy, the main part being getting the states in a
linear order, instead of spread around a 2d grid.

> > While not wrong, it seems overly complicated; can't we do something
> > like:
> > 
> > tick:
> 
> As in sched_tick_remote(), right?
> 
> > 	state = atomic_read(->state);
> > 	if (state) {
> 
> You sure you don't want "if (state != RUNNING)"?  But I guess you need
> to understand that RUNNING==0 to understand the atomic_inc_not_zero().

Right..

> 
> > 		WARN_ON_ONCE(state != OFFLINING);
> > 		if (atomic_inc_not_zero(->state))
> 
> This assumes that there cannot be concurrent calls to sched_tick_remote(),
> otherwise, you can end up with ->state==3.  Which is a situation that
> my version does a WARN_ON_ONCE() for, so I guess the only difference is
> that mine would be guaranteed to complain and yours would complain with
> high probability.  So fair enough!

I was assuming there was only a single work per CPU and there'd not be
concurrency on this path.

> > 			return;
> > 	}
> > 	queue_delayed_work();
> > 
> > 
> > stop:
> > 	/*
> > 	 * This is hotplug; even without stop-machine, there cannot be
> > 	 * concurrency on offlining specific CPUs.
> > 	 */
> > 	state = atomic_read(->state);
> 
> There cannot be a sched_tick_stop() or sched_tick_stop(), but there really
> can be a sched_tick_remote() right here in the absence of stop-machine,
> can't there?  Or am I missing something other than stop-machine that
> prevents this?

There can be a remote tick, indeed.

> Now, you could argue that concurrency is safe: Either sched_tick_remote()
> sees RUNNING and doesn't touch the value, or it sees offlining and
> sched_tick_stop() makes no further changes,

That was indeed the thinking.

> but I am not sure that this qualifies as simpler...

There is that I suppose. I think my initial version was a little more
complicated, but after a few passes this happened :-)

> > 	WARN_ON_ONCE(state != RUNNING);
> > 	atomic_set(->state, OFFLINING);
> 
> Another option would be to use atomic_xchg() as below instead of the
> atomic_read()/atomic_set() pair.  Would that work for you?

Yes, that works I suppose. Is more expensive, but I don't think we
particularly care about that here.

> > start:
> > 	state = atomic_xchg(->state, RUNNING);
> > 	WARN_ON_ONCE(state == RUNNING);
> > 	if (state == OFFLINE) {
> > 		// ...
> > 		queue_delayed_work();
> > 	}
> 
> This one looks to be an improvement on mine regardless of the other two.


