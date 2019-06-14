Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42293C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEC02133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfFNOuC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:50:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42662 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfFNOuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:50:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id y13so1923597lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 07:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/tv53bBPYd1hXH+pjJtxE0GfwGIVE/QTSAJ64xVQ4QY=;
        b=KNpIxesmCSfDQa66v8UarsZ49zhV3vV5Dh3W7vs1luGHUBm/SoEH1T09Ih7Mr6iCHS
         4t/ffNN5XS16jGoy+o5i9duj01JWe6hDvd/BWsGKVdCtHcYfO7u05iUpBF/rk8f/aKFB
         MhFdiBW6+OAcellbgPLg4jc26mIxRLs5hS9VT56jfACjy0CjEjvIFlUbU010zfybcpny
         Av/7pcXZqhwViB+McGTVf/sdptZ6N3JydQ0+mXMw16j2yWOqugR383+I/HRrYdR6PWRv
         z3AYgxs3PMa4X0xqLcgQG4IDfM4lyqKp23cN1rm3kTQfERtpaJz82xeLpqr6vv3PaiN9
         9xHg==
X-Gm-Message-State: APjAAAWqFNuVH8J/3Z6zWM47QMGwJA1xODxEtqnCLj99g4HLDtSdp64q
        DkowOSgzPufSxb6rFUpmGLGOtbsjL+gsdsfL8lL/+6t5
X-Google-Smtp-Source: APXvYqxD3wqf6g/sdCg0FVG2kshRAzt7DvShEl9JMI9mG1tKob5nMKlK+606u2/DUa9cJVolgXr9F3h4j+M3m4BDTc0=
X-Received: by 2002:a19:6e41:: with SMTP id q1mr40659179lfk.20.1560523799309;
 Fri, 14 Jun 2019 07:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190429081937.7544-1-geert@linux-m68k.org> <CAK8P3a1NbjYAGCTq2RUfqEX1OgppEV5mKmBJ0t=JiFF13zSytg@mail.gmail.com>
In-Reply-To: <CAK8P3a1NbjYAGCTq2RUfqEX1OgppEV5mKmBJ0t=JiFF13zSytg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jun 2019 16:49:45 +0200
Message-ID: <CAMuHMdUHnW13j07559peRijggGQwExrJ9TBaAW7ZqWcT1onpSg@mail.gmail.com>
Subject: Re: [PATCH] m68k: io: Fix io{read,write}{16,32}be() for Coldfire peripherals
To:     Arnd Bergmann <arnd@arndb.de>
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

Hi Arnd,

On Mon, Apr 29, 2019 at 2:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Apr 29, 2019 at 10:19 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > The generic definitions of mmio_{read,write}{16,32}be() in lib/iomap.c
> > assume that the {read,write}[wl]() I/O accessors always use little
> > endian accesses, and swap the result.
> >
> > However, the Coldfire versions of the {read,write}[wl]() I/O accessors are
> > special, in that they use native big endian instead of little endian for
> > accesses to the on-SoC peripheral block, thus violating the assumption.
> >
> > Fix this by providing our own variants, using the raw accessors,
> > reinstating the old behavior.  This is fine on m68k, as no special
> > barriers are needed, and also avoids swapping data twice.
> >
> > Reported-by: Angelo Dureghello <angelo@sysam.it>
> > Fixes: aecc787c06f4300f ("iomap: Use non-raw io functions for io{read|write}XXbe")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > This can be reverted later, after this oddity of the Coldfire I/O
> > support has been fixed, and drivers have been updated.
> > ---
> >  arch/m68k/include/asm/io.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
> > index aabe6420ead2a599..d47e7384681ab1cd 100644
> > --- a/arch/m68k/include/asm/io.h
> > +++ b/arch/m68k/include/asm/io.h
> > @@ -8,6 +8,12 @@
> >  #include <asm/io_mm.h>
> >  #endif
> >
> > +#define mmio_read16be(addr)            __raw_readw(addr)
> > +#define mmio_read32be(addr)            __raw_readl(addr)
> > +
> > +#define mmio_write16be(val, port)      __raw_writew((val), (port))
> > +#define mmio_write32be(val, port)      __raw_writel((val), (port))
> > +
> >  #include <asm-generic/io.h>
>
> This looks correct to me, but there are two points that stick out to me:
>
> - why do you only do this for mmio and not for pio?

Because no one had a need for it? ;-)

Now seriously, m68k only has MMIO, no PIO.  Any PIO, if used, is for ISA or
PCMCIA I/O accesses, which are little endian.

> - why do you even use the generic_iomap wrappers rather than
>   the trivial asm-generic versions of those functions?

Looking at git history, that was done to fix some link errors, which no
longer seem to happen with the more mature asm-generic infrastructure we
have now.

So probably we can drop the selection of GENERIC_IOMAP and inclusion
of <asm-generic/iomap.h>, after fixing a few compiler warnings like:

    include/asm-generic/io.h: In function ‘ioread8_rep’
    arch/m68k/include/asm/io_mm.h:371:44: warning: passing argument 1
of ‘raw_insb’ discard ‘const’ qualifier from pointer target type
[-Wdiscarded-qualifiers]
     #define readsb(port, buf, nr)     raw_insb((port), (u8 *)(buf), (nr))
    arch/m68k/include/asm/raw_io.h:101:50: note: expected ‘volatile u8
*’ {aka ‘volatile unsigned char *’} but argument is of type ‘const
volatile void *’
    static inline void raw_insb(volatile u8 __iomem *port, u8 *buf,
unsigned int len)

and some regression testing, of course.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
