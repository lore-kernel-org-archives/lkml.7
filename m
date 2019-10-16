Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15BCFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC2A2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393740AbfJPQ01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:26:27 -0400
Received: from foss.arm.com ([217.140.110.172]:44882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390184AbfJPQ01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:26:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B92ED28;
        Wed, 16 Oct 2019 09:26:26 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3D0D3F68E;
        Wed, 16 Oct 2019 09:26:25 -0700 (PDT)
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
To:     Qian Cai <cai@lca.pw>, Joerg Roedel <jroedel@suse.de>
Cc:     Tom Murphy <murphyt7@tcd.ie>, Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1571237707.5937.58.camel@lca.pw>
 <1571237982.5937.60.camel@lca.pw> <20191016153112.GF4695@suse.de>
 <1571241213.5937.64.camel@lca.pw> <20191016160314.GH4695@suse.de>
 <1571242287.5937.66.camel@lca.pw>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2912dd38-72c5-93a1-1185-46b681473a62@arm.com>
Date:   Wed, 16 Oct 2019 17:26:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571242287.5937.66.camel@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2019 17:11, Qian Cai wrote:
> On Wed, 2019-10-16 at 18:03 +0200, Joerg Roedel wrote:
>> On Wed, Oct 16, 2019 at 11:53:33AM -0400, Qian Cai wrote:
>>> On Wed, 2019-10-16 at 17:31 +0200, Joerg Roedel wrote:
>>> The x86 one might just be a mistake.
>>>
>>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>>> index ad05484d0c80..63c4b894751d 100644
>>> --- a/drivers/iommu/amd_iommu.c
>>> +++ b/drivers/iommu/amd_iommu.c
>>> @@ -2542,7 +2542,7 @@ static int amd_iommu_map(struct iommu_domain *dom,
>>> unsigned long iova,
>>>          if (iommu_prot & IOMMU_WRITE)
>>>                  prot |= IOMMU_PROT_IW;
>>>   
>>> -       ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
>>> +       ret = iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
>>
>> Yeah, that is a bug, I spotted that too.
>>
>>> @@ -1185,7 +1185,7 @@ static struct iommu_dma_msi_page
>>> *iommu_dma_get_msi_page(struct device *dev,
>>>          if (!iova)
>>>                  goto out_free_page;
>>>   
>>> -       if (iommu_map(domain, iova, msi_addr, size, prot))
>>> +       if (iommu_map_atomic(domain, iova, msi_addr, size, prot))
>>>                  goto out_free_iova;
>>
>> Not so sure this is a bug, this code is only about setting up MSIs on
>> ARM. It probably doesn't need to be atomic.
> 
> The patch "iommu: Add gfp parameter to iommu_ops::map" does this. It could be
> called from an atomic context as showed in the arm64 call traces,
> 
> +int iommu_map(struct iommu_domain *domain, unsigned long iova,
> +             phys_addr_t paddr, size_t size, int prot)
> +{
> +       might_sleep();
> +       return __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
> +}

Also note that it's *only* the might_sleep() at issue here - none of the 
arm64 IOMMU drivers have been converted to look at the new gfp argument 
yet, so anything they actually allocate while mapping will still be 
GFP_ATOMIC anyway.

(Carrying that flag down through the whole io-pgtable stack is on my 
to-do list...)

Robin.
