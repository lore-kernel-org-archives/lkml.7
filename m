Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECA3C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A94208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfEML5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:57:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728943AbfEML5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:57:52 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1A687BF275AA98292D00;
        Mon, 13 May 2019 19:57:49 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 May 2019
 19:57:39 +0800
Subject: Re: [RFC PATCH] irqchip/gic-v3: Correct the usage of GICD_CTLR's RWP
 field
To:     Andre Przywara <andre.przywara@arm.com>
CC:     <marc.zyngier@arm.com>, <eric.auger@redhat.com>,
        <drjones@redhat.com>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <wanghaibin.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1557720954-6592-1-git-send-email-yuzenghui@huawei.com>
 <20190513093704.0b293de0@donnerap.cambridge.arm.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <0d1febde-30de-6474-4cca-a0a17963a329@huawei.com>
Date:   Mon, 13 May 2019 19:55:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20190513093704.0b293de0@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On 2019/5/13 16:37, Andre Przywara wrote:
> On Mon, 13 May 2019 04:15:54 +0000
> Zenghui Yu <yuzenghui@huawei.com> wrote:
> 
> Hi,
> 
>> As per ARM IHI 0069D, GICD_CTLR's RWP field tracks updates to:
>>
>> 	GICD_CTLR's Group Enable bits, for transitions from 1 to 0 only
>> 	GICD_CTLR's ARE bits, E1NWF bit and DS bit (if we have)
>> 	GICD_ICENABLER<n>
>>
>> We seemed use this field in an inappropriate way, somewhere in the
>> GIC-v3 driver. For some examples:
>>
>> In gic_set_affinity(), if the interrupt was not enabled, we only need
>> to write GICD_IROUTER<n> with the appropriate mpidr value. Updates to
>> GICD_IROUTER will not be tracked by RWP field, and we can remove the
>> unnecessary RWP waiting.
> 
> I am not sure this is the proper fix, see below inline.
> 
>> In gic_dist_init(), we "Enable distributor with ARE, Group1" by writing
>> to GICD_CTLR, and we should use gic_dist_wait_for_rwp() here.
> 
> That looks reasonable, yes.
> 
>> These two are obvious cases, and there are some other cases where we don't
>> need to do RWP waiting, such as in gic_configure_irq() and gic_poke_irq().
>> But too many modifications makes me not confident. It's hard for me to say
>> whether this patch is doing the right thing and how does the RWP waiting
>> affect the system, thus RFC.
> 
> So did you actually see a problem, and this patch fixes it? Or was this
> just discovered by code inspection and comparing to the spec?

The latter ;-)

>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   drivers/irqchip/irq-gic-v3.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 15e55d3..8d63950 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -600,6 +600,7 @@ static void __init gic_dist_init(void)
>>   	/* Enable distributor with ARE, Group1 */
>>   	writel_relaxed(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A |
>> GICD_CTLR_ENABLE_G1, base + GICD_CTLR);
>> +	gic_dist_wait_for_rwp();
>>   
>>   	/*
>>   	 * Set all global interrupts to the boot CPU only. ARE must be
>> @@ -986,14 +987,9 @@ static int gic_set_affinity(struct irq_data *d,
>> const struct cpumask *mask_val,
>>   	gic_write_irouter(val, reg);
>>   
>> -	/*
>> -	 * If the interrupt was enabled, enabled it again. Otherwise,
>> -	 * just wait for the distributor to have digested our changes.
>> -	 */
>> +	/* If the interrupt was enabled, enabled it again. */
>>   	if (enabled)
>>   		gic_unmask_irq(d);
>> -	else
>> -		gic_dist_wait_for_rwp();
> 
> I think you are right in this is not needed here.
> But I guess this call belongs further up in this function, after the
> gic_mask_irq() call, as this one writes to GICD_ICENABLER. So in case this
> IRQ was enabled, we should wait for the distributor to have properly
> disabled it, before changing its affinity.

I still think we don't need this call in gic_set_affinity().
Actually, the writes to GICD_ICENABLER happens in gic_poke_irq(). And we
already have a gic_dist_wait_for_rwp() there, named rwp_wait().


thanks,
zenghui

> 
> Cheers,
> Andre.
> 
>>   
>>   	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>>   
> 
> 
> .
> 

