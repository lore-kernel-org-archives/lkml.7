Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA768C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A88206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbfFJHuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:50:08 -0400
Received: from foss.arm.com ([217.140.110.172]:37402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387781AbfFJHuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:50:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D2B0344;
        Mon, 10 Jun 2019 00:50:06 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 150323F246;
        Mon, 10 Jun 2019 00:50:00 -0700 (PDT)
Subject: Re: [PATCH v3 5/8] arm64: Fix incorrect irqflag restore for priority
 masking
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
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <cddd5774-cdf1-f14c-cf17-d160a7138a47@arm.com>
Date:   Mon, 10 Jun 2019 08:49:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <68594d4e-ed5a-2e11-42c3-eafb4f6bbd05@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/2019 17:29, Marc Zyngier wrote:
> On 06/06/2019 10:31, Julien Thierry wrote:
>> When using IRQ priority masking to disable interrupts, in order to deal
>> with the PSR.I state, local_irq_save() would convert the I bit into a
>> PMR value (GIC_PRIO_IRQOFF). This resulted in local_irq_restore()
>> potentially modifying the value of PMR in undesired location due to the
>> state of PSR.I upon flag saving [1].
>>
>> In an attempt to solve this issue in a less hackish manner, introduce
>> a bit (GIC_PRIO_IGNORE_PMR) for the PMR values that can represent
>> whether PSR.I is being used to disable interrupts, in which case it
>> takes precedence of the status of interrupt masking via PMR.
>>
>> GIC_PRIO_IGNORE_PMR is chosen such that (<pmr_value> |
>> GIC_PRIO_IGNORE_PMR) does not mask more interrupts than <pmr_value> as
>> some sections (e.g. arch_cpu_idle(), interrupt acknowledge path)
>> requires PMR not to mask interrupts that could be signaled to the
>> CPU when using only PSR.I.
>>
> 
> s/GIC_PRIO_IGNORE_PMR/GIC_PRIO_PSR_I_SET/
> 
>> [1] https://www.spinics.net/lists/arm-kernel/msg716956.html
>>
>> Fixes: commit 4a503217ce37 ("arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking")
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Reported-by: Zenghui Yu <yuzenghui@huawei.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Wei Li <liwei391@huawei.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Pouloze <suzuki.poulose@arm.com>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> ---
>>  arch/arm64/include/asm/arch_gicv3.h |  4 ++-
>>  arch/arm64/include/asm/daifflags.h  | 68 ++++++++++++++++++++++---------------
>>  arch/arm64/include/asm/irqflags.h   | 67 +++++++++++++++---------------------
>>  arch/arm64/include/asm/kvm_host.h   |  7 ++--
>>  arch/arm64/include/asm/ptrace.h     | 10 ++++--
>>  arch/arm64/kernel/entry.S           | 38 ++++++++++++++++++---
>>  arch/arm64/kernel/process.c         |  2 +-
>>  arch/arm64/kernel/smp.c             |  8 +++--
>>  arch/arm64/kvm/hyp/switch.c         |  2 +-
>>  9 files changed, 123 insertions(+), 83 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
>> index 14b41dd..9e991b6 100644
>> --- a/arch/arm64/include/asm/arch_gicv3.h
>> +++ b/arch/arm64/include/asm/arch_gicv3.h
>> @@ -163,7 +163,9 @@ static inline bool gic_prio_masking_enabled(void)
>>
>>  static inline void gic_pmr_mask_irqs(void)
>>  {
>> -	BUILD_BUG_ON(GICD_INT_DEF_PRI <= GIC_PRIO_IRQOFF);
>> +	BUILD_BUG_ON(GICD_INT_DEF_PRI < (GIC_PRIO_IRQOFF |
>> +					 GIC_PRIO_PSR_I_SET));
>> +	BUILD_BUG_ON(GICD_INT_DEF_PRI >= GIC_PRIO_IRQON);
>>  	gic_write_pmr(GIC_PRIO_IRQOFF);
>>  }
>>
>> diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
>> index db452aa..f93204f 100644
>> --- a/arch/arm64/include/asm/daifflags.h
>> +++ b/arch/arm64/include/asm/daifflags.h
>> @@ -18,6 +18,7 @@
>>
>>  #include <linux/irqflags.h>
>>
>> +#include <asm/arch_gicv3.h>
>>  #include <asm/cpufeature.h>
>>
>>  #define DAIF_PROCCTX		0
>> @@ -32,6 +33,11 @@ static inline void local_daif_mask(void)
>>  		:
>>  		:
>>  		: "memory");
>> +
>> +	/* Don't really care for a dsb here, we don't intend to enable IRQs */
>> +	if (system_uses_irq_prio_masking())
>> +		gic_write_pmr(GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET);
>> +
>>  	trace_hardirqs_off();
>>  }
>>
>> @@ -43,7 +49,7 @@ static inline unsigned long local_daif_save(void)
>>
>>  	if (system_uses_irq_prio_masking()) {
>>  		/* If IRQs are masked with PMR, reflect it in the flags */
>> -		if (read_sysreg_s(SYS_ICC_PMR_EL1) <= GIC_PRIO_IRQOFF)
>> +		if (read_sysreg_s(SYS_ICC_PMR_EL1) != GIC_PRIO_IRQON)
>>  			flags |= PSR_I_BIT;
>>  	}
>>
>> @@ -59,36 +65,44 @@ static inline void local_daif_restore(unsigned long flags)
>>  	if (!irq_disabled) {
>>  		trace_hardirqs_on();
>>
>> -		if (system_uses_irq_prio_masking())
>> -			arch_local_irq_enable();
>> -	} else if (!(flags & PSR_A_BIT)) {
>> -		/*
>> -		 * If interrupts are disabled but we can take
>> -		 * asynchronous errors, we can take NMIs
>> -		 */
>>  		if (system_uses_irq_prio_masking()) {
>> -			flags &= ~PSR_I_BIT;
>> +			gic_write_pmr(GIC_PRIO_IRQON);
>> +			dsb(sy);
>> +		}
>> +	} else if (system_uses_irq_prio_masking()) {
>> +		u64 pmr;
>> +
>> +		if (!(flags & PSR_A_BIT)) {
>>  			/*
>> -			 * There has been concern that the write to daif
>> -			 * might be reordered before this write to PMR.
>> -			 * From the ARM ARM DDI 0487D.a, section D1.7.1
>> -			 * "Accessing PSTATE fields":
>> -			 *   Writes to the PSTATE fields have side-effects on
>> -			 *   various aspects of the PE operation. All of these
>> -			 *   side-effects are guaranteed:
>> -			 *     - Not to be visible to earlier instructions in
>> -			 *       the execution stream.
>> -			 *     - To be visible to later instructions in the
>> -			 *       execution stream
>> -			 *
>> -			 * Also, writes to PMR are self-synchronizing, so no
>> -			 * interrupts with a lower priority than PMR is signaled
>> -			 * to the PE after the write.
>> -			 *
>> -			 * So we don't need additional synchronization here.
>> +			 * If interrupts are disabled but we can take
>> +			 * asynchronous errors, we can take NMIs
>>  			 */
>> -			arch_local_irq_disable();
>> +			flags &= ~PSR_I_BIT;
>> +			pmr = GIC_PRIO_IRQOFF;
>> +		} else {
>> +			pmr = GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET;
>>  		}
>> +
>> +		/*
>> +		 * There has been concern that the write to daif
>> +		 * might be reordered before this write to PMR.
>> +		 * From the ARM ARM DDI 0487D.a, section D1.7.1
>> +		 * "Accessing PSTATE fields":
>> +		 *   Writes to the PSTATE fields have side-effects on
>> +		 *   various aspects of the PE operation. All of these
>> +		 *   side-effects are guaranteed:
>> +		 *     - Not to be visible to earlier instructions in
>> +		 *       the execution stream.
>> +		 *     - To be visible to later instructions in the
>> +		 *       execution stream
>> +		 *
>> +		 * Also, writes to PMR are self-synchronizing, so no
>> +		 * interrupts with a lower priority than PMR is signaled
>> +		 * to the PE after the write.
>> +		 *
>> +		 * So we don't need additional synchronization here.
>> +		 */
>> +		gic_write_pmr(pmr);
>>  	}
>>
>>  	write_sysreg(flags, daif);
>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
>> index fbe1aba..b6f757f 100644
>> --- a/arch/arm64/include/asm/irqflags.h
>> +++ b/arch/arm64/include/asm/irqflags.h
>> @@ -67,43 +67,46 @@ static inline void arch_local_irq_disable(void)
>>   */
>>  static inline unsigned long arch_local_save_flags(void)
>>  {
>> -	unsigned long daif_bits;
>>  	unsigned long flags;
>>
>> -	daif_bits = read_sysreg(daif);
>> -
>> -	/*
>> -	 * The asm is logically equivalent to:
>> -	 *
>> -	 * if (system_uses_irq_prio_masking())
>> -	 *	flags = (daif_bits & PSR_I_BIT) ?
>> -	 *			GIC_PRIO_IRQOFF :
>> -	 *			read_sysreg_s(SYS_ICC_PMR_EL1);
>> -	 * else
>> -	 *	flags = daif_bits;
>> -	 */
>>  	asm volatile(ALTERNATIVE(
>> -			"mov	%0, %1\n"
>> -			"nop\n"
>> -			"nop",
>> -			__mrs_s("%0", SYS_ICC_PMR_EL1)
>> -			"ands	%1, %1, " __stringify(PSR_I_BIT) "\n"
>> -			"csel	%0, %0, %2, eq",
>> -			ARM64_HAS_IRQ_PRIO_MASKING)
>> -		: "=&r" (flags), "+r" (daif_bits)
>> -		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
>> -		: "cc", "memory");
>> +		"mrs	%0, daif",
>> +		__mrs_s("%0", SYS_ICC_PMR_EL1),
>> +		ARM64_HAS_IRQ_PRIO_MASKING)
>> +		: "=&r" (flags)
>> +		:
>> +		: "memory");
> 
> I think this is worth a comment here, as you're changing the semantics
> of arch_local_save_flags(). Maybe just indicating that the only thing
> this should be used for is to carry the interrupt state, and nothing else.
> 

Arguably, this is what gets called by local_save_flags() which is arch
independent and, as far as I understand, is only aware of the interrupt
state being contained in the flags (arch might wish to store more stuff
in it, but overall, generic code cannot rely on it).

I'll still add a comment so that code directly calling arch_save_flags()
doesn't try to play with PSR.DA_F. (In such a cases it would be probably
clearer for them to do direct DAIF reads/writes IMO).

>>
>>  	return flags;
>>  }
>>
>> +static inline int arch_irqs_disabled_flags(unsigned long flags)
>> +{
>> +	int res;
>> +
>> +	asm volatile(ALTERNATIVE(
>> +		"and	%w0, %w1, #" __stringify(PSR_I_BIT),
>> +		"eor	%w0, %w1, #" __stringify(GIC_PRIO_IRQOFF),
>> +		ARM64_HAS_IRQ_PRIO_MASKING)
>> +		: "=&r" (res)
>> +		: "r" ((int) flags)
>> +		: "memory");
>> +
>> +	return res;
>> +}
>> +
>>  static inline unsigned long arch_local_irq_save(void)
>>  {
>>  	unsigned long flags;
>>
>>  	flags = arch_local_save_flags();
>>
>> -	arch_local_irq_disable();
>> +	/*
>> +	 * There are too many states with IRQs disabled, just keep the current
>> +	 * state if interrupts are already disabled/masked.
>> +	 */
>> +	if (!arch_irqs_disabled_flags(flags))
>> +		arch_local_irq_disable();
>>
>>  	return flags;
>>  }
>> @@ -124,21 +127,5 @@ static inline void arch_local_irq_restore(unsigned long flags)
>>  		: "memory");
>>  }
>>
>> -static inline int arch_irqs_disabled_flags(unsigned long flags)
>> -{
>> -	int res;
>> -
>> -	asm volatile(ALTERNATIVE(
>> -			"and	%w0, %w1, #" __stringify(PSR_I_BIT) "\n"
>> -			"nop",
>> -			"cmp	%w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
>> -			"cset	%w0, ls",
>> -			ARM64_HAS_IRQ_PRIO_MASKING)
>> -		: "=&r" (res)
>> -		: "r" ((int) flags)
>> -		: "cc", "memory");
>> -
>> -	return res;
>> -}
>>  #endif
>>  #endif
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 4bcd9c1..fdc0e1c 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -608,11 +608,12 @@ static inline void kvm_arm_vhe_guest_enter(void)
>>  	 * will not signal the CPU of interrupts of lower priority, and the
>>  	 * only way to get out will be via guest exceptions.
>>  	 * Naturally, we want to avoid this.
>> +	 *
>> +	 * local_daif_mask() already sets IGNORE_PMR, we just need a
> 
> GIC_PRIO_PSR_I_SET?

Yes.

> 
>> +	 * dsb to ensure the redistributor is forwards EL2 IRQs to the CPU.
>>  	 */
>> -	if (system_uses_irq_prio_masking()) {
>> -		gic_write_pmr(GIC_PRIO_IRQON);
>> +	if (system_uses_irq_prio_masking())
>>  		dsb(sy);
>> -	}
>>  }
>>
>>  static inline void kvm_arm_vhe_guest_exit(void)
>> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
>> index b2de329..da22422 100644
>> --- a/arch/arm64/include/asm/ptrace.h
>> +++ b/arch/arm64/include/asm/ptrace.h
>> @@ -35,9 +35,15 @@
>>   * means masking more IRQs (or at least that the same IRQs remain masked).
>>   *
>>   * To mask interrupts, we clear the most significant bit of PMR.
>> + *
>> + * Some code sections either automatically switch back to PSR.I or explicitly
>> + * require to not use priority masking. If bit GIC_PRIO_PSR_I_SET is included
>> + * in the  the priority mask, it indicates that PSR.I should be set and
>> + * interrupt disabling temporarily does not rely on IRQ priorities.
>>   */
>> -#define GIC_PRIO_IRQON		0xf0
>> -#define GIC_PRIO_IRQOFF		(GIC_PRIO_IRQON & ~0x80)
>> +#define GIC_PRIO_IRQON			0xc0
>> +#define GIC_PRIO_IRQOFF			(GIC_PRIO_IRQON & ~0x80)
>> +#define GIC_PRIO_PSR_I_SET		(1 << 4)
>>
>>  /* Additional SPSR bits not exposed in the UABI */
>>  #define PSR_IL_BIT		(1 << 20)
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 46358a3..7f92e4b 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -258,6 +258,7 @@ alternative_else_nop_endif
>>  	/*
>>  	 * Registers that may be useful after this macro is invoked:
>>  	 *
>> +	 * x20 - ICC_PMR_EL1
>>  	 * x21 - aborted SP
>>  	 * x22 - aborted PC
>>  	 * x23 - aborted PSTATE
>> @@ -449,6 +450,24 @@ alternative_endif
>>  	.endm
>>  #endif
>>
>> +	.macro	gic_prio_kentry_setup, tmp:req
>> +#ifdef CONFIG_ARM64_PSEUDO_NMI
>> +	alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>> +	mov	x20, #(GIC_PRIO_PSR_I_SET | GIC_PRIO_IRQON)
>> +	msr_s	SYS_ICC_PMR_EL1, x20
> 
> I find the implicit use of x20 quite dangerous, but hey. I guess that
> the context makes that fairly explicit.
> 

Yes, this is not intentional, I must have messed up when reworking the
code. The macro has a tmp parameter for that purpose, I just forgot to
update the body of the macro...

Thanks for spotting it.

Thanks,

-- 
Julien Thierry
