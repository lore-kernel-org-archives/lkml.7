Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CF8C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D5721736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfDSVgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:36:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726665AbfDSVgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:36:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33F1597439F0519A1287;
        Fri, 19 Apr 2019 21:48:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Fri, 19 Apr 2019
 21:48:06 +0800
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: make sure the kdump kernel can
 work well when smmu is enabled
To:     Will Deacon <will.deacon@arm.com>
References: <20190318131243.20716-1-thunder.leizhen@huawei.com>
 <20190404153031.GE27558@fuggles.cambridge.arm.com>
 <5CAAB293.3080600@huawei.com>
 <20190416091410.GC31579@fuggles.cambridge.arm.com>
 <5CB683D2.9010901@huawei.com>
CC:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5CB9D195.7000707@huawei.com>
Date:   Fri, 19 Apr 2019 21:48:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <5CB683D2.9010901@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/17 9:39, Leizhen (ThunderTown) wrote:
> 
> 
> On 2019/4/16 17:14, Will Deacon wrote:
>> On Mon, Apr 08, 2019 at 10:31:47AM +0800, Leizhen (ThunderTown) wrote:
>>> On 2019/4/4 23:30, Will Deacon wrote:
>>>> On Mon, Mar 18, 2019 at 09:12:41PM +0800, Zhen Lei wrote:
>>>>> v1 --> v2:
>>>>> 1. Drop part2. Now, we only use the SMMUv3 hardware feature STE.config=0b000
>>>>> (Report abort to device, no event recorded) to suppress the event messages
>>>>> caused by the unexpected devices.
>>>>> 2. rewrite the patch description.
>>>>
>>>> This issue came up a while back:
>>>>
>>>> https://lore.kernel.org/linux-pci/20180302103032.GB19323@arm.com/
>>>>
>>>> and I'd still prefer to solve it using the disable_bypass logic which we
>>>> already have. Something along the lines of the diff below?
>>>
>>> Yes, my patches also use disable_bypass=1(set ste.config=0b000). If
>>> SMMU_IDR0.ST_LEVEL=0(Linear Stream table supported), then all STE entries
>>> are allocated and initialized(set ste.config=0b000). But if SMMU_IDR0.ST_LEVEL=1
>>> (2-level Stream Table), we only allocated and initialized the first level tables,
>>> but leave level 2 tables dynamic allocated. That means, C_BAD_STREAMID(eventid=0x2)
>>> will be reported, if an unexpeted device access memory without reinitialized in
>>> kdump kernel.
>>
>> So is your problem just that the C_BAD_STREAMID events are noisy? If so,
>> perhaps we should be disabling fault reporting entirely in the kdump kernel.
>>
>> How about the update diff below? I'm keen to have this as simple as
>> possible, so we don't end up introducing rarely tested, complex code on
>> the crash path.
> In theory, it can solve the problem, let me test it.
Hi Will,
  I have tested your patch on my board today. It works well.

> 
> But then again, below patch will also disable the fault reporting come from the
> expected devices which are used in the kdump kernel. In fact, my patches have been
> merged into our interval version more than 2 months, no bug have been found yet.
> 
> However, my patches do not support the case that the hardware does not support the
> "STE bypass" feature, I think your patch can also resolve it.
> 
>>
>> Will
>>
>> --->8
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index d3880010c6cf..d8b73da6447d 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -2454,13 +2454,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>>  	/* Clear CR0 and sync (disables SMMU and queue processing) */
>>  	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
>>  	if (reg & CR0_SMMUEN) {
>> -		if (is_kdump_kernel()) {
>> -			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
>> -			arm_smmu_device_disable(smmu);
>> -			return -EBUSY;
>> -		}
>> -
>>  		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
>> +		WARN_ON(is_kdump_kernel() && !disable_bypass);
>> +		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
>>  	}
>>  
>>  	ret = arm_smmu_device_disable(smmu);
>> @@ -2553,6 +2549,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>>  		return ret;
>>  	}
>>  
>> +	if (is_kdump_kernel())
>> +		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
>>  
>>  	/* Enable the SMMU interface, or ensure bypass */
>>  	if (!bypass || disable_bypass) {
>>
>> .
>>
> 

-- 
Thanks!
BestRegards

