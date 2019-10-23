Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8708CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58807207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbfJWCY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 22:24:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:18196 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729994AbfJWCYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:24:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 19:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,219,1569308400"; 
   d="scan'208";a="196639623"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2019 19:24:21 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v6 02/10] iommu/vt-d: Add custom allocator for IOASID
To:     "Raj, Ashok" <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571788403-42095-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <20191023005129.GC100970@otc-nc-03>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0a0f33b8-e3d8-3d29-ca71-552f1875bc62@linux.intel.com>
Date:   Wed, 23 Oct 2019 10:21:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023005129.GC100970@otc-nc-03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/23/19 8:51 AM, Raj, Ashok wrote:
> On Tue, Oct 22, 2019 at 04:53:15PM -0700, Jacob Pan wrote:
>> When VT-d driver runs in the guest, PASID allocation must be
>> performed via virtual command interface. This patch registers a
>> custom IOASID allocator which takes precedence over the default
>> XArray based allocator. The resulting IOASID allocation will always
>> come from the host. This ensures that PASID namespace is system-
>> wide.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> ---
>>   drivers/iommu/Kconfig       |  1 +
>>   drivers/iommu/intel-iommu.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/intel-iommu.h |  2 ++
>>   3 files changed, 70 insertions(+)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index fd50ddffffbf..961fe5795a90 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -211,6 +211,7 @@ config INTEL_IOMMU_SVM
>>   	bool "Support for Shared Virtual Memory with Intel IOMMU"
>>   	depends on INTEL_IOMMU && X86
>>   	select PCI_PASID
>> +	select IOASID
>>   	select MMU_NOTIFIER
>>   	help
>>   	  Shared Virtual Memory (SVM) provides a facility for devices
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 3f974919d3bd..3aff0141c522 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1706,6 +1706,8 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>>   		if (ecap_prs(iommu->ecap))
>>   			intel_svm_finish_prq(iommu);
>>   	}
>> +	ioasid_unregister_allocator(&iommu->pasid_allocator);
>> +
>>   #endif
>>   }
>>   
>> @@ -4910,6 +4912,46 @@ static int __init probe_acpi_namespace_devices(void)
>>   	return 0;
>>   }
>>   
>> +#ifdef CONFIG_INTEL_IOMMU_SVM
> 
> Maybe move them to intel-svm.c instead? that's where the bulk
> of the svm support is?

I think this is a generic PASID allocator for guest IOMMU although vSVA
is currently the only consumer. Instead of making it SVM specific, I'd
like to suggest moving it to intel-pasid.c and replace the @svm
parameter with a void * one in intel_ioasid_free().

> 
>> +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
>> +{
>> +	struct intel_iommu *iommu = data;
>> +	ioasid_t ioasid;
>> +
>> +	/*
>> +	 * VT-d virtual command interface always uses the full 20 bit
>> +	 * PASID range. Host can partition guest PASID range based on
>> +	 * policies but it is out of guest's control.
>> +	 */
>> +	if (min < PASID_MIN || max > PASID_MAX)
>> +		return INVALID_IOASID;
> 
> What are these PASID_MIN/MAX? Do you check if these are within the
> limits supported by the iommu/vIOMMU as its enumerated?
> 

Is it an invalid request when @max is greater than hardware capability?

Say, the consumer is asking for allocate a PASID within [0, 2^20], while
the PASID pool of the allocator is just, say, [4, 2^19] with others
reserved for other special usage or due to iommu capability. Instead
of returning error, why not just allocating a PASID within [2, 2^19]?

In another word, final allocation range should be Range[allocator 
supported] & Range[customer specified]. Please correct me if I missed
anything.

> 
>> +
>> +	if (vcmd_alloc_pasid(iommu, &ioasid))
>> +		return INVALID_IOASID;
>> +
>> +	return ioasid;
>> +}
>> +
>> +static void intel_ioasid_free(ioasid_t ioasid, void *data)
>> +{
>> +	struct iommu_pasid_alloc_info *svm;
>> +	struct intel_iommu *iommu = data;
>> +
>> +	if (!iommu)
>> +		return;
>> +	/*
>> +	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
>> +	 * We can only free the PASID when all the devices are unbond.
>> +	 */
>> +	svm = ioasid_find(NULL, ioasid, NULL);
>> +	if (!svm) {
>> +		pr_warn("Freeing unbond IOASID %d\n", ioasid);
>> +		return;
>> +	}
>> +	vcmd_free_pasid(iommu, ioasid);
>> +}
>> +#endif
>> +
>>   int __init intel_iommu_init(void)
>>   {
>>   	int ret = -ENODEV;
>> @@ -5020,6 +5062,31 @@ int __init intel_iommu_init(void)
>>   				       "%s", iommu->name);
>>   		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
>>   		iommu_device_register(&iommu->iommu);
>> +#ifdef CONFIG_INTEL_IOMMU_SVM
>> +		if (cap_caching_mode(iommu->cap) && sm_supported(iommu)) {
> 
> do you need to check against cap_caching_mode() or ecap_vcmd?
> 
> 
>> +			/*
>> +			 * Register a custom ASID allocator if we are running
>> +			 * in a guest, the purpose is to have a system wide PASID
>> +			 * namespace among all PASID users.
>> +			 * There can be multiple vIOMMUs in each guest but only
>> +			 * one allocator is active. All vIOMMU allocators will
>> +			 * eventually be calling the same host allocator.
>> +			 */
>> +			iommu->pasid_allocator.alloc = intel_ioasid_alloc;
>> +			iommu->pasid_allocator.free = intel_ioasid_free;
>> +			iommu->pasid_allocator.pdata = (void *)iommu;
>> +			ret = ioasid_register_allocator(&iommu->pasid_allocator);
>> +			if (ret) {
>> +				pr_warn("Custom PASID allocator registeration failed\n");
>> +				/*
>> +				 * Disable scalable mode on this IOMMU if there
>> +				 * is no custom allocator. Mixing SM capable vIOMMU
>> +				 * and non-SM vIOMMU are not supported.
>> +				 */
>> +				intel_iommu_sm = 0;
>> +			}
>> +		}
>> +#endif

I think this should also be moved to intel-pasid.c and made it svm
independent as a generic pasid allocator for IOMMU running in a vm guest
or user level application.

Best regards,
baolu

>>   	}
>>   
>>   	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index eea7468694a7..fb1973a761c1 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -19,6 +19,7 @@
>>   #include <linux/iommu.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/dmar.h>
>> +#include <linux/ioasid.h>
>>   
>>   #include <asm/cacheflush.h>
>>   #include <asm/iommu.h>
>> @@ -542,6 +543,7 @@ struct intel_iommu {
>>   #ifdef CONFIG_INTEL_IOMMU_SVM
>>   	struct page_req_dsc *prq;
>>   	unsigned char prq_name[16];    /* Name for PRQ interrupt */
>> +	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
>>   #endif
>>   	struct q_inval  *qi;            /* Queued invalidation info */
>>   	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
>> -- 
>> 2.7.4
>>
> 
