Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3ECC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1218D208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389971AbfFMPy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:54:58 -0400
Received: from foss.arm.com ([217.140.110.172]:44042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732092AbfFMPyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:54:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E882367;
        Thu, 13 Jun 2019 08:54:54 -0700 (PDT)
Received: from C02TF0J2HF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81AD83F246;
        Thu, 13 Jun 2019 08:54:50 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:54:35 +0100
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
Message-ID: <20190613155434.GW28951@C02TF0J2HF1T.local>
References: <20190611151731.6135-1-msys.mizuma@gmail.com>
 <20190611151731.6135-2-msys.mizuma@gmail.com>
 <20190611180007.him7md7gdcjs5cg6@mbp>
 <20190611220246.lyhcqahsxyxuhqjk@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611220246.lyhcqahsxyxuhqjk@gabell>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 06:02:47PM -0400, Masayoshi Mizuma wrote:
> On Tue, Jun 11, 2019 at 07:00:07PM +0100, Catalin Marinas wrote:
> > On Tue, Jun 11, 2019 at 11:17:30AM -0400, Masayoshi Mizuma wrote:
> > > --- a/arch/arm64/mm/dma-mapping.c
> > > +++ b/arch/arm64/mm/dma-mapping.c
> > > @@ -91,10 +91,6 @@ static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
> > >  
> > >  static int __init arm64_dma_init(void)
> > >  {
> > > -	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
> > > -		   TAINT_CPU_OUT_OF_SPEC,
> > > -		   "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
> > > -		   ARCH_DMA_MINALIGN, cache_line_size());
> > >  	return dma_atomic_pool_init(GFP_DMA32, __pgprot(PROT_NORMAL_NC));
> > >  }
> > >  arch_initcall(arm64_dma_init);
> > > @@ -473,6 +469,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> > >  			const struct iommu_ops *iommu, bool coherent)
> > >  {
> > >  	dev->dma_coherent = coherent;
> > > +
> > > +	if (!coherent && (cache_line_size() > ARCH_DMA_MINALIGN))
> > > +		dev_WARN(dev, "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
> > > +				ARCH_DMA_MINALIGN, cache_line_size());
> > 
> > I'm ok in principle with this patch, with the minor issue that since
> > commit 7b8c87b297a7 ("arm64: cacheinfo: Update cache_line_size detected
> > from DT or PPTT") queued for 5.3 cache_line_size() gets the information
> > from DT or ACPI. The reason for this change is that the information is
> > used for performance tuning rather than DMA coherency.
> > 
> > You can go for a direct cache_type_cwg() check in here, unless Robin
> > (cc'ed) has a better idea.
> 
> Got it, thanks.
> I believe coherency_max_size is zero in case of coherent is false,
> so I'll modify the patch as following. Does it make sense?

The coherency_max_size gives you the largest cache line in the system,
independent of whether a device is coherent or not. You may have a
device that does not snoop L1/L2 but there is a transparent L3 (system
cache) with a larger cache line that the device may be able to snoop.
The coherency_max_size and therefore cache_line_size() would give you
this L3 value but the device would work fine since CWG <=
ARCH_DMA_MINALIGN.

> 
> @@ -57,6 +53,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>                         const struct iommu_ops *iommu, bool coherent)
>  {
>         dev->dma_coherent = coherent;
> +
> +       if (!coherent && (cache_line_size() > ARCH_DMA_MINALIGN))
> +               dev_WARN(dev, "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
> +                               ARCH_DMA_MINALIGN, (4 << cache_type_cwg()));
> +
>         if (iommu)
>                 iommu_setup_dma_ops(dev, dma_base, size);

I think the easiest here is to add a local variable:

	int cls = 4 << cache_type_cwg();

and check it against ARCH_DMA_MINALIGN.

-- 
Catalin
