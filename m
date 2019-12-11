Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA790C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A2122527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="REHNdmQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfLKWeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:34:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfLKWeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vGBSifJsetdNrHa2+mZGq0HtV+U08W9ZitlOZKuQo7I=; b=REHNdmQWdBrywQ+956MJ3OXt+
        VwE+pSXHaKHGBrlg9BgZ3a5D9C0JimC5JLdbAg9oSBBvELMbw9w7FNgigVnTV9GMdz7nP4kIfLZrU
        jLUNtTr/+J5p2+cIXO3TkKmcezotusUuchSAvMj2rqPV++k1JKwCTB3HStyCXyz+Ft2226OEfa7sA
        RoOccjjNMWrXVlDcE/WAwvVUxP/ejcmg8lC7PLDDeu9/asES5VJZxk/+HvVwbrC+hbZrhmamr6P3v
        RcEAM1OAx+JFacogc09bt+6TwNDU2jDeOAD37ep0F4yqcXU9BKrduHqp/mkxbsd2BAxHQ/5CaatP9
        fxsZv1Vbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifAYd-0002ln-JZ; Wed, 11 Dec 2019 22:34:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B04D7300565;
        Wed, 11 Dec 2019 23:32:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4344720120E46; Wed, 11 Dec 2019 23:34:07 +0100 (CET)
Date:   Wed, 11 Dec 2019 23:34:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191211223407.GT2844@hirez.programming.kicks-ass.net>
References: <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com>
 <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
 <20191122203105.GE2844@hirez.programming.kicks-ass.net>
 <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
 <20191211175202.GQ2827@hirez.programming.kicks-ass.net>
 <CALCETrXUZ790WFk9SEzuiKg-wMva=RpWhZNYPf+MqzT0xdu+gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXUZ790WFk9SEzuiKg-wMva=RpWhZNYPf+MqzT0xdu+gg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:12:56AM -0800, Andy Lutomirski wrote:
> On Wed, Dec 11, 2019 at 9:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Nov 22, 2019 at 01:23:30PM -0800, Andy Lutomirski wrote:
> > > On Fri, Nov 22, 2019 at 12:31 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Fri, Nov 22, 2019 at 05:48:14PM +0000, Luck, Tony wrote:
> > > > > > When we use byte ops, we must consider the word as 4 independent
> > > > > > variables. And in that case the later load might observe the lock-byte
> > > > > > state from 3, because the modification to the lock byte from 4 is in
> > > > > > CPU2's store-buffer.
> > > > >
> > > > > So we absolutely violate this with the optimization for constant arguments
> > > > > to set_bit(), clear_bit() and change_bit() that are implemented as byte ops.
> > > > >
> > > > > So is code that does:
> > > > >
> > > > >       set_bit(0, bitmap);
> > > > >
> > > > > on one CPU. While another is doing:
> > > > >
> > > > >       set_bit(mybit, bitmap);
> > > > >
> > > > > on another CPU safe? The first operates on just one byte, the second  on 8 bytes.
> > > >
> > > > It is safe if all you care about is the consistency of that one bit.
> > > >
> > >
> > > I'm still lost here.  Can you explain how one could write code that
> > > observes an issue?  My trusty SDM, Vol 3 8.2.2 says "Locked
> > > instructions have a total order."
> >
> > This is the thing I don't fully believe. Per this thread the bus-lock is
> > *BAD* and not used for normal LOCK prefixed operations. But without the
> > bus-lock it becomes very hard to guarantee total order.
> >
> > After all, if some CPU doesn't observe a specific variable, it doesn't
> > care where in the order it fell. So I'm thinking they punted and went
> > with some partial order that is near enough that it becomes very hard to
> > tell the difference the moment you actually do observe stuff.
> 
> I hope that, if the SDM is indeed wrong, that Intel would fix the SDM.
> It's definitely not fun to try to understand locking if we don't trust
> the manual.

I can try and find a HW person; but getting the SDM updated is
difficult.

Anyway, the way I see it, it is a scalability thing. Absolute total
order is untenable, it cannot be, it would mean that if you have your 16
socket 20 core system with hyperthreads, and each logical CPU doing a
LOCK prefix instruction on a separate page, they all 640 need to sit
down and discuss who goes first.

Some sort of partial order that connects where variables/lines are
actually shared is needed. Then again, I'm not a HW person, just a poor
sod trying to understand how this can work.

> > Sure, but we're talking two cpus here.
> >
> >         u32 var = 0;
> >         u8 *ptr = &var;
> >
> >         CPU0                    CPU1
> >
> >                                 xchg(ptr, 1)
> >
> >         xchg((ptr+1, 1);
> >         r = READ_ONCE(var);
> >
> > AFAICT nothing guarantees r == 0x0101. The CPU1 store can be stuck in
> > CPU1's store-buffer. CPU0's xchg() does not overlap and therefore
> > doesn't force a snoop or forward.
> 
> I think I don't quite understand.  The final value of var had better
> be 0x0101 or something is severely wrong.  

> But r can be 0x0100 because
> nothing in this example guarantees that the total order of the locked
> instructions has CPU 1's instruction first.

Assuming CPU1 goes first, why would the load from CPU0 see CPU1's
ptr[0]? It can be in CPU1 store buffer, and TSO allows regular reads to
ignore (remote) store-buffers.

> > From the perspective of the LOCK prefixed instructions CPU0 never
> > observes the variable @ptr. And therefore doesn't need to provide order.
> 
> I suspect that the implementation works on whole cache lines for
> everything except the actual store buffer entries, which would mean
> that CPU 0 does think it observed ptr[0].

Quite possible, but consider SMT where each thread has its own
store-buffer. Then the core owns the line, but the value is still not
visible.

I don't know if they want to tie down those semantics.

> > Note how the READ_ONCE() is a normal load on CPU0, and per the rules is
> > only forced to happen after it's own LOCK prefixed instruction, but it
> > is free to observe ptr[0,2,3] from before, only ptr[1] will be forwarded
> > from its own store-buffer.
> >
> > This is exactly the one reorder TSO allows.
> 
> If so, then our optimized smp_mb() has all kinds of problems, no?

Why? All smp_mb() guarantees is order between two memops and it does
that just fine.

> > Did this clarify, or confuse more?
> 
> Probably confuses more.

Lets put it this way, the first approach has many questions and subtle
points, the second approach must always work without question.

> If you're actual concerned that the SDM is wrong, I think that roping
> in some architects would be a good idea.

I'll see what I can do, getting them to commit to something is always
the hard part.

> I still think that making set_bit() do 32-bit or smaller accesses is okay.

Yes, that really should not be a problem. This whole subthread was more
of a cautionary tale that it is not immediately obviously safe. And like
I've said before, the bitops interface is across all archs, we must
consider the weakest behaviour.

Anyway, we considered these things when we did
clear_bit_unlock_is_negative_byte(), and there is a reason we ended up
with BIT(7), there is no way to slice up a byte.
