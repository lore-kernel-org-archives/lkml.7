Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9142064A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfCZBQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:16:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:46706 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfCZBQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:16:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 18:16:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,270,1549958400"; 
   d="scan'208";a="130142763"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 25 Mar 2019 18:16:03 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
 iommu_get_resv_regions
To:     James Sewart <jamessewart@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
 <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
 <A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
 <fb1565dc-d991-acf9-e275-c0090f69f47e@linux.intel.com>
 <445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5f8f4829-5443-1ab5-85af-636d2f42ad52@linux.intel.com>
Date:   Tue, 26 Mar 2019 09:10:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/25/19 8:57 PM, James Sewart wrote:
> Hey Lu,
> 
>> On 25 Mar 2019, at 02:03, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi James,
>>
>> On 3/22/19 5:57 PM, James Sewart wrote:
>>> Hey Lu,
>>>> On 15 Mar 2019, at 02:19, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>
>>>> Hi James,
>>>>
>>>> On 3/14/19 7:58 PM, James Sewart wrote:
>>>>> To support mapping ISA region via iommu_group_create_direct_mappings,
>>>>> make sure its exposed by iommu_get_resv_regions. This allows
>>>>> deduplication of reserved region mappings
>>>>> Signed-off-by: James Sewart <jamessewart@arista.com>
>>>>> ---
>>>>>   drivers/iommu/intel-iommu.c | 42 +++++++++++++++++++++++++++++--------
>>>>>   1 file changed, 33 insertions(+), 9 deletions(-)
>>>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>>>> index 8e0a4e2ff77f..2e00e8708f06 100644
>>>>> --- a/drivers/iommu/intel-iommu.c
>>>>> +++ b/drivers/iommu/intel-iommu.c
>>>>> @@ -337,6 +337,8 @@ static LIST_HEAD(dmar_rmrr_units);
>>>>>   #define for_each_rmrr_units(rmrr) \
>>>>>   	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
>>>>>   +static struct iommu_resv_region *isa_resv_region;
>>>>> +
>>>>>   /* bitmap for indexing intel_iommus */
>>>>>   static int g_num_of_iommus;
>>>>>   @@ -2780,26 +2782,34 @@ static inline int iommu_prepare_rmrr_dev(struct dmar_rmrr_unit *rmrr,
>>>>>   					  rmrr->end_address);
>>>>>   }
>>>>>   +static inline struct iommu_resv_region *iommu_get_isa_resv_region(void)
>>>>> +{
>>>>> +	if (!isa_resv_region)
>>>>> +		isa_resv_region = iommu_alloc_resv_region(0,
>>>>> +				16*1024*1024,
>>>>> +				0, IOMMU_RESV_DIRECT);
>>>>> +
>>>>> +	return isa_resv_region;
>>>>> +}
>>>>> +
>>>>>   #ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>>>>> -static inline void iommu_prepare_isa(void)
>>>>> +static inline void iommu_prepare_isa(struct pci_dev *pdev)
>>>>>   {
>>>>> -	struct pci_dev *pdev;
>>>>>   	int ret;
>>>>> +	struct iommu_resv_region *reg = iommu_get_isa_resv_region();
>>>>>   -	pdev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
>>>>> -	if (!pdev)
>>>>> +	if (!reg)
>>>>>   		return;
>>>>>     	pr_info("Prepare 0-16MiB unity mapping for LPC\n");
>>>>> -	ret = iommu_prepare_identity_map(&pdev->dev, 0, 16*1024*1024 - 1);
>>>>> +	ret = iommu_prepare_identity_map(&pdev->dev, reg->start,
>>>>> +			reg->start + reg->length - 1);
>>>>>     	if (ret)
>>>>>   		pr_err("Failed to create 0-16MiB identity map - floppy might not work\n");
>>>>> -
>>>>> -	pci_dev_put(pdev);
>>>>>   }
>>>>>   #else
>>>>> -static inline void iommu_prepare_isa(void)
>>>>> +static inline void iommu_prepare_isa(struct pci_dev *pdev)
>>>>>   {
>>>>>   	return;
>>>>>   }
>>>>> @@ -3289,6 +3299,7 @@ static int __init init_dmars(void)
>>>>>   	struct dmar_rmrr_unit *rmrr;
>>>>>   	bool copied_tables = false;
>>>>>   	struct device *dev;
>>>>> +	struct pci_dev *pdev;
>>>>>   	struct intel_iommu *iommu;
>>>>>   	int i, ret;
>>>>>   @@ -3469,7 +3480,11 @@ static int __init init_dmars(void)
>>>>>   		}
>>>>>   	}
>>>>>   -	iommu_prepare_isa();
>>>>> +	pdev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
>>>>> +	if (pdev) {
>>>>> +		iommu_prepare_isa(pdev);
>>>>> +		pci_dev_put(pdev);
>>>>> +	}
>>>>>     domains_done:
>>>>>   @@ -5266,6 +5281,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
>>>>>   	struct iommu_resv_region *reg;
>>>>>   	struct dmar_rmrr_unit *rmrr;
>>>>>   	struct device *i_dev;
>>>>> +	struct pci_dev *pdev;
>>>>>   	int i;
>>>>>     	rcu_read_lock();
>>>>> @@ -5280,6 +5296,14 @@ static void intel_iommu_get_resv_regions(struct device *device,
>>>>>   	}
>>>>>   	rcu_read_unlock();
>>>>>   +	if (dev_is_pci(device)) {
>>>>> +		pdev = to_pci_dev(device);
>>>>> +		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
>>>>> +			reg = iommu_get_isa_resv_region();
>>>>> +			list_add_tail(&reg->list, head);
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>
>>>> Just wondering why not just
>>>>
>>>> +#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>>>> +	if (dev_is_pci(device)) {
>>>> +		pdev = to_pci_dev(device);
>>>> +		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
>>>> +			reg = iommu_alloc_resv_region(0,
>>>> +				16*1024*1024,
>>>> +				0, IOMMU_RESV_DIRECT);
>>>> +			if (reg)
>>>> +				list_add_tail(&reg->list, head);
>>>> +		}
>>>> +	}
>>>> +#endif
>>>>
>>>> and, remove all other related code?
>>> At this point in the patchset if we remove iommu_prepare_isa then the ISA
>>> region won’t be mapped to the device. Only once the dma domain is allocable
>>> will the reserved regions be mapped by iommu_group_create_direct_mappings.
>>
>> Yes. So if we put the allocation code here, it won't impact anything and
>> will take effect as soon as the dma domain is allocatable.
>>
>>> Theres an issue that if we choose to alloc a new resv_region with type
>>> IOMMU_RESV_DIRECT, we will need to refactor intel_iommu_put_resv_regions
>>> to free this entry type which means refactoring the rmrr regions in
>>> get_resv_regions. Should this work be in this patchset?
>>
>> Do you mean the rmrr regions are not allocated in get_resv_regions, but
>> are freed in put_resv_regions? I think we should fix this in this patch
>> set since this might impact the device passthrough if we don't do it.
> 
> They’re not allocated and not freed currently, only type IOMMU_RESV_MSI is
> freed in put_resv_regions. If we allocate a new resv_region with type
> IOMMU_RESV_DIRECT for the isa region, then it won’t be freed. If we modify
> put_resv_regions to free type IOMMU_RESV_DIRECT, then we will try to free
> the static RMRR regions.

Ah yes! Thanks for the explanation.

> 
> Either the ISA region is static and not freed as with my implementation,
> or the RMRR regions are converted to be allocated on each call to
> get_resv_regions and freed in put_resv_regions.

Okay, I second your implementation now.

> 
>>
>> Best regards,
>> Lu Baolu
> 
> Cheers,
> James.
> 

Best regards,
Lu Baolu
