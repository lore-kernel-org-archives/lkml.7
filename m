Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629A6C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B2F2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfECLo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:44:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfECLo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:44:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EBDF374;
        Fri,  3 May 2019 04:44:58 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA2A53F220;
        Fri,  3 May 2019 04:44:56 -0700 (PDT)
Date:   Fri, 3 May 2019 12:44:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/25] iommu/dma: Remove the flush_page callback
Message-ID: <20190503114454.GD55449@arrakis.emea.arm.com>
References: <20190430105214.24628-1-hch@lst.de>
 <20190430105214.24628-5-hch@lst.de>
 <20190503114335.GC55449@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503114335.GC55449@arrakis.emea.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 12:43:35PM +0100, Catalin Marinas wrote:
> On Tue, Apr 30, 2019 at 06:51:53AM -0400, Christoph Hellwig wrote:
> > We now have a arch_dma_prep_coherent architecture hook that is used
> > for the generic DMA remap allocator, and we should use the same
> > interface for the dma-iommu code.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  arch/arm64/mm/dma-mapping.c | 8 +-------
> >  drivers/iommu/dma-iommu.c   | 8 +++-----
> >  include/linux/dma-iommu.h   | 3 +--
> >  3 files changed, 5 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> > index 674860e3e478..10a8852c8b6a 100644
> > --- a/arch/arm64/mm/dma-mapping.c
> > +++ b/arch/arm64/mm/dma-mapping.c
> > @@ -104,12 +104,6 @@ arch_initcall(arm64_dma_init);
> >  #include <linux/platform_device.h>
> >  #include <linux/amba/bus.h>
> >  
> > -/* Thankfully, all cache ops are by VA so we can ignore phys here */
> > -static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
> > -{
> > -	__dma_flush_area(virt, PAGE_SIZE);
> > -}
> 
> Rather than removing, should this not become arch_dma_prep_coherent()?
> With patch 2 selecting the corresponding Kconfig option, I think with
> this patch you'd get a build error (haven't tried).

Ah, sorry, it was already there.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
