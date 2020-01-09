Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C9C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E8920673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbgAIOtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:49:23 -0500
Received: from verein.lst.de ([213.95.11.211]:55076 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbgAIOtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:49:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9ECB268BFE; Thu,  9 Jan 2020 15:49:20 +0100 (CET)
Date:   Thu, 9 Jan 2020 15:49:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Christoph Hellwig <hch@lst.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/2] arm: use swiotlb for bounce buffer on LPAE configs
Message-ID: <20200109144920.GB22907@lst.de>
References: <20190709142011.24984-1-hch@lst.de> <20190709142011.24984-3-hch@lst.de> <9bbd87c2-5b6c-069c-dd22-5105dc827428@ti.com> <20191219150259.GA3003@lst.de> <20106a84-8247-fa78-2381-2c94fad9cb6a@ti.com> <eca457b6-c685-59ac-1dec-5b28e4430e1d@ti.com> <d3921764-840c-4d1c-f240-b974b9b83ec8@arm.com> <27450c0e-c8aa-d59b-aa32-37f23c232eb7@ti.com> <0e6decce-c54e-9791-473e-0aef05650f39@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6decce-c54e-9791-473e-0aef05650f39@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 03:20:07PM +0000, Robin Murphy wrote:
>> The problem - I think - is that the DMA_BIT_MASK(32) from
>> dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32)) is treated as physical
>> address along the call path so the dma_pfn_offset is applied to it and
>> the check will fail, saying that DMA_BIT_MASK(32) can not be supported.
>
> But that's the thing - in isolation, that is entirely correct. Considering 
> ZONE_DMA32 for simplicity, in general the zone is expected to cover the 
> physical address range 0x0000_0000 - 0xffff_ffff (because DMA offsets are 
> relatively rare), and a device with a dma_pfn_offset of more than 
> (0x1_0000_0000 >> PAGE_SHIFT) *cannot* support that range with any mask, 
> because the DMA address itself would have to be negative.

Note that ZONE_DMA32 is irrelevant in this particular case, as we are
talking about arm32.  But with ZONE_DMA instead this roughly makes sense.

> The problem is that platforms with esoteric memory maps have no right thing 
> to do. If the base of RAM is at at 0x1_0000_0000 or higher, the "correct" 
> ZONE_DMA32 would be empty while ZONE_NORMAL above it would not, and last 
> time I looked that makes the page allocator break badly. So the standard 
> bodge on such platforms is to make ZONE_DMA32 cover not the first 4GB of 
> *PA space*, but the first 4GB of *RAM*, wherever that happens to be. That 
> then brings different problems - now the page allocator is happy and 
> successfully returns GFP_DMA32 allocations from the range 0x8_0000_0000 - 
> 0x8_ffff_ffff that are utterly useless to 32-bit devices with zero 
> dma_pfn_offset - see the AMD Seattle SoC for the prime example of that. If 
> on the other hand all devices are guaranteed to have a dma_pfn_offset that 
> puts the base of RAM at DMA address 0 then GFP_DMA32 allocations do end up 
> working as expected, but now the original assumption of where ZONE_DMA32 
> actually is is broken, so generic code unaware of the 
> platform/architecture-specific bodge will be misled - that's the case 
> you're running into.
>
> Having thought this far, if there's a non-hacky way to reach in and grab 
> ZONE_DMA{32} such that dma_direct_supported() could use zone_end_pfn() 
> instead of trying to assume either way, that might be the most robust 
> general solution.

zone_dma_bits is our somewhat ugly way to try to poke into this
information, although the way it is done right now sucks pretty badly.

The patch I sent to Peter in December was trying to convey that
information in a way similar to what the arm32 legacy dma code does, but
it didn't work, so I'll need to find some time to sit down and figure out
why.
