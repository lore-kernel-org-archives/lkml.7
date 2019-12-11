Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E7CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E978222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576087993;
	bh=Ts+aHtpj5ja17RbmxvtWY6JKJpfKXa1bAAuzHiFjJiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ts5120zufzxmj+jxir0s/SZNj5kMxbp/bW7Vcmbt4/v6nNP2wPQvG4/0pok0BhKBA
	 UMFdvnW+ueQaXbjkZsS+BzUa3u5qhZOX+X8n8bP5Q7fhcu4kFj/qxEwZnRO8QVKLH7
	 nTZTGoW6R0YWtbs7/S6TQSUgRS/y6Xwid5IOo5Jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfLKSNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:13:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfLKSNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:13:11 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A565324654
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576087990;
        bh=Ts+aHtpj5ja17RbmxvtWY6JKJpfKXa1bAAuzHiFjJiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ImmomFkvHtlmxTPxuDe3MEcn6qBn5tcYffN49bc43vcBA+sI+WaPjHk2K4TWF89Ek
         jSEZEnWnjLhwZioHl6Vh0mBe9M9UfRBIEO6XaxgHnXcaASgDeGv9GWfcaZlp5r25h3
         RLAoF3a8xKGLi3FbVep5CWZ2bOCTDmRdECEcGjpE=
Received: by mail-wr1-f41.google.com with SMTP id g17so25125120wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:13:09 -0800 (PST)
X-Gm-Message-State: APjAAAXQ42T3QgcLN5IKa5Q+yGNSGNKfTNruZ0hjDFZa/enZ7ISfueg8
        prh+Hrl6HWqSFzJdfOvT168UBfRATf1x1aG7t+8H6Q==
X-Google-Smtp-Source: APXvYqyjydZM2VzbqZ7EJPREgHq5qJc0Wahnea+PiXy3tHfEsaOdFppLSOQqCpNEiQANwqcygVcQHhyGyZcozL9iYCQ=
X-Received: by 2002:adf:eb09:: with SMTP id s9mr1251463wrn.61.1576087987979;
 Wed, 11 Dec 2019 10:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20191121171214.GD12042@gmail.com> <3481175cbe14457a947f934343946d52@AcuMS.aculab.com>
 <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com> <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net> <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
 <20191122203105.GE2844@hirez.programming.kicks-ass.net> <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
 <20191211175202.GQ2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20191211175202.GQ2827@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 11 Dec 2019 10:12:56 -0800
X-Gmail-Original-Message-ID: <CALCETrXUZ790WFk9SEzuiKg-wMva=RpWhZNYPf+MqzT0xdu+gg@mail.gmail.com>
Message-ID: <CALCETrXUZ790WFk9SEzuiKg-wMva=RpWhZNYPf+MqzT0xdu+gg@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 9:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 22, 2019 at 01:23:30PM -0800, Andy Lutomirski wrote:
> > On Fri, Nov 22, 2019 at 12:31 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Nov 22, 2019 at 05:48:14PM +0000, Luck, Tony wrote:
> > > > > When we use byte ops, we must consider the word as 4 independent
> > > > > variables. And in that case the later load might observe the lock-byte
> > > > > state from 3, because the modification to the lock byte from 4 is in
> > > > > CPU2's store-buffer.
> > > >
> > > > So we absolutely violate this with the optimization for constant arguments
> > > > to set_bit(), clear_bit() and change_bit() that are implemented as byte ops.
> > > >
> > > > So is code that does:
> > > >
> > > >       set_bit(0, bitmap);
> > > >
> > > > on one CPU. While another is doing:
> > > >
> > > >       set_bit(mybit, bitmap);
> > > >
> > > > on another CPU safe? The first operates on just one byte, the second  on 8 bytes.
> > >
> > > It is safe if all you care about is the consistency of that one bit.
> > >
> >
> > I'm still lost here.  Can you explain how one could write code that
> > observes an issue?  My trusty SDM, Vol 3 8.2.2 says "Locked
> > instructions have a total order."
>
> This is the thing I don't fully believe. Per this thread the bus-lock is
> *BAD* and not used for normal LOCK prefixed operations. But without the
> bus-lock it becomes very hard to guarantee total order.
>
> After all, if some CPU doesn't observe a specific variable, it doesn't
> care where in the order it fell. So I'm thinking they punted and went
> with some partial order that is near enough that it becomes very hard to
> tell the difference the moment you actually do observe stuff.

I hope that, if the SDM is indeed wrong, that Intel would fix the SDM.
It's definitely not fun to try to understand locking if we don't trust
the manual.

>
> > 8.2.3.9 says "Loads and Stores Are
> > Not Reordered with Locked Instructions."  Admittedly, the latter is an
> > "example", but the section is very clear about the fact that a locked
> > instruction prevents reordering of a load or a store issued by the
> > same CPU relative to the locked instruction *regardless of whether
> > they overlap*.
>
> IIRC this rule is CPU-local.
>
> Sure, but we're talking two cpus here.
>
>         u32 var = 0;
>         u8 *ptr = &var;
>
>         CPU0                    CPU1
>
>                                 xchg(ptr, 1)
>
>         xchg((ptr+1, 1);
>         r = READ_ONCE(var);
>
> AFAICT nothing guarantees r == 0x0101. The CPU1 store can be stuck in
> CPU1's store-buffer. CPU0's xchg() does not overlap and therefore
> doesn't force a snoop or forward.

I think I don't quite understand.  The final value of var had better
be 0x0101 or something is severely wrong.  But r can be 0x0100 because
nothing in this example guarantees that the total order of the locked
instructions has CPU 1's instruction first.

>
> From the perspective of the LOCK prefixed instructions CPU0 never
> observes the variable @ptr. And therefore doesn't need to provide order.

I suspect that the implementation works on whole cache lines for
everything except the actual store buffer entries, which would mean
that CPU 0 does think it observed ptr[0].

>
> Note how the READ_ONCE() is a normal load on CPU0, and per the rules is
> only forced to happen after it's own LOCK prefixed instruction, but it
> is free to observe ptr[0,2,3] from before, only ptr[1] will be forwarded
> from its own store-buffer.
>
> This is exactly the one reorder TSO allows.

If so, then our optimized smp_mb() has all kinds of problems, no?

>
> > I understand that the CPU is probably permitted to optimize a LOCK RMW
> > operation such that it retires before the store buffers of earlier
> > instructions are fully flushed, but only if the store buffer and cache
> > coherency machinery work together to preserve the architecturally
> > guaranteed ordering.
>
> Maybe, maybe not. I'm very loathe to trust this without things being
> better specified.
>
> Like I said, it is possible that it all works, but the way I understand
> things I _really_ don't want to rely on it.
>
> Therefore, I've written:
>
>         u32 var = 0;
>         u8 *ptr = &var;
>
>         CPU0                    CPU1
>
>                                 xchg(ptr, 1)
>
>         set_bit(8, ptr);
>
>         r = READ_ONCE(var);
>
> Because then the LOCK BTSL overlaps with the LOCK XCHGB and CPU0 now
> observes the variable @ptr and therefore must force order.
>
> Did this clarify, or confuse more?

Probably confuses more.

If you're actual concerned that the SDM is wrong, I think that roping
in some architects would be a good idea.

I still think that making set_bit() do 32-bit or smaller accesses is okay.
