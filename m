Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F51C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E8721773
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfFNJ6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:58:52 -0400
Received: from foss.arm.com ([217.140.110.172]:58442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfFNJ6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:58:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ABB72B;
        Fri, 14 Jun 2019 02:58:49 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3357A3F718;
        Fri, 14 Jun 2019 03:00:32 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:58:46 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC] Disable lockref on arm64
Message-ID: <20190614095846.GC10506@fuggles.cambridge.arm.com>
References: <20190502231858.GB13168@dc5-eodlnx05.marvell.com>
 <CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com>
 <20190506061100.GA8465@dc5-eodlnx05.marvell.com>
 <20190506181039.GA2875@brain-police>
 <20190518042424.GA28517@dc5-eodlnx05.marvell.com>
 <CAKv+Gu9U9z3iAuz4V1c5zTHuz1As8FSNGY-TJon4OLErB8ts8Q@mail.gmail.com>
 <20190522160417.GF7876@fuggles.cambridge.arm.com>
 <20190612040933.GA18848@dc5-eodlnx05.marvell.com>
 <20190612093151.GA11554@brain-police>
 <20190614070914.GA21961@dc5-eodlnx05.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614070914.GA21961@dc5-eodlnx05.marvell.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Kees]

On Fri, Jun 14, 2019 at 07:09:26AM +0000, Jayachandran Chandrasekharan Nair wrote:
> On Wed, Jun 12, 2019 at 10:31:53AM +0100, Will Deacon wrote:
> > On Wed, Jun 12, 2019 at 04:10:20AM +0000, Jayachandran Chandrasekharan Nair wrote:
> > > Now that the lockref change is mainline, I think we need to take another
> > > look at this patch.
> > 
> > Before we get too involved with this, I really don't want to start a trend of
> > "let's try to rewrite all code using cmpxchg() in Linux because of TX2".
> 
> x86 added a arch-specific fast refcount implementation - and the commit
> specifically notes that it is faster than cmpxchg based code[1].
> 
> There seems to be an ongoing effort to move over more and more subsystems
> from atomic_t to refcount_t(e.g.[2]), specifically because refcount_t on
> x86 is fast enough and you get some error checking atomic_t that does not
> have.

Correct, but there are also some cases that are only caught by
REFCOUNT_FULL.

> > At some point, the hardware needs to play ball. However...
> 
> Even on a totally baller CPU, REFCOUNT_FULL is going to be slow :)
> On TX2, this specific benchmark just highlights the issue, but the
> difference is significant even on x86 (as noted above).

My point was more general than that. If you want scalable concurrent code,
then you end up having to move away from the serialisation introduced by
locking. The main trick in the toolbox is cmpxchg() so, in the absence of
a zoo of special-purpose atomic instructions, it really needs to do better
than serialising.

> > I was hoping we could use LDMIN/LDMAX to maintain the semantics of
> > REFCOUNT_FULL, but now that I think about it I can't see how we could keep
> > the arithmetic atomic in that case. Hmm.
> 
> Do you think Ard's patch needs changes before it can be considered? I
> can take a look at that.

I would like to see how it performs if we keep the checking inline, yes.
I suspect Ard could spin this in short order.

> > Whatever we do, I prefer to keep REFCOUNT_FULL the default option for arm64,
> > so if we can't keep the semantics when we remove the cmpxchg, you'll need to
> > opt into this at config time.
> 
> Only arm64 and arm selects REFCOUNT_FULL in the default config. So please
> reconsider this! This is going to slow down arm64 vs. other archs and it
> will become worse when more code adopts refcount_t.

Maybe, but faced with the choice between your micro-benchmark results and
security-by-default for people using the arm64 Linux kernel, I really think
that's a no-brainer. I'm well aware that not everybody agrees with me on
that.

Will
