Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31868C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065FA2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfFQQWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:22:37 -0400
Received: from foss.arm.com ([217.140.110.172]:55450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfFQQWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:22:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F004A28;
        Mon, 17 Jun 2019 09:22:36 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B69B33F718;
        Mon, 17 Jun 2019 09:22:35 -0700 (PDT)
Date:   Mon, 17 Jun 2019 17:22:33 +0100
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
Message-ID: <20190617162233.GB34565@arrakis.emea.arm.com>
References: <20190614131141.4428-1-msys.mizuma@gmail.com>
 <aa445f8f-2576-4f78-a64e-1cde6a2f9593@hisilicon.com>
 <20190617104555.GA1367@arrakis.emea.arm.com>
 <7e567399-6f3d-b416-6636-c9f2f37ea407@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e567399-6f3d-b416-6636-c9f2f37ea407@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 07:00:34PM +0800, Zhangshaokun wrote:
> On 2019/6/17 18:45, Catalin Marinas wrote:
> > On Sat, Jun 15, 2019 at 10:44:33AM +0800, Zhangshaokun wrote:
> >> On 2019/6/14 21:11, Masayoshi Mizuma wrote:
> >>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> >>> index 1669618db08a..379589dc7113 100644
> >>> --- a/arch/arm64/mm/dma-mapping.c
> >>> +++ b/arch/arm64/mm/dma-mapping.c
> >>> @@ -38,10 +38,6 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
> >>>  
> >>>  static int __init arm64_dma_init(void)
> >>>  {
> >>> -	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
> >>> -		   TAINT_CPU_OUT_OF_SPEC,
> >>> -		   "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
> >>> -		   ARCH_DMA_MINALIGN, cache_line_size());
> >>>  	return dma_atomic_pool_init(GFP_DMA32, __pgprot(PROT_NORMAL_NC));
> >>>  }
> >>>  arch_initcall(arm64_dma_init);
> >>> @@ -56,7 +52,17 @@ void arch_teardown_dma_ops(struct device *dev)
> >>>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >>>  			const struct iommu_ops *iommu, bool coherent)
> >>>  {
> >>> +	int cls = cache_line_size_of_cpu();
> >>
> >> whether we need this local variable, how about use cache_line_size_of_cpu
> >> directly in WARN_TAINT just like before.
> > 
> > The reason being?
> 
> Since it is inline function,  maybe it is unnecessary, it is trivial.

OTOH, you end up with two reads from the CTR_EL0 register.

-- 
Catalin
