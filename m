Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22944ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8FE205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljbIiqwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbfJOSGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 14:06:09 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:33752 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfJOSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:06:09 -0400
Received: by mail-pl1-f172.google.com with SMTP id d22so9970755pls.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 11:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBqT9Ybr/Ipic63e3mRedQn/6ltePkNsW7NCVWavp3g=;
        b=ljbIiqwTrf9NgeFAUtAMBFbK8YLkRUnSe2tlxycaq/vf6DF+H5f5YZwmFn6BZThyMx
         GMnP05W2z06TEWbrr7e6mBtKXgyQ5vwWFyMHlx0eP1C8o7USaba3spZ3vAdAFxGi5Ych
         6R3em4hnjlCV/+9+5aVmTHipoSIFG1IeYAEjGz4CKeox9hY6sRiPne5GqYdWOhcz8SMs
         ux2fodB3vdy1OJcfDNCV1X1Es8hxIxqLqoRVfszKdjWtw1kgx1acKA9VnvaPt5lEaSSO
         Xuy0A5V5kkr3AnMXf5BTFZe6/IlOrY6vcqNsE8S1jhoMBzXKNhN5JGucaw2Q+m7Wv0na
         +gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBqT9Ybr/Ipic63e3mRedQn/6ltePkNsW7NCVWavp3g=;
        b=eaiUKE/MdrHoU9SbqO+i4EwNvqhGaKYjJuiEY+/uw9/tw6reqkuLrnRq/uYm5UkAUd
         fEclmWFui4YEe2IaQ0oJ655qrp5hXqjBnkKBqQntC8ieAEQZSQmaB6K0nJOWRXjSU6C+
         cnEc9J5EDnj7lh4nOU+plEGwAF5kl0xdDX5MEK4+yVtk94u/x16jeqa3O8w2yiNKzzVy
         H0ce+OJShF63M/8uElLkpCCRAVBRDSZnIcGVeHgSZn/hYLDn/u88Oh40BK1jW1t6JC5j
         FuZygaxbGatHovJKSzEzURBrij5kY2kx2AnToK4L+QnIyI8gi0ELeQ+O/JvCqYsgrt8C
         5XPQ==
X-Gm-Message-State: APjAAAX+eHuuu0RhXNU351zk8Zk591/f/UOVnqM+uKGBvrXKC0IQeSJQ
        RICw0m1bS55JHsHh0IcJazNArPmrX+zqfGmhDiqEOw==
X-Google-Smtp-Source: APXvYqx/GzA2ea/qqOKmR0URniymnPEQbAPNCRFY3WJQqBqUY31DiRHgDGzArE6Z+eGUbLr7QD5P9iMo1PzrV5IgrKA=
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr36165530plp.179.1571162768113;
 Tue, 15 Oct 2019 11:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com> <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
In-Reply-To: <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Oct 2019 11:05:56 -0700
Message-ID: <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
Subject: Re: AMDGPU and 16B stack alignment
To:     Arnd Bergmann <arnd@arndb.de>, "S, Shirish" <sshankar@amd.com>
Cc:     "Wentland, Harry" <Harry.Wentland@amd.com>,
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

On Tue, Oct 15, 2019 at 12:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Oct 15, 2019 at 9:08 AM S, Shirish <sshankar@amd.com> wrote:
> > On 10/15/2019 3:52 AM, Nick Desaulniers wrote:
>
> > My gcc build fails with below errors:
> >
> > dcn_calcs.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
> >
> > dcn_calc_math.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12

I was able to reproduce this failure on pre-7.1 versions of GCC.  It
seems that when:
1. code is using doubles
2. setting -mpreferred-stack-boundary=3 -mno-sse2, ie. 8B stack alignment
than GCC produces that error:
https://godbolt.org/z/7T8nbH

That's already a tall order of constraints, so it's understandable
that the compiler would just error likely during instruction
selection, but was eventually taught how to solve such constraints.

> >
> > While GPF observed on clang builds seem to be fixed.

Thanks for the report.  Your testing these patches is invaluable, Shirish!

>
> Ok, so it seems that gcc insists on having at least 2^4 bytes stack
> alignment when
> SSE is enabled on x86-64, but does not actually rely on that for
> correct operation
> unless it's using sse2. So -msse always has to be paired with
>  -mpreferred-stack-boundary=3.

Seemingly only for older versions of GCC, pre 7.1.

>
> For clang, it sounds like the opposite is true: when passing 16 byte
> stack alignment
> and having sse/sse2 enabled, it requires the incoming stack to be 16
> byte aligned,

I don't think it requires the incoming stack to be 16B aligned for
sse2, I think it requires the incoming and current stack alignment to
match. Today it does not, which is why we observe GPFs.

> but passing 8 byte alignment makes it do the right thing.
>
> So, should we just always pass $(call cc-option, -mpreferred-stack-boundary=4)
> to get the desired outcome on both?

Hmmm...I would have liked to remove it outright, as it is an ABI
mismatch that is likely to result in instability and non-fun-to-debug
runtime issues in the future.  I suspect my patch does work for GCC
7.1+.  The question is: Do we want to either:
1. mark AMDGPU broken for GCC < 7.1, or
2. continue supporting it via stack alignment mismatch?

2 is brittle, and may break at any point in the future, but if it's
working for someone it does make me feel bad to outright disable it.
What I'd image 2 looks like is (psuedo code in a Makefile):

if CC_IS_GCC && GCC_VERSION < 7.1:
  set stack alignment to 16B and hope for the best

So my diff would be amended to keep the stack alignment flags, but
only to support GCC < 7.1.  And that assumes my change compiles with
GCC 7.1+. (Looks like it does for me locally with GCC 8.3, but I would
feel even more confident if someone with hardware to test on and GCC
7.1+ could boot test).
-- 
Thanks,
~Nick Desaulniers
