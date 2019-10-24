Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8735CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9D420856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571905637;
	bh=3/0NJxWLDuGRa0pi/Aw8SPuVDgpBexipgnIiNiKI0io=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=USprk2Dd61e8IlNEYOyTfbhRCsKduz9ZEQhqyIJL88x5aTfaNTZp9LEnKle1VzenY
	 v+LBHOSMySlQ450HyKPy60AyDXW5Bc7Ubse0JSz9C346xxv/WqXZaXHpgShSllauk4
	 TJQfaXrOFQjECYVu3FyvuJR+ixsyoZvpLoQH7LCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438195AbfJXI1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:27:16 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:55749 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbfJXI1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:27:16 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iNYSb-0003IV-AU; Thu, 24 Oct 2019 10:27:09 +0200
To:     Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC 2/2] irqchip/gic: Allow the use of SGI interrupts
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 24 Oct 2019 09:27:08 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thanu Rangarajan <thanu.rangarajan@arm.com>
In-Reply-To: <fdb77138-3df8-ef51-6519-e630b6228eb0@gmail.com>
References: <20191023000547.7831-1-f.fainelli@gmail.com>
 <20191023000547.7831-3-f.fainelli@gmail.com>
 <112a725164b7fe321f27357fd4cd772f@www.loen.fr>
 <fdb77138-3df8-ef51-6519-e630b6228eb0@gmail.com>
Message-ID: <4a17f340ca1687e55855e34058d084b8@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: f.fainelli@gmail.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, souvik.chakravarty@arm.com, james.quinlan@broadcom.com, sudeep.holla@arm.com, thanu.rangarajan@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-23 18:02, Florian Fainelli wrote:
> Hello marc,
>
> On 10/23/19 6:22 AM, Marc Zyngier wrote:
>> Hi Florian,
>>
>> Needless to say, I mostly have questions...
>>
>> On 2019-10-23 01:05, Florian Fainelli wrote:
>>> SGI interrupts are a convenient way for trusted firmware to target 
>>> a
>>> specific set of CPUs. Update the ARM GIC code to allow the 
>>> translation
>>> and mapping of SGI interrupts.
>>>
>>> Since the kernel already uses SGIs for various inter-processor 
>>> interrupt
>>> activities, we specifically make sure that we do not let users of 
>>> the
>>> IRQ API to even try to map those.
>>>
>>> Internal IPIs remain dispatched through handle_IPI() while public 
>>> SGIs
>>> get promoted to a normal interrupt flow management.
>>>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>>  drivers/irqchip/irq-gic.c | 41 
>>> +++++++++++++++++++++++++++------------
>>>  1 file changed, 29 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>>> index 30ab623343d3..dcfdbaacdd64 100644
>>> --- a/drivers/irqchip/irq-gic.c
>>> +++ b/drivers/irqchip/irq-gic.c
>>> @@ -385,7 +385,10 @@ static void __exception_irq_entry
>>> gic_handle_irq(struct pt_regs *regs)
>>>               * Pairs with the write barrier in gic_raise_softirq
>>>               */
>>>              smp_rmb();
>>> -            handle_IPI(irqnr, regs);
>>> +            if (irqnr < NR_IPI)
>>> +                handle_IPI(irqnr, regs);
>>> +            else
>>> +                handle_domain_irq(gic->domain, irqnr, regs);
>>
>> Double EOI, UNPREDICTABLE territory, your state machine is now dead.
>
> Oh yes, the interrupt flow now also goes through ->irq_eoi (that's 
> the
> whole point), meh.

Indeed. But to be honest, we should probably consider moving all the 
SGI
handling to normal interrupts. There's hardly any reason why we should 
keep
SGIs out of the normal interrupt model, other than maybe performance 
(and
that's pretty dubious).

>
>>
>>>  #endif
>>>              continue;
>>>          }
>>> @@ -1005,20 +1008,34 @@ static int gic_irq_domain_translate(struct
>>> irq_domain *d,
>>>          if (fwspec->param_count < 3)
>>>              return -EINVAL;
>>>
>>> -        /* Get the interrupt number and add 16 to skip over SGIs 
>>> */
>>> -        *hwirq = fwspec->param[1] + 16;
>>> -
>>> -        /*
>>> -         * For SPIs, we need to add 16 more to get the GIC irq
>>> -         * ID number
>>> -         */
>>> -        if (!fwspec->param[0])
>>> +        *hwirq = fwspec->param[1];
>>> +        switch (fwspec->param[0]) {
>>> +        case 0:
>>> +            /*
>>> +             * For SPIs, we need to add 16 more to get the GIC irq
>>> +             * ID number
>>> +             */
>>> +            *hwirq += 16;
>>> +            /* fall through */
>>> +        case 1:
>>> +            /* Add 16 to skip over SGIs */
>>>              *hwirq += 16;
>>> +            *type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>>>
>>> -        *type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>>> +            /* Make it clear that broken DTs are... broken */
>>> +            WARN_ON(*type == IRQ_TYPE_NONE);
>>> +            break;
>>> +        case 2:
>>> +            /* Refuse to map internal IPIs */
>>> +            if (*hwirq < NR_IPI)
>>
>> So depending on how the kernel uses SGIs, you can or cannot use 
>> these SGIs.
>> That looks like a good way to corner ourselves into not being to 
>> change
>> much.
>
> arch/arm/kernel/smp.c has a forward looking statement about SGI 
> numbering:
>
>         /*
>          * SGI8-15 can be reserved by secure firmware, and thus may
>          * not be usable by the kernel. Please keep the above limited
>          * to at most 8 entries.
>          */
>
> is this something that can be used as an universal and unbreakable 
> rule
> for the ARM64 kernel as well in order to ensure SGIs 8-15 can be 
> usable
> through the IRQ API or is this simply not a guarantee at all?

There is no guarantee whatsoever. There's an ARM recommendation about 
the
above split, but that's it. Hardly something that can be enforced.

Now, your firmware is the one that gives you the DT, so if it is 
inconsistent
in configuring the interrupt and presenting it to the kernel, tough 
luck.

>> Also, do you expect this to work for both Group-0 and Group-1 
>> interrupts
>> (since you imply that this works as a communication medium with the 
>> secure
>> side)? Given that the kernel running in NS has no way to 
>> enable/disable
>> Group-0 interrupts, this looks terminally flawed. Or is that Group-1 
>> only?
>
> That would be Group-1 interrupts only, are you suggesting there is an
> additional check being done that such SGIs are actually part of 
> Group-1?

You can try and change the configuration of that interrupt (priority, 
for
example), and see if that sticks. If it doesn't, you're in trouble (and
nothing you can do about it).

>>
>> How do we describe which SGIs are guaranteed to be available to 
>> Linux?
>
> In our case, the Device Tree mailbox node gets populated its 
> interrupts
> property with the SGI number(s), and that same number is also passed 
> as
> a configuration parameter to the trusted firmware. Or are you echoing
> back to your earlier comment about the fact that if the kernel 
> changes
> its own definition of NR_IPI then we suddenly start breaking IRQ API
> uses of SGIs in a certain range?

That's indeed my worry. There is also the fact that the kernel itself 
will
never expose such reservation in DT, so we'd have to tread carefully 
here.
We probably need to specify that *only* SGI8-15 are allowed to be 
described
as such.

Another thing: why don't you use a PPI? If you use a GICv2, you're also 
using
ancient cores, and they have PPIs to spare. Or do you rely on being 
able to
inject interrupts from one core to another?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
