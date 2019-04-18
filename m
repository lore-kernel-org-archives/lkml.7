Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF073C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A792B217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QUHRDt9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbfDRIWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:22:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfDRIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fffGZjxgGSbdW+iunxhsvxVyGz+RKWHqyA6qeyhzL0E=; b=QUHRDt9Yapr0U7b2YbjqiE3F+
        UPnUMHRz07m18q1ZhFhIPazbeYI45qP3VVBMInjwXPLKOA0ahIVLnhXbwDm267UzVbTQPZyjOKH55
        48xCo1iciMh8HSgzwioBAUQ+PAT7cfcfb3YJkfyl/PM7Z+ru9TwmVLEkfard3zeYUYpeyZ6R4v+7J
        F0bXDd923pxLQco55BvrMkkPkXCYlJLYe15n76QYRZ2jMPleOnpg9tawUrcWFB+u5SsF3eKlA1xXz
        k7J8preZJFxHpwbKMeoL3PLG3L48xgK0690zQiP0oID6EkHhnP1jXl82Pk503yQDlw5zTS0SK1/JE
        FgwVwLVxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH2J6-0007AZ-GX; Thu, 18 Apr 2019 08:22:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07D4429BA67E6; Thu, 18 Apr 2019 10:22:07 +0200 (CEST)
Date:   Thu, 18 Apr 2019 10:22:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 07/16] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Message-ID: <20190418082206.GT12232@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-8-longman@redhat.com>
 <20190416154937.GL12232@hirez.programming.kicks-ass.net>
 <d10586ae-cd86-2992-766b-1ba4a4807b6a@redhat.com>
 <20190417080549.GA4038@hirez.programming.kicks-ass.net>
 <5c869d39-571e-11cb-e9eb-5d785562bfd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c869d39-571e-11cb-e9eb-5d785562bfd1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:39:19PM -0400, Waiman Long wrote:
> On 04/17/2019 04:05 AM, Peter Zijlstra wrote:
> > So what is wrong with the below?
> >
> > --- a/include/linux/sched/wake_q.h
> > +++ b/include/linux/sched/wake_q.h
> > @@ -51,6 +51,11 @@ static inline void wake_q_init(struct wa
> >  	head->lastp = &head->first;
> >  }
> >  
> > +static inline bool wake_q_empty(struct wake_q_head *head)
> > +{
> > +	return head->first == WAKE_Q_TAIL;
> > +}
> > +
> >  extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
> >  extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
> >  extern void wake_up_q(struct wake_q_head *head);
> > --- a/kernel/locking/rwsem.c
> > +++ b/kernel/locking/rwsem.c
> > @@ -700,25 +700,22 @@ __rwsem_down_write_failed_common(struct
> >  		 *     must be read owned; so we try to wake any read lock
> >  		 *     waiters that were queued ahead of us.
> >  		 */
> > -		if (!(count & RWSEM_LOCKED_MASK))
> > -			__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
> > -		else if (!(count & RWSEM_WRITER_MASK) &&
> > -				(count & RWSEM_READER_MASK))
> > -			__rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);
> > -		else
> > +		if (count & RWSEM_WRITER_LOCKED)
> >  			goto wait;
> > -		/*
> > -		 * The wakeup is normally called _after_ the wait_lock
> > -		 * is released, but given that we are proactively waking
> > -		 * readers we can deal with the wake_q overhead as it is
> > -		 * similar to releasing and taking the wait_lock again
> > -		 * for attempting rwsem_try_write_lock().
> > -		 */
> > -		wake_up_q(&wake_q);
> > -		/*
> > -		 * Reinitialize wake_q after use.
> > -		 */
> > -		wake_q_init(&wake_q);
> > +
> > +		__rwsem_mark_wake(sem, (count & RWSEM_READER_MASK) ?
> > +				RWSEM_WAKE_READERS :
> > +				RWSEM_WAKE_ANY, &wake_q);
> > +
> > +		if (!wake_q_empty(&wake_q)) {
> > +			raw_spin_unlock_irq(&sem->wait_lock);
> > +			wake_up_q(&wake_q);
> > +			/* used again, reinit */
> > +			wake_q_init(&wake_q);
> > +			raw_spin_lock_irq(&sem->wait_lock);
> > +			if (rwsem_waiter_is_first(sem, &waiter))
> > +				wstate = WRITER_FIRST;
> > +		}
> >  	} else {
> >  		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
> >  	}
> 
> Yes, we can certainly do that. My point is that I haven't changed the
> existing logic regarding that wakeup, I only move it around in the
> patch. As it is not related to lock handoff, we can do it as a separate
> patch.

Ah, I missed that the old code did that too (too much looking at the new
code I suppose). Then yes, a separate patch fixing this would be good.
