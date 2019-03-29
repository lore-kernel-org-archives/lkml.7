Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB07C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0A12075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfC2PEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:04:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728720AbfC2PEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:04:10 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E214EDB6B05F9EE6F112;
        Fri, 29 Mar 2019 23:04:07 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Fri, 29 Mar 2019
 23:04:01 +0800
Subject: Re: [RFC PATCH] irqchip/gic-v3: Make gic_handle_irq() notrace
To:     Marc Zyngier <marc.zyngier@arm.com>, <julien.thierry@arm.com>,
        <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <james.morse@arm.com>,
        <suzuki.poulose@arm.com>, <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1553865808-30604-1-git-send-email-yuzenghui@huawei.com>
 <237b00d0-8a8d-ede6-91b1-c3e23e61925c@arm.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <bf434b0c-2b17-b92d-3171-a57203486c84@huawei.com>
Date:   Fri, 29 Mar 2019 23:02:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <237b00d0-8a8d-ede6-91b1-c3e23e61925c@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/3/29 21:58, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 29/03/2019 13:23, Zenghui Yu wrote:
>> Enable pseudo NMI together with function_graph tracer, will lead
>> the system to a hang. This is easy to reproduce,
>>
>>    1) Set "irqchip.gicv3_pseudo_nmi=1" on the kernel command line
>>    2) echo function_graph > /sys/kernel/debug/tracing/current_tracer
>>
>> This patch (RFC) set gic_handle_irq() as notrace and it seems works
>> fine now. But I have no idea about what the issue is exactly, and
>> you can regard this patch as a report then :)
>>
>> Can someone give a look at it and provide some explanations ?
>>
>> Thanks!
>>
>> Cc: Julien Thierry <julien.thierry@arm.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   drivers/irqchip/irq-gic-v3.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 15e55d3..8d0c25f 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -487,7 +487,7 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
>>   		gic_deactivate_unhandled(irqnr);
>>   }
>>   
>> -static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
>> +static asmlinkage notrace void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
>>   {
>>   	u32 irqnr;
>>   
>>
> 
> 
> That's interesting. Do you have any out of tree patch that actually
> makes use of the pseudo-NMI feature? Without those patches, the
> behaviour should stay unchanged.

I am at commit 1a9df9e29c2afecf6e3089442d429b377279ca3c. No more
patches, and this is the most confusing. Just out of curiosity, I
wanted to run Julien's "Use NMI for perf interrupt" patch (posted
on the mailing list), so I have to enable NMI first.

That said, with
   1) Select Kernel Feature -> Support for NMI-like interrupts
   2) Set "irqchip.gicv3_pseudo_nmi=1" on the kernel command line
   3) No pseudo-NMIs have been generated at all
and this issue was hit.


thanks,

zenghui

> 
> On the other hand, if you can generate pseudo-NMIs, you could end-up
> tracing gic_handle_irq whilst being inside the tracing code with
> interrupts being notionally disabled (and that could be pretty bad).
> 
> So, patches or no patches?
> 
> Thanks,
> 
> 	M.
> 

