Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C7CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351A020651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfHSOZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:25:22 -0400
Received: from verein.lst.de ([213.95.11.211]:48105 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfHSOZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:25:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B1550227A81; Mon, 19 Aug 2019 16:25:16 +0200 (CEST)
Date:   Mon, 19 Aug 2019 16:25:16 +0200
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
Message-ID: <20190819142516.GA6366@lst.de>
References: <20190808160005.10325-1-hch@lst.de> <20190808160005.10325-8-hch@lst.de> <1565861152.2963.7.camel@HansenPartnership.com> <20190815105002.GA30805@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815105002.GA30805@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does my explanation from Thursday make sense or is it completely
off?  Does the patch description need some update to be less
confusing to those used to different terminology?

On Thu, Aug 15, 2019 at 12:50:02PM +0200, Christoph Hellwig wrote:
> Except for the different naming scheme vs the code this matches my
> assumptions.
> 
> In the code we have three cases (and a fourth EISA case mention in
> comments, but not actually implemented as far as I can tell):
> 
> arch/parisc/kernel/pci-dma.c says in the top of file comments:
> 
> ** AFAIK, all PA7100LC and PA7300LC platforms can use this code.
> 
> and the handles two different case.  for cpu_type == pcxl or pcxl2
> it maps the memory as uncached for dma_alloc_coherent, and for all
> other cpu types it fails the coherent allocations.
> 
> In addition to that there are the ccio and sba iommu drivers, of which
> according to your above comment one is always present for pa8xxx.
> 
> Which brings us back to this patch, which ensures that no cacheable
> memory is exported to userspace by removing ->mmap from ccio and sba.
> It then enabled dma_mmap_coherent for the pcxl or pcxl2 case that
> allocates uncached memory, which dma_mmap_coherent does not work
> because dma_alloc_coherent already failed for the !pcxl && !pcxl2
> and thus there is no memory to mmap.
> 
> So if the description is too confusing please suggest a better
> one, I'm a little lost between all these code names and product
> names (arch/parisc/include/asm/dma-mapping.h uses yet another set).
---end quoted text---
