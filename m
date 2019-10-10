Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B598C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AF7218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TOvAZmrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfJJUtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:49:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35159 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:49:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id c3so3377674plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FbuS4s96gtXfKE+Jv4TQDokuX4OO+vajbwsmDQ2Vtl4=;
        b=TOvAZmrP1VlBVLd+AvbPtBguYOELftNyPaaX1defv8S+ZMZVZRk2ZHIWFuJ1RSLTm/
         pXNwZon01QpJhfqxmiJn3NzRIj4Eb5U8/+H1CGNcArZsNAxASfiCvbb9BxjEy9Hk/g3z
         zTfvgE08I+Z3v6JCgw4ccUDTS+fR2Nm4ddBl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FbuS4s96gtXfKE+Jv4TQDokuX4OO+vajbwsmDQ2Vtl4=;
        b=Gf/TN7WhbABocF4UYElVD3cSmNCeMw94WyQRWfyiMLnmZZEltgySywCFs1/VVcCx5q
         U48C7gF7/Iceau2VpQPb25McjoPl/jk6qxGVvm0o+EHFZvChkvVy3HrBqS8dm1gzf/sJ
         8bhd6ftKGz9CzUlibPDqrkN9B1KiTGfnHsnhf6cSPfi6/GhCdwBIQZCbVpSakt2ZHNLl
         MP2IJ9Lj0TP0MFqut1S8Gdo5dl0MLj5Xzks9pHH09PbZiLMmfymQKebCaYOTGbJll3gI
         BjcS3TGNbKk6PMdaQbhWGniLpIPDPGJ86AwKsQeo4ekBOxfAPmkDyPz2paKf2/Sofx1B
         aJwA==
X-Gm-Message-State: APjAAAVZ/S+w3r4f0rpOnnyVNM14bJD+gAH3QiPoeu5BxQ6DKBOweXgT
        0sBwVvz6x8ZEzSnuuJvj4bKVuw==
X-Google-Smtp-Source: APXvYqzuT6Yx70+R1UyFgfIksySwHI+AT7T6B3MU6VlIN6ACViHIm3XUsiyHll3enVxqNZSchWOMug==
X-Received: by 2002:a17:902:aa82:: with SMTP id d2mr11213875plr.24.1570740578240;
        Thu, 10 Oct 2019 13:49:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13sm6928244pfg.172.2019.10.10.13.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:49:37 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:49:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v3 08/10] refcount: Consolidate implementations of
 refcount_t
Message-ID: <201910101349.B889441E23@keescook>
References: <20191007154703.5574-1-will@kernel.org>
 <20191007154703.5574-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007154703.5574-9-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:47:01PM +0100, Will Deacon wrote:
> The generic implementation of refcount_t should be good enough for
> everybody, so remove ARCH_HAS_REFCOUNT and REFCOUNT_FULL entirely,
> leaving the generic implementation enabled unconditionally.

*cheering*

> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/Kconfig                       |  21 -----
>  arch/arm/Kconfig                   |   1 -
>  arch/arm64/Kconfig                 |   1 -
>  arch/s390/configs/debug_defconfig  |   1 -
>  arch/x86/Kconfig                   |   1 -
>  arch/x86/include/asm/asm.h         |   6 --
>  arch/x86/include/asm/refcount.h    | 126 -----------------------------
>  arch/x86/mm/extable.c              |  49 -----------
>  drivers/gpu/drm/i915/Kconfig.debug |   1 -
>  include/linux/refcount.h           | 122 +++++++++-------------------
>  lib/refcount.c                     |   2 +-
>  11 files changed, 41 insertions(+), 290 deletions(-)
>  delete mode 100644 arch/x86/include/asm/refcount.h
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 5f8a5d84dbbe..8bcc1c746142 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -892,27 +892,6 @@ config STRICT_MODULE_RWX
>  config ARCH_HAS_PHYS_TO_DMA
>  	bool
>  
> -config ARCH_HAS_REFCOUNT
> -	bool
> -	help
> -	  An architecture selects this when it has implemented refcount_t
> -	  using open coded assembly primitives that provide an optimized
> -	  refcount_t implementation, possibly at the expense of some full
> -	  refcount state checks of CONFIG_REFCOUNT_FULL=y.
> -
> -	  The refcount overflow check behavior, however, must be retained.
> -	  Catching overflows is the primary security concern for protecting
> -	  against bugs in reference counts.
> -
> -config REFCOUNT_FULL
> -	bool "Perform full reference count validation at the expense of speed"
> -	help
> -	  Enabling this switches the refcounting infrastructure from a fast
> -	  unchecked atomic_t implementation to a fully state checked
> -	  implementation, which can be (slightly) slower but provides protections
> -	  against various use-after-free conditions that can be used in
> -	  security flaw exploits.
> -
>  config HAVE_ARCH_COMPILER_H
>  	bool
>  	help
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 8a50efb559f3..0d3c5d7cceb7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -117,7 +117,6 @@ config ARM
>  	select OLD_SIGSUSPEND3
>  	select PCI_SYSCALL if PCI
>  	select PERF_USE_VMALLOC
> -	select REFCOUNT_FULL
>  	select RTC_LIB
>  	select SYS_SUPPORTS_APM_EMULATION
>  	# Above selects are sorted alphabetically; please add new ones
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 41a9b4257b72..bc990d3abfe9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -181,7 +181,6 @@ config ARM64
>  	select PCI_SYSCALL if PCI
>  	select POWER_RESET
>  	select POWER_SUPPLY
> -	select REFCOUNT_FULL
>  	select SPARSE_IRQ
>  	select SWIOTLB
>  	select SYSCTL_EXCEPTION_TRACE
> diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
> index 347f48702edb..ded15e2add36 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -61,7 +61,6 @@ CONFIG_OPROFILE=m
>  CONFIG_KPROBES=y
>  CONFIG_JUMP_LABEL=y
>  CONFIG_STATIC_KEYS_SELFTEST=y
> -CONFIG_REFCOUNT_FULL=y
>  CONFIG_LOCK_EVENT_COUNTS=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_FORCE_LOAD=y
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d6e1faa28c58..fa6274f1e370 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -73,7 +73,6 @@ config X86
>  	select ARCH_HAS_PMEM_API		if X86_64
>  	select ARCH_HAS_PTE_DEVMAP		if X86_64
>  	select ARCH_HAS_PTE_SPECIAL
> -	select ARCH_HAS_REFCOUNT
>  	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
>  	select ARCH_HAS_UACCESS_MCSAFE		if X86_64 && X86_MCE
>  	select ARCH_HAS_SET_MEMORY
> diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
> index 3ff577c0b102..5a0c14ebef70 100644
> --- a/arch/x86/include/asm/asm.h
> +++ b/arch/x86/include/asm/asm.h
> @@ -139,9 +139,6 @@
>  # define _ASM_EXTABLE_EX(from, to)				\
>  	_ASM_EXTABLE_HANDLE(from, to, ex_handler_ext)
>  
> -# define _ASM_EXTABLE_REFCOUNT(from, to)			\
> -	_ASM_EXTABLE_HANDLE(from, to, ex_handler_refcount)
> -
>  # define _ASM_NOKPROBE(entry)					\
>  	.pushsection "_kprobe_blacklist","aw" ;			\
>  	_ASM_ALIGN ;						\
> @@ -170,9 +167,6 @@
>  # define _ASM_EXTABLE_EX(from, to)				\
>  	_ASM_EXTABLE_HANDLE(from, to, ex_handler_ext)
>  
> -# define _ASM_EXTABLE_REFCOUNT(from, to)			\
> -	_ASM_EXTABLE_HANDLE(from, to, ex_handler_refcount)
> -
>  /* For C file, we already have NOKPROBE_SYMBOL macro */
>  #endif
>  
> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> deleted file mode 100644
> index 232f856e0db0..000000000000
> --- a/arch/x86/include/asm/refcount.h
> +++ /dev/null
> @@ -1,126 +0,0 @@
> -#ifndef __ASM_X86_REFCOUNT_H
> -#define __ASM_X86_REFCOUNT_H
> -/*
> - * x86-specific implementation of refcount_t. Based on PAX_REFCOUNT from
> - * PaX/grsecurity.
> - */
> -#include <linux/refcount.h>
> -#include <asm/bug.h>
> -
> -/*
> - * This is the first portion of the refcount error handling, which lives in
> - * .text.unlikely, and is jumped to from the CPU flag check (in the
> - * following macros). This saves the refcount value location into CX for
> - * the exception handler to use (in mm/extable.c), and then triggers the
> - * central refcount exception. The fixup address for the exception points
> - * back to the regular execution flow in .text.
> - */
> -#define _REFCOUNT_EXCEPTION				\
> -	".pushsection .text..refcount\n"		\
> -	"111:\tlea %[var], %%" _ASM_CX "\n"		\
> -	"112:\t" ASM_UD2 "\n"				\
> -	ASM_UNREACHABLE					\
> -	".popsection\n"					\
> -	"113:\n"					\
> -	_ASM_EXTABLE_REFCOUNT(112b, 113b)
> -
> -/* Trigger refcount exception if refcount result is negative. */
> -#define REFCOUNT_CHECK_LT_ZERO				\
> -	"js 111f\n\t"					\
> -	_REFCOUNT_EXCEPTION
> -
> -/* Trigger refcount exception if refcount result is zero or negative. */
> -#define REFCOUNT_CHECK_LE_ZERO				\
> -	"jz 111f\n\t"					\
> -	REFCOUNT_CHECK_LT_ZERO
> -
> -/* Trigger refcount exception unconditionally. */
> -#define REFCOUNT_ERROR					\
> -	"jmp 111f\n\t"					\
> -	_REFCOUNT_EXCEPTION
> -
> -static __always_inline void refcount_add(unsigned int i, refcount_t *r)
> -{
> -	asm volatile(LOCK_PREFIX "addl %1,%0\n\t"
> -		REFCOUNT_CHECK_LT_ZERO
> -		: [var] "+m" (r->refs.counter)
> -		: "ir" (i)
> -		: "cc", "cx");
> -}
> -
> -static __always_inline void refcount_inc(refcount_t *r)
> -{
> -	asm volatile(LOCK_PREFIX "incl %0\n\t"
> -		REFCOUNT_CHECK_LT_ZERO
> -		: [var] "+m" (r->refs.counter)
> -		: : "cc", "cx");
> -}
> -
> -static __always_inline void refcount_dec(refcount_t *r)
> -{
> -	asm volatile(LOCK_PREFIX "decl %0\n\t"
> -		REFCOUNT_CHECK_LE_ZERO
> -		: [var] "+m" (r->refs.counter)
> -		: : "cc", "cx");
> -}
> -
> -static __always_inline __must_check
> -bool refcount_sub_and_test(unsigned int i, refcount_t *r)
> -{
> -	bool ret = GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
> -					 REFCOUNT_CHECK_LT_ZERO,
> -					 r->refs.counter, e, "er", i, "cx");
> -
> -	if (ret) {
> -		smp_acquire__after_ctrl_dep();
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
> -{
> -	bool ret = GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> -					 REFCOUNT_CHECK_LT_ZERO,
> -					 r->refs.counter, e, "cx");
> -
> -	if (ret) {
> -		smp_acquire__after_ctrl_dep();
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -static __always_inline __must_check
> -bool refcount_add_not_zero(unsigned int i, refcount_t *r)
> -{
> -	int c, result;
> -
> -	c = atomic_read(&(r->refs));
> -	do {
> -		if (unlikely(c == 0))
> -			return false;
> -
> -		result = c + i;
> -
> -		/* Did we try to increment from/to an undesirable state? */
> -		if (unlikely(c < 0 || c == INT_MAX || result < c)) {
> -			asm volatile(REFCOUNT_ERROR
> -				     : : [var] "m" (r->refs.counter)
> -				     : "cc", "cx");
> -			break;
> -		}
> -
> -	} while (!atomic_try_cmpxchg(&(r->refs), &c, result));
> -
> -	return c != 0;
> -}
> -
> -static __always_inline __must_check bool refcount_inc_not_zero(refcount_t *r)
> -{
> -	return refcount_add_not_zero(1, r);
> -}
> -
> -#endif
> diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> index 4d75bc656f97..30bb0bd3b1b8 100644
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -44,55 +44,6 @@ __visible bool ex_handler_fault(const struct exception_table_entry *fixup,
>  }
>  EXPORT_SYMBOL_GPL(ex_handler_fault);
>  
> -/*
> - * Handler for UD0 exception following a failed test against the
> - * result of a refcount inc/dec/add/sub.
> - */
> -__visible bool ex_handler_refcount(const struct exception_table_entry *fixup,
> -				   struct pt_regs *regs, int trapnr,
> -				   unsigned long error_code,
> -				   unsigned long fault_addr)
> -{
> -	/* First unconditionally saturate the refcount. */
> -	*(int *)regs->cx = INT_MIN / 2;
> -
> -	/*
> -	 * Strictly speaking, this reports the fixup destination, not
> -	 * the fault location, and not the actually overflowing
> -	 * instruction, which is the instruction before the "js", but
> -	 * since that instruction could be a variety of lengths, just
> -	 * report the location after the overflow, which should be close
> -	 * enough for finding the overflow, as it's at least back in
> -	 * the function, having returned from .text.unlikely.
> -	 */
> -	regs->ip = ex_fixup_addr(fixup);
> -
> -	/*
> -	 * This function has been called because either a negative refcount
> -	 * value was seen by any of the refcount functions, or a zero
> -	 * refcount value was seen by refcount_dec().
> -	 *
> -	 * If we crossed from INT_MAX to INT_MIN, OF (Overflow Flag: result
> -	 * wrapped around) will be set. Additionally, seeing the refcount
> -	 * reach 0 will set ZF (Zero Flag: result was zero). In each of
> -	 * these cases we want a report, since it's a boundary condition.
> -	 * The SF case is not reported since it indicates post-boundary
> -	 * manipulations below zero or above INT_MAX. And if none of the
> -	 * flags are set, something has gone very wrong, so report it.
> -	 */
> -	if (regs->flags & (X86_EFLAGS_OF | X86_EFLAGS_ZF)) {
> -		bool zero = regs->flags & X86_EFLAGS_ZF;
> -
> -		refcount_error_report(regs, zero ? "hit zero" : "overflow");
> -	} else if ((regs->flags & X86_EFLAGS_SF) == 0) {
> -		/* Report if none of OF, ZF, nor SF are set. */
> -		refcount_error_report(regs, "unexpected saturation");
> -	}
> -
> -	return true;
> -}
> -EXPORT_SYMBOL(ex_handler_refcount);
> -
>  /*
>   * Handler for when we fail to restore a task's FPU state.  We should never get
>   * here because the FPU state of a task using the FPU (task->thread.fpu.state)
> diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
> index 00786a142ff0..1400fce39c58 100644
> --- a/drivers/gpu/drm/i915/Kconfig.debug
> +++ b/drivers/gpu/drm/i915/Kconfig.debug
> @@ -22,7 +22,6 @@ config DRM_I915_DEBUG
>          depends on DRM_I915
>          select DEBUG_FS
>          select PREEMPT_COUNT
> -        select REFCOUNT_FULL
>          select I2C_CHARDEV
>          select STACKDEPOT
>          select DRM_DP_AUX_CHARDEV
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index e148639a9224..662ccb81dd65 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -1,8 +1,48 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Variant of atomic_t specialized for reference counts.
> + *
> + * The interface matches the atomic_t interface (to aid in porting) but only
> + * provides the few functions one should use for reference counting.
> + *
> + * It differs in that the counter saturates at REFCOUNT_SATURATED and will not
> + * move once there. This avoids wrapping the counter and causing 'spurious'
> + * use-after-free issues.
> + *
> + * Memory ordering rules are slightly relaxed wrt regular atomic_t functions
> + * and provide only what is strictly required for refcounts.
> + *
> + * The increments are fully relaxed; these will not provide ordering. The
> + * rationale is that whatever is used to obtain the object we're increasing the
> + * reference count on will provide the ordering. For locked data structures,
> + * its the lock acquire, for RCU/lockless data structures its the dependent
> + * load.
> + *
> + * Do note that inc_not_zero() provides a control dependency which will order
> + * future stores against the inc, this ensures we'll never modify the object
> + * if we did not in fact acquire a reference.
> + *
> + * The decrements will provide release order, such that all the prior loads and
> + * stores will be issued before, it also provides a control dependency, which
> + * will order us against the subsequent free().
> + *
> + * The control dependency is against the load of the cmpxchg (ll/sc) that
> + * succeeded. This means the stores aren't fully ordered, but this is fine
> + * because the 1->0 transition indicates no concurrency.
> + *
> + * Note that the allocator is responsible for ordering things between free()
> + * and alloc().
> + *
> + * The decrements dec_and_test() and sub_and_test() also provide acquire
> + * ordering on success.
> + *
> + */
> +
>  #ifndef _LINUX_REFCOUNT_H
>  #define _LINUX_REFCOUNT_H
>  
>  #include <linux/atomic.h>
> +#include <linux/bug.h>
>  #include <linux/compiler.h>
>  #include <linux/limits.h>
>  #include <linux/spinlock_types.h>
> @@ -56,48 +96,6 @@ static inline unsigned int refcount_read(const refcount_t *r)
>  	return atomic_read(&r->refs);
>  }
>  
> -#ifdef CONFIG_REFCOUNT_FULL
> -#include <linux/bug.h>
> -
> -/*
> - * Variant of atomic_t specialized for reference counts.
> - *
> - * The interface matches the atomic_t interface (to aid in porting) but only
> - * provides the few functions one should use for reference counting.
> - *
> - * It differs in that the counter saturates at REFCOUNT_SATURATED and will not
> - * move once there. This avoids wrapping the counter and causing 'spurious'
> - * use-after-free issues.
> - *
> - * Memory ordering rules are slightly relaxed wrt regular atomic_t functions
> - * and provide only what is strictly required for refcounts.
> - *
> - * The increments are fully relaxed; these will not provide ordering. The
> - * rationale is that whatever is used to obtain the object we're increasing the
> - * reference count on will provide the ordering. For locked data structures,
> - * its the lock acquire, for RCU/lockless data structures its the dependent
> - * load.
> - *
> - * Do note that inc_not_zero() provides a control dependency which will order
> - * future stores against the inc, this ensures we'll never modify the object
> - * if we did not in fact acquire a reference.
> - *
> - * The decrements will provide release order, such that all the prior loads and
> - * stores will be issued before, it also provides a control dependency, which
> - * will order us against the subsequent free().
> - *
> - * The control dependency is against the load of the cmpxchg (ll/sc) that
> - * succeeded. This means the stores aren't fully ordered, but this is fine
> - * because the 1->0 transition indicates no concurrency.
> - *
> - * Note that the allocator is responsible for ordering things between free()
> - * and alloc().
> - *
> - * The decrements dec_and_test() and sub_and_test() also provide acquire
> - * ordering on success.
> - *
> - */
> -
>  /**
>   * refcount_add_not_zero - add a value to a refcount unless it is 0
>   * @i: the value to add to the refcount
> @@ -260,46 +258,6 @@ static inline void refcount_dec(refcount_t *r)
>  	if (unlikely(atomic_fetch_sub_release(1, &r->refs) <= 1))
>  		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
>  }
> -#else /* CONFIG_REFCOUNT_FULL */
> -# ifdef CONFIG_ARCH_HAS_REFCOUNT
> -#  include <asm/refcount.h>
> -# else
> -static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
> -{
> -	return atomic_add_unless(&r->refs, i, 0);
> -}
> -
> -static inline void refcount_add(int i, refcount_t *r)
> -{
> -	atomic_add(i, &r->refs);
> -}
> -
> -static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
> -{
> -	return atomic_add_unless(&r->refs, 1, 0);
> -}
> -
> -static inline void refcount_inc(refcount_t *r)
> -{
> -	atomic_inc(&r->refs);
> -}
> -
> -static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
> -{
> -	return atomic_sub_and_test(i, &r->refs);
> -}
> -
> -static inline __must_check bool refcount_dec_and_test(refcount_t *r)
> -{
> -	return atomic_dec_and_test(&r->refs);
> -}
> -
> -static inline void refcount_dec(refcount_t *r)
> -{
> -	atomic_dec(&r->refs);
> -}
> -# endif /* !CONFIG_ARCH_HAS_REFCOUNT */
> -#endif /* !CONFIG_REFCOUNT_FULL */
>  
>  extern __must_check bool refcount_dec_if_one(refcount_t *r);
>  extern __must_check bool refcount_dec_not_one(refcount_t *r);
> diff --git a/lib/refcount.c b/lib/refcount.c
> index 6a61d39f9390..4ba991c2335c 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Out-of-line refcount functions common to all refcount implementations.
> + * Out-of-line refcount functions.
>   */
>  
>  #include <linux/mutex.h>
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 

-- 
Kees Cook
