Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87593C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5809B2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfDPMHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:07:45 -0400
Received: from foss.arm.com ([217.140.101.70]:53726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfDPMHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:07:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BBDCEBD;
        Tue, 16 Apr 2019 05:07:44 -0700 (PDT)
Received: from [10.37.12.51] (unknown [10.37.12.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22F9F3F706;
        Tue, 16 Apr 2019 05:07:40 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] arch/arm64: fpsimd: Introduce
 fpsimd_save_and_flush_cpu_state() and use it
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ard.biesheuvel@linaro.org, julien.thierry@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com
References: <20190412171420.29065-1-julien.grall@arm.com>
 <20190412171420.29065-3-julien.grall@arm.com>
 <20190416115305.GL3567@e103592.cambridge.arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <025e0596-c28d-7289-e691-5571fef0113a@arm.com>
Date:   Tue, 16 Apr 2019 13:07:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416115305.GL3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 4/16/19 12:53 PM, Dave Martin wrote:
> On Fri, Apr 12, 2019 at 06:14:19PM +0100, Julien Grall wrote:
>> The only external user of fpsimd_save() and fpsimd_flush_cpu_state() is
>> the KVM FPSIMD code.
>>
>> A follow-up patch will mandate hold of the FPSIMD context while
> 
> This is a bit hard to read without understanding the following patch.
> 
> Maybe elaborate a bit with something like
> 
> "The following patch will introduce a mechanism to acquire ownership of the FPSIMD/SVE context for performing context management operations. Rather than having to export this [...]"

I will update the commit message with your suggestion.

> 
>> modifying it. Rather than having to export the new helpers to get/put
>> the context, we can just introduce a new function to combine
>> fpsimd_save() and fpsimd_flush_cpu_state().
>>
>> This has also the advantage to remove any external call of fpsimd_save()
>> and fpsimd_flush_cpu_state(), so they can be turned static.
>>
>> Lastly, the new function can also be used in the PM notifier.
>>
>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>
>> ---
>>      Changes in v2:
>>          - Patch added
>> ---
>>   arch/arm64/include/asm/fpsimd.h |  5 ++---
>>   arch/arm64/kernel/fpsimd.c      | 17 +++++++++++++----
>>   arch/arm64/kvm/fpsimd.c         |  3 +--
>>   3 files changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
>> index 32abbfd852e8..88c223f6ded6 100644
>> --- a/arch/arm64/include/asm/fpsimd.h
>> +++ b/arch/arm64/include/asm/fpsimd.h
>> @@ -48,11 +48,11 @@ struct task_struct;
>>   extern void fpsimd_save_state(struct user_fpsimd_state *state);
>>   extern void fpsimd_load_state(struct user_fpsimd_state *state);
>>   
>> -extern void fpsimd_save(void);
>> -
>>   extern void fpsimd_thread_switch(struct task_struct *next);
>>   extern void fpsimd_flush_thread(void);
>>   
>> +extern void fpsimd_save_and_flush_cpu_state(void);
>> +
> 
> Nit, bit I think this makes more sense alongside the other flush
> functions.
> 
> Can you just drop this new declaration in place of the old declaration
> for sve_flush_cpu_state()?

Sure, I will do it in the next version.

> 
>>   extern void fpsimd_signal_preserve_current_state(void);
>>   extern void fpsimd_preserve_current_state(void);
>>   extern void fpsimd_restore_current_state(void);
>> @@ -63,7 +63,6 @@ extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
>>   				     void *sve_state, unsigned int sve_vl);
>>   
>>   extern void fpsimd_flush_task_state(struct task_struct *target);
>> -extern void fpsimd_flush_cpu_state(void);
>>   
>>   /* Maximum VL that SVE VL-agnostic software can transparently support */
>>   #define SVE_VL_ARCH_MAX 0x100
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 577296bba730..9e4e4b6acd93 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -241,7 +241,7 @@ static void task_fpsimd_load(void)
>>    *
>>    * Softirqs (and preemption) must be disabled.
>>    */
>> -void fpsimd_save(void)
>> +static void fpsimd_save(void)
>>   {
>>   	struct fpsimd_last_state_struct const *last =
>>   		this_cpu_ptr(&fpsimd_last_state);
>> @@ -1117,12 +1117,22 @@ void fpsimd_flush_task_state(struct task_struct *t)
>>    * Invalidate any task's FPSIMD state that is present on this cpu.
>>    * This function must be called with softirqs disabled.
>>    */
>> -void fpsimd_flush_cpu_state(void)
>> +static void fpsimd_flush_cpu_state(void)
>>   {
>>   	__this_cpu_write(fpsimd_last_state.st, NULL);
>>   	set_thread_flag(TIF_FOREIGN_FPSTATE);
>>   }
>>   
>> +/*
>> + * Save the FPSIMD state to memory and invalidate cpu view.
>> + * This function must be called with softirqs (and preemption) disabled.
>> + */
>> +void fpsimd_save_and_flush_cpu_state(void)
>> +{
>> +	fpsimd_save();
>> +	fpsimd_flush_cpu_state();
>> +}
>> +
>>   #ifdef CONFIG_KERNEL_MODE_NEON
>>   
>>   DEFINE_PER_CPU(bool, kernel_neon_busy);
>> @@ -1279,8 +1289,7 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>>   {
>>   	switch (cmd) {
>>   	case CPU_PM_ENTER:
>> -		fpsimd_save();
>> -		fpsimd_flush_cpu_state();
>> +		fpsimd_save_and_flush_cpu_state();
> 
> Any reason not to do this in kernel_neon_begin() too?

In the next patch, fpsimd_save_and_flush_cpu_state() will also call 
{get, put}_cpu_fpsimd_context(). So we avoid to expose the two new 
functions outside of the file.

I could introduce a double-underscore version of this function if you 
think it is worth it.

> 
>>   		break;
>>   	case CPU_PM_EXIT:
>>   		break;
>> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
>> index 6e3c9c8b2df9..01bd2e862506 100644
>> --- a/arch/arm64/kvm/fpsimd.c
>> +++ b/arch/arm64/kvm/fpsimd.c
>> @@ -113,8 +113,7 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
>>   		u64 *guest_zcr = &vcpu->arch.ctxt.sys_regs[ZCR_EL1];
>>   
>>   		/* Clean guest FP state to memory and invalidate cpu view */
> 
> You can lose the comment here, since the call is now self-explanatory.

Sure.

> 
>> -		fpsimd_save();
>> -		fpsimd_flush_cpu_state();
>> +		fpsimd_save_and_flush_cpu_state();
> 
> [...]
> 
> Otherwise, looks sensible.

Thank you for the review!

Cheers,

-- 
Julien Grall
