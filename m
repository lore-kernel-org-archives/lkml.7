Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCCCECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFD6207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5ZVArQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405776AbfJPXFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:05:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46517 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731616AbfJPXFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:05:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so309701pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvr2k2cesqfqWN6XGDafc/ENwBi4+yjAQQmmpnGGw1M=;
        b=j5ZVArQNVMKzmkp+DRled9bM3rrZ/59tqf72vSdYRblhYDT7OdWKSLu8b4ZhXvnmWY
         RBe0YRjhf+228rDoYlf1FOs4ipUl2vCn9ce/y0H5bt1n78fFi7EPW7r9mFDM9Ik5sCXP
         KFOR6Nb0NkY46WU7xEUn9swCntPjQuLCqe77V1vMCY9uB7LPhRf7+KIZMiZy4wC43aKK
         nmHGIn9otzLVJrfckmeEO6poTKol439elLaDIeGXgzoFcueonkBUVSY1XF1q1BpFvPDG
         u1REr8fQmr++x737PzzimqhhHDd17CdN2S7h/RHfj/hDR5iMB+msu5M68JbMPAfEV35u
         OukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvr2k2cesqfqWN6XGDafc/ENwBi4+yjAQQmmpnGGw1M=;
        b=guejIYVhshw5tmOkRwgTyAQ+HcqNqiKOtxl5b0ySY97G9Z7O+6NvWMVyqoyFVbFPYz
         ZM8cJvefqJ0mWZWtnUHto/5cMEgIAtDbzKCQ65H4TutL+RzW31KMIJMNmBmnYZcBobHw
         00h6Opo285eGXu2zTLGVJMd+MI7AL2vHRtyUipQiPW7WwQmX3vvhh8/DX7M16cu10IJx
         2b2kQG2aDSjNdWgaxrTBw8I3YbnfWzIl4/HjRH0op0PAEo/9DGbyLvpJTf74HFVb49wm
         d2sTJD14WJUgm44h7IgpkYxRFdJpnlIIvK62Ut8mIqJnDVsjMGAH8BRBCHOmjM9Ay1NV
         g8Dw==
X-Gm-Message-State: APjAAAX91dg6FQq1SJsfawG4yVG9uztbyOSmViOXFsKb/L9MgPR5fYzD
        jnR3dkp6qIgyPu+ByWoUNP+25Hp4W67xG+squNDqNA==
X-Google-Smtp-Source: APXvYqwCWg6vuWk/c7vo6aVbHSfyIrRLJzTxaFNbwVhkRwUofko28zx66hVQm8lxJNsn7OZeLh6uNs1z75f9BLHI7/Y=
X-Received: by 2002:a63:5448:: with SMTP id e8mr679797pgm.10.1571267138767;
 Wed, 16 Oct 2019 16:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com> <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
 <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
 <20191015202636.GA1671072@rani> <CAKwvOd=yGXMwdoxKCD2gcEgevozf41jVmqCkW7CU=Xvd7mqtjw@mail.gmail.com>
 <20191016185500.GA2674383@rani>
In-Reply-To: <20191016185500.GA2674383@rani>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 16 Oct 2019 16:05:27 -0700
Message-ID: <CAKwvOdkXDyqMA-mOz_PE9x0V0ePtA9uFcJS+1ibpBqde6MXX4g@mail.gmail.com>
Subject: Re: AMDGPU and 16B stack alignment
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>, "S, Shirish" <sshankar@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "yshuiv7@gmail.com" <yshuiv7@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Matthias Kaehlcke <mka@google.com>,
        "S, Shirish" <Shirish.S@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:55 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Oct 15, 2019 at 06:51:26PM -0700, Nick Desaulniers wrote:
> > On Tue, Oct 15, 2019 at 1:26 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, Oct 15, 2019 at 11:05:56AM -0700, Nick Desaulniers wrote:
> > > > Hmmm...I would have liked to remove it outright, as it is an ABI
> > > > mismatch that is likely to result in instability and non-fun-to-debug
> > > > runtime issues in the future.  I suspect my patch does work for GCC
> > > > 7.1+.  The question is: Do we want to either:
> > > > 1. mark AMDGPU broken for GCC < 7.1, or
> > > > 2. continue supporting it via stack alignment mismatch?
> > > >
> > > > 2 is brittle, and may break at any point in the future, but if it's
> > > > working for someone it does make me feel bad to outright disable it.
> > > > What I'd image 2 looks like is (psuedo code in a Makefile):
> > > >
> > > > if CC_IS_GCC && GCC_VERSION < 7.1:
> > > >   set stack alignment to 16B and hope for the best
> > > >
> > > > So my diff would be amended to keep the stack alignment flags, but
> > > > only to support GCC < 7.1.  And that assumes my change compiles with
> > > > GCC 7.1+. (Looks like it does for me locally with GCC 8.3, but I would
> > > > feel even more confident if someone with hardware to test on and GCC
> > > > 7.1+ could boot test).
> > > > --
> > > > Thanks,
> > > > ~Nick Desaulniers
> > >
> > > If we do keep it, would adding -mstackrealign make it more robust?
> > > That's simple and will only add the alignment to functions that require
> > > 16-byte alignment (at least on gcc).
> >
> > I think there's also `-mincoming-stack-boundary=`.
> > https://github.com/ClangBuiltLinux/linux/issues/735#issuecomment-540038017
>
> Yes, but -mstackrealign looks like it's supported by clang as well.

Good to know, but I want less duct tape, not more.

> >
> > >
> > > Alternative is to use
> > > __attribute__((force_align_arg_pointer)) on functions that might be
> > > called from 8-byte-aligned code.
> >
> > Which is hard to automate and easy to forget.  Likely a large diff to fix today.
>
> Right, this is a no-go, esp to just fix old compilers.
> >
> > >
> > > It looks like -mstackrealign should work from gcc 5.3 onwards.
> >
> > The kernel would generally like to support GCC 4.9+.
> >
> > There's plenty of different ways to keep layering on duct tape and
> > bailing wire to support differing ABIs, but that's just adding
> > technical debt that will have to be repaid one day.  That's why the
> > cleanest solution IMO is mark the driver broken for old toolchains,
> > and use a code-base-consistent stack alignment.  Bending over
> > backwards to support old toolchains means accepting stack alignment
> > mismatches, which is in the "unspecified behavior" ring of the
> > "undefined behavior" Venn diagram.  I have the same opinion on relying
> > on explicitly undefined behavior.
> >
> > I'll send patches for fixing up Clang, but please consider my strong
> > advice to generally avoid stack alignment mismatches, regardless of
> > compiler.
> > --
> > Thanks,
> > ~Nick Desaulniers
>
> What I suggested was in reference to your proposal for dropping the
> -mpreferred-stack-boundary=4 for modern compilers, but keeping it for
> <7.1. -mstackrealign would at least let 5.3 onwards be less likely to
> break (and it doesn't error before then, I think it just doesn't
> actually do anything, so no worse than now at least).
>
> Simply dropping support for <7.1 would be cleanest, yes, but it sounds
> like people don't want to go that far.

That's fair.  I've included your suggestions in the commit message of
02/03 of a series I just sent but forgot to in reply to this thread:
https://lkml.org/lkml/2019/10/16/1700

Also, I do appreciate the suggestions and understand the value of brainstorming.
-- 
Thanks,
~Nick Desaulniers
