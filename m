Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3102C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A0920700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDCQaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:30:22 -0400
Received: from foss.arm.com ([217.140.101.70]:44392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCQaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:30:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D815880D;
        Wed,  3 Apr 2019 09:30:18 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E4653F68F;
        Wed,  3 Apr 2019 09:30:16 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64: irqflags: fix incomplete save & restore
To:     Wei Li <liwei391@huawei.com>, marc.zyngier@arm.com,
        rostedt@goodmis.org
Cc:     mark.rutland@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
        james.morse@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com,
        huawei.libin@huawei.com
References: <20190403152854.27741-1-liwei391@huawei.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <dac1f926-e621-c29c-ac95-463aa92db527@arm.com>
Date:   Wed, 3 Apr 2019 17:30:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190403152854.27741-1-liwei391@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Thanks for looking into this.

On 03/04/2019 16:28, Wei Li wrote:
> To support the arm64 pseudo nmi, function arch_local_irq_save() and
> arch_local_irq_restore() now operate ICC_PMR_EL1 insead of daif.
> But i found the logic of the save and restore may be suspicious:
> 
> arch_local_irq_save():
> daif.i_on	pmr_on	->	flag.i_on
> 1			0		|	0
> 1			1		|	1
> 0			1		|	0		--[1]
> 0			0		|	0
> 
> arch_local_irq_restore():
> daif.i_on	pmr_on	<-	flag.i_on
> x			0		|	0
> x			1		|	1
> 
> As we see, the condintion [1] will never be restored honestly. When doing
> function_graph trace at gic_handle_irq(), calling local_irq_save() and
> local_irq_restore() in trace_graph_entry() will just go into this
> condintion. Therefore the irq can never be processed and leading to hang.
> 
> In this patch, we do the save & restore exactly, and make sure the
> arch_irqs_disabled_flags() returns correctly.

Thinking out loud:

So, with this patch we make sure that PMR is not sneakily altered when
restoring a state with PSR.I == 1 and PMR == GIC_PRIO_IRQON.

One thing that could be odd from such a state is:

	flags = local_irq_save(); // local_irqs_disabled_flags(flags) == true

	[...]

	write_sysreg(ICC_PMR_EL1, GIC_PRIO_IRQOFF);
	write_sysreg(daif, read_sysreg(daif) & ~PSR_I_BIT);

	[...]

	local_irq_restore(flags);

Where restoring flags that indicated us that interrupts were disabled
suddenly enable interrupts.

But doing a save/restore around an operation that fiddles with PSR.I
doesn't make sense, especially when we are using PMR for normal
enable/disable.

I think your suggestion is better that what we have right now, but I'd
like to think about it a bit more.

In a previous version of the priority masking, PSR.I was both saved and
restored in the flags (almost like you did except you don't restore it
in your case). So I'm wondering whether we should just go back to that
option... (Maybe taking inspiration from your patch and just keep all
daif bits and stuff them as they are in the upper 32 bits since both
daif and pmr are 32 bit registers and the flags are 64 bits).

Other people's opinion are welcome as well.

> 
> Fix: commit 4a503217ce37 ("arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking")
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  arch/arm64/include/asm/irqflags.h | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 43d8366c1e87..7bc6a79f31c4 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -76,8 +76,7 @@ static inline unsigned long arch_local_save_flags(void)
>  	 * The asm is logically equivalent to:
>  	 *
>  	 * if (system_uses_irq_prio_masking())
> -	 *	flags = (daif_bits & PSR_I_BIT) ?
> -	 *			GIC_PRIO_IRQOFF :
> +	 *	flags = (daif_bits << 32) |
>  	 *			read_sysreg_s(SYS_ICC_PMR_EL1);
>  	 * else
>  	 *	flags = daif_bits;
> @@ -87,11 +86,11 @@ static inline unsigned long arch_local_save_flags(void)
>  			"nop\n"
>  			"nop",
>  			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1) "\n"
> -			"ands	%1, %1, " __stringify(PSR_I_BIT) "\n"
> -			"csel	%0, %0, %2, eq",
> +			"lsl	%1, %1, #32\n"
> +			"orr	%0, %0, %1",
>  			ARM64_HAS_IRQ_PRIO_MASKING)
>  		: "=&r" (flags), "+r" (daif_bits)
> -		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
> +		:
>  		: "memory");
>  
>  	return flags;
> @@ -119,8 +118,8 @@ static inline void arch_local_irq_restore(unsigned long flags)
>  			"msr_s	" __stringify(SYS_ICC_PMR_EL1) ", %0\n"
>  			"dsb	sy",
>  			ARM64_HAS_IRQ_PRIO_MASKING)
> -		: "+r" (flags)
>  		:
> +		: "r" ((int)flags)

Nit: If we go with that, can we cast this to "u32" or "uint32_t"?

>  		: "memory");
>  }
>  
> @@ -130,12 +129,14 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
>  
>  	asm volatile(ALTERNATIVE(
>  			"and	%w0, %w1, #" __stringify(PSR_I_BIT) "\n"
> +			"nop\n"
>  			"nop",
> +			"and	%w0, %w2, #" __stringify(PSR_I_BIT) "\n"
>  			"cmp	%w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
> -			"cset	%w0, ls",
> +			"cinc	%w0, %w0, ls",
>  			ARM64_HAS_IRQ_PRIO_MASKING)
>  		: "=&r" (res)
> -		: "r" ((int) flags)
> +		: "r" ((int) flags), "r" (flags >> 32)

Same.

>  		: "memory");
>  
>  	return res;
> 

Thanks,

-- 
Julien Thierry
