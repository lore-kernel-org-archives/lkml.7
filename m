Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8397AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DDC20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfDXNRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:17:40 -0400
Received: from foss.arm.com ([217.140.101.70]:43322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfDXNRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:17:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECD6E80D;
        Wed, 24 Apr 2019 06:17:38 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E856D3F238;
        Wed, 24 Apr 2019 06:17:36 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:17:34 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ard.biesheuvel@linaro.org, julien.thierry@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com
Subject: Re: [PATCH v3 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190424131734.GT3567@e103592.cambridge.arm.com>
References: <20190423135719.11306-1-julien.grall@arm.com>
 <20190423135719.11306-4-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423135719.11306-4-julien.grall@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 02:57:19PM +0100, Julien Grall wrote:
> When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
> the kernel may be able to use FPSIMD/SVE. This is for instance the case
> for crypto code.
> 
> Any use of FPSIMD/SVE in the kernel are clearly marked by using the
> function kernel_neon_{begin, end}. Furthermore, this can only be used
> when may_use_simd() returns true.
> 
> The current implementation of may_use_simd() allows softirq to use
> FPSIMD/SVE unless it is currently in use (i.e kernel_neon_busy is true).
> When in use, softirqs usually fall back to a software method.
> 
> At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
> when touching the FPSIMD/SVE context. This has the drawback to disable
> all softirqs even if they are not using FPSIMD/SVE.
> 
> Since a softirq is supposed to check may_use_simd() anyway before
> attempting to use FPSIMD/SVE, there is limited reason to keep softirq
> disabled when touching the FPSIMD/SVE context. Instead, we can simply
> disable preemption and mark the FPSIMD/SVE context as in use by setting
> CPU's kernel_neon_busy flag.
> 
> Two new helpers {get, put}_cpu_fpsimd_context is introduced to mark the
> area using FPSIMD/SVE context and uses them in replacement of
> local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
> also re-implemented to use the new helpers.
> 
> For use in fpsimd_thread_switch(), which is a critical path where
> preemption is already disabled, doule-underscored versions of the
> helpers are provided to avoid disabling preemption again.
> 
> The change has been benchmarked on Linux 5.1-rc4 with defconfig.
> 
> On Juno2:
>     * hackbench 100 process 1000 (10 times)
>     * .7% quicker
> 
> On ThunderX 2:
>     * hackbench 1000 process 1000 (20 times)
>     * 3.4% quicker
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> ---
>     Changes in v3:
>         - Fix typoes in the commit message
>         - Rework a bit the commit message
>         - Use imperative mood
>         - Rename kernel_neon_busy to fpsimd_context_busy
>         - Remove debug code
>         - Update comments
>         - Don't require preemption when calling fpsimd_save_and_flush_cpu_state()
> 
>     Changes in v2:
>         - Remove spurious call to kernel_neon_enable in kernel_neon_begin.
>         - Rename kernel_neon_{enable, disable} to {get, put}_cpu_fpsimd_context
>         - Introduce a double-underscore version of the helpers for case
>         where preemption is already disabled
>         - Introduce have_cpu_fpsimd_context() and use it in WARN_ON(...)
>         - Surround more places in the code with the new helpers
>         - Rework the comments
>         - Update the commit message with the benchmark result
> ---
>  arch/arm64/include/asm/simd.h |  10 ++--
>  arch/arm64/kernel/fpsimd.c    | 126 ++++++++++++++++++++++++++++--------------
>  2 files changed, 88 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> index 6495cc51246f..a6307e43b8c2 100644
> --- a/arch/arm64/include/asm/simd.h
> +++ b/arch/arm64/include/asm/simd.h
> @@ -15,9 +15,9 @@
>  #include <linux/preempt.h>
>  #include <linux/types.h>
>  
> -#ifdef CONFIG_KERNEL_MODE_NEON
> +DECLARE_PER_CPU(bool, fpsimd_context_busy);
>  
> -DECLARE_PER_CPU(bool, kernel_neon_busy);
> +#ifdef CONFIG_KERNEL_MODE_NEON
>  
>  /*
>   * may_use_simd - whether it is allowable at this time to issue SIMD
> @@ -29,15 +29,15 @@ DECLARE_PER_CPU(bool, kernel_neon_busy);
>  static __must_check inline bool may_use_simd(void)
>  {
>  	/*
> -	 * kernel_neon_busy is only set while preemption is disabled,
> +	 * fpsimd_context_busy is only set while preemption is disabled,
>  	 * and is clear whenever preemption is enabled. Since
> -	 * this_cpu_read() is atomic w.r.t. preemption, kernel_neon_busy
> +	 * this_cpu_read() is atomic w.r.t. preemption, fpsimd_context_busy
>  	 * cannot change under our feet -- if it's set we cannot be
>  	 * migrated, and if it's clear we cannot be migrated to a CPU
>  	 * where it is set.
>  	 */
>  	return !in_irq() && !irqs_disabled() && !in_nmi() &&
> -		!this_cpu_read(kernel_neon_busy);
> +		!this_cpu_read(fpsimd_context_busy);
>  }
>  
>  #else /* ! CONFIG_KERNEL_MODE_NEON */
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 5313aa257be6..6168d06bbd20 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -92,7 +92,8 @@
>   * To prevent this from racing with the manipulation of the task's FPSIMD state
>   * from task context and thereby corrupting the state, it is necessary to
>   * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
> - * flag with local_bh_disable() unless softirqs are already masked.
> + * flag with {, __}get_cpu_fpsimd_context(). This will still allow softirqs to
> + * run but prevent them to use FPSIMD.
>   *
>   * For a certain task, the sequence may look something like this:
>   * - the task gets scheduled in; if both the task's fpsimd_cpu field
> @@ -155,6 +156,56 @@ extern void __percpu *efi_sve_state;
>  
>  #endif /* ! CONFIG_ARM64_SVE */
>  
> +DEFINE_PER_CPU(bool, fpsimd_context_busy);
> +EXPORT_PER_CPU_SYMBOL(fpsimd_context_busy);
> +
> +static void __get_cpu_fpsimd_context(void)
> +{
> +	bool busy = __this_cpu_xchg(fpsimd_context_busy, true);
> +
> +	WARN_ON(busy);
> +}
> +
> +/*
> + * Claim ownership of the CPU FPSIMD context for use by the calling context.
> + *
> + * The caller may freely modify FPSIMD context until *put_cpu_fpsimd_context()
> + * is called.

Nit: it may be better to say "freely manipulate the FPSIMD context
metadata".

get_cpu_fpsimd_context() isn't enough to allow the FPSIMD regs to be
safely trashed, because they may still contain live data (or an up to
date copy) for some task.

(For that you also need fpsimd_save_and_flush_cpu_state(), or just use
kernel_neon_begin() instead.)

[...]

> @@ -922,6 +971,8 @@ void fpsimd_thread_switch(struct task_struct *next)
>  	if (!system_supports_fpsimd())
>  		return;
>  
> +	__get_cpu_fpsimd_context();
> +
>  	/* Save unsaved fpsimd state, if any: */
>  	fpsimd_save();
>  
> @@ -936,6 +987,8 @@ void fpsimd_thread_switch(struct task_struct *next)
>  
>  	update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
>  			       wrong_task || wrong_cpu);
> +
> +	__put_cpu_fpsimd_context();

There should be a note in the commit message explaining why these are
here.

Are they actually needed, other than to keep
WARN_ON(have_cpu_fpsimd_context()) happy elsewhere?

Does PREEMPT_RT allow non-threaded softirqs to execute while we're in
this code?


OTOH, if the overall effect on performance remains positive, we can
probably argue that these operations make the code more self-describing
and help guard against mistakes during future maintanence, even if
they're not strictly needed today.

[...]

> -/*
> - * Save the FPSIMD state to memory and invalidate cpu view.
> - * This function must be called with softirqs (and preemption) disabled.
> - */
> +/* Save the FPSIMD state to memory and invalidate cpu view. */
>  void fpsimd_save_and_flush_cpu_state(void)
>  {
> +	get_cpu_fpsimd_context();
>  	fpsimd_save();
>  	fpsimd_flush_cpu_state();
> +	put_cpu_fpsimd_context();
>  }

Again, are these added just to keep WARN_ON()s happy?

Now I look at the diff, I think after all that

	WARN_ON(preemptible());
	__get_cpu_fpsimd_context();

	...

	__put_cpu_fpsimd_context();

is preferable.  The purpose of this function is to free up the FPSIMD
regs for use by the kernel, so it makes no sense to call it with
preemption enabled: the regs could spontaneously become live again due
to a context switch.  So we shouldn't encourage misuse by making the
function "safe" to call with preemption enabled.

(In fact, this starts to look so much like kernel_neon_begin() that we
could perhaps merge the two together -- but let's not bother for now.
That will make noise due to renaming, so it's best to leave it for a
future patch.)

[...]

Also, have you tested this patch with CONFIG_KERNEL_MODE_NEON=n?

Otherwise, this looks like it's almost there.

Cheers
---Dave
