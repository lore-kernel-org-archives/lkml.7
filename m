Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A401C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419A22087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCMOgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:36:04 -0400
Received: from foss.arm.com ([217.140.101.70]:58564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfCMOgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:36:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02F6280D;
        Wed, 13 Mar 2019 07:36:03 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FD403F614;
        Wed, 13 Mar 2019 07:36:01 -0700 (PDT)
Date:   Wed, 13 Mar 2019 14:35:53 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qian Cai <cai@lca.pw>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/debug: add a cast to u64 for atomic64_read()
Message-ID: <20190313143552.GA39315@lakrids.cambridge.arm.com>
References: <20190310183051.87303-1-cai@lca.pw>
 <20190311035815.kq7ftc6vphy6vwen@linux-r8p5>
 <20190311122100.GF22862@mellanox.com>
 <1552312822.7087.11.camel@lca.pw>
 <CAK8P3a0QB7+oPz4sfbW_g2EGZZmC=LMEnkMNLCW_FD=fEZoQPA@mail.gmail.com>
 <20190313091844.GA24390@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313091844.GA24390@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 10:18:44AM +0100, Peter Zijlstra wrote:
> On Mon, Mar 11, 2019 at 03:20:04PM +0100, Arnd Bergmann wrote:
> > On Mon, Mar 11, 2019 at 3:00 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > On Mon, 2019-03-11 at 12:21 +0000, Jason Gunthorpe wrote:
> > > > On Sun, Mar 10, 2019 at 08:58:15PM -0700, Davidlohr Bueso wrote:
> > > > > On Sun, 10 Mar 2019, Qian Cai wrote:
> > > >
> > > > Not saying this patch shouldn't go ahead..
> > > >
> > > > But is there a special reason the atomic64*'s on ppc don't use the u64
> > > > type like other archs? Seems like a better thing to fix than adding
> > > > casts all over the place.
> 
> s64 if anything, atomic stuff is signed (although since we have -fwrapv
> it doesn't matter one whit).
> 
> > > A bit of history here,
> > >
> > > https://patchwork.kernel.org/patch/7344011/#15495901
> > 
> > Ah, I had already forgotten about that discussion.
> > 
> > At least the atomic_long part we discussed there has been resolved now
> > as part of commit b5d47ef9ea5c ("locking/atomics: Switch to generated
> > atomic-long").
> > 
> > Adding Mark Rutland to Cc, maybe he has some ideas of how to use
> > the infrastructure he added to use consistent types for atomic64()
> > on the remaining 64-bit architectures.
> 
> A quick count shows there's only 5 definitions of atomic64_t in the
> tree, it would be trivial to align them on type.
> 
> $ git grep "} atomic64_t"
> arch/arc/include/asm/atomic.h:} atomic64_t;
> arch/arm/include/asm/atomic.h:} atomic64_t;
> arch/x86/include/asm/atomic64_32.h:} atomic64_t;
> include/asm-generic/atomic64.h:} atomic64_t;
> include/linux/types.h:} atomic64_t;
> 
> Note that the one used in _most_ cases, is the one from linux/types.h,
> and that is using 'long'. The others, all typically on ILP32 platforms,
> obviously must use long long.
> 
> I have no objection to changing the types.h one to long long or all of
> them to s64. It really shouldn't matter at all.

I think that using s64 consistently (with any necessary alignment
annotation) makes the most sense. That's unambigious, and what the
common headers now use.

Now that the scripted atomics are merged, I'd like to move arches over
to arch_atomic_*(), so the argument and return types will become s64
everywhere.

Thanks,
Mark.
