Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C244C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803812084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="C1aJehxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfKLCV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 21:21:57 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:53362 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfKLCV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:21:57 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id xAC2Lku3003792
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 11:21:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xAC2Lku3003792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573525307;
        bh=y7MzE4Tyl7ZA6/nakd70Ls06yxLts/TrU5ic+fxvtfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C1aJehxV1KpU4kD1mebXEvYGbuHV1tCyJy2FgOKgNde7u2m1urDSByV5602GtcEHX
         AbncWs7376oCtbr6pE6+8WodZdJ6DEmPBTHUceX++/I31xaXYpWxg88hWYYb0qSAAm
         MSiXMDyNTgvdPQaL7wVmb69zJOdVM5H6SjQWOxj/pLSjHvC+xSMeobV8g1+2iHbQKM
         Hkjxc5QOp8l4aqW1LnBreKskO85rXCrrZQp/a7Cq60hklcZ5Krao+n2Az7MAy9GZQs
         sf0/HAmVY/DJ6ZwGGZkfKJO30z/Ca9ZX1nsD8L23ammk/W3EWdYBG19FjQsKYWzxKp
         lP7Coi4msZfdg==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id b16so9762987vso.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 18:21:46 -0800 (PST)
X-Gm-Message-State: APjAAAWzYx0R2y6V9EpgC0qRQtuXg2OzKBC1HkbOsaCr4IYHW27HJ25b
        xZUAplKwKQ+kgKNHFvJkmOHbSnyiEyN/bXJSzsk=
X-Google-Smtp-Source: APXvYqxeanEG4WIYh37eR2tVL4EL2c3BDdD2rPZKpV6mv7REHbZo5fpg3hHZj6xKkC+uGEZrKDIqz7lYWNAgwCoomUs=
X-Received: by 2002:a05:6102:726:: with SMTP id u6mr20193685vsg.179.1573525305837;
 Mon, 11 Nov 2019 18:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20191110153043.111710-1-dima@golovin.in>
In-Reply-To: <20191110153043.111710-1-dima@golovin.in>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Nov 2019 11:21:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQBKjJB0koyAANPb+iwGa7DYi2R+0EFiD6pJ4TihMFjHQ@mail.gmail.com>
Message-ID: <CAK7LNAQBKjJB0koyAANPb+iwGa7DYi2R+0EFiD6pJ4TihMFjHQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: kbuild: use correct nm executable
To:     Dmitry Golovin <dima@golovin.in>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Matthias Maennich <maennich@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Agner <stefan@agner.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 12:32 AM Dmitry Golovin <dima@golovin.in> wrote:
>
> Since $(NM) variable can be easily overridden for the whole build, it's
> better to use it instead of $(CROSS_COMPILE)nm. The use of $(CROSS_COMPILE)
> prefixed variables where their calculated equivalents can be used is
> incorrect. This fixes issues with builds where $(NM) is set to llvm-nm.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/766
> Signed-off-by: Dmitry Golovin <dima@golovin.in>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Matthias Maennich <maennich@google.com>
> ---

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>



>  arch/arm/boot/compressed/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 9219389bbe61..a1e883c5e5c4 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -121,7 +121,7 @@ ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin -I$(obj)
>  asflags-y := -DZIMAGE
>
>  # Supply kernel BSS size to the decompressor via a linker symbol.
> -KBSS_SZ = $(shell echo $$(($$($(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
> +KBSS_SZ = $(shell echo $$(($$($(NM) $(obj)/../../../../vmlinux | \
>                 sed -n -e 's/^\([^ ]*\) [AB] __bss_start$$/-0x\1/p' \
>                        -e 's/^\([^ ]*\) [AB] __bss_stop$$/+0x\1/p') )) )
>  LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
> @@ -165,7 +165,7 @@ $(obj)/bswapsdi2.S: $(srctree)/arch/$(SRCARCH)/lib/bswapsdi2.S
>  # The .data section is already discarded by the linker script so no need
>  # to bother about it here.
>  check_for_bad_syms = \
> -bad_syms=$$($(CROSS_COMPILE)nm $@ | sed -n 's/^.\{8\} [bc] \(.*\)/\1/p') && \
> +bad_syms=$$($(NM) $@ | sed -n 's/^.\{8\} [bc] \(.*\)/\1/p') && \
>  [ -z "$$bad_syms" ] || \
>    ( echo "following symbols must have non local/private scope:" >&2; \
>      echo "$$bad_syms" >&2; false )
> --
> 2.23.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
