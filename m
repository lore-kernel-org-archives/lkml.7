Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0364BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C994B2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564677858;
	bh=luxeEe+sNcMiUEJZddOmw2LCtZnw/7cP+2BTlvtj75g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cxef6gkd27ruJ/dnRHCPYTwGT3FCn043WiiLnenvWuAZcj6SpFK46cjuk4Og0lNTs
	 iw43Z/c90zNFdOrJZIw4kvT37BliLBMvsj2Zx1dvbKUscu4Fa6dGvf542UOWFEBHhC
	 t0M7ZwJlA7qnZsSklJzTHtdzdeBo/vK/jEmQHo8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbfHAQoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729082AbfHAQoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:44:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A272C20838;
        Thu,  1 Aug 2019 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564677856;
        bh=luxeEe+sNcMiUEJZddOmw2LCtZnw/7cP+2BTlvtj75g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1vCYTqrWNpzwy70+mDDkDyYbXSINihdTQt827ZNZ38BqrocpuTP/5twuQPWb+gghN
         +bl+z5TixFmhDdNjnDx+Eh8sSH8KshmaqVzUor7b7NSq1e0PiUUaxnmgdxPhdn1229
         Armf1YNDTLI9lVu8j9VV+a1Qdb+UMV3aZU2PBKDY=
Date:   Thu, 1 Aug 2019 17:44:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190801164411.kmsl4japtfkgvzxe@willie-the-truck>
References: <20190801142118.21225-1-hch@lst.de>
 <20190801142118.21225-2-hch@lst.de>
 <20190801162305.3m32chycsdjmdejk@willie-the-truck>
 <20190801163457.GB26588@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801163457.GB26588@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 06:34:57PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 01, 2019 at 05:23:06PM +0100, Will Deacon wrote:
> > > -	if (!dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_WRITE_COMBINE))
> > > -		return pgprot_writecombine(prot);
> > > -	return prot;
> > > +	return pgprot_writecombine(prot);
> > >  }
> > 
> > Seems like a sensible cleanup to me:
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > Although arch_dma_mmap_pgprot() is a bit of a misnomer now that it only
> > gets involved in the non-coherent case.
> 
> A better name is welcome.

How about arch_dma_noncoherent_mmap_pgprot() ? Too long?

> My other idea would be to just remove it entirely and do something like:
> 
> #ifndef pgprot_dmacoherent
> #define pgprot_dmacoherent pgprot_noncached
> #endif
> 
> pgprot_t dma_mmap_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
> {
> 	if (dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_NON_CONSISTENT))
> 		return prot;
> #ifdef pgprot_writecombine
> 	if (attrs & DMA_ATTR_WRITE_COMBINE)
> 		return pgprot_writecombine(prot);
> #endif
> 	return pgprot_dmacoherent(prot);
> }

Oh, I prefer that!

> But my worry is how this interacts with architectures that have an
> uncached segment (mips, nios2, microblaze, extensa) where we'd have
> the kernel access DMA_ATTR_WRITE_COMBINE mappigns using the uncached
> segment, and userspace mmaps using pgprot_writecombine, which could
> lead to aliasing issues.  But then again mips already supports
> DMA_ATTR_WRITE_COMBINE, so this must be ok somehow.  I guess I'll
> need to field that question to the relevant parties.

Or it's always been busted and happens to work out in practice...

Will
