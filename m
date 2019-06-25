Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063DBC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD28D21670
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfFYIIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:08:04 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40466 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfFYIIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:08:04 -0400
Received: by mail-oi1-f194.google.com with SMTP id w196so11813812oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jxnw+U68hXn7Fa0q2TDaDCNwS8hp8RvnOdBQ8+g7VtQ=;
        b=jOaTrMx/Yv4gOf4ng5pj8MKmCIrmMGg5Eqf7k+fbOk+7lSxCSWnL6oPfQ2ODySSflq
         Gm4zH+tLNj+x/srJpZZMbqMpfWyTn8q2nooUqPQCYKtvKBuRIFR/MrigfBrbI+Jf0yNG
         WzMX/5bal9osld9vHRi+PVGgYVNYwxz+1nPE7h+0JMYZf33bf5x7iL833W+4VHKeyL+X
         Z99HWo+QETU/uv+u6a9Wgjzg6+JQkfX9uIY2Oba022rbD2XUEYoXRlZfKXxE39RXZFx2
         nidpnz/pOabD+zbjf0Pyal2kHfbAilYcvedF5EHrwVrAQEXdE8Um0/SI9cYyMQe/5W4Y
         gCTg==
X-Gm-Message-State: APjAAAWuA3NWvHozfTyWd6kwCKzDB5qJd5hVtT0TLHyn0FOexmUEsnRr
        7SM0Squ1EBQ0AdhgAI0swvL0RoYgHgKDqnK2nSQ=
X-Google-Smtp-Source: APXvYqzrUbQHgU0X1DTs1TPpiF36yqBmvbJBf3nQaoGw1DPSgo/XDZxCB1bntOWxwntQtZIyDTs1Fl08JTO4tIu1AmQ=
X-Received: by 2002:aca:338a:: with SMTP id z132mr13925717oiz.54.1561450082666;
 Tue, 25 Jun 2019 01:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190614102126.8402-1-hch@lst.de> <CAMuHMdVPU5RQyX4FnHFEhxXZeG3v0uh_-t2FB=vAzQ8_3u-gSw@mail.gmail.com>
 <20190625063228.GA29561@lst.de> <CAMuHMdUNwERTRg4MbkkD62EtNhsU7kWVy6x4kB89rYh6ann0Pw@mail.gmail.com>
 <20190625073524.GA30815@lst.de>
In-Reply-To: <20190625073524.GA30815@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jun 2019 10:07:51 +0200
Message-ID: <CAMuHMdU1j9TiSB-67_3P1RMU95Jtb2=1=g2dhpD6zXuk9e69gA@mail.gmail.com>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, Jun 25, 2019 at 9:35 AM Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Jun 25, 2019 at 09:26:48AM +0200, Geert Uytterhoeven wrote:
> > > > bloat-o-meter says:
> > > >
> > > > add/remove: 75/0 grow/shrink: 11/6 up/down: 4122/-82 (4040)
> > >
> > > What do these values stand for?  The code should grow a little as
> > > we now need to include the the pool allocator for the above API
> > > fix.
> >
> > Last 3 values are "bytes added/removed (net increase)".
> > So this increases the static kernel size by ca. 4 KiB.
>
> That seems a lot for the little bit of pool code.  Did m68k not

Exactly, hence my original question...

> build lib/genalloc.c by default before?

Indeed, CONFIG_GENERIC_ALLOCATOR wasn't enabled before.

--- .config.orig 2019-06-25 09:53:35.098691378 +0200
+++ .config 2019-06-25 09:59:23.914874446 +0200
@@ -2401,6 +2401,7 @@
 CONFIG_DECOMPRESS_XZ=y
 CONFIG_DECOMPRESS_LZO=y
 CONFIG_DECOMPRESS_LZ4=y
+CONFIG_GENERIC_ALLOCATOR=y
 CONFIG_TEXTSEARCH=y
 CONFIG_TEXTSEARCH_KMP=m
 CONFIG_TEXTSEARCH_BM=m
@@ -2409,6 +2410,10 @@
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_DMA=y
 CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
+CONFIG_ARCH_HAS_DMA_PREP_COHERENT=y
+CONFIG_ARCH_HAS_DMA_MMAP_PGPROT=y
+CONFIG_DMA_REMAP=y
+CONFIG_DMA_DIRECT_REMAP=y
 # CONFIG_DMA_API_DEBUG is not set
 CONFIG_SGL_ALLOC=y
 CONFIG_DQL=y

> Also I'd be curious what the first 4 values are.

Reading scripts/bloat-o-meter in the kernel source tree tells me number of
added/removed symbols (functions or variables), and number of
grown/shrunk symbols.

I run it regularly, to catch silly mistakes (cfr. my favorite one, fixed
by commit 23c323af0375a7f6 ("SUNRPC: No, I did not intend to create a
256KiB hashtable")).

Full output before/after for an atari_defconfig kernel
(numbers are different, baseline has changed, too):

$ bloat-o-meter vmlinux.orig vmlinux
add/remove: 75/0 grow/shrink: 1/2 up/down: 4098/-28 (4070)
Function                                     old     new   delta
gen_pool_alloc_algo_owner                      -     392    +392
dma_atomic_pool_init                           -     360    +360
gen_pool_best_fit                              -     248    +248
dma_common_contiguous_remap                    -     238    +238
gen_pool_destroy                               -     190    +190
gen_pool_free_owner                            -     184    +184
devm_gen_pool_create                           -     174    +174
dma_alloc_from_pool                            -     152    +152
bitmap_clear_ll                                -     138    +138
arch_dma_free                                 12     136    +124
dma_common_free_remap                          -     110    +110
gen_pool_add_owner                             -     108    +108
gen_pool_fixed_alloc                           -     100    +100
dma_common_pages_remap                         -      92     +92
gen_pool_dma_alloc                             -      78     +78
arch_dma_prep_coherent                         -      76     +76
clear_bits_ll                                  -      66     +66
dma_free_from_pool                             -      62     +62
set_bits_ll                                    -      60     +60
devm_gen_pool_match                            -      56     +56
addr_in_gen_pool                               -      56     +56
gen_pool_create                                -      54     +54
gen_pool_virt_to_phys                          -      52     +52
gen_pool_first_fit_align                       -      52     +52
gen_pool_for_each_chunk                        -      42     +42
gen_pool_get                                   -      40     +40
gen_pool_first_fit_order_align                 -      36     +36
gen_pool_set_algo                              -      34     +34
early_coherent_pool                            -      32     +32
__kstrtab_gen_pool_first_fit_order_align       -      31     +31
gen_pool_size                                  -      30     +30
arch_dma_mmap_pgprot                           -      28     +28
dma_in_atomic_pool                             -      26     +26
__kstrtab_gen_pool_alloc_algo_owner            -      26     +26
__kstrtab_gen_pool_first_fit_align             -      25     +25
gen_pool_avail                                 -      24     +24
__kstrtab_gen_pool_for_each_chunk              -      24     +24
__kstrtab_gen_pool_virt_to_phys                -      22     +22
__kstrtab_gen_pool_fixed_alloc                 -      21     +21
__kstrtab_devm_gen_pool_create                 -      21     +21
arch_dma_coherent_to_pfn                       -      20     +20
__kstrtab_gen_pool_free_owner                  -      20     +20
__kstrtab_gen_pool_first_fit                   -      19     +19
__kstrtab_gen_pool_dma_alloc                   -      19     +19
__kstrtab_gen_pool_add_owner                   -      19     +19
__kstrtab_gen_pool_set_algo                    -      18     +18
__kstrtab_gen_pool_best_fit                    -      18     +18
__kstrtab_gen_pool_destroy                     -      17     +17
__kstrtab_gen_pool_create                      -      16     +16
__kstrtab_gen_pool_avail                       -      15     +15
gen_pool_first_fit                             -      14     +14
devm_gen_pool_release                          -      14     +14
__setup_str_early_coherent_pool                -      14     +14
__kstrtab_gen_pool_size                        -      14     +14
__kstrtab_gen_pool_get                         -      13     +13
__setup_early_coherent_pool                    -      12     +12
__ksymtab_gen_pool_virt_to_phys                -       8      +8
__ksymtab_gen_pool_size                        -       8      +8
__ksymtab_gen_pool_set_algo                    -       8      +8
__ksymtab_gen_pool_get                         -       8      +8
__ksymtab_gen_pool_free_owner                  -       8      +8
__ksymtab_gen_pool_for_each_chunk              -       8      +8
__ksymtab_gen_pool_fixed_alloc                 -       8      +8
__ksymtab_gen_pool_first_fit_order_align       -       8      +8
__ksymtab_gen_pool_first_fit_align             -       8      +8
__ksymtab_gen_pool_first_fit                   -       8      +8
__ksymtab_gen_pool_dma_alloc                   -       8      +8
__ksymtab_gen_pool_destroy                     -       8      +8
__ksymtab_gen_pool_create                      -       8      +8
__ksymtab_gen_pool_best_fit                    -       8      +8
__ksymtab_gen_pool_avail                       -       8      +8
__ksymtab_gen_pool_alloc_algo_owner            -       8      +8
__ksymtab_gen_pool_add_owner                   -       8      +8
__ksymtab_devm_gen_pool_create                 -       8      +8
atomic_pool_size                               -       4      +4
atomic_pool                                    -       4      +4
arch_dma_alloc                               312     310      -2
dma_common_mmap                              250     224     -26
Total: Before=3724055, After=3728125, chg +0.11%


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
