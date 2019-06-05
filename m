Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A352C282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D682075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFEBk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 21:40:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfFEBk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 21:40:57 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 334B06E9D2154592342C;
        Wed,  5 Jun 2019 09:40:55 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 5 Jun 2019
 09:40:44 +0800
Subject: Re: [RFC v2] irqchip/gic-its: fix command queue pointer comparison
 bug
To:     Marc Zyngier <marc.zyngier@arm.com>, <linux-kernel@vger.kernel.org>
References: <1557747726-28283-1-git-send-email-guoheyi@huawei.com>
 <0723e23c-fd0e-366b-73ec-12cc59767a4e@arm.com>
CC:     <wanghaibin.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>
From:   Guoheyi <guoheyi@huawei.com>
Message-ID: <5eab61dc-290c-b49e-71fb-ade9f3d76281@huawei.com>
Date:   Wed, 5 Jun 2019 09:40:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <0723e23c-fd0e-366b-73ec-12cc59767a4e@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/4 18:28, Marc Zyngier wrote:
> Hi Heyi,
>
> On 13/05/2019 12:42, Heyi Guo wrote:
>> When we run several VMs with PCI passthrough and GICv4 enabled, not
>> pinning vCPUs, we will occasionally see below warnings in dmesg:
>>
>> ITS queue timeout (65440 65504 480)
>> ITS cmd its_build_vmovp_cmd failed
>>
>> The reason for the above issue is that in BUILD_SINGLE_CMD_FUNC:
>> 1. Post the write command.
>> 2. Release the lock.
>> 3. Start to read GITS_CREADR to get the reader pointer.
>> 4. Compare the reader pointer to the target pointer.
>> 5. If reader pointer does not reach the target, sleep 1us and continue
>> to try.
>>
>> If we have several processors running the above concurrently, other
>> CPUs will post write commands while the 1st CPU is waiting the
>> completion. So we may have below issue:
>>
>> phase 1:
>> ---rd_idx-----from_idx-----to_idx--0---------
>>
>> wait 1us:
>>
>> phase 2:
>> --------------from_idx-----to_idx--0-rd_idx--
>>
>> That is the rd_idx may fly ahead of to_idx, and if in case to_idx is
>> near the wrap point, rd_idx will wrap around. So the below condition
>> will not be met even after 1s:
>>
>> if (from_idx < to_idx && rd_idx >= to_idx)
>>
>> There is another theoretical issue. For a slow and busy ITS, the
>> initial rd_idx may fall behind from_idx a lot, just as below:
>>
>> ---rd_idx---0--from_idx-----to_idx-----------
>>
>> This will cause the wait function exit too early.
>>
>> Actually, it does not make much sense to use from_idx to judge if
>> to_idx is wrapped, but we need a initial rd_idx when lock is still
>> acquired, and it can be used to judge whether to_idx is wrapped and
>> the current rd_idx is wrapped.
> That's an interesting observation. Indeed, from_idx is pretty irrelevant
> here, and all we want to observe is the read pointer reaching the end of
> the command set.
>
>> We switch to a method of calculating the delta of two adjacent reads
>> and accumulating it to get the sum, so that we can get the real rd_idx
>> from the wrapped value even when the queue is almost full.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 30 ++++++++++++++++++++----------
>>   1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 7577755..f05acd4 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -745,32 +745,40 @@ static void its_flush_cmd(struct its_node *its, struct its_cmd_block *cmd)
>>   }
>>   
>>   static int its_wait_for_range_completion(struct its_node *its,
>> -					 struct its_cmd_block *from,
>> +					 u64	origin_rd_idx,
>>   					 struct its_cmd_block *to)
>>   {
>> -	u64 rd_idx, from_idx, to_idx;
>> +	u64 rd_idx, prev_idx, to_idx, sum;
>> +	s64 delta;
>>   	u32 count = 1000000;	/* 1s! */
>>   
>> -	from_idx = its_cmd_ptr_to_offset(its, from);
>>   	to_idx = its_cmd_ptr_to_offset(its, to);
>> +	if (to_idx < origin_rd_idx)
>> +		to_idx += ITS_CMD_QUEUE_SZ;
>> +
>> +	prev_idx = origin_rd_idx;
> I guess you could just rename origin_rd_idx to prev_idx and drop the
> extra declaration (the pr_err doesn't matter much).
>
>> +	sum = origin_rd_idx;
>>   
>>   	while (1) {
>>   		rd_idx = readl_relaxed(its->base + GITS_CREADR);
>>   
>> -		/* Direct case */
>> -		if (from_idx < to_idx && rd_idx >= to_idx)
>> -			break;
>> +		/* Wrap around for CREADR */
>> +		if (rd_idx >= prev_idx)
>> +			delta = rd_idx - prev_idx;
>> +		else
>> +			delta = rd_idx + ITS_CMD_QUEUE_SZ - prev_idx;
>>   
>> -		/* Wrapped case */
>> -		if (from_idx >= to_idx && rd_idx >= to_idx && rd_idx < from_idx)
>> +		sum += delta;
> So "sum" isn't quite saying what it represent. My understanding is that
> it is the linearized version of the read pointer, right? Just like
> you've linearized to_idx at the beginning of the function.
>
>> +		if (sum >= to_idx)
>>   			break;
>>   
>>   		count--;
>>   		if (!count) {
>>   			pr_err_ratelimited("ITS queue timeout (%llu %llu %llu)\n",
>> -					   from_idx, to_idx, rd_idx);
>> +					   origin_rd_idx, to_idx, sum);
>>   			return -1;
>>   		}
>> +		prev_idx = rd_idx;
>>   		cpu_relax();
>>   		udelay(1);
>>   	}
>> @@ -787,6 +795,7 @@ void name(struct its_node *its,						\
>>   	struct its_cmd_block *cmd, *sync_cmd, *next_cmd;		\
>>   	synctype *sync_obj;						\
>>   	unsigned long flags;						\
>> +	u64 rd_idx;							\
>>   									\
>>   	raw_spin_lock_irqsave(&its->lock, flags);			\
>>   									\
>> @@ -808,10 +817,11 @@ void name(struct its_node *its,						\
>>   	}								\
>>   									\
>>   post:									\
>> +	rd_idx = readl_relaxed(its->base + GITS_CREADR);		\
>>   	next_cmd = its_post_commands(its);				\
>>   	raw_spin_unlock_irqrestore(&its->lock, flags);			\
>>   									\
>> -	if (its_wait_for_range_completion(its, cmd, next_cmd))		\
>> +	if (its_wait_for_range_completion(its, rd_idx, next_cmd))	\
>>   		pr_err_ratelimited("ITS cmd %ps failed\n", builder);	\
>>   }
>>   
>>
> If you agree with my comments above, I'm happy to take this patch and
> tidy it up myself.

Sure; many thanks
>
> Now, I think there is still an annoying bug that can creep up if the
> queue wraps *twice* while you're sleeping (which could perfectly happen
> in a guest running on a busy host). Which means we need to account for
> wrapping generations...
I was assuming that it was not really possible for the reader pointer to 
go through the whole loop in 1us, between two successive reads, while 
the loop has 2K entries. But I'm OK if we add more enhancement to avoid 
this.

Thanks,
Heyi

>
> Thanks,
>
> 	M.


