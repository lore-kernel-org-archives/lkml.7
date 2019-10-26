Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7B2CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 07:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA2220679
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 07:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfJZHFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 03:05:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:15719 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJZHFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 03:05:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2019 00:05:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="224136893"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 26 Oct 2019 00:05:37 -0700
Cc:     baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v7 11/11] iommu/vt-d: Add svm/sva invalidate function
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-12-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDE06@SHSMSX104.ccr.corp.intel.com>
 <5e9d2372-a8b5-9a26-1438-c1a608bfad6d@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d0375121-7893-bb06-45f3-209a0cff12de@linux.intel.com>
Date:   Sat, 26 Oct 2019 15:03:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5e9d2372-a8b5-9a26-1438-c1a608bfad6d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 10/26/19 10:40 AM, Lu Baolu wrote:
> Hi,
> 
> On 10/25/19 3:27 PM, Tian, Kevin wrote:
>>> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
>>> Sent: Friday, October 25, 2019 3:55 AM
>>>
>>> When Shared Virtual Address (SVA) is enabled for a guest OS via
>>> vIOMMU, we need to provide invalidation support at IOMMU API and
>>> driver
>>> level. This patch adds Intel VT-d specific function to implement
>>> iommu passdown invalidate API for shared virtual address.
>>>
>>> The use case is for supporting caching structure invalidation
>>> of assigned SVM capable devices. Emulated IOMMU exposes queue
>>> invalidation capability and passes down all descriptors from the guest
>>> to the physical IOMMU.
>>
>> specifically you may clarify that only invalidations related to
>> first-level page table is passed down, because it's guest
>> structure being bound to the first-level. other descriptors
>> are emulated or translated into other necessary operations.
>>
>>>
>>> The assumption is that guest to host device ID mapping should be
>>> resolved prior to calling IOMMU driver. Based on the device handle,
>>> host IOMMU driver can replace certain fields before submit to the
>>> invalidation queue.
>>
>> what is device ID? it's a bit confusing term here.
>>
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel-iommu.c | 170
>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 170 insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>> index 5fab32fbc4b4..a73e76d6457a 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -5491,6 +5491,175 @@ static void
>>> intel_iommu_aux_detach_device(struct iommu_domain *domain,
>>>       aux_domain_remove_dev(to_dmar_domain(domain), dev);
>>>   }
>>>
>>> +/*
>>> + * 2D array for converting and sanitizing IOMMU generic TLB 
>>> granularity to
>>> + * VT-d granularity. Invalidation is typically included in the unmap
>>> operation
>>> + * as a result of DMA or VFIO unmap. However, for assigned device where
>>> guest
>>> + * could own the first level page tables without being shadowed by 
>>> QEMU.
>>> In
>>> + * this case there is no pass down unmap to the host IOMMU as a 
>>> result of
>>> unmap
>>> + * in the guest. Only invalidations are trapped and passed down.
>>> + * In all cases, only first level TLB invalidation (request with 
>>> PASID) can be
>>> + * passed down, therefore we do not include IOTLB granularity for 
>>> request
>>> + * without PASID (second level).
>>> + *
>>> + * For an example, to find the VT-d granularity encoding for IOTLB
>>> + * type and page selective granularity within PASID:
>>> + * X: indexed by iommu cache type
>>> + * Y: indexed by enum iommu_inv_granularity
>>> + * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
>>> + *
>>> + * Granu_map array indicates validity of the table. 1: valid, 0: 
>>> invalid
>>> + *
>>> + */
>>> +const static int
>>> inv_type_granu_map[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRAN
>>> U_NR] = {
>>> +    /* PASID based IOTLB, support PASID selective and page selective */
>>> +    {0, 1, 1},
>>> +    /* PASID based dev TLBs, only support all PASIDs or single PASID */
>>> +    {1, 1, 0},
>>
>> I forgot previous discussion. is it necessary to pass down dev TLB 
>> invalidation
>> requests? Can it be handled by host iOMMU driver automatically?
> 
> On host SVA, when a memory is unmapped, driver callback will invalidate
> dev IOTLB explicitly. So I guess we need to pass down it for guest case.
> This is also required for guest iova over 1st level usage as far as can
> see.
> 

Sorry, I confused guest vIOVA and guest vSVA. For guest vIOVA, no device
TLB invalidation pass down. But currently for guest vSVA, device TLB
invalidation is passed down. Perhaps we can avoid passing down dev TLB
flush just like what we are doing for guest IOVA.

Best regards,
baolu
