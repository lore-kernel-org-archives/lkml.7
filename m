Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CDEC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 21:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE180216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 21:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfIHV1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 17:27:17 -0400
Received: from foss.arm.com ([217.140.110.172]:43278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfIHV1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 17:27:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C23C2337;
        Sun,  8 Sep 2019 14:27:16 -0700 (PDT)
Received: from huawei_p9_lite.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4243F67D;
        Sun,  8 Sep 2019 14:27:13 -0700 (PDT)
Date:   Sun, 8 Sep 2019 22:27:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     hch@lst.de, wahrenst@gmx.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Will Deacon <will@kernel.org>, f.fainelli@gmail.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        mbrugger@suse.com, linux-rpi-kernel@lists.infradead.org,
        phill@raspberrypi.org, m.szyprowski@samsung.com
Subject: Re: [PATCH v4 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
Message-ID: <20190908212711.GA84759@huawei_p9_lite.cambridge.arm.com>
References: <20190906120617.18836-1-nsaenzjulienne@suse.de>
 <20190906120617.18836-4-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906120617.18836-4-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 02:06:14PM +0200, Nicolas Saenz Julienne wrote:
> @@ -430,7 +454,7 @@ void __init arm64_memblock_init(void)
>  
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  
> -	dma_contiguous_reserve(arm64_dma32_phys_limit);
> +	dma_contiguous_reserve(arm64_dma_phys_limit ? : arm64_dma32_phys_limit);
>  }
>  
>  void __init bootmem_init(void)
> @@ -534,6 +558,7 @@ static void __init free_unused_memmap(void)
>  void __init mem_init(void)
>  {
>  	if (swiotlb_force == SWIOTLB_FORCE ||
> +	    max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT) ||
>  	    max_pfn > (arm64_dma32_phys_limit >> PAGE_SHIFT))
>  		swiotlb_init(1);

So here we want to initialise the swiotlb only if we need bounce
buffers. Prior to this patch, we assumed that swiotlb is needed if
max_pfn is beyond the reach of 32-bit devices. With ZONE_DMA, we need to
lower this limit to arm64_dma_phys_limit.

If ZONE_DMA is enabled, just comparing max_pfn with arm64_dma_phys_limit
is sufficient since the dma32 one limit always higher. However, if
ZONE_DMA is disabled, arm64_dma_phys_limit is 0, so we may initialise
swiotlb unnecessarily. I guess you need a similar check to the
dma_contiguous_reserve() above.

With that:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Unless there are other objections, I can queue this series for 5.5 in a
few weeks time (too late for 5.4).

-- 
Catalin
