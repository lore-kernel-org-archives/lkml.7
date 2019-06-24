Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E8EC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C779E20652
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfFXP1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:27:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38438 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfFXP07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:26:59 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfQrW-0007ym-Eo; Mon, 24 Jun 2019 17:26:30 +0200
Date:   Mon, 24 Jun 2019 17:26:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Beulich <jbeulich@suse.com>
Subject: Re: x86: Spurious vectors not handled robustly
In-Reply-To: <alpine.DEB.2.21.1906241541290.32342@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1906241725340.32342@nanos.tec.linutronix.de>
References: <e525108f-3749-4e1d-1ac2-0d0a2655f15f@siemens.com> <alpine.DEB.2.21.1906241204430.32342@nanos.tec.linutronix.de> <1565f016-4e3b-fa89-62e5-fc77594ee5aa@siemens.com> <alpine.DEB.2.21.1906241236390.32342@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906241541290.32342@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019, Thomas Gleixner wrote:
>  
> +#ifdef CONFIG_X86_LOCAL_APIC
> +	.align 8
> +ENTRY(spurious_entries_start)
> +    vector=FIRST_SYSTEM_VECTOR
> +    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
> +	pushl	$(~vector+0x80)			/* Note: always in signed byte range */
> +    vector=vector+1
> +	jmp	common_spurious_vector

Moo. Not syncing the compile machine and the laptop! That should obviously be

 +	jmp	common_spurious

> +	.align	8
> +    .endr
> +END(spurious_entries_start)
> +
> +common_spurious:
> +	ASM_CLAC
> +	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
> +	SAVE_ALL switch_stacks=1
> +	ENCODE_FRAME_POINTER
> +	TRACE_IRQS_OFF
> +	movl	%esp, %eax
> +	call	smp_spurious_interrupt
> +	jmp	ret_from_intr
> +ENDPROC(common_interrupt)
> +#endif
> +
>  /*
>   * the CPU automatically disables interrupts when executing an IRQ vector,
>   * so IRQ-flags tracing has to follow that:
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -375,6 +375,18 @@ ENTRY(irq_entries_start)
>      .endr
>  END(irq_entries_start)
>  
> +	.align 8
> +ENTRY(spurious_entries_start)
> +    vector=FIRST_SYSTEM_VECTOR
> +    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
> +	UNWIND_HINT_IRET_REGS
> +	pushq	$(~vector+0x80)			/* Note: always in signed byte range */
> +	jmp	common_spurious
> +	.align	8
> +	vector=vector+1
> +    .endr
> +END(spurious_entries_start)
> +
>  .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
>  #ifdef CONFIG_DEBUG_ENTRY
>  	pushq %rax
> @@ -571,10 +583,20 @@ END(interrupt_entry)
>  
>  /* Interrupt entry/exit. */
>  
> -	/*
> -	 * The interrupt stubs push (~vector+0x80) onto the stack and
> -	 * then jump to common_interrupt.
> -	 */
> +/*
> + * The interrupt stubs push (~vector+0x80) onto the stack and
> + * then jump to common_spurious/interrupt.
> + */
> +common_spurious:
> +	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
> +	call	interrupt_entry
> +	UNWIND_HINT_REGS indirect=1
> +	call	smp_spurious_interrupt		/* rdi points to pt_regs */
> +	jmp	ret_from_intr
> +END(common_spurious)
> +_ASM_NOKPROBE(common_spurious)
> +
> +/* common_interrupt is a hotpath. Align it */
>  	.p2align CONFIG_X86_L1_CACHE_SHIFT
>  common_interrupt:
>  	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
> --- a/arch/x86/include/asm/hw_irq.h
> +++ b/arch/x86/include/asm/hw_irq.h
> @@ -150,6 +150,8 @@ extern char irq_entries_start[];
>  #define trace_irq_entries_start irq_entries_start
>  #endif
>  
> +extern char spurious_entries_start[];
> +
>  #define VECTOR_UNUSED		NULL
>  #define VECTOR_RETRIGGERED	((void *)~0UL)
>  
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -319,7 +319,8 @@ void __init idt_setup_apic_and_irq_gates
>  #ifdef CONFIG_X86_LOCAL_APIC
>  	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
>  		set_bit(i, system_vectors);
> -		set_intr_gate(i, spurious_interrupt);
> +		entry = spurious_entries_start + 8 * (i - FIRST_SYSTEM_VECTOR);
> +		set_intr_gate(i, entry);
>  	}
>  #endif
>  }
> 
