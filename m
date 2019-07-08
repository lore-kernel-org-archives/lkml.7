Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919E5C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BCF2084A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfGHH1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:27:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40917 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGHH1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:27:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id w196so11809944oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 00:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZrT2N1sutRemC0ofEBvwqZxYdQwvhpPAhF5OXToKzE=;
        b=DCbHNenHLv1PS6wJAizJh4Js1ZPoRojczPMekgWngk93by09yhCD1Lt229d659Ur9g
         i0Vgq/+2cmcT5P65pgK1hGsMqXH2Z6iAS0Lb2TWvZOM81Kaa0aoAeYy7eTA1kpCmE3qk
         vTg9tp3nBSke/9LeFVcPJGnWLOhzbDjDnW/ThLIfWn/xAzQ744EafFCJeYSKOCxbdFTO
         g2KM+MSbkw/IjsuW1ne+Zty4IxCICGPyLoqtyIQc6Q3/W9YieExmeJ6RCJr3o/gRrv+0
         DtxigZvyECrFt7udLnSI5BZez7uibHrZkUkd1BLbJwzAJmfYwy2nmhV+S9gJTvnWbLkr
         WLUA==
X-Gm-Message-State: APjAAAXEIjxrZfYVyXmVxQ+yk9ua/n6drkLcF+OYHEZT+SwMkAmcb/5F
        2y0swGwksyb0PxUpOqJafEFTbRhKbCFFlWg3TYI=
X-Google-Smtp-Source: APXvYqzMNknub3S2RKZaG12cUKoGvm5whfeE6+B2Z9W4By+mrROQD5rNaLcO9l33MgAWAtuS9MO/dGBHWr+pOUGKQRA=
X-Received: by 2002:a05:6808:3c5:: with SMTP id o5mr8625647oie.102.1562570822914;
 Mon, 08 Jul 2019 00:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <224218b529a5abb1d5dd5ce2103b685a10866577.1550182390.git.fthain@telegraphics.com.au>
In-Reply-To: <224218b529a5abb1d5dd5ce2103b685a10866577.1550182390.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jul 2019 09:26:51 +0200
Message-ID: <CAMuHMdW_ScrApPH1YZb8+64+wZjq9BGuF18KCF7--9D2gneXrg@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Revisit floppy disc controller base addresses
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joshua Thompson <funaho@jurai.org>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Thanks for your patch!

On Thu, Feb 14, 2019 at 11:22 PM Finn Thain <fthain@telegraphics.com.au> wrote:
> Rename floppy_type macros to make them more consistent with the scsi_type
> macros, which are named after classes of models with similar memory maps.
>
> The documentation for LC-class machines has the IO devices at offsets
> from $50F0 0000. Use these addresses (consistent with mac_scsi resources)
> because they may not be aliased elsewhere in the memory map, e.g. at
> offsets from $5000 0000.

I guess the others do have aliases at 0x50000000? ...

>
> Add comments with controller type information from 'Designing Cards and
> Drivers for the Macintosh Family', relevant Developer Notes and
> http://mess.redump.net/mess/driver_info/mac_technical_notes
>
> Adopt phys_addr_t to avoid type casts.
>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Laurent Vivier <lvivier@redhat.com>

> --- a/arch/m68k/mac/config.c
> +++ b/arch/m68k/mac/config.c

> @@ -973,22 +973,22 @@ int __init mac_platform_init(void)
>          */
>
>         switch (macintosh_config->floppy_type) {
> -       case MAC_FLOPPY_SWIM_ADDR1:
> -               swim_base = (u8 *)(VIA1_BASE + 0x1E000);
> +       case MAC_FLOPPY_QUADRA:
> +               swim_base = 0x5001E000;
>                 break;
> -       case MAC_FLOPPY_SWIM_ADDR2:
> -               swim_base = (u8 *)(VIA1_BASE + 0x16000);
> +       case MAC_FLOPPY_OLD:
> +               swim_base = 0x50016000;

... so that's why you change them from 0x50fxxxxx to 0x500xxxxx?

If that is correct, please mention that in the patch description.

Thanks!

>                 break;
> -       default:
> -               swim_base = NULL;
> +       case MAC_FLOPPY_LC:
> +               swim_base = 0x50F16000;
>                 break;
>         }
>
>         if (swim_base) {
>                 struct resource swim_rsrc = {
>                         .flags = IORESOURCE_MEM,
> -                       .start = (resource_size_t)swim_base,
> -                       .end   = (resource_size_t)swim_base + 0x1FFF,
> +                       .start = swim_base,
> +                       .end   = swim_base + 0x1FFF,
>                 };
>
>                 platform_device_register_simple("swim", -1, &swim_rsrc, 1);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
