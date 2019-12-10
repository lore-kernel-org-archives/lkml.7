Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA01C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4714720828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pfsP84Zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLJTZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:25:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfLJTZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UGHsupCw3uOoSMyNUG7+Dzli5EixX+ffpw1yo/XpsVs=; b=pfsP84Zyi6h7wAqXcRK9GrQkr
        bipVM/25NLrGrjYo6ZNVSbbjPR+4nFRCxXBJKswT3+cCjNKLe46neN4N7SZTv/ZaNSWNtTZjM9dz7
        ngSjjGnxKCb1G25Y9vAgWCAFvyxuRArELuoFXDNW70rqoPXc1hLtiq13cltmRc45QYwZz+Y35Btiq
        dEXqhg/5Vk/lEfnBbcm2n30OJ/oLCYN3dAUb2LqWk6hvLq0k647b10+koQ0G9uU+r4PeUc+ooCliZ
        cmwphh4OqJ/QeNWkvB75+gu6QZhhzm2nkXm4qsbxYLj39FrbP5aS58j63D6IMBS9Kj49l9vnyyIo4
        ZhE/m05vg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iel8d-0002g2-Na; Tue, 10 Dec 2019 19:25:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17835980D21; Tue, 10 Dec 2019 20:25:38 +0100 (CET)
Date:   Tue, 10 Dec 2019 20:25:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Howells <dhowells@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Problem with WARN_ON in mutex_trylock() and rxrpc
Message-ID: <20191210192538.GB11457@worktop.programming.kicks-ass.net>
References: <26229.1575547344@warthog.procyon.org.uk>
 <20191205132212.GK2827@hirez.programming.kicks-ass.net>
 <87wob4hvyq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wob4hvyq.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 07:33:17PM +0100, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> > On Thu, Dec 05, 2019 at 12:02:24PM +0000, David Howells wrote:

> > To recap the IRC discussion; the intended mutex semantics are such to
> > allow Priority Inheritance. This means that the mutex must be locked and
> > unlocked in the same (task) context. Otherwise there is no distinct
> > owner to boost for contending mutex_lock() operations.
> >
> > Since (soft)irq context doesn't (necessarily) have a task context, these
> > operations don't strictly make sense, and that is what the patch in
> > question tries to WARN about.
> 
> Not only that. Acquiring something which is _NOT_ designed for non
> thread context works by chance not by design. IOW it makes assumptions
> about the underlying mutex implementation and any change to that which
> actually assumes thread context will break that. So, no we don't want
> I'm clever and can do that as the implementation allows, simply because
> this is a blatant layering violation.

AFAICT the only assumption it relies on are:

 - that the softirq will cleanly preempt a task. That is, the task
   context must not change under the softirq execution.

 - that the softirq runs non-preemptible.

Now, both these properties are rather fundamental to how our softirqs
work. And can, therefore, be relied upon, irrespective of the mutex
implementation.

> > As it happens, you do mutex_unlock() from the very same softirq context
> > you do that mutex_trylock() in, so lockdep will never have had cause to
> > complain, 'current' is the same at acquire and release.
> >
> > Now, either we're in non-preemptible softirq context and a contending
> > mutex_lock() would spuriously boost a random task, which is harmless due
> > to the non-preemptive nature of softirq, or we're running in ksoftirqd
> > and that gets boosted, which actually makes some sense.
> >
> > For PREEMPT_RT (the only case that really matters, since that actually
> > replaces struct mutex with rt_mutex) this would result in boosting
> > whatever (soft)irq thread ended up running the thing.
> 
> Well, that'd "work". Actually in RT this makes even sense as the
> contending waiter wants the owner out of the critical region ASAP>

The only funny I could come up with is if current == idle, because in
that case we'll attempt to boost idle. And that is a major no-no. The
proxy execution patches will actually run into this :/

> > (Also, I'm not entire sure on the current softirq model for -RT)
> >
> > Is this something we want to allow?
> 
> I'm not a fan. See above.

Yeah, I'm pretty adverse to it too. But I'm not sure what to suggest
David do instead. Clearly semaphores are an option, but perhaps there's
something better; I've not yet tried to understand his code.
