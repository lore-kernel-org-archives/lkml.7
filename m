Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2738DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6CF20409
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nxZLRJlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfLKRwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:52:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLKRwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NNmicuFL5ok36X4eq37Ayq5N4dbbpy3GcLqAwcxHD20=; b=nxZLRJlP62cN7e2AvJqHBD1EX
        Q/9Rmt2XXKWYsEOK6WOOI53eUGjAIOGVvwN0nddevYkw8poXEYzXZs+E3qVPJ4Pd36PX5lkaM66Un
        7b7oJCljoeOVnfR6w7trjP/m8yGhpq50mIg+FzkznyOSZhTCwq5XMrLvKpvOsWh3GpAVVfZj69O/t
        ZGXJ7nnLaE7ipj3XR2lqTH3Po8hHa6dRokw3KBXD8DwZENktcWAjE3Hp+U8L1IxOfuhlU8GaD7xld
        R165MNTTuuHxCWLDJEaU/QRpgV1VoecoWc1CtlWN9J+aA9kQPOa19x1oHYxYZq2tJFX4QqNsXrBrP
        AEjE3uiQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if69d-000597-VL; Wed, 11 Dec 2019 17:52:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CAEEA300F29;
        Wed, 11 Dec 2019 18:50:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1C5920120E4D; Wed, 11 Dec 2019 18:52:02 +0100 (CET)
Date:   Wed, 11 Dec 2019 18:52:02 +0100
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
Message-ID: <20191211175202.GQ2827@hirez.programming.kicks-ass.net>
References: <20191121171214.GD12042@gmail.com>
 <3481175cbe14457a947f934343946d52@AcuMS.aculab.com>
 <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com>
 <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
 <20191122203105.GE2844@hirez.programming.kicks-ass.net>
 <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 01:23:30PM -0800, Andy Lutomirski wrote:
> On Fri, Nov 22, 2019 at 12:31 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Nov 22, 2019 at 05:48:14PM +0000, Luck, Tony wrote:
> > > > When we use byte ops, we must consider the word as 4 independent
> > > > variables. And in that case the later load might observe the lock-byte
> > > > state from 3, because the modification to the lock byte from 4 is in
> > > > CPU2's store-buffer.
> > >
> > > So we absolutely violate this with the optimization for constant arguments
> > > to set_bit(), clear_bit() and change_bit() that are implemented as byte ops.
> > >
> > > So is code that does:
> > >
> > >       set_bit(0, bitmap);
> > >
> > > on one CPU. While another is doing:
> > >
> > >       set_bit(mybit, bitmap);
> > >
> > > on another CPU safe? The first operates on just one byte, the second  on 8 bytes.
> >
> > It is safe if all you care about is the consistency of that one bit.
> >
> 
> I'm still lost here.  Can you explain how one could write code that
> observes an issue?  My trusty SDM, Vol 3 8.2.2 says "Locked
> instructions have a total order."

This is the thing I don't fully believe. Per this thread the bus-lock is
*BAD* and not used for normal LOCK prefixed operations. But without the
bus-lock it becomes very hard to guarantee total order.

After all, if some CPU doesn't observe a specific variable, it doesn't
care where in the order it fell. So I'm thinking they punted and went
with some partial order that is near enough that it becomes very hard to
tell the difference the moment you actually do observe stuff.

> 8.2.3.9 says "Loads and Stores Are
> Not Reordered with Locked Instructions."  Admittedly, the latter is an
> "example", but the section is very clear about the fact that a locked
> instruction prevents reordering of a load or a store issued by the
> same CPU relative to the locked instruction *regardless of whether
> they overlap*.

IIRC this rule is CPU-local.

Sure, but we're talking two cpus here.

	u32 var = 0;
	u8 *ptr = &var;

	CPU0			CPU1

				xchg(ptr, 1)

	xchg((ptr+1, 1);
	r = READ_ONCE(var);

AFAICT nothing guarantees r == 0x0101. The CPU1 store can be stuck in
CPU1's store-buffer. CPU0's xchg() does not overlap and therefore
doesn't force a snoop or forward.

From the perspective of the LOCK prefixed instructions CPU0 never
observes the variable @ptr. And therefore doesn't need to provide order.

Note how the READ_ONCE() is a normal load on CPU0, and per the rules is
only forced to happen after it's own LOCK prefixed instruction, but it
is free to observe ptr[0,2,3] from before, only ptr[1] will be forwarded
from its own store-buffer.

This is exactly the one reorder TSO allows.

> I understand that the CPU is probably permitted to optimize a LOCK RMW
> operation such that it retires before the store buffers of earlier
> instructions are fully flushed, but only if the store buffer and cache
> coherency machinery work together to preserve the architecturally
> guaranteed ordering.

Maybe, maybe not. I'm very loathe to trust this without things being
better specified.

Like I said, it is possible that it all works, but the way I understand
things I _really_ don't want to rely on it.

Therefore, I've written:

	u32 var = 0;
	u8 *ptr = &var;

	CPU0			CPU1

				xchg(ptr, 1)

	set_bit(8, ptr);

	r = READ_ONCE(var);

Because then the LOCK BTSL overlaps with the LOCK XCHGB and CPU0 now
observes the variable @ptr and therefore must force order.

Did this clarify, or confuse more?
