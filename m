Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F96C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C90C218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCUWHm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:07:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:38820 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfCUWHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:07:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="330812590"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga005.fm.intel.com with ESMTP; 21 Mar 2019 15:07:40 -0700
Date:   Thu, 21 Mar 2019 15:10:05 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@linux.intel.com, kevin.tian@intel.com,
        vincent.stehle@arm.com, ashok.raj@intel.com, kvm@vger.kernel.org,
        peter.maydell@linaro.org, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, christoffer.dall@arm.com,
        alex.williamson@redhat.com, robin.murphy@arm.com,
        kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 05/22] iommu: Introduce cache_invalidate API
Message-ID: <20190321151005.07374be0@jacob-builder>
In-Reply-To: <41173658-dde0-6e58-90ed-65cff2b1dd1c@redhat.com>
References: <20190317172232.1068-1-eric.auger@redhat.com>
        <20190317172232.1068-6-eric.auger@redhat.com>
        <20190320093727.45a86866@jacob-builder>
        <7ae1df77-18d0-0993-8dab-6af3a4474b42@arm.com>
        <ad4d18ec-0040-901f-8d37-0fccb3cfd0d5@redhat.com>
        <109c3520-dd26-3c0b-35d1-48b169fea982@arm.com>
        <41173658-dde0-6e58-90ed-65cff2b1dd1c@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 15:32:45 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi jean, Jacob,
> 
> On 3/21/19 3:13 PM, Jean-Philippe Brucker wrote:
> > On 21/03/2019 13:54, Auger Eric wrote:  
> >> Hi Jacob, Jean-Philippe,
> >>
> >> On 3/20/19 5:50 PM, Jean-Philippe Brucker wrote:  
> >>> On 20/03/2019 16:37, Jacob Pan wrote:
> >>> [...]  
> >>>>> +struct iommu_inv_addr_info {
> >>>>> +#define IOMMU_INV_ADDR_FLAGS_PASID	(1 << 0)
> >>>>> +#define IOMMU_INV_ADDR_FLAGS_ARCHID	(1 << 1)
> >>>>> +#define IOMMU_INV_ADDR_FLAGS_LEAF	(1 << 2)
> >>>>> +	__u32	flags;
> >>>>> +	__u32	archid;
> >>>>> +	__u64	pasid;
> >>>>> +	__u64	addr;
> >>>>> +	__u64	granule_size;
> >>>>> +	__u64	nb_granules;
> >>>>> +};
> >>>>> +
> >>>>> +/**
> >>>>> + * First level/stage invalidation information
> >>>>> + * @cache: bitfield that allows to select which caches to
> >>>>> invalidate
> >>>>> + * @granularity: defines the lowest granularity used for the
> >>>>> invalidation:
> >>>>> + *     domain > pasid > addr
> >>>>> + *
> >>>>> + * Not all the combinations of cache/granularity make sense:
> >>>>> + *
> >>>>> + *         type |   DEV_IOTLB   |     IOTLB     |
> >>>>> PASID    |
> >>>>> + * granularity	|		|		|
> >>>>> cache	|
> >>>>> + *
> >>>>> -------------+---------------+---------------+---------------+
> >>>>> + * DOMAIN	|	N/A	|       Y	|
> >>>>> Y	|
> >>>>> + * PASID	|	Y	|       Y	|
> >>>>> Y	|
> >>>>> + * ADDR		|       Y	|       Y	|
> >>>>> N/A	|
> >>>>> + */
> >>>>> +struct iommu_cache_invalidate_info {
> >>>>> +#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
> >>>>> +	__u32	version;
> >>>>> +/* IOMMU paging structure cache */
> >>>>> +#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU
> >>>>> IOTLB */ +#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 <<
> >>>>> 1) /* Device IOTLB */ +#define
> >>>>> IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID cache */  
> >>>> Just a clarification, this used to be an enum. You do intend to
> >>>> issue a single invalidation request on multiple cache types?
> >>>> Perhaps for virtio-IOMMU? I only see a single cache type in your
> >>>> patch #14. For VT-d we plan to issue one cache type at a time
> >>>> for now. So this format works for us.  
> >>>
> >>> Yes for virtio-iommu I'd like as little overhead as possible,
> >>> which means a single invalidation message to hit both IOTLB and
> >>> ATC at once, and the ability to specify multiple pages with
> >>> @nb_granules.  
> >> The original request/explanation from Jean-Philippe can be found
> >> here: https://lkml.org/lkml/2019/1/28/1497
> >>  
> >>>  
> >>>> However, if multiple cache types are issued in a single
> >>>> invalidation. They must share a single granularity, not all
> >>>> combinations are valid. e.g. dev IOTLB does not support domain
> >>>> granularity. Just a reminder, not an issue. Driver could filter
> >>>> out invalid combinations.  
> >> Sure I will add a comment about this restriction.  
> >>>
> >>> Agreed. Even the core could filter out invalid combinations based
> >>> on the table above: IOTLB and domain granularity are N/A.  
> >> I don't get this sentence. What about vtd IOTLB domain-selective
> >> invalidation:  
> > 
> > My mistake: I meant dev-IOTLB and domain granularity are N/A  
> 
> Ah OK, no worries.
> 
> How do we proceed further with those user APIs? Besides the comment to
> be added above and previous suggestion from Jean ("Invalidations by
> @granularity use field ...), have we reached a consensus now on:
> 
> - attach/detach_pasid_table
> - cache_invalidate
> - fault data and fault report API?
> 
These APIs are sufficient for today's VT-d use and leave enough space
for extension. E.g. new fault reasons.

I have cherry picked the above APIs from your patchset to enable VT-d
nested translation. Going forward, I will reuse these until they get
merged.

> If not, please let me know.
> 
> Thanks
> 
> Eric
> 
> 
> > 
> > Thanks,
> > Jean
> >   
> >> "
> >> • IOTLB entries caching mappings associated with the specified
> >> domain-id are invalidated.
> >> • Paging-structure-cache entries caching mappings associated with
> >> the specified domain-id are invalidated.
> >> "
> >>
> >> Thanks
> >>
> >> Eric
> >>  
> >>>
> >>> Thanks,
> >>> Jean
> >>>  
> >>>>  
> >>>>> +	__u8	cache;
> >>>>> +	__u8	granularity;
> >>>>> +	__u8	padding[2];
> >>>>> +	union {
> >>>>> +		__u64	pasid;
> >>>>> +		struct iommu_inv_addr_info addr_info;
> >>>>> +	};
> >>>>> +};
> >>>>> +
> >>>>> +
> >>>>>  #endif /* _UAPI_IOMMU_H */  
> >>>>
> >>>> [Jacob Pan]
> >>>> _______________________________________________
> >>>> iommu mailing list
> >>>> iommu@lists.linux-foundation.org
> >>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >>>>  
> >>>  
> >> _______________________________________________
> >> iommu mailing list
> >> iommu@lists.linux-foundation.org
> >> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >>  
> >   

[Jacob Pan]
