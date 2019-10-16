Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532F2C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3149D21835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389838AbfJPIsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:48:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbfJPIsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:48:01 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8F356CBF38CF2F34D498;
        Wed, 16 Oct 2019 16:47:59 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 16:47:53 +0800
Subject: Re: [RFC PATCH 0/6] SMMUv3 PMCG IMP DEF event support
To:     Robin Murphy <robin.murphy@arm.com>, <lorenzo.pieralisi@arm.com>,
        <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>
References: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
 <66a3ce9f-d3cd-110f-7353-46e6eaf25b7c@arm.com>
CC:     <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <nleeder@codeaurora.org>,
        <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1d546b4b-a2ad-49da-b532-951232093a9f@huawei.com>
Date:   Wed, 16 Oct 2019 09:47:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <66a3ce9f-d3cd-110f-7353-46e6eaf25b7c@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2019 19:00, Robin Murphy wrote:
> Hi John,
>
> On 30/09/2019 15:33, John Garry wrote:
>> This patchset adds IMP DEF event support for the SMMUv3 PMCG.
>>
>> It is marked as an RFC as the method to identify the PMCG implementation
>> may be a quite disliked. And, in general, the series is somewhat
>> incomplete.
>>
>> So the background is that the PMCG supports IMP DEF events, yet we
>> have no
>> method to identify the PMCG to know the IMP DEF events.
>>
>> A method for identifying the PMCG implementation could be using
>> PMDEVARCH, but we cannot rely on this being set properly, as whether this
>> is implemented is not defined in SMMUv3 spec.
>>
>> Another method would be perf event aliasing, but this method of event
>> matching is based on CPU id, which would not guarantee same
>> uniqueness as PMCG implementation.
>>
>> Yet another method could be to continue using ACPI OEM ID in the IORT
>> code, but this does not scale. And it is not suitable if we ever add DT
>> support to the PMCG driver.
>>
>> The method used in this series is based on matching on the parent SMMUv3
>> IIDR. We store this IIDR contents in the arm smmu structure as the first
>> element, which means that we don't have to expose SMMU APIs - this is
>> the part which may be disliked.
>>
>> The final two patches switch the pre-existing PMCG model identification
>> from ACPI OEM ID to the same parent SMMUv3 IIDR matching.
>>
>> For now, we only consider SMMUv3' nodes being the associated node for
>> PMCG.
>

Hi Robin,

> Two significant concerns right off the bat:
>
> - It seems more common than not for silicon designers to fail to
> implement IIDR correctly, so it's only a matter of time before
> inevitably needing to bring back some firmware-level identifier
> abstraction (if not already - does Hi161x have PMCGs?)

Maybe there's a way that we can switch to this method, and leave the 
door open for an easy way to support firmware-level identifier again, if 
ever needed. I'm not too pushed - this was secondary to just allowing 
the PMCG driver know the associated SMMU model.

And, no, hi161x does not have any PMCGs.

>
> - This seems like a step in entirely the wrong direction for supporting
>.

So to support PMCGs that reference a Named Component or Root Complex, I 
thought that the IORT parsing code would have to do some secondary 
lookup to the associated SMMU, through the Named Component or Root 
Complex node.

What was your idea here?

Note: I do acknowledge that an overall issue is that we assume all PMCG 
IMP DEF events are same for a given SMMU model.

>
> Interpreting the Node Reference is definitely a welcome improvement over
> matching table headers, but absent a truly compelling argument to the
> contrary, I'd rather retain the "PMCG model" abstraction in between that
> and the driver itself (especially since those can trivially be hung off
> compatibles once it comes to DT support).

For DT, I would assume that we just use compatible strings would allow 
us to identify the PMCG model.

On a related matter, is there still a need to deal with scenarios of the 
PMCG being located within the SMMU register map? As you may remember, we 
did have this issue but relocated the PMCG to outside the SMMU register 
map in a later chip rev.

Cheers,
John

>
> Thanks,
> Robin.
>
>>
>> John Garry (6):
>>    ACPI/IORT: Set PMCG device parent
>>    iommu/arm-smmu-v3: Record IIDR in arm_smmu_device structure
>>    perf/smmuv3: Retrieve parent SMMUv3 IIDR
>>    perf/smmuv3: Support HiSilicon hip08 (hi1620) IMP DEF events
>>    perf/smmuv3: Match implementation options based on parent SMMU IIDR
>>    ACPI/IORT: Drop code to set the PMCG software-defined model
>>
>>   drivers/acpi/arm64/iort.c     | 69 ++++++++++++++--------------
>>   drivers/iommu/arm-smmu-v3.c   |  5 +++
>>   drivers/perf/arm_smmuv3_pmu.c | 84 ++++++++++++++++++++++++++++++-----
>>   include/linux/acpi_iort.h     |  8 ----
>>   4 files changed, 112 insertions(+), 54 deletions(-)
>>
>
> .
>


