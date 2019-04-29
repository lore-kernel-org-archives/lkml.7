Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE52C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A474D2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfD2MkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:40:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38721 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbfD2MkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:40:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so11628187qth.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 05:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbAr6/WdYzJlIzTH+NuMw5/VW9YuLHZKFQ/V9ucbt+8=;
        b=ifCw3KNUmszAaiPtKjEHYgsd4taolTC1vOPxMGLZnk423VFZZSvItESD1fuutRThEl
         cWwSajAD7g4TLLKUzt0rCYqzehzXiWna4RL5hhjK5tN+bWeGOIfofyKA7L3ErVFg7DiN
         OO+7rAtv13/NlxfcEWRzmmB09kp+e4gs3Hn1oVu7gYz3aaThDpWijXmxNfERb+9czsOJ
         z8H/FOEQDhASvnhAEW2pKeS3VI0X5RqQaz6YagHSobPGR2lbKAcIvh4AbzMPvmgwGuxP
         9lR7o8ENY8o/kF48onpVmsbD2tUkrgbxlKCJuDim8Z5VM0WzavGJFxuoQqzzrngdC7AU
         znvQ==
X-Gm-Message-State: APjAAAXgmLt157F+viNPxYw1cvHSnRqwOyj0+OwZgdS4wjNZtRnzFWR4
        r/DTVhse7Kbem4tuIS3NF8hYCWmVF2X08kGRQvg=
X-Google-Smtp-Source: APXvYqxtyaYWnpSaTkKoxT8ZEzcffujpYcweM7sgqhq0vKNL+IjepM43siJ5d37QAZ5PcYFuhIjeC7tjWLDFIw8mR/E=
X-Received: by 2002:ac8:3f38:: with SMTP id c53mr38245305qtk.152.1556541604080;
 Mon, 29 Apr 2019 05:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190429081937.7544-1-geert@linux-m68k.org>
In-Reply-To: <20190429081937.7544-1-geert@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Apr 2019 14:39:47 +0200
Message-ID: <CAK8P3a1NbjYAGCTq2RUfqEX1OgppEV5mKmBJ0t=JiFF13zSytg@mail.gmail.com>
Subject: Re: [PATCH] m68k: io: Fix io{read,write}{16,32}be() for Coldfire peripherals
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Angelo Dureghello <angelo@sysam.it>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:19 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> The generic definitions of mmio_{read,write}{16,32}be() in lib/iomap.c
> assume that the {read,write}[wl]() I/O accessors always use little
> endian accesses, and swap the result.
>
> However, the Coldfire versions of the {read,write}[wl]() I/O accessors are
> special, in that they use native big endian instead of little endian for
> accesses to the on-SoC peripheral block, thus violating the assumption.
>
> Fix this by providing our own variants, using the raw accessors,
> reinstating the old behavior.  This is fine on m68k, as no special
> barriers are needed, and also avoids swapping data twice.
>
> Reported-by: Angelo Dureghello <angelo@sysam.it>
> Fixes: aecc787c06f4300f ("iomap: Use non-raw io functions for io{read|write}XXbe")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> This can be reverted later, after this oddity of the Coldfire I/O
> support has been fixed, and drivers have been updated.
> ---
>  arch/m68k/include/asm/io.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
> index aabe6420ead2a599..d47e7384681ab1cd 100644
> --- a/arch/m68k/include/asm/io.h
> +++ b/arch/m68k/include/asm/io.h
> @@ -8,6 +8,12 @@
>  #include <asm/io_mm.h>
>  #endif
>
> +#define mmio_read16be(addr)            __raw_readw(addr)
> +#define mmio_read32be(addr)            __raw_readl(addr)
> +
> +#define mmio_write16be(val, port)      __raw_writew((val), (port))
> +#define mmio_write32be(val, port)      __raw_writel((val), (port))
> +
>  #include <asm-generic/io.h>

This looks correct to me, but there are two points that stick out to me:

- why do you only do this for mmio and not for pio?
- why do you even use the generic_iomap wrappers rather than
  the trivial asm-generic versions of those functions?

       Arnd
