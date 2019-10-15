Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B842C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C53A218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfJOLnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:43:35 -0400
Received: from foss.arm.com ([217.140.110.172]:36778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfJOLne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:43:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39529337;
        Tue, 15 Oct 2019 04:43:34 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A6F43F68E;
        Tue, 15 Oct 2019 04:43:33 -0700 (PDT)
Subject: Re: [PATCH] iommu: rockchip: Free domain on .domain_free
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Joerg Roedel <joro@8bytes.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
References: <20191002172923.22430-1-ezequiel@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <815abfca-a15f-365d-438c-5616a05b0513@arm.com>
Date:   Tue, 15 Oct 2019 12:43:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191002172923.22430-1-ezequiel@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2019 18:29, Ezequiel Garcia wrote:
> IOMMU domain resource life is well-defined, managed
> by .domain_alloc and .domain_free.
> 
> Therefore, domain-specific resources shouldn't be tied to
> the device life, but instead to its domain.

FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>   drivers/iommu/rockchip-iommu.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 26290f310f90..e845bd01a1a2 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -979,13 +979,13 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>   	if (!dma_dev)
>   		return NULL;
>   
> -	rk_domain = devm_kzalloc(dma_dev, sizeof(*rk_domain), GFP_KERNEL);
> +	rk_domain = kzalloc(sizeof(*rk_domain), GFP_KERNEL);
>   	if (!rk_domain)
>   		return NULL;
>   
>   	if (type == IOMMU_DOMAIN_DMA &&
>   	    iommu_get_dma_cookie(&rk_domain->domain))
> -		return NULL;
> +		goto err_free_domain;
>   
>   	/*
>   	 * rk32xx iommus use a 2 level pagetable.
> @@ -1020,6 +1020,8 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>   err_put_cookie:
>   	if (type == IOMMU_DOMAIN_DMA)
>   		iommu_put_dma_cookie(&rk_domain->domain);
> +err_free_domain:
> +	kfree(rk_domain);
>   
>   	return NULL;
>   }
> @@ -1048,6 +1050,7 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
>   
>   	if (domain->type == IOMMU_DOMAIN_DMA)
>   		iommu_put_dma_cookie(&rk_domain->domain);
> +	kfree(rk_domain);
>   }
>   
>   static int rk_iommu_add_device(struct device *dev)
> 
