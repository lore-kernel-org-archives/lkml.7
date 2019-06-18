Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4810C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C7E20673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfFRPlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:41:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729349AbfFRPlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:41:53 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CF6C394442611AB97EC6;
        Tue, 18 Jun 2019 23:41:44 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Jun 2019
 23:41:40 +0800
Date:   Tue, 18 Jun 2019 16:41:28 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Eric Auger" <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi L <yi.l.liu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        <Liu@mail.linuxfoundation.org>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 08/22] iommu: Introduce attach/detach_pasid_table API
Message-ID: <20190618164128.0000204f@huawei.com>
In-Reply-To: <1560087862-57608-9-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-9-git-send-email-jacob.jun.pan@linux.intel.com>
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

On Sun, 9 Jun 2019 06:44:08 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> In virtualization use case, when a guest is assigned
> a PCI host device, protected by a virtual IOMMU on the guest,
> the physical IOMMU must be programmed to be consistent with
> the guest mappings. If the physical IOMMU supports two
> translation stages it makes sense to program guest mappings
> onto the first stage/level (ARM/Intel terminology) while the host
> owns the stage/level 2.
> 
> In that case, it is mandated to trap on guest configuration
> settings and pass those to the physical iommu driver.
> 
> This patch adds a new API to the iommu subsystem that allows
> to set/unset the pasid table information.
> 
> A generic iommu_pasid_table_config struct is introduced in
> a new iommu.h uapi header. This is going to be used by the VFIO
> user API.

Another case where strictly speaking stuff is introduced that this series
doesn't use.  I don't know what the plans are to merge the various
related series though so this might make sense in general. Right now
it just bloats this series a bit..
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/iommu.c      | 19 +++++++++++++++++
>  include/linux/iommu.h      | 18 ++++++++++++++++
>  include/uapi/linux/iommu.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 89 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 166adb8..4496ccd 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1619,6 +1619,25 @@ int iommu_page_response(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(iommu_page_response);
>  
> +int iommu_attach_pasid_table(struct iommu_domain *domain,
> +			     struct iommu_pasid_table_config *cfg)
> +{
> +	if (unlikely(!domain->ops->attach_pasid_table))
> +		return -ENODEV;
> +
> +	return domain->ops->attach_pasid_table(domain, cfg);
> +}
> +EXPORT_SYMBOL_GPL(iommu_attach_pasid_table);
> +
> +void iommu_detach_pasid_table(struct iommu_domain *domain)
> +{
> +	if (unlikely(!domain->ops->detach_pasid_table))
> +		return;
> +
> +	domain->ops->detach_pasid_table(domain);
> +}
> +EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 950347b..d3edb10 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -264,6 +264,8 @@ struct page_response_msg {
>   * @sva_unbind: Unbind process address space from device
>   * @sva_get_pasid: Get PASID associated to a SVA handle
>   * @page_response: handle page request response
> + * @attach_pasid_table: attach a pasid table
> + * @detach_pasid_table: detach the pasid table
>   * @pgsize_bitmap: bitmap of all possible supported page sizes
>   */
>  struct iommu_ops {
> @@ -323,6 +325,9 @@ struct iommu_ops {
>  				      void *drvdata);
>  	void (*sva_unbind)(struct iommu_sva *handle);
>  	int (*sva_get_pasid)(struct iommu_sva *handle);
> +	int (*attach_pasid_table)(struct iommu_domain *domain,
> +				  struct iommu_pasid_table_config *cfg);
> +	void (*detach_pasid_table)(struct iommu_domain *domain);
>  
>  	int (*page_response)(struct device *dev, struct page_response_msg *msg);
>  
> @@ -434,6 +439,9 @@ extern int iommu_attach_device(struct iommu_domain *domain,
>  			       struct device *dev);
>  extern void iommu_detach_device(struct iommu_domain *domain,
>  				struct device *dev);
> +extern int iommu_attach_pasid_table(struct iommu_domain *domain,
> +				    struct iommu_pasid_table_config *cfg);
> +extern void iommu_detach_pasid_table(struct iommu_domain *domain);
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> @@ -947,6 +955,13 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>  	return -ENODEV;
>  }
>  
> +static inline
> +int iommu_attach_pasid_table(struct iommu_domain *domain,
> +			     struct iommu_pasid_table_config *cfg)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline struct iommu_sva *
>  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>  {
> @@ -968,6 +983,9 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
>  	return IOMMU_PASID_INVALID;
>  }
>  
> +static inline
> +void iommu_detach_pasid_table(struct iommu_domain *domain) {}
> +
>  #endif /* CONFIG_IOMMU_API */
>  
>  #ifdef CONFIG_IOMMU_DEBUGFS
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index aaa3b6a..3976767 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -115,4 +115,56 @@ struct iommu_fault {
>  		struct iommu_fault_page_request prm;
>  	};
>  };
> +
> +/**
> + * struct iommu_pasid_smmuv3 - ARM SMMUv3 Stream Table Entry stage 1 related
> + *     information
> + * @version: API version of this structure
> + * @s1fmt: STE s1fmt (format of the CD table: single CD, linear table
> + *         or 2-level table)
> + * @s1dss: STE s1dss (specifies the behavior when @pasid_bits != 0
> + *         and no PASID is passed along with the incoming transaction)
> + * @padding: reserved for future use (should be zero)
> + *
> + * The PASID table is referred to as the Context Descriptor (CD) table on ARM
> + * SMMUv3. Please refer to the ARM SMMU 3.x spec (ARM IHI 0070A) for full
> + * details.
> + */
> +struct iommu_pasid_smmuv3 {
> +#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
> +	__u32	version;
> +	__u8	s1fmt;
> +	__u8	s1dss;
> +	__u8	padding[2];
> +};
> +
> +/**
> + * struct iommu_pasid_table_config - PASID table data used to bind guest PASID
> + *     table to the host IOMMU
> + * @version: API version to prepare for future extensions
> + * @format: format of the PASID table
> + * @base_ptr: guest physical address of the PASID table
> + * @pasid_bits: number of PASID bits used in the PASID table
> + * @config: indicates whether the guest translation stage must
> + *          be translated, bypassed or aborted.
> + * @padding: reserved for future use (should be zero)
> + * @smmuv3: table information when @format is %IOMMU_PASID_FORMAT_SMMUV3
> + */
> +struct iommu_pasid_table_config {
> +#define PASID_TABLE_CFG_VERSION_1 1
> +	__u32	version;
> +#define IOMMU_PASID_FORMAT_SMMUV3	1
> +	__u32	format;
> +	__u64	base_ptr;
> +	__u8	pasid_bits;
> +#define IOMMU_PASID_CONFIG_TRANSLATE	1
> +#define IOMMU_PASID_CONFIG_BYPASS	2
> +#define IOMMU_PASID_CONFIG_ABORT	3
> +	__u8	config;
> +	__u8    padding[6];
> +	union {
> +		struct iommu_pasid_smmuv3 smmuv3;
> +	};
> +};
> +
>  #endif /* _UAPI_IOMMU_H */


