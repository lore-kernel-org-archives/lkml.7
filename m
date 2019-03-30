Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB22EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D73218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="szuFg3y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfC3FMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 01:12:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:60294 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfC3FMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 01:12:34 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2U5CPET016709;
        Sat, 30 Mar 2019 14:12:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2U5CPET016709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553922746;
        bh=r8dOwkRacFsMX0aiVsf+V+1Xd/JhXUjQuswL53e227Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=szuFg3y8BnJLm8VMIcsZZ7JAgGV1EDTLXl5P5OkcJUqV3IFgnXPKOzRaEAnbqv/9g
         AMoK8j8QH0VYdiXY/6WgQJrZfqTMokrWGO58h7mF9KQQOWdBizAL3pmAHa+7uTC6j6
         qzfR2iPhAQuINHxUhecuzliUjk1CX8PwUApIzh7jW2hn95y+VYf94pn3KQVhL/IYOS
         q4fHdBQxpeVjJMHPdsBzcqFXXwBCYcQ6/zTC1XQCZ/nUGszRKDgrEGjoyPR8WfnCJo
         9t2j/8R5+bvHp58aR2SR03lu9YlVVFb3tXMxb2q5fi/0bFzTCEiGP1H3PQ9pA4VZIa
         I7eE5xXBTRkMQ==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id 46so1398578uan.8;
        Fri, 29 Mar 2019 22:12:25 -0700 (PDT)
X-Gm-Message-State: APjAAAUalN8dqule5fmvlFrWEbNaMXhFABJn2PNQ+bQUgrR3R+5OALJK
        oSU/A5Nvzya+HhAWm4w8fAWfujhKFpNmAMkUjCg=
X-Google-Smtp-Source: APXvYqz7+m6nOICvWerYyHtLvsMyLPKn/kLwUsjt5tAPtc0V0EcTy4etDMKa6wRpSpjkuhy/A+A+3zDl3s9yO3BTNdA=
X-Received: by 2002:ab0:7008:: with SMTP id k8mr30972360ual.40.1553922744674;
 Fri, 29 Mar 2019 22:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <1553580672-29551-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553580672-29551-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 30 Mar 2019 14:11:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNARrTy7sFfO7FF=Sadrz7FygRMcfe9oG7bKbWni1PfszRg@mail.gmail.com>
Message-ID: <CAK7LNARrTy7sFfO7FF=Sadrz7FygRMcfe9oG7bKbWni1PfszRg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: move RETPOLINE flags below config-targets
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 3:11 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> When you run a "make *config" target, the retpoline compiler flags
> are evaluated for nothing because the code is located above the
> 'ifeq ($(config-targets),1)'.
>
> Move it a bit below to avoid unneeded computation in the Kconfig stage.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>
>  Makefile | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1b361bd..66a8e04 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -519,15 +519,6 @@ KBUILD_AFLAGS      += $(CLANG_FLAGS)
>  export CLANG_FLAGS
>  endif
>
> -RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> -RETPOLINE_VDSO_CFLAGS_GCC := -mindirect-branch=thunk-inline -mindirect-branch-register
> -RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
> -RETPOLINE_VDSO_CFLAGS_CLANG := -mretpoline
> -RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
> -RETPOLINE_VDSO_CFLAGS := $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_VDSO_CFLAGS_CLANG)))
> -export RETPOLINE_CFLAGS
> -export RETPOLINE_VDSO_CFLAGS
> -
>  # The expansion should be delayed until arch/$(SRCARCH)/Makefile is included.
>  # Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
>  # CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
> @@ -624,6 +615,15 @@ ifdef CONFIG_FUNCTION_TRACER
>    CC_FLAGS_FTRACE := -pg
>  endif
>
> +RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> +RETPOLINE_VDSO_CFLAGS_GCC := -mindirect-branch=thunk-inline -mindirect-branch-register
> +RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
> +RETPOLINE_VDSO_CFLAGS_CLANG := -mretpoline
> +RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
> +RETPOLINE_VDSO_CFLAGS := $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_VDSO_CFLAGS_CLANG)))
> +export RETPOLINE_CFLAGS
> +export RETPOLINE_VDSO_CFLAGS
> +
>  # The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
>  # values of the respective KBUILD_* variables
>  ARCH_CPPFLAGS :=
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
