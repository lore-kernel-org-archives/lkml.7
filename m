Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633E3C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C49F2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J40k/k39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDLR3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:29:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35834 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfDLR3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:29:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so5529906pgf.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 10:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjZ4YMyKo+QbZAjVtELKpRi6NtVs0gJzGRZ9miVsfu8=;
        b=J40k/k39s8tcNfMXc+f52TAYVBDF3zM1alSY7PFnlZELIYSpAVvVsaWIho/LoTm4Mm
         dTw/f5/5pou8BOIqwwqtzyJC9r4i7Y39r/4saZrVdf/H70HHOeJPizo3ta0fQktyLAbo
         cnwIg2LNqHLrPAzTfzjJf4oskeg5Ob1sjuC4e1FSDsuSKOs57g0k6vWliI2TlNrDWGLs
         Haoaakd+rxydz0B+PS4k5NDUUSdRgW/IeP6mG/jP+FcREim7BSi6fCa8Vh7Qe4ULU1SG
         EzNPLI7cbkBKwgWYOiXR/KxnE2usBWQ7delOJAt1VYrSvLsOZYveWcE3tlVRT0Z/ZnDc
         AO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjZ4YMyKo+QbZAjVtELKpRi6NtVs0gJzGRZ9miVsfu8=;
        b=lmDVACwXEYH3IY8YSj+lhNNRUXUN3C7mzXFnMeM6Bg10uboBGacKSrIUdAknGlSTUj
         XAvnWKFskkNBJ9P0+dH63HK5wqt8XDrmAzxE7sPnel9fmWjHIORwYMg0gHwYwJ4ciLrA
         s0eHOIfpPr4HmCwZF1onLREN0DjP5GesAbSwNeKuVR3HdTxPRWrWIdlwX8OnXDP4mHBr
         ucahCwWBq87HteUanInzoHcSTlQGLPeL/WDhTTuD+Vfl1iW70sZAWUoXavN2fB6jVE6I
         HJUlNRX3Z4bF8QOx/IjAO5TM3sFj4oF7tykCrH8whijW4MCaaDC/czBlVS+WMPifRZCT
         PXmQ==
X-Gm-Message-State: APjAAAVI/nJY+JVZHGDARw2M/S/gpjd238v1mXtxmzLnja3wk5OmvSAh
        71Ttw/Oxt6VMmaQYqcoiu59iSeEsu/7FFDcIa4QwSA==
X-Google-Smtp-Source: APXvYqy5jxEfB76p9f+NH5/SAAqUtuQhzZpE8dqX1U54P0+GkAMjQuC7KpGW4z4Ny05H0jpBJE/Nhwu8fQStcW6lDlY=
X-Received: by 2002:a63:d256:: with SMTP id t22mr51807898pgi.80.1555090153616;
 Fri, 12 Apr 2019 10:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190411092933.6413-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190411092933.6413-1-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Apr 2019 10:29:02 -0700
Message-ID: <CAKwvOdmyyOnfmy4Y-Yuhj2OnpdSmZ07N2LuDiEnefa9Xf4F7LQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: vdso: use $(LD) instead of $(CC) to link VDSO
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 2:30 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> My plan is to rewrite all VDSO Makefiles to use $(LD), then delete
> cc-ldoption.

I too look forward to the removal of cc-ldoption. Thanks for the
patch.  Based on some of the discussion in a similar patch for
aarch64: https://lkml.org/lkml/2019/4/12/760:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/vdso/Makefile | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index f4efff9d3afb..fadf554d9391 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -10,12 +10,12 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>  ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
>  ccflags-y += -DDISABLE_BRANCH_PROFILING
>
> -VDSO_LDFLAGS := -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
> -VDSO_LDFLAGS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
> -VDSO_LDFLAGS += -nostdlib -shared
> -VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> -VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--build-id)
> -VDSO_LDFLAGS += $(call cc-ldoption, -fuse-ld=bfd)
> +ldflags-y = -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
> +           -z max-page-size=4096 -z common-page-size=4096 \

This reminds me that I should resend:
https://lore.kernel.org/patchwork/patch/1023578/

-- 
Thanks,
~Nick Desaulniers
