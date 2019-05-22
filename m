Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D68C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11FA208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfEVQEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:04:22 -0400
Received: from foss.arm.com ([217.140.101.70]:54496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbfEVQEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:04:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E97B341;
        Wed, 22 May 2019 09:04:21 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 035BE3F718;
        Wed, 22 May 2019 09:04:19 -0700 (PDT)
Date:   Wed, 22 May 2019 17:04:17 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] Disable lockref on arm64
Message-ID: <20190522160417.GF7876@fuggles.cambridge.arm.com>
References: <20190429145159.GA29076@hc>
 <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190502082741.GE13955@hc>
 <CAHk-=wjmtMrxC1nSEHarBn8bW+hNXGv=2YeAWmTw1o54V8GKWA@mail.gmail.com>
 <20190502231858.GB13168@dc5-eodlnx05.marvell.com>
 <CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com>
 <20190506061100.GA8465@dc5-eodlnx05.marvell.com>
 <20190506181039.GA2875@brain-police>
 <20190518042424.GA28517@dc5-eodlnx05.marvell.com>
 <CAKv+Gu9U9z3iAuz4V1c5zTHuz1As8FSNGY-TJon4OLErB8ts8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9U9z3iAuz4V1c5zTHuz1As8FSNGY-TJon4OLErB8ts8Q@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 12:00:34PM +0200, Ard Biesheuvel wrote:
> On Sat, 18 May 2019 at 06:25, Jayachandran Chandrasekharan Nair
> <jnair@marvell.com> wrote:
> >
> > On Mon, May 06, 2019 at 07:10:40PM +0100, Will Deacon wrote:
> > > On Mon, May 06, 2019 at 06:13:12AM +0000, Jayachandran Chandrasekharan Nair wrote:
> > > > Perhaps someone from ARM can chime in here how the cas/yield combo
> > > > is expected to work when there is contention. ThunderX2 does not
> > > > do much with the yield, but I don't expect any ARM implementation
> > > > to treat YIELD as a hint not to yield, but to get/keep exclusive
> > > > access to the last failed CAS location.
> > >
> > > Just picking up on this as "someone from ARM".
> > >
> > > The yield instruction in our implementation of cpu_relax() is *only* there
> > > as a scheduling hint to QEMU so that it can treat it as an internal
> > > scheduling hint and run some other thread; see 1baa82f48030 ("arm64:
> > > Implement cpu_relax as yield"). We can't use WFE or WFI blindly here, as it
> > > could be a long time before we see a wake-up event such as an interrupt. Our
> > > implementation of smp_cond_load_acquire() is much better for that kind of
> > > thing, but doesn't help at all for a contended CAS loop where the variable
> > > is actually changing constantly.
> >
> > Looking thru the perf output of this case (open/close of a file from
> > multiple CPUs), I see that refcount is a significant factor in most
> > kernel configurations - and that too uses cmpxchg (without yield).
> > x86 has an optimized inline version of refcount that helps
> > significantly. Do you think this is worth looking at for arm64?
> >
> 
> I looked into this a while ago [0], but at the time, we decided to
> stick with the generic implementation until we encountered a use case
> that benefits from it. Worth a try, I suppose ...
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20170903101622.12093-1-ard.biesheuvel@linaro.org/

If JC can show that we benefit from this, it would be interesting to see if
we can implement the refcount-full saturating arithmetic using the
LDMIN/LDMAX instructions instead of the current cmpxchg() loops.

Will
