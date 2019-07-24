Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969A1C41517
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F6C2199C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfGXNv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:51:29 -0400
Received: from foss.arm.com ([217.140.110.172]:41254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfGXNv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:51:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21F7B28;
        Wed, 24 Jul 2019 06:51:28 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7116C3F71A;
        Wed, 24 Jul 2019 06:51:26 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:51:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        phil@raspberrypi.org, stefan.wahren@i2se.com, f.fainelli@gmail.com,
        mbrugger@suse.com, Jisheng.Zhang@synaptics.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/4] dma-direct: add dma_direct_min_mask
Message-ID: <20190724135124.GA44864@arrakis.emea.arm.com>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de>
 <20190717153135.15507-4-nsaenzjulienne@suse.de>
 <20190718091526.GA25321@lst.de>
 <13dd1a4f33fcf814545f0d93f18429e853de9eaf.camel@suse.de>
 <58753252bd7964e3b9e9558b633bd325c4a898a1.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58753252bd7964e3b9e9558b633bd325c4a898a1.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 03:08:52PM +0200, Nicolas Saenz Julienne wrote:
> On Thu, 2019-07-18 at 13:18 +0200, Nicolas Saenz Julienne wrote:
> > On Thu, 2019-07-18 at 11:15 +0200, Christoph Hellwig wrote:
> > > On Wed, Jul 17, 2019 at 05:31:34PM +0200, Nicolas Saenz Julienne wrote:
> > > > Historically devices with ZONE_DMA32 have been assumed to be able to
> > > > address at least the lower 4GB of ram for DMA. This is still the defualt
> > > > behavior yet the Raspberry Pi 4 is limited to the first GB of memory.
> > > > This has been observed to trigger failures in dma_direct_supported() as
> > > > the 'min_mask' isn't properly set.
> > > > 
> > > > We create 'dma_direct_min_mask' in order for the arch init code to be
> > > > able to fine-tune dma direct's 'min_dma' mask.
> > > 
> > > Normally we use ZONE_DMA for that case.
> > 
> > Fair enough, I didn't think of that possibility.
> > 
> > So would the arm64 maintainers be happy with something like this:
> > 
> > - ZONE_DMA: Follows standard definition, 16MB in size. ARCH_ZONE_DMA_BITS is
> > 	    left as is.
> > - ZONE_DMA32: Will honor the most constraining 'dma-ranges'. Which so far for
> > 	      most devices is 4G, except for RPi4.
> > - ZONE_NORMAL: The rest of the memory.
> 
> Never mind this suggestion, I don't think it makes any sense. If anything arm64
> seems to fit the ZONE_DMA usage pattern of arm and powerpc: where ZONE_DMA's
> size is decided based on ram size and/or board configuration. It was actually
> set-up like this until Christoph's ad67f5a6545f7 ("arm64: replace ZONE_DMA with
> ZONE_DMA32").
> 
> So the easy solution would be to simply revert that commit. On one hand I feel
> it would be a step backwards as most 64 bit architectures have been moving to
> use ZONE_DMA32. On the other, current ZONE_DMA32 usage seems to be heavily
> rooted on having a 32 bit DMA mask*, which will no longer be the case on arm64
> if we want to support the RPi 4.
> 
> So the way I see it and lacking a better solution, the argument is stronger on
> moving back arm64 to using ZONE_DMA. Any comments/opinions?

As it was suggested in this or the previous thread, I'm not keen on
limiting ZONE_DMA32 to the smalles RPi4 can cover, as the naming
implies this zone should cover 32-bit devices that can deal with a full
32-bit mask.

I think it may be better if we have both ZONE_DMA and ZONE_DMA32 on
arm64. ZONE_DMA would be based on the smallest dma-ranges as described
in the DT while DMA32 covers the first naturally aligned 4GB of RAM
(unchanged). When a smaller ZONE_DMA is not needed, it could be expanded
to cover what would normally be ZONE_DMA32 (or could we have ZONE_DMA as
0-bytes? I don't think GFP_DMA can still allocate memory in this case).

We'd probably have to define ARCH_ZONE_DMA_BITS for arm64 to something
smaller than 32-bit but sufficient to cover the known platforms like
RPi4 (the current 24 is too small, so maybe 30). AFAICT,
__dma_direct_optimal_gfp_mask() figures out whether GFP_DMA or GFP_DMA32
should be passed.

-- 
Catalin
