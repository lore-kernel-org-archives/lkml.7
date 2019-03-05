Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD684C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42A62075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfCEGvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 01:51:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:37082 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfCEGvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 01:51:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 22:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,443,1544515200"; 
   d="scan'208";a="119677763"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2019 22:51:30 -0800
Cc:     baolu.lu@linux.intel.com, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iommu/vt-d: Allow IOMMU_DOMAIN_DMA and
 IOMMU_DOMAIN_IDENTITY to be allocated
To:     James Sewart <jamessewart@arista.com>,
        iommu@lists.linux-foundation.org
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <78df6013-bdcb-abfa-d86a-6460b17dc924@linux.intel.com>
Date:   Tue, 5 Mar 2019 14:46:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/4/19 11:46 PM, James Sewart wrote:
> Allowing IOMMU_DOMAIN_DMA type IOMMU domain to be allocated allows the
> default_domain of an iommu_group to be set. This delegates device-domain
> relationships to the generic IOMMU code.
> 
> Signed-off-by: James Sewart <jamessewart@arista.com>
> ---
>   drivers/iommu/intel-iommu.c | 113 +++++++++++++++++++++++++++---------
>   1 file changed, 84 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 8e0a4e2ff77f..71cd6bbfec05 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -309,6 +309,14 @@ static int hw_pass_through = 1;
>   /* si_domain contains mulitple devices */
>   #define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
>   
> +/* Domain managed externally, don't cleanup if it isn't attached
> + * to any devices. */
> +#define DOMAIN_FLAG_MANAGED_EXTERNALLY	(1 << 2)
> +
> +/* Set after domain initialisation. Used when allocating dma domains to
> + * defer domain initialisation until it is attached to a device */
> +#define DOMAIN_FLAG_INITIALISED	(1 << 4)

Why do you skip bit 3?

> +
>   #define for_each_domain_iommu(idx, domain)			\
>   	for (idx = 0; idx < g_num_of_iommus; idx++)		\
>   		if (domain->iommu_refcnt[idx])
> @@ -558,6 +566,16 @@ static inline int domain_type_is_vm_or_si(struct dmar_domain *domain)
>   				DOMAIN_FLAG_STATIC_IDENTITY);
>   }
>   
> +static inline int domain_managed_externally(struct dmar_domain *domain)
> +{
> +	return domain->flags & DOMAIN_FLAG_MANAGED_EXTERNALLY;
> +}
> +
> +static inline int domain_is_initialised(struct dmar_domain *domain)
> +{
> +	return domain->flags & DOMAIN_FLAG_INITIALISED;
> +}
> +
>   static inline int domain_pfn_supported(struct dmar_domain *domain,
>   				       unsigned long pfn)
>   {
> @@ -1662,7 +1680,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>   
>   		__dmar_remove_one_dev_info(info);
>   
> -		if (!domain_type_is_vm_or_si(domain)) {
> +		if (!domain_managed_externally(domain)) {
>   			/*
>   			 * The domain_exit() function  can't be called under
>   			 * device_domain_lock, as it takes this lock itself.
> @@ -1895,6 +1913,7 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>   	domain->pgd = (struct dma_pte *)alloc_pgtable_page(domain->nid);
>   	if (!domain->pgd)
>   		return -ENOMEM;
> +	domain->flags |= DOMAIN_FLAG_INITIALISED;
>   	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
>   	return 0;
>   }
> @@ -2807,14 +2826,10 @@ static inline void iommu_prepare_isa(void)
>   
>   static int md_domain_init(struct dmar_domain *domain, int guest_width);
>   
> -static int __init si_domain_init(int hw)
> +static int __init si_domain_init(struct dmar_domain *si_domain, int hw)
>   {
>   	int nid, ret = 0;
>   
> -	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
> -	if (!si_domain)
> -		return -EFAULT;
> -
>   	if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
>   		domain_exit(si_domain);
>   		return -EFAULT;
> @@ -3417,9 +3432,16 @@ static int __init init_dmars(void)
>   	check_tylersburg_isoch();
>   
>   	if (iommu_identity_mapping) {
> -		ret = si_domain_init(hw_pass_through);
> -		if (ret)
> +		si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);

Where will this si_domain be used? We still need to keep the global
si_domain?

> +		if (!si_domain) {
> +			ret = -EFAULT;
>   			goto free_iommu;
> +		}
> +		ret = si_domain_init(si_domain, hw_pass_through);
> +		if (ret) {
> +			domain_exit(si_domain);
> +			goto free_iommu;
> +		}
>   	}
>   
>   
> @@ -4575,7 +4597,7 @@ static int device_notifier(struct notifier_block *nb,
>   		return 0;
>   
>   	dmar_remove_one_dev_info(domain, dev);
> -	if (!domain_type_is_vm_or_si(domain) && list_empty(&domain->devices))
> +	if (!domain_managed_externally(domain) && list_empty(&domain->devices))
>   		domain_exit(domain);
>   
>   	return 0;
> @@ -5020,6 +5042,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
>   	domain->pgd = (struct dma_pte *)alloc_pgtable_page(domain->nid);
>   	if (!domain->pgd)
>   		return -ENOMEM;
> +	domain->flags |= DOMAIN_FLAG_INITIALISED;
>   	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
>   	return 0;
>   }
> @@ -5028,28 +5051,54 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>   {
>   	struct dmar_domain *dmar_domain;
>   	struct iommu_domain *domain;
> +	int flags = DOMAIN_FLAG_MANAGED_EXTERNALLY;
>   
> -	if (type != IOMMU_DOMAIN_UNMANAGED)
> -		return NULL;
> -
> -	dmar_domain = alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
> -	if (!dmar_domain) {
> -		pr_err("Can't allocate dmar_domain\n");
> -		return NULL;
> -	}
> -	if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
> -		pr_err("Domain initialization failed\n");
> -		domain_exit(dmar_domain);
> +	switch (type) {
> +	case IOMMU_DOMAIN_UNMANAGED:
> +		flags |= DOMAIN_FLAG_VIRTUAL_MACHINE | DOMAIN_FLAG_INITIALISED;
> +		dmar_domain = alloc_domain(flags);
> +		if (!dmar_domain) {
> +			pr_err("Can't allocate dmar_domain\n");
> +			return NULL;
> +		}
> +		if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
> +			pr_err("Domain initialization failed\n");
> +			domain_exit(dmar_domain);
> +			return NULL;
> +		}
> +		domain_update_iommu_cap(dmar_domain);
> +		domain = &dmar_domain->domain;
> +		domain->geometry.aperture_start = 0;
> +		domain->geometry.aperture_end   = __DOMAIN_MAX_ADDR(dmar_domain->gaw);
> +		domain->geometry.force_aperture = true;
> +		break;
> +	case IOMMU_DOMAIN_DMA:
> +		dmar_domain = alloc_domain(flags);
> +		if (!dmar_domain) {
> +			pr_err("Can't allocate dmar_domain\n");

Not necessary for memory allocation failure.

> +			return NULL;
> +		}
> +		// init domain in device attach when we know IOMMU capabilities

Use /* */ for comments, please.

> +		break;
> +	case IOMMU_DOMAIN_IDENTITY:
> +		flags |= DOMAIN_FLAG_STATIC_IDENTITY | DOMAIN_FLAG_INITIALISED;
> +		dmar_domain = alloc_domain(flags);
> +		if (!dmar_domain) {
> +			pr_err("Can't allocate dmar_domain\n");
> +			return NULL;
> +		}
> +		if (si_domain_init(dmar_domain, 0)) {
> +			pr_err("Domain initialization failed\n");
> +			domain_exit(dmar_domain);
> +			return NULL;
> +		}
> +		break;

How about moving si domain allocation into a separated patch? There are
two significant changes here, so it worth a new patch for discussion.

1) a shared single si domain vs. per group si domain;
2) previously vt-d drivers determines what kind of devices should use
    identity domain; Now, it turns to iommu generic layer, behavior will
    be changed.

> +	default:
>   		return NULL;
>   	}
> -	domain_update_iommu_cap(dmar_domain);
> -
> -	domain = &dmar_domain->domain;
> -	domain->geometry.aperture_start = 0;
> -	domain->geometry.aperture_end   = __DOMAIN_MAX_ADDR(dmar_domain->gaw);
> -	domain->geometry.force_aperture = true;
>   
> -	return domain;
> +	dmar_domain->domain.type = type;

Is it necessary to set this?

> +	return &dmar_domain->domain;
>   }
>   
>   static void intel_iommu_domain_free(struct iommu_domain *domain)
> @@ -5080,8 +5129,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>   			dmar_remove_one_dev_info(old_domain, dev);
>   			rcu_read_unlock();
>   
> -			if (!domain_type_is_vm_or_si(old_domain) &&
> -			     list_empty(&old_domain->devices))
> +			if (list_empty(&old_domain->devices) &&
> +			     !domain_managed_externally(old_domain))
>   				domain_exit(old_domain);
>   		}
>   	}
> @@ -5090,6 +5139,12 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>   	if (!iommu)
>   		return -ENODEV;
>   
> +	// Initialise domain with IOMMU capabilities if it isn't already initialised

Ditto.

> +	if (!domain_is_initialised(dmar_domain)) {
> +		if (domain_init(dmar_domain, iommu, DEFAULT_DOMAIN_ADDRESS_WIDTH))
> +			return -ENOMEM;
> +	}

Each domain, not matter the DMA domain or UNMANAGED domain, is allocated
first and then gets initialized during device attaching, right? If so,
why do we need to have a special DOMAIN_FLAG_INITIALISED flag for DMA
domains?

> +
>   	/* check if this iommu agaw is sufficient for max mapped address */
>   	addr_width = agaw_to_width(iommu->agaw);
>   	if (addr_width > cap_mgaw(iommu->cap))
> 

Best regards,
Lu Baolu
