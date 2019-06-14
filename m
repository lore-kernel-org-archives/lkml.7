Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA3BC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9053208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfFNKiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:38:54 -0400
Received: from foss.arm.com ([217.140.110.172]:59062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbfFNKix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:38:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 473812B;
        Fri, 14 Jun 2019 03:38:53 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2CF63F246;
        Fri, 14 Jun 2019 03:40:35 -0700 (PDT)
Date:   Fri, 14 Jun 2019 11:38:50 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC] Disable lockref on arm64
Message-ID: <20190614103850.GG10659@fuggles.cambridge.arm.com>
References: <20190506061100.GA8465@dc5-eodlnx05.marvell.com>
 <20190506181039.GA2875@brain-police>
 <20190518042424.GA28517@dc5-eodlnx05.marvell.com>
 <CAKv+Gu9U9z3iAuz4V1c5zTHuz1As8FSNGY-TJon4OLErB8ts8Q@mail.gmail.com>
 <20190522160417.GF7876@fuggles.cambridge.arm.com>
 <20190612040933.GA18848@dc5-eodlnx05.marvell.com>
 <20190612093151.GA11554@brain-police>
 <20190614070914.GA21961@dc5-eodlnx05.marvell.com>
 <20190614095846.GC10506@fuggles.cambridge.arm.com>
 <CAKv+Gu_Kdq=UPijjA84FpmO=ZsdEO9EyyF7GeOQ+WmfqtO_hMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_Kdq=UPijjA84FpmO=ZsdEO9EyyF7GeOQ+WmfqtO_hMg@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Fri, Jun 14, 2019 at 12:24:54PM +0200, Ard Biesheuvel wrote:
> On Fri, 14 Jun 2019 at 11:58, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Jun 14, 2019 at 07:09:26AM +0000, Jayachandran Chandrasekharan Nair wrote:
> > > x86 added a arch-specific fast refcount implementation - and the commit
> > > specifically notes that it is faster than cmpxchg based code[1].
> > >
> > > There seems to be an ongoing effort to move over more and more subsystems
> > > from atomic_t to refcount_t(e.g.[2]), specifically because refcount_t on
> > > x86 is fast enough and you get some error checking atomic_t that does not
> > > have.
> >
> > Correct, but there are also some cases that are only caught by
> > REFCOUNT_FULL.
> >
> Yes, but do note that my arm64 implementation catches
> increment-from-zero as well.

Ok, so it's just the silly racy cases that are problematic?

> > > Do you think Ard's patch needs changes before it can be considered? I
> > > can take a look at that.
> >
> > I would like to see how it performs if we keep the checking inline, yes.
> > I suspect Ard could spin this in short order.
> 
> Moving the post checks before the stores you mean? That shouldn't be
> too difficult, I suppose, but it will certainly cost performance.

That's what I'd like to assess, since the major complaint seems to be the
use of cmpxchg() as opposed to inline branching.

> > > > Whatever we do, I prefer to keep REFCOUNT_FULL the default option for arm64,
> > > > so if we can't keep the semantics when we remove the cmpxchg, you'll need to
> > > > opt into this at config time.
> > >
> > > Only arm64 and arm selects REFCOUNT_FULL in the default config. So please
> > > reconsider this! This is going to slow down arm64 vs. other archs and it
> > > will become worse when more code adopts refcount_t.
> >
> > Maybe, but faced with the choice between your micro-benchmark results and
> > security-by-default for people using the arm64 Linux kernel, I really think
> > that's a no-brainer. I'm well aware that not everybody agrees with me on
> > that.
> 
> I think the question whether the benchmark is valid is justified, but
> otoh, we are obsessed with hackbench which is not that representative
> of a real workload either. It would be better to discuss these changes
> in the context of known real-world use cases where refcounts are a
> true bottleneck.

I wasn't calling into question the validity of the benchmark (I really have
no clue about that), but rather that you can't have your cake and eat it.
Faced with the choice, I'd err on the security side because it's far easier
to explain to somebody that the default is full mitigation at a cost than it
is to explain why a partial mitigation is acceptable (and in the end it's
often subjective because people have different thresholds).

> Also, I'd like to have Kees's view on the gap between REFCOUNT_FULL
> and the fast version on arm64. I'm not convinced the cases we are not
> covering are such a big deal.

Fair enough, but if the conclusion is that it's not a big deal then we
should just remove REFCOUNT_FULL altogether, because it's the choice that
is the problem here.

Will
