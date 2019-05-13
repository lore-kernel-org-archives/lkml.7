Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC3DC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3A920989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfEMJO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbfEMJOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:14:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F73D3086205;
        Mon, 13 May 2019 09:14:52 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E1CF68D9B;
        Mon, 13 May 2019 09:14:46 +0000 (UTC)
Subject: Re: [PATCH v3 02/16] iommu: Introduce cache_invalidate API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556922737-76313-3-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <d32d3d19-11c9-4af9-880b-bb8ebefd4f7f@redhat.com>
Date:   Mon, 13 May 2019 11:14:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1556922737-76313-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 13 May 2019 09:14:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob, Jean-Philippe,

On 5/4/19 12:32 AM, Jacob Pan wrote:
> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> 
> In any virtualization use case, when the first translation stage
> is "owned" by the guest OS, the host IOMMU driver has no knowledge
> of caching structure updates unless the guest invalidation activities
> are trapped by the virtualizer and passed down to the host.
> 
> Since the invalidation data are obtained from user space and will be
> written into physical IOMMU, we must allow security check at various
> layers. Therefore, generic invalidation data format are proposed here,
> model specific IOMMU drivers need to convert them into their own format.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v6 -> v7:
> - detail which fields are used for each invalidation type
> - add a comment about multiple cache invalidation
> 
> v5 -> v6:
> - fix merge issue
> 
> v3 -> v4:
> - full reshape of the API following Alex' comments
> 
> v1 -> v2:
> - add arch_id field
> - renamed tlb_invalidate into cache_invalidate as this API allows
>   to invalidate context caches on top of IOTLBs
> 
> v1:
> renamed sva_invalidate into tlb_invalidate and add iommu_ prefix in
> header. Commit message reworded.
> ---
>  drivers/iommu/iommu.c      | 14 ++++++++
>  include/linux/iommu.h      | 15 ++++++++-
>  include/uapi/linux/iommu.h | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8df9d34..a2f6f3e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1645,6 +1645,20 @@ void iommu_detach_pasid_table(struct iommu_domain *domain)
>  }
>  EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
>  
> +int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> +			   struct iommu_cache_invalidate_info *inv_info)
> +{
> +	int ret = 0;
> +
> +	if (unlikely(!domain->ops->cache_invalidate))
> +		return -ENODEV;
> +
> +	ret = domain->ops->cache_invalidate(domain, dev, inv_info);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ab4d922..d182525 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -266,6 +266,7 @@ struct page_response_msg {
>   * @page_response: handle page request response
>   * @attach_pasid_table: attach a pasid table
>   * @detach_pasid_table: detach the pasid table
> + * @cache_invalidate: invalidate translation caches
>   * @pgsize_bitmap: bitmap of all possible supported page sizes
>   */
>  struct iommu_ops {
> @@ -328,8 +329,9 @@ struct iommu_ops {
>  	int (*attach_pasid_table)(struct iommu_domain *domain,
>  				  struct iommu_pasid_table_config *cfg);
>  	void (*detach_pasid_table)(struct iommu_domain *domain);
> -
>  	int (*page_response)(struct device *dev, struct page_response_msg *msg);
> +	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
> +				struct iommu_cache_invalidate_info *inv_info);
>  
>  	unsigned long pgsize_bitmap;
>  };
> @@ -442,6 +444,9 @@ extern void iommu_detach_device(struct iommu_domain *domain,
>  extern int iommu_attach_pasid_table(struct iommu_domain *domain,
>  				    struct iommu_pasid_table_config *cfg);
>  extern void iommu_detach_pasid_table(struct iommu_domain *domain);
> +extern int iommu_cache_invalidate(struct iommu_domain *domain,
> +				  struct device *dev,
> +				  struct iommu_cache_invalidate_info *inv_info);
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> @@ -982,6 +987,14 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
>  static inline
>  void iommu_detach_pasid_table(struct iommu_domain *domain) {}
>  
> +static inline int
> +iommu_cache_invalidate(struct iommu_domain *domain,
> +		       struct device *dev,
> +		       struct iommu_cache_invalidate_info *inv_info)
> +{
> +	return -ENODEV;
> +}
> +
>  #endif /* CONFIG_IOMMU_API */
>  
>  #ifdef CONFIG_IOMMU_DEBUGFS
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 8848514..fa96ecb 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -162,4 +162,84 @@ struct iommu_pasid_table_config {
>  	};
>  };

I noticed my qemu integration was currently incorrectly using PASID
invalidation for ASID based invalidation (SMMUV3 Stage1 CMD_TLBI_NH_ASID
invalidation command). So I think we also need ARCHID invalidation.
Sorry for the late notice.
>  
> +/* defines the granularity of the invalidation */
> +enum iommu_inv_granularity {
> +	IOMMU_INV_GRANU_DOMAIN,	/* domain-selective invalidation */
        IOMMU_INV_GRANU_ARCHID, /* archid-selective invalidation */
> +	IOMMU_INV_GRANU_PASID,	/* pasid-selective invalidation */
> +	IOMMU_INV_GRANU_ADDR,	/* page-selective invalidation */
> +	IOMMU_INVAL_GRANU_NR,   /* number of invalidation granularities */
> +};
> +
> +/**
> + * Address Selective Invalidation Structure
> + *
> + * @flags indicates the granularity of the address-selective invalidation
> + * - if PASID bit is set, @pasid field is populated and the invalidation
> + *   relates to cache entries tagged with this PASID and matching the
> + *   address range.
> + * - if ARCHID bit is set, @archid is populated and the invalidation relates
> + *   to cache entries tagged with this architecture specific id and matching
> + *   the address range.
> + * - Both PASID and ARCHID can be set as they may tag different caches.
> + * - if neither PASID or ARCHID is set, global addr invalidation applies
> + * - LEAF flag indicates whether only the leaf PTE caching needs to be
> + *   invalidated and other paging structure caches can be preserved.
> + * @pasid: process address space id
> + * @archid: architecture-specific id
> + * @addr: first stage/level input address
> + * @granule_size: page/block size of the mapping in bytes
> + * @nb_granules: number of contiguous granules to be invalidated
> + */
> +struct iommu_inv_addr_info {
> +#define IOMMU_INV_ADDR_FLAGS_PASID	(1 << 0)
> +#define IOMMU_INV_ADDR_FLAGS_ARCHID	(1 << 1)
> +#define IOMMU_INV_ADDR_FLAGS_LEAF	(1 << 2)
> +	__u32	flags;
> +	__u32	archid;
> +	__u64	pasid;
> +	__u64	addr;
> +	__u64	granule_size;
> +	__u64	nb_granules;
> +};
> +
> +/**
> + * First level/stage invalidation information
> + * @cache: bitfield that allows to select which caches to invalidate
> + * @granularity: defines the lowest granularity used for the invalidation:
> + *     domain > pasid > addr
> + *
> + * Not all the combinations of cache/granularity make sense:
> + *
> + *         type |   DEV_IOTLB   |     IOTLB     |      PASID    |
> + * granularity	|		|		|      cache	|
> + * -------------+---------------+---------------+---------------+
> + * DOMAIN	|	N/A	|       Y	|	Y	|
 * ARCHID       |       N/A     |       Y       |       N/A     |

> + * PASID	|	Y	|       Y	|	Y	|
> + * ADDR		|       Y	|       Y	|	N/A	|
> + *
> + * Invalidations by %IOMMU_INV_GRANU_ADDR use field @addr_info.
 * Invalidations by %IOMMU_INV_GRANU_ARCHID use field @archid.
> + * Invalidations by %IOMMU_INV_GRANU_PASID use field @pasid.
> + * Invalidations by %IOMMU_INV_GRANU_DOMAIN don't take any argument.
> + *
> + * If multiple cache types are invalidated simultaneously, they all
> + * must support the used granularity.
> + */
> +struct iommu_cache_invalidate_info {
> +#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
> +	__u32	version;
> +/* IOMMU paging structure cache */
> +#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
> +#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /* Device IOTLB */
> +#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID cache */
> +#define IOMMU_CACHE_TYPE_NR		(3)
> +	__u8	cache;
> +	__u8	granularity;
> +	__u8	padding[2];
> +	union {
> +		__u64	pasid;
                __u32   archid;

Thanks

Eric
> +		struct iommu_inv_addr_info addr_info;
> +	};
> +};
> +
> +
>  #endif /* _UAPI_IOMMU_H */
> 
