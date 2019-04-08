Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945F4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4EE20863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDHCtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:49:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:27599 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfDHCtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:49:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Apr 2019 19:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,323,1549958400"; 
   d="scan'208";a="129433562"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2019 19:49:16 -0700
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
 <cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
 <6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
 <8B1FC0C7-9BAC-498D-B1F0-0138EACF75C2@arista.com>
 <ddcaa472-7bff-ddd3-0518-f2ba694b3279@linux.intel.com>
 <9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ea8b4315-4db2-00c9-66f7-fee6a4cd1a8c@linux.intel.com>
Date:   Mon, 8 Apr 2019 10:43:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/6/19 2:02 AM, James Sewart wrote:
> Hey Lu,
> 
> My bad, did some debugging on my end. The issue was swapping out
> find_domain for iommu_get_domain_for_dev. It seems in some situations the
> domain is not attached to the group but the device is expected to have the
> domain still stored in its archdata.
> 
> I’ve attached the final patch with find_domain unremoved which seems to
> work in my testing.

This version works for me now.

> 
> Cheers,
> James.

Best regards,
Lu Baolu

> 
> 
> 
> 
> 
>> On 4 Apr 2019, at 07:49, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi James,
>>
>> I did a sanity test from my end. The test machine fails to boot. I
>> haven't seen any valuable kernel log. It results in a purple screen.
>>
>> Best regards,
>> Lu Baolu
>>
>> On 3/29/19 11:26 PM, James Sewart wrote:
>>> Hey Lu,
>>> I’ve attached a preliminary v3, if you could take a look and run some tests
>>> that would be great.
>>> Since v2 i’ve added your default domain type patches, the new device_group
>>> handler, and incorporated Jacob’s feedback.
>>>> On 28 Mar 2019, at 18:37, James Sewart <jamessewart@arista.com> wrote:
>>>>
>>>> Hey Lu,
>>>>
>>>>> On 26 Mar 2019, at 01:24, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>>
>>>>> Hi James,
>>>>>
>>>>> On 3/25/19 8:57 PM, James Sewart wrote:
>>>>>>>> Theres an issue that if we choose to alloc a new resv_region with type
>>>>>>>> IOMMU_RESV_DIRECT, we will need to refactor intel_iommu_put_resv_regions
>>>>>>>> to free this entry type which means refactoring the rmrr regions in
>>>>>>>> get_resv_regions. Should this work be in this patchset?
>>>>>>> Do you mean the rmrr regions are not allocated in get_resv_regions, but
>>>>>>> are freed in put_resv_regions? I think we should fix this in this patch
>>>>>>> set since this might impact the device passthrough if we don't do it.
>>>>>> They’re not allocated and not freed currently, only type IOMMU_RESV_MSI is
>>>>>> freed in put_resv_regions. If we allocate a new resv_region with type
>>>>>> IOMMU_RESV_DIRECT for the isa region, then it won’t be freed. If we modify
>>>>>> put_resv_regions to free type IOMMU_RESV_DIRECT, then we will try to free
>>>>>> the static RMRR regions.
>>>>>> Either the ISA region is static and not freed as with my implementation,
>>>>>> or the RMRR regions are converted to be allocated on each call to
>>>>>> get_resv_regions and freed in put_resv_regions.
>>>>>
>>>>> By the way, there's another way in my mind. Let's add a new region type
>>>>> for LPC devices, e.x. IOMMU_RESV_LPC, and then handle it in the same way
>>>>> as those MSI regions. Just FYI.
>>>>
>>>> This solution would require adding some extra code to
>>>> iommu_group_create_direct_mappings as currently only type
>>>> IOMMU_RESV_DIRECT is identity mapped, other types are only reserved.
>>>>
>>>>
>>>>>
>>>>> Best regards,
>>>>> Lu Baolu
>>>>
>>>> Cheers,
>>>> James.
>>> Cheers,
>>> James.
> 
