Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A00AC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD496208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpi+7QDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfEJRyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:54:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46146 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfEJRyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:54:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so3592729pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1itVqm/8wQC9SNWjeDa4dzSfWDqGRFaqod6eNBqWDE=;
        b=vpi+7QDuHFbrhBBUyCBfSRPp4e/b18thnFfQ8bcFdB7+QYft6hvk/wzwmMbGMpNFAu
         GodCgjxLULgCoExsd5PcNVG2XmpdO7y7RawmiDS2wwQLIyHAdVMvyLNvAEsl7rmZrne0
         An8KJ8pFXq6AL9lBK2f996oSXS6Xtq0n7sBdak8TFvfS1fnLLeEopXok2YbfF+F3qbPF
         i0HfP7omSqy2J2dzOFYpktJe1eppSYU4mLHoVldyHBicYpGZWAtaAWCK9NgM6Syc4BiA
         PPCgbPV+ewXX4uCbfDhmIml5lZk8dQO4djXjpd/cHh0McCqcAU4Jy0PtE+qAa+IUybZJ
         VMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1itVqm/8wQC9SNWjeDa4dzSfWDqGRFaqod6eNBqWDE=;
        b=MinhzwbNbXHHU/TH4tp6iS6hirSjACVjiOFg8f/uGaBN415kzPJzpRrW/Vr4zpSBLi
         LVQMx4qyM6N/xCfMdUoaKB1uo1KNjRR203ERICrmZg669pVaf1SdwwV4c2U6TnZkNKXg
         hUtzwes9NHta5tygVoGO/4a73p945d1BGBK2LbF/WzABIxXp9mqV3sWJIMd3OIAd1lNj
         cU6Qa4HF0q7vgJhK06n/HBHII/PFObsQj21dqOClamXYs/lyfr1ykyAw3cfTLZKlwUJh
         23dL7Xr9FjWo3X1/G2r5wAMe5MuoOVbowjRl+YFelGFmHRVn+iYoLLUThZPLA3sNiBK3
         CBGA==
X-Gm-Message-State: APjAAAV+IPI1lIbRRmV64ITWP96pfeeexBuxSiQU2/uTtsYfKBo2PNT4
        KLvAasojoW53Jucm9R4YBlf+ts3h5q3rfWGUPV2UPrdB
X-Google-Smtp-Source: APXvYqzP8m3pUBu8UMfj1TGUem0MHgkYl98JB8CBT7FbIBwDvJmFqEL/4/iSOqEP7vpWgLOmbZ7LAxZ9mHAlN3Sy0r4=
X-Received: by 2002:aa7:8096:: with SMTP id v22mr16300080pff.94.1557510862969;
 Fri, 10 May 2019 10:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <1557497409-18037-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1557497409-18037-1-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 May 2019 10:54:11 -0700
Message-ID: <CAKwvOdmaBopTduxoicj204pkr=+Xbapcqx2JMctNxd0MeHonog@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add all Clang-specific flags unconditionally
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 7:10 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> We do not support old Clang versions. Upgrade your clang version
> if any of these flags is unsupported.
>
> Let's add all flags within ifdef CONFIG_CC_IS_CLANG unconditionally.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Ack

> ---
>
> Changes in v2:
>   - Rebase on top of Nathan's patch
>      https://patchwork.kernel.org/patch/10937055/
>
>  Makefile                   | 10 +++++-----
>  scripts/Makefile.extrawarn | 12 ++++++------
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 914a3ad..1152fc4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -731,15 +731,15 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
>  KBUILD_CFLAGS += $(stackp-flags-y)
>
>  ifdef CONFIG_CC_IS_CLANG
> -KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
> -KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
> -KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> +KBUILD_CPPFLAGS += -Qunused-arguments
> +KBUILD_CFLAGS += -Wno-format-invalid-specifier
> +KBUILD_CFLAGS += -Wno-gnu
>  # Quiet clang warning: comparison of unsigned expression < 0 is always false
> -KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
> +KBUILD_CFLAGS += -Wno-tautological-compare
>  # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
>  # source of a reference will be _MergedGlobals and not on of the whitelisted names.
>  # See modpost pattern 2
> -KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
> +KBUILD_CFLAGS += -mno-global-merge
>  else
>
>  # These warnings generated too much noise in a regular build.
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 768306a..523c4ca 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -66,11 +66,11 @@ KBUILD_CFLAGS += $(warning)
>  else
>
>  ifdef CONFIG_CC_IS_CLANG
> -KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
> -KBUILD_CFLAGS += $(call cc-disable-warning, format)
> -KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
> -KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
> -KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
> +KBUILD_CFLAGS += -Wno-initializer-overrides
> +KBUILD_CFLAGS += -Wno-unused-value
> +KBUILD_CFLAGS += -Wno-format
> +KBUILD_CFLAGS += -Wno-sign-compare
> +KBUILD_CFLAGS += -Wno-format-zero-length
> +KBUILD_CFLAGS += -Wno-uninitialized
>  endif
>  endif
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
