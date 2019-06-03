Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A05C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECA326FB1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qe9LZdq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfFCQTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:19:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54664 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfFCQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tCvefdLEzZFFnGKYljkJu42dp0wb4UPwJgMz0erD2bs=; b=Qe9LZdq8JvV4H1j8BClRr1eIY
        na0qS+QFSOpMiGx+KxMA4vjS7StYq/Be2T6RY6jWR8BInYLDVsZ5wxrGNy4JHPymgxGIHrNahM/VZ
        Rgr3V+kcOH+6MW6GM4NyKla3IC/7PpC5twZdB1NX0hd5un1ZnkVpxEZeeKmLaiZKf5llwbmqKXkHb
        4vr7kMDuvOYH9bBRsWEyzpH7GHJqzTO8FQd3qF3Gm0UALv15ZsIsKiZQxOk7AjDULqTthckovZpl/
        G/UH7fvmBINUynoswkPEb+rLvq1IFVpICsvh3hlaNCoNuil7UKKGqrmGHrCyTy8UIc8wFr4vNBP5U
        csHxhzQCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXpgC-0004Uf-0H; Mon, 03 Jun 2019 16:19:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C40529BBD36C; Mon,  3 Jun 2019 18:19:22 +0200 (CEST)
Date:   Mon, 3 Jun 2019 18:19:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, hch@lst.de, gkohli@codeaurora.org,
        mingo@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
Message-ID: <20190603161922.GB3402@hirez.programming.kicks-ass.net>
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
 <20190603124401.GB3463@hirez.programming.kicks-ass.net>
 <20190603160953.GA15244@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603160953.GA15244@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 06:09:53PM +0200, Oleg Nesterov wrote:
> On 06/03, Peter Zijlstra wrote:
> >
> > It now also has concurrency on wakeup; but afaict that's harmless, we'll
> > get racing stores of p->state = TASK_RUNNING, much the same as if there
> > was a remote wakeup vs a wait-loop terminating early.
> >
> > I suppose the tracepoint consumers might have to deal with some
> > artifacts there, but that's their problem.
> 
> I guess you mean that trace_sched_waking/wakeup can be reported twice if
> try_to_wake_up(current) races with ttwu_remote(). And ttwu_stat().

Right, one local one remote, and you get them things twice.

> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1990,6 +1990,28 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> > >  	unsigned long flags;
> > >  	int cpu, success = 0;
> > >  
> > > +	if (p == current) {
> > > +		/*
> > > +		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
> > > +		 * == smp_processor_id()'. Together this means we can special
> > > +		 * case the whole 'p->on_rq && ttwu_remote()' case below
> > > +		 * without taking any locks.
> > > +		 *
> > > +		 * In particular:
> > > +		 *  - we rely on Program-Order guarantees for all the ordering,
> > > +		 *  - we're serialized against set_special_state() by virtue of
> > > +		 *    it disabling IRQs (this allows not taking ->pi_lock).
> > > +		 */
> > > +		if (!(p->state & state))
> > > +			goto out;
> > > +
> > > +		success = 1;
> > > +		trace_sched_waking(p);
> > > +		p->state = TASK_RUNNING;
> > > +		trace_sched_woken(p);
>                 ^^^^^^^^^^^^^^^^^
> trace_sched_wakeup(p) ?

Uhm,, yah.

> I see nothing wrong... but probably this is because I don't fully understand
> this change. In particular, I don't really understand who else can benefit from
> this optimization...

Pretty much every wait-loop, where the wakeup happens from IRQ context
on the same CPU, before we've hit schedule().

Now, I've no idea if that's many, but I much prefer to keep this magic
inside try_to_wake_up() than spreading it around.
