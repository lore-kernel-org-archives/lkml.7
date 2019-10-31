Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F95ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441892087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfJaP5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:57:54 -0400
Received: from verein.lst.de ([213.95.11.211]:51760 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbfJaP5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:57:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F39B68BE1; Thu, 31 Oct 2019 16:57:50 +0100 (CET)
Date:   Thu, 31 Oct 2019 16:57:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] dma/direct: turn ARCH_ZONE_DMA_BITS into a variable
Message-ID: <20191031155750.GA7394@lst.de>
References: <20191031152837.15253-1-nsaenzjulienne@suse.de> <20191031154759.GA7162@lst.de> <40d06d463c05d36968e8b64924d78f7794f8de50.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d06d463c05d36968e8b64924d78f7794f8de50.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 04:53:13PM +0100, Nicolas Saenz Julienne wrote:
> > > +#define ARM64_ZONE_DMA_BITS	30
> > > +
> > >  /*
> > >   * We need to be able to catch inadvertent references to memstart_addr
> > >   * that occur (potentially in generic code) before arm64_memblock_init()
> > > @@ -424,6 +427,8 @@ void __init arm64_memblock_init(void)
> > >  	else
> > >  		arm64_dma_phys_limit = PHYS_MASK + 1;
> > >  
> > > +	zone_dma_bits = ARM64_ZONE_DMA_BITS;
> > > +
> > >  	reserve_crashkernel();
> > 
> > This actually adds a new limit, as there wasn't one before for arm64.
> 
> Well, as zone_dma_bits is only relevant in dma/direct when ZONE_DMA is defined
> I figured it doesn't matter if the variable is set conditionally to ZONE_DMA or
> not.

I'd much prefer that to do separately.
