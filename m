Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB88FC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A603E20989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QNxhNwD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbfDEQwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:52:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42329 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbfDEQwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:52:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id w25so2133056pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZRju1TCf3hjgA6aEvD9E53a1gVrkZjm46k2uJ+NEZA=;
        b=QNxhNwD685MblYo7ih+AlHchFXY1TZs4XAbxvDkgxiybSrmlZ2F9KDbvOoV6sNjPss
         ev1gbLz/WwNhwQEsrp1BCCbrdMM6AT561TFca3Yv4myOR9zEY5oDnB9wh7rjMVxwsEKh
         pPVXtOp9iT5nB8FhAOFLu438c15s6TpMiN4mDaWF7w8cBWsiaxg4ydR9g3ysENxpyg16
         4A/ATUOklCsfaFNr3aIuP48tOMGORJ47yCE63ztcdY3xAElijD1i81lFe+ClHqTJXhaD
         emxMPJR35cxDnEKJ6XDE0wC40/CsTyrEm0HNWSwkB1/J4tCmKPcZcLvgY/AlxWMPm0s0
         28xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZRju1TCf3hjgA6aEvD9E53a1gVrkZjm46k2uJ+NEZA=;
        b=XFLf6QKfAWEMH/8b7M99ICFTOK36l+5yxy04Sww5ZbGdI1CVYx11PNgn21I+XRQ9C1
         OrZyef5oFoBbs3lpb8SnVouUnomyUNeLwNNuXd4ejZdZRd9OAzUgNOhPoLdWvEzrNpfx
         OpI2lFGWMfD6xT1Ihdutc8NWpb3+U3Nth17WqCBHeeY7WPgYcgpvNuCLfjVMkb9iFTQ/
         xv95T2NaJshvfQ5Y9vPAfG2Dh92BvLTQyzkJ7dkVeS43ENUCrJDDeh28VjeDjuFz1szT
         Ve+3dOdrY7pdidXYzHVnv33C8k0HuY2l68mRSu/GU6f+2oAQN+6MZbZ/p/GtU2lTE3nY
         Do2A==
X-Gm-Message-State: APjAAAUbSUY5qAQzAxEQfZJoG1h3OmFFmRSsTS/Db0F9LFoQMUff+nY7
        WU9PIUvmN9dDSyE1wj2V2mjLKX0b70cxnwkYVDFcmg==
X-Google-Smtp-Source: APXvYqwXH0nRO0oBbrJMilA/Yu0zbad0L4gz0mN/f4QwxwuHCt4VRhs5VCO/adgKhuhAFM+b9UyFueZlbXsknkt+ODU=
X-Received: by 2002:a65:5304:: with SMTP id m4mr12947739pgq.281.1554483141544;
 Fri, 05 Apr 2019 09:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQw7nPwykOEV5i+yWjkxzgf1gPa5ewFhDxbbn8XXjwFUA@mail.gmail.com>
 <20190402070858.49597-1-ndesaulniers@google.com> <CAK7LNAQGUe0h2ti6_u5=y9KUrNStESdd=D=8K3NOiE08tt022w@mail.gmail.com>
 <CAGXu5jKZUP33Kz=nDPkUSj0Ksz5FOYTuuKAxv4N6xGEtFT645A@mail.gmail.com>
In-Reply-To: <CAGXu5jKZUP33Kz=nDPkUSj0Ksz5FOYTuuKAxv4N6xGEtFT645A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Apr 2019 09:52:10 -0700
Message-ID: <CAKwvOd=eBWm6B24soOGhxtCk+TCeKqwra0_b-V6kTYDSHLOg_w@mail.gmail.com>
Subject: Re: [PATCH v3] Makefile: lld: tell clang to use lld
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
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

On Fri, Apr 5, 2019 at 9:11 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Apr 5, 2019 at 3:17 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > I want to propose alternative solution.
> > Please check the attached patches.

```
My plan is to rewrite all VDSO Makefiles to use $(LD), then delete cc-ldoption.
```

I agree with that as a possible solution as well; I think it's best to
just invoke the linker directly rather than use the compiler as the
driver.  Just small nits with the 2 attached patches, but I think they
will also work for us.

Looks like there's 15 call sites across 12 files, plus Documentation/
and scripts/Kbuild.include; removing it seems feasible and I'd be
happy to help if you'd welcome the patches?

Let's start with that series of changes, but I suspect we will
ultimately need to revisit -fuse-ld=.  I was just thinking that even
my proposed patch doesn't do anything for KBUILD_HOSTCFLAGS, for
example.  I worry that bfd may still be invoked by Clang at some point
in the build.  I will try to test in an environment with no GNU
binutils.

> In the 0001 patch of arch/arm/vdso/Makefile:
> > ...
> > -VDSO_LDFLAGS += $(call cc-ldoption, -fuse-ld=bfd)
> > +ldflags-y = -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
> > +           -z max-page-size=4096 -z common-page-size=4096 \
> > +           -nostdlib -shared \
> > +           $(call ld-option, --hash-style=sysv) \

I think the vdso's should all REQUIRE --hash-style=sysv; the kselftest
for vdso's will fail otherwise.  I could always follow up with patches
for that if we didn't want to conflate changes.

> > +           $(call ld-option, --build-id) \
> > +           -T

Was it intentional to add -T standalone?  The man page for `ld` says
it needs an additional filename to follow -T.  Or rather is optional
if a -L flag is specified?

>
> I see that "-fuse-ld=bfd" is explicitly dropped here, which could
> reintroduce the problem fixed in d2b30cd4b722 ("ARM: 8384/1: VDSO:
> force use of BFD linker") (and 3473f26592c1c). Does ld.gold still
> exhibit this problem? If so, we'll need to detect gold and force bfd
> still maybe?

The arm32 vdso Makefile is an oddity in this regard.  I think what
Kees described is best.  Rather than always set the linker to bfd
(which harms linkers like lld), detect if gold is being used and if so
set the linker back to bfd.

For arm64, lld has this issue with -n,
https://github.com/ClangBuiltLinux/linux/issues/340, but I think we
can fix that in a follow up patch.  Same thoughts on --hash-style and
-T.

-- 
Thanks,
~Nick Desaulniers
