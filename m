Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113F1C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22D82082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389759AbfFJLg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 07:36:57 -0400
Received: from foss.arm.com ([217.140.110.172]:41046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389748AbfFJLg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 07:36:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 445AF337;
        Mon, 10 Jun 2019 04:36:56 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DB543F557;
        Mon, 10 Jun 2019 04:38:35 -0700 (PDT)
Subject: Re: [PATCH v3 5/8] arm64: Fix incorrect irqflag restore for priority
 masking
From:   Julien Thierry <julien.thierry@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        yuzenghui@huawei.com, wanghaibin.wang@huawei.com,
        james.morse@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, liwei391@huawei.com,
        Christoffer Dall <christoffer.dall@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <1559813517-41540-1-git-send-email-julien.thierry@arm.com>
 <1559813517-41540-6-git-send-email-julien.thierry@arm.com>
 <68594d4e-ed5a-2e11-42c3-eafb4f6bbd05@arm.com>
 <cddd5774-cdf1-f14c-cf17-d160a7138a47@arm.com>
Message-ID: <5a5bfa6a-30e6-a6dd-4482-29f27888d823@arm.com>
Date:   Mon, 10 Jun 2019 12:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cddd5774-cdf1-f14c-cf17-d160a7138a47@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/2019 08:49, Julien Thierry wrote:
> 
> 
> On 07/06/2019 17:29, Marc Zyngier wrote:
>> On 06/06/2019 10:31, Julien Thierry wrote:
>>> When using IRQ priority masking to disable interrupts, in order to deal
>>> with the PSR.I state, local_irq_save() would convert the I bit into a
>>> PMR value (GIC_PRIO_IRQOFF). This resulted in local_irq_restore()
>>> potentially modifying the value of PMR in undesired location due to the
>>> state of PSR.I upon flag saving [1].
>>>
>>> In an attempt to solve this issue in a less hackish manner, introduce
>>> a bit (GIC_PRIO_IGNORE_PMR) for the PMR values that can represent
>>> whether PSR.I is being used to disable interrupts, in which case it
>>> takes precedence of the status of interrupt masking via PMR.
>>>
>>> GIC_PRIO_IGNORE_PMR is chosen such that (<pmr_value> |
>>> GIC_PRIO_IGNORE_PMR) does not mask more interrupts than <pmr_value> as
>>> some sections (e.g. arch_cpu_idle(), interrupt acknowledge path)
>>> requires PMR not to mask interrupts that could be signaled to the
>>> CPU when using only PSR.I.
>>>
>>
>> s/GIC_PRIO_IGNORE_PMR/GIC_PRIO_PSR_I_SET/
>>
>>> [1] https://www.spinics.net/lists/arm-kernel/msg716956.html
>>>
>>> Fixes: commit 4a503217ce37 ("arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking")
>>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>>> Reported-by: Zenghui Yu <yuzenghui@huawei.com>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Wei Li <liwei391@huawei.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: James Morse <james.morse@arm.com>
>>> Cc: Suzuki K Pouloze <suzuki.poulose@arm.com>
>>> Cc: Oleg Nesterov <oleg@redhat.com>
>>> ---
>>>  arch/arm64/include/asm/arch_gicv3.h |  4 ++-
>>>  arch/arm64/include/asm/daifflags.h  | 68 ++++++++++++++++++++++---------------
>>>  arch/arm64/include/asm/irqflags.h   | 67 +++++++++++++++---------------------
>>>  arch/arm64/include/asm/kvm_host.h   |  7 ++--
>>>  arch/arm64/include/asm/ptrace.h     | 10 ++++--
>>>  arch/arm64/kernel/entry.S           | 38 ++++++++++++++++++---
>>>  arch/arm64/kernel/process.c         |  2 +-
>>>  arch/arm64/kernel/smp.c             |  8 +++--
>>>  arch/arm64/kvm/hyp/switch.c         |  2 +-
>>>  9 files changed, 123 insertions(+), 83 deletions(-)
>>>

[...]

>>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
>>> index fbe1aba..b6f757f 100644
>>> --- a/arch/arm64/include/asm/irqflags.h
>>> +++ b/arch/arm64/include/asm/irqflags.h
>>> @@ -67,43 +67,46 @@ static inline void arch_local_irq_disable(void)
>>>   */
>>>  static inline unsigned long arch_local_save_flags(void)
>>>  {
>>> -	unsigned long daif_bits;
>>>  	unsigned long flags;
>>>
>>> -	daif_bits = read_sysreg(daif);
>>> -
>>> -	/*
>>> -	 * The asm is logically equivalent to:
>>> -	 *
>>> -	 * if (system_uses_irq_prio_masking())
>>> -	 *	flags = (daif_bits & PSR_I_BIT) ?
>>> -	 *			GIC_PRIO_IRQOFF :
>>> -	 *			read_sysreg_s(SYS_ICC_PMR_EL1);
>>> -	 * else
>>> -	 *	flags = daif_bits;
>>> -	 */
>>>  	asm volatile(ALTERNATIVE(
>>> -			"mov	%0, %1\n"
>>> -			"nop\n"
>>> -			"nop",
>>> -			__mrs_s("%0", SYS_ICC_PMR_EL1)
>>> -			"ands	%1, %1, " __stringify(PSR_I_BIT) "\n"
>>> -			"csel	%0, %0, %2, eq",
>>> -			ARM64_HAS_IRQ_PRIO_MASKING)
>>> -		: "=&r" (flags), "+r" (daif_bits)
>>> -		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
>>> -		: "cc", "memory");
>>> +		"mrs	%0, daif",
>>> +		__mrs_s("%0", SYS_ICC_PMR_EL1),
>>> +		ARM64_HAS_IRQ_PRIO_MASKING)
>>> +		: "=&r" (flags)
>>> +		:
>>> +		: "memory");
>>
>> I think this is worth a comment here, as you're changing the semantics
>> of arch_local_save_flags(). Maybe just indicating that the only thing
>> this should be used for is to carry the interrupt state, and nothing else.
>>
> 
> Arguably, this is what gets called by local_save_flags() which is arch
> independent and, as far as I understand, is only aware of the interrupt
> state being contained in the flags (arch might wish to store more stuff
> in it, but overall, generic code cannot rely on it).
> 
> I'll still add a comment so that code directly calling arch_save_flags()
> doesn't try to play with PSR.DA_F. (In such a cases it would be probably
> clearer for them to do direct DAIF reads/writes IMO).
> 

After checking, arch_local_save_flags() already has the following
comment above it:

/*



 * Save the current interrupt enable state.



 */


Which suggests you shouldn't rely on having the value of debug state and
other (it just happens to be there, maybe wrongfully...).

And user checking the flags should use arch_irqs_disabled_flags() rather
than "flags & PSR_I_BIT != 0".

Also, those semantics where already changed when we introduced priority
masking and included the PMR value in the irqflags.

I'm not sure there is a lot more explanation to do in this patch in
particular.

Thanks,

-- 
Julien Thierry
