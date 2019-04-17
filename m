Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF847C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F2E2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D2DW7Bml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfDQHgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:36:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQHgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LpSOMcBlyIhKDhjISPyeoabpIEP0cf1quEet+iani6w=; b=D2DW7BmlhNdsVW2N0qdQU5a4Q
        Rh12MOnXCjmXuA5EvJUsZAN+IntE+AG0sQu2GM5pUT+nQVaD+ML2pB6XKdWlcT4U6lhqDa6rhPPRj
        eZ1tx6efRzTLZPydik65cMcS4dmTXzoyhdmquMC01ihvJJ+7O26gO1DcbR1tvIXQZpYBKIKYGQkMR
        ERe0HsoxVcJqq4S+BF72DY+L2uRGs/BAcnFnrrSuomZULtLLL4J82yJlxhJhJ8HILfKoW11zFvwAr
        lNzhFpcG18y4vdVDP+DQScSYYca10XAscnw/TbEkSehfzTJ/NubqC7aWDFyBfFZP2FXCU0PpOVRiw
        OuD1Wl7Ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGf6v-0005vA-44; Wed, 17 Apr 2019 07:36:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D06F829B5293D; Wed, 17 Apr 2019 09:35:59 +0200 (CEST)
Date:   Wed, 17 Apr 2019 09:35:59 +0200
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
Message-ID: <20190417073559.GZ4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-8-longman@redhat.com>
 <20190416154937.GL12232@hirez.programming.kicks-ass.net>
 <d10586ae-cd86-2992-766b-1ba4a4807b6a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d10586ae-cd86-2992-766b-1ba4a4807b6a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:16:11PM -0400, Waiman Long wrote:

> >> @@ -324,6 +364,12 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
> >>  		adjustment -= RWSEM_FLAG_WAITERS;
> >>  	}
> >>  
> >> +	/*
> >> +	 * Clear the handoff flag
> >> +	 */
> > Right, but that is a trivial comment in the 'increment i' style, it
> > clearly states what the code does, but completely fails to elucidate the
> > code.
> >
> > Maybe:
> >
> > 	/*
> > 	 * When we've woken a reader, we no longer need to force writers
> > 	 * to give up the lock and we can clear HANDOFF.
> > 	 */
> >
> > And I suppose this is required if we were the pickup of the handoff set
> > above, but is there a guarantee that the HANDOFF was not set by a
> > writer?
> 
> I can change the comment. The handoff bit is always cleared in
> rwsem_try_write_lock() when the lock is successfully acquire. Will add a
> comment to document that.

That doesn't help much, because it drops ->wait_lock between setting it
and acquiring it. So the read-acquire can interleave.

I _think_ it works, but I'm having trouble explaining how exactly. I
think because readers don't spin yet and thus wakeups abide by queue
order.

And the other way around should have (write) spinners terminate the
moment they see HANDOFF set by a readers, but I'm not immediately seeing
that either.

I'll continue staring at that.

