Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A900C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DC021849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTxXBCRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfGSU4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 16:56:39 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:40986 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbfGSU4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 16:56:39 -0400
Received: by mail-pg1-f171.google.com with SMTP id x15so4620811pgg.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3NYv6TCWtb7tkR1P/MbWMgyIgT3S1PINtDcy9WMCXyk=;
        b=wTxXBCRSeppmWSR7yZ/z0fatUN5RT4CIrq5NGo/JoipBYdHByrus46FERdKzLm/Say
         sZq1nShQJtykJcyndXzxDXtIVSfFG2V5dvtIQ+wVGU0azw/IoP8kc6e11c1Ub8Wp5SO0
         BVKoDVWLmTdXKj6ArxpIpfDs+c0NcAdOo3fyjCOp3z0e0CyCPa1HsqK6jBsfD04xjvyO
         D2JcnFOYZ+Mj3O1c133nZecyNSNGuMldvj0xUo5IA0m7qyELJYsdwzeX5ZYk8UKrYXiS
         fBUWIjysf/rtZRZAQ/vIPkmssohq9s2WEJAYUpa61wxBqSZzRQp7GZ1lAKEm3xNHDLxt
         sd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3NYv6TCWtb7tkR1P/MbWMgyIgT3S1PINtDcy9WMCXyk=;
        b=Lb7bVcJidwEDkNwDqgQ3FNw6PzIyczW8uTtxwasohwvQpsH6SU09rFXtQ8cu7r2pfh
         aXtfPpMZGneOVJN0frtKLLQhxp1FELzqPL1B3Je2e2+x6n0OAQdiJvEQpMPQoWTA1qpo
         SDr0bd5vh/UeX1ufofIPa0pUle3flASsf1EF7RuNu792zq0fa+nIBSI+bK4NQOzsgZft
         n2KwzMPl9FzE68+/Vx/kk3MdvsRYwjdNA+nWMR7Xfqdd5H9BhnawmAPkM6qqSjYxE/dk
         TsurBsHCmKZ2E+TQC7cwZDSb6UtxQm2sRni7nLIL0gk1B+6lvGCeWPnncEAFd2X0hYhc
         3Tlg==
X-Gm-Message-State: APjAAAVSeaknnwGrTD+ZKVa6SEXuhpmDydGoB2ld/hb7Xv04Q/Lxvfug
        vYh7o3l760ThnDBdntMJ41tl18pzzZns/eTVFmWdmA==
X-Google-Smtp-Source: APXvYqyMOIrfjIgnGwgMocYcJ0JN38hJDAsNgaSllqcJ5GyMRnAOgoT2e/hbgQDpittbt0zFbvtqobrf5jz1JuEtHFw=
X-Received: by 2002:a63:60a:: with SMTP id 10mr25172182pgg.381.1563569798307;
 Fri, 19 Jul 2019 13:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190719200347.2596375-1-arnd@arndb.de>
In-Reply-To: <20190719200347.2596375-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Jul 2019 13:56:27 -0700
Message-ID: <CAKwvOdkv9DebPrB1BLriY+SY5a8EX5VsDVLRS-2-cbORMdTcTQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] kasan: remove clang version check for KASAN_STACK
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>,
        Mark Brown <broonie@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 1:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> asan-stack mode still uses dangerously large kernel stacks of
> tens of kilobytes in some drivers, and it does not seem that anyone
> is working on the clang bug.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Turn it off for all clang versions to prevent users from
> accidentally enabling it once they update to clang-9, and
> to help automated build testing with clang-9.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=38809
> Fixes: 6baec880d7a5 ("kasan: turn off asan-stack for clang-8 and earlier")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: disable the feature for all clang versions, not just 9 and below.
> ---
>  lib/Kconfig.kasan | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 4fafba1a923b..7fa97a8b5717 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -106,7 +106,6 @@ endchoice
>
>  config KASAN_STACK_ENABLE
>         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
> -       default !(CLANG_VERSION < 90000)
>         depends on KASAN
>         help
>           The LLVM stack address sanitizer has a know problem that
> @@ -115,11 +114,11 @@ config KASAN_STACK_ENABLE
>           Disabling asan-stack makes it safe to run kernels build
>           with clang-8 with KASAN enabled, though it loses some of
>           the functionality.
> -         This feature is always disabled when compile-testing with clang-8
> -         or earlier to avoid cluttering the output in stack overflow
> -         warnings, but clang-8 users can still enable it for builds without
> -         CONFIG_COMPILE_TEST.  On gcc and later clang versions it is
> -         assumed to always be safe to use and enabled by default.
> +         This feature is always disabled when compile-testing with clang
> +         to avoid cluttering the output in stack overflow warnings,
> +         but clang users can still enable it for builds without
> +         CONFIG_COMPILE_TEST.  On gcc it is assumed to always be safe
> +         to use and enabled by default.
>
>  config KASAN_STACK
>         int
> --
> 2.20.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190719200347.2596375-1-arnd%40arndb.de.



-- 
Thanks,
~Nick Desaulniers
