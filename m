Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA78FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA61C2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406348AbfJPQgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:36:14 -0400
Received: from foss.arm.com ([217.140.110.172]:45190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404745AbfJPQgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:36:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A93C628;
        Wed, 16 Oct 2019 09:36:13 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80C143F68E;
        Wed, 16 Oct 2019 09:36:12 -0700 (PDT)
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>
Cc:     iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Tom Murphy <murphyt7@tcd.ie>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
References: <1571237707.5937.58.camel@lca.pw>
 <1571237982.5937.60.camel@lca.pw> <20191016153112.GF4695@suse.de>
 <1571241213.5937.64.camel@lca.pw> <20191016160314.GH4695@suse.de>
 <a85f264c-3b74-b92b-ac03-aeba3a56946f@arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <fc510899-4e8b-827f-4c5f-2fe89145ac30@arm.com>
Date:   Wed, 16 Oct 2019 17:36:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a85f264c-3b74-b92b-ac03-aeba3a56946f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 16/10/2019 17:09, Robin Murphy wrote:
> On 16/10/2019 17:03, Joerg Roedel wrote:
>> On Wed, Oct 16, 2019 at 11:53:33AM -0400, Qian Cai wrote:
>>> On Wed, 2019-10-16 at 17:31 +0200, Joerg Roedel wrote:
>>
>>> The x86 one might just be a mistake.
>>>
>>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>>> index ad05484d0c80..63c4b894751d 100644
>>> --- a/drivers/iommu/amd_iommu.c
>>> +++ b/drivers/iommu/amd_iommu.c
>>> @@ -2542,7 +2542,7 @@ static int amd_iommu_map(struct iommu_domain *dom,
>>> unsigned long iova,
>>>          if (iommu_prot & IOMMU_WRITE)
>>>                  prot |= IOMMU_PROT_IW;
>>> -       ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
>>> +       ret = iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
>>
>> Yeah, that is a bug, I spotted that too.
>>
>>> @@ -1185,7 +1185,7 @@ static struct iommu_dma_msi_page
>>> *iommu_dma_get_msi_page(struct device *dev,
>>>          if (!iova)
>>>                  goto out_free_page;
>>> -       if (iommu_map(domain, iova, msi_addr, size, prot))
>>> +       if (iommu_map_atomic(domain, iova, msi_addr, size, prot))
>>>                  goto out_free_iova;
>>
>> Not so sure this is a bug, this code is only about setting up MSIs on
>> ARM. It probably doesn't need to be atomic.
> Right, since the iommu_dma_prepare_msi() operation was broken out to happen at 
> MSI domain setup time, I don't think the comment in there applies any more, so 
> we can probably stop disabling irqs around the iommu_dma_get_msi_page() call.

Yes, I agree that it does not need to be atomic anymore.

Cheers,

-- 
Julien Grall
