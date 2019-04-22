Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F04C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C8420B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfDVSLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:11:21 -0400
Received: from verein.lst.de ([213.95.11.211]:41053 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbfDVSLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:11:20 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1434668AFE; Mon, 22 Apr 2019 20:11:01 +0200 (CEST)
Date:   Mon, 22 Apr 2019 20:11:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     laurentiu.tudor@nxp.com
Cc:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] dma-mapping: create iommu mapping for newly
 allocated dma coherent mem
Message-ID: <20190422181100.GB32490@lst.de>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 07:51:25PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> If possible / available call into the DMA API to get a proper iommu
> mapping and a dma address for the newly allocated coherent dma memory.

I don't think this is so simple.  The original use case of
dma_declare_coherent_memory was memory that is local to a device, where
we copy in data through a MMIO mapping and the device can then access
it.  This use case still seems to be alive in the ohci-sm501 and
ohci-tmio drivers.  Going through the iommu in those cases would be
counter productive.

The other use cases, including the OF ones seem to be (and Marek who
added that support should correct me if I'm wrong) normal host DRAM
that is just set aside for the device.

So if we want to support these prealloc pools with an iommu we need to
split the use cases.  I have to say I really hate the way we do the DMA
"coherent" allocations, so I'm all in favor of that, it just hasn't
bubbled up towards the front of my todo list yet.

My highlevel plan here would be:

 a) move the two OHCI drivers away from our current DMA declare
    coherent code, and just use a trivial genalloc allocator for
    their MMIO space, given that the USB layer already wraps the
    dma_alloc/free APIs anyway
 b) move the rest of the DMA coherent stuff into the actual dma
    map ops, similar to how we handle CMA allocations.  In fact
    we should probably do this by a new page allocation helper
    that tries CMA, "coherent" or the page allocator as fallback
 b) also merge the OF-side handling of CMA vs "coherent" into a
    single implementation.  Preferably dropping the misleading
    "coherent" name while we are at it.
