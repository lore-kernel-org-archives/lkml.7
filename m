Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C0FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9642086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406806AbfFKSAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:00:12 -0400
Received: from foss.arm.com ([217.140.110.172]:39386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406701AbfFKSAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:00:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCF44337;
        Tue, 11 Jun 2019 11:00:10 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A56C63F73C;
        Tue, 11 Jun 2019 11:00:09 -0700 (PDT)
Date:   Tue, 11 Jun 2019 19:00:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/2] arm64/mm: check cpu cache line size with
 non-coherent device
Message-ID: <20190611180007.him7md7gdcjs5cg6@mbp>
References: <20190611151731.6135-1-msys.mizuma@gmail.com>
 <20190611151731.6135-2-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611151731.6135-2-msys.mizuma@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:17:30AM -0400, Masayoshi Mizuma wrote:
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -91,10 +91,6 @@ static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
>  
>  static int __init arm64_dma_init(void)
>  {
> -	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
> -		   TAINT_CPU_OUT_OF_SPEC,
> -		   "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
> -		   ARCH_DMA_MINALIGN, cache_line_size());
>  	return dma_atomic_pool_init(GFP_DMA32, __pgprot(PROT_NORMAL_NC));
>  }
>  arch_initcall(arm64_dma_init);
> @@ -473,6 +469,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  			const struct iommu_ops *iommu, bool coherent)
>  {
>  	dev->dma_coherent = coherent;
> +
> +	if (!coherent && (cache_line_size() > ARCH_DMA_MINALIGN))
> +		dev_WARN(dev, "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
> +				ARCH_DMA_MINALIGN, cache_line_size());

I'm ok in principle with this patch, with the minor issue that since
commit 7b8c87b297a7 ("arm64: cacheinfo: Update cache_line_size detected
from DT or PPTT") queued for 5.3 cache_line_size() gets the information
from DT or ACPI. The reason for this change is that the information is
used for performance tuning rather than DMA coherency.

You can go for a direct cache_type_cwg() check in here, unless Robin
(cc'ed) has a better idea.

-- 
Catalin
