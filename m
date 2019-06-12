Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B90AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9FF207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437337AbfFLJcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:32:02 -0400
Received: from foss.arm.com ([217.140.110.172]:48454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436605AbfFLJcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:32:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A427028;
        Wed, 12 Jun 2019 02:32:01 -0700 (PDT)
Received: from brain-police (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6C563F246;
        Wed, 12 Jun 2019 02:31:59 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:31:53 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] Disable lockref on arm64
Message-ID: <20190612093151.GA11554@brain-police>
References: <20190502082741.GE13955@hc>
 <CAHk-=wjmtMrxC1nSEHarBn8bW+hNXGv=2YeAWmTw1o54V8GKWA@mail.gmail.com>
 <20190502231858.GB13168@dc5-eodlnx05.marvell.com>
 <CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com>
 <20190506061100.GA8465@dc5-eodlnx05.marvell.com>
 <20190506181039.GA2875@brain-police>
 <20190518042424.GA28517@dc5-eodlnx05.marvell.com>
 <CAKv+Gu9U9z3iAuz4V1c5zTHuz1As8FSNGY-TJon4OLErB8ts8Q@mail.gmail.com>
 <20190522160417.GF7876@fuggles.cambridge.arm.com>
 <20190612040933.GA18848@dc5-eodlnx05.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612040933.GA18848@dc5-eodlnx05.marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi JC,

On Wed, Jun 12, 2019 at 04:10:20AM +0000, Jayachandran Chandrasekharan Nair wrote:
> On Wed, May 22, 2019 at 05:04:17PM +0100, Will Deacon wrote:
> > On Sat, May 18, 2019 at 12:00:34PM +0200, Ard Biesheuvel wrote:
> > > On Sat, 18 May 2019 at 06:25, Jayachandran Chandrasekharan Nair
> > > <jnair@marvell.com> wrote:
> > > > Looking thru the perf output of this case (open/close of a file from
> > > > multiple CPUs), I see that refcount is a significant factor in most
> > > > kernel configurations - and that too uses cmpxchg (without yield).
> > > > x86 has an optimized inline version of refcount that helps
> > > > significantly. Do you think this is worth looking at for arm64?
> > > >
> > > 
> > > I looked into this a while ago [0], but at the time, we decided to
> > > stick with the generic implementation until we encountered a use case
> > > that benefits from it. Worth a try, I suppose ...
> > > 
> > > [0] https://lore.kernel.org/linux-arm-kernel/20170903101622.12093-1-ard.biesheuvel@linaro.org/
> > 
> > If JC can show that we benefit from this, it would be interesting to see if
> > we can implement the refcount-full saturating arithmetic using the
> > LDMIN/LDMAX instructions instead of the current cmpxchg() loops.
> 
> Now that the lockref change is mainline, I think we need to take another
> look at this patch.

Before we get too involved with this, I really don't want to start a trend of
"let's try to rewrite all code using cmpxchg() in Linux because of TX2". At
some point, the hardware needs to play ball. However...

Ard's refcount patch was about moving the overflow check out-of-line. A
side-effect of this, is that we avoid the cmpxchg() operation from many of
the operations (atomic_add_unless() disappears), and it's /this/ which helps
you. So there may well be a middle ground where we avoid the complexity of
the out-of-line {over,under}flow handling but do the saturation post-atomic
inline.

I was hoping we could use LDMIN/LDMAX to maintain the semantics of
REFCOUNT_FULL, but now that I think about it I can't see how we could keep
the arithmetic atomic in that case. Hmm.

Whatever we do, I prefer to keep REFCOUNT_FULL the default option for arm64,
so if we can't keep the semantics when we remove the cmpxchg, you'll need to
opt into this at config time.

Will
