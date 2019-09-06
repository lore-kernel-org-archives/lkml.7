Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27E5C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D082214E0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwGlTu37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395323AbfIFSOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:14:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46538 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbfIFSOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:14:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so4998052pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVmS35APPsvZEyHb/hkutEn/YX4Fk0dbgk2QnuIg6M8=;
        b=bwGlTu37wG//Rl/oPzfokc56k5fbB+PzXpwdhNVKe40PvEcZiFZviCIK8Vxg4zic4F
         BQxTWx+Z4HAhHgP/ZwTYh68NEgKp2EPdg8T2twTkqi3GLqWu66MQDjdGPl0vxmDy9hLm
         zeOmvWKymiCagahdfkvPVK1ibc6B8/SiJppqMehonaXQ0yEyd28TF9UhrRWLa/b50BBa
         ViTQzx/4D0PCoD1pPLC9hBsVty5O5kzC2l+Y8itRiQpsn8VizCaGTYTbS9kE5ycFZ7VK
         ZrfTyienHowZ+tvqw5BuMU/446R7mNNSmh06UhYcNhz2Jd1N0RACIeAlYyVdGNwI0PSa
         aNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVmS35APPsvZEyHb/hkutEn/YX4Fk0dbgk2QnuIg6M8=;
        b=tIkDCqNmfdrPYyaYR1ze4sL40r+c3EKJcOOBMJ4xZ2vn1gHzlhVCqLH8i1yWzaLiJG
         wuA+Y9d/HXopudgzl/LI6L1j/7XTmY01jNVhA5XttYgpjefpDOpCUguLQXtPmw7qE+9H
         vgSk+145FvZKwJgKB40I6dOHDnz3Te18U6l6NDh7pQE6RCB2I2DNh2VeJ01CrkufIWK2
         ADGcA0TFfDQp7ktsW6cVa3iDM0J5u80S/fJG/BFuSDRBICim50eT/AE8PV+MmhXw/RLt
         skUADSEWWzgcVGzUORe9jH6XAZPTFOYPh8SGVRcb/S1axLuJWoIBdxCJc6UsCJUj0lIq
         mjag==
X-Gm-Message-State: APjAAAWB2Llfc47WumPmeAD52LJtOxC2phm1S6IXKoJ+KwN9llt4HjAJ
        aIx58Sdi15aaW/SAUbsfzIaUn7GROInEfYwv4SZjrw==
X-Google-Smtp-Source: APXvYqwT9sER3T9wjBUfIeVQ3AbDkcnjBhIA171HurQ1hKs7Tc8uDMwXZYUInBsBtuJbrTZNIT1yyGOEZ23uzGdvzwI=
X-Received: by 2002:a62:cec4:: with SMTP id y187mr12206609pfg.84.1567793659699;
 Fri, 06 Sep 2019 11:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190830231527.22304-5-linux@rasmusvillemoes.dk>
 <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
 <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk> <20190905134535.GP9749@gate.crashing.org>
 <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com>
 <20190906122349.GZ9749@gate.crashing.org> <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com>
 <20190906163028.GC9749@gate.crashing.org> <20190906163918.GJ2120@tucnak>
In-Reply-To: <20190906163918.GJ2120@tucnak>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Sep 2019 11:14:08 -0700
Message-ID: <CAKwvOd=MT_=U250tR+t0jTtj7SxKJjnEZ1FmR3ir_PHjcXFLVw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 9:39 AM Jakub Jelinek <jakub@redhat.com> wrote:
>
> On Fri, Sep 06, 2019 at 11:30:28AM -0500, Segher Boessenkool wrote:
> > On Fri, Sep 06, 2019 at 05:13:54PM +0200, Miguel Ojeda wrote:
> > > On Fri, Sep 6, 2019 at 2:23 PM Segher Boessenkool
> > > <segher@kernel.crashing.org> wrote:
> > > > I can't find anything with "feature" and "macros" in the C++ standard,
> > > > it's "predefined macros" there I guess?  In C, it is also "predefined
> > > > macros" in general, and there is "conditional feature macros".
> > >
> > > They are introduced in C++20,
> >
> > (Which isn't the C++ standard yet, okay).
>
> Well, they have been required by SD-6 before being added to C++20, so we
> have tons of the predefined macros for C++ already starting with gcc 4.9 or
> so, but it is something required by the standard so we have to do that.
> Most of them depend also on compiler options, so can't be easily replaced
> with a simple __GNUC__ version check.
>
> What I'd like to add is that each predefined macro isn't without cost,
> while adding one predefined macro might not be measurable (though, for
> some predefined macros (the floating point values) it was very measurable
> and we had to resort to lazy evaluation of the macros), adding hundreds of
> predefined macros is measurable, affects the speed of empty compiler run,
> adds size of -g3 produced debug info, increases size of -E -dD output etc.
>
>         Jakub

Here's the case that I think is perfect:
https://developers.redhat.com/blog/2016/02/25/new-asm-flags-feature-for-x86-in-gcc-6/

Specifically the feature test preprocessor define __GCC_ASM_FLAG_OUTPUTS__.

See exactly how we handle it in the kernel:
- https://github.com/ClangBuiltLinux/linux/blob/0445971000375859008414f87e7c72fa0d809cf8/arch/x86/include/asm/asm.h#L112-L118
- https://github.com/ClangBuiltLinux/linux/blob/0445971000375859008414f87e7c72fa0d809cf8/arch/x86/include/asm/rmwcc.h#L14-L30

Feature detection of the feature makes it trivial to detect when the
feature is supported, rather than brittle compiler version checks.
Had it been a GCC version check, it wouldn't work for clang out of the
box when clang added support for __GCC_ASM_FLAG_OUTPUTS__.  But since
we had the helpful __GCC_ASM_FLAG_OUTPUTS__, and wisely based our use
of the feature on that preprocessor define, the code ***just worked***
for compilers that didn't support the feature ***and*** compilers when
they did support the feature ***without changing any of the source
code*** being compiled.

All I'm asking for is that when GCC adds a new GNU C extension (such
as `asm inline`), define a new preprocessor symbol (like has already
been done w/ __GCC_ASM_FLAG_OUTPUTS__), so that we don't have to use
version checking (or reimplementing autoconf) and use feature
detection instead.  This simplifies use of this feature even between
codebases supporting multiple versions of GCC.

(Also, I'm guessing the cost of another preprocessor define is near
zero compared to parsing comments for -Wimplicit-fallthrough)
-- 
Thanks,
~Nick Desaulniers
