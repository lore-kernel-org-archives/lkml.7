Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136AACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB4F20679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S024ARil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbfJ2TGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:06:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43324 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJ2TGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=21xsfraS/2QctRbkK88eSO/iNXjA6ma2luYnvxLO8rk=; b=S024ARils0EqmZtVKnemIJWu6
        BCCfvQM4fSLlJyue7g6YyBGkDV6o6eC1So7YTF/X2LQ8Cgg19UDgLyEc4aiTtCInUdLpG3+YJV/0d
        GVdNEU/dgLKHTc9YD6s0ix9Yv3Wlard+tFum4Q3ve0/i6cscGS/lJ+8IhfCpZsvwaK46XVCbh2Dw5
        LIDJS9Mydk4hqAUg3goOckloh3KQUnNNuStEYy2oJsItGtLliAkupLsFaYSiotV64FJALj5cZ8fp5
        eKFfkcL7fQ0xI7S6DAfHG3Kl+h2mjBf0kE2KJMrkQyCj26TUZlrPVbF72nL755+7swR53NRo+yo9+
        0ux2A6eRQ==;
Received: from [188.207.73.209] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPWp3-00027g-Fi; Tue, 29 Oct 2019 19:06:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 213049802EA; Tue, 29 Oct 2019 20:06:24 +0100 (CET)
Date:   Tue, 29 Oct 2019 20:06:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20191029190624.GB3079@worktop.programming.kicks-ass.net>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190807144305.v55fohssujsqtegb@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807144305.v55fohssujsqtegb@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 03:45:34PM +0100, Will Deacon wrote:
> Hi Peter,
> 
> I've mostly been spared the joys of pcpu rwsem, but I took a look anyway.
> Comments of questionable quality below.

Thanks for having a look, and sorry for being tardy.

> On Mon, Aug 05, 2019 at 04:02:41PM +0200, Peter Zijlstra wrote:

> > +/*
> > + * Called with preemption disabled, and returns with preemption disabled,
> > + * except when it fails the trylock.
> > + */
> > +bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
> >  {
> >  	/*
> >  	 * Due to having preemption disabled the decrement happens on
> >  	 * the same CPU as the increment, avoiding the
> >  	 * increment-on-one-CPU-and-decrement-on-another problem.
> >  	 *
> > -	 * If the reader misses the writer's assignment of readers_block, then
> > -	 * the writer is guaranteed to see the reader's increment.
> > +	 * If the reader misses the writer's assignment of sem->block, then the
> > +	 * writer is guaranteed to see the reader's increment.
> >  	 *
> >  	 * Conversely, any readers that increment their sem->read_count after
> > -	 * the writer looks are guaranteed to see the readers_block value,
> > -	 * which in turn means that they are guaranteed to immediately
> > -	 * decrement their sem->read_count, so that it doesn't matter that the
> > -	 * writer missed them.
> > +	 * the writer looks are guaranteed to see the sem->block value, which
> > +	 * in turn means that they are guaranteed to immediately decrement
> > +	 * their sem->read_count, so that it doesn't matter that the writer
> > +	 * missed them.
> >  	 */
> >  
> > +again:
> >  	smp_mb(); /* A matches D */
> >  
> >  	/*
> > -	 * If !readers_block the critical section starts here, matched by the
> > +	 * If !sem->block the critical section starts here, matched by the
> >  	 * release in percpu_up_write().
> >  	 */
> > -	if (likely(!smp_load_acquire(&sem->readers_block)))
> > -		return 1;
> > +	if (likely(!atomic_read_acquire(&sem->block)))
> > +		return true;
> >  
> >  	/*
> >  	 * Per the above comment; we still have preemption disabled and
> >  	 * will thus decrement on the same CPU as we incremented.
> >  	 */
> > -	__percpu_up_read(sem);
> > +	__percpu_up_read(sem); /* implies preempt_enable() */
> 
> Irritatingly, it also implies an smp_mb() which I don't think we need here.

Hurm.. yes, I think you're right. We have:

	__this_cpu_inc()
	smp_mb()
	if (!atomic_read_acquire(&sem->block))
		return true;
	__percpu_up_read();

Between that smp_mb() and the ACQUIRE there is no way the
__this_cpu_dec() can get hoisted. That is, except if we rely on that
stronger transitivity guarantee (I forgot what we ended up calling it,
and I can't ever find anything in a hurry in memory-barriers.txt).

That said, with Oleg's suggestion getting here is much reduced and when
we do, the cost of actual wakeups is much higher than that of the memory
barrier, so I'm inclined to leave things as they are.

> >  	if (try)
> > -		return 0;
> > +		return false;
> >  
> > -	/*
> > -	 * We either call schedule() in the wait, or we'll fall through
> > -	 * and reschedule on the preempt_enable() in percpu_down_read().
> > -	 */
> > -	preempt_enable_no_resched();
> > +	wait_event(sem->waiters, !atomic_read_acquire(&sem->block));
> 
> Why do you need acquire semantics here? Is the control dependency to the
> increment not enough?

Uuuhhh... let me think about that. Clearly we want ACQUIRE for the
'return true' case, but I'm not sure why I used it here.

> Talking of control dependencies, could we replace the smp_mb() in
> readers_active_check() with smp_acquire__after_ctrl_dep()? In fact, perhaps
> we could remove it altogether, given that our writes will be ordered by
> the dependency and I don't think we care about ordering our reads wrt
> previous readers. Hmm. Either way, clearly not for this patch.

I think we can, but we've never had the need to optimize the slow path
here. The design of this thing has always been that if you hit the
slow-path, you're doing it wrong.

That said, I think cgroups use a variant of percpu-rwsem that wreck rss
on purpose and always take the slowpaths. So it might actually be worth
it.
