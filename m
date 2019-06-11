Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA1DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4370C20673
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404709AbfFKI0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:26:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34887 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404073AbfFKI0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:26:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so6075214ljh.2;
        Tue, 11 Jun 2019 01:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRmoMIsZBSVoYdlrURu/R5LpVklxWrnPow9T+scl1c8=;
        b=gIcU94J47mvP6GNPNcFwUM2EV2b2fBSARTihfnzPd0RqXmqXFVQo4ilCXChC250ICZ
         8Xz088n+h9BBMxYQdXbCykA4V1H9dz3o2gscvTA4Vt5L5EswHH2WBNeeS90IXpNLX5Ul
         7SasOEDNAViOksYq01t1xVc58F0Nf+EQr7uGgP6QPAlvicTVX6EIZkAXMMIya9UdSqrI
         GFUmPH8QyChs2T/jM5ppO9Z+9a/kAFO0MpFhurQW9ZaVAuR1FBDZi4u7ydLmSQJ6eB1n
         1bkZWpB4Wg0avUb26Qb2LeAGz5UAapqcLxHgHoPf+6/BR4HBUkmuFfi5SOtXZU2yA+jF
         a6Kg==
X-Gm-Message-State: APjAAAUXwD04mHrGNj3D75TJ+XSIo03T499CZT922SkQs71fsIQ5QaGA
        rMsKp/XX+hkuvEjESFlJo5uQdlX29Zh6uLydFTw=
X-Google-Smtp-Source: APXvYqz5wc/joiy06FOa5+5LASjye7tJKfWbnZfpusW+8Da+RGItpfdSQao+YuZntnzQUcnhkK8gdEsZWI/Z5YLEf6g=
X-Received: by 2002:a2e:91c5:: with SMTP id u5mr28381055ljg.65.1560241559914;
 Tue, 11 Jun 2019 01:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190610212015.9157-1-hch@lst.de> <20190610212015.9157-8-hch@lst.de>
In-Reply-To: <20190610212015.9157-8-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Jun 2019 10:25:46 +0200
Message-ID: <CAMuHMdXvbA=+=AQ6fYV2zRUc6CWtZ_GzEN7D5b8QNYwLEd6OjA@mail.gmail.com>
Subject: Re: [PATCH 07/15] binfmt_flat: use __be32 for the on-disk format
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Jun 10, 2019 at 11:21 PM Christoph Hellwig <hch@lst.de> wrote:
> So far binfmt_flat has onl been supported on 32-bit platforms, so the
> variable size of the fields didn't matter.  But the upcoming RISC-V
> nommu port supports 64-bit CPUs, and we now have a conflict between
> the elf2flt creation tool that always uses 32-bit fields and the kernel
> that uses (unsigned) long field.  Switch to the userspace view as the
> rest of the binfmt_flat format is completely architecture neutral,
> and binfmt_flat isn't the right binary format for huge executables to
> start with.
>
> While we're at it also ensure these fields are using __be types as
> they big endian and are byteswapped when loaded.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

> --- a/include/linux/flat.h
> +++ b/include/linux/flat.h

> @@ -67,19 +67,19 @@ struct flat_hdr {
>  #define OLD_FLAT_RELOC_TYPE_BSS                2
>
>  typedef union {
> -       unsigned long   value;
> +       u32             value;
>         struct {
>  # if defined(mc68000) && !defined(CONFIG_COLDFIRE)
> -               signed long offset : 30;
> -               unsigned long type : 2;
> +               s32     offset : 30;
> +               u32     type : 2;
>  #      define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
>  # elif defined(__BIG_ENDIAN_BITFIELD)
> -               unsigned long type : 2;
> -               signed long offset : 30;
> +               u32     type : 2;
> +               s32     offset : 30;
>  #      define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
>  # elif defined(__LITTLE_ENDIAN_BITFIELD)
> -               signed long offset : 30;
> -               unsigned long type : 2;
> +               s32     offset : 30;
> +               u32     type : 2;
>  #      define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */

The definitions of OLD_FLAT_FLAG_RAM are identical, so could be
factored out.
However, they appear to be unused.

>  # else
>  #      error "Unknown bitfield order for flat files."

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
