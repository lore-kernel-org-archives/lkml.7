Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072FDC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5352217D8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3aJduX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfEIRRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:17:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33357 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEIRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:17:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id y3so1466335plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwCs3q6jbD83yfOwCi9FGEbxwcLuNFM2qszk0t25lO0=;
        b=j3aJduX0Ix4TebkyyPV3qCbhz379c+5CY5UYNFnybdIxXefzYU0NIFxb8gTh8ZhNTi
         DZmQ+fZwBQONntrPlfJg/ubxah2qR7K4uIQFQ0X4aBqEogQjSUd4IhOc0dCNH1gU5ksw
         rGyATepTqf+k0Bbr6fAclgERf/XvJhT4R+mpyDQLGLbClLvmMwkZKpIj+QjhjaIPzXGi
         XSz3J7nfc5V4TJbQntJpjdaeivTnURLemo7NC2CFVcZZw+miD86iwasFwmxvQBiFUwUl
         jpAvKpoOBjhBGzrTjG8FvIt82y0FWb+lj5G7lSC93RiHJplmSU32zs5bYsfmuQLKo4kY
         Xchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwCs3q6jbD83yfOwCi9FGEbxwcLuNFM2qszk0t25lO0=;
        b=YEKQA1SvHwPdN8jeLzqASWC8rzTCo1CmWtUSC71DY9XDx9mg6CB1PNfBm26Es0rZKg
         BjSL4DyuW6L5KH+dhRRNIsrlP+HfCnqUXQIK62K5LnqVPMu5OPpWnQWPsHLeW5yZyVGP
         RInks/pfN9YiWxV9z7xnmKIXuupaLCaiT95KoA99LSW5GvlqdHnuJslWR/nMcTybuXq/
         tvLjvP3PYMM4FAymV0/UjfRvkFtDVnNmRxipTxwWJ1LmlRM2wJ1CLOI/8vVKT7L5kb3w
         bKNMVAWY+P3+DvPoMmML2gwPvvIRcN+V0KdfeZMglQgBWPND3Lt5U5ARkLmNCZJZh63Y
         yl2Q==
X-Gm-Message-State: APjAAAVoBiXa6Y6y5t6QUNAbN9fB1E1ZFL6175gBZ38ceQZpI+sViuUE
        w5kNKkUzjcSLv9YtOKbcdgJgJCpfyVvd0fKqfEXxWg==
X-Google-Smtp-Source: APXvYqx2aTaiRZ3xsV976GrnpDFl/zXtdv+wVuwvLB2fmHDuFumVjwczU/rfW94kTNvOnKnYSv+40CyQvS2Xp3D3dwY=
X-Received: by 2002:a17:902:2a26:: with SMTP id i35mr6888461plb.229.1557422254907;
 Thu, 09 May 2019 10:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190509064455.1173-1-yamada.masahiro@socionext.com> <20190509111534.GA32696@archlinux-i9>
In-Reply-To: <20190509111534.GA32696@archlinux-i9>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 9 May 2019 10:17:23 -0700
Message-ID: <CAKwvOd=3UqmwDpKyUGj6gH_TwWc=JeEKdwAi=-AhFvRBGc1ncg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add most of Clang-specific flags unconditionally
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 09, 2019 at 03:44:55PM +0900, Masahiro Yamada wrote:
> > We do not support old Clang versions. Upgrade your clang version
> > if any of these flags is unsupported.
> >
> > Let's add flags within ifdef CONFIG_CC_IS_CLANG unconditionally,
> > except -fcatch-undefined-behavior.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  Makefile                   | 10 +++++-----
> >  scripts/Makefile.extrawarn | 12 ++++++------
> >  2 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index bd7ae11947cb..c71ffb6f55b5 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -731,15 +731,15 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
> >  KBUILD_CFLAGS += $(stackp-flags-y)
> >
> >  ifdef CONFIG_CC_IS_CLANG
> > -KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
> > -KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
> > -KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> > +KBUILD_CPPFLAGS += -Qunused-arguments
> > +KBUILD_CFLAGS += -Wno-format-invalid-specifier
> > +KBUILD_CFLAGS += -Wno-gnu
> >  # Quiet clang warning: comparison of unsigned expression < 0 is always false
> > -KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
> > +KBUILD_CFLAGS += -Wno-tautological-compare
> >  # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
> >  # source of a reference will be _MergedGlobals and not on of the whitelisted names.
> >  # See modpost pattern 2
> > -KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
> > +KBUILD_CFLAGS += -mno-global-merge
> >  KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
>
> I think we should just remove this, I'm fairly confident the kernel
> can't be reliably compiled with anything earlier than Clang 4 (Pixel 2
> was shipped with it but had some hacks, this commit is from Clang 3.5):

Yeah, clang-4 is usually what I test these with, as that's the
earliest known version of Clang that I ever had success with.
Hopefully a lot of things will stabilize for the clang-9 release.

Anyways, I checked these all w/ godbolt w/ clang-4.
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>
> https://github.com/llvm/llvm-project/commit/cb3f812b6b9fab8f3b41414f24e90222170417b4
>
> Otherwise:
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>
> >  else
> >
> > diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> > index 768306add591..523c4cafe2dc 100644
> > --- a/scripts/Makefile.extrawarn
> > +++ b/scripts/Makefile.extrawarn
> > @@ -66,11 +66,11 @@ KBUILD_CFLAGS += $(warning)
> >  else
> >
> >  ifdef CONFIG_CC_IS_CLANG
> > -KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
> > -KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
> > -KBUILD_CFLAGS += $(call cc-disable-warning, format)
> > -KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
> > -KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
> > -KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
> > +KBUILD_CFLAGS += -Wno-initializer-overrides
> > +KBUILD_CFLAGS += -Wno-unused-value
> > +KBUILD_CFLAGS += -Wno-format
> > +KBUILD_CFLAGS += -Wno-sign-compare
> > +KBUILD_CFLAGS += -Wno-format-zero-length
> > +KBUILD_CFLAGS += -Wno-uninitialized
> >  endif
> >  endif
> > --
> > 2.17.1
> >



-- 
Thanks,
~Nick Desaulniers
