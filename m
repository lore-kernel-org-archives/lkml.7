Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ED7C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F1A23BAB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfE2Pn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfE2Pn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:43:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 664FE4CF7E;
        Wed, 29 May 2019 15:43:51 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5B3E5C5DF;
        Wed, 29 May 2019 15:43:43 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v5 7/7] iommu/vt-d: Differentiate relaxable and non
 relaxable RMRRs
To:     Lu Baolu <baolu.lu@linux.intel.com>, eric.auger.pro@gmail.com,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        robin.murphy@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jean-philippe.brucker@arm.com
References: <20190528115025.17194-1-eric.auger@redhat.com>
 <20190528115025.17194-8-eric.auger@redhat.com>
 <13a77738-5e85-ea62-aab1-384c75bde8bd@linux.intel.com>
Message-ID: <1f2a7039-04be-383e-b054-d0dba99b9bdf@redhat.com>
Date:   Wed, 29 May 2019 17:43:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <13a77738-5e85-ea62-aab1-384c75bde8bd@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 29 May 2019 15:43:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On 5/29/19 4:34 AM, Lu Baolu wrote:
> Hi,
> 
> On 5/28/19 7:50 PM, Eric Auger wrote:
>> Now we have a new IOMMU_RESV_DIRECT_RELAXABLE reserved memory
>> region type, let's report USB and GFX RMRRs as relaxable ones.
>>
>> We introduce a new device_rmrr_is_relaxable() helper to check
>> whether the rmrr belongs to the relaxable category.
>>
>> This allows to have a finer reporting at IOMMU API level of
>> reserved memory regions. This will be exploitable by VFIO to
>> define the usable IOVA range and detect potential conflicts
>> between the guest physical address space and host reserved
>> regions.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v3 -> v4:
>> - introduce device_rmrr_is_relaxable and reshuffle the comments
>> ---
>>   drivers/iommu/intel-iommu.c | 55 +++++++++++++++++++++++++++----------
>>   1 file changed, 40 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 9302351818ab..01c82f848470 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2920,6 +2920,36 @@ static bool device_has_rmrr(struct device *dev)
>>       return false;
>>   }
>>   +/*
>> + * device_rmrr_is_relaxable - Test whether the RMRR of this device
>> + * is relaxable (ie. is allowed to be not enforced under some
>> conditions)
>> + *
>> + * @dev: device handle
>> + *
>> + * We assume that PCI USB devices with RMRRs have them largely
>> + * for historical reasons and that the RMRR space is not actively
>> used post
>> + * boot.  This exclusion may change if vendors begin to abuse it.
>> + *
>> + * The same exception is made for graphics devices, with the
>> requirement that
>> + * any use of the RMRR regions will be torn down before assigning the
>> device
>> + * to a guest.
>> + *
>> + * Return: true if the RMRR is relaxable
>> + */
>> +static bool device_rmrr_is_relaxable(struct device *dev)
>> +{
>> +    struct pci_dev *pdev;
>> +
>> +    if (!dev_is_pci(dev))
>> +        return false;
>> +
>> +    pdev = to_pci_dev(dev);
>> +    if (IS_USB_DEVICE(pdev) || IS_GFX_DEVICE(pdev))
>> +        return true;
>> +    else
>> +        return false;
>> +}
> 
> I know this is only code refactoring. But strictly speaking, the rmrr of
> any USB host device is ignorable only if quirk_usb_early_handoff() has
> been called. There, the control of USB host controller will be handed
> over from BIOS to OS and the corresponding SMI are disabled.
> 
> This function is registered in drivers/usb/host/pci-quirks.c
> 
> DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
>                         PCI_CLASS_SERIAL_USB, 8, quirk_usb_early_handoff);
> 
> and only get compiled if CONFIG_USB_PCI is enabled.
> 
> Hence, it's safer to say:
> 
> +#ifdef CONFIG_USB_PCI
> +    if (IS_USB_DEVICE(pdev))
> +        return true;
> +#endif /* CONFIG_USB_PCI */
> 
> I am okay if we keep this untouched and make this change within a
> separated patch.

As we first checked whether the device was a pci device, isn't it
sufficient to guarantee the quirk is setup?

As you suggested, I am inclined to keep it as a separate patch anyway.

Thank you for the review!

Best Regards

Eric
> 
>> +
>>   /*
>>    * There are a couple cases where we need to restrict the
>> functionality of
>>    * devices associated with RMRRs.  The first is when evaluating a
>> device for
>> @@ -2934,25 +2964,16 @@ static bool device_has_rmrr(struct device *dev)
>>    * We therefore prevent devices associated with an RMRR from
>> participating in
>>    * the IOMMU API, which eliminates them from device assignment.
>>    *
>> - * In both cases we assume that PCI USB devices with RMRRs have them
>> largely
>> - * for historical reasons and that the RMRR space is not actively
>> used post
>> - * boot.  This exclusion may change if vendors begin to abuse it.
>> - *
>> - * The same exception is made for graphics devices, with the
>> requirement that
>> - * any use of the RMRR regions will be torn down before assigning the
>> device
>> - * to a guest.
>> + * In both cases, devices which have relaxable RMRRs are not
>> concerned by this
>> + * restriction. See device_rmrr_is_relaxable comment.
>>    */
>>   static bool device_is_rmrr_locked(struct device *dev)
>>   {
>>       if (!device_has_rmrr(dev))
>>           return false;
>>   -    if (dev_is_pci(dev)) {
>> -        struct pci_dev *pdev = to_pci_dev(dev);
>> -
>> -        if (IS_USB_DEVICE(pdev) || IS_GFX_DEVICE(pdev))
>> -            return false;
>> -    }
>> +    if (device_rmrr_is_relaxable(dev))
>> +        return false;
>>         return true;
>>   }
>> @@ -5494,6 +5515,7 @@ static void intel_iommu_get_resv_regions(struct
>> device *device,
>>           for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
>>                         i, i_dev) {
>>               struct iommu_resv_region *resv;
>> +            enum iommu_resv_type type;
>>               size_t length;
>>                 if (i_dev != device &&
>> @@ -5501,9 +5523,12 @@ static void intel_iommu_get_resv_regions(struct
>> device *device,
>>                   continue;
>>                 length = rmrr->end_address - rmrr->base_address + 1;
>> +
>> +            type = device_rmrr_is_relaxable(device) ?
>> +                IOMMU_RESV_DIRECT_RELAXABLE : IOMMU_RESV_DIRECT;
>> +
>>               resv = iommu_alloc_resv_region(rmrr->base_address,
>> -                               length, prot,
>> -                               IOMMU_RESV_DIRECT);
>> +                               length, prot, type);
>>               if (!resv)
>>                   break;
>>  
> 
> Other looks good to me.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Best regards,
> Baolu
