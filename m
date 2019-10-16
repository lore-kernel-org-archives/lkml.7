Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17F8FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE8F2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbfJPKvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:51:32 -0400
Received: from foss.arm.com ([217.140.110.172]:36152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfJPKvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:51:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54E0628;
        Wed, 16 Oct 2019 03:51:31 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 037943F6C4;
        Wed, 16 Oct 2019 03:51:28 -0700 (PDT)
Subject: Re: [RFC PATCH 0/6] SMMUv3 PMCG IMP DEF event support
To:     John Garry <john.garry@huawei.com>, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com, mark.rutland@arm.com,
        will@kernel.org
Cc:     shameerali.kolothum.thodi@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, rjw@rjwysocki.net,
        lenb@kernel.org, nleeder@codeaurora.org, linuxarm@huawei.com
References: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
 <66a3ce9f-d3cd-110f-7353-46e6eaf25b7c@arm.com>
 <1d546b4b-a2ad-49da-b532-951232093a9f@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fc2df5d8-561a-b25b-e8f1-79aeb913687f@arm.com>
Date:   Wed, 16 Oct 2019 11:51:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1d546b4b-a2ad-49da-b532-951232093a9f@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-16 9:47 am, John Garry wrote:
> On 15/10/2019 19:00, Robin Murphy wrote:
>> Hi John,
>>
>> On 30/09/2019 15:33, John Garry wrote:
>>> This patchset adds IMP DEF event support for the SMMUv3 PMCG.
>>>
>>> It is marked as an RFC as the method to identify the PMCG implementation
>>> may be a quite disliked. And, in general, the series is somewhat
>>> incomplete.
>>>
>>> So the background is that the PMCG supports IMP DEF events, yet we
>>> have no
>>> method to identify the PMCG to know the IMP DEF events.
>>>
>>> A method for identifying the PMCG implementation could be using
>>> PMDEVARCH, but we cannot rely on this being set properly, as whether 
>>> this
>>> is implemented is not defined in SMMUv3 spec.
>>>
>>> Another method would be perf event aliasing, but this method of event
>>> matching is based on CPU id, which would not guarantee same
>>> uniqueness as PMCG implementation.
>>>
>>> Yet another method could be to continue using ACPI OEM ID in the IORT
>>> code, but this does not scale. And it is not suitable if we ever add DT
>>> support to the PMCG driver.
>>>
>>> The method used in this series is based on matching on the parent SMMUv3
>>> IIDR. We store this IIDR contents in the arm smmu structure as the first
>>> element, which means that we don't have to expose SMMU APIs - this is
>>> the part which may be disliked.
>>>
>>> The final two patches switch the pre-existing PMCG model identification
>>> from ACPI OEM ID to the same parent SMMUv3 IIDR matching.
>>>
>>> For now, we only consider SMMUv3' nodes being the associated node for
>>> PMCG.
>>
> 
> Hi Robin,
> 
>> Two significant concerns right off the bat:
>>
>> - It seems more common than not for silicon designers to fail to
>> implement IIDR correctly, so it's only a matter of time before
>> inevitably needing to bring back some firmware-level identifier
>> abstraction (if not already - does Hi161x have PMCGs?)
> 
> Maybe there's a way that we can switch to this method, and leave the 
> door open for an easy way to support firmware-level identifier again, if 
> ever needed. I'm not too pushed - this was secondary to just allowing 
> the PMCG driver know the associated SMMU model.

But that's the part I'm not buying - there's no clear advantage to 
pushing that complexity down into the PMCG driver, vs. leaving the IORT 
code responsible for translating an SMMU model into a PMCG model, yet 
the aforementioned disadvantages jump out right away.

> And, no, hi161x does not have any PMCGs.

Hooray, I guess :)

>>
>> - This seems like a step in entirely the wrong direction for supporting
>> .
> 
> So to support PMCGs that reference a Named Component or Root Complex, I 
> thought that the IORT parsing code would have to do some secondary 
> lookup to the associated SMMU, through the Named Component or Root 
> Complex node.
> 
> What was your idea here?

The associated SMMU has no relevance in that context - the reason for 
the Node Reference to point to a non-SMMU node is for devices that 
implement their own embedded TLB (e.g. AMBA DTI masters) and expose a 
standard PMCG interface to monitor it. It isn't reasonable to expect any 
old PCIe controller or on-chip-accelerator driver to expose a fake SMMU 
IIDR just to keep some other driver happy.

> Note: I do acknowledge that an overall issue is that we assume all PMCG 
> IMP DEF events are same for a given SMMU model.

That assumption does technically fail already - I know MMU-600 has 
different IMP-DEF events for its TCU and TBUs, however as long as we can 
get as far as "this is some part of an MMU-600" the driver should be 
able to figure out the rest (annoyingly it looks like both PMCG types 
expose the same PMCG_ID_REGS information, but they should be 
distinguishable by PMCG_CEIDn).

>> Interpreting the Node Reference is definitely a welcome improvement over
>> matching table headers, but absent a truly compelling argument to the
>> contrary, I'd rather retain the "PMCG model" abstraction in between that
>> and the driver itself (especially since those can trivially be hung off
>> compatibles once it comes to DT support).
> 
> For DT, I would assume that we just use compatible strings would allow 
> us to identify the PMCG model.

Right, that was largely my point - DT probing can start with a PMCG 
model, so it's a lot more logical for ACPI probing to do the same, with 
the actual PMCG model determination hidden away in the ACPI code. That's 
the basis of the current design.

I have been nagging the architects that PMCGs not having their own IIDR 
is an unwelcome hole in the spec, so hopefully this might get a bit 
easier some day.

> On a related matter, is there still a need to deal with scenarios of the 
> PMCG being located within the SMMU register map? As you may remember, we 
> did have this issue but relocated the PMCG to outside the SMMU register 
> map in a later chip rev.

MMU-600 has its TCU PMCG page 0 in the middle of its SMMU page 0 space, 
but given that it's an Arm IP, I expect that when the heat gets turned 
up for making it work, it's most likely to be under me ;)

Robin.
