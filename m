Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FE3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A821A2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfDWK7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:59:49 -0400
Received: from foss.arm.com ([217.140.101.70]:54356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfDWK7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:59:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 927E5374;
        Tue, 23 Apr 2019 03:59:48 -0700 (PDT)
Received: from [10.37.8.239] (unknown [10.37.8.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C0A53F557;
        Tue, 23 Apr 2019 03:59:46 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     julien.thierry@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org
References: <20190412171420.29065-1-julien.grall@arm.com>
 <20190412171420.29065-4-julien.grall@arm.com>
 <20190416123033.GM3567@e103592.cambridge.arm.com>
 <901b1c73-4f96-b493-cdc7-bc2f6bd2d7ca@arm.com>
 <20190417140058.GZ3567@e103592.cambridge.arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <80c6b8cd-5ea9-7fa3-7a3b-8b3af686f737@arm.com>
Date:   Tue, 23 Apr 2019 11:59:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417140058.GZ3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 4/17/19 3:01 PM, Dave Martin wrote:
> On Wed, Apr 17, 2019 at 12:37:57PM +0100, Julien Grall wrote:
>> Hi Dave,
>>
>> On 16/04/2019 13:30, Dave Martin wrote:
>>> On Fri, Apr 12, 2019 at 06:14:20PM +0100, Julien Grall wrote:
> 
> [...]
> 
>>>> +
>>>> +/*
>>>> + * Obtain the CPU FPSIMD context for use by the calling context.
> 
> If we say something like "Claim ownership of the CPU FPSIMD context for
> use by the calling context", this may be easier to reference elsewhere
> (see below).
> 
>>>> + *
>>>> + * The caller may freely modify FPSIMD context until *put_cpu_fpsimd_context()
>>>
>>> Nit: Why *?  This makes it look a bit like get_cpu_fpsimd_context()
>>> returns a pointer and you're saying something about dereferencing that
>>> pointer here.
>>
>> I tend to use * for wildcard. In this context it used to refers to both the
>> double-underscored version and the one without.
> 
> Ah, right.  * makes sense in general, but here it confused me.
> 
>> I can use {,__}put_cpu_fpsimd_context() instead.
> 
> Maybe, but the caller is not supposed to pair get_cpu_fpsimd_context()
> with __put_cpu_fpsimd_context().
> 
> What if we just comment the non-underscore versions.  The purpose of
> the __ versions is then relatively obvious without additional commenting.

I am happy with this solution as well.

[...]

> 
>>>
>>>> +	{
>>>> +		printk("preemptible() = %u kernel_neon_busy = %u\n",
>>>> +		       preemptible(), __this_cpu_read(kernel_neon_busy));
>>>> +		while (1);
>>>> +	}
>>>>   	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
>>>>   		if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
>>>> @@ -352,7 +413,8 @@ static int __init sve_sysctl_init(void) { return 0; }
>>>>    * task->thread.sve_state.
>>>>    *
>>>>    * Task can be a non-runnable task, or current.  In the latter case,
>>>> - * softirqs (and preemption) must be disabled.
>>>> + * the FPSIMD context must be acquired with get_fpu_fpsimd_context()
>>>> + * before calling this function.
>>
>> I noticed you didn't comment about the usage of get_cpu_fpsimd_context here.
>> Do you want to add a WARN(..) in the function, or just using {,___} here?
> 
> Partly because of things getting repetitive.
> 
> WARN() is not free, so I suggest we don't add any new ones for now.
> 
>  From a comment point of view, if we just say something "the caller must
> have ownership of the cpu FPSIMD context" to refer back to the
> commenting for get_cpu_fpsimd_context(), that should cover the general
> case.

I am fine with this suggestion.

>>
>>>>    * task->thread.sve_state must point to at least sve_state_size(task)
>>>>    * bytes of allocated kernel memory.
>>>>    * task->thread.uw.fpsimd_state must be up to date before calling this
>>>> @@ -379,7 +441,8 @@ static void fpsimd_to_sve(struct task_struct *task)
>>>>    * task->thread.uw.fpsimd_state.
>>>>    *
>>>>    * Task can be a non-runnable task, or current.  In the latter case,
>>>> - * softirqs (and preemption) must be disabled.
>>>> + * the FPSIMD context must be acquired with get_fpu_fpsimd_context()
>>>> + * before calling this function.
>>
>> Same question here.
>>
>> [...]
>>
>>>> @@ -1012,7 +1079,8 @@ void fpsimd_signal_preserve_current_state(void)
>>>>   /*
>>>>    * Associate current's FPSIMD context with this cpu
>>>> - * Preemption must be disabled when calling this function.
>>>> + * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
>>>> + * before calling this function.
>>
>> Same question here.
> 
> Same for these.
> 
>>>>   /*
>>>>    * Invalidate any task's FPSIMD state that is present on this cpu.
>>>> - * This function must be called with softirqs disabled.
>>>> + * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
>>>> + * before calling this function.
>>>>    */
>>>>   static void fpsimd_flush_cpu_state(void)
>>>>   {
>>>> @@ -1125,19 +1194,18 @@ static void fpsimd_flush_cpu_state(void)
>>>>   /*
>>>>    * Save the FPSIMD state to memory and invalidate cpu view.
>>>> - * This function must be called with softirqs (and preemption) disabled.
>>>> + * This function must be called with preemption disabled.
>>>>    */
>>>>   void fpsimd_save_and_flush_cpu_state(void)
>>>>   {
>>>> +	__get_cpu_fpsimd_context();
>>>>   	fpsimd_save();
>>>>   	fpsimd_flush_cpu_state();
>>>> +	__put_cpu_fpsimd_context();
>>>
>>> It may be cleaner to avoid the assumption about preemption already being
>>> disabled here.  fpsimd_thread_switch() is rather a special case, but for
>>> this one is this really used on a hot path that justifies the assumption?
>>
>> It is currently only called with preemption disabled. So I thought it would
>> be better to avoid disabling preemption again. But I am happy to use the
>> non-__ version if you think it is better.
> 
> Hmmm, this works either way.  Since this is not fast-path and has an
> external caller, it might be worth adding a WARN_ON(preemptible()) here
> if you want to stick with the __ functions.

As it is not a fastpath, I will use the non-underscore version.

Cheers,

-- 
Julien Grall
