Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E812C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F1221773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfC2FzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:55:00 -0400
Received: from foss.arm.com ([217.140.101.70]:54874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfC2FzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 01:55:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE26A78;
        Thu, 28 Mar 2019 22:54:59 -0700 (PDT)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C23B33F575;
        Thu, 28 Mar 2019 22:54:55 -0700 (PDT)
Subject: Re: [PATCH v7 7/10] KVM: arm/arm64: context-switch ptrauth registers
To:     James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <1552984243-7689-1-git-send-email-amit.kachhap@arm.com>
 <1552984243-7689-8-git-send-email-amit.kachhap@arm.com>
 <9d929db6-2a24-b356-6c76-8f58341db4bc@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <6208fe17-5a75-92d6-a27d-32a63f5e3bfd@arm.com>
Date:   Fri, 29 Mar 2019 11:24:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9d929db6-2a24-b356-6c76-8f58341db4bc@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/29/19 12:21 AM, James Morse wrote:
> Hi Amit,
> 
> On 19/03/2019 08:30, Amit Daniel Kachhap wrote:
>> From: Mark Rutland <mark.rutland@arm.com>
>>
>> When pointer authentication is supported, a guest may wish to use it.
>> This patch adds the necessary KVM infrastructure for this to work, with
>> a semi-lazy context switch of the pointer auth state.
>>
>> Pointer authentication feature is only enabled when VHE is built
>> in the kernel and present in the CPU implementation so only VHE code
>> paths are modified.
>>
>> When we schedule a vcpu, we disable guest usage of pointer
>> authentication instructions and accesses to the keys. While these are
>> disabled, we avoid context-switching the keys. When we trap the guest
>> trying to use pointer authentication functionality, we change to eagerly
>> context-switching the keys, and enable the feature. The next time the
>> vcpu is scheduled out/in, we start again. However the host key save is
>> optimized and implemented inside ptrauth instruction/register access
>> trap.
>>
>> Pointer authentication consists of address authentication and generic
>> authentication, and CPUs in a system might have varied support for
>> either. Where support for either feature is not uniform, it is hidden
>> from guests via ID register emulation, as a result of the cpufeature
>> framework in the host.
>>
>> Unfortunately, address authentication and generic authentication cannot
>> be trapped separately, as the architecture provides a single EL2 trap
>> covering both. If we wish to expose one without the other, we cannot
>> prevent a (badly-written) guest from intermittently using a feature
>> which is not uniformly supported (when scheduled on a physical CPU which
>> supports the relevant feature). Hence, this patch expects both type of
>> authentication to be present in a cpu.
>>
>> This switch of key is done from guest enter/exit assembly as preperation
>> for the upcoming in-kernel pointer authentication support. Hence, these
>> key switching routines are not implemented in C code as they may cause
>> pointer authentication key signing error in some situations.
> 
> 
>> diff --git a/arch/arm64/include/asm/kvm_ptrauth_asm.h b/arch/arm64/include/asm/kvm_ptrauth_asm.h
>> new file mode 100644
>> index 0000000..97bb040
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/kvm_ptrauth_asm.h
> 
>> +.macro	ptrauth_save_state base, reg1, reg2
>> +	mrs_s	\reg1, SYS_APIAKEYLO_EL1
>> +	mrs_s	\reg2, SYS_APIAKEYHI_EL1
>> +	stp	\reg1, \reg2, [\base, #PTRAUTH_REG_OFFSET(CPU_APIAKEYLO_EL1)]
> 
> A nice-to-have:
> Because you only use the 'LO' asm-offset definitions here, we have to just assume that the
> 'HI' ones are adjacent. Is it possible to add a BUILD_BUG() somewhere (probably in
> asm-offsets.c) to check this? As its just an enum we'd expect the order to be arbitrary,
> and asm-offsets to take care of any re-ordering... (struct randomisation may one day come
> to enums!)
Yes, seems this logic will fail with enum randomization. Adding any BUG 
in asm-offsets.c is not picked by the build system. I guess another 
approach would be to disable randomization for each key and define the 
enums as like below,
      enum vcpu_sysreg {
      ...
      APIAKEYLO_EL1,
      APIAKEYHI_EL1 = APIAKEYLO_EL1 + 1,
      APIBKEYLO_EL1,
      APIBKEYHI_EL1 = APIBKEYLO_EL1 + 1,
      ...
      }
This should be fine as each key size is 128 bit so LOW/HI key is placed 
together to access it as a unit.
> 
> 
>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index e2f0268..9f591ad 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c
>> @@ -544,3 +544,17 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
>>   
>>   	return ret;
>>   }
>> +
>> +/**
>> + * kvm_arm_vcpu_ptrauth_setup_lazy - setup lazy ptrauth for vcpu schedule
>> + *
>> + * @vcpu: The VCPU pointer
>> + *
>> + * This function may be used to disable ptrauth and use it in a lazy context
>> + * via traps.
>> + */
>> +void kvm_arm_vcpu_ptrauth_setup_lazy(struct kvm_vcpu *vcpu)
>> +{
>> +	if (vcpu_has_ptrauth(vcpu))
>> +		kvm_arm_vcpu_ptrauth_disable(vcpu);
>> +}
> 
> Can you check my reasoning here, to make sure I've understood this properly?!:
> 
> This clears the API/APK bits to enable the traps, if the system supports ptrauth, and if
> Qemu requested it for this vcpu. If any of those things aren't true, the guest gets
> HCR_GUEST_FLAGS, which also has the API/APK bits clear...
> 
> What this is doing is clearing the API/APK bits that may have been left set by a previous
> run of a ptrauth-enabled vcpu.
Yes your description looks fine. Mark mentioned the benefit of this 
approach in earlier thread [1].

[1]: 
https://lore.kernel.org/lkml/20180309142838.uvcv3mhvqqlprktt@lakrids.cambridge.arm.com/
> 
> 
> 
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index f16a5f8..00f0639 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -128,6 +128,13 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>   	if (loaded)
>>   		kvm_arch_vcpu_put(vcpu);
>>
>> +	if (test_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, vcpu->arch.features) ||
>> +		test_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, vcpu->arch.features)) {
>> +		/* Verify that KVM startup matches the conditions for ptrauth */
>> +		if (WARN_ON(!vcpu_has_ptrauth(vcpu)))
>> +			return -EINVAL;
>> +	}
> 
> Could this hunk go in the previous patch that added the vcpu definitions?
> It would be good if the uapi defines, the documentation and this validation logic came as
> one patch, it makes future archaeology easier!
ok it makes sense. I will update it in the next patch series.

Thanks,
Amit Daniel
> 
> 
> Looks good!
> 
> Thanks,
> 
> James
> 
