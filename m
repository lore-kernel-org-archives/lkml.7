Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C39FC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CBA26008
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Gy9TmV6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfEaCCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 22:02:12 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:64124 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaCCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 22:02:12 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x4V220Re026216
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 11:02:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x4V220Re026216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559268121;
        bh=JFKrCexjwszU8gfQr6gW63eXVh2Hm+G6S4mj7tEbXBk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gy9TmV6St9w3knc6CLRQIxjO90p3aOCozwt75d8GEjJesM/ZEDgxL8yKNCQezIlMc
         HVCUNTVU3t2OD7wFo49b/0s5+H1p8zXmzTxBkh0pLyIo5CaZbZeRoUY1gSowgEymjy
         TuHvd6Lqwpt3rRaSn9PoSC76moqRKXBaqC3eHlLE/4kx/sqIMn99GMJGKPF2n4T+Ln
         +3Net432SjsjP6bO0ADHtZdEs8SXhz4pQWYuW4rYy/iu4aSPLm02HrBieQUlI76e9w
         kFq0h9gnBHlNrm938clEM/L8KGz9VputCTg6OE0Jcv0/UMElkP3QO1F6Xh5ykq4NFW
         xHLYv63EaCg1Q==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id l20so5738104vsp.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 19:02:00 -0700 (PDT)
X-Gm-Message-State: APjAAAVUzXOdehIOCRsZ/4LX/TNspx5bTxvmKgI4Z44imqM2kVHIgUXW
        KbigoRwyf8juXs6hHhrL7O15ol+B6PjFj3H7IxQ=
X-Google-Smtp-Source: APXvYqzVzNfAFknY7H7mEOgb5wDJU1a317iny5D7E6KvkLWcVJbVf3bJmiOMvqJe5LYISJjwZVa1Kmh96JHDJfwhpUY=
X-Received: by 2002:a67:b109:: with SMTP id w9mr3599220vsl.155.1559268119666;
 Thu, 30 May 2019 19:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190529182324.8140-1-Jason@zx2c4.com>
In-Reply-To: <20190529182324.8140-1-Jason@zx2c4.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 31 May 2019 11:01:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNARFUaaJH+g3oGzwFyKnELum72nOzxnvUfMKYBaAoGVkug@mail.gmail.com>
Message-ID: <CAK7LNARFUaaJH+g3oGzwFyKnELum72nOzxnvUfMKYBaAoGVkug@mail.gmail.com>
Subject: Re: [PATCH] arm: vdso: pass --be8 to linker if necessary
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thanks for catching this.

On Thu, May 30, 2019 at 3:26 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The commit fe00e50b2db8 ("ARM: 8858/1: vdso: use $(LD) instead of $(CC)
> to link VDSO") removed the passing of CFLAGS, since ld doesn't take
> those directly. However, prior, big-endian ARM was relying on gcc to
> translate its -mbe8 option into ld's --be8 option. Lacking this, ld


'git grep -- -mbe8' has no hit.

Is it a toolchain internal flag?



> generated be32 code, making the VDSO generate SIGILL when called by
> userspace.
>
> This commit passes --be8 if CONFIG_CPU_ENDIAN_BE8 is enabled.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/vdso/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index fadf554d9391..1f5ec9741e6d 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -10,9 +10,10 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>  ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
>  ccflags-y += -DDISABLE_BRANCH_PROFILING
>
> -ldflags-y = -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
> +ldflags-$(CONFIG_CPU_ENDIAN_BE8) := --be8
> +ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
>             -z max-page-size=4096 -z common-page-size=4096 \
> -           -nostdlib -shared \
> +           -nostdlib -shared $(ldflags-y) \
>             $(call ld-option, --hash-style=sysv) \
>             $(call ld-option, --build-id) \
>             -T
> --
> 2.21.0
>


--
Best Regards
Masahiro Yamada
