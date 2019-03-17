Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA76C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8C920835
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfCQQnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:43:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfCQQnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:43:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EAD7308FC5E;
        Sun, 17 Mar 2019 16:43:21 +0000 (UTC)
Received: from [10.36.116.102] (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D01465C28F;
        Sun, 17 Mar 2019 16:43:14 +0000 (UTC)
Subject: Re: [PATCH v5 05/22] iommu: Introduce cache_invalidate API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, yi.l.liu@linux.intel.com,
        jean-philippe.brucker@arm.com, will.deacon@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com, ashok.raj@intel.com,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        peter.maydell@linaro.org, vincent.stehle@arm.com
References: <20190315160906.12900-1-eric.auger@redhat.com>
 <20190315160906.12900-6-eric.auger@redhat.com>
 <20190315113702.1184d162@jacob-builder>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <281167f1-c046-3077-e954-d1f510c27d61@redhat.com>
Date:   Sun, 17 Mar 2019 17:43:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190315113702.1184d162@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 17 Mar 2019 16:43:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 3/15/19 7:37 PM, Jacob Pan wrote:
> On Fri, 15 Mar 2019 17:08:49 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
>>
>> In any virtualization use case, when the first translation stage
>> is "owned" by the guest OS, the host IOMMU driver has no knowledge
>> of caching structure updates unless the guest invalidation activities
>> are trapped by the virtualizer and passed down to the host.
>>
>> Since the invalidation data are obtained from user space and will be
>> written into physical IOMMU, we must allow security check at various
>> layers. Therefore, generic invalidation data format are proposed here,
>> model specific IOMMU drivers need to convert them into their own
>> format.
>>
>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v3 -> v4:
>> - full reshape of the API following Alex' comments
>>
>> v1 -> v2:
>> - add arch_id field
>> - renamed tlb_invalidate into cache_invalidate as this API allows
>>   to invalidate context caches on top of IOTLBs
>>
>> v1:
>> renamed sva_invalidate into tlb_invalidate and add iommu_ prefix in
>> header. Commit message reworded.
>> ---
>>  drivers/iommu/iommu.c      | 14 ++++++++
>>  include/linux/iommu.h      | 21 +++++++++++
>>  include/uapi/linux/iommu.h | 71
>> ++++++++++++++++++++++++++++++++++++++ 3 files changed, 106
>> insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 7d9285cea100..b72e326ddd41 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1544,6 +1544,20 @@ void iommu_detach_pasid_table(struct
>> iommu_domain *domain) }
>>  EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
>>  
>> +int iommu_cache_invalidate(struct iommu_domain *domain, struct
>> device *dev,
>> +			   struct iommu_cache_invalidate_info
>> *inv_info) +{
>> +	int ret = 0;
>> +
>> +	if (unlikely(!domain->ops->cache_invalidate))
>> +		return -ENODEV;
>> +
>> +	ret = domain->ops->cache_invalidate(domain, dev, inv_info);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
>> +
>>  static void __iommu_detach_device(struct iommu_domain *domain,
>>  				  struct device *dev)
>>  {
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index fb9b7a8de25f..3d8e48876162 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -191,6 +191,7 @@ struct iommu_resv_region {
>>   *                      driver init to device driver init (default
>> no)
>>   * @attach_pasid_table: attach a pasid table
>>   * @detach_pasid_table: detach the pasid table
>> + * @cache_invalidate: invalidate translation caches
>>   * @pgsize_bitmap: bitmap of all possible supported page sizes
>>   */
>>  struct iommu_ops {
>> @@ -239,6 +240,9 @@ struct iommu_ops {
>>  				  struct iommu_pasid_table_config
>> *cfg); void (*detach_pasid_table)(struct iommu_domain *domain);
>>  
>> +	int (*cache_invalidate)(struct iommu_domain *domain, struct
>> device *dev,
>> +				struct iommu_cache_invalidate_info
>> *inv_info); +
>>  	unsigned long pgsize_bitmap;
>>  };
>>  
>> @@ -349,6 +353,9 @@ extern void iommu_detach_device(struct
>> iommu_domain *domain, extern int iommu_attach_pasid_table(struct
>> iommu_domain *domain, struct iommu_pasid_table_config *cfg);
>>  extern void iommu_detach_pasid_table(struct iommu_domain *domain);
>> +extern int iommu_cache_invalidate(struct iommu_domain *domain,
>> +				  struct device *dev,
>> +				  struct iommu_cache_invalidate_info
>> *inv_info); extern struct iommu_domain
>> *iommu_get_domain_for_dev(struct device *dev); extern struct
>> iommu_domain *iommu_get_dma_domain(struct device *dev); extern int
>> iommu_map(struct iommu_domain *domain, unsigned long iova, @@ -795,7
>> +802,21 @@ int iommu_attach_pasid_table(struct iommu_domain *domain, }
>>  
>>  static inline
>> +<<<<<<< HEAD
>>  void iommu_detach_pasid_table(struct iommu_domain *domain) {}
>> +=======
>> +void iommu_detach_pasid_table(struct iommu_domain *domain)
>> +{
>> +	return -ENODEV;
>> +}
>> +static inline int
>> +iommu_cache_invalidate(struct iommu_domain *domain,
>> +		       struct device *dev,
>> +		       struct iommu_cache_invalidate_info *inv_info)
>> +{
>> +	return -ENODEV;
>> +}
>> +>>>>>>> 56df871916e5... iommu: Introduce cache_invalidate API 
ouch :-(

> forgot to merge :)
>>  
>>  #endif /* CONFIG_IOMMU_API */
>>  
>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>> index 532a64075f23..e4c6a447e85a 100644
>> --- a/include/uapi/linux/iommu.h
>> +++ b/include/uapi/linux/iommu.h
>> @@ -159,4 +159,75 @@ struct iommu_pasid_table_config {
>>  	};
>>  };
>>  
>> +/* defines the granularity of the invalidation */
>> +enum iommu_inv_granularity {
>> +	IOMMU_INV_GRANU_DOMAIN,	/* domain-selective
>> invalidation */
>> +	IOMMU_INV_GRANU_PASID,	/* pasid-selective
>> invalidation */
>> +	IOMMU_INV_GRANU_ADDR,	/* page-selective invalidation
>> */ +};
>> +
>> +/**
>> + * Address Selective Invalidation Structure
>> + *
>> + * @flags indicates the granularity of the address-selective
>> invalidation
>> + * - if PASID bit is set, @pasid field is populated and the
>> invalidation
>> + *   relates to cache entries tagged with this PASID and matching the
>> + *   address range.
>> + * - if ARCHID bit is set, @archid is populated and the invalidation
>> relates
>> + *   to cache entries tagged with this architecture specific id and
>> matching
>> + *   the address range.
>> + * - Both PASID and ARCHID can be set as they may tag different
>> caches.
>> + * - if neither PASID or ARCHID is set, global addr invalidation
>> applies
>> + * - LEAF flag indicates whether only the leaf PTE caching needs to
>> be
>> + *   invalidated and other paging structure caches can be preserved.
>> + * @pasid: process address space id
>> + * @archid: architecture-specific id
>> + * @addr: first stage/level input address
>> + * @granule_size: page/block size of the mapping in bytes
>> + * @nb_granules: number of contiguous granules to be invalidated
>> + */
>> +struct iommu_inv_addr_info {
>> +#define IOMMU_INV_ADDR_FLAGS_PASID	(1 << 0)
>> +#define IOMMU_INV_ADDR_FLAGS_ARCHID	(1 << 1)
>> +#define IOMMU_INV_ADDR_FLAGS_LEAF	(1 << 2)
>> +	__u32	flags;
>> +	__u32	archid;
>> +	__u64	pasid;
>> +	__u64	addr;
>> +	__u64	granule_size;
>> +	__u64	nb_granules;
>> +};
>> +
>> +/**
>> + * First level/stage invalidation information
>> + * @cache: bitfield that allows to select which caches to invalidate
>> + * @granularity: defines the lowest granularity used for the
>> invalidation:
>> + *     domain > pasid > addr
>> + *
>> + * Not all the combinations of cache/granularity make sense:
>> + *
>> + *         type |   DEV_IOTLB   |     IOTLB     |      PASID    |
>> + * granularity	|		|		|
>> cache	|
>> + * -------------+---------------+---------------+---------------+
>> + * DOMAIN	|	N/A	|       Y	|
>> Y	|
>> + * PASID	|	Y	|       Y	|
>> Y	|
>> + * ADDR		|       Y	|       Y	|
>> N/A	|
>> + */
>> +struct iommu_cache_invalidate_info {
>> +#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
>> +	__u32	version;
>> +/* IOMMU paging structure cache */
>> +#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
>> +#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /* Device
>> IOTLB */ +#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID
>> cache */
>> +	__u8	cache;
>> +	__u8	granularity;
>> +	__u8	padding[2];
>> +	union {
>> +		__u64	pasid;
> just realized there is already a pasid field in the addr_info, do we
> still need this?
I think so. Either you do a PASID based invalidation and you directly
use the pasid field or you do an address based invalidation and you use
the addr_info where the pasid may or not be passed.

Thanks

Eric
>> +		struct iommu_inv_addr_info addr_info;
>> +	};
>> +};
>> +
>> +
>>  #endif /* _UAPI_IOMMU_H */
> 
> [Jacob Pan]
> 
