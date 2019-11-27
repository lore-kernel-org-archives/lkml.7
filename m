Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42D7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993C320674
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfK0PMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:12:01 -0500
Received: from foss.arm.com ([217.140.110.172]:48830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfK0PMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:12:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0118030E;
        Wed, 27 Nov 2019 07:12:00 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C01E3F68E;
        Wed, 27 Nov 2019 07:11:57 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:11:55 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, allison@lohutok.net, info@metux.net,
        alexios.zavras@intel.com, sstabellini@kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, stefan@agner.ch,
        yamada.masahiro@socionext.com, xen-devel@lists.xenproject.org,
        linux@armlinux.org.uk
Subject: Re: [PATCH v2 3/3] arm64: remove the rest of asm-uaccess.h
Message-ID: <20191127151154.GC51937@lakrids.cambridge.arm.com>
References: <20191122022406.590141-1-pasha.tatashin@soleen.com>
 <20191122022406.590141-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122022406.590141-4-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:24:06PM -0500, Pavel Tatashin wrote:
> The __uaccess_ttbr0_disable and __uaccess_ttbr0_enable,
> are the last two macros defined in asm-uaccess.h.
> 
> Replace them with C wrappers and call C functions from
> kernel_entry and kernel_exit.

For now, please leave those as-is.

I don't think we want to have out-of-line C wrappers in the middle of
the entry assembly where we don't have a complete kernel environment.
The use in entry code can also assume non-preemptibility, while the C
functions have to explcitily disable that.

We can certainly remove the includes of <asm/asm-uaccess.h> elsewhere,
and maybe fold the macros into entry.S if it's not too crowded.

Thanks,
Mark.

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/include/asm/asm-uaccess.h | 38 ----------------------------
>  arch/arm64/kernel/entry.S            |  6 ++---
>  arch/arm64/lib/clear_user.S          |  2 +-
>  arch/arm64/lib/copy_from_user.S      |  2 +-
>  arch/arm64/lib/copy_in_user.S        |  2 +-
>  arch/arm64/lib/copy_to_user.S        |  2 +-
>  arch/arm64/mm/cache.S                |  1 -
>  arch/arm64/mm/context.c              | 12 +++++++++
>  8 files changed, 19 insertions(+), 46 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/asm-uaccess.h
> 
> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
> deleted file mode 100644
> index 8f763e5b41b1..000000000000
> --- a/arch/arm64/include/asm/asm-uaccess.h
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_ASM_UACCESS_H
> -#define __ASM_ASM_UACCESS_H
> -
> -#include <asm/alternative.h>
> -#include <asm/kernel-pgtable.h>
> -#include <asm/mmu.h>
> -#include <asm/sysreg.h>
> -#include <asm/assembler.h>
> -
> -/*
> - * User access enabling/disabling macros.
> - */
> -#ifdef CONFIG_ARM64_SW_TTBR0_PAN
> -	.macro	__uaccess_ttbr0_disable, tmp1
> -	mrs	\tmp1, ttbr1_el1			// swapper_pg_dir
> -	bic	\tmp1, \tmp1, #TTBR_ASID_MASK
> -	sub	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE	// reserved_ttbr0 just before swapper_pg_dir
> -	msr	ttbr0_el1, \tmp1			// set reserved TTBR0_EL1
> -	isb
> -	add	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE
> -	msr	ttbr1_el1, \tmp1		// set reserved ASID
> -	isb
> -	.endm
> -
> -	.macro	__uaccess_ttbr0_enable, tmp1, tmp2
> -	get_current_task \tmp1
> -	ldr	\tmp1, [\tmp1, #TSK_TI_TTBR0]	// load saved TTBR0_EL1
> -	mrs	\tmp2, ttbr1_el1
> -	extr    \tmp2, \tmp2, \tmp1, #48
> -	ror     \tmp2, \tmp2, #16
> -	msr	ttbr1_el1, \tmp2		// set the active ASID
> -	isb
> -	msr	ttbr0_el1, \tmp1		// set the non-PAN TTBR0_EL1
> -	isb
> -	.endm
> -#endif
> -#endif
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 583f71abbe98..c7b571e6d0f2 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -22,8 +22,8 @@
>  #include <asm/mmu.h>
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
> +#include <asm/kernel-pgtable.h>
>  #include <asm/thread_info.h>
> -#include <asm/asm-uaccess.h>
>  #include <asm/unistd.h>
>  
>  /*
> @@ -219,7 +219,7 @@ alternative_else_nop_endif
>  	and	x23, x23, #~PSR_PAN_BIT		// Clear the emulated PAN in the saved SPSR
>  	.endif
>  
> -	__uaccess_ttbr0_disable x21
> +	bl __uaccess_ttbr0_disable_c
>  1:
>  #endif
>  
> @@ -293,7 +293,7 @@ alternative_else_nop_endif
>  	tbnz	x22, #22, 1f			// Skip re-enabling TTBR0 access if the PSR_PAN_BIT is set
>  	.endif
>  
> -	__uaccess_ttbr0_enable x0, x1
> +	bl	__uaccess_ttbr0_enable_c
>  
>  	.if	\el == 0
>  	/*
> diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
> index aeafc03e961a..b0b4a86a09e2 100644
> --- a/arch/arm64/lib/clear_user.S
> +++ b/arch/arm64/lib/clear_user.S
> @@ -6,7 +6,7 @@
>   */
>  #include <linux/linkage.h>
>  
> -#include <asm/asm-uaccess.h>
> +#include <asm/alternative.h>
>  #include <asm/assembler.h>
>  
>  	.text
> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
> index ebb3c06cbb5d..142bc7505518 100644
> --- a/arch/arm64/lib/copy_from_user.S
> +++ b/arch/arm64/lib/copy_from_user.S
> @@ -5,7 +5,7 @@
>  
>  #include <linux/linkage.h>
>  
> -#include <asm/asm-uaccess.h>
> +#include <asm/alternative.h>
>  #include <asm/assembler.h>
>  #include <asm/cache.h>
>  
> diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
> index 3d8153a1ebce..04dc48ca26f7 100644
> --- a/arch/arm64/lib/copy_in_user.S
> +++ b/arch/arm64/lib/copy_in_user.S
> @@ -7,7 +7,7 @@
>  
>  #include <linux/linkage.h>
>  
> -#include <asm/asm-uaccess.h>
> +#include <asm/alternative.h>
>  #include <asm/assembler.h>
>  #include <asm/cache.h>
>  
> diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
> index 357eae2c18eb..8f3218ae88ab 100644
> --- a/arch/arm64/lib/copy_to_user.S
> +++ b/arch/arm64/lib/copy_to_user.S
> @@ -5,7 +5,7 @@
>  
>  #include <linux/linkage.h>
>  
> -#include <asm/asm-uaccess.h>
> +#include <asm/alternative.h>
>  #include <asm/assembler.h>
>  #include <asm/cache.h>
>  
> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> index 408d317a47d2..7940d6ef5da5 100644
> --- a/arch/arm64/mm/cache.S
> +++ b/arch/arm64/mm/cache.S
> @@ -12,7 +12,6 @@
>  #include <asm/assembler.h>
>  #include <asm/cpufeature.h>
>  #include <asm/alternative.h>
> -#include <asm/asm-uaccess.h>
>  
>  /*
>   *	__arch_flush_icache_range(start,end)
> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index b5e329fde2dd..4fc32c504dea 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -237,6 +237,18 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
>  		cpu_switch_mm(mm->pgd, mm);
>  }
>  
> +#ifdef CONFIG_ARM64_SW_TTBR0_PAN
> +asmlinkage void __uaccess_ttbr0_enable_c(void)
> +{
> +	__uaccess_ttbr0_enable();
> +}
> +
> +asmlinkage void __uaccess_ttbr0_disable_c(void)
> +{
> +	__uaccess_ttbr0_disable();
> +}
> +#endif
> +
>  /* Errata workaround post TTBRx_EL1 update. */
>  asmlinkage void post_ttbr_update_workaround(void)
>  {
> -- 
> 2.24.0
> 
