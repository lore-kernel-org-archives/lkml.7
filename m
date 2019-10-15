Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F304F20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1bYUzxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfJOSai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 14:30:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35558 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfJOSai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:30:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id y21so137468wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 11:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzFVXgcr+SbryhCTIPWP1x78uV1MrL2l3mggmZnG6J0=;
        b=d1bYUzxclgcIwQyGom6nQU9FbRAuZmgiWTJXIBD5CvPkiODLcyyeIH5MOmgIY5qegO
         wF9rakwLnWkpSmQS7tuNvPqrIV4uY42XgwNk9G+8FFAJs3YrSvMGseDiXQphlRKvwwpj
         QDiPkjXQKBwyUMwZurpk0auizQkZlIDGnKV9JzTvAMK07ogKXnNVfKPZUFqfNfgFhoWV
         Jl/NGyisdi4XUPts9Ku7O0WnFdjKBRJRQAjsLO8ApfiVQcDk/WNiqXxU1ElOmVa/1fr9
         EuU0BVoz6u0pWJau3jxbISHWYBhp9nVITAudMISOYVUTmt/NJB8yPRp9LZMsJcnjAbDj
         s17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzFVXgcr+SbryhCTIPWP1x78uV1MrL2l3mggmZnG6J0=;
        b=LOwAimDz3mpYFYUhVH80sOvH47zEfTJRYyuv9QCRFPLpUDx3e7BnrAioze6SQCp4zL
         mNYzboUUhLPGTNlMoBAuoriQnYZ8qTEYeucjs7U10GKhBF8kWjyM1fmZw/SRDCQWUfZY
         kxcodZvD7MBJOJji9s47yY+QRyoc9471BwBiyW5FQ8ZHIp9pWx8WZxLPxq6Nksb5ehfr
         rpOHSzzJcwA3/Zb2AAYlf0/pBjRWJunJMc+7Pmu00Rj7PhghjPnaiw5x8DCWZIoLvk2u
         YHpZQMzIVSdcaO7w0dO3R4BxobXqCygH0eFmW92aB9AOW40KIaTFEpBv8OMv36w4Z4Eo
         oAhQ==
X-Gm-Message-State: APjAAAVnHqs7VFVtlZK7KRqg0dhC0c/UYtrY0IvEc3ffI9Lj9eeGgdau
        TbrEIzw8n9FUEbt4fFZuIIdWGiTwbz/yAiQ2Nmg=
X-Google-Smtp-Source: APXvYqw5mjBI9MyTnIQNVNmV4S5NIMpCWobeJtM4nSdr7tbShHIZntss/bw3jdnI/nRWI/84Xu5NwnHBlop2AsFW3/U=
X-Received: by 2002:a1c:d0:: with SMTP id 199mr21418272wma.67.1571164236355;
 Tue, 15 Oct 2019 11:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com> <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
 <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
In-Reply-To: <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Oct 2019 14:30:23 -0400
Message-ID: <CADnq5_P55aRJ-1VVz2uKA=xpddyi0BvDcXqPD=xVpw3aJZrzng@mail.gmail.com>
Subject: Re: AMDGPU and 16B stack alignment
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "S, Shirish" <sshankar@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "S, Shirish" <Shirish.S@amd.com>,
        Matthias Kaehlcke <mka@google.com>,
        "yshuiv7@gmail.com" <yshuiv7@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 2:07 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Oct 15, 2019 at 12:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Oct 15, 2019 at 9:08 AM S, Shirish <sshankar@amd.com> wrote:
> > > On 10/15/2019 3:52 AM, Nick Desaulniers wrote:
> >
> > > My gcc build fails with below errors:
> > >
> > > dcn_calcs.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
> > >
> > > dcn_calc_math.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
>
> I was able to reproduce this failure on pre-7.1 versions of GCC.  It
> seems that when:
> 1. code is using doubles
> 2. setting -mpreferred-stack-boundary=3 -mno-sse2, ie. 8B stack alignment
> than GCC produces that error:
> https://godbolt.org/z/7T8nbH
>
> That's already a tall order of constraints, so it's understandable
> that the compiler would just error likely during instruction
> selection, but was eventually taught how to solve such constraints.
>
> > >
> > > While GPF observed on clang builds seem to be fixed.
>
> Thanks for the report.  Your testing these patches is invaluable, Shirish!
>
> >
> > Ok, so it seems that gcc insists on having at least 2^4 bytes stack
> > alignment when
> > SSE is enabled on x86-64, but does not actually rely on that for
> > correct operation
> > unless it's using sse2. So -msse always has to be paired with
> >  -mpreferred-stack-boundary=3.
>
> Seemingly only for older versions of GCC, pre 7.1.
>
> >
> > For clang, it sounds like the opposite is true: when passing 16 byte
> > stack alignment
> > and having sse/sse2 enabled, it requires the incoming stack to be 16
> > byte aligned,
>
> I don't think it requires the incoming stack to be 16B aligned for
> sse2, I think it requires the incoming and current stack alignment to
> match. Today it does not, which is why we observe GPFs.
>
> > but passing 8 byte alignment makes it do the right thing.
> >
> > So, should we just always pass $(call cc-option, -mpreferred-stack-boundary=4)
> > to get the desired outcome on both?
>
> Hmmm...I would have liked to remove it outright, as it is an ABI
> mismatch that is likely to result in instability and non-fun-to-debug
> runtime issues in the future.  I suspect my patch does work for GCC
> 7.1+.  The question is: Do we want to either:
> 1. mark AMDGPU broken for GCC < 7.1, or
> 2. continue supporting it via stack alignment mismatch?
>
> 2 is brittle, and may break at any point in the future, but if it's
> working for someone it does make me feel bad to outright disable it.
> What I'd image 2 looks like is (psuedo code in a Makefile):

Well, it's been working as is for years now, at least with gcc, so I'd
hate to break that.

Alex

>
> if CC_IS_GCC && GCC_VERSION < 7.1:
>   set stack alignment to 16B and hope for the best
>
> So my diff would be amended to keep the stack alignment flags, but
> only to support GCC < 7.1.  And that assumes my change compiles with
> GCC 7.1+. (Looks like it does for me locally with GCC 8.3, but I would
> feel even more confident if someone with hardware to test on and GCC
> 7.1+ could boot test).
> --
> Thanks,
> ~Nick Desaulniers
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
