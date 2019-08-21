Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ABFC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F4E2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566383529;
	bh=A+iM2fcbvw+d9Qr+hJyFjUYYb+TAcMjZYCiuBg29XNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=egF8cQNVTSnIYVGwj034xGg11e3jN0M/NpxB2ibJ8ImRo7YGJxcIJYaG6CYySkRFZ
	 xyFtf2IV+5l2WMqIb17sB7os3HNqnj6bm2tIQISkUzkqN2zNenGr+kTHVTnMaM7nFo
	 RI6WVjHLrGB2rg3ADznB3FIhe5AifKNv67NmVfEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfHUKcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfHUKcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:32:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A32F42332A;
        Wed, 21 Aug 2019 10:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566383526;
        bh=A+iM2fcbvw+d9Qr+hJyFjUYYb+TAcMjZYCiuBg29XNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wnfiH+LPw4EVdrkSmLcIk7Zd2olnASwh6NoDlI6zKtQxRw5kfxtMR3PVfxGyny/pC
         evcfutPLvZng5VSBB79v3dl2qNSkKxRxQnodbUN/R6qCuIQdRUsr3u97Sm0Lq1RbYC
         A9kK9RJCZRFQv8ny+jlfOn1MB6QczAxJbSmNO8II=
Date:   Wed, 21 Aug 2019 11:32:01 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190821103200.kpufwtviqhpbuv2n@willie-the-truck>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
 <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
 <CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com>
 <20190820135612.GS2332@hirez.programming.kicks-ass.net>
 <20190820202932.GW28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820202932.GW28441@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 01:29:32PM -0700, Paul E. McKenney wrote:
> On Tue, Aug 20, 2019 at 03:56:12PM +0200, Peter Zijlstra wrote:
> > On Sat, Aug 17, 2019 at 01:08:02AM -0700, Linus Torvalds wrote:
> > 
> > > The data tearing issue is almost a non-issue. We're not going to add
> > > WRITE_ONCE() to these kinds of places for no good reason.
> > 
> > Paulmck actually has an example of that somewhere; ISTR that particular
> > case actually got fixed by GCC, but I'd really _love_ for some compiler
> > people (both GCC and LLVM) to state that their respective compilers will
> > not do load/store tearing for machine word sized load/stores.
> 
> I do very much recall such an example, but I am now unable to either
> find it or reproduce it.  :-/
> 
> If I cannot turn it up in a few days, I will ask the LWN editors to
> make appropriate changes to the "Who is afraid" article.
> 
> > Without this written guarantee (which supposedly was in older GCC
> > manuals but has since gone missing), I'm loathe to rely on it.
> > 
> > Yes, it is very rare, but it is a massive royal pain to debug if/when it
> > does do happen.
> 
> But from what I can see, Linus is OK with use of WRITE_ONCE() for data
> races on any variable for which there is at least one READ_ONCE().
> So we can still use WRITE_ONCE() as we would like in our own code.
> Yes, you or I might be hit by someone else's omission of WRITE_ONCE(),
> it is better than the proverbial kick in the teeth.
> 
> Of course, if anyone knows of a compiler/architecture combination that
> really does tear stores of 32-bit constants, please do not keep it
> a secret!  After all, it would be good to get that addressed easily
> starting now rather than after a difficult and painful series of
> debugging sessions.

It's not quite what you asked for, but if you look at the following
silly code:

typedef unsigned long long u64;

struct data {
	u64 arr[1023];
	u64 flag;
};

void foo(struct data *x)
{
	int i;

	for (i = 0; i < 1023; ++i)
		x->arr[i] = 0;

	x->flag = 0;
}

void bar(u64 *x)
{
	*x = 0xabcdef10abcdef10;
}

Then arm64 clang (-O2) generates the following for foo:

foo:                                    // @foo
	stp	x29, x30, [sp, #-16]!   // 16-byte Folded Spill
	orr	w2, wzr, #0x2000
	mov	w1, wzr
	mov	x29, sp
	bl	memset
	ldp	x29, x30, [sp], #16     // 16-byte Folded Reload
	ret

and so the store to 'flag' has become part of the memset, which could
easily be bytewise in terms of atomicity (and this isn't unlikely given
we have a DC ZVA instruction which only guaratees bytewise atomicity).

GCC (also -O2) generates the following for bar:

bar:
	mov	w1, 61200
	movk	w1, 0xabcd, lsl 16
	stp	w1, w1, [x0]
	ret

and so it is using a store-pair instruction to reduce the complexity in
the immediate generation. Thus, the 64-bit store will only have 32-bit
atomicity. In fact, this is scary because if I change bar to:

void bar(u64 *x)
{
	*(volatile u64 *)x = 0xabcdef10abcdef10;
}

then I get:

bar:
	mov	w1, 61200
	movk	w1, 0xabcd, lsl 16
	str	w1, [x0]
	str	w1, [x0, 4]
	ret

so I'm not sure that WRITE_ONCE would even help :/

It's worth noting that:

void baz(atomic_long *x)
{
	atomic_store_explicit(x, 0xabcdef10abcdef10, memory_order_relaxed)
}

does the right thing:

baz:
	mov	x1, 61200
	movk	x1, 0xabcd, lsl 16
	movk	x1, 0xef10, lsl 32
	movk	x1, 0xabcd, lsl 48
	str	x1, [x0]
	ret

Whilst these examples may be contrived, I do thing they illustrate that
we can't simply say "stores to aligned, word-sized pointers are atomic".

Will
