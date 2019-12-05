Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E661C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E45D20659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B3rPScEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfLENWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:22:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41814 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfLENWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sKrRNRvuFeevznsBBMQ+8fO1vB3b1BESp1/N/DR8lIA=; b=B3rPScEiOAsb3Zar8bnuYcybs
        2au44oN93c9dOHlueCZNxaK9r6RRveK1Bsu6PyhN9WFX0+pjNZiQ0uTK8eS60ffBDpxgjTmRHDZbT
        7Atb3yT8Ka0safiubFFepMs7vADqBImgUfL6e1pv3ktbzDvphDWr+H9ZTWMPwHrSwiNM3RKltgu1v
        MOyiYmxwrF+3kvvUPBc+GWqRcgKcQZc5DjoL3+4aO/Z/l+t/xH6aPR3jmQyo6BvfxycV+i7vdt2eH
        HMsrNZYwMPPWOTpXxCaiK3arMR1l40sBDVKGJd4PJb5xYMS+LY8YQysk+aSx2jlHHiQ62VhiPWbje
        GIVybaRpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icr5E-0006qX-RN; Thu, 05 Dec 2019 13:22:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD2B03006E3;
        Thu,  5 Dec 2019 14:20:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F15E12B26E20C; Thu,  5 Dec 2019 14:22:12 +0100 (CET)
Date:   Thu, 5 Dec 2019 14:22:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Problem with WARN_ON in mutex_trylock() and rxrpc
Message-ID: <20191205132212.GK2827@hirez.programming.kicks-ass.net>
References: <26229.1575547344@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26229.1575547344@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 12:02:24PM +0000, David Howells wrote:
> Hi Davidlohr,
> 
> commit a0855d24fc22d49cdc25664fb224caee16998683 ("locking/mutex: Complain upon
> mutex API misuse in IRQ contexts") is a bit of a problem for rxrpc, though
> nothing that shouldn't be reasonably easy to solve, I think.
> 
> What happens is that rxrpc_new_incoming_call(), which is called in softirq
> context, calls mutex_trylock() to prelock a new incoming call:
> 
> 	/* Lock the call to prevent rxrpc_kernel_send/recv_data() and
> 	 * sendmsg()/recvmsg() inconveniently stealing the mutex once the
> 	 * notification is generated.
> 	 *
> 	 * The BUG should never happen because the kernel should be well
> 	 * behaved enough not to access the call before the first notification
> 	 * event and userspace is prevented from doing so until the state is
> 	 * appropriate.
> 	 */
> 	if (!mutex_trylock(&call->user_mutex))
> 		BUG();
> 
> before publishing it.  This used to work fine, but now there are big splashy
> warnings every time a new call comes in.
> 
> No one else can see the lock at this point, but I need to lock it so that
> lockdep doesn't complain later.  However, I can't lock it in the preallocator
> - again because that upsets lockdep.

To recap the IRC discussion; the intended mutex semantics are such to
allow Priority Inheritance. This means that the mutex must be locked and
unlocked in the same (task) context. Otherwise there is no distinct
owner to boost for contending mutex_lock() operations.

Since (soft)irq context doesn't (necessarily) have a task context, these
operations don't strictly make sense, and that is what the patch in
question tries to WARN about.

As it happens, you do mutex_unlock() from the very same softirq context
you do that mutex_trylock() in, so lockdep will never have had cause to
complain, 'current' is the same at acquire and release.

Now, either we're in non-preemptible softirq context and a contending
mutex_lock() would spuriously boost a random task, which is harmless due
to the non-preemptive nature of softirq, or we're running in ksoftirqd
and that gets boosted, which actually makes some sense.

For PREEMPT_RT (the only case that really matters, since that actually
replaces struct mutex with rt_mutex) this would result in boosting
whatever (soft)irq thread ended up running the thing.

(Also, I'm not entire sure on the current softirq model for -RT)

Is this something we want to allow?

At the very least I'm going to do a lockdep patch that verifies the lock
stack is 'empty' for the current irq_context when it changes.
