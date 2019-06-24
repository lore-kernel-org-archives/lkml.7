Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640A7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4259A2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfFXHQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:16:42 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35295 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFXHQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:16:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so9015117oii.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 00:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VaP9DcJntoExkzdbDVYZcYt6yhIrCESVYXgeB0JPho=;
        b=mkVU6K6GujCuFZFuSsSki4fqyj/8ggY6Eg5fV3Gg1EmhAzGziyAxP87+ekl9FAGHo+
         uy2c2/gXzNru+u/rFTdHVPPWw/h4WzAKcwAWOmfvEfhK5NEQBUNwQ2LUf24uIlJDsJZL
         9Voaf5M6/kUPq7udngRdw3hXsIcfGFpHfcDodBy88xOAjDWQcoZkzAe+2TpTR72j9bCx
         P62Jf/trFvIOrsqVK+H8GHnx/PabA/SmZREf/w4Bg+MYy21UdhGGTj3wYG3CqrsTr8i9
         2+eKrZ2ue8zj0ZQ5z0IiHX32t1CTxZ1ZjPynYNu8IbmpiPp+E5+Ul74cbqB52vSKuHP8
         HVjw==
X-Gm-Message-State: APjAAAWrtbtAfLZyP5+DQo7+rv66hhAA96DT8Kn1dji6zVOWo83mHLUH
        xqJ0ICiFPSuup1S+glgTq2O0vFKTByEkLlbfXTr40F9A
X-Google-Smtp-Source: APXvYqwjNpJZS5JGDSd4vFCHzeEA5Jvi4zbkSDl1ADx6436Ln2bc4donTa2LIBvyHioB/b/v4b+ZniLu5PjJQ3MIyuw=
X-Received: by 2002:aca:c4d5:: with SMTP id u204mr9868425oif.131.1561360601551;
 Mon, 24 Jun 2019 00:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190614102126.8402-1-hch@lst.de>
In-Reply-To: <20190614102126.8402-1-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jun 2019 09:16:30 +0200
Message-ID: <CAMuHMdUbuTc+MWqDFw=RnYxtiNQPQkzJ91KDuAQbhMq533tBCQ@mail.gmail.com>
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

On Fri, Jun 14, 2019 at 12:21 PM Christoph Hellwig <hch@lst.de> wrote:
> can you take a look at the (untested) patches below?  They convert m68k
> to use the generic remapping DMA allocator, which is also used by
> arm64 and csky.

When building for Sun-3:

kernel/dma/remap.o: In function `arch_dma_alloc':
remap.c:(.text+0x316): undefined reference to `__dma_direct_alloc_pages'
remap.c:(.text+0x32a): undefined reference to `arch_dma_prep_coherent'
remap.c:(.text+0x34e): undefined reference to `arch_dma_mmap_pgprot'
remap.c:(.text+0x378): undefined reference to `__dma_direct_free_pages'
remap.c:(.text+0x3f4): undefined reference to `arch_dma_prep_coherent'
remap.c:(.text+0x40a): undefined reference to `__dma_direct_alloc_pages'
kernel/dma/remap.o: In function `arch_dma_free':
remap.c:(.text+0x446): undefined reference to `__dma_direct_free_pages'
remap.c:(.text+0x4a8): undefined reference to `__dma_direct_free_pages'
kernel/dma/remap.o: In function `dma_atomic_pool_init':
remap.c:(.init.text+0x66): undefined reference to `arch_dma_prep_coherent'

Doing

-       select DMA_DIRECT_REMAP if MMU && !COLDFIRE
+       select DMA_DIRECT_REMAP if MMU && !COLDFIRE && !SUN3

in arch/m68k/Kconfig fixes the build.

Alternatively, you could use:

-       select DMA_DIRECT_REMAP if MMU && !COLDFIRE
+       select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
