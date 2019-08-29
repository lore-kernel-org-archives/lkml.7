Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8117C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A53C233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfH2Jrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:47:32 -0400
Received: from foss.arm.com ([217.140.110.172]:41504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfH2Jrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:47:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D44A28;
        Thu, 29 Aug 2019 02:47:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0F0D3F246;
        Thu, 29 Aug 2019 02:47:29 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:47:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthew Leach <matthew.leach@arm.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: use x22 to save boot exception level
Message-ID: <20190829094720.GA44575@lakrids.cambridge.arm.com>
References: <20190828173318.12428-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828173318.12428-1-afd@ti.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Aug 28, 2019 at 01:33:18PM -0400, Andrew F. Davis wrote:
> The exception level in which the kernel was entered needs to be saved for
> later. We do this by writing the exception level to memory. As this data
> is written with the MMU/cache off it will bypass any cache, after this we
> invalidate the address so that later reads from cacheable mappings do not
> read a stale cache line. The side effect of this invalidate is any
> existing cache line for this address in the same coherency domain will be
> cleaned and written into memory, possibly overwriting the data we just
> wrote. As this memory is treated as cacheable by already running cores it
> on not architecturally safe to perform any non-caching accesses to this
> memory anyway.

Are you seeing an issue in practice here, or is this something that
you've found by inspection?

If this is an issue in practice, can you tell me more about the system,
i.e.

- Which CPU models do you see this with?
- Do you see this with the boot CPU, secondaries, or both?
- Do you have a system-level cache? If so, which model?
- Do you see this on bare-metal?
- Do you see this under a hypervisor? If so, which hypervisor?

We place __boot_cpu_mode in the .mmuoff.data.write section, which is
only written with the MMU off (i.e. with non-cacheable accesses), such
that the cached copy should always be clean and shouldn't be written
back. Your description sounds like you're seeing a write-back, which is
surprising and may indicate a bug elsewhere.

Depending on what exactly you're seeing, this could also be an issue for
__early_cpu_boot_status and the early page table creation, so I'd like
to understand that better.

Thanks,
Mark.

> Lets avoid these issues altogether by moving the writing of the boot
> exception level to after MMU/caching has been enabled. Saving the boot
> state in unused register x22 until we can safely and coherently write out
> this data.
> 
> As the data is not written with the MMU off anymore we move the variable
> definition out of this section and into a regular C code data section.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  arch/arm64/kernel/head.S | 31 +++++++++++--------------------
>  arch/arm64/kernel/smp.c  | 10 ++++++++++
>  2 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 2cdacd1c141b..4c71493742c5 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -99,6 +99,7 @@ pe_header:
>  	 *
>  	 *  Register   Scope                      Purpose
>  	 *  x21        stext() .. start_kernel()  FDT pointer passed at boot in x0
> +	 *  x22        stext() .. start_kernel()  exception level core was booted
>  	 *  x23        stext() .. start_kernel()  physical misalignment/KASLR offset
>  	 *  x28        __create_page_tables()     callee preserved temp register
>  	 *  x19/x20    __primary_switch()         callee preserved temp registers
> @@ -108,7 +109,6 @@ ENTRY(stext)
>  	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
>  	adrp	x23, __PHYS_OFFSET
>  	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
> -	bl	set_cpu_boot_mode_flag
>  	bl	__create_page_tables
>  	/*
>  	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
> @@ -428,6 +428,8 @@ __primary_switched:
>  	sub	x4, x4, x0			// the kernel virtual and
>  	str_l	x4, kimage_voffset, x5		// physical mappings
>  
> +	bl	set_cpu_boot_mode_flag
> +
>  	// Clear BSS
>  	adr_l	x0, __bss_start
>  	mov	x1, xzr
> @@ -470,7 +472,7 @@ EXPORT_SYMBOL(kimage_vaddr)
>   * If we're fortunate enough to boot at EL2, ensure that the world is
>   * sane before dropping to EL1.
>   *
> - * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in w0 if
> + * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in w22 if
>   * booted in EL1 or EL2 respectively.
>   */
>  ENTRY(el2_setup)
> @@ -480,7 +482,7 @@ ENTRY(el2_setup)
>  	b.eq	1f
>  	mov_q	x0, (SCTLR_EL1_RES1 | ENDIAN_SET_EL1)
>  	msr	sctlr_el1, x0
> -	mov	w0, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
> +	mov	w22, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
>  	isb
>  	ret
>  
> @@ -593,7 +595,7 @@ set_hcr:
>  
>  	cbz	x2, install_el2_stub
>  
> -	mov	w0, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
> +	mov	w22, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
>  	isb
>  	ret
>  
> @@ -632,7 +634,7 @@ install_el2_stub:
>  		      PSR_MODE_EL1h)
>  	msr	spsr_el2, x0
>  	msr	elr_el2, lr
> -	mov	w0, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
> +	mov	w22, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
>  	eret
>  ENDPROC(el2_setup)
>  
> @@ -642,12 +644,10 @@ ENDPROC(el2_setup)
>   */
>  set_cpu_boot_mode_flag:
>  	adr_l	x1, __boot_cpu_mode
> -	cmp	w0, #BOOT_CPU_MODE_EL2
> +	cmp	w22, #BOOT_CPU_MODE_EL2
>  	b.ne	1f
> -	add	x1, x1, #4
> -1:	str	w0, [x1]			// This CPU has booted in EL1
> -	dmb	sy
> -	dc	ivac, x1			// Invalidate potentially stale cache line
> +	add	x1, x1, #4			// This CPU has booted in EL2
> +1:	str	w22, [x1]
>  	ret
>  ENDPROC(set_cpu_boot_mode_flag)
>  
> @@ -658,16 +658,7 @@ ENDPROC(set_cpu_boot_mode_flag)
>   * sufficient alignment that the CWG doesn't overlap another section.
>   */
>  	.pushsection ".mmuoff.data.write", "aw"
> -/*
> - * We need to find out the CPU boot mode long after boot, so we need to
> - * store it in a writable variable.
> - *
> - * This is not in .bss, because we set it sufficiently early that the boot-time
> - * zeroing of .bss would clobber it.
> - */
> -ENTRY(__boot_cpu_mode)
> -	.long	BOOT_CPU_MODE_EL2
> -	.long	BOOT_CPU_MODE_EL1
> +
>  /*
>   * The booting CPU updates the failed status @__early_cpu_boot_status,
>   * with MMU turned off.
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 018a33e01b0e..66bdcaf61a46 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -65,6 +65,16 @@ struct secondary_data secondary_data;
>  /* Number of CPUs which aren't online, but looping in kernel text. */
>  int cpus_stuck_in_kernel;
>  
> +/*
> + * We need to find out the CPU boot mode long after boot, so we need to
> + * store it in a writable variable in early boot. Any core started in
> + * EL1 will write that to the first location, EL2 to the second. After
> + * all cores are started this allows us to check that all cores started
> + * in the same mode.
> + */
> +u32 __boot_cpu_mode[2] = { BOOT_CPU_MODE_EL2, BOOT_CPU_MODE_EL1 };
> +EXPORT_SYMBOL(__boot_cpu_mode);
> +
>  enum ipi_msg_type {
>  	IPI_RESCHEDULE,
>  	IPI_CALL_FUNC,
> -- 
> 2.17.1
> 
