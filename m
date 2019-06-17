Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98AEC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C313320863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfFQUYE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:24:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39264 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbfFQUYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:24:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id i34so7160447qta.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 13:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4pItfmIF9BXCq+5fMpkHMPOAjCwD9tKzbQC2ATbU3XA=;
        b=NNmMi9dYNpbgAUl/sXeJ5oaRAJfcToxpwvJT3AltTCAwbY4b6TMX1M5GGqlRQbpFmc
         4UmosDyW8DCdZyUJakhKT35s6SFNOQtlCvDko/VVG/5r1UxsM9F/1waefNlNxDfuoi4R
         A/eAVcH5/5aCmezqDJW3UZRwNBtpeUXHMfkwVTO3p0HEoKbio1DxulnRI8228Euo44Vf
         OVirOymxBx7URTvXltn4t1wtIFK8XPzhj99bW4MFppFdJct4Y2WudhodGYJSgxtqhqHw
         HZ//DFZwUWGrvtuNqTffN7gQc5PfoR+aLR5Kd0+l/Mv5wg1TagRH9+l4bPinipSuAmdo
         ASgA==
X-Gm-Message-State: APjAAAU5GCMeXve6NgYYwbBY5a+yKTc4oq5Bw8uzIE2lOY6ph/xf92wc
        wMxVOLRdRKVbtSWiTkQfYHYIFFWnLRV2djbpaMMnXZ2x3+U=
X-Google-Smtp-Source: APXvYqy4Unnhet8qqC3Cl960aIp24gAx2o6DWsJ4LQIbDl6e7igeVzc/mjRaois3hURJ4dbdc4vSQZ7O4vSJRTTTUiM=
X-Received: by 2002:ac8:3485:: with SMTP id w5mr18860691qtb.142.1560803042716;
 Mon, 17 Jun 2019 13:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190429081937.7544-1-geert@linux-m68k.org> <CAK8P3a1NbjYAGCTq2RUfqEX1OgppEV5mKmBJ0t=JiFF13zSytg@mail.gmail.com>
 <CAMuHMdUHnW13j07559peRijggGQwExrJ9TBaAW7ZqWcT1onpSg@mail.gmail.com>
In-Reply-To: <CAMuHMdUHnW13j07559peRijggGQwExrJ9TBaAW7ZqWcT1onpSg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 22:23:45 +0200
Message-ID: <CAK8P3a3fvTPZKhASGA5cZE2WwTM8LgA45kgbm0XE2KjwCopTSA@mail.gmail.com>
Subject: Re: [PATCH] m68k: io: Fix io{read,write}{16,32}be() for Coldfire peripherals
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Angelo Dureghello <angelo@sysam.it>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 4:52 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Apr 29, 2019 at 2:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Apr 29, 2019 at 10:19 AM Geert Uytterhoeven
> > This looks correct to me, but there are two points that stick out to me:
> >
> > - why do you only do this for mmio and not for pio?
>
> Because no one had a need for it? ;-)
>
> Now seriously, m68k only has MMIO, no PIO.  Any PIO, if used, is for ISA or
> PCMCIA I/O accesses, which are little endian.

I suppose the majority of PIO operations are single-byte only,
so endianess doesn't apply at all ;-). You are certainly right
that big-endian PIO access has close to zero uses in the
kernel (I could not find any either).

If you don't have ISA or PCMCIA devices, then using the
trivial readl/writel based wrappers is clearly the easiest way.

If you do have PIO based devices, then defining pio_read16be
etc would save a few bytes in lib/iomap.c.

> > - why do you even use the generic_iomap wrappers rather than
> >   the trivial asm-generic versions of those functions?
>
> Looking at git history, that was done to fix some link errors, which no
> longer seem to happen with the more mature asm-generic infrastructure we
> have now.
>
> So probably we can drop the selection of GENERIC_IOMAP and inclusion
> of <asm-generic/iomap.h>, after fixing a few compiler warnings like:
>
>     include/asm-generic/io.h: In function ‘ioread8_rep’
>     arch/m68k/include/asm/io_mm.h:371:44: warning: passing argument 1
> of ‘raw_insb’ discard ‘const’ qualifier from pointer target type
> [-Wdiscarded-qualifiers]
>      #define readsb(port, buf, nr)     raw_insb((port), (u8 *)(buf), (nr))
>     arch/m68k/include/asm/raw_io.h:101:50: note: expected ‘volatile u8
> *’ {aka ‘volatile unsigned char *’} but argument is of type ‘const
> volatile void *’
>     static inline void raw_insb(volatile u8 __iomem *port, u8 *buf,
> unsigned int len)

Those should just be missing 'volatile' and 'const' modifiers
on the arguments.

         Arnd
