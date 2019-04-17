Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC4CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBCE20656
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfDQLiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:38:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43436 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729578AbfDQLiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:38:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26CB5374;
        Wed, 17 Apr 2019 04:38:01 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 343383F68F;
        Wed, 17 Apr 2019 04:37:59 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ard.biesheuvel@linaro.org, julien.thierry@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com
References: <20190412171420.29065-1-julien.grall@arm.com>
 <20190412171420.29065-4-julien.grall@arm.com>
 <20190416123033.GM3567@e103592.cambridge.arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <901b1c73-4f96-b493-cdc7-bc2f6bd2d7ca@arm.com>
Date:   Wed, 17 Apr 2019 12:37:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416123033.GM3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 16/04/2019 13:30, Dave Martin wrote:
> On Fri, Apr 12, 2019 at 06:14:20PM +0100, Julien Grall wrote:
>> When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
>> the kernel may be able to use FPSIMD/SVE. This is for instance the case
>> for crypto code.
>>
>> Any use of FPSIMD/SVE in the kernel are clearly marked by using the
>> function kernel_neon_{begin, end}. Furthermore, this can only be used
>> when may_use_simd() returns true.
>>
>> The current implementation of may_use_simd() allows softirq to use
>> FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
> 
> Nit: "in used" -> "in use"
> 
>> When in used, softirqs usually fallback to a software method.
> 
> Likewise.
> 
> Nit: "fallback" -> "fall back"
> 
>> At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
>> when touching the FPSIMD/SVE context. This has the drawback to disable
>> all softirqs even if they are not using FPSIMD/SVE.
>>
>> As a softirq should not rely on been able to use simd at a given time,
>> there are limited reason to keep softirq disabled when touching the
> 
> The implication is not totally clear to me here.  Maybe write something
> like
> 
> "Since a softirq is supposed to check may_use_simd() anyway before
> attempting to use FPSIMD/SVE, there is limited reason to keep softirq
> disabled when touching the FPSIMD/SVE context [...]"

I will update the commit message.

> 
>> FPSIMD/SVE context. Instead, we can only disable preemption and tell
> 
> I'd put "just" or "simply" instead of "only" here.
> 
>> the NEON unit is currently in use.
> 
> Maybe "mark the FPSIMD/SVE context as in use by setting the
> CPU's kernel_neon_busy flag".

Sounds better as this flag does not protect only the hardware but some part of 
context that resides in memory.

> 
>> This patch introduces two new helpers {get, put}_cpu_fpsimd_context to
>> mark the area using FPSIMD/SVE context and use them in replacement of
> 
> uses
> 
>> local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
>> also re-implemented to use the new helpers.
>>
>> Additionally, this patch introduced a double-underscored version of each
> 
> introduces
> 
>> helper that can be used when preemption is disabled. This avoid to
>> disable/enable preemption for again and helps documenting places where
> 
> The wording seems a bit mangled here?  

Oops yes.

> Also, these are not for general use, so maybe say something like
> 
> "For use in the fpsimd_thread_switch(), which is a critical path where
> preemption is already disabled, double-underscored versions of the
> helpers are provided to avoid disabling preemption again."
> 
> (I'm assuming here that we don't need to use these elsewhere -- see
> other comments.)

I will comment on this below.

> 
>> context can only be used by one instance.
>>
>> This patch has been benchmarked on Linux 5.1-rc4 with defconfig.
>>
>> On Juno2:
>>      * hackbench 100 process 1000 (10 times)
>>      * .7% quicker
>>
>> On ThunderX 2:
>>      * hackbench 1000 process 1000 (20 times)
>>      * 3.4% quicker
>>
>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>
>> ---
>>      Changes in v2:
>>          - Remove spurious call to kernel_neon_enable in kernel_neon_begin.
>>          - Rename kernel_neon_{enable, disable} to {get, put}_cpu_fpsimd_context
>>          - Introduce a double-underscore version of the helpers for case
>>          where preemption is already disabled
>>          - Introduce have_cpu_fpsimd_context() and use it in WARN_ON(...)
>>          - Surround more places in the code with the new helpers
>>          - Rework the comments
>>          - Update the commit message with the benchmark result
>> ---
>>   arch/arm64/include/asm/simd.h |   4 +-
>>   arch/arm64/kernel/fpsimd.c    | 133 ++++++++++++++++++++++++++++++------------
>>   2 files changed, 97 insertions(+), 40 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
>> index 6495cc51246f..94c0dac508aa 100644
>> --- a/arch/arm64/include/asm/simd.h
>> +++ b/arch/arm64/include/asm/simd.h
>> @@ -15,10 +15,10 @@
>>   #include <linux/preempt.h>
>>   #include <linux/types.h>
>>   
>> -#ifdef CONFIG_KERNEL_MODE_NEON
>> -
>>   DECLARE_PER_CPU(bool, kernel_neon_busy);
>>   
>> +#ifdef CONFIG_KERNEL_MODE_NEON
>> +
>>   /*
>>    * may_use_simd - whether it is allowable at this time to issue SIMD
>>    *                instructions or access the SIMD register file
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 9e4e4b6acd93..761d848fb26d 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -92,7 +92,8 @@
>>    * To prevent this from racing with the manipulation of the task's FPSIMD state
>>    * from task context and thereby corrupting the state, it is necessary to
>>    * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
>> - * flag with local_bh_disable() unless softirqs are already masked.
>> + * flag with kernel_neon_{disable, enable}. This will still allow softirqs to
> 
> These names don't match the code now.
> 
>> + * run but prevent them to use FPSIMD.
>>    *
>>    * For a certain task, the sequence may look something like this:
>>    * - the task gets scheduled in; if both the task's fpsimd_cpu field
>> @@ -150,6 +151,58 @@ extern void __percpu *efi_sve_state;
>>   
>>   #endif /* ! CONFIG_ARM64_SVE */
>>   
>> +DEFINE_PER_CPU(bool, kernel_neon_busy);
>> +EXPORT_PER_CPU_SYMBOL(kernel_neon_busy);
> 
> This feels mis-named now.  Maybe "fpsimd_context_busy" would be a better
> name?

Make sense. I will update it.

> 
>> +
>> +/*
>> + * Obtain the CPU FPSIMD context for use by the calling context.
>> + *
>> + * The caller may freely modify FPSIMD context until *put_cpu_fpsimd_context()
> 
> Nit: Why *?  This makes it look a bit like get_cpu_fpsimd_context()
> returns a pointer and you're saying something about dereferencing that
> pointer here.

I tend to use * for wildcard. In this context it used to refers to both the 
double-underscored version and the one without.

I can use {,__}put_cpu_fpsimd_context() instead.

> 
>> + * is called.
>> + *
>> + * The double-underscore version must only be called if you know the task
>> + * can't be preempted.
>> + *
>> + * __get_cpu_fpsimd_context() *must* be in pair with __put_cpu_fpsimd_context()
>> + * get_cpu_fpsimd_context() *must* be in pair with put_cpu_fpsimd_context()
> 
> "in pair" -> "paired with"?

Sure.

> 
> I'd move each of these comments to be next to the function it applies
> to.

Do you mean on top of {,__}put_cpu_ or {,__}get_cpu?

> 
>> + */
>> +static void __get_cpu_fpsimd_context(void)
>> +{
>> +	bool busy = __this_cpu_xchg(kernel_neon_busy, true);
>> +
> 
> I don't mind whether there is a blank line here or not, but please make
> it consistent with __put_cpu_fpsimd_context().

I will modify __put_cpu_fpsimd_context() to add a newline.

> 
>> +	WARN_ON(busy);
>> +}
>> +
>> +static void get_cpu_fpsimd_context(void)
>> +{
>> +	preempt_disable();
>> +	__get_cpu_fpsimd_context();
>> +}
>> +
>> +/*
>> + * Release the CPU FPSIMD context.
>> + *
>> + * Must be called from a context in which *get_cpu_fpsimd_context() was
> 
> Nit: Why *?

Same as above, I can update to use {,__} instead of *.

> 
>> + * previously called, with no call to *put_cpu_fpsimd_context() in the
>> + * meantime.
>> + */
>> +static void __put_cpu_fpsimd_context(void)
>> +{
>> +	bool busy = __this_cpu_xchg(kernel_neon_busy, false);
>> +	WARN_ON(!busy); /* No matching get_cpu_fpsimd_context()? */
>> +}
>> +
>> +static void put_cpu_fpsimd_context(void)
>> +{
>> +	__put_cpu_fpsimd_context();
>> +	preempt_enable();
>> +}
>> +
>> +static bool have_cpu_fpsimd_context(void)
>> +{
>> +	return (!preemptible() && __this_cpu_read(kernel_neon_busy));
> 
> Nit: Redundant ()
> 
>> +}
>> +
>>   /*
>>    * Call __sve_free() directly only if you know task can't be scheduled
>>    * or preempted.
>> @@ -221,11 +274,12 @@ static void sve_free(struct task_struct *task)
>>    * thread_struct is known to be up to date, when preparing to enter
>>    * userspace.
>>    *
>> - * Softirqs (and preemption) must be disabled.
>> + * The FPSIMD context must be acquired with get_cpu_fpsimd_context()
> 
> or __get_cpu_fpsimd_context()?  Since this is effectively documented by
> the WARN_ON() and this is a local function anyway, maybe it would be
> simpler just to drop this comment here?

I am fine with that.

> 
>> + * before calling this function.
>>    */
>>   static void task_fpsimd_load(void)
>>   {
>> -	WARN_ON(!in_softirq() && !irqs_disabled());
>> +	WARN_ON(!have_cpu_fpsimd_context());
>>   
>>   	if (system_supports_sve() && test_thread_flag(TIF_SVE))
>>   		sve_load_state(sve_pffr(&current->thread),
>> @@ -239,15 +293,22 @@ static void task_fpsimd_load(void)
>>    * Ensure FPSIMD/SVE storage in memory for the loaded context is up to
>>    * date with respect to the CPU registers.
>>    *
>> - * Softirqs (and preemption) must be disabled.
>> + * The FPSIMD context must be acquired with get_cpu_fpsimd_context()
> 
> Likewise.

Ditto.

> 
>> + * before calling this function.
>>    */
>>   static void fpsimd_save(void)
>>   {
>>   	struct fpsimd_last_state_struct const *last =
>>   		this_cpu_ptr(&fpsimd_last_state);
>>   	/* set by fpsimd_bind_task_to_cpu() or fpsimd_bind_state_to_cpu() */
>> +	WARN_ON(!have_cpu_fpsimd_context());
>>   
>> -	WARN_ON(!in_softirq() && !irqs_disabled());
>> +	if ( !have_cpu_fpsimd_context() )
> 
> Nit: Redundant whitespace around expression.

This hunk should actually be dropped. I was using for debugging and forgot to 
remove it before sending the series :/.

> 
>> +	{
>> +		printk("preemptible() = %u kernel_neon_busy = %u\n",
>> +		       preemptible(), __this_cpu_read(kernel_neon_busy));
>> +		while (1);
>> +	}
>>   
>>   	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
>>   		if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
>> @@ -352,7 +413,8 @@ static int __init sve_sysctl_init(void) { return 0; }
>>    * task->thread.sve_state.
>>    *
>>    * Task can be a non-runnable task, or current.  In the latter case,
>> - * softirqs (and preemption) must be disabled.
>> + * the FPSIMD context must be acquired with get_fpu_fpsimd_context()
>> + * before calling this function.

I noticed you didn't comment about the usage of get_cpu_fpsimd_context here. Do 
you want to add a WARN(..) in the function, or just using {,___} here?

>>    * task->thread.sve_state must point to at least sve_state_size(task)
>>    * bytes of allocated kernel memory.
>>    * task->thread.uw.fpsimd_state must be up to date before calling this
>> @@ -379,7 +441,8 @@ static void fpsimd_to_sve(struct task_struct *task)
>>    * task->thread.uw.fpsimd_state.
>>    *
>>    * Task can be a non-runnable task, or current.  In the latter case,
>> - * softirqs (and preemption) must be disabled.
>> + * the FPSIMD context must be acquired with get_fpu_fpsimd_context()
>> + * before calling this function.

Same question here.

[...]

>> @@ -1012,7 +1079,8 @@ void fpsimd_signal_preserve_current_state(void)
>>   
>>   /*
>>    * Associate current's FPSIMD context with this cpu
>> - * Preemption must be disabled when calling this function.
>> + * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
>> + * before calling this function.

Same question here.

>>   /*
>>    * Invalidate any task's FPSIMD state that is present on this cpu.
>> - * This function must be called with softirqs disabled.
>> + * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
>> + * before calling this function.
>>    */
>>   static void fpsimd_flush_cpu_state(void)
>>   {
>> @@ -1125,19 +1194,18 @@ static void fpsimd_flush_cpu_state(void)
>>   
>>   /*
>>    * Save the FPSIMD state to memory and invalidate cpu view.
>> - * This function must be called with softirqs (and preemption) disabled.
>> + * This function must be called with preemption disabled.
>>    */
>>   void fpsimd_save_and_flush_cpu_state(void)
>>   {
>> +	__get_cpu_fpsimd_context();
>>   	fpsimd_save();
>>   	fpsimd_flush_cpu_state();
>> +	__put_cpu_fpsimd_context();
> 
> It may be cleaner to avoid the assumption about preemption already being
> disabled here.  fpsimd_thread_switch() is rather a special case, but for
> this one is this really used on a hot path that justifies the assumption?

It is currently only called with preemption disabled. So I thought it would be 
better to avoid disabling preemption again. But I am happy to use the non-__ 
version if you think it is better.

Cheers,

-- 
Julien Grall
