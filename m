Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA3CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF0320748
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfLBLII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 06:08:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42566 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727354AbfLBLIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 06:08:07 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E5EFE93BAA5E17831125;
        Mon,  2 Dec 2019 19:08:04 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Dec 2019
 19:07:59 +0800
Subject: Re: [PATCH] irq/gic-its: gicv4: set VPENDING table as inner-shareable
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20191130073849.38378-1-guoheyi@huawei.com>
 <20191201180434.1dba3116@why>
From:   Guoheyi <guoheyi@huawei.com>
Message-ID: <aaa0f679-9fde-f877-e125-7e609c555e38@huawei.com>
Date:   Mon, 2 Dec 2019 19:07:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191201180434.1dba3116@why>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2019/12/2 2:04, Marc Zyngier Ð´µÀ:
> On Sat, 30 Nov 2019 15:38:49 +0800
> Heyi Guo <guoheyi@huawei.com> wrote:
>
>> There is no special reason to set virtual LPI pending table as
>> non-shareable. If we choose to hard code the shareability without
>> probing, inner-shareable will be a better choice, for all the other
>> ITS/GICR tables prefer to be inner-shareable.
> One of the issues is that we have strictly no idea what the caches are
> Inner Shareable with (I've been asking for such clarification for years
> without getting anywhere). You can have as many disconnected inner
> shareable domains as you want!

Hisilicon HIP07 and HIP08 are compliant with ARM SBSA and have only one 
inner shareable domain in the whole system.

What will happen if a system has multiple inner shareable domains? Will 
Linux still work on such system? Can we declare that Linux only supports 
one single inner shareable domain?

>
> I suspect that in the grand scheme of things, the redistributors
> ought to be in the same inner shareable domain, and that with a bit of
> luck, the CPUs are there as well. Still, that's a massive guess.
>
>> What's more, on Hisilicon hip08 it will trigger some kind of bus
>> warning when mixing use of different shareabilities.
> Do you have more information about what the bus is complaining about?
> Is that because the CPUs have these pages mapped as inner shareable?

Actually HIP08 L3 Cache will complain on any non-shareable cache entry, 
for the data coherence cannot be guarenteed for such configuration. This 
also implies VPENDING table will be allocated and snooped in L3 cache.

>
> I'll give it a go on D05 (HIP07) to find out what changes there.

Thanks,

HG

>
> Thanks,
>
> 	M.
>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c   | 2 +-
>>   include/linux/irqchip/arm-gic-v3.h | 3 +++
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 787e8eec9a7f..d31e863bc9ef 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2831,7 +2831,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
>>   	val  = virt_to_phys(page_address(vpe->vpt_page)) &
>>   		GENMASK_ULL(51, 16);
>>   	val |= GICR_VPENDBASER_RaWaWb;
>> -	val |= GICR_VPENDBASER_NonShareable;
>> +	val |= GICR_VPENDBASER_InnerShareable;
>>   	/*
>>   	 * There is no good way of finding out if the pending table is
>>   	 * empty as we can race against the doorbell interrupt very
>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
>> index 5cc10cf7cb3e..a184f875e451 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -289,6 +289,9 @@
>>   #define GICR_VPENDBASER_NonShareable					\
>>   	GIC_BASER_SHAREABILITY(GICR_VPENDBASER, NonShareable)
>>   
>> +#define GICR_VPENDBASER_InnerShareable					\
>> +	GIC_BASER_SHAREABILITY(GICR_VPENDBASER, InnerShareable)
>> +
>>   #define GICR_VPENDBASER_nCnB	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, nCnB)
>>   #define GICR_VPENDBASER_nC 	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, nC)
>>   #define GICR_VPENDBASER_RaWt	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, RaWt)
>
>

