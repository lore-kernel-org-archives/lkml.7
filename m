Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40172C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D4921773
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NJo/Eh84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFOEVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 00:21:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33003 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfFOEVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 00:21:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id k187so2649897pga.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 21:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e2sMQ1AZ0GtcV+cpgmOhkEZAkfXP9SWkwW6WWCjK14E=;
        b=NJo/Eh84TXhtAiPaNmEx+xZQeCM0zcjl41wUNj7hhj/WaID6M1FO62iXhG8gt/MNWl
         RvLnpnvvPa02OWyxRyLcLlwErMp7n7+JtmlXIEqgyck7bznOsIrM/Z2sNVWj3w5Xvyg7
         5Rb6VzHLLzgr0D8GSKFDpw2IsqwMToJn74hJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e2sMQ1AZ0GtcV+cpgmOhkEZAkfXP9SWkwW6WWCjK14E=;
        b=GW+sfg6Ot+JMkctDUpUK1jBBQun0zRKSeOPkdUbetTwpHgaXs7PXuqPPgJQHxAp6bc
         UlGLhNZvz05uRzwfTRL5JSJAS+wex8GJVp2H7XO9v5AmjKd1KMkypUi2+x4QaHEf7P2/
         2zDh06AriPCyiQzI6+k7E8SYzv6kiIfUPlqdRWERDs/2BhqoZgbTPvWv0wtUHlr1547o
         Ke3Ixy0BFP0zwQrd/hEMWEFIHfHsJzNItmKDmvglHrnqJxNHTt2rAAg7UO1fX6T2h/te
         rFFh+q9eWJM9jNNhUL8HweNyndcf/ArqwKIg+9GRDj93lePgOVwyYMNfoZMjKasQgoGe
         5UNQ==
X-Gm-Message-State: APjAAAUpJs+wMYieAnruvDfSNNCzdKxnpoPceRNsHQWSBlpEV74OJPbN
        JPzeaoOoyKzgkRZksueDHidRbA==
X-Google-Smtp-Source: APXvYqyVgt5pnlVfhuyZa6vFwsGeGO8MPwwOGiXx1xL0K0Q9qN6dU+LywkN1KUgj2GhkelxQC9yBDA==
X-Received: by 2002:a65:638e:: with SMTP id h14mr16564299pgv.86.1560572497170;
        Fri, 14 Jun 2019 21:21:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b2sm4370319pgk.50.2019.06.14.21.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 21:21:35 -0700 (PDT)
Date:   Fri, 14 Jun 2019 21:21:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] Disable lockref on arm64
Message-ID: <201906142026.1BC27EDB1E@keescook>
References: <20190506181039.GA2875@brain-police>
 <20190518042424.GA28517@dc5-eodlnx05.marvell.com>
 <CAKv+Gu9U9z3iAuz4V1c5zTHuz1As8FSNGY-TJon4OLErB8ts8Q@mail.gmail.com>
 <20190522160417.GF7876@fuggles.cambridge.arm.com>
 <20190612040933.GA18848@dc5-eodlnx05.marvell.com>
 <20190612093151.GA11554@brain-police>
 <20190614070914.GA21961@dc5-eodlnx05.marvell.com>
 <20190614095846.GC10506@fuggles.cambridge.arm.com>
 <CAKv+Gu_Kdq=UPijjA84FpmO=ZsdEO9EyyF7GeOQ+WmfqtO_hMg@mail.gmail.com>
 <20190614103850.GG10659@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614103850.GG10659@fuggles.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tl;dr: if arm/arm64 can catch overflow, untested dec-to-zero, and
inc-from-zero, while performing better than existing REFCOUNT_FULL,
it's a no-brainer to switch. Minimum parity to x86 would be to catch
overflow and untested dec-to-zero. Minimum viable protection would be to
catch overflow. LKDTM is your friend.

Details below...

On Fri, Jun 14, 2019 at 11:38:50AM +0100, Will Deacon wrote:
> On Fri, Jun 14, 2019 at 12:24:54PM +0200, Ard Biesheuvel wrote:
> > On Fri, 14 Jun 2019 at 11:58, Will Deacon <will.deacon@arm.com> wrote:
> > > On Fri, Jun 14, 2019 at 07:09:26AM +0000, Jayachandran Chandrasekharan Nair wrote:
> > > > x86 added a arch-specific fast refcount implementation - and the commit
> > > > specifically notes that it is faster than cmpxchg based code[1].
> > > >
> > > > There seems to be an ongoing effort to move over more and more subsystems
> > > > from atomic_t to refcount_t(e.g.[2]), specifically because refcount_t on
> > > > x86 is fast enough and you get some error checking atomic_t that does not
> > > > have.

For clarity: the choices on x86 are: full or fast, where both catch
the condition that leads to use-after-free that can be unconditionally
mitigated (i.e. refcount overflow-wrapping to zero: the common missing
ref count decrement). The _underflow_ case (the less common missing ref
count increment) can be exploited but nothing can be done to mitigate
it. Only a later increment from zero can indicate that something went
wrong _in the past_.

There is not a way to build x86 without the overflow protection, and
that was matched on arm/arm64 by making REFCOUNT_FULL unconditionally
enabled. So, from the perspective of my take on weakening the protection
level, I'm totally fine if arm/arm64 falls back to a non-FULL
implementation as long as it catches the overflow case (which the prior
"fast" patches totally did).

> > > Correct, but there are also some cases that are only caught by
> > > REFCOUNT_FULL.
> > >
> > Yes, but do note that my arm64 implementation catches
> > increment-from-zero as well.

FWIW, the vast majority of bugs that refcount_t has found has been
inc-from-zero (the overflow case doesn't tend to ever get exercised,
but it's easy for syzkaller and other fuzzers to underflow when such a
path is found). And those are only found on REFCOUNT_FULL kernels
presently, so it'd be nice to have that case covered in the "fast"
arm/arm64 case too.

> Ok, so it's just the silly racy cases that are problematic?
> 
> > > > Do you think Ard's patch needs changes before it can be considered? I
> > > > can take a look at that.
> > >
> > > I would like to see how it performs if we keep the checking inline, yes.
> > > I suspect Ard could spin this in short order.
> > 
> > Moving the post checks before the stores you mean? That shouldn't be
> > too difficult, I suppose, but it will certainly cost performance.
> 
> That's what I'd like to assess, since the major complaint seems to be the
> use of cmpxchg() as opposed to inline branching.
> 
> > > > > Whatever we do, I prefer to keep REFCOUNT_FULL the default option for arm64,
> > > > > so if we can't keep the semantics when we remove the cmpxchg, you'll need to
> > > > > opt into this at config time.
> > > >
> > > > Only arm64 and arm selects REFCOUNT_FULL in the default config. So please
> > > > reconsider this! This is going to slow down arm64 vs. other archs and it
> > > > will become worse when more code adopts refcount_t.
> > >
> > > Maybe, but faced with the choice between your micro-benchmark results and
> > > security-by-default for people using the arm64 Linux kernel, I really think
> > > that's a no-brainer. I'm well aware that not everybody agrees with me on
> > > that.
> > 
> > I think the question whether the benchmark is valid is justified, but
> > otoh, we are obsessed with hackbench which is not that representative
> > of a real workload either. It would be better to discuss these changes
> > in the context of known real-world use cases where refcounts are a
> > true bottleneck.
> 
> I wasn't calling into question the validity of the benchmark (I really have
> no clue about that), but rather that you can't have your cake and eat it.
> Faced with the choice, I'd err on the security side because it's far easier
> to explain to somebody that the default is full mitigation at a cost than it
> is to explain why a partial mitigation is acceptable (and in the end it's
> often subjective because people have different thresholds).

I'm happy to call into question the validity of the benchmark though! ;)
Seriously, it came up repeatedly in the x86 port, where there was a
claim of "it's slower" (which is certainly objectively true: more cycles
are spent), but no one could present a real-world workload where the
difference was measurable.

> > Also, I'd like to have Kees's view on the gap between REFCOUNT_FULL
> > and the fast version on arm64. I'm not convinced the cases we are not
> > covering are such a big deal.
> 
> Fair enough, but if the conclusion is that it's not a big deal then we
> should just remove REFCOUNT_FULL altogether, because it's the choice that
> is the problem here.

The coverage difference on x86 is that inc-from-zero is only caught in
the FULL case. Additionally there is the internal difference around how
"saturation" of the value happens. e.g. under FULL a count gets pinned
either to INT_MAX or to zero.

Since the "fast" arm patch caught inc-from-zero, I would say sure
ditch FULL in favor of it (though check that "dec-to-zero" is caught:
i.e. _dec() hitting zero -- instead of dec_and_test() hitting zero). LKDTM
has extensive behavioral tests for refcount_t, so if the tests show the
same results before/after, go for it. :) Though note that the logic may
need tweaking depending on the saturation behavior: right now it expects
either FULL (INT_MAX/0 pinning) or the x86 saturation (INT_MIN / 2).

Note also that LKDTM has a refcount benchmark as well, in case you want
to measure the difference between atomic_t and refcount_t in the most
microbenchmark-y way possible. This is what was used for the numbers in
commit 7a46ec0e2f48 ("locking/refcounts, x86/asm: Implement fast
refcount overflow protection"):

 2147483646 refcount_inc()s and 2147483647 refcount_dec_and_test()s:
                 cycles        protections
 atomic_t         82249267387  none
 refcount_t-fast  82211446892  overflow, untested dec-to-zero
 refcount_t-full 144814735193  overflow, untested dec-to-zero, inc-from-zero

Also note that the x86 fast implementations adjusted memory ordering
slightly later on in commit 47b8f3ab9c49 ("refcount_t: Add ACQUIRE
ordering on success for dec(sub)_and_test() variants").

-- 
Kees Cook
