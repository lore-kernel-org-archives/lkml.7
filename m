Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E64C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90C6214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8UZouch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfLKN7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:59:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34541 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbfLKN7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:59:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so24173867wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 05:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=STaNEtWndnwuAqqhmXVnDhNs+/7QG3rCPR52EQWWaas=;
        b=H8UZouchmiK0Y13YNR0SwBb+PKetsAbTms3YnTspLwes/xLjaIGRijl06ZP9T/cWhL
         eL0jssfAK++uUWsJ+aOMGrdnzq5QH1jQtnzTzB7dj1tfmDziq8+BoZkfyIlaxdyE9CCM
         GhWR+kt0PNgI+E5NjbSENGvL/yWvUasNFalqQGuFTAFdKkC7vMpxIs0RUu9RsRN0lvuu
         uH8cbM+Pt3j+q9QsbwWwSwa/iQB592ABHABHAEDd1WH8FCeLFHyQOdCaCqYOEyAhFTlU
         P/ODSOaB2X7AKgLJo11KL20XSy761EVB73m9jR6fgcPYgmX0mTlkwrTkUagSHh22wNFG
         qEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=STaNEtWndnwuAqqhmXVnDhNs+/7QG3rCPR52EQWWaas=;
        b=C1N4v/fz2eCmDlFHwmgpNneY1V41SRxtf01C3czB9mUuTeMdpgr7OgL4aVWSzvMx7A
         KGhJOxiSo7DLPb5qaBzFLTy3F/RcPaPnd9EV2fnUCXH2wXMjeoX+V0pHyNCXszXRuQTE
         sSkFR7TDTid59bNXDFszdDlUhZjOsV16jCmYSgYHKQwUMU1RnPOkxIe1h82XMe4PeD/T
         kRFkssd3qr1iPjKkNJCAQ+PDm9fEecE0WCQQxKsp0fi+PGgrhZeVUiRzhHOe1X/puWt5
         IWMCytDaJyNHTRLiggQ/EZJ10PoTr0MxlMGDXWKIQxafQzwTdO+ebVTez/S3eByfKah3
         hNRQ==
X-Gm-Message-State: APjAAAWjaYbdfFW05AuLyBru3L2ya0xsw2Etuub7ZzZxZOJTDSusnlyx
        +06Nr6XCAPRhc6huV5BYIoWYtLVVqKvHBDZJukFlWg==
X-Google-Smtp-Source: APXvYqxrnY22qG46E2qM1V+u18BpTO3sW9wSH/3ZXlho4UR4T0gYJ7K7pbXJtIkZxgRF9nLpKcVXc1X1jYSASiOVKoA=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr3933196wrs.200.1576072774421;
 Wed, 11 Dec 2019 05:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20191211133951.401933-1-arnd@arndb.de>
In-Reply-To: <20191211133951.401933-1-arnd@arndb.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 11 Dec 2019 14:59:23 +0100
Message-ID: <CAKv+Gu8yaz8uekq3taUaxWOs95yVB_tRaoKM0N2EBKSzWOhExw@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: make it possible to disable
 CONFIG_GCC_PLUGINS again
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Emese Revfy <re.emese@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 at 14:40, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I noticed that randconfig builds with gcc no longer produce a lot of
> ccache hits, unlike with clang, and traced this back to plugins
> now being enabled unconditionally if they are supported.
>
> I am now working around this by adding
>
>    export CCACHE_COMPILERCHECK=/usr/bin/size -A %compiler%
>
> to my top-level Makefile. This changes the heuristic that ccache uses
> to determine whether the plugins are the same after a 'make clean'.
>
> However, it also seems that being able to just turn off the plugins is
> generally useful, at least for build testing it adds noticeable overhead
> but does not find a lot of bugs additional bugs, and may be easier for
> ccache users than my workaround.
>
> Fixes: 9f671e58159a ("security: Create "kernel hardening" config area")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  scripts/gcc-plugins/Kconfig | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index d33de0b9f4f5..e3569543bdac 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -14,8 +14,8 @@ config HAVE_GCC_PLUGINS
>           An arch should select this symbol if it supports building with
>           GCC plugins.
>
> -config GCC_PLUGINS
> -       bool
> +menuconfig GCC_PLUGINS
> +       bool "GCC plugins"
>         depends on HAVE_GCC_PLUGINS
>         depends on PLUGIN_HOSTCC != ""
>         default y
> @@ -25,8 +25,7 @@ config GCC_PLUGINS
>
>           See Documentation/core-api/gcc-plugins.rst for details.
>
> -menu "GCC plugins"
> -       depends on GCC_PLUGINS
> +if GCC_PLUGINS
>
>  config GCC_PLUGIN_CYC_COMPLEXITY
>         bool "Compute the cyclomatic complexity of a function" if EXPERT
> @@ -113,4 +112,4 @@ config GCC_PLUGIN_ARM_SSP_PER_TASK
>         bool
>         depends on GCC_PLUGINS && ARM
>
> -endmenu
> +endif
> --
> 2.20.0
>
