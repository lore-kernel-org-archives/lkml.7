Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED9BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61374223EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfDPONY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:13:24 -0400
Received: from foss.arm.com ([217.140.101.70]:55996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfDPONX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:13:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06BE3EBD;
        Tue, 16 Apr 2019 07:13:23 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C8FF3F59C;
        Tue, 16 Apr 2019 07:13:18 -0700 (PDT)
Subject: Re: [PATCH 6/9] iommu/amd: Implement map_atomic
To:     Tom Murphy <tmurphy@arista.com>, iommu@lists.linux-foundation.org
Cc:     dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20190411184741.27540-1-tmurphy@arista.com>
 <20190411184741.27540-7-tmurphy@arista.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <78f2114b-0dcb-2dcf-c3b3-411e064b079f@arm.com>
Date:   Tue, 16 Apr 2019 15:13:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411184741.27540-7-tmurphy@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 19:47, Tom Murphy wrote:
> Instead of using a spin lock I removed the mutex lock from both the
> amd_iommu_map and amd_iommu_unmap path as well. iommu_map doesn’t lock
> while mapping and so if iommu_map is called by two different threads on
> the same iova region it results in a race condition even with the locks.
> So the locking in amd_iommu_map and amd_iommu_unmap doesn't add any real
> protection. The solution to this is for whatever manages the allocated
> iova’s externally to make sure iommu_map isn’t called twice on the same
> region at the same time.

Note that that assumption is not necessarily sufficient - even with 
correct address space management you can have cases like two threads 
mapping adjacent pages, where even thought they are targeting different 
PTEs they can race to install/modify intermediate levels of the 
pagetable. I believe AMD is actually OK in that regard, but some drivers 
*are* relying on locking for correctness so it can't just be 
unequivocally removed everywhere.

Robin.

> Signed-off-by: Tom Murphy <tmurphy@arista.com>
> ---
>   drivers/iommu/amd_iommu.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 2d4ee10626b4..b45e0e033adc 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3089,12 +3089,12 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
>   	return ret;
>   }
>   
> -static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
> -			 phys_addr_t paddr, size_t page_size, int iommu_prot)
> +static int __amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
> +			 phys_addr_t paddr, size_t page_size, int iommu_prot,
> +			 gfp_t gfp)
>   {
>   	struct protection_domain *domain = to_pdomain(dom);
>   	int prot = 0;
> -	int ret;
>   
>   	if (domain->mode == PAGE_MODE_NONE)
>   		return -EINVAL;
> @@ -3104,11 +3104,21 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
>   	if (iommu_prot & IOMMU_WRITE)
>   		prot |= IOMMU_PROT_IW;
>   
> -	mutex_lock(&domain->api_lock);
> -	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
> -	mutex_unlock(&domain->api_lock);
> +	return iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
> +}
>   
> -	return ret;
> +static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
> +			 phys_addr_t paddr, size_t page_size, int iommu_prot)
> +{
> +	return __amd_iommu_map(dom, iova, paddr, page_size, iommu_prot,
> +			GFP_KERNEL);
> +}
> +
> +static int amd_iommu_map_atomic(struct iommu_domain *dom, unsigned long iova,
> +			 phys_addr_t paddr, size_t page_size, int iommu_prot)
> +{
> +	return __amd_iommu_map(dom, iova, paddr, page_size, iommu_prot,
> +			GFP_ATOMIC);
>   }
>   
>   static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
> @@ -3262,6 +3272,7 @@ const struct iommu_ops amd_iommu_ops = {
>   	.attach_dev = amd_iommu_attach_device,
>   	.detach_dev = amd_iommu_detach_device,
>   	.map = amd_iommu_map,
> +	.map_atomic = amd_iommu_map_atomic,
>   	.unmap = amd_iommu_unmap,
>   	.iova_to_phys = amd_iommu_iova_to_phys,
>   	.add_device = amd_iommu_add_device,
> 
