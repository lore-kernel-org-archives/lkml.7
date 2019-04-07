Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF2DC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 02:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE7B218FE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 02:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Re1/lDx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDGCUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 22:20:43 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:45431 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfDGCUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 22:20:43 -0400
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x372KbfW028695;
        Sun, 7 Apr 2019 11:20:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x372KbfW028695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554603639;
        bh=P+WsSxKN4aU5NJqDR7kiKX6Q1Y1Wn16FzTTGu6UUoL4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Re1/lDx5Zf9zbk6J3fLeL/Eo1J+NIV20qf2EIh3kP9h7BabBMdqmd9ZNwSZwFcY6a
         sKA64PFcVZNHYl4xAty6i1ptzk8r21qkm/NY5jX2FlBIIkzV6Q8rd9/Kx094LHAPAW
         JDo0o0Sa8EFpt8OXEWeSv7Gy3FQ1VHU0uMeXpM4gBMlzMwMssRg86+7n4LNwm5d+Om
         xekpqsHNb50XJt5R6ROkfbWJte+XSiefzPxjLBhRSGvOdXKJs3p+CianHIjgxDa1vs
         LrjNOdw/672uxIfs0Jr/yEZ+U2Q4xQPvgu0MsfJITEGa0IwZHIbNNofbPO4RSpLHpL
         mdVS6uQgM/oaA==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id h71so2285205vkf.5;
        Sat, 06 Apr 2019 19:20:38 -0700 (PDT)
X-Gm-Message-State: APjAAAXIRFBiDBBnl6AW0INVJAAc1OvWZigrNoEMrTG9AtAQbnDWJ21Q
        jIHLNrsAX958vlkJt4g60dNSrUKIL2o6w3KCGLg=
X-Google-Smtp-Source: APXvYqyTF4UFvoIPVNWed/LrTcVxzcgzVJ4pyibfNJcsmsw0Ej+69Tg1uvVcny1UxMTrq63BfWrT5pw3wBO3kOzRiA8=
X-Received: by 2002:a1f:b3c6:: with SMTP id c189mr10031591vkf.33.1554603637273;
 Sat, 06 Apr 2019 19:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQw7nPwykOEV5i+yWjkxzgf1gPa5ewFhDxbbn8XXjwFUA@mail.gmail.com>
 <20190402070858.49597-1-ndesaulniers@google.com> <CAK7LNAQGUe0h2ti6_u5=y9KUrNStESdd=D=8K3NOiE08tt022w@mail.gmail.com>
 <CAGXu5jKZUP33Kz=nDPkUSj0Ksz5FOYTuuKAxv4N6xGEtFT645A@mail.gmail.com> <CAKwvOd=eBWm6B24soOGhxtCk+TCeKqwra0_b-V6kTYDSHLOg_w@mail.gmail.com>
In-Reply-To: <CAKwvOd=eBWm6B24soOGhxtCk+TCeKqwra0_b-V6kTYDSHLOg_w@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 7 Apr 2019 11:20:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS+n44wBUfSJktmXWuz1=UQkuNOq3_M4K-62+ymH_V1jw@mail.gmail.com>
Message-ID: <CAK7LNAS+n44wBUfSJktmXWuz1=UQkuNOq3_M4K-62+ymH_V1jw@mail.gmail.com>
Subject: Re: [PATCH v3] Makefile: lld: tell clang to use lld
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Lynch <nathan_lynch@mentor.com>,
        Peter Smith <peter.smith@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees, Nick,


On Sat, Apr 6, 2019 at 1:52 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Apr 5, 2019 at 9:11 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Apr 5, 2019 at 3:17 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > > I want to propose alternative solution.
> > > Please check the attached patches.
>
> ```
> My plan is to rewrite all VDSO Makefiles to use $(LD), then delete cc-ldoption.
> ```
>
> I agree with that as a possible solution as well; I think it's best to
> just invoke the linker directly rather than use the compiler as the
> driver.  Just small nits with the 2 attached patches, but I think they
> will also work for us.
>
> Looks like there's 15 call sites across 12 files, plus Documentation/
> and scripts/Kbuild.include; removing it seems feasible and I'd be
> happy to help if you'd welcome the patches?


Yeah, your help is appreciated.

I just worked on two Makefiles
because I wanted to hear opinions
before investing more efforts.


Basically, you are positive to this approach,
so let's go this way.


> Let's start with that series of changes, but I suspect we will
> ultimately need to revisit -fuse-ld=.  I was just thinking that even
> my proposed patch doesn't do anything for KBUILD_HOSTCFLAGS, for
> example.

Host tools are not so important, but I agree.

BTW, why does clang invoke bfd linker instead of
lld by default?

If we want to make llvm self-contained,
I believe clang should use ld.lld by default.




>  I worry that bfd may still be invoked by Clang at some point
> in the build.  I will try to test in an environment with no GNU
> binutils.
>
> > In the 0001 patch of arch/arm/vdso/Makefile:
> > > ...
> > > -VDSO_LDFLAGS += $(call cc-ldoption, -fuse-ld=bfd)
> > > +ldflags-y = -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
> > > +           -z max-page-size=4096 -z common-page-size=4096 \
> > > +           -nostdlib -shared \
> > > +           $(call ld-option, --hash-style=sysv) \
>
> I think the vdso's should all REQUIRE --hash-style=sysv; the kselftest
> for vdso's will fail otherwise.  I could always follow up with patches
> for that if we didn't want to conflate changes.
>
> > > +           $(call ld-option, --build-id) \
> > > +           -T
>
> Was it intentional to add -T standalone?  The man page for `ld` says
> it needs an additional filename to follow -T.

This is because I wanted to re-use cmd_ld
defined in scripts/Makefile.lib

$(real-prereqs) contains the linker scripts and objects.


>  Or rather is optional
> if a -L flag is specified?
>
> >
> > I see that "-fuse-ld=bfd" is explicitly dropped here, which could
> > reintroduce the problem fixed in d2b30cd4b722 ("ARM: 8384/1: VDSO:
> > force use of BFD linker") (and 3473f26592c1c). Does ld.gold still
> > exhibit this problem? If so, we'll need to detect gold and force bfd
> > still maybe?

I intentionally dropped -fuse-ld=bfd.

With my patch applied, users have full control
of the linker by passing LD=.

Since we cannot link vmlinux with gold,
users should definitely pass a bfd linker.



> The arm32 vdso Makefile is an oddity in this regard.  I think what
> Kees described is best.  Rather than always set the linker to bfd
> (which harms linkers like lld), detect if gold is being used and if so
> set the linker back to bfd.
>
> For arm64, lld has this issue with -n,
> https://github.com/ClangBuiltLinux/linux/issues/340, but I think we
> can fix that in a follow up patch.  Same thoughts on --hash-style and
> -T.


If we need to add something depending on
the linker type,

I do not mind doing like this.

ldflags-$(CONFIG_LD_IS_GOLD) += ...
ldflags-$(CONFIG_LD_IS_LLD)  += ...

But, it is a different issue.






--
Best Regards
Masahiro Yamada
