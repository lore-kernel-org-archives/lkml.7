Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0144ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9162320B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbfJJB24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 21:28:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:62021 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732157AbfJJB24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 21:28:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 18:28:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="218862856"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2019 18:28:52 -0700
Cc:     baolu.lu@linux.intel.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iommu/vt-d: Return the correct dma mask when we are
 bypassing the IOMMU
To:     Arvind Sankar <nivedita@alum.mit.edu>, linux-kernel@vger.kernel.org
References: <20191008143357.GA599223@rani.riverdale.lan>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <85123533-2e9c-af73-3014-782dd6f925cb@linux.intel.com>
Date:   Thu, 10 Oct 2019 09:26:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008143357.GA599223@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/8/19 10:33 PM, Arvind Sankar wrote:
> We must return a mask covering the full physical RAM when bypassing the
> IOMMU mapping. Also, in iommu_need_mapping, we need to check using
> dma_direct_get_required_mask to ensure that the device's dma_mask can
> cover physical RAM before deciding to bypass IOMMU mapping.
> 
> Fixes: 249baa547901 ("dma-mapping: provide a better default ->get_required_mask")
> Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
> Tested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Originally-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Fixed-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

This patch looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

> ---
>   drivers/iommu/intel-iommu.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3f974919d3bd..79e35b3180ac 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3471,7 +3471,7 @@ static bool iommu_need_mapping(struct device *dev)
>   		if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
>   			dma_mask = dev->coherent_dma_mask;
>   
> -		if (dma_mask >= dma_get_required_mask(dev))
> +		if (dma_mask >= dma_direct_get_required_mask(dev))
>   			return false;
>   
>   		/*
> @@ -3775,6 +3775,13 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
>   	return nelems;
>   }
>   
> +static u64 intel_get_required_mask(struct device *dev)
> +{
> +	if (!iommu_need_mapping(dev))
> +		return dma_direct_get_required_mask(dev);
> +	return DMA_BIT_MASK(32);
> +}
> +
>   static const struct dma_map_ops intel_dma_ops = {
>   	.alloc = intel_alloc_coherent,
>   	.free = intel_free_coherent,
> @@ -3787,6 +3794,7 @@ static const struct dma_map_ops intel_dma_ops = {
>   	.dma_supported = dma_direct_supported,
>   	.mmap = dma_common_mmap,
>   	.get_sgtable = dma_common_get_sgtable,
> +	.get_required_mask = intel_get_required_mask,
>   };
>   
>   static void
> 
