Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E56C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3B72075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfD1JWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 05:22:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36835 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfD1JWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 05:22:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id c35so8880414qtk.3;
        Sun, 28 Apr 2019 02:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=veWYAJkJ/F2gcFlQ2zbsFOPbVn5QH3794y4MG0IvxDI=;
        b=sNj3dUrgGImm/IzeA3Is7GCaA032TTwti08PAKFtMomJtYaOCxuJRnySQdqUqMivKr
         1SaLGsqNORqBkh6bhgTDocBJslsvVvDIKECWxAYiggTqxt5+fhbe/7TmVvpHfQrV39vT
         o9R8MiS99gUFFy5E7yyvS26XTyuucUYt0jfV2rC9k/RaODp7PsedgUgou3gH3yENYM1o
         8ww9qrS9Bb9BLCVnqKqtpzbKURdPBohIXYTzYgOysGg3BxEGWaDEb8UU07eyOwdVHToY
         8TiQ26/7AIBzuNsZLVanWfJQmWOOyheX834P66Zol0THuTKL0YiMTaqRQ56J4SkKg3kO
         kiVw==
X-Gm-Message-State: APjAAAWv0Nr5ioUA1Lm45FofDNswHQo6s28RqK5bOcDmSkLaY7qKYErS
        RXUd76fGVu6Y5rjYMw5Q8Gq6xDTFQ0PfkbFTjAc=
X-Google-Smtp-Source: APXvYqyaHEYbkQjjmbvSJ0mXCZluNISeZglksexpBd2wlbqx1f2Tksn/ePtz4c/VCYzD22LyTchSujkmYxGEWUMC6WU=
X-Received: by 2002:ac8:3f38:: with SMTP id c53mr33723274qtk.152.1556443323842;
 Sun, 28 Apr 2019 02:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190427153222.GA9613@jerusalem> <20190427202150.GB9613@jerusalem>
 <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
In-Reply-To: <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 28 Apr 2019 11:21:46 +0200
Message-ID: <CAK8P3a2F6KW3M7ZaK=WL8429j_z=y_wXrx6rthxni8vBmsMPyg@mail.gmail.com>
Subject: Re: endianness swapped
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Angelo Dureghello <angelo@sysam.it>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 10:46 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sat, Apr 27, 2019 at 10:22 PM Angelo Dureghello <angelo@sysam.it> wrote:
> > On Sat, Apr 27, 2019 at 05:32:22PM +0200, Angelo Dureghello wrote:
> > > as you may know, i am working on mcf5441x.
> > > Sorry for not following carefully all the threads, but from a certain
> > > kernel version (likely 4.19 or near there), seems ioread32be
> > > reads the bytes swapped in endianness (mcf-edma dma driver not working
> > > anymore).
> > >
> > > Has there been a change about this in the architecture I/O access ?
> > > How should i proceed now ? Fixing the DMA driver read/write, or what ?
>
> > looks like the reason of my ioread32be now swapped is:
> >
> > https://patchwork.kernel.org/patch/10766673/
> >
> > Trying to figure out what to do now.
>
> This is commit aecc787c06f4300f ("iomap: Use non-raw io functions for
> io{read|write}XXbe"):
>
> --- a/lib/iomap.c
> +++ b/lib/iomap.c
> @@ -65,8 +65,8 @@ static void bad_io_access(unsigned long port, const
> char *access)
>  #endif
>
>  #ifndef mmio_read16be
> -#define mmio_read16be(addr) be16_to_cpu(__raw_readw(addr))
> -#define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
> +#define mmio_read16be(addr) swab16(readw(addr))
> +#define mmio_read32be(addr) swab32(readl(addr))
>  #endif
>
>  unsigned int ioread8(void __iomem *addr)
> @@ -106,8 +106,8 @@ EXPORT_SYMBOL(ioread32be);
>  #endif
>
>  #ifndef mmio_write16be
> -#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
> -#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
> +#define mmio_write16be(val,port) writew(swab16(val),port)
> +#define mmio_write32be(val,port) writel(swab32(val),port)
>
> On big endian, the raw accessors are assumed to be non-swapping,
> while non-raw accessors are assumed to be swapping.
> The latter is not true for Coldfire internal registers, cfr.
> arch/m68k/include/asm/io_no.h:

The raw accessors are always assumed to be non-swapping
in the asm-generic code, while the non-raw ones are assumed to
be little-endian in order for them to work with portable drivers.

We have some other cases of big-endian machines that use
a hardware byteswap on their MMIO buses (iirc some mips
and superh parts), but they then need to swap the __raw_*
accessor data words in software to get back to the normal
behavior, as well as swizzle the address for accesses that are
less than 32 bit wide.

Coldfire makes the behavior of readw()/readl() depend on the
MMIO address, presumably since that was the easiest way to
get drivers working originally, but it breaks the assumption
in the asm-generic code.

> static inline u16 readw(const volatile void __iomem *addr)
> {
>         if (cf_internalio(addr))
>                 return __raw_readw(addr);
>         return __le16_to_cpu(__raw_readw(addr));
> }
>
> Orthogonal to how Coldfire's read[wl]() should be fixed, I find it a bit
> questionable to swap data twice on big endian architectures.

I would expect that the compiler is capable of detecting a double
swap and optimize it out. Even if it can't, there are not that many
instances of io{read,write}{16,32}be in the kernel, so the increase
in kernel image size from a double swap should be limited to a
few extra instructions, and the runtime overhead should be
negligible compared to the bus access.

> Fortunately we can avoid that by defining our own
> mmio_{read,write}{16,32}be()...

Yes, that should be the easiest workaround. I doubt that anyone
would want to audit all drivers for internal I/O on coldfire and
convert them to use the big-endian accessors in place of the
readw/readl ones in order to use the asm-generic/io.h conventions.

      Arnd
