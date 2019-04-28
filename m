Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63CDC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 08:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C1E21530
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 08:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfD1IqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 04:46:17 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:43264 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfD1IqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 04:46:16 -0400
Received: by mail-vk1-f195.google.com with SMTP id g18so1670514vki.10;
        Sun, 28 Apr 2019 01:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LeA4BTl5SuWWI8+5j04l+yMd8FsZkAfk7vM2bOn3wLU=;
        b=AiJqgWkuzsG8m1HSTlbcIkNBJoENYXeLsUc5PP3huuK2RjL/sP5HbnvIWnXJbAMbP5
         uJnXzNjvYjCPihlY6zghR0vxlXbh+3Wn2DqxzS7iEKgIt7GYeIDMT2gloQnON4X93IxU
         h9xb0MG2VraH+zSc6TLiA01IjwDslfURiYC60Ljk9/POEn3Kw3FmcPjnhWmrBIjgQWaN
         dOd0cGYTEe2Yw6WfEgM0ZozhTb8J80adkINKntimOruoo82gHVz98m+qwxYLIwV/OwfZ
         hvlEydsF0XswowjBm4SU6ahbwdxObgssvefzUUNB9BWQlCAh8R8Swp5RjDzHdz4TIdvc
         Bm4w==
X-Gm-Message-State: APjAAAXBwt8VPCCUJFHfUadiMQH5r96XrMWpGtjCAw/Ki7OZlS46oEkv
        ovJiqkLn3UfZNMEuzW6PkuRmn2vNQy9ycgi6d/0=
X-Google-Smtp-Source: APXvYqwHW+/I78MhItZOcGjIDMHVNbZE7f3ko3abfC6hGx/AF+ZS6x6e+/NAw8BfR2EBIhmpUj0zGfi3u/l/9d7zuDE=
X-Received: by 2002:a1f:1284:: with SMTP id 126mr29253775vks.72.1556441175524;
 Sun, 28 Apr 2019 01:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190427153222.GA9613@jerusalem> <20190427202150.GB9613@jerusalem>
In-Reply-To: <20190427202150.GB9613@jerusalem>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 28 Apr 2019 10:46:03 +0200
Message-ID: <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
Subject: Re: endianness swapped
To:     Angelo Dureghello <angelo@sysam.it>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

CC commit relations

On Sat, Apr 27, 2019 at 10:22 PM Angelo Dureghello <angelo@sysam.it> wrote:
> On Sat, Apr 27, 2019 at 05:32:22PM +0200, Angelo Dureghello wrote:
> > as you may know, i am working on mcf5441x.
> > Sorry for not following carefully all the threads, but from a certain
> > kernel version (likely 4.19 or near there), seems ioread32be
> > reads the bytes swapped in endianness (mcf-edma dma driver not working
> > anymore).
> >
> > Has there been a change about this in the architecture I/O access ?
> > How should i proceed now ? Fixing the DMA driver read/write, or what ?

> looks like the reason of my ioread32be now swapped is:
>
> https://patchwork.kernel.org/patch/10766673/
>
> Trying to figure out what to do now.

This is commit aecc787c06f4300f ("iomap: Use non-raw io functions for
io{read|write}XXbe"):

--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -65,8 +65,8 @@ static void bad_io_access(unsigned long port, const
char *access)
 #endif

 #ifndef mmio_read16be
-#define mmio_read16be(addr) be16_to_cpu(__raw_readw(addr))
-#define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
+#define mmio_read16be(addr) swab16(readw(addr))
+#define mmio_read32be(addr) swab32(readl(addr))
 #endif

 unsigned int ioread8(void __iomem *addr)
@@ -106,8 +106,8 @@ EXPORT_SYMBOL(ioread32be);
 #endif

 #ifndef mmio_write16be
-#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
-#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
+#define mmio_write16be(val,port) writew(swab16(val),port)
+#define mmio_write32be(val,port) writel(swab32(val),port)

On big endian, the raw accessors are assumed to be non-swapping,
while non-raw accessors are assumed to be swapping.
The latter is not true for Coldfire internal registers, cfr.
arch/m68k/include/asm/io_no.h:

static inline u16 readw(const volatile void __iomem *addr)
{
        if (cf_internalio(addr))
                return __raw_readw(addr);
        return __le16_to_cpu(__raw_readw(addr));
}

Orthogonal to how Coldfire's read[wl]() should be fixed, I find it a bit
questionable to swap data twice on big endian architectures.

Fortunately we can avoid that by defining our own
mmio_{read,write}{16,32}be()...

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
