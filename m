Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59244C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3E32173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IrhFuyyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfLLNEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:04:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbfLLNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NjvH1quuvLRS7d0OQTnj2l3Ce1X8fDNiEPYtgGnqjt0=; b=IrhFuyyCtQPfTdwSv4ZfaZj28
        V1MsfH+YoqybwmDazfqs7d0FCO0flqSSgK27sQkktwsT1PrMjpglvnxzoB0wzrz4b+92F9ZjofePl
        6EASXumfYeDbmC1IigCJy+Tqi9QtyQHCBmS584sKSEzs5u2pTDQoazP9Uxu2jT8/YY0ruR1lQQDDJ
        Vlw0fE8dpa+DKaObS0ZO+MwOG+LZOJF49OuLCoEgwarO4QITN2OesvdhESiOr9nTDnIoZKxXja6fM
        a4GY6n14n0EQ64LMVvwfLFpeid7rKMLNks3roB/iFPALlzIi6altPVksRSS3NJOFbP/JB8VIK32p2
        j0RQVvMYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifO8m-0006l2-Io; Thu, 12 Dec 2019 13:04:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58B5C3058B4;
        Thu, 12 Dec 2019 14:03:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B211929E10BD8; Thu, 12 Dec 2019 14:04:21 +0100 (CET)
Date:   Thu, 12 Dec 2019 14:04:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
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
Message-ID: <20191212130421.GX2827@hirez.programming.kicks-ass.net>
References: <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
 <20191122203105.GE2844@hirez.programming.kicks-ass.net>
 <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
 <20191211175202.GQ2827@hirez.programming.kicks-ass.net>
 <20191211184416.GA6344@agluck-desk2.amr.corp.intel.com>
 <20191211223917.GU2844@hirez.programming.kicks-ass.net>
 <5ba0190e63594ad1b8b032bc12553393@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba0190e63594ad1b8b032bc12553393@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:36:27AM +0000, David Laight wrote:

> On x86 'xchg' is always 'locked' regardless of whether there is a 'lock' prefix.

Sure, irrelevant here though.

> set_bit() (etc) include the 'lock' prefix (dunno why this decision was made...).

Because it is the atomic set bit function, we have __set_bit() if you
want the non-atomic one.

Atomic bitops are (obviously) useful if you have concurrent changes to
your bitmap.

Lots of people seem confused on this though, as evidenced by a lot of
the broken crap we keep finding (then again, them using __set_bit()
would still be broken due to the endian thing).

> For locked operations (including misaligned ones) that don't cross cache-line
> boundaries the read operation almost certainly locks the cache line (against
> a snoop) until the write has updated the cache line.

Note your use of 'almost'. Almost isn't good enough. Note that other
architectures allow the store from atomic operations to hit the store
buffer. And I strongly suspect x86 does the same.

Waiting for a store-buffer drain is *expensive*.

Try timing:

	LOCK INC (ptr);

vs

	LOCK INC (ptr);
	MFENCE

My guess is the second one *far* more expensive. MFENCE drains (and waits
for completion thereof) the store-buffer -- it must since it fences
against non-coherent stuff.

I suppose ARM's DMB vs DSB is of similar distinction.

> This won't happen until the write 'drains' from the store buffer.
> (I suspect that locked read requests act like write requests in ensuring
> that no other cpu has a dirty copy of the cache line, and also marking it dirty.)
> Although this will delay the response to the snoop it will only
> stall the cpu (or other bus master), not the entire memory 'bus'.

I really don't think so. The commit I pointed to earlier in the thread,
that replaced MFENCE with LOCK ADD $0, -4(%RSP) for smp_mb(), strongly
indicates LOCK prefixed instructions do _NOT_ flush the store buffer.

All barriers impose is order, if your store-buffer can preserve order,
all should just work. One possible way would be to tag each entry, and
increment the tag on barrier. Then ensure that all smaller tags are
flushed before allowing a higher tagged entry to leave.

> If you read the description of 'lock btr' you'll see that it always does the
> write cycle (to complete the atomic RMW expected by the memory
> subsystem) even when the bit is clear.

I know it does, but I don't see how that is relevant here.

> Remote store buffers are irrelevant to locked accesses.

They are not in general and I've seen nothing to indicate this is the
case on x86.

> (If you are doing concurrent locked and unlocked accesses to the same
> memory location something is badly broken.)

It is actually quite common.

> It really can't matter whether one access is a mis-aligned 64bit word
> and the other a byte. Both do atomic RMW updates so the result
> cannot be unexpected.

Expectations are often violated. Esp when talking about memory ordering.

> In principle two separate 8 bit RMW cycles could be done concurrently
> to two halves of a 16 bit 'flag' word without losing any bits or any reads
> returning any of the expected 4 values.
> Not that any memory system would support such updates.

I'm thinking you ought to go read that paper on mixed size concurrency I
referenced earlier in this thread. IIRC the conclusion was that PowerPC
does exactly that and ARM64 allows for it but it hasn't been observed,
yet.

Anyway, I'm not saying x86 behaves this way, I'm saying that I have lots
of questions and very little answers. I'm also saying that the variant
with non-overlapping atomics could conceivably misbehave, while the
variant with overlapping atomics is guaranteed not to.

Specifically smp_mb()/SYNC on PowerPC can not restore Sequential
Consistency under mixed size operations. How's that for expectations?
