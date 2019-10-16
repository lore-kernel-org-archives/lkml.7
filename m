Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B71FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E163F2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391212AbfJPMHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:07:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389706AbfJPMHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:07:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D546CCAF42B4863132D3;
        Wed, 16 Oct 2019 20:07:27 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 20:07:18 +0800
Subject: Re: [RFC PATCH 0/6] SMMUv3 PMCG IMP DEF event support
To:     Robin Murphy <robin.murphy@arm.com>, <lorenzo.pieralisi@arm.com>,
        <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>
References: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
 <66a3ce9f-d3cd-110f-7353-46e6eaf25b7c@arm.com>
 <1d546b4b-a2ad-49da-b532-951232093a9f@huawei.com>
 <fc2df5d8-561a-b25b-e8f1-79aeb913687f@arm.com>
CC:     <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <nleeder@codeaurora.org>,
        <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9b590b5c-b68a-6b33-dd8b-a992bf56a253@huawei.com>
Date:   Wed, 16 Oct 2019 13:07:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <fc2df5d8-561a-b25b-e8f1-79aeb913687f@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robin,

>>> Two significant concerns right off the bat:
>>>
>>> - It seems more common than not for silicon designers to fail to
>>> implement IIDR correctly, so it's only a matter of time before
>>> inevitably needing to bring back some firmware-level identifier
>>> abstraction (if not already - does Hi161x have PMCGs?)
>>
>> Maybe there's a way that we can switch to this method, and leave the
>> door open for an easy way to support firmware-level identifier again,
>> if ever needed. I'm not too pushed - this was secondary to just
>> allowing the PMCG driver know the associated SMMU model.
>
> But that's the part I'm not buying - there's no clear advantage to
> pushing that complexity down into the PMCG driver, vs. leaving the IORT
> code responsible for translating an SMMU model into a PMCG model, yet
> the aforementioned disadvantages jump out right away.
>

One advantage is that the next piece of quirky hw with a properly 
implemented IIDR does not require a new IORT model.

And today, this handling is only for hi1620, and since we can use hi1620 
IIDR to id it, then it seems good to remove code outside the PMCG driver 
specifically to handle it.

But if you think it's going to be needed again, then it makes sense not 
to remove it.

>> And, no, hi161x does not have any PMCGs.
>
> Hooray, I guess :)
>
>>>
>>> - This seems like a step in entirely the wrong direction for supporting
>>> .
>>
>> So to support PMCGs that reference a Named Component or Root Complex,
>> I thought that the IORT parsing code would have to do some secondary
>> lookup to the associated SMMU, through the Named Component or Root
>> Complex node.
>>
>> What was your idea here?
>
> The associated SMMU has no relevance in that context - the reason for
> the Node Reference to point to a non-SMMU node is for devices that
> implement their own embedded TLB (e.g. AMBA DTI masters) and expose a
> standard PMCG interface to monitor it. It isn't reasonable to expect any
> old PCIe controller or on-chip-accelerator driver to expose a fake SMMU
> IIDR just to keep some other driver happy.

But won't there still be an SMMU associated with the AMBA DTI masters, 
in your example?

It's this SMMU which the PMCG driver would reference as the "parent" 
device, and the IORT parsing would need to do the lookup for this reference.

But then, this becomes something that the DT parsing would need to 
handle also.

>
>> Note: I do acknowledge that an overall issue is that we assume all
>> PMCG IMP DEF events are same for a given SMMU model.
>
> That assumption does technically fail already - I know MMU-600 has
> different IMP-DEF events for its TCU and TBUs, however as long as we can
> get as far as "this is some part of an MMU-600" the driver should be
> able to figure out the rest (annoyingly it looks like both PMCG types
> expose the same PMCG_ID_REGS information, but they should be
> distinguishable by PMCG_CEIDn).

JFYI, PMCG_CEIDn contents for hi1620 are all zero, apart from PMDEVARCH 
and PMDEVTYPE, which are same as arm implementation according to the 
spec - sigh...

>
>>> Interpreting the Node Reference is definitely a welcome improvement over
>>> matching table headers, but absent a truly compelling argument to the
>>> contrary, I'd rather retain the "PMCG model" abstraction in between that
>>> and the driver itself (especially since those can trivially be hung off
>>> compatibles once it comes to DT support).
>>
>> For DT, I would assume that we just use compatible strings would allow
>> us to identify the PMCG model.
>
> Right, that was largely my point - DT probing can start with a PMCG
> model, so it's a lot more logical for ACPI probing to do the same, with
> the actual PMCG model determination hidden away in the ACPI code. That's
> the basis of the current design.
>
> I have been nagging the architects that PMCGs not having their own IIDR
> is an unwelcome hole in the spec, so hopefully this might get a bit
> easier some day.

For sure. The spec reads that the PMCGs may be "independently-designed", 
hence no general id method. I don't get this.

>
>> On a related matter, is there still a need to deal with scenarios of
>> the PMCG being located within the SMMU register map? As you may
>> remember, we did have this issue but relocated the PMCG to outside the
>> SMMU register map in a later chip rev.
>
> MMU-600 has its TCU PMCG page 0 in the middle of its SMMU page 0 space,
> but given that it's an Arm IP, I expect that when the heat gets turned
> up for making it work, it's most likely to be under me ;)

OK, so this is another reason why I thought that having a reference to 
the SMMU device could be useful in terms of solving that problem.

>
> Robin.
>
> .

Thanks again,
John

>


