Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCF1C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797F02184E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bq7+4Znd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfCMJTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:19:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44914 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfCMJTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KzxQSaJbsqgdV04fsK2ylmeyEWpxrxzz2n7IfMtSZqI=; b=Bq7+4Zndp7tTjNamrCv1IFoTS
        sY2LOFDg0fpvuUMjw6ms0dt7lKbF3tt1fjChxjzHCVmXCEElHpFsnz5bTt2+FyQSLIxPNEYbe5cbR
        VBz8e5t1nIQkUiBz7ILKnAPB2bywmeBCdpRU4a5IWO7Fjti9gQcPVbFH/zGhglDag2ZoozU+TJa8P
        dBjyy+DYaa1tVGqAfSgvE6wIFgJE+3mwHI/sf7TY9eApm28xIB3yPbF3TyLmj+UUsxtZlhtcuo4vl
        T6UEQ6z4YJJvgyC9zQbENyHWLpN1NA1hZzksIxUyHNOcMa9GwAqu0aGBtFb9mmWHNnClTjOUcUn1M
        vM2173Qag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h402D-0007do-9r; Wed, 13 Mar 2019 09:18:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C2252028B0F8; Wed, 13 Mar 2019 10:18:45 +0100 (CET)
Date:   Wed, 13 Mar 2019 10:18:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Qian Cai <cai@lca.pw>, Jason Gunthorpe <jgg@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] mm/debug: add a cast to u64 for atomic64_read()
Message-ID: <20190313091844.GA24390@hirez.programming.kicks-ass.net>
References: <20190310183051.87303-1-cai@lca.pw>
 <20190311035815.kq7ftc6vphy6vwen@linux-r8p5>
 <20190311122100.GF22862@mellanox.com>
 <1552312822.7087.11.camel@lca.pw>
 <CAK8P3a0QB7+oPz4sfbW_g2EGZZmC=LMEnkMNLCW_FD=fEZoQPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0QB7+oPz4sfbW_g2EGZZmC=LMEnkMNLCW_FD=fEZoQPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 03:20:04PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 11, 2019 at 3:00 PM Qian Cai <cai@lca.pw> wrote:
> >
> > On Mon, 2019-03-11 at 12:21 +0000, Jason Gunthorpe wrote:
> > > On Sun, Mar 10, 2019 at 08:58:15PM -0700, Davidlohr Bueso wrote:
> > > > On Sun, 10 Mar 2019, Qian Cai wrote:
> > >
> > > Not saying this patch shouldn't go ahead..
> > >
> > > But is there a special reason the atomic64*'s on ppc don't use the u64
> > > type like other archs? Seems like a better thing to fix than adding
> > > casts all over the place.

s64 if anything, atomic stuff is signed (although since we have -fwrapv
it doesn't matter one whit).

> > A bit of history here,
> >
> > https://patchwork.kernel.org/patch/7344011/#15495901
> 
> Ah, I had already forgotten about that discussion.
> 
> At least the atomic_long part we discussed there has been resolved now
> as part of commit b5d47ef9ea5c ("locking/atomics: Switch to generated
> atomic-long").
> 
> Adding Mark Rutland to Cc, maybe he has some ideas of how to use
> the infrastructure he added to use consistent types for atomic64()
> on the remaining 64-bit architectures.

A quick count shows there's only 5 definitions of atomic64_t in the
tree, it would be trivial to align them on type.

$ git grep "} atomic64_t"
arch/arc/include/asm/atomic.h:} atomic64_t;
arch/arm/include/asm/atomic.h:} atomic64_t;
arch/x86/include/asm/atomic64_32.h:} atomic64_t;
include/asm-generic/atomic64.h:} atomic64_t;
include/linux/types.h:} atomic64_t;

Note that the one used in _most_ cases, is the one from linux/types.h,
and that is using 'long'. The others, all typically on ILP32 platforms,
obviously must use long long.

I have no objection to changing the types.h one to long long or all of
them to s64. It really shouldn't matter at all.
