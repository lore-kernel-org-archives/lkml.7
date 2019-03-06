Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63426C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF902064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WJHD6U8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfCFIcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:32:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38708 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbfCFIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VxEQufSkxfx4daBMXnY7yCKUoh7b79A19vdrUWhMAFY=; b=WJHD6U8OC2C2VsJiPKYKcBJ8t
        OQv9bxzu5hjf0ZHUKzm52oQ3mLJHfjpvLxI7NP6yDZxANJQy7ODIuJYgS2EG/g04HNXllSRFrGJal
        wJakq9gKv+ysVIIVva8U1iemmRfj/KduNsR4EvcVDEOjAG19pdNgbzTd83k6v3RFKR21II2FqGRic
        3zcN6eVS9hibJbtz0PdGM5Xv8z04jIIOqX5WBGM2L/cDch45jsAKX3tCaohJ7+6BM4pezFOJktlNg
        bzpGKbUxJTSs1TxP0i/Oz4NBzaZ2pyUNyuNmcUBBYGjm2ww/FOeNRVn5joDMkyPs9zztz+tpP5iDt
        Dwn+Y1x5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1Rwn-0007h5-UA; Wed, 06 Mar 2019 08:30:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5915C20288B9E; Wed,  6 Mar 2019 09:30:39 +0100 (CET)
Date:   Wed, 6 Mar 2019 09:30:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH for 5.1 0/3] Restartable Sequences updates for 5.1
Message-ID: <20190306083039.GS32477@hirez.programming.kicks-ass.net>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
 <1689743723.311.1551817115045.JavaMail.zimbra@efficios.com>
 <20190305215848.GQ32477@hirez.programming.kicks-ass.net>
 <486623963.509.1551825130539.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486623963.509.1551825130539.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 05:32:10PM -0500, Mathieu Desnoyers wrote:

> >> * Adaptative mutex improvements
> >> 
> >> I have done a prototype using rseq to implement an adaptative mutex which
> >> can detect preemption using a rseq critical section. This ensures the
> >> thread doesn't continue to busy-loop after it returns from preemption, and
> >> calls sys_futex() instead. This is part of a user-space prototype branch [2],
> >> and does not require any kernel change.
> > 
> > I'm still not convinced that is actually the right way to go about
> > things. The kernel heuristic is spin while the _owner_ runs, and we
> > don't get preempted, obviously.
> > 
> > And the only userspace spinning that makes sense is to cover the cost of
> > the syscall. Now Obviously PTI wrecked everything, but before that
> > syscalls were actually plenty fast and you didn't need many cmpxchg
> > cycles to amortize the syscall itself -- which could then do kernel side
> > adaptive spinning (when required).
> 
> Indeed with PTI the system calls are back to their slow self. ;)
> 
> You point about owner is interesting. Perhaps there is one tweak that I
> should add in there. We could write the owner thread ID in the lock word.

This is already required for PI (and I think robust) futexes. There have
been proposals for FUTEX_LOCK and FUTEX_UNLOCK (!PI) primitives that
require the same.

Waiman had some patches; but I think all went under because 'important'
stuff happened.

> When trying to grab a lock, one of a few situations can happen:
> 
> - It's unlocked, so we grab it by storing our thread ID,
> - It's locked, and we can fetch the CPU number of the thread owning it
>   if we can access its (struct rseq *)->cpu_id through a lookup using its
>   thread ID, We can then check whether it's the same CPU we are running on.

That might just work with threads (private futexes; which are the
majority these these I think), but will obviously not work with regular
(shared) futexes.

>   - If so, we _know_ we should let the owner run, so we call futex right away,
>     no spinning. We can even boost it for priority inheritance mutexes,
>   - If it's owned by a thread which was last running on a different CPU,
>     then it may make sense to actively try to grab the lock by spinning
>     up to a certain number of loops (which can be either fixed or adaptative).
>     After that limit, call futex. If preempted while looping, call futex.
> 
> Do you see this as an improvement over what exists today, or am I
> on the wrong track ?

That's probably better than what they have today. Last time I looked at
libc pthread I got really sad -- arguably that was a long time ago, and
some of that stuff is because POSIX, but still.

Some day we should redesign all that.. futex2 etc.
