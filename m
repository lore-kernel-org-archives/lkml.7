Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5CDC31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 08:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEE221848
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 08:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtVAF8JG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFOIrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 04:47:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45619 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFOIrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 04:47:32 -0400
Received: by mail-io1-f66.google.com with SMTP id e3so10854340ioc.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQIeCnt1AsA94ywJQw2hHXpqHxAaixVgEOd73UMhR9A=;
        b=HtVAF8JGfXGtOsKn/5hM4jRmWuZDCxK4P1zPKEn8a/W1ElFoLR0yxiljTiXqDFRN9w
         uce22IF6s/ZbcZINbvHP03ObxEO1YTv9Ip5P6Dd1hct7PsfAyMGwKivGcbUz3HKmbwR+
         FpIXs1XzRfzFepK/TD1J/eqpUyDg4KuDlcy0VMt48B94/vAHwA2PTHizRfi5lWFbFbiF
         WllwKHfQ37mU52orMh5JG1HbNF5BnxiHGQ4cjfQfkNuXEoPW1QfnTZTJfVr/e7SPTmzo
         B45LKuV/ATZzQFm7Me7KR6PnbVuiJqGqmbKo89KnLnQBDcUuC9syIHM//N+LAYvSLS1S
         zJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQIeCnt1AsA94ywJQw2hHXpqHxAaixVgEOd73UMhR9A=;
        b=A8CeC4dErqoySiczFQs0MyRZLziXycJob/YK0daeOQ7C7jzVhapb8Sl1Q75bqanEQH
         bhyMc3OHiyUUFjw6fILlub6DglVDp1azzVDzFB6Pjz7/O31slNJXwBbNqOZffohFXeyD
         gOuVf2uaULfH4tWxxkMRvuZL/mAZgCdjLhMRWLEF+cu9I1fYSKHUu3tVtdfsOffO55VI
         NTjOl9QtgdsxlEnmfzm9k0thLksNSeCwgtoaAtjcqEp8KTJKfdc8cvieIs1/WrLY2bSV
         BUbse5rOZKviJaLwG7BLW/27IVxXToRox+ZPvjYcx1eoBAdcFtbPkzeTOmPZ42RzCHkp
         sIGA==
X-Gm-Message-State: APjAAAVYEBtJef7Q5BNW9GO2IGa1t9iJYNDyD+VQhhMcYPkU49euIrn3
        FVqEAHR30Y68YFBt3z1uKdJ1C15AevYWmyxVfxA66Q==
X-Google-Smtp-Source: APXvYqwFMTWQEehXvCimHm7jziuGsyJXKdLo7cMtRP4IicmyX8EmmlCo7hLF6O0vBLtfullbb5IKTHnNO1vZBWbmf/A=
X-Received: by 2002:a02:9143:: with SMTP id b3mr46140454jag.12.1560588450839;
 Sat, 15 Jun 2019 01:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190506181039.GA2875@brain-police> <20190518042424.GA28517@dc5-eodlnx05.marvell.com>
 <CAKv+Gu9U9z3iAuz4V1c5zTHuz1As8FSNGY-TJon4OLErB8ts8Q@mail.gmail.com>
 <20190522160417.GF7876@fuggles.cambridge.arm.com> <20190612040933.GA18848@dc5-eodlnx05.marvell.com>
 <20190612093151.GA11554@brain-police> <20190614070914.GA21961@dc5-eodlnx05.marvell.com>
 <20190614095846.GC10506@fuggles.cambridge.arm.com> <CAKv+Gu_Kdq=UPijjA84FpmO=ZsdEO9EyyF7GeOQ+WmfqtO_hMg@mail.gmail.com>
 <20190614103850.GG10659@fuggles.cambridge.arm.com> <201906142026.1BC27EDB1E@keescook>
In-Reply-To: <201906142026.1BC27EDB1E@keescook>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 15 Jun 2019 10:47:19 +0200
Message-ID: <CAKv+Gu_XuhgUCYOeykrbaxJz-wL1HFrc_O+HeZHqaGkMHd2J9Q@mail.gmail.com>
Subject: Re: [RFC] Disable lockref on arm64
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2019 at 06:21, Kees Cook <keescook@chromium.org> wrote:
>
> tl;dr: if arm/arm64 can catch overflow, untested dec-to-zero, and
> inc-from-zero, while performing better than existing REFCOUNT_FULL,
> it's a no-brainer to switch. Minimum parity to x86 would be to catch
> overflow and untested dec-to-zero. Minimum viable protection would be to
> catch overflow. LKDTM is your friend.
>
> Details below...
>
> On Fri, Jun 14, 2019 at 11:38:50AM +0100, Will Deacon wrote:
> > On Fri, Jun 14, 2019 at 12:24:54PM +0200, Ard Biesheuvel wrote:
> > > On Fri, 14 Jun 2019 at 11:58, Will Deacon <will.deacon@arm.com> wrote:
> > > > On Fri, Jun 14, 2019 at 07:09:26AM +0000, Jayachandran Chandrasekharan Nair wrote:
> > > > > x86 added a arch-specific fast refcount implementation - and the commit
> > > > > specifically notes that it is faster than cmpxchg based code[1].
> > > > >
> > > > > There seems to be an ongoing effort to move over more and more subsystems
> > > > > from atomic_t to refcount_t(e.g.[2]), specifically because refcount_t on
> > > > > x86 is fast enough and you get some error checking atomic_t that does not
> > > > > have.
>
> For clarity: the choices on x86 are: full or fast, where both catch
> the condition that leads to use-after-free that can be unconditionally
> mitigated (i.e. refcount overflow-wrapping to zero: the common missing
> ref count decrement). The _underflow_ case (the less common missing ref
> count increment) can be exploited but nothing can be done to mitigate
> it. Only a later increment from zero can indicate that something went
> wrong _in the past_.
>
> There is not a way to build x86 without the overflow protection, and
> that was matched on arm/arm64 by making REFCOUNT_FULL unconditionally
> enabled. So, from the perspective of my take on weakening the protection
> level, I'm totally fine if arm/arm64 falls back to a non-FULL
> implementation as long as it catches the overflow case (which the prior
> "fast" patches totally did).
>
> > > > Correct, but there are also some cases that are only caught by
> > > > REFCOUNT_FULL.
> > > >
> > > Yes, but do note that my arm64 implementation catches
> > > increment-from-zero as well.
>
> FWIW, the vast majority of bugs that refcount_t has found has been
> inc-from-zero (the overflow case doesn't tend to ever get exercised,
> but it's easy for syzkaller and other fuzzers to underflow when such a
> path is found). And those are only found on REFCOUNT_FULL kernels
> presently, so it'd be nice to have that case covered in the "fast"
> arm/arm64 case too.
>
> > Ok, so it's just the silly racy cases that are problematic?
> >
> > > > > Do you think Ard's patch needs changes before it can be considered? I
> > > > > can take a look at that.
> > > >
> > > > I would like to see how it performs if we keep the checking inline, yes.
> > > > I suspect Ard could spin this in short order.
> > >
> > > Moving the post checks before the stores you mean? That shouldn't be
> > > too difficult, I suppose, but it will certainly cost performance.
> >
> > That's what I'd like to assess, since the major complaint seems to be the
> > use of cmpxchg() as opposed to inline branching.
> >
> > > > > > Whatever we do, I prefer to keep REFCOUNT_FULL the default option for arm64,
> > > > > > so if we can't keep the semantics when we remove the cmpxchg, you'll need to
> > > > > > opt into this at config time.
> > > > >
> > > > > Only arm64 and arm selects REFCOUNT_FULL in the default config. So please
> > > > > reconsider this! This is going to slow down arm64 vs. other archs and it
> > > > > will become worse when more code adopts refcount_t.
> > > >
> > > > Maybe, but faced with the choice between your micro-benchmark results and
> > > > security-by-default for people using the arm64 Linux kernel, I really think
> > > > that's a no-brainer. I'm well aware that not everybody agrees with me on
> > > > that.
> > >
> > > I think the question whether the benchmark is valid is justified, but
> > > otoh, we are obsessed with hackbench which is not that representative
> > > of a real workload either. It would be better to discuss these changes
> > > in the context of known real-world use cases where refcounts are a
> > > true bottleneck.
> >
> > I wasn't calling into question the validity of the benchmark (I really have
> > no clue about that), but rather that you can't have your cake and eat it.
> > Faced with the choice, I'd err on the security side because it's far easier
> > to explain to somebody that the default is full mitigation at a cost than it
> > is to explain why a partial mitigation is acceptable (and in the end it's
> > often subjective because people have different thresholds).
>
> I'm happy to call into question the validity of the benchmark though! ;)
> Seriously, it came up repeatedly in the x86 port, where there was a
> claim of "it's slower" (which is certainly objectively true: more cycles
> are spent), but no one could present a real-world workload where the
> difference was measurable.
>
> > > Also, I'd like to have Kees's view on the gap between REFCOUNT_FULL
> > > and the fast version on arm64. I'm not convinced the cases we are not
> > > covering are such a big deal.
> >
> > Fair enough, but if the conclusion is that it's not a big deal then we
> > should just remove REFCOUNT_FULL altogether, because it's the choice that
> > is the problem here.
>
> The coverage difference on x86 is that inc-from-zero is only caught in
> the FULL case. Additionally there is the internal difference around how
> "saturation" of the value happens. e.g. under FULL a count gets pinned
> either to INT_MAX or to zero.
>
> Since the "fast" arm patch caught inc-from-zero, I would say sure
> ditch FULL in favor of it (though check that "dec-to-zero" is caught:
> i.e. _dec() hitting zero -- instead of dec_and_test() hitting zero). LKDTM
> has extensive behavioral tests for refcount_t, so if the tests show the
> same results before/after, go for it. :) Though note that the logic may
> need tweaking depending on the saturation behavior: right now it expects
> either FULL (INT_MAX/0 pinning) or the x86 saturation (INT_MIN / 2).
>
> Note also that LKDTM has a refcount benchmark as well, in case you want
> to measure the difference between atomic_t and refcount_t in the most
> microbenchmark-y way possible. This is what was used for the numbers in
> commit 7a46ec0e2f48 ("locking/refcounts, x86/asm: Implement fast
> refcount overflow protection"):
>
>  2147483646 refcount_inc()s and 2147483647 refcount_dec_and_test()s:
>                  cycles        protections
>  atomic_t         82249267387  none
>  refcount_t-fast  82211446892  overflow, untested dec-to-zero
>  refcount_t-full 144814735193  overflow, untested dec-to-zero, inc-from-zero
>
> Also note that the x86 fast implementations adjusted memory ordering
> slightly later on in commit 47b8f3ab9c49 ("refcount_t: Add ACQUIRE
> ordering on success for dec(sub)_and_test() variants").
>

Thanks Kees.

That acquire ordering patch appears to carry over cleanly . So the
remaining question Will had was whether it makes sense to do the
condition checks before doing the actual store, to avoid having a time
window where the refcount assumes its illegal value. Since arm64 does
not have memory operands, the instruction count wouldn't change, but
it will definitely result in a performance hit on out-of-order CPUs.
