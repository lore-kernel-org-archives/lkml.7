Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825EDC432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5437E206E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLDA1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 19:27:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:21712 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfLDA1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 19:27:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 16:27:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,275,1571727600"; 
   d="scan'208";a="223028262"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2019 16:27:46 -0800
Cc:     baolu.lu@linux.intel.com, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        Eric Auger <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iommu/vt-d: Consolidate various cache flush ops
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
References: <20191122030449.28892-1-baolu.lu@linux.intel.com>
 <22759c43f440eecee60b2d318b6f8e8fe2587bcb.camel@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4100ad7a-0818-7fc1-aaf5-bf0ef44f3f54@linux.intel.com>
Date:   Wed, 4 Dec 2019 08:27:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <22759c43f440eecee60b2d318b6f8e8fe2587bcb.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 12/3/19 4:49 PM, David Woodhouse wrote:
> On Fri, 2019-11-22 at 11:04 +0800, Lu Baolu wrote:
>> Intel VT-d 3.0 introduces more caches and interfaces for software to
>> flush when it runs in the scalable mode. Currently various cache flush
>> helpers are scattered around. This consolidates them by putting them in
>> the existing iommu_flush structure.
>>
>> /* struct iommu_flush - Intel IOMMU cache invalidation ops
>>   *
>>   * @cc_inv: invalidate context cache
>>   * @iotlb_inv: Invalidate IOTLB and paging structure caches when software
>>   *             has changed second-level tables.
>>   * @p_iotlb_inv: Invalidate IOTLB and paging structure caches when software
>>   *               has changed first-level tables.
>>   * @pc_inv: invalidate pasid cache
>>   * @dev_tlb_inv: invalidate cached mappings used by requests-without-PASID
>>   *               from the Device-TLB on a endpoint device.
>>   * @p_dev_tlb_inv: invalidate cached mappings used by requests-with-PASID
>>   *                 from the Device-TLB on an endpoint device
>>   */
>> struct iommu_flush {
>>          void (*cc_inv)(struct intel_iommu *iommu, u16 did,
>>                         u16 sid, u8 fm, u64 type);
>>          void (*iotlb_inv)(struct intel_iommu *iommu, u16 did, u64 addr,
>>                            unsigned int size_order, u64 type);
>>          void (*p_iotlb_inv)(struct intel_iommu *iommu, u16 did, u32 pasid,
>>                              u64 addr, unsigned long npages, bool ih);
>>          void (*pc_inv)(struct intel_iommu *iommu, u16 did, u32 pasid,
>>                         u64 granu);
>>          void (*dev_tlb_inv)(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>>                              u16 qdep, u64 addr, unsigned int mask);
>>          void (*p_dev_tlb_inv)(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>>                                u32 pasid, u16 qdep, u64 addr,
>>                                unsigned long npages);
>> };
>>
>> The name of each cache flush ops is defined according to the spec section 6.5
>> so that people are easy to look up them in the spec.
> 
> Hm, indirect function calls are quite expensive these days.

Good consideration. Thanks!

> 
> I would have preferred to go in the opposite direction, since surely
> aren't going to have *many* of these implementations. Currently there's
> only one for register-based and one for queued invalidation, right?
> Even if VT-d 3.0 throws an extra version in, I think I'd prefer to take
> out the indirection completely and have an if/then helper.
> 
> Would love to see a microbenchmark of unmap operations before and after
> this patch series with retpoline enabled, to see the effect.

Yes. Need some micro-bench tests to address the concern.

Best regards,
baolu
