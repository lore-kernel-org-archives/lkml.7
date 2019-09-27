Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E63FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E24120835
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfI0CEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 22:04:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2729 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727794AbfI0CEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 22:04:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 089539B626AC6B8ABFFF;
        Fri, 27 Sep 2019 10:03:58 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 27 Sep 2019
 10:03:48 +0800
Subject: Re: [PATCH 10/35] irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER)
 allocation
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-11-maz@kernel.org>
 <155660c2-7f30-e188-ca8d-c37fabea6d97@huawei.com>
 <6f4ccdfd-4b63-04cb-e7c0-f069e620127f@kernel.org>
 <14111988-74c9-12c3-1322-1580ff6ba11f@huawei.com>
 <c4d63ccd-b5b2-007f-6174-1a9d20f3669d@kernel.org>
 <5d915f55-785b-72f5-498b-8c17148dd3a9@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <99e561dc-fe3c-ff8f-7e28-8fc4b66d1209@huawei.com>
Date:   Fri, 27 Sep 2019 10:01:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <5d915f55-785b-72f5-498b-8c17148dd3a9@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/27 0:27, Marc Zyngier wrote:
> On 26/09/2019 16:57, Marc Zyngier wrote:
>> On 26/09/2019 16:19, Zenghui Yu wrote:
>>> Hi Marc,
>>>
>>> Two more questions below.
>>>
>>> On 2019/9/25 22:41, Marc Zyngier wrote:
>>>> On 25/09/2019 14:04, Zenghui Yu wrote:
>>>>> Hi Marc,
>>>>>
>>>>> Some questions about this patch, mostly to confirm that I would
>>>>> understand things here correctly.
>>>>>
>>>>> On 2019/9/24 2:25, Marc Zyngier wrote:
>>>>>> GICv4.1 defines a new VPE table that is potentially shared between
>>>>>> both the ITSs and the redistributors, following complicated affinity
>>>>>> rules.
>>>>>>
>>>>>> To make things more confusing, the programming of this table at
>>>>>> the redistributor level is reusing the GICv4.0 GICR_VPROPBASER register
>>>>>> for something completely different.
>>>>>>
>>>>>> The code flow is somewhat complexified by the need to respect the
>>>>>> affinities required by the HW, meaning that tables can either be
>>>>>> inherited from a previously discovered ITS or redistributor.
>>>>>>
>>>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>>>> ---
>>>>>
>>>>> [...]
>>>>>
>>>>>> @@ -1962,6 +1965,65 @@ static bool its_parse_indirect_baser(struct its_node *its,
>>>>>>     	return indirect;
>>>>>>     }
>>>>>>     
>>>>>> +static u32 compute_common_aff(u64 val)
>>>>>> +{
>>>>>> +	u32 aff, clpiaff;
>>>>>> +
>>>>>> +	aff = FIELD_GET(GICR_TYPER_AFFINITY, val);
>>>>>> +	clpiaff = FIELD_GET(GICR_TYPER_COMMON_LPI_AFF, val);
>>>>>> +
>>>>>> +	return aff & ~(GENMASK(31, 0) >> (clpiaff * 8));
>>>>>> +}
>>>>>> +
>>>>>> +static u32 compute_its_aff(struct its_node *its)
>>>>>> +{
>>>>>> +	u64 val;
>>>>>> +	u32 svpet;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Reencode the ITS SVPET and MPIDR as a GICR_TYPER, and compute
>>>>>> +	 * the resulting affinity. We then use that to see if this match
>>>>>> +	 * our own affinity.
>>>>>> +	 */
>>>>>> +	svpet = FIELD_GET(GITS_TYPER_SVPET, its->typer);
>>>
>>> The spec says, ITS does not share vPE table with Redistributors when
>>> SVPET==0.  It seems that we miss this rule and simply regard SVPET as
>>> GICR_TYPER_COMMON_LPI_AFF here.  Am I wrong?
>>
>> Correct. I missed the case where the ITS doesn't share anything. That's
>> pretty unlikely though (you loose all the benefit of v4.1, and I don't
>> really see how you'd make it work reliably).
> 
> Actually, this is already handled...
> 
>>
>>>
>>>>>> +	val  = FIELD_PREP(GICR_TYPER_COMMON_LPI_AFF, svpet);
>>>>>> +	val |= FIELD_PREP(GICR_TYPER_AFFINITY, its->mpidr);
>>>>>> +	return compute_common_aff(val);
>>>>>> +}
>>>>>> +
>>>>>> +static struct its_node *find_sibbling_its(struct its_node *cur_its)
>>>>>> +{
>>>>>> +	struct its_node *its;
>>>>>> +	u32 aff;
>>>>>> +
>>>>>> +	if (!FIELD_GET(GITS_TYPER_SVPET, cur_its->typer))
>>>>>> +		return NULL;
> 
> ... here. If SVPET is 0, there is no sibling, and we'll allocate a VPE
> table as usual.

Yes, I see.  So we can safely encode the non-zero SVPET as
COMMON_LPI_AFF in a GICR_TYPER when computing the affinity.


Thanks,
zenghui

