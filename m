Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC701C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A86C208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfHOKuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 06:50:10 -0400
Received: from verein.lst.de ([213.95.11.211]:45603 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730969AbfHOKuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:50:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9FC9468AFE; Thu, 15 Aug 2019 12:50:03 +0200 (CEST)
Date:   Thu, 15 Aug 2019 12:50:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Takashi Iwai <tiwai@suse.de>, Helge Deller <deller@gmx.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] parisc: don't set ARCH_NO_COHERENT_DMA_MMAP
Message-ID: <20190815105002.GA30805@lst.de>
References: <20190808160005.10325-1-hch@lst.de> <20190808160005.10325-8-hch@lst.de> <1565861152.2963.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565861152.2963.7.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:25:52AM +0100, James Bottomley wrote:
> >  which means exporting normally cachable memory to userspace is
> > relatively dangrous due to cache aliasing.
> > 
> > But normally cachable memory is only allocated by dma_alloc_coherent
> > on parisc when using the sba_iommu or ccio_iommu drivers, so just
> > remove the .mmap implementation for them so that we don't have to set
> > ARCH_NO_COHERENT_DMA_MMAP, which I plan to get rid of.
> 
> So I don't think this is quite right.  We have three architectural
> variants essentially (hidden behind about 12 cpu types):
> 
>    1. pa70xx: These can't turn off page caching, so they were the non
>       coherent problem case
>    2. pa71xx: These can manufacture coherent memory simply by turning off
>       the cache on a per page basis
>    3. pa8xxx: these have a full cache flush coherence mechanism.
> 
> (I might have this slightly wrong: I vaguely remember the pa71xxlc
> variants have some weird cache quirks for DMA as well)
> 
> So I think pa70xx we can't mmap.  pa71xx we can provided we mark the
> page as uncached ... which should already have happened in the allocate
> and pa8xxx which can always mmap dma memory without any special tricks.

Except for the different naming scheme vs the code this matches my
assumptions.

In the code we have three cases (and a fourth EISA case mention in
comments, but not actually implemented as far as I can tell):

arch/parisc/kernel/pci-dma.c says in the top of file comments:

** AFAIK, all PA7100LC and PA7300LC platforms can use this code.

and the handles two different case.  for cpu_type == pcxl or pcxl2
it maps the memory as uncached for dma_alloc_coherent, and for all
other cpu types it fails the coherent allocations.

In addition to that there are the ccio and sba iommu drivers, of which
according to your above comment one is always present for pa8xxx.

Which brings us back to this patch, which ensures that no cacheable
memory is exported to userspace by removing ->mmap from ccio and sba.
It then enabled dma_mmap_coherent for the pcxl or pcxl2 case that
allocates uncached memory, which dma_mmap_coherent does not work
because dma_alloc_coherent already failed for the !pcxl && !pcxl2
and thus there is no memory to mmap.

So if the description is too confusing please suggest a better
one, I'm a little lost between all these code names and product
names (arch/parisc/include/asm/dma-mapping.h uses yet another set).
