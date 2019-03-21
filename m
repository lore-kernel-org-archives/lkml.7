Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B65C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ACA218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfCUNye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:54:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUNye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:54:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD7913082E0F;
        Thu, 21 Mar 2019 13:54:33 +0000 (UTC)
Received: from [10.36.116.167] (ovpn-116-167.ams2.redhat.com [10.36.116.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6CD619C59;
        Thu, 21 Mar 2019 13:54:27 +0000 (UTC)
Subject: Re: [PATCH v6 05/22] iommu: Introduce cache_invalidate API
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     yi.l.liu@linux.intel.com, kevin.tian@intel.com,
        vincent.stehle@arm.com, alex.williamson@redhat.com,
        ashok.raj@intel.com, kvm@vger.kernel.org, peter.maydell@linaro.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
References: <20190317172232.1068-1-eric.auger@redhat.com>
 <20190317172232.1068-6-eric.auger@redhat.com>
 <20190320093727.45a86866@jacob-builder>
 <7ae1df77-18d0-0993-8dab-6af3a4474b42@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <ad4d18ec-0040-901f-8d37-0fccb3cfd0d5@redhat.com>
Date:   Thu, 21 Mar 2019 14:54:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7ae1df77-18d0-0993-8dab-6af3a4474b42@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 21 Mar 2019 13:54:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob, Jean-Philippe,

On 3/20/19 5:50 PM, Jean-Philippe Brucker wrote:
> On 20/03/2019 16:37, Jacob Pan wrote:
> [...]
>>> +struct iommu_inv_addr_info {
>>> +#define IOMMU_INV_ADDR_FLAGS_PASID	(1 << 0)
>>> +#define IOMMU_INV_ADDR_FLAGS_ARCHID	(1 << 1)
>>> +#define IOMMU_INV_ADDR_FLAGS_LEAF	(1 << 2)
>>> +	__u32	flags;
>>> +	__u32	archid;
>>> +	__u64	pasid;
>>> +	__u64	addr;
>>> +	__u64	granule_size;
>>> +	__u64	nb_granules;
>>> +};
>>> +
>>> +/**
>>> + * First level/stage invalidation information
>>> + * @cache: bitfield that allows to select which caches to invalidate
>>> + * @granularity: defines the lowest granularity used for the
>>> invalidation:
>>> + *     domain > pasid > addr
>>> + *
>>> + * Not all the combinations of cache/granularity make sense:
>>> + *
>>> + *         type |   DEV_IOTLB   |     IOTLB     |      PASID    |
>>> + * granularity	|		|		|
>>> cache	|
>>> + * -------------+---------------+---------------+---------------+
>>> + * DOMAIN	|	N/A	|       Y	|
>>> Y	|
>>> + * PASID	|	Y	|       Y	|
>>> Y	|
>>> + * ADDR		|       Y	|       Y	|
>>> N/A	|
>>> + */
>>> +struct iommu_cache_invalidate_info {
>>> +#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
>>> +	__u32	version;
>>> +/* IOMMU paging structure cache */
>>> +#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
>>> +#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /* Device
>>> IOTLB */ +#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID
>>> cache */
>> Just a clarification, this used to be an enum. You do intend to issue a
>> single invalidation request on multiple cache types? Perhaps for
>> virtio-IOMMU? I only see a single cache type in your patch #14. For VT-d
>> we plan to issue one cache type at a time for now. So this format works
>> for us.
> 
> Yes for virtio-iommu I'd like as little overhead as possible, which
> means a single invalidation message to hit both IOTLB and ATC at once,
> and the ability to specify multiple pages with @nb_granules.
The original request/explanation from Jean-Philippe can be found here:
https://lkml.org/lkml/2019/1/28/1497

> 
>> However, if multiple cache types are issued in a single invalidation.
>> They must share a single granularity, not all combinations are valid.
>> e.g. dev IOTLB does not support domain granularity. Just a reminder,
>> not an issue. Driver could filter out invalid combinations.
Sure I will add a comment about this restriction.
> 
> Agreed. Even the core could filter out invalid combinations based on the
> table above: IOTLB and domain granularity are N/A.
I don't get this sentence. What about vtd IOTLB domain-selective
invalidation:
"
• IOTLB entries caching mappings associated with the specified domain-id
are invalidated.
• Paging-structure-cache entries caching mappings associated with the
specified domain-id are invalidated.
"

Thanks

Eric

> 
> Thanks,
> Jean
> 
>>
>>> +	__u8	cache;
>>> +	__u8	granularity;
>>> +	__u8	padding[2];
>>> +	union {
>>> +		__u64	pasid;
>>> +		struct iommu_inv_addr_info addr_info;
>>> +	};
>>> +};
>>> +
>>> +
>>>  #endif /* _UAPI_IOMMU_H */
>>
>> [Jacob Pan]
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
> 
