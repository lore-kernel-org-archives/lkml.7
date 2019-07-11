Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F51CC74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5896321537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfGKIvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:51:02 -0400
Received: from foss.arm.com ([217.140.110.172]:43448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfGKIvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:51:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3EDE2B;
        Thu, 11 Jul 2019 01:51:00 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12F223F59C;
        Thu, 11 Jul 2019 01:50:59 -0700 (PDT)
Subject: Re: [PATCH] kernel/dma: export dma_alloc_from_contiguous to modules
To:     miles.chen@mediatek.com, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org
References: <20190711053343.28873-1-miles.chen@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7d14b94f-454f-d512-bc8f-589f71bc07ea@arm.com>
Date:   Thu, 11 Jul 2019 09:50:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190711053343.28873-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2019 06:33, miles.chen@mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> This change exports dma_alloc_from_contiguous and
> dma_release_from_contiguous to modules.
> 
> Currently, we can add a reserve a memory node in dts files, make
> it a CMA memory by setting compatible = "shared-dma-pool",
> and setup the dev->cma_area by using of_reserved_mem_device_init_by_idx().
> 
> Export dma_alloc_from_contiguous and dma_release_from_contiguous, so we
> can allocate/free from/to dev->cma_area in kernel modules.

As far as I understand, this was never intended for drivers to call 
directly. If a device has its own private CMA area, then regular 
dma_alloc_attrs() should allocate from that automatically; if that's not 
happening already, then there's a bug somewhere.

Robin.

> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>   kernel/dma/contiguous.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index b2a87905846d..d5920bdedc77 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -197,6 +197,7 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
>   
>   	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
>   }
> +EXPORT_SYMBOL_GPL(dma_alloc_from_contiguous);
>   
>   /**
>    * dma_release_from_contiguous() - release allocated pages
> @@ -213,6 +214,7 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
>   {
>   	return cma_release(dev_get_cma_area(dev), pages, count);
>   }
> +EXPORT_SYMBOL_GPL(dma_release_from_contiguous);
>   
>   /*
>    * Support for reserved memory regions defined in device tree
> 
