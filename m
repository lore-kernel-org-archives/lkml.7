Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7B9C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21DA2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wWygBo8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKVJ0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:26:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37314 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKVJ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fFSeQ+jPOdfWL9mo0nXYn5k4ETQl4Z3Uc5YMW/Q7fIk=; b=wWygBo8ATjj89zxEdoLAsfT4Q
        yo77Eov573ifzNAKE7MmJ/8lPJMyRGzS9lkvCELAc+BX9N5GzIvevWOyGMYB09dLWhlPxP6VIIoNc
        ZTMFywT+t0ac57lSa0N9kknUvwPV8IKLfVu2Xo98qTP4CGlFdC9026I1vVyn1v4UFbFQ2WFxWX58r
        Hc4P2vHErx5qPabjV4k3WQcFg23DMbenLnloYTNG315zuxDnecQi0C7qtTY0bVrD0Vjuo8NrfdJy9
        pr+RwZlHJHxn2/peKKwuoh5l6sWfWFUwJqpBLl6gomg3zG/FON8OTRYQ/goO+99i5Awwrp2QREI8E
        tRRv3sCug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iY5CR-0006bS-6h; Fri, 22 Nov 2019 09:25:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 629E13056BE;
        Fri, 22 Nov 2019 10:24:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BEE220321C89; Fri, 22 Nov 2019 10:25:55 +0100 (CET)
Date:   Fri, 22 Nov 2019 10:25:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191122092555.GA4097@hirez.programming.kicks-ass.net>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <3481175cbe14457a947f934343946d52@AcuMS.aculab.com>
 <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com>
 <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 01:22:13PM -0800, Andy Lutomirski wrote:
> On Thu, Nov 21, 2019 at 12:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Nov 21, 2019 at 10:53:03AM -0800, Fenghua Yu wrote:
> >
> > > 4. Otherwise, re-calculate addr to point the 32-bit address which contains
> > >    the bit and operate on the bit. No split lock.
> >
> > That sounds confused, Even BT{,CRS} have a RmW size. There is no
> > 'operate on the bit'.
> >
> > Specifically I hard rely on BTSL to be a 32bit RmW, see commit:
> >
> >   7aa54be29765 ("locking/qspinlock, x86: Provide liveness guarantee")
> >
> 
> Okay, spent a bit of time trying to grok this.  Are you saying that
> LOCK BTSL suffices in a case where LOCK BTSB or LOCK XCHG8 would not?

Yep.

> On x86, all the LOCK operations are full barriers, so they should
> order with adjacent normal accesses even to unrelated addresses,
> right?

Yep, still.

The barrier is not the problem here. Yes the whole value load must come
after the atomic op, be it XCHGB/BTSB or BTSL.

The problem with XCHGB is that it is an 8bit RmW and therefore it makes
no guarantess on the contents of the bytes next to it.

When we use byte ops, we must consider the word as 4 independent
variables. And in that case the later load might observe the lock-byte
state from 3, because the modification to the lock byte from 4 is in
CPU2's store-buffer.

However, by using a 32bit RmW, we force a write on all 4 bytes at the
same time which forces that store from CPU2 to be flushed (because the
operations overlap, whereas an 8byte RmW would not overlap and be
independent).

Now, it _might_ work with an XCHGB anyway, _if_ coherency is per
cacheline, and not on a smaller granularity. But I don't think that is
something the architecture guarantees -- they could play fun and games
with partial forwards or whatever.

Specifically, we made this change:

  450cbdd0125c ("locking/x86: Use LOCK ADD for smp_mb() instead of MFENCE")

Now, we know that MFENCE will in fact flush the store buffers, and LOCK
prefix being faster does seem to imply it does not. LOCK prefix only
guarantees order, it does not guarantee completion (that's what makes
MFENCE so much more expensive).


Also; if we're going to change the bitops API, that is a generic change
and we must consider all architectures. Me having audited the atomic
bitops width a fair number of times now. to answer question on what code
actually does and/or if a proposed change is valid, indicates the
current state is crap, irrespective of the long vs u32 question.

So I'm saying that if we're going to muck with bitops, lets make it a
simple and consistent thing. This concurrency crap is hard enough
without fancy bells on.
