Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A92C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 14:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8CF20663
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 14:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2PB1Mez5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFWOLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 10:11:54 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:23360 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFWOLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 10:11:54 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x5NEBV69011197
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:11:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x5NEBV69011197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561299092;
        bh=IAWEC1k7JmeweyFBrRKSY79vqZflSYuq0o8X6SeOK3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2PB1Mez515B6HihQQBQb8WCi8icDjimVH5dCRzYmYc/TOnguMs3KnV4K+DOss/ZEp
         PoxzI8Wb8AT6+T2+yfcew3XlJj7tCAByH9z+yd3x3kaJ6YyW6W8aOjgiasd8HGVshu
         xghLRo2vb6QdQ0ZwnaEUdoKZpBs5pFPezgo7h/AFZcwa5eNF1a6C2+n6M0S3iY3DjT
         xzf37AJjG+JNHOWB2Y2Wra2cebb4s4XnTS72pTi+nmJBjM8q/qLq59OiFFLqN4iX7q
         Byuk4YBpq50FFxjU41X/Qs7C3FghYyPCOHG/q09Dj+MOm8kdmqEzPfZzb7Wks2rX5R
         eYIyTUDhAOq3Q==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id s4so4711869uad.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 07:11:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXKDkYwd7XwlFyYeJarscWwM3t0leBbHjxyuMnNB3u0jyEsDSXg
        aZMDfwJ4mH7+tKJPRWQ/6pbKGvFuCN4uBgg/bjI=
X-Google-Smtp-Source: APXvYqxxL9Fe1f4D+36OPQQYmIHaTRLbAeCCkDst90U/jbNKx6rUFrwQUHLg1/HA63wqrhcO/G2ISUlEKZcqaBy0/t0=
X-Received: by 2002:ab0:234e:: with SMTP id h14mr28875617uao.25.1561299091313;
 Sun, 23 Jun 2019 07:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <1557756964-13087-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1557756964-13087-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 23 Jun 2019 23:10:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNARFYJo2mKAMsxrbLdyOrjFp5gJhq2ySUsDA-8jic3XpZQ@mail.gmail.com>
Message-ID: <CAK7LNARFYJo2mKAMsxrbLdyOrjFp5gJhq2ySUsDA-8jic3XpZQ@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/boot: pass CONFIG options in a simpler and
 more robust way
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Rob Herring <robh@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Mark Greer <mgreer@animalcreek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 11:24 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit 5e9dcb6188a4 ("powerpc/boot: Expose Kconfig symbols to wrapper")
> was wrong, but commit e41b93a6be57 ("powerpc/boot: Fix build failures
> with -j 1") was also wrong.
>
> The correct dependency is:
>
>   $(obj)/serial.o: $(obj)/autoconf.h
>
> However, I do not see the reason why we need to copy autoconf.h to
> arch/power/boot/. Nor do I see consistency in the way of passing
> CONFIG options.
>
> decompress.c references CONFIG_KERNEL_GZIP and CONFIG_KERNEL_XZ, which
> are passed via the command line.
>
> serial.c includes autoconf.h to reference a couple of CONFIG options,
> but this is fragile because we often forget to include "autoconf.h"
> from source files.
>
> In fact, it is already broken.
>
> ppc_asm.h references CONFIG_PPC_8xx, but utils.S is not given any way
> to access CONFIG options. So, CONFIG_PPC_8xx is never defined here.
>
> Pass $(LINUXINCLUDE) to make sure CONFIG options are accessible from
> all .c and .S files in arch/powerpc/boot/.
>
> I also removed the -traditional flag to make include/linux/kconfig.h
> work. This flag makes the preprocessor imitate the behavior of the
> pre-standard C compiler, but I do not understand why it is necessary.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>

Ping.



> Changes in v2:
>  - reword commit log
>
>  arch/powerpc/boot/.gitignore |  2 --
>  arch/powerpc/boot/Makefile   | 14 +++-----------
>  arch/powerpc/boot/serial.c   |  1 -
>  3 files changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
> index 32034a0c..6610665 100644
> --- a/arch/powerpc/boot/.gitignore
> +++ b/arch/powerpc/boot/.gitignore
> @@ -44,5 +44,3 @@ fdt_sw.c
>  fdt_wip.c
>  libfdt.h
>  libfdt_internal.h
> -autoconf.h
> -
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 73d1f35..b8a82be 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -20,9 +20,6 @@
>
>  all: $(obj)/zImage
>
> -compress-$(CONFIG_KERNEL_GZIP) := CONFIG_KERNEL_GZIP
> -compress-$(CONFIG_KERNEL_XZ)   := CONFIG_KERNEL_XZ
> -
>  ifdef CROSS32_COMPILE
>      BOOTCC := $(CROSS32_COMPILE)gcc
>      BOOTAR := $(CROSS32_COMPILE)ar
> @@ -34,7 +31,7 @@ endif
>  BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>                  -fno-strict-aliasing -O2 -msoft-float -mno-altivec -mno-vsx \
>                  -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
> -                -D$(compress-y)
> +                $(LINUXINCLUDE)
>
>  ifdef CONFIG_PPC64_BOOT_WRAPPER
>  BOOTCFLAGS     += -m64
> @@ -51,7 +48,7 @@ BOOTCFLAGS    += -mlittle-endian
>  BOOTCFLAGS     += $(call cc-option,-mabi=elfv2)
>  endif
>
> -BOOTAFLAGS     := -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
> +BOOTAFLAGS     := -D__ASSEMBLY__ $(BOOTCFLAGS) -nostdinc
>
>  BOOTARFLAGS    := -cr$(KBUILD_ARFLAGS)
>
> @@ -202,14 +199,9 @@ $(obj)/empty.c:
>  $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
>         $(Q)cp $< $@
>
> -$(srctree)/$(src)/serial.c: $(obj)/autoconf.h
> -
> -$(obj)/autoconf.h: $(obj)/%: $(objtree)/include/generated/%
> -       $(Q)cp $< $@
> -
>  clean-files := $(zlib-) $(zlibheader-) $(zliblinuxheader-) \
>                 $(zlib-decomp-) $(libfdt) $(libfdtheader) \
> -               autoconf.h empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
> +               empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
>
>  quiet_cmd_bootcc = BOOTCC  $@
>        cmd_bootcc = $(BOOTCC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
> diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
> index b0491b8..9457863 100644
> --- a/arch/powerpc/boot/serial.c
> +++ b/arch/powerpc/boot/serial.c
> @@ -18,7 +18,6 @@
>  #include "stdio.h"
>  #include "io.h"
>  #include "ops.h"
> -#include "autoconf.h"
>
>  static int serial_open(void)
>  {
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
