Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57042C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340C82196E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfI3Jl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:41:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727547AbfI3Jl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:41:28 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E97985D9C003C37EE7BD;
        Mon, 30 Sep 2019 17:41:23 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 30 Sep 2019
 17:41:16 +0800
Subject: Re: [PATCH 20/35] irqchip/gic-v4.1: Allow direct invalidation of
 VLPIs
To:     Marc Zyngier <maz@kernel.org>
CC:     <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-21-maz@kernel.org>
 <db01f956-bc53-b8a5-9406-15b889d717f0@huawei.com>
 <1c96d38da22a97b1fda94a940b60e345@www.loen.fr>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4ac7dddc-1ba8-52bf-e66e-bee9b3b79744@huawei.com>
Date:   Mon, 30 Sep 2019 17:40:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <1c96d38da22a97b1fda94a940b60e345@www.loen.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/30 17:20, Marc Zyngier wrote:
> On 2019-09-28 03:02, Zenghui Yu wrote:
>> On 2019/9/24 2:25, Marc Zyngier wrote:
>>> Just like for INVALL, GICv4.1 has grown a VPE-aware INVLPI register.
>>> Let's plumb it in and make use of the DirectLPI code in that case.
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
>>>   drivers/irqchip/irq-gic-v3-its.c   | 19 +++++++++++++++++--
>>>   include/linux/irqchip/arm-gic-v3.h |  1 +
>>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>>> b/drivers/irqchip/irq-gic-v3-its.c
>>> index b791c9beddf2..34595a7fcccb 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -1200,13 +1200,27 @@ static void wait_for_syncr(void __iomem *rdbase)
>>>   static void direct_lpi_inv(struct irq_data *d)
>>>   {
>>> +    struct its_vlpi_map *map = get_vlpi_map(d);
>>>       struct its_collection *col;
>>>       void __iomem *rdbase;
>>> +    u64 val;
>>> +
>>> +    if (map) {
>>> +        struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>>> +
>>> +        WARN_ON(!is_v4_1(its_dev->its));
>>> +
>>> +        val  = GICR_INVLPIR_V;
>>> +        val |= FIELD_PREP(GICR_INVLPIR_VPEID, map->vpe->vpe_id);
>>> +        val |= FIELD_PREP(GICR_INVLPIR_INTID, map->vintid);
>>> +    } else {
>>> +        val = d->hwirq;
>>> +    }
>>>
>>>       /* Target the redistributor this LPI is currently routed to */
>>>       col = irq_to_col(d);
>>
>> I think irq_to_col() may not work when GICv4.1 VLPIs are involved in.
>>
>> irq_to_col() gives us col_map[event] as the target redistributor,
>> but the correct one for VLPIs should be vlpi_maps[event]->vpe->col_idx.
>> These two are not always pointing to the same physical RD.
>> For example, if guest issues a MOVI against a VLPI, we will update the
>> corresponding vlpi_map->vpe and issue a VMOVI on ITS... but leave the
>> col_map[event] unchanged.
>>
>> col_map[event] usually describes the physical LPI's CPU affinity, but
>> when this physical LPI serves as something which the VLPI is backed by,
>> we take really little care of it.  Did I miss something here?
> 
> You didn't miss anything, and this is indeed another pretty bad bug.
> The collection mapping is completely unused when the LPI becomes a
> VLPI, and it is only the vpe->col_id that matters (which gets updated
> on VMOVP).
> 
> This shows that irq_to_col() is the wrong abstraction, and what we're
> interested is something that is more like 'irq to cpuid', allowing us
> to directly point to the right distributor.
> 
> Please see the patch I just pushed[1], which does that.
> 
> Thanks,
> 
>          M.
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/gic-v4.1-devel&id=aff363113eb26b6840136b69c2c7db2ea691db20 

Yes, I think this makes sense.


Thanks,
zenghui

