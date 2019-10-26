Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F91CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 02:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FBF214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 02:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfJZCnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 22:43:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:58200 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfJZCng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 22:43:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 19:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="224100961"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2019 19:43:33 -0700
Cc:     baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v7 11/11] iommu/vt-d: Add svm/sva invalidate function
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-12-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDE06@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5e9d2372-a8b5-9a26-1438-c1a608bfad6d@linux.intel.com>
Date:   Sat, 26 Oct 2019 10:40:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDE06@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/25/19 3:27 PM, Tian, Kevin wrote:
>> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
>> Sent: Friday, October 25, 2019 3:55 AM
>>
>> When Shared Virtual Address (SVA) is enabled for a guest OS via
>> vIOMMU, we need to provide invalidation support at IOMMU API and
>> driver
>> level. This patch adds Intel VT-d specific function to implement
>> iommu passdown invalidate API for shared virtual address.
>>
>> The use case is for supporting caching structure invalidation
>> of assigned SVM capable devices. Emulated IOMMU exposes queue
>> invalidation capability and passes down all descriptors from the guest
>> to the physical IOMMU.
> 
> specifically you may clarify that only invalidations related to
> first-level page table is passed down, because it's guest
> structure being bound to the first-level. other descriptors
> are emulated or translated into other necessary operations.
> 
>>
>> The assumption is that guest to host device ID mapping should be
>> resolved prior to calling IOMMU driver. Based on the device handle,
>> host IOMMU driver can replace certain fields before submit to the
>> invalidation queue.
> 
> what is device ID? it's a bit confusing term here.
> 
>>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 170
>> ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 170 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 5fab32fbc4b4..a73e76d6457a 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -5491,6 +5491,175 @@ static void
>> intel_iommu_aux_detach_device(struct iommu_domain *domain,
>>   	aux_domain_remove_dev(to_dmar_domain(domain), dev);
>>   }
>>
>> +/*
>> + * 2D array for converting and sanitizing IOMMU generic TLB granularity to
>> + * VT-d granularity. Invalidation is typically included in the unmap
>> operation
>> + * as a result of DMA or VFIO unmap. However, for assigned device where
>> guest
>> + * could own the first level page tables without being shadowed by QEMU.
>> In
>> + * this case there is no pass down unmap to the host IOMMU as a result of
>> unmap
>> + * in the guest. Only invalidations are trapped and passed down.
>> + * In all cases, only first level TLB invalidation (request with PASID) can be
>> + * passed down, therefore we do not include IOTLB granularity for request
>> + * without PASID (second level).
>> + *
>> + * For an example, to find the VT-d granularity encoding for IOTLB
>> + * type and page selective granularity within PASID:
>> + * X: indexed by iommu cache type
>> + * Y: indexed by enum iommu_inv_granularity
>> + * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
>> + *
>> + * Granu_map array indicates validity of the table. 1: valid, 0: invalid
>> + *
>> + */
>> +const static int
>> inv_type_granu_map[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRAN
>> U_NR] = {
>> +	/* PASID based IOTLB, support PASID selective and page selective */
>> +	{0, 1, 1},
>> +	/* PASID based dev TLBs, only support all PASIDs or single PASID */
>> +	{1, 1, 0},
> 
> I forgot previous discussion. is it necessary to pass down dev TLB invalidation
> requests? Can it be handled by host iOMMU driver automatically?

On host SVA, when a memory is unmapped, driver callback will invalidate
dev IOTLB explicitly. So I guess we need to pass down it for guest case.
This is also required for guest iova over 1st level usage as far as can
see.

Best regards,
baolu

> 
>> +	/* PASID cache */
>> +	{1, 1, 0}
>> +};
>> +
>> +const static u64
>> inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRAN
>> U_NR] = {
>> +	/* PASID based IOTLB */
>> +	{0, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
>> +	/* PASID based dev TLBs */
>> +	{QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0},
>> +	/* PASID cache */
>> +	{QI_PC_ALL_PASIDS, QI_PC_PASID_SEL, 0},
>> +};
>> +
>> +static inline int to_vtd_granularity(int type, int granu, u64 *vtd_granu)
>> +{
>> +	if (type >= IOMMU_CACHE_INV_TYPE_NR || granu >=
>> IOMMU_INV_GRANU_NR ||
>> +		!inv_type_granu_map[type][granu])
>> +		return -EINVAL;
>> +
>> +	*vtd_granu = inv_type_granu_table[type][granu];
>> +
>> +	return 0;
>> +}
>> +
>> +static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
>> +{
>> +	u64 nr_pages = (granu_size * nr_granules) >> VTD_PAGE_SHIFT;
>> +
>> +	/* VT-d size is encoded as 2^size of 4K pages, 0 for 4k, 9 for 2MB,
>> etc.
>> +	 * IOMMU cache invalidate API passes granu_size in bytes, and
>> number of
>> +	 * granu size in contiguous memory.
>> +	 */
>> +	return order_base_2(nr_pages);
>> +}
>> +
>> +#ifdef CONFIG_INTEL_IOMMU_SVM
>> +static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
>> +		struct device *dev, struct iommu_cache_invalidate_info
>> *inv_info)
>> +{
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct device_domain_info *info;
>> +	struct intel_iommu *iommu;
>> +	unsigned long flags;
>> +	int cache_type;
>> +	u8 bus, devfn;
>> +	u16 did, sid;
>> +	int ret = 0;
>> +	u64 size;
>> +
>> +	if (!inv_info || !dmar_domain ||
>> +		inv_info->version !=
>> IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
>> +		return -EINVAL;
>> +
>> +	if (!dev || !dev_is_pci(dev))
>> +		return -ENODEV;
>> +
>> +	iommu = device_to_iommu(dev, &bus, &devfn);
>> +	if (!iommu)
>> +		return -ENODEV;
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	spin_lock(&iommu->lock);
>> +	info = iommu_support_dev_iotlb(dmar_domain, iommu, bus,
>> devfn);
>> +	if (!info) {
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +	did = dmar_domain->iommu_did[iommu->seq_id];
>> +	sid = PCI_DEVID(bus, devfn);
>> +	size = to_vtd_size(inv_info->addr_info.granule_size, inv_info-
>>> addr_info.nb_granules);
>> +
>> +	for_each_set_bit(cache_type, (unsigned long *)&inv_info->cache,
>> IOMMU_CACHE_INV_TYPE_NR) {
>> +		u64 granu = 0;
>> +		u64 pasid = 0;
>> +
>> +		ret = to_vtd_granularity(cache_type, inv_info->granularity,
>> &granu);
>> +		if (ret) {
>> +			pr_err("Invalid cache type and granu
>> combination %d/%d\n", cache_type,
>> +				inv_info->granularity);
>> +			break;
>> +		}
>> +
>> +		/* PASID is stored in different locations based on
>> granularity */
>> +		if (inv_info->granularity == IOMMU_INV_GRANU_PASID)
>> +			pasid = inv_info->pasid_info.pasid;
>> +		else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
>> +			pasid = inv_info->addr_info.pasid;
>> +		else {
>> +			pr_err("Cannot find PASID for given cache type and
>> granularity\n");
>> +			break;
>> +		}
>> +
>> +		switch (BIT(cache_type)) {
>> +		case IOMMU_CACHE_INV_TYPE_IOTLB:
>> +			if (size && (inv_info->addr_info.addr &
>> ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
>> +				pr_err("Address out of range, 0x%llx, size
>> order %llu\n",
>> +					inv_info->addr_info.addr, size);
>> +				ret = -ERANGE;
>> +				goto out_unlock;
>> +			}
>> +
>> +			qi_flush_piotlb(iommu, did,
>> mm_to_dma_pfn(inv_info->addr_info.addr),
>> +					pasid, size, granu, inv_info-
>>> addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
>> +
>> +			/*
>> +			 * Always flush device IOTLB if ATS is enabled since
>> guest
>> +			 * vIOMMU exposes CM = 1, no device IOTLB flush
>> will be passed
>> +			 * down.
>> +			 */
>> +			if (info->ats_enabled) {
>> +				qi_flush_dev_piotlb(iommu, sid, info->pfsid,
>> +						pasid, info->ats_qdep,
>> +						inv_info->addr_info.addr,
>> size,
>> +						granu);
>> +			}
>> +			break;
>> +		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
>> +			if (info->ats_enabled) {
>> +				qi_flush_dev_piotlb(iommu, sid, info->pfsid,
>> +						inv_info->addr_info.pasid,
>> info->ats_qdep,
>> +						inv_info->addr_info.addr,
>> size,
>> +						granu);
>> +			} else
>> +				pr_warn("Passdown device IOTLB flush w/o
>> ATS!\n");
>> +
>> +			break;
>> +		case IOMMU_CACHE_INV_TYPE_PASID:
>> +			qi_flush_pasid_cache(iommu, did, granu, inv_info-
>>> pasid_info.pasid);
>> +
>> +			break;
>> +		default:
>> +			dev_err(dev, "Unsupported IOMMU invalidation
>> type %d\n",
>> +				cache_type);
>> +			ret = -EINVAL;
>> +		}
>> +	}
>> +out_unlock:
>> +	spin_unlock(&iommu->lock);
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +
>> +	return ret;
>> +}
>> +#endif
>> +
>>   static int intel_iommu_map(struct iommu_domain *domain,
>>   			   unsigned long iova, phys_addr_t hpa,
>>   			   size_t size, int iommu_prot)
>> @@ -6027,6 +6196,7 @@ const struct iommu_ops intel_iommu_ops = {
>>   	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>>   	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>>   #ifdef CONFIG_INTEL_IOMMU_SVM
>> +	.cache_invalidate	= intel_iommu_sva_invalidate,
>>   	.sva_bind_gpasid	= intel_svm_bind_gpasid,
>>   	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
>>   #endif
>> --
>> 2.7.4
> 
> 
