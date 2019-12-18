Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4D1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B22924650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfLRLmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:42:45 -0500
Received: from foss.arm.com ([217.140.110.172]:43226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfLRLmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:42:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32F1D30E;
        Wed, 18 Dec 2019 03:42:44 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8BA13F6CF;
        Wed, 18 Dec 2019 03:42:42 -0800 (PST)
Subject: Re: [PATCH v2 7/7] arm64: nofpsmid: Handle TIF_FOREIGN_FPSTATE flag
 cleanly
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, dave.martin@arm.com,
        catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        christoffer.dall@arm.com, Marc Zyngier <marc.zyngier@arm.com>
References: <20191217183402.2259904-1-suzuki.poulose@arm.com>
 <20191217183402.2259904-8-suzuki.poulose@arm.com>
 <94c0bdd9f26c3262ff8a885d13a64d22@www.loen.fr>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Message-ID: <9e491901-b589-b486-1cad-1bd92a35da95@arm.com>
Date:   Wed, 18 Dec 2019 11:42:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <94c0bdd9f26c3262ff8a885d13a64d22@www.loen.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 17/12/2019 19:05, Marc Zyngier wrote:
> Hi Suzuki,
> 
> On 2019-12-17 18:34, Suzuki K Poulose wrote:
>> We detect the absence of FP/SIMD after an incapable CPU is brought up,
>> and by then we have kernel threads running already with
>> TIF_FOREIGN_FPSTATE set
>> which could be set for early userspace applications (e.g, modprobe 
>> triggered
>> from initramfs) and init. This could cause the applications to loop
>> forever in
>> do_nofity_resume() as we never clear the TIF flag, once we now know that
>> we don't support FP.
>>
>> Fix this by making sure that we clear the TIF_FOREIGN_FPSTATE flag
>> for tasks which may have them set, as we would have done in the normal
>> case, but avoiding touching the hardware state (since we don't support 
>> any).
>>
>> Also to make sure we handle the cases seemlessly we categorise the
>> helper functions to two :
>>  1) Helpers for common core code, which calls into take appropriate
>>     actions without knowing the current FPSIMD state of the CPU/task.
>>
>>     e.g fpsimd_restore_current_state(), fpsimd_flush_task_state(),
>>         fpsimd_save_and_flush_cpu_state().
>>
>>     We bail out early for these functions, taking any appropriate actions
>>     (e.g, clearing the TIF flag) where necessary to hide the handling
>>     from core code.
>>
>>  2) Helpers used when the presence of FP/SIMD is apparent.
>>     i.e, save/restore the FP/SIMD register state, modify the CPU/task
>>     FP/SIMD state.
>>     e.g,
>>
>>     fpsimd_save(), task_fpsimd_load() - save/restore task FP/SIMD 
>> registers
>>
>>     fpsimd_bind_task_to_cpu()  \
>>                                 - Update the "state" metadata for 
>> CPU/task.
>>     fpsimd_bind_state_to_cpu() /
>>
>>     fpsimd_update_current_state() - Update the fp/simd state for the 
>> current
>>                                     task from memory.
>>
>>     These must not be called in the absence of FP/SIMD. Put in a WARNING
>>     to make sure they are not invoked in the absence of FP/SIMD.
>>
>> KVM also uses the TIF_FOREIGN_FPSTATE flag to manage the FP/SIMD state
>> on the CPU. However, without FP/SIMD support we trap all accesses and
>> inject undefined instruction. Thus we should never "load" guest state.
>> Add a sanity check to make sure this is valid.
> 
> Yes, but no, see below.
> 
>>
>> Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
> 
> No idea who that guy is. It's a fake! ;-)

Sorry about that, will fix it.

> 
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  arch/arm64/kernel/fpsimd.c  | 31 +++++++++++++++++++++++++++----
>>  arch/arm64/kvm/hyp/switch.c |  9 +++++++++
>>  2 files changed, 36 insertions(+), 4 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
>> index 72fbbd86eb5e..9696ebb5c13a 100644
>> --- a/arch/arm64/kvm/hyp/switch.c
>> +++ b/arch/arm64/kvm/hyp/switch.c
>> @@ -28,10 +28,19 @@
>>  /* Check whether the FP regs were dirtied while in the host-side run
>> loop: */
>>  static bool __hyp_text update_fp_enabled(struct kvm_vcpu *vcpu)
>>  {
>> +    /*
>> +     * When the system doesn't support FP/SIMD, we cannot rely on
>> +     * the state of _TIF_FOREIGN_FPSTATE. However, we will never
>> +     * set the KVM_ARM64_FP_ENABLED, as the FP/SIMD accesses always
>> +     * inject an abort into the guest. Thus we always trap the
>> +     * accesses.
>> +     */
>>      if (vcpu->arch.host_thread_info->flags & _TIF_FOREIGN_FPSTATE)
>>          vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
>>                        KVM_ARM64_FP_HOST);
>>
>> +    WARN_ON(!system_supports_fpsimd() &&
>> +        (vcpu->arch.flags & KVM_ARM64_FP_ENABLED));
> 
> Careful, this will panic the host if it happens on a !VHE host
> (calling non-inline stuff from a __hyp_text function is usually
> not a good idea).

Ouch! Sorry about that WARN_ON()! I could drop the warning and
make this :

	if (!system_supports_fpsimd() ||
	    (vcpu->arch.host_thread_info->flags & _TIF_FOREIGN_FPSTATE))
		vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
				      KVM_ARM64_FP_HOST);

to make sure we never say fp is enabled.

What do you think ?

Cheers
Suzuki
