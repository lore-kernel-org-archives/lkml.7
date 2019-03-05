Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF18C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6612082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfCEHFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:05:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:14072 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfCEHFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:05:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 23:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,443,1544515200"; 
   d="scan'208";a="119680591"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2019 23:05:02 -0800
Cc:     baolu.lu@linux.intel.com, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
To:     James Sewart <jamessewart@arista.com>,
        iommu@lists.linux-foundation.org
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
 <7F6B5F6A-EC76-4A9F-8EB6-AEAB9994D91A@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fdd74d83-acd4-23da-6c0c-b52573d999bb@linux.intel.com>
Date:   Tue, 5 Mar 2019 14:59:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7F6B5F6A-EC76-4A9F-8EB6-AEAB9994D91A@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It's hard for me to understand why do we remove the rmrr related
code in this patch.

And, now we have two places to hold a domain for a device: group and
dev->info. We can consider to optimize the use of per device iommu
arch data. This should be later work anyway.

More comments inline.

On 3/4/19 11:47 PM, James Sewart wrote:
> The generic IOMMU code will allocate and attach a dma ops domain to each
> device that comes online, replacing any lazy allocated domain. Removes
> RMRR application at iommu init time as we won't have a domain attached
> to any device. iommu.c will do this after attaching a device using
> create_direct_mappings.
> 
> Signed-off-by: James Sewart <jamessewart@arista.com>
> ---
>   drivers/iommu/intel-iommu.c | 202 ++----------------------------------
>   1 file changed, 8 insertions(+), 194 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 71cd6bbfec05..282257e2628d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2595,118 +2595,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>   	return domain;
>   }
>   
> -static int get_last_alias(struct pci_dev *pdev, u16 alias, void *opaque)
> -{
> -	*(u16 *)opaque = alias;
> -	return 0;
> -}
> -
> -static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
> -{
> -	struct device_domain_info *info = NULL;
> -	struct dmar_domain *domain = NULL;
> -	struct intel_iommu *iommu;
> -	u16 dma_alias;
> -	unsigned long flags;
> -	u8 bus, devfn;
> -
> -	iommu = device_to_iommu(dev, &bus, &devfn);
> -	if (!iommu)
> -		return NULL;
> -
> -	if (dev_is_pci(dev)) {
> -		struct pci_dev *pdev = to_pci_dev(dev);
> -
> -		pci_for_each_dma_alias(pdev, get_last_alias, &dma_alias);
> -
> -		spin_lock_irqsave(&device_domain_lock, flags);
> -		info = dmar_search_domain_by_dev_info(pci_domain_nr(pdev->bus),
> -						      PCI_BUS_NUM(dma_alias),
> -						      dma_alias & 0xff);
> -		if (info) {
> -			iommu = info->iommu;
> -			domain = info->domain;
> -		}
> -		spin_unlock_irqrestore(&device_domain_lock, flags);
> -
> -		/* DMA alias already has a domain, use it */
> -		if (info)
> -			goto out;
> -	}
> -
> -	/* Allocate and initialize new domain for the device */
> -	domain = alloc_domain(0);
> -	if (!domain)
> -		return NULL;
> -	if (domain_init(domain, iommu, gaw)) {
> -		domain_exit(domain);
> -		return NULL;
> -	}
> -
> -out:
> -
> -	return domain;
> -}
> -
> -static struct dmar_domain *set_domain_for_dev(struct device *dev,
> -					      struct dmar_domain *domain)
> -{
> -	struct intel_iommu *iommu;
> -	struct dmar_domain *tmp;
> -	u16 req_id, dma_alias;
> -	u8 bus, devfn;
> -
> -	iommu = device_to_iommu(dev, &bus, &devfn);
> -	if (!iommu)
> -		return NULL;
> -
> -	req_id = ((u16)bus << 8) | devfn;
> -
> -	if (dev_is_pci(dev)) {
> -		struct pci_dev *pdev = to_pci_dev(dev);
> -
> -		pci_for_each_dma_alias(pdev, get_last_alias, &dma_alias);
> -
> -		/* register PCI DMA alias device */
> -		if (req_id != dma_alias) {
> -			tmp = dmar_insert_one_dev_info(iommu, PCI_BUS_NUM(dma_alias),
> -					dma_alias & 0xff, NULL, domain);
> -
> -			if (!tmp || tmp != domain)
> -				return tmp;
> -		}
> -	}
> -
> -	tmp = dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
> -	if (!tmp || tmp != domain)
> -		return tmp;
> -
> -	return domain;
> -}
> -
> -static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
> -{
> -	struct dmar_domain *domain, *tmp;
> -
> -	domain = find_domain(dev);
> -	if (domain)
> -		goto out;
> -
> -	domain = find_or_alloc_domain(dev, gaw);
> -	if (!domain)
> -		goto out;
> -
> -	tmp = set_domain_for_dev(dev, domain);
> -	if (!tmp || domain != tmp) {
> -		domain_exit(domain);
> -		domain = tmp;
> -	}
> -
> -out:
> -
> -	return domain;
> -}
> -
>   static int iommu_domain_identity_map(struct dmar_domain *domain,
>   				     unsigned long long start,
>   				     unsigned long long end)
> @@ -2779,7 +2667,7 @@ static int iommu_prepare_identity_map(struct device *dev,
>   	struct dmar_domain *domain;
>   	int ret;
>   
> -	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
> +	domain = find_domain(dev);
>   	if (!domain)
>   		return -ENOMEM;
>   
> @@ -3301,11 +3189,9 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>   static int __init init_dmars(void)
>   {
>   	struct dmar_drhd_unit *drhd;
> -	struct dmar_rmrr_unit *rmrr;
>   	bool copied_tables = false;
> -	struct device *dev;
>   	struct intel_iommu *iommu;
> -	int i, ret;
> +	int ret;
>   
>   	/*
>   	 * for each drhd
> @@ -3466,32 +3352,6 @@ static int __init init_dmars(void)
>   			goto free_iommu;
>   		}
>   	}
> -	/*
> -	 * For each rmrr
> -	 *   for each dev attached to rmrr
> -	 *   do
> -	 *     locate drhd for dev, alloc domain for dev
> -	 *     allocate free domain
> -	 *     allocate page table entries for rmrr
> -	 *     if context not allocated for bus
> -	 *           allocate and init context
> -	 *           set present in root table for this bus
> -	 *     init context with domain, translation etc
> -	 *    endfor
> -	 * endfor
> -	 */
> -	pr_info("Setting RMRR:\n");
> -	for_each_rmrr_units(rmrr) {
> -		/* some BIOS lists non-exist devices in DMAR table. */
> -		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
> -					  i, dev) {
> -			ret = iommu_prepare_rmrr_dev(rmrr, dev);
> -			if (ret)
> -				pr_err("Mapping reserved region failed\n");
> -		}
> -	}
> -
> -	iommu_prepare_isa();

Why do you want to remove this segment of code?

>   
>   domains_done:
>   
> @@ -3580,53 +3440,6 @@ static unsigned long intel_alloc_iova(struct device *dev,
>   	return iova_pfn;
>   }
>   
> -struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
> -{
> -	struct dmar_domain *domain, *tmp;
> -	struct dmar_rmrr_unit *rmrr;
> -	struct device *i_dev;
> -	int i, ret;
> -
> -	domain = find_domain(dev);
> -	if (domain)
> -		goto out;
> -
> -	domain = find_or_alloc_domain(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
> -	if (!domain)
> -		goto out;
> -
> -	/* We have a new domain - setup possible RMRRs for the device */
> -	rcu_read_lock();
> -	for_each_rmrr_units(rmrr) {
> -		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
> -					  i, i_dev) {
> -			if (i_dev != dev)
> -				continue;
> -
> -			ret = domain_prepare_identity_map(dev, domain,
> -							  rmrr->base_address,
> -							  rmrr->end_address);
> -			if (ret)
> -				dev_err(dev, "Mapping reserved region failed\n");

We can't simply remove this segment of code, right? At least it should
be moved to the domain allocation interface.

> -		}
> -	}
> -	rcu_read_unlock();
> -
> -	tmp = set_domain_for_dev(dev, domain);
> -	if (!tmp || domain != tmp) {
> -		domain_exit(domain);
> -		domain = tmp;
> -	}
> -
> -out:
> -
> -	if (!domain)
> -		pr_err("Allocating domain for %s failed\n", dev_name(dev));
> -
> -
> -	return domain;
> -}
> -
>   /* Check if the dev needs to go through non-identity map and unmap process.*/
>   static int iommu_no_mapping(struct device *dev)
>   {
> @@ -3689,7 +3502,7 @@ static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
>   	if (iommu_no_mapping(dev))
>   		return paddr;
>   
> -	domain = get_valid_domain_for_dev(dev);
> +	domain = find_domain(dev);
>   	if (!domain)
>   		return DMA_MAPPING_ERROR;
>   
> @@ -3753,7 +3566,8 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
>   		return;
>   
>   	domain = find_domain(dev);
> -	BUG_ON(!domain);
> +	if (!domain)
> +		return;
>   

This is not related to this patch. Let's do it in a separated patch.

>   	iommu = domain_get_iommu(domain);
>   
> @@ -3899,7 +3713,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
>   	if (iommu_no_mapping(dev))
>   		return intel_nontranslate_map_sg(dev, sglist, nelems, dir);
>   
> -	domain = get_valid_domain_for_dev(dev);
> +	domain = find_domain(dev);
>   	if (!domain)
>   		return 0;
>   
> @@ -5377,9 +5191,9 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
>   	u64 ctx_lo;
>   	int ret;
>   
> -	domain = get_valid_domain_for_dev(sdev->dev);
> +	domain = find_domain(sdev->dev);
>   	if (!domain)
> -		return -EINVAL;
> +		return -ENOMEM;

This is not related to this patch. Let's do it in a separated patch.

>   
>   	spin_lock_irqsave(&device_domain_lock, flags);
>   	spin_lock(&iommu->lock);
> 

Best regards,
Lu Baolu
