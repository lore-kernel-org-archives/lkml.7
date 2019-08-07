Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A57C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A9D2199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfHGGOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:14:06 -0400
Received: from verein.lst.de ([213.95.11.211]:34725 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfHGGOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:14:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 55DB268B05; Wed,  7 Aug 2019 08:14:02 +0200 (CEST)
Date:   Wed, 7 Aug 2019 08:14:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org,
        Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190807061402.GE6627@lst.de>
References: <20190801142118.21225-1-hch@lst.de> <20190801142118.21225-2-hch@lst.de> <20190801162305.3m32chycsdjmdejk@willie-the-truck> <20190801163457.GB26588@lst.de> <20190801164411.kmsl4japtfkgvzxe@willie-the-truck> <20190802081441.GA9725@lst.de> <20190802103803.3qrbhqwxlasojsco@willie-the-truck> <20190803064812.GA29746@lst.de> <20190806160854.htk67msiyadlrl4m@willie-the-truck> <20190806164503.GD1330@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190806164503.GD1330@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 05:45:03PM +0100, Russell King - ARM Linux admin wrote:
> We could have used a different approach, making all IO writes contain
> a "drain write buffer" instruction, and map DMA memory as "buffered",
> but as there were no Linux barriers defined to order memory accesses
> to DMA memory (so, for example, ring buffers can be updated in the
> correct order) back in those days, using the uncached/unbuffered mode
> was the sanest and most reliable solution.

Absolutely makes sense so far.

> > > The other really weird things is that in arm32
> > > pgprot_dmacoherent incudes the L_PTE_XN bit, which from my understanding
> > > is the no-execture bit, but pgprot_writecombine does not.  This seems to
> > > not very unintentional.  So minus that the whole DMA_ATTR_WRITE_COMBІNE
> > > seems to be about flagging old arm specific drivers as having the proper
> > > barriers in places and otherwise is a no-op.
> > 
> > I think it only matters for Armv7 CPUs, but yes, we should probably be
> > setting L_PTE_XN for both of these memory types.
> 
> Conventionally, pgprot_writecombine() has only been used to change
> the memory type and not the permissions.  Since writecombine memory
> is still capable of being executed, I don't see any reason to set XN
> for it.
> 
> If the user wishes to mmap() using PROT_READ|PROT_EXEC, then is there
> really a reason for writecombine to set XN overriding the user?
> 
> That said, pgprot_writecombine() is mostly used for framebuffers, which
> arguably shouldn't be executable anyway - but who'd want to mmap() the
> framebuffer with PROT_EXEC?

Well, I was mostly taking about DMA_ATTR_WRITE_COMBINE, which really
should include the NX bit even if pgprot_writecombine doesn't, right?

> > >  - make DMA_ATTR_WRITE_COMBINE a no-op and schedule it for removal,
> > >    thus removing the last instances of arch_dma_mmap_pgprot
> > 
> > All sounds good to me, although I suppose 32-bit Arm platforms without
> > CONFIG_ARM_DMA_MEM_BUFFERABLE may run into issues if DMA_ATTR_WRITE_COMBINE
> > disappears. Only one way to find out...
> 
> Looking at the results of grep, I think only OMAP2+ and Exynos may be
> affected.

As you mentioned later we also have the dma_alloc_wc wrapper, and a
single instance of dma_alloc_writecombine.

Exynos looks like purely ARM v7 from Kconfig, so it shouldn't even be
affected.

> However, removing writecombine support from the DMA API is going to
> have a huge impact for framebuffers on earlier ARMs - that's where we
> do expect framebuffers to be mapped "uncached/buffered" for performance
> reasons and not "uncached/unbuffered".  It's quite literally the
> difference between console scrolling being usable and totally unusable.
> 
> Given what I've said above, switching to using buffered mode for normal
> DMA mappings is data-corrupting risky - as in your filesystem could get
> fried.  I don't think we should play fast and loose with people's data
> by randomly changing that "because we'd like to", and I don't see that
> screwing the console is really an option either.

Oh well.   If we can't make dma_alloc_wc generally safe I fear we'll
have to keep it, but maybe literally limit it to the pre ARM v6
platforms.  While pretty much all callers seems platform specific,
there actually are a decent number that can only work on ARM v7 or
arm64.
