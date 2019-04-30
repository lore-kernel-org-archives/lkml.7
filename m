Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1785C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3442147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfD3FQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 01:16:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfD3FQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:16:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41F1630715CA;
        Tue, 30 Apr 2019 05:16:16 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEB5E1001284;
        Tue, 30 Apr 2019 05:15:50 +0000 (UTC)
Subject: Re: [PATCH v2 17/19] iommu: Add max num of cache and granu types
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-18-git-send-email-jacob.jun.pan@linux.intel.com>
 <a9f2c804-24a8-03fb-96ac-0c4661870dd5@redhat.com>
 <20190429091723.5970e967@jacob-builder>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <fe189810-aa25-2a67-0608-fbeef5b07d92@redhat.com>
Date:   Tue, 30 Apr 2019 07:15:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190429091723.5970e967@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 30 Apr 2019 05:16:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/29/19 6:17 PM, Jacob Pan wrote:
> On Fri, 26 Apr 2019 18:22:46 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Jacob,
>>
>> On 4/24/19 1:31 AM, Jacob Pan wrote:
>>> To convert to/from cache types and granularities between generic and
>>> VT-d specific counterparts, a 2D arrary is used. Introduce the
>>> limits  
>> array
>>> to help define the converstion array size.  
>> conversion
>>>
> will fix, thanks
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---
>>>  include/uapi/linux/iommu.h | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>>> index 5c95905..2d8fac8 100644
>>> --- a/include/uapi/linux/iommu.h
>>> +++ b/include/uapi/linux/iommu.h
>>> @@ -197,6 +197,7 @@ struct iommu_inv_addr_info {
>>>  	__u64	granule_size;
>>>  	__u64	nb_granules;
>>>  };
>>> +#define NR_IOMMU_CACHE_INVAL_GRANU	(3)
>>>  
>>>  /**
>>>   * First level/stage invalidation information
>>> @@ -235,6 +236,7 @@ struct iommu_cache_invalidate_info {
>>>  		struct iommu_inv_addr_info addr_info;
>>>  	};
>>>  };
>>> +#define NR_IOMMU_CACHE_TYPE		(3)
>>>  /**
>>>   * struct gpasid_bind_data - Information about device and guest
>>> PASID binding
>>>   * @gcr3:	Guest CR3 value from guest mm
>>>   
>> Is it really something that needs to be exposed in the uapi?
>>
> I put it in uapi since the related definitions for granularity and
> cache type are in the same file.
> Maybe putting them close together like this? I was thinking you can just
> fold it into your next series as one patch for introducing cache
> invalidation.
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 2d8fac8..4ff6929 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -164,6 +164,7 @@ enum iommu_inv_granularity {
>         IOMMU_INV_GRANU_DOMAIN, /* domain-selective invalidation */
>         IOMMU_INV_GRANU_PASID,  /* pasid-selective invalidation */
>         IOMMU_INV_GRANU_ADDR,   /* page-selective invalidation */
> +       NR_IOMMU_INVAL_GRANU,   /* number of invalidation granularities
> */ };
>  
>  /**
> @@ -228,6 +229,7 @@ struct iommu_cache_invalidate_info {
>  #define IOMMU_CACHE_INV_TYPE_IOTLB     (1 << 0) /* IOMMU IOTLB */
>  #define IOMMU_CACHE_INV_TYPE_DEV_IOTLB (1 << 1) /* Device IOTLB */
>  #define IOMMU_CACHE_INV_TYPE_PASID     (1 << 2) /* PASID cache */
> +#define NR_IOMMU_CACHE_TYPE            (3)

OK I will add this.

Thanks

Eric
>         __u8    cache;
>         __u8    granularity;
> 
>> Thanks
>>
>> Eric
> 
> [Jacob Pan]
> 
