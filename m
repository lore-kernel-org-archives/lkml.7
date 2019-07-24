Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DBBC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7E921926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfGXN5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:57:01 -0400
Received: from verein.lst.de ([213.95.11.211]:51214 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbfGXN5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:57:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D0A368B20; Wed, 24 Jul 2019 15:56:57 +0200 (CEST)
Date:   Wed, 24 Jul 2019 15:56:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        phil@raspberrypi.org, stefan.wahren@i2se.com, f.fainelli@gmail.com,
        mbrugger@suse.com, Jisheng.Zhang@synaptics.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/4] dma-direct: add dma_direct_min_mask
Message-ID: <20190724135657.GA9075@lst.de>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de> <20190717153135.15507-4-nsaenzjulienne@suse.de> <20190718091526.GA25321@lst.de> <13dd1a4f33fcf814545f0d93f18429e853de9eaf.camel@suse.de> <58753252bd7964e3b9e9558b633bd325c4a898a1.camel@suse.de> <20190724135124.GA44864@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724135124.GA44864@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 02:51:24PM +0100, Catalin Marinas wrote:
> I think it may be better if we have both ZONE_DMA and ZONE_DMA32 on
> arm64. ZONE_DMA would be based on the smallest dma-ranges as described
> in the DT while DMA32 covers the first naturally aligned 4GB of RAM
> (unchanged). When a smaller ZONE_DMA is not needed, it could be expanded
> to cover what would normally be ZONE_DMA32 (or could we have ZONE_DMA as
> 0-bytes? I don't think GFP_DMA can still allocate memory in this case).
> 
> We'd probably have to define ARCH_ZONE_DMA_BITS for arm64 to something
> smaller than 32-bit but sufficient to cover the known platforms like
> RPi4 (the current 24 is too small, so maybe 30). AFAICT,
> __dma_direct_optimal_gfp_mask() figures out whether GFP_DMA or GFP_DMA32
> should be passed.

ARCH_ZONE_DMA_BITS should probably become a variable.  That way we can
just initialize it to the default 24 bits in kernel/dma/direct.c and
allow architectures to override it in their early boot code.
