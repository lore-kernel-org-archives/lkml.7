Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4353ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC88D2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPI8JjSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389557AbfJPBvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 21:51:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39232 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfJPBvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 21:51:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so13645017pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 18:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eInMsMe+BJaYRY1Pz9oWe+U9MwphvcdZCLcBAxvz7R0=;
        b=XPI8JjSsYj2wNPJu04c2XrN1/PeiTZfQIUnpdo/TyHS6cpar5/1bLRDjwA0cPCx6be
         n2YvCGW7epfY3GWj1ROYKCzbAYH8LTfKoC9HTIukwIP+IFA76LYQ38jP5uNUZ1+ydZx5
         ZI4YJCpAjhjueDXz6a1lbLprnoEEeJpCKgx4XVW0vGzLcWfbVzzvm7tQChbAm8p5s7Ej
         k2ylWDmyDhfbh0bCaxt1fvxQb4bIfU44/U0wop9nrLb57GKqMxHajEPt1y8UzQLXV9C9
         B76LN9xOBBh8AU7kAAG6T8ZJtmBpolQnOrUbbrEvzuZIv2s91bNWbNl1ScmVJZZv2Oqf
         hI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eInMsMe+BJaYRY1Pz9oWe+U9MwphvcdZCLcBAxvz7R0=;
        b=pacwHh8HmigBi87FQIrgpFXRv3LRWekFYzoywHmYK1lvfWI3yGjSnwERnokLtzbTgd
         y0ntuy4ey1uOMWtq9D52geZg3HQ5f6Kh9h2KOOmUwSpsYMmApxCHBRahaCOOfDQJPeUN
         3XW6MsFkO64m1EGlfGEpViY6TOvDx3GerzQBBJRai9JkZ0PkdbvIF/lhz2Sqsf/kd+LD
         kRuVyrWLPnF/kWePzRK8MZYcbACr1t+938CNMaapmlXMiEVkl7ydQIsUUmQUMpPe76c0
         INLQZDG0D+EUcs4tX9XfQsxir+mzbY0Y/1mGoO00147mGIFCp/J7Qia4BFrC7AfD2Why
         2Zew==
X-Gm-Message-State: APjAAAU/wU6vOstMSphZJS53rLclNownPcgWM3J+Xb/L8C528i1B0IP0
        kJClzv30Nvz913Rc39YTq7JNDpBEovBRxO/LnymghwF9uoM=
X-Google-Smtp-Source: APXvYqwRKPbjtP3iHgUwdE5xgVuxjM/o+4isROAa/cr/OlgflkHBhgT2X2KSWEZJdk2KR7aGLa/Ihza4EKunVksUgVQ=
X-Received: by 2002:a63:5a03:: with SMTP id o3mr4805222pgb.381.1571190696394;
 Tue, 15 Oct 2019 18:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com> <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
 <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com> <20191015202636.GA1671072@rani>
In-Reply-To: <20191015202636.GA1671072@rani>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Oct 2019 18:51:26 -0700
Message-ID: <CAKwvOd=yGXMwdoxKCD2gcEgevozf41jVmqCkW7CU=Xvd7mqtjw@mail.gmail.com>
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

On Tue, Oct 15, 2019 at 1:26 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Oct 15, 2019 at 11:05:56AM -0700, Nick Desaulniers wrote:
> > Hmmm...I would have liked to remove it outright, as it is an ABI
> > mismatch that is likely to result in instability and non-fun-to-debug
> > runtime issues in the future.  I suspect my patch does work for GCC
> > 7.1+.  The question is: Do we want to either:
> > 1. mark AMDGPU broken for GCC < 7.1, or
> > 2. continue supporting it via stack alignment mismatch?
> >
> > 2 is brittle, and may break at any point in the future, but if it's
> > working for someone it does make me feel bad to outright disable it.
> > What I'd image 2 looks like is (psuedo code in a Makefile):
> >
> > if CC_IS_GCC && GCC_VERSION < 7.1:
> >   set stack alignment to 16B and hope for the best
> >
> > So my diff would be amended to keep the stack alignment flags, but
> > only to support GCC < 7.1.  And that assumes my change compiles with
> > GCC 7.1+. (Looks like it does for me locally with GCC 8.3, but I would
> > feel even more confident if someone with hardware to test on and GCC
> > 7.1+ could boot test).
> > --
> > Thanks,
> > ~Nick Desaulniers
>
> If we do keep it, would adding -mstackrealign make it more robust?
> That's simple and will only add the alignment to functions that require
> 16-byte alignment (at least on gcc).

I think there's also `-mincoming-stack-boundary=`.
https://github.com/ClangBuiltLinux/linux/issues/735#issuecomment-540038017

>
> Alternative is to use
> __attribute__((force_align_arg_pointer)) on functions that might be
> called from 8-byte-aligned code.

Which is hard to automate and easy to forget.  Likely a large diff to fix today.

>
> It looks like -mstackrealign should work from gcc 5.3 onwards.

The kernel would generally like to support GCC 4.9+.

There's plenty of different ways to keep layering on duct tape and
bailing wire to support differing ABIs, but that's just adding
technical debt that will have to be repaid one day.  That's why the
cleanest solution IMO is mark the driver broken for old toolchains,
and use a code-base-consistent stack alignment.  Bending over
backwards to support old toolchains means accepting stack alignment
mismatches, which is in the "unspecified behavior" ring of the
"undefined behavior" Venn diagram.  I have the same opinion on relying
on explicitly undefined behavior.

I'll send patches for fixing up Clang, but please consider my strong
advice to generally avoid stack alignment mismatches, regardless of
compiler.
--
Thanks,
~Nick Desaulniers
