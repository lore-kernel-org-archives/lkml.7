Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDC5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA9820663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCFV44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:56:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:54975 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfCFV4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:56:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 13:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,449,1544515200"; 
   d="scan'208";a="304994983"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 06 Mar 2019 13:56:54 -0800
Date:   Wed, 6 Mar 2019 13:59:10 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, yi.l.liu@linux.intel.com,
        will.deacon@arm.com, robin.murphy@arm.com, marc.zyngier@arm.com,
        peter.maydell@linaro.org, kevin.tian@intel.com,
        ashok.raj@intel.com, christoffer.dall@arm.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 05/22] iommu: Introduce cache_invalidate API
Message-ID: <20190306135910.0ef1eb0d@jacob-builder>
In-Reply-To: <0e041735-98e8-1d8c-c866-ad23e6cc1db5@redhat.com>
References: <20190218135504.25048-1-eric.auger@redhat.com>
        <20190218135504.25048-6-eric.auger@redhat.com>
        <0762b4da-aff0-4e9f-f257-e2ab294bf235@arm.com>
        <0e041735-98e8-1d8c-c866-ad23e6cc1db5@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019 19:14:42 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Kevin, Yi,
> 
> On 3/5/19 4:28 PM, Jean-Philippe Brucker wrote:
> > On 18/02/2019 13:54, Eric Auger wrote:  
> >> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> >>
> >> In any virtualization use case, when the first translation stage
> >> is "owned" by the guest OS, the host IOMMU driver has no knowledge
> >> of caching structure updates unless the guest invalidation
> >> activities are trapped by the virtualizer and passed down to the
> >> host.
> >>
> >> Since the invalidation data are obtained from user space and will
> >> be written into physical IOMMU, we must allow security check at
> >> various layers. Therefore, generic invalidation data format are
> >> proposed here, model specific IOMMU drivers need to convert them
> >> into their own format.
> >>
> >> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> >> Signed-off-by: Jean-Philippe Brucker
> >> <jean-philippe.brucker@arm.com> Signed-off-by: Jacob Pan
> >> <jacob.jun.pan@linux.intel.com> Signed-off-by: Ashok Raj
> >> <ashok.raj@intel.com> Signed-off-by: Eric Auger
> >> <eric.auger@redhat.com>
> >>
> >> ---
> >> v3 -> v4:
> >> - full reshape of the API following Alex' comments
> >>
> >> v1 -> v2:
> >> - add arch_id field
> >> - renamed tlb_invalidate into cache_invalidate as this API allows
> >>   to invalidate context caches on top of IOTLBs
> >>
> >> v1:
> >> renamed sva_invalidate into tlb_invalidate and add iommu_ prefix in
> >> header. Commit message reworded.
> >> ---
> >>  drivers/iommu/iommu.c      | 14 ++++++++
> >>  include/linux/iommu.h      | 14 ++++++++
> >>  include/uapi/linux/iommu.h | 71
> >> ++++++++++++++++++++++++++++++++++++++ 3 files changed, 99
> >> insertions(+)
> >>
> >> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >> index b3adb77cb14c..bcb8eb15426c 100644
> >> --- a/drivers/iommu/iommu.c
> >> +++ b/drivers/iommu/iommu.c
> >> @@ -1564,6 +1564,20 @@ void iommu_detach_pasid_table(struct
> >> iommu_domain *domain) }
> >>  EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
> >>  
> >> +int iommu_cache_invalidate(struct iommu_domain *domain, struct
> >> device *dev,
> >> +			   struct iommu_cache_invalidate_info
> >> *inv_info) +{
> >> +	int ret = 0;
> >> +
> >> +	if (unlikely(!domain->ops->cache_invalidate))
> >> +		return -ENODEV;
> >> +
> >> +	ret = domain->ops->cache_invalidate(domain, dev,
> >> inv_info); +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
> >> +
> >>  static void __iommu_detach_device(struct iommu_domain *domain,
> >>  				  struct device *dev)
> >>  {
> >> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> >> index 7045e26f3a7d..a3b879d0753c 100644
> >> --- a/include/linux/iommu.h
> >> +++ b/include/linux/iommu.h
> >> @@ -189,6 +189,7 @@ struct iommu_resv_region {
> >>   * @pgsize_bitmap: bitmap of all possible supported page sizes
> >>   * @attach_pasid_table: attach a pasid table
> >>   * @detach_pasid_table: detach the pasid table
> >> + * @cache_invalidate: invalidate translation caches
> >>   */
> >>  struct iommu_ops {
> >>  	bool (*capable)(enum iommu_cap);
> >> @@ -235,6 +236,9 @@ struct iommu_ops {
> >>  				  struct iommu_pasid_table_config
> >> *cfg); void (*detach_pasid_table)(struct iommu_domain *domain);
> >>  
> >> +	int (*cache_invalidate)(struct iommu_domain *domain,
> >> struct device *dev,
> >> +				struct
> >> iommu_cache_invalidate_info *inv_info); +
> >>  	unsigned long pgsize_bitmap;
> >>  };
> >>  
> >> @@ -348,6 +352,9 @@ extern void iommu_detach_device(struct
> >> iommu_domain *domain, extern int iommu_attach_pasid_table(struct
> >> iommu_domain *domain, struct iommu_pasid_table_config *cfg);
> >>  extern void iommu_detach_pasid_table(struct iommu_domain *domain);
> >> +extern int iommu_cache_invalidate(struct iommu_domain *domain,
> >> +				  struct device *dev,
> >> +				  struct
> >> iommu_cache_invalidate_info *inv_info); extern struct iommu_domain
> >> *iommu_get_domain_for_dev(struct device *dev); extern struct
> >> iommu_domain *iommu_get_dma_domain(struct device *dev); extern int
> >> iommu_map(struct iommu_domain *domain, unsigned long iova, @@
> >> -798,6 +805,13 @@ void iommu_detach_pasid_table(struct
> >> iommu_domain *domain) { return -ENODEV;
> >>  }
> >> +static inline int
> >> +iommu_cache_invalidate(struct iommu_domain *domain,
> >> +		       struct device *dev,
> >> +		       struct iommu_cache_invalidate_info
> >> *inv_info) +{
> >> +	return -ENODEV;
> >> +}
> >>  
> >>  #endif /* CONFIG_IOMMU_API */
> >>  
> >> diff --git a/include/uapi/linux/iommu.h
> >> b/include/uapi/linux/iommu.h index e9065bfa5b24..ae41385b0a7e
> >> 100644 --- a/include/uapi/linux/iommu.h
> >> +++ b/include/uapi/linux/iommu.h
> >> @@ -159,4 +159,75 @@ struct iommu_pasid_table_config {
> >>  	};
> >>  };
> >>  
> >> +/* defines the granularity of the invalidation */
> >> +enum iommu_inv_granularity {
> >> +	IOMMU_INV_GRANU_DOMAIN,	/* domain-selective
> >> invalidation */
> >> +	IOMMU_INV_GRANU_PASID,	/* pasid-selective
> >> invalidation */
> >> +	IOMMU_INV_GRANU_ADDR,	/* page-selective
> >> invalidation */ +};
> >> +
> >> +/**
> >> + * Address Selective Invalidation Structure
> >> + *
> >> + * @flags indicates the granularity of the address-selective
> >> invalidation
> >> + * - if PASID bit is set, @pasid field is populated and the
> >> invalidation
> >> + *   relates to cache entries tagged with this PASID and matching
> >> the
> >> + *   address range.
> >> + * - if ARCHID bit is set, @archid is populated and the
> >> invalidation relates
> >> + *   to cache entries tagged with this architecture specific id
> >> and matching
> >> + *   the address range.
> >> + * - Both PASID and ARCHID can be set as they may tag different
> >> caches.
> >> + * - if neither PASID or ARCHID is set, global addr invalidation
> >> applies
> >> + * - LEAF flag indicates whether only the leaf PTE caching needs
> >> to be
> >> + *   invalidated and other paging structure caches can be
> >> preserved.
> >> + * @pasid: process address space id
> >> + * @archid: architecture-specific id
> >> + * @addr: first stage/level input address
> >> + * @granule_size: page/block size of the mapping in bytes
> >> + * @nb_granules: number of contiguous granules to be invalidated
> >> + */
> >> +struct iommu_inv_addr_info {
> >> +#define IOMMU_INV_ADDR_FLAGS_PASID	(1 << 0)
> >> +#define IOMMU_INV_ADDR_FLAGS_ARCHID	(1 << 1)
> >> +#define IOMMU_INV_ADDR_FLAGS_LEAF	(1 << 2)
> >> +	__u32	flags;
> >> +	__u32	archid;
> >> +	__u64	pasid;
> >> +	__u64	addr;
> >> +	__u64	granule_size;
> >> +	__u64	nb_granules;
> >> +};  
> > 
> > Some fields don't need that many bytes, but I'm not sure it matters
> > and I'd like to see if this version works for the x86 folks before
> > bothering with such details. Looks good to me, from the SMMU
> > perspective.  
> Does it fit your needs? - Thanks Jean for your feedback -
Yes, it should fit VT-d's needs.
We will do some conversion for granularity based on .cache
and .granularity.

Fill in the 4K size for granule_size, then use nb_granules for size of
iotlb invalidation. We probably dont need arch ID. We also dont need
the global page flags as you have removed it. So we should be good.

We will use this for my next patchset.

Thanks,

Jacob

> 
> Thanks
> 
> Eric
> 
> > 
> > Thanks,
> > Jean
> >   
> >> +
> >> +/**
> >> + * First level/stage invalidation information
> >> + * @cache: bitfield that allows to select which caches to
> >> invalidate
> >> + * @granularity: defines the lowest granularity used for the
> >> invalidation:
> >> + *     domain > pasid > addr
> >> + *
> >> + * Not all the combinations of cache/granularity make sense:
> >> + *
> >> + *         type |   DEV_IOTLB   |     IOTLB     |      PASID    |
> >> + * granularity	|		|		|
> >> cache	|
> >> + * -------------+---------------+---------------+---------------+
> >> + * DOMAIN	|	N/A	|       Y	|
> >> Y	|
> >> + * PASID	|	Y	|       Y	|
> >> Y	|
> >> + * ADDR		|       Y	|       Y	|
> >> N/A	|
> >> + */
> >> +struct iommu_cache_invalidate_info {
> >> +#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
> >> +	__u32	version;
> >> +/* IOMMU paging structure cache */
> >> +#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB
> >> */ +#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /*
> >> Device IOTLB */ +#define IOMMU_CACHE_INV_TYPE_PASID	(1 <<
> >> 2) /* PASID cache */
> >> +	__u8	cache;
> >> +	__u8	granularity;
> >> +	__u8	padding[2];
> >> +	union {
> >> +		__u64	pasid;
> >> +		struct iommu_inv_addr_info addr_info;
> >> +	};
> >> +};
> >> +
> >> +
> >>  #endif /* _UAPI_IOMMU_H */
> >>  
> >   

[Jacob Pan]
