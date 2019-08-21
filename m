Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1490C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8105322CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mIVjIYDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfHUEGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 00:06:47 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:53128 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfHUEGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:06:46 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x7L46Mfm004949;
        Wed, 21 Aug 2019 13:06:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x7L46Mfm004949
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566360383;
        bh=muuXnYLKetb5cxC3kfdv57DMCKDIXml15bwOXhq/nJs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mIVjIYDxZc9Lbo+4Rn79AO8sNgIFjPug562CXh6JT/1+QQoJrDq0RZqPqa5OyYTxB
         IQzNZdOH6Eo4H7Q2o9vMv9+M6AUh3QtB3n09xY3D3oln30lNJY+fzYn9tS7f1MVE74
         wDCGQ+SuiSiaZH5rqEpXzH+27/fwcIP5I6aUvrlKr5H6PC7o/EUx6EmpGaRXCi0jpD
         XNlC3xqnW1gNpH63f12U1BtwfCQiwfjDFaIj3xmKK1wVN1p+Y3SanSgEMrgM+cU1HP
         7GQZBmBtn8l2CM24dqlNC+knxlXE5bzNrOl4AIYIwJYB7yEXLtBOGOvFQC6HSW/p/j
         yTkUu7oxybCdg==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id j25so452434vsq.12;
        Tue, 20 Aug 2019 21:06:22 -0700 (PDT)
X-Gm-Message-State: APjAAAXbKsU3X5JsLp5O+EnyT45yOl1ME5GdhBfGgFJ+TlB7jLtUSPCw
        yxPt7t6iKRDmU69MlpWzjOalixsKI3xKxpvNi1k=
X-Google-Smtp-Source: APXvYqylf5YzGmVfQP1Y/aLizQEgiqcXur6luFADCkGp19zMapciICFm2B+UioaZMTg4uUM9pqSaSmGNw+RRsCvvZ4k=
X-Received: by 2002:a67:fe12:: with SMTP id l18mr4861186vsr.54.1566360381493;
 Tue, 20 Aug 2019 21:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190821035517.21671-1-yamada.masahiro@socionext.com> <20190821035517.21671-3-yamada.masahiro@socionext.com>
In-Reply-To: <20190821035517.21671-3-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 21 Aug 2019 13:05:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAROtaGR4fqrCcocmv8eO1GcAS4FKCLiS_wQqrjEjMMBBg@mail.gmail.com>
Message-ID: <CAK7LNAROtaGR4fqrCcocmv8eO1GcAS4FKCLiS_wQqrjEjMMBBg@mail.gmail.com>
Subject: Re: [PATCH 2/4] video/logo: fix unneeded generation of font C files
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 12:56 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

I will replace 'font' -> 'logo'.
(My brain was corrupted.)



> Currently, all the font C files are generated irrespective of CONFIG
> options. Adding them to extra-y is wrong. What we need to do here is
> to add them to 'targets' so that if_changed works properly.
>
> All files listed in 'targets' are cleaned, so clean-files is unneeded.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  drivers/video/logo/Makefile | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
> index 10b75ce3ce09..16f60c1e1766 100644
> --- a/drivers/video/logo/Makefile
> +++ b/drivers/video/logo/Makefile
> @@ -18,23 +18,6 @@ obj-$(CONFIG_SPU_BASE)                       += logo_spe_clut224.o
>
>  # How to generate logo's
>
> -# Use logo-cfiles to retrieve list of .c files to be built
> -logo-cfiles = $(notdir $(patsubst %.$(2), %.c, \
> -              $(wildcard $(srctree)/$(src)/*$(1).$(2))))
> -
> -
> -# Mono logos
> -extra-y += $(call logo-cfiles,_mono,pbm)
> -
> -# VGA16 logos
> -extra-y += $(call logo-cfiles,_vga16,ppm)
> -
> -# 224 Logos
> -extra-y += $(call logo-cfiles,_clut224,ppm)
> -
> -# Gray 256
> -extra-y += $(call logo-cfiles,_gray256,pgm)
> -
>  pnmtologo := scripts/pnmtologo
>
>  # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
> @@ -55,5 +38,5 @@ $(obj)/%_clut224.c: $(src)/%_clut224.ppm $(pnmtologo) FORCE
>  $(obj)/%_gray256.c: $(src)/%_gray256.pgm $(pnmtologo) FORCE
>         $(call if_changed,logo)
>
> -# Files generated that shall be removed upon make clean
> -clean-files := *_mono.c *_vga16.c *_clut224.c *_gray256.c
> +# generated C files
> +targets += *_mono.c *_vga16.c *_clut224.c *_gray256.c
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
