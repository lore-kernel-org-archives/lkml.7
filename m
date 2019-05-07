Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D6EC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D70020825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEGK23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:28:29 -0400
Received: from foss.arm.com ([217.140.101.70]:49510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfEGK22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:28:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8428374;
        Tue,  7 May 2019 03:28:27 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B4703F5AF;
        Tue,  7 May 2019 03:28:26 -0700 (PDT)
Subject: Re: [PATCH v3 1/8] iommu: Add ops entry for supported default domain
 type
To:     Tom Murphy <tmurphy@arista.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
        David Woodhouse <dwmw2@infradead.org>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
 <20190429020925.18136-2-baolu.lu@linux.intel.com>
 <CAPL0++4Q7p7gWRUF5vG5sazLNCmSR--Px-=OEtj6vm_gEpB_ng@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bba1f327-21b7-ed3c-8fd4-217ad97a6a7c@arm.com>
Date:   Tue, 7 May 2019 11:28:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPL0++4Q7p7gWRUF5vG5sazLNCmSR--Px-=OEtj6vm_gEpB_ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2019 16:32, Tom Murphy via iommu wrote:
> The AMD driver already solves this problem and uses the generic
> iommu_request_dm_for_dev function. It seems like both drivers have the
> same problem and could use the same solution. Is there any reason we
> can't have use the same solution for the intel and amd driver?
> 
> Could we just  copy the implementation of the AMD driver? It would be
> nice to have the same behavior across both drivers especially as we
> move to make both drivers use more generic code.

TBH I don't think the API really needs to be involved at all here. 
Drivers can already not provide the requested default domain type if 
they don't support it, so as long as the driver can ensure that the 
device ends up with IOMMU or direct DMA ops as appropriate, I don't see 
any great problem with drivers just returning a passthrough domain when 
a DMA domain was requested, or vice versa (and logging a message that 
the requested type was overridden). The only type that we really do have 
to honour strictly is non-default (i.e. unmanaged) domains.

Robin.

> On Mon, Apr 29, 2019 at 3:16 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> This adds an optional ops entry to query the default domain
>> types supported by the iommu driver for  a specific device.
>> This is necessary in cases where the iommu driver can only
>> support a specific type of default domain for a device. In
>> normal cases, this ops will return IOMMU_DOMAIN_ANY which
>> indicates that the iommu driver supports both IOMMU_DOMAIN_DMA
>> and IOMMU_DOMAIN_IDENTITY, hence the static default domain
>> type will be used.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 13 ++++++++++---
>>   include/linux/iommu.h | 11 +++++++++++
>>   2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index acd6830e6e9b..1ad9a1f2e078 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1097,15 +1097,22 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>>           * IOMMU driver.
>>           */
>>          if (!group->default_domain) {
>> +               unsigned int domain_type = IOMMU_DOMAIN_ANY;
>>                  struct iommu_domain *dom;
>>
>> -               dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
>> -               if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
>> +               if (ops->def_domain_type)
>> +                       domain_type = ops->def_domain_type(dev);
>> +
>> +               if (domain_type == IOMMU_DOMAIN_ANY)
>> +                       domain_type = iommu_def_domain_type;
>> +
>> +               dom = __iommu_domain_alloc(dev->bus, domain_type);
>> +               if (!dom && domain_type != IOMMU_DOMAIN_DMA) {
>>                          dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
>>                          if (dom) {
>>                                  dev_warn(dev,
>>                                           "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
>> -                                        iommu_def_domain_type);
>> +                                        domain_type);
>>                          }
>>                  }
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 8239ece9fdfc..ba9a5b996a63 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -79,12 +79,16 @@ struct iommu_domain_geometry {
>>    *     IOMMU_DOMAIN_DMA        - Internally used for DMA-API implementations.
>>    *                               This flag allows IOMMU drivers to implement
>>    *                               certain optimizations for these domains
>> + *     IOMMU_DOMAIN_ANY        - All domain types defined here
>>    */
>>   #define IOMMU_DOMAIN_BLOCKED   (0U)
>>   #define IOMMU_DOMAIN_IDENTITY  (__IOMMU_DOMAIN_PT)
>>   #define IOMMU_DOMAIN_UNMANAGED (__IOMMU_DOMAIN_PAGING)
>>   #define IOMMU_DOMAIN_DMA       (__IOMMU_DOMAIN_PAGING |        \
>>                                   __IOMMU_DOMAIN_DMA_API)
>> +#define IOMMU_DOMAIN_ANY       (IOMMU_DOMAIN_IDENTITY |        \
>> +                                IOMMU_DOMAIN_UNMANAGED |       \
>> +                                IOMMU_DOMAIN_DMA)
>>
>>   struct iommu_domain {
>>          unsigned type;
>> @@ -196,6 +200,11 @@ enum iommu_dev_features {
>>    * @dev_feat_enabled: check enabled feature
>>    * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
>>    * @aux_get_pasid: get the pasid given an aux-domain
>> + * @def_domain_type: get per-device default domain type that the IOMMU
>> + *             driver is able to support. Valid returns values:
>> + *             - IOMMU_DOMAIN_DMA: only suports non-identity domain
>> + *             - IOMMU_DOMAIN_IDENTITY: only supports identity domain
>> + *             - IOMMU_DOMAIN_ANY: supports all
>>    * @pgsize_bitmap: bitmap of all possible supported page sizes
>>    */
>>   struct iommu_ops {
>> @@ -251,6 +260,8 @@ struct iommu_ops {
>>          void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
>>          int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
>>
>> +       int (*def_domain_type)(struct device *dev);
>> +
>>          unsigned long pgsize_bitmap;
>>   };
>>
>> --
>> 2.17.1
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
