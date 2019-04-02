Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F971C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8DB2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbfDBOAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:00:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51816 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbfDBOAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:00:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACB5A16A3;
        Tue,  2 Apr 2019 07:00:08 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EA863F721;
        Tue,  2 Apr 2019 07:00:06 -0700 (PDT)
Subject: Re: [RFC PATCH] irqchip/gic-v3: Make gic_handle_irq() notrace
To:     Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>, rostedt@goodmis.org
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, linux@armlinux.org.uk, james.morse@arm.com,
        suzuki.poulose@arm.com, wanghaibin.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1553865808-30604-1-git-send-email-yuzenghui@huawei.com>
 <237b00d0-8a8d-ede6-91b1-c3e23e61925c@arm.com>
 <bf434b0c-2b17-b92d-3171-a57203486c84@huawei.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <aad77b33-7eb0-57a6-2d60-1cb717c1e1c7@arm.com>
Date:   Tue, 2 Apr 2019 15:00:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bf434b0c-2b17-b92d-3171-a57203486c84@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/03/2019 15:02, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2019/3/29 21:58, Marc Zyngier wrote:
>> Hi Zenghui,
>>
>> On 29/03/2019 13:23, Zenghui Yu wrote:
>>> Enable pseudo NMI together with function_graph tracer, will lead
>>> the system to a hang. This is easy to reproduce,
>>>
>>>    1) Set "irqchip.gicv3_pseudo_nmi=1" on the kernel command line
>>>    2) echo function_graph > /sys/kernel/debug/tracing/current_tracer
>>>
>>> This patch (RFC) set gic_handle_irq() as notrace and it seems works
>>> fine now. But I have no idea about what the issue is exactly, and
>>> you can regard this patch as a report then :)
>>>
>>> Can someone give a look at it and provide some explanations ?
>>>

Thanks for testing this and reporting the issue.

>>> Thanks!
>>>
>>> Cc: Julien Thierry <julien.thierry@arm.com>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>>> ---
>>>   drivers/irqchip/irq-gic-v3.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>> index 15e55d3..8d0c25f 100644
>>> --- a/drivers/irqchip/irq-gic-v3.c
>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>> @@ -487,7 +487,7 @@ static inline void gic_handle_nmi(u32 irqnr,
>>> struct pt_regs *regs)
>>>           gic_deactivate_unhandled(irqnr);
>>>   }
>>>   -static asmlinkage void __exception_irq_entry gic_handle_irq(struct
>>> pt_regs *regs)
>>> +static asmlinkage notrace void __exception_irq_entry
>>> gic_handle_irq(struct pt_regs *regs)
>>>   {
>>>       u32 irqnr;
>>>  
>>
>>
>> That's interesting. Do you have any out of tree patch that actually
>> makes use of the pseudo-NMI feature? Without those patches, the
>> behaviour should stay unchanged.
> 
> I am at commit 1a9df9e29c2afecf6e3089442d429b377279ca3c. No more
> patches, and this is the most confusing. Just out of curiosity, I
> wanted to run Julien's "Use NMI for perf interrupt" patch (posted
> on the mailing list), so I have to enable NMI first.
> 
> That said, with
>   1) Select Kernel Feature -> Support for NMI-like interrupts
>   2) Set "irqchip.gicv3_pseudo_nmi=1" on the kernel command line
>   3) No pseudo-NMIs have been generated at all
> and this issue was hit.
> 

I finally found out what happens.

When using interrupt priority masking, at the begining of
gic_handle_irq(), we are in this awkward state where we still have the I
bit set and PMR unmasked (this is because we cannot ack the interrupt
that was signaled if it has lower priority than the current priority mask).

To try and keep things simple, we decided that local_irq_*() would only
deal with PMR (when using priority masking). With one additional case
being that, if PSR.I is set when saving flags, we'd represent it in the
form of a value of PMR (i.e. GIC_PRIO_IRQOFF), so that irqs_disabled()
and such would still accurately state that no interrupt could happen in
those sections. The assumption was that in the few sections were we are
having the PSR.I set, we wouldn't care about having interrupts disabled
with PSR.I or PMR. And now that assumption appears to be wrong:

trace_graph_entry(), called at the begining of gic_handle_irq() when
enabling the tracer, does use local_irq_save/restore(). The save
operation returns flags GIC_PRIO_IRQOFF (because PSR.I is set when we
enter gic_handle_irq() ). The restore operation will then proceed to
mask PMR, once we get back to gic_handle_irq() we can't acknowledge the
interrupt we just received...

The function tracer does not appear to save/restore flags on function
entry (I saw save/restore operations in the stack tracer but for some
reason couldn't get them to trigger the issue).

To confirm this, I checked with the following diff (which is not a fix,
it is better to mark gic_handle_irq() as notrace if I don't find
something more suitable).

Cheers,

-- 
Julien Thierry

-->

diff --git a/kernel/trace/trace_functions_graph.c
b/kernel/trace/trace_functions_graph.c
index 69ebf3c..80b941e 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -133,6 +133,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
        int ret;
        int cpu;
        int pc;
+       bool restore = false;

        if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT))
                return 0;
@@ -172,7 +173,13 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
        if (tracing_thresh)
                return 1;

-       local_irq_save(flags);
+       if (!irqs_disabled()) {
+               restore = true;
+               local_irq_save(flags);
+       } else {
+               local_save_flags(flags);
+       }
+
        cpu = raw_smp_processor_id();
        data = per_cpu_ptr(tr->trace_buffer.data, cpu);
        disabled = atomic_inc_return(&data->disabled);
@@ -184,7 +191,8 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
        }

        atomic_dec(&data->disabled);
-       local_irq_restore(flags);
+       if (restore)
+               local_irq_restore(flags);

        return ret;
 }

