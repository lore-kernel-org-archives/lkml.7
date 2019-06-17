Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F5EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABEA20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfFQKp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:45:59 -0400
Received: from foss.arm.com ([217.140.110.172]:45086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfFQKp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:45:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F24BB344;
        Mon, 17 Jun 2019 03:45:58 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 122773F246;
        Mon, 17 Jun 2019 03:47:42 -0700 (PDT)
Date:   Mon, 17 Jun 2019 11:45:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhangshaokun <zhangshaokun@hisilicon.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>
Subject: Re: [PATCH v2] arm64/mm: Correct the cache line size warning with
 non coherent device
Message-ID: <20190617104555.GA1367@arrakis.emea.arm.com>
References: <20190614131141.4428-1-msys.mizuma@gmail.com>
 <aa445f8f-2576-4f78-a64e-1cde6a2f9593@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa445f8f-2576-4f78-a64e-1cde6a2f9593@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 10:44:33AM +0800, Zhangshaokun wrote:
> On 2019/6/14 21:11, Masayoshi Mizuma wrote:
> > diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
> > index 6eaf1c07aa4e..7fa6828bb488 100644
> > --- a/arch/arm64/kernel/cacheinfo.c
> > +++ b/arch/arm64/kernel/cacheinfo.c
> > @@ -19,12 +19,10 @@
> >  
> >  int cache_line_size(void)
> >  {
> > -	u32 cwg = cache_type_cwg();
> > -
> >  	if (coherency_max_size != 0)
> >  		return coherency_max_size;
> >  
> > -	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
> > +	return cache_line_size_of_cpu();
> >  }
> 
> How about simplify it as this?
> 
> int cache_line_size(void)
> {
>         return coherency_max_size ? coherency_max_size :
>                 cache_line_size_of_cpu();
> }

I don't see this as a simplification, easier to read with explicit 'if'.

> >  EXPORT_SYMBOL_GPL(cache_line_size);
> >  
> > diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> > index 1669618db08a..379589dc7113 100644
> > --- a/arch/arm64/mm/dma-mapping.c
> > +++ b/arch/arm64/mm/dma-mapping.c
> > @@ -38,10 +38,6 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
> >  
> >  static int __init arm64_dma_init(void)
> >  {
> > -	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
> > -		   TAINT_CPU_OUT_OF_SPEC,
> > -		   "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
> > -		   ARCH_DMA_MINALIGN, cache_line_size());
> >  	return dma_atomic_pool_init(GFP_DMA32, __pgprot(PROT_NORMAL_NC));
> >  }
> >  arch_initcall(arm64_dma_init);
> > @@ -56,7 +52,17 @@ void arch_teardown_dma_ops(struct device *dev)
> >  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >  			const struct iommu_ops *iommu, bool coherent)
> >  {
> > +	int cls = cache_line_size_of_cpu();
> 
> whether we need this local variable, how about use cache_line_size_of_cpu
> directly in WARN_TAINT just like before.

The reason being?

Anyway, I'll queue v2 of this patch as is for 5.3. Thanks.

-- 
Catalin
