Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F6DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF78F208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfE2KMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:12:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42626 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2KMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:12:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F789341;
        Wed, 29 May 2019 03:12:20 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FCBC3F59C;
        Wed, 29 May 2019 03:12:18 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Fix condition check in iommu_dma_unmap_sg
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
References: <20190529081532.73585-1-natechancellor@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e8c21972-cb70-34ff-949d-5e2555c3a1fb@arm.com>
Date:   Wed, 29 May 2019 11:12:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529081532.73585-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2019 09:15, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/iommu/dma-iommu.c:897:6: warning: logical not is only applied to
> the left hand side of this comparison [-Wlogical-not-parentheses]
>          if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>              ^                                 ~~
> drivers/iommu/dma-iommu.c:897:6: note: add parentheses after the '!' to
> evaluate the comparison first
>          if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>              ^
>               (                                    )
> drivers/iommu/dma-iommu.c:897:6: note: add parentheses around left hand
> side expression to silence this warning
>          if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>              ^
>              (                                )
> 1 warning generated.
> 
> Judging from the rest of the commit and the conditional in
> iommu_dma_map_sg, either
> 
>      if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> 
> or
>      if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> 
> was intended, not a combination of the two.
> 
> I personally think that the former is easier to understand so use that.

Good catch, thanks Nathan. Looks like this was an unintentional mangling 
while ratifying the couple of odd "x == 0" instances to "!x" in the 
move. The effective double-negation is not what we want at all.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 06d60728ff5c ("iommu/dma: move the arm64 wrappers to common code")
> Link: https://github.com/ClangBuiltLinux/linux/issues/497
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   drivers/iommu/dma-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 0cd49c2d3770..0dee374fc64a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -894,7 +894,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	struct scatterlist *tmp;
>   	int i;
>   
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
>   
>   	/*
> 
