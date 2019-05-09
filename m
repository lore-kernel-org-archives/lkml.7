Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF66C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783BC20989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEIEiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 00:38:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:58762 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfEIEiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 00:38:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 21:38:07 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 08 May 2019 21:38:06 -0700
Cc:     baolu.lu@linux.intel.com, Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
Subject: Re: [PATCH v3 5/8] iommu/vt-d: Implement def_domain_type iommu ops
 entry
To:     Tom Murphy <tmurphy@arista.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
 <20190429020925.18136-6-baolu.lu@linux.intel.com>
 <20190429200338.GA8412@infradead.org>
 <9c1d1e16-fdab-0494-8720-97ff20013da4@linux.intel.com>
 <CAPL0++6UmAzVQCm0MBD056DsA-13qVTSK1x737tXXkFzooWzNA@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bb0122b9-9001-415d-807f-aa4f4dcf0b85@linux.intel.com>
Date:   Thu, 9 May 2019 12:31:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPL0++6UmAzVQCm0MBD056DsA-13qVTSK1x737tXXkFzooWzNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/6/19 11:25 PM, Tom Murphy wrote:
> It looks like there is a bug in this code.
> 
> The behavior before this patch in __intel_map_single was that
> iommu_no_mapping would call remove the attached si_domain for 32 bit
> devices  (in the  dmar_remove_one_dev_info(dev) call in
> iommu_no_mapping) and then allocate a new domain in
> get_valid_domain_for_dev
> old:
> if (iommu_no_mapping(dev))
>     return paddr;
> domain = get_valid_domain_for_dev(dev);
> if (!domain)
>     return DMA_MAPPING_ERROR;
> 
> but in the new code we remove the attached si_domain but we WON'T
> allocate a new domain and instead just return an error when we call
> find_domain
> new:
>          if (iommu_no_mapping(dev))
>                  return paddr;
> 
>          domain = find_domain(dev);
>          if (!domain)
>                  return DMA_MAPPING_ERROR;
> 
> This is a bug, right?

When we use the old lazy creation of iommu domain, we can change the
domain for a 32bit device from identity to dma by pulling it out of the
si_domain and allocating a new one for it.

When we switch to default domain in iommu generic layer, we can't do
this anymore. The logic in above code is if we find this case (32bit
device using an identity domain), we simple return error for dma api
and warn the user "hey, this is a 32bit device, don't use the default
pass-through mode".

I believe there should be better solutions, for example, how about
letting pci core to call iommu_request_dma_map_for_dev() when it
finds a 32bit device.

Best regards,
Lu Baolu

> 
> On Tue, Apr 30, 2019 at 3:18 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi Christoph,
>>
>> On 4/30/19 4:03 AM, Christoph Hellwig wrote:
>>>> @@ -3631,35 +3607,30 @@ static int iommu_no_mapping(struct device *dev)
>>>>       if (iommu_dummy(dev))
>>>>               return 1;
>>>>
>>>> -    if (!iommu_identity_mapping)
>>>> -            return 0;
>>>> -
>>>
>>> FYI, iommu_no_mapping has been refactored in for-next:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=x86/vt-d&id=48b2c937ea37a3bece0094b46450ed5267525289
>>
>> Oh, yes! Thanks for letting me know this. Will rebase the code.
>>
>>>
>>>>       found = identity_mapping(dev);
>>>>       if (found) {
>>>> +            /*
>>>> +             * If the device's dma_mask is less than the system's memory
>>>> +             * size then this is not a candidate for identity mapping.
>>>> +             */
>>>> +            u64 dma_mask = *dev->dma_mask;
>>>> +
>>>> +            if (dev->coherent_dma_mask &&
>>>> +                dev->coherent_dma_mask < dma_mask)
>>>> +                    dma_mask = dev->coherent_dma_mask;
>>>> +
>>>> +            if (dma_mask < dma_get_required_mask(dev)) {
>>>
>>> I know this is mostly existing code moved around, but it really needs
>>> some fixing.  For one dma_get_required_mask is supposed to return the
>>> required to not bounce mask for the given device.  E.g. for a device
>>> behind an iommu it should always just return 32-bit.  If you really
>>> want to check vs system memory please call dma_direct_get_required_mask
>>> without the dma_ops indirection.
>>>
>>> Second I don't even think we need to check the coherent_dma_mask,
>>> dma_direct is pretty good at always finding memory even without
>>> an iommu.
>>>
>>> Third this doesn't take take the bus_dma_mask into account.
>>>
>>> This probably should just be:
>>>
>>>                if (min(*dev->dma_mask, dev->bus_dma_mask) <
>>>                    dma_direct_get_required_mask(dev)) {
>>
>> Agreed and will add this in the next version.
>>
>> Best regards,
>> Lu Baolu
> 
