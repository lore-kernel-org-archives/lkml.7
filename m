Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78A8C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B883920679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbfHAQfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:35:03 -0400
Received: from verein.lst.de ([213.95.11.211]:44897 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHAQfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:35:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C7B8E68B20; Thu,  1 Aug 2019 18:34:57 +0200 (CEST)
Date:   Thu, 1 Aug 2019 18:34:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190801163457.GB26588@lst.de>
References: <20190801142118.21225-1-hch@lst.de> <20190801142118.21225-2-hch@lst.de> <20190801162305.3m32chycsdjmdejk@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801162305.3m32chycsdjmdejk@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 05:23:06PM +0100, Will Deacon wrote:
> > -	if (!dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_WRITE_COMBINE))
> > -		return pgprot_writecombine(prot);
> > -	return prot;
> > +	return pgprot_writecombine(prot);
> >  }
> 
> Seems like a sensible cleanup to me:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Although arch_dma_mmap_pgprot() is a bit of a misnomer now that it only
> gets involved in the non-coherent case.

A better name is welcome.  My other idea would be to just remove it
entirely and do something like:

#ifndef pgprot_dmacoherent
#define pgprot_dmacoherent pgprot_noncached
#endif

pgprot_t dma_mmap_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
{
	if (dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_NON_CONSISTENT))
		return prot;
#ifdef pgprot_writecombine
	if (attrs & DMA_ATTR_WRITE_COMBINE)
		return pgprot_writecombine(prot);
#endif
	return pgprot_dmacoherent(prot);
}

But my worry is how this interacts with architectures that have an
uncached segment (mips, nios2, microblaze, extensa) where we'd have
the kernel access DMA_ATTR_WRITE_COMBINE mappigns using the uncached
segment, and userspace mmaps using pgprot_writecombine, which could
lead to aliasing issues.  But then again mips already supports
DMA_ATTR_WRITE_COMBINE, so this must be ok somehow.  I guess I'll
need to field that question to the relevant parties.
