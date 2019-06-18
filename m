Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83A7C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0EA20673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfFRPl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:41:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729272AbfFRPl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:41:27 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 36BC936D2AA33ED8A0AD;
        Tue, 18 Jun 2019 23:41:22 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Jun 2019
 23:41:17 +0800
Date:   Tue, 18 Jun 2019 16:41:05 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Eric Auger" <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 09/22] iommu: Introduce cache_invalidate API
Message-ID: <20190618164105.0000077b@huawei.com>
In-Reply-To: <1560087862-57608-10-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-10-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2019 06:44:09 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> From: Liu Yi L <yi.l.liu@intel.com>
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
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Some comment ordering nitpicks.  Nothing important.

Jonathan

> ---
>  drivers/iommu/iommu.c      |  10 +++++
>  include/linux/iommu.h      |  14 ++++++
>  include/uapi/linux/iommu.h | 110 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4496ccd..1758b57 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1638,6 +1638,16 @@ void iommu_detach_pasid_table(struct iommu_domain *domain)
>  }
>  EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
>  
> +int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> +			   struct iommu_cache_invalidate_info *inv_info)
> +{
> +	if (unlikely(!domain->ops->cache_invalidate))
> +		return -ENODEV;
> +
> +	return domain->ops->cache_invalidate(domain, dev, inv_info);
> +}
> +EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d3edb10..7a37336 100644
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
> @@ -330,6 +331,8 @@ struct iommu_ops {
>  	void (*detach_pasid_table)(struct iommu_domain *domain);
>  
>  	int (*page_response)(struct device *dev, struct page_response_msg *msg);
> +	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
> +				struct iommu_cache_invalidate_info *inv_info);
>  
>  	unsigned long pgsize_bitmap;
>  };
> @@ -442,6 +445,9 @@ extern void iommu_detach_device(struct iommu_domain *domain,
>  extern int iommu_attach_pasid_table(struct iommu_domain *domain,
>  				    struct iommu_pasid_table_config *cfg);
>  extern void iommu_detach_pasid_table(struct iommu_domain *domain);
> +extern int iommu_cache_invalidate(struct iommu_domain *domain,
> +				  struct device *dev,
> +				  struct iommu_cache_invalidate_info *inv_info);
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> @@ -986,6 +992,14 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
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
> index 3976767..ca4b753 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -167,4 +167,114 @@ struct iommu_pasid_table_config {
>  	};
>  };
>  
> +/* defines the granularity of the invalidation */
> +enum iommu_inv_granularity {
> +	IOMMU_INV_GRANU_DOMAIN,	/* domain-selective invalidation */
> +	IOMMU_INV_GRANU_PASID,	/* PASID-selective invalidation */
> +	IOMMU_INV_GRANU_ADDR,	/* page-selective invalidation */
> +	IOMMU_INV_GRANU_NR,	/* number of invalidation granularities */
> +};
> +
> +/**
> + * struct iommu_inv_addr_info - Address Selective Invalidation Structure
> + *
> + * @flags: indicates the granularity of the address-selective invalidation
> + * - If the PASID bit is set, the @pasid field is populated and the invalidation
> + *   relates to cache entries tagged with this PASID and matching the address
> + *   range.
> + * - If ARCHID bit is set, @archid is populated and the invalidation relates
> + *   to cache entries tagged with this architecture specific ID and matching
> + *   the address range.
> + * - Both PASID and ARCHID can be set as they may tag different caches.
> + * - If neither PASID or ARCHID is set, global addr invalidation applies.
> + * - The LEAF flag indicates whether only the leaf PTE caching needs to be
> + *   invalidated and other paging structure caches can be preserved.
> + * @pasid: process address space ID
> + * @archid: architecture-specific ID

Parameter ordering should match between docs and structure.
Might make more sense in some ways to not do so but the kernel-doc
guid states
"The kernel-doc data structure comments describe each member of the structure,
in order, with the @member: descriptions. "

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
> + * struct iommu_inv_pasid_info - PASID Selective Invalidation Structure
> + *
> + * @flags: indicates the granularity of the PASID-selective invalidation
> + * - If the PASID bit is set, the @pasid field is populated and the invalidation
> + *   relates to cache entries tagged with this PASID and matching the address
> + *   range.
> + * - If the ARCHID bit is set, the @archid is populated and the invalidation
> + *   relates to cache entries tagged with this architecture specific ID and
> + *   matching the address range.
> + * - Both PASID and ARCHID can be set as they may tag different caches.
> + * - At least one of PASID or ARCHID must be set.
> + * @pasid: process address space ID
> + * @archid: architecture-specific ID
Ordering of parameters is different from below.
> + */
> +struct iommu_inv_pasid_info {
> +#define IOMMU_INV_PASID_FLAGS_PASID	(1 << 0)
> +#define IOMMU_INV_PASID_FLAGS_ARCHID	(1 << 1)
> +	__u32	flags;
> +	__u32	archid;
> +	__u64	pasid;
> +};
> +
> +/**
> + * struct iommu_cache_invalidate_info - First level/stage invalidation
> + *     information
> + * @version: API version of this structure
> + * @cache: bitfield that allows to select which caches to invalidate
> + * @granularity: defines the lowest granularity used for the invalidation:
> + *     domain > PASID > addr
> + * @padding: reserved for future use (should be zero)
> + * @pasid_info: invalidation data when @granularity is %IOMMU_INV_GRANU_PASID
> + * @addr_info: invalidation data when @granularity is %IOMMU_INV_GRANU_ADDR
> + *
> + * Not all the combinations of cache/granularity are valid:
> + *
> + * +--------------+---------------+---------------+---------------+
> + * | type /       |   DEV_IOTLB   |     IOTLB     |      PASID    |
> + * | granularity  |               |               |      cache    |
> + * +==============+===============+===============+===============+
> + * | DOMAIN       |       N/A     |       Y       |       Y       |
> + * +--------------+---------------+---------------+---------------+
> + * | PASID        |       Y       |       Y       |       Y       |
> + * +--------------+---------------+---------------+---------------+
> + * | ADDR         |       Y       |       Y       |       N/A     |
> + * +--------------+---------------+---------------+---------------+
> + *
> + * Invalidations by %IOMMU_INV_GRANU_DOMAIN don't take any argument other than
> + * @version and @cache.
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
> +#define IOMMU_CACHE_INV_TYPE_NR		(3)
> +	__u8	cache;
> +	__u8	granularity;
> +	__u8	padding[2];
> +	union {
> +		struct iommu_inv_pasid_info pasid_info;
> +		struct iommu_inv_addr_info addr_info;
> +	};
> +};
> +
>  #endif /* _UAPI_IOMMU_H */


