Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B9DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF2B2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkUC2VvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733249AbfJOUQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:16:10 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:38392 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfJOUQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:16:10 -0400
Received: by mail-pf1-f178.google.com with SMTP id h195so13188533pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6wGmR3qIig/wVR5vsFEQByfOvdwbfZeNFvYpJXRBa8=;
        b=ZkUC2VvDYeB3kimGxCTRRiD6bzPRrvilRsSrHzdhRZReqGG/sMYHd0CtpUqzg+AYzz
         0/qxUZbei0laUxbaw9rodRBLy8qXWgm+ZoRg4PN4dyrgwyG8HVZXO3z4PjsXC3KdypNL
         wtxm1iWMXo5b1v00eON247x2iP9hOTCKPuYNDnSV6+FwovdrWx/tH18faL5Q9dLC0YkM
         dk4fJmPQ7jPZga/o3RCC8FC6wsGS0vnSN6X+J3hcWTFjD6m0Hx2TN739Gvh7KwrbZg4Q
         s1pimPih476jfM0Yyhiju2TgFAnzvERrrqBZvUA/w/0yiH7Q+GJG/m3Qdj5Kn70u5iDH
         zZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6wGmR3qIig/wVR5vsFEQByfOvdwbfZeNFvYpJXRBa8=;
        b=NIhn6hehTGQgrniSc/jp6rklDQcGxq+4qS7OLN4oEa90Bj1vlqubibyc/gkbP+YXD0
         zCHG0fKuDYD+f4NLdqSNq1+omBxBjiaVbh69fOz+Qna7ANhd9DvYqWlwn69xb3FEc09I
         ziMBNzQmzqPLILK8T8NX5aoFHOqmw9mNZOHXC2aBzy6jyUIJXGBUislWEofT1lP+XS74
         CTOt9uHqLUnjW5FbgWm34Q/sJuEMZoWUPThbbs9xYgml6YO+HSJhJYc8BsTnR0aSX8NP
         x7Cs9GHDv90YTHJfnUYR+7G0O6u3rv7L0Au++qWg7UUnFeF4+W17kSK5PUVm/AWS5lN/
         /3RA==
X-Gm-Message-State: APjAAAWexwF+HNZszaa+Vu4W68qnf0iiA2kt4Q8G++Ut5v2FJaaAYaBz
        t2IhVGmChr6DLol6OkYpyZy1qARqCGodxOvRzkpyTw==
X-Google-Smtp-Source: APXvYqw7meAgMvqhoBX/JmtJARgYzLvgCyfPRVahL0fEM4fvkw+hKAvA0vpgplsq2FMo1H1eF/kDPG6m6XvNRSH+zXE=
X-Received: by 2002:a17:90a:aa81:: with SMTP id l1mr7575pjq.73.1571170568840;
 Tue, 15 Oct 2019 13:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com> <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
 <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com> <CADnq5_P55aRJ-1VVz2uKA=xpddyi0BvDcXqPD=xVpw3aJZrzng@mail.gmail.com>
In-Reply-To: <CADnq5_P55aRJ-1VVz2uKA=xpddyi0BvDcXqPD=xVpw3aJZrzng@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Oct 2019 13:15:57 -0700
Message-ID: <CAKwvOdme6g7rr+AkJi6Do6Rzq7zYAJm+spQaBF3cwgKU1H2ThQ@mail.gmail.com>
Subject: Re: AMDGPU and 16B stack alignment
To:     Alex Deucher <alexdeucher@gmail.com>
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

On Tue, Oct 15, 2019 at 11:30 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Oct 15, 2019 at 2:07 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Oct 15, 2019 at 12:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Tue, Oct 15, 2019 at 9:08 AM S, Shirish <sshankar@amd.com> wrote:
> > > > On 10/15/2019 3:52 AM, Nick Desaulniers wrote:
> > >
> > > > My gcc build fails with below errors:
> > > >
> > > > dcn_calcs.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
> > > >
> > > > dcn_calc_math.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
> >
> > I was able to reproduce this failure on pre-7.1 versions of GCC.  It
> > seems that when:
> > 1. code is using doubles
> > 2. setting -mpreferred-stack-boundary=3 -mno-sse2, ie. 8B stack alignment
> > than GCC produces that error:
> > https://godbolt.org/z/7T8nbH
> >
> > That's already a tall order of constraints, so it's understandable
> > that the compiler would just error likely during instruction
> > selection, but was eventually taught how to solve such constraints.
> >
> > > >
> > > > While GPF observed on clang builds seem to be fixed.
> >
> > Thanks for the report.  Your testing these patches is invaluable, Shirish!
> >
> > >
> > > Ok, so it seems that gcc insists on having at least 2^4 bytes stack
> > > alignment when
> > > SSE is enabled on x86-64, but does not actually rely on that for
> > > correct operation
> > > unless it's using sse2. So -msse always has to be paired with
> > >  -mpreferred-stack-boundary=3.
> >
> > Seemingly only for older versions of GCC, pre 7.1.
> >
> > >
> > > For clang, it sounds like the opposite is true: when passing 16 byte
> > > stack alignment
> > > and having sse/sse2 enabled, it requires the incoming stack to be 16
> > > byte aligned,
> >
> > I don't think it requires the incoming stack to be 16B aligned for
> > sse2, I think it requires the incoming and current stack alignment to
> > match. Today it does not, which is why we observe GPFs.
> >
> > > but passing 8 byte alignment makes it do the right thing.
> > >
> > > So, should we just always pass $(call cc-option, -mpreferred-stack-boundary=4)
> > > to get the desired outcome on both?
> >
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
>
> Well, it's been working as is for years now, at least with gcc, so I'd
> hate to break that.

Ok, I'm happy to leave that as is for GCC, then.  Would you prefer I
modify it for GCC >7.1 or just leave it alone (maybe I'll add a
comment about *why* it's done for GCC)? Would you prefer 1 patch or 4?

>
> Alex
>
> >
> > if CC_IS_GCC && GCC_VERSION < 7.1:
> >   set stack alignment to 16B and hope for the best

Ie, this ^

> >
> > So my diff would be amended to keep the stack alignment flags, but
> > only to support GCC < 7.1.  And that assumes my change compiles with
> > GCC 7.1+. (Looks like it does for me locally with GCC 8.3, but I would
> > feel even more confident if someone with hardware to test on and GCC
> > 7.1+ could boot test).

-- 
Thanks,
~Nick Desaulniers
