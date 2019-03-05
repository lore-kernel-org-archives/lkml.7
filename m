Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050A3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A0220645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfCESPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:15:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbfCESPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:15:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C077D3087BAE;
        Tue,  5 Mar 2019 18:15:13 +0000 (UTC)
Received: from [10.36.116.102] (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 928E45C207;
        Tue,  5 Mar 2019 18:15:03 +0000 (UTC)
Subject: Re: [PATCH v4 04/22] iommu: Introduce attach/detach_pasid_table API
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, will.deacon@arm.com, robin.murphy@arm.com
Cc:     marc.zyngier@arm.com, peter.maydell@linaro.org,
        kevin.tian@intel.com, ashok.raj@intel.com, christoffer.dall@arm.com
References: <20190218135504.25048-1-eric.auger@redhat.com>
 <20190218135504.25048-5-eric.auger@redhat.com>
 <17894c69-7d64-b85a-be91-0755aeb08ca3@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <65e7e722-61b4-be70-8b8b-0a5047ced1f5@redhat.com>
Date:   Tue, 5 Mar 2019 19:15:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <17894c69-7d64-b85a-be91-0755aeb08ca3@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 05 Mar 2019 18:15:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 3/5/19 4:23 PM, Jean-Philippe Brucker wrote:
> On 18/02/2019 13:54, Eric Auger wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>
>> In virtualization use case, when a guest is assigned
>> a PCI host device, protected by a virtual IOMMU on the guest,
>> the physical IOMMU must be programmed to be consistent with
>> the guest mappings. If the physical IOMMU supports two
>> translation stages it makes sense to program guest mappings
>> onto the first stage/level (ARM/Intel terminology) while the host
>> owns the stage/level 2.
>>
>> In that case, it is mandated to trap on guest configuration
>> settings and pass those to the physical iommu driver.
>>
>> This patch adds a new API to the iommu subsystem that allows
>> to set/unset the pasid table information.
>>
>> A generic iommu_pasid_table_config struct is introduced in
>> a new iommu.h uapi header. This is going to be used by the VFIO
>> user API.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> This patch generalizes the API introduced by Jacob & co-authors in
>> https://lwn.net/Articles/754331/
>>
>> v3 -> v4:
>> - s/set_pasid_table/attach_pasid_table
>> - restore detach_pasid_table. Detach can be used on unwind path.
>> - add padding
>> - remove @abort
>> - signature used for config and format
>> - add comments for fields in the SMMU struct
>>
>> v2 -> v3:
>> - replace unbind/bind by set_pasid_table
>> - move table pointer and pasid bits in the generic part of the struct
>>
>> v1 -> v2:
>> - restore the original pasid table name
>> - remove the struct device * parameter in the API
>> - reworked iommu_pasid_smmuv3
>> ---
>>  drivers/iommu/iommu.c      | 19 +++++++++++++++
>>  include/linux/iommu.h      | 22 ++++++++++++++++++
>>  include/uapi/linux/iommu.h | 47 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 88 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index c297cdcf7f89..b3adb77cb14c 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1545,6 +1545,25 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_attach_device);
>>  
>> +int iommu_attach_pasid_table(struct iommu_domain *domain,
>> +			     struct iommu_pasid_table_config *cfg)
>> +{
>> +	if (unlikely(!domain->ops->attach_pasid_table))
>> +		return -ENODEV;
>> +
>> +	return domain->ops->attach_pasid_table(domain, cfg);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_attach_pasid_table);
>> +
>> +void iommu_detach_pasid_table(struct iommu_domain *domain)
>> +{
>> +	if (unlikely(!domain->ops->detach_pasid_table))
>> +		return;
>> +
>> +	domain->ops->detach_pasid_table(domain);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
>> +
>>  static void __iommu_detach_device(struct iommu_domain *domain,
>>  				  struct device *dev)
>>  {
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index b38e0c100940..7045e26f3a7d 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -187,6 +187,8 @@ struct iommu_resv_region {
>>   * @domain_window_disable: Disable a particular window for a domain
>>   * @of_xlate: add OF master IDs to iommu grouping
>>   * @pgsize_bitmap: bitmap of all possible supported page sizes
>> + * @attach_pasid_table: attach a pasid table
>> + * @detach_pasid_table: detach the pasid table
> 
> Should go before pgsize_bitmap
sure
> 
>>   */
>>  struct iommu_ops {
>>  	bool (*capable)(enum iommu_cap);
>> @@ -229,6 +231,10 @@ struct iommu_ops {
>>  	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
>>  	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
>>  
>> +	int (*attach_pasid_table)(struct iommu_domain *domain,
>> +				  struct iommu_pasid_table_config *cfg);
>> +	void (*detach_pasid_table)(struct iommu_domain *domain);
>> +
>>  	unsigned long pgsize_bitmap;
>>  };
>>  
>> @@ -339,6 +345,9 @@ extern int iommu_attach_device(struct iommu_domain *domain,
>>  			       struct device *dev);
>>  extern void iommu_detach_device(struct iommu_domain *domain,
>>  				struct device *dev);
>> +extern int iommu_attach_pasid_table(struct iommu_domain *domain,
>> +				    struct iommu_pasid_table_config *cfg);
>> +extern void iommu_detach_pasid_table(struct iommu_domain *domain);
>>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>>  extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>> @@ -777,6 +786,19 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>>  	return NULL;
>>  }
>>  
>> +static inline
>> +int iommu_attach_pasid_table(struct iommu_domain *domain,
>> +			     struct iommu_pasid_table_config *cfg)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline
>> +void iommu_detach_pasid_table(struct iommu_domain *domain)
>> +{
>> +	return -ENODEV;
> 
> No return here. With that fixed:
oups
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Thanks!

Eric

> 
>> +}
>> +
>>  #endif /* CONFIG_IOMMU_API */
>>  
>>  #ifdef CONFIG_IOMMU_DEBUGFS
>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>> index 7ebf23ed6ccb..e9065bfa5b24 100644
>> --- a/include/uapi/linux/iommu.h
>> +++ b/include/uapi/linux/iommu.h
>> @@ -112,4 +112,51 @@ struct iommu_fault {
>>  		struct iommu_fault_page_request prm;
>>  	};
>>  };
>> +
>> +/**
>> + * SMMUv3 Stream Table Entry stage 1 related information
>> + * The PASID table is referred to as the context descriptor (CD) table.
>> + *
>> + * @s1fmt: STE s1fmt (format of the CD table: single CD, linear table
>> +   or 2-level table)
>> + * @s1dss: STE s1dss (specifies the behavior when pasid_bits != 0
>> +   and no pasid is passed along with the incoming transaction)
>> + * Please refer to the smmu 3.x spec (ARM IHI 0070A) for full details
>> + */
>> +struct iommu_pasid_smmuv3 {
>> +#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
>> +	__u32	version;
>> +	__u8 s1fmt;
>> +	__u8 s1dss;
>> +	__u8 padding[2];
>> +};
>> +
>> +/**
>> + * PASID table data used to bind guest PASID table to the host IOMMU
>> + * Note PASID table corresponds to the Context Table on ARM SMMUv3.
>> + *
>> + * @version: API version to prepare for future extensions
>> + * @format: format of the PASID table
>> + * @base_ptr: guest physical address of the PASID table
>> + * @pasid_bits: number of PASID bits used in the PASID table
>> + * @config: indicates whether the guest translation stage must
>> + * be translated, bypassed or aborted.
>> + */
>> +struct iommu_pasid_table_config {
>> +#define PASID_TABLE_CFG_VERSION_1 1
>> +	__u32	version;
>> +#define IOMMU_PASID_FORMAT_SMMUV3	1
>> +	__u32	format;
>> +	__u64	base_ptr;
>> +	__u8	pasid_bits;
>> +#define IOMMU_PASID_CONFIG_TRANSLATE	1
>> +#define IOMMU_PASID_CONFIG_BYPASS	2
>> +#define IOMMU_PASID_CONFIG_ABORT	3
>> +	__u8	config;
>> +	__u8    padding[6];
>> +	union {
>> +		struct iommu_pasid_smmuv3 smmuv3;
>> +	};
>> +};
>> +
>>  #endif /* _UAPI_IOMMU_H */
>>
> 
