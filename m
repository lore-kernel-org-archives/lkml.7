Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA56EC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B979C2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="al7AleF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfDYHPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:15:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47468 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfDYHPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eG7Po0z2bfo1lvBmirguFsmzJiBnDOcOQs8lZ9FhK6o=; b=al7AleF3OAPX9ZnPucLi6hTty
        S6mmZK3SjaOxPJzaxOCBIkwAQ8SmyO5hp12tdJ5atPIF7fR2KFFcD6/HkIfnafjhMT15x9BTIeWVS
        j29OX8f2MoB9eY242AZMoI+vkaKkWl8jIoim/RrhPjIPyUYjbRtoTZtY+sQfx8ean/Qnyyv+QaTRa
        yoEUqoVnIWqNFbgVQlJWeo8MlgQuX4Pbd7YzIUZ3ak1vImyRBVJ4BAVITFZxklMg67euQolVubvEb
        WMu94Xm3PAS4iL2y3XG7B6w74UfBxC8kI0w7LDUGOXLP4k7TTtRpEPNsbOOb+bWw+CuZXg2/zRJLD
        h/veBsR1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJYbR-0000Eh-GG; Thu, 25 Apr 2019 07:15:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26BCB203E8871; Thu, 25 Apr 2019 09:15:28 +0200 (CEST)
Date:   Thu, 25 Apr 2019 09:15:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Huacai Chen <chenhc@lemote.com>,
        Huang Pei <huangpei@loongson.cn>
Subject: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
Message-ID: <20190425071528.GU11158@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424211759.52xraajqwudc2fza@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:18:04PM +0000, Paul Burton wrote:
> Hi Peter,
> 
> On Wed, Apr 24, 2019 at 02:36:58PM +0200, Peter Zijlstra wrote:
> > The comment describing the loongson_llsc_mb() reorder case doesn't
> > make any sense what so ever. Instruction re-ordering is not an SMP
> > artifact, but rather a CPU local phenomenon. This means that _every_
> > LL/SC loop needs this barrier right in front to avoid the CPU from
> > leaking a memop inside it.
> 
> Does it?

It does, however..

> The Loongson bug being described here causes an sc to succeed
> erroneously if certain loads or stores are executed between the ll &
> associated sc, including speculatively. On a UP system there's no code
> running on other cores to race with us & cause our sc to fail - ie. sc
> should always succeed anyway, so if the bug hits & the sc succeeds
> what's the big deal? It would have succeeded anyway. At least that's my
> understanding based on discussions with Loongson engineers a while ago.

Ah! So that wasn't spelled out as such. This basically says that: Yes,
it also screws with SC on UP, however the failure case is harmless.

(Also the comment with loongson_llsc_mb() seems incomplete in that it
doesn't mention the SC can also erroneously fail; typically that isn't a
problem because we'll just get an extra loop around and succeed
eventually.)

That said; I'm not entirely sure. The reason we use LL/SC even for
CPU-local variables is because of interrupts and the like. Would not a
false positive be a problem if it _should_ fail because of an interrupt?

> Having said that, if you have a strong preference for adding the barrier
> in UP systems anyway then I don't really object. It's not like anyone's
> likely to want to run a UP kernel on the affected systems, nevermind
> care about a miniscule performance impact.

It mostly all didn't make sense to me; and having a consistent recipie
for LL/SC loops is easier on the person occasionally looking at all
this (me, mostly :-).

(also, you should probably have a look at
include/asm-generic/bitops/atomic.h)

> One possibility your change could benefit would be if someone ran Linux
> on a subset of cores & some non-Linux code on other cores, in which case
> there could be something to cause the sc to fail. I've no idea if that's
> something these Loongson systems ever do though.

Or a bunch of UP guests ?

> > For the branch speculation case; if futex_atomic_cmpxchg_inatomic()
> > needs one at the bne branch target, then surely the normal
> > __cmpxch_asmg() implementation does too. We cannot rely on the
> 
> s/cmpxch_asmg/cmpxchg_asm/

Typing hard :-)

