Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1DFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EAE20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7VVgHvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDJWUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:20:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40083 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDJWUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:20:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so2240801plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9AQM9Er5xIu0dK7JBT6Ay6B+U4MsPIr+qvFzik28d0=;
        b=o7VVgHvZlzx3LhZneghQwUlAr86T5syvkidjdozrG8mIhw1d6H0IBWsXmnxBmsDiaq
         hn+0ftVUFmac2e+cDp2p2ySvZcZVMDtPq1JMckFQ17UiVg7i1aY4XkbcuWSAF6mxK0q9
         9NSHSx9gWSQPTN8CQ0sCJ6vVmhwY6yP0EgdbqqF+NyH2WGdn/DdB4J0CctA7tVjSIRh7
         fIgLq7nQn3M17rvS4rqehsHlpxAhSUX6INEPxt/fOgSf5VG86z6ISrRwfDsc/9OX5868
         xzo6kQERUie/X3A3yxVSdxooK0IvqjgN7Et5ZbD+3tYdmKuowiYWWOGWkrll2Z9yg/8B
         eekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9AQM9Er5xIu0dK7JBT6Ay6B+U4MsPIr+qvFzik28d0=;
        b=KvC1eRGREtsBINloBVEx568gpD+bE8NhDffR3Sbm2rqG6W7l8pLFyWOvc+D5s0Vma3
         qW/kiTsE6D2W5gCCDhkGEvhnmIWkKPKB24+/E5EFgZqiM9nYWI+c1BFhDkWthU/truEO
         K2wxdYIVNUajsiFR6w1Gh9trZeYbWXPun8bVrwmK4W47dQqxgjU8Jb8TK0eyqhNMh3BZ
         qD6cSzAN7838CFUYh71Rt9uuTXyeq7PyTJYYtb3NuidbscNpLy8bg5ebAmiM3eFXn0nc
         yyV/lejCx9T0epU/5Pl7tObOPXfUqeJyly8fiX7YrFNl59Mleyd5ve6edmam92bT/aSc
         IS7Q==
X-Gm-Message-State: APjAAAX0yuMEKwPtuFlk2PiEi20wXRDh1bgQgjpJLTxfn5BaP8wAmFjB
        96iQE4NdHGaAcWrRutVVpM42PPG4Py9uM0y3CZNC0Q==
X-Google-Smtp-Source: APXvYqx92h4EUAn4ErLiC/ikSuis6k2GMyfUVONLnH8PeBcgCbmTD3KqAi5CghuiEuqhM4GimtniMnxUmNnT7iInjN0=
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr46827317plb.24.1554934820450;
 Wed, 10 Apr 2019 15:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190410201300.3528984-1-arnd@arndb.de>
In-Reply-To: <20190410201300.3528984-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Apr 2019 15:20:09 -0700
Message-ID: <CAKwvOdnZjj_FRQkAqmmmMcG=s+TGFXqQS5-ZhT2E9fcGu-nm8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] s390: only build for new CPUs with clang
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 1:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> llvm does does not understand -march=z9-109 and older target

Please file bugs for these in LLVM's issue tracker.  It might be
possible to enable these additional architecture variants if they're
similar to existing ones and simply unrecognized.  IIRC, we had this
issue with armv7 variants.

> specifiers, so disable the respective Kconfig settings and
> the logic to make the boot code work on old systems when
> building with clang.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/Kconfig       | 6 ++++++
>  arch/s390/boot/Makefile | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 8cd860cba4d1..1a2eec61196d 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -240,6 +240,7 @@ choice
>
>  config MARCH_Z900
>         bool "IBM zSeries model z800 and z900"
> +       depends on !CC_IS_CLANG
>         select HAVE_MARCH_Z900_FEATURES
>         help
>           Select this to enable optimizations for model z800/z900 (2064 and
> @@ -248,6 +249,7 @@ config MARCH_Z900
>
>  config MARCH_Z990
>         bool "IBM zSeries model z890 and z990"
> +       depends on !CC_IS_CLANG
>         select HAVE_MARCH_Z990_FEATURES
>         help
>           Select this to enable optimizations for model z890/z990 (2084 and
> @@ -256,6 +258,7 @@ config MARCH_Z990
>
>  config MARCH_Z9_109
>         bool "IBM System z9"
> +       depends on !CC_IS_CLANG
>         select HAVE_MARCH_Z9_109_FEATURES
>         help
>           Select this to enable optimizations for IBM System z9 (2094 and
> @@ -347,12 +350,15 @@ config TUNE_DEFAULT
>
>  config TUNE_Z900
>         bool "IBM zSeries model z800 and z900"
> +       depends on !CC_IS_CLANG
>
>  config TUNE_Z990
>         bool "IBM zSeries model z890 and z990"
> +       depends on !CC_IS_CLANG
>
>  config TUNE_Z9_109
>         bool "IBM System z9"
> +       depends on !CC_IS_CLANG
>
>  config TUNE_Z10
>         bool "IBM System z10"
> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> index c844eaf24ed7..953a74d04990 100644
> --- a/arch/s390/boot/Makefile
> +++ b/arch/s390/boot/Makefile
> @@ -11,6 +11,7 @@ KASAN_SANITIZE := n
>  KBUILD_AFLAGS := $(KBUILD_AFLAGS_DECOMPRESSOR)
>  KBUILD_CFLAGS := $(KBUILD_CFLAGS_DECOMPRESSOR)
>
> +ifndef CONFIG_CC_IS_CLANG
>  #
>  # Use -march=z900 for als.c to be able to print an error
>  # message if the kernel is started on a machine which is too old
> @@ -25,6 +26,7 @@ CFLAGS_als.o                  += -march=z900
>  CFLAGS_REMOVE_sclp_early_core.o        += $(CC_FLAGS_MARCH)
>  CFLAGS_sclp_early_core.o       += -march=z900
>  endif
> +endif
>
>  CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
>
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
