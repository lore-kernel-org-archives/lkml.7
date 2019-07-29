Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCF1C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35CD214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfG2NNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:13:48 -0400
Received: from foss.arm.com ([217.140.110.172]:44022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfG2NNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:13:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CA5328;
        Mon, 29 Jul 2019 06:13:47 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0363D3F71F;
        Mon, 29 Jul 2019 06:13:45 -0700 (PDT)
Subject: Re: [PATCH 07/24] iommu/dma: Move domain lookup into
 __iommu_dma_{map, unmap}
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
References: <20190520072948.11412-1-hch@lst.de>
 <20190520072948.11412-8-hch@lst.de>
 <5FC3163CFD30C246ABAA99954A238FA83F328FAB@lhreml524-mbb.china.huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9027b5f1-545b-e11b-ca8f-f1e0bd701634@arm.com>
Date:   Mon, 29 Jul 2019 14:13:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F328FAB@lhreml524-mbb.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,

On 29/07/2019 13:12, Shameerali Kolothum Thodi wrote:
> Hi Robin,
> 
>> -----Original Message-----
>> From: iommu-bounces@lists.linux-foundation.org
>> [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf Of Christoph
>> Hellwig
>> Sent: 20 May 2019 08:30
>> To: Robin Murphy <robin.murphy@arm.com>
>> Cc: Tom Murphy <tmurphy@arista.com>; Catalin Marinas
>> <catalin.marinas@arm.com>; Will Deacon <will.deacon@arm.com>;
>> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
>> linux-arm-kernel@lists.infradead.org
>> Subject: [PATCH 07/24] iommu/dma: Move domain lookup into
>> __iommu_dma_{map, unmap}
>>
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Most of the callers don't care, and the couple that do already have the
>> domain to hand for other reasons are in slow paths where the (trivial)
>> overhead of a repeated lookup will be utterly immaterial.
> 
> On a Hisilicon ARM64 platform with 5.3-rc1, a F_TRANSALTION error from
> smmuv3 is reported when an attempt is made to assign a ixgbe vf dev to a
> Guest.
> 
> [  196.747107] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x10 received:
> [  196.747109] arm-smmu-v3 arm-smmu-v3.0.auto: 0x00000180 00000010
> [  196.747110] arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000020100000000
> [  196.747111] arm-smmu-v3 arm-smmu-v3.0.auto: 0x00000000ffffe040
> [  196.747113] arm-smmu-v3 arm-smmu-v3.0.auto: 0x00000000ffffe000
> 
> Git bisect points to this patch.
> 
> Please see below.
[...]
>> *iommu_dma_get_msi_page(struct device *dev,
>>   	if (!msi_page)
>>   		return NULL;
>>
>> -	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
>> +	iova = __iommu_dma_map(dev, msi_addr, size, prot);
> 
> I think the domain here is retrieved using iommu_get_domain_for_dev()
> which may not be the default domain returned by iommu_get_dma_domain().

Urgh, yes, how did I manage to miss that? :(

I doubt this patch reverts cleanly, but I don't think it needs to be 
completely undone anyway; give me a moment...

Robin.

> 
> Please check and let me know.
> 
> Thanks,
> Shameer
> 
>>   	if (iova == DMA_MAPPING_ERROR)
>>   		goto out_free_page;
>> --
>> 2.20.1
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
