Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BED5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FFE20828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfCZEEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 00:04:05 -0400
Received: from foss.arm.com ([217.140.101.70]:58914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfCZEEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 00:04:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DC8880D;
        Mon, 25 Mar 2019 21:04:04 -0700 (PDT)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA45A3F59C;
        Mon, 25 Mar 2019 21:04:00 -0700 (PDT)
Subject: Re: [PATCH v7 7/10] KVM: arm/arm64: context-switch ptrauth registers
To:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <1552984243-7689-1-git-send-email-amit.kachhap@arm.com>
 <1552984243-7689-8-git-send-email-amit.kachhap@arm.com>
 <64505666-8a1f-cf64-7067-4b2dd53b0b40@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <da7091a9-01b2-bead-3777-972fbb293def@arm.com>
Date:   Tue, 26 Mar 2019 09:33:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <64505666-8a1f-cf64-7067-4b2dd53b0b40@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/26/19 1:34 AM, Kristina Martsenko wrote:
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
>>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> [Only VHE, key switch in full assembly, vcpu_has_ptrauth checks
>> , save host key in ptrauth exception trap]
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: kvmarm@lists.cs.columbia.edu
> 
> [...]
> 
>> +/* SPDX-License-Identifier: GPL-2.0
>> + * arch/arm64/include/asm/kvm_ptrauth_asm.h: Guest/host ptrauth save/restore
>> + * Copyright 2019 Arm Limited
>> + * Author: Mark Rutland <mark.rutland@arm.com>
>> + *         Amit Daniel Kachhap <amit.kachhap@arm.com>
>> + */
> 
> I think the license needs to be in its own comment, like
> 
> /* SPDX-License-Identifier: GPL-2.0 */
yes this is indeed the format followed.
> /* arch/arm64/include/asm/kvm_ptrauth_asm.h: ...
>   * ...
>   */
> 
>> +
>> +#ifndef __ASM_KVM_ASM_PTRAUTH_H
>> +#define __ASM_KVM_ASM_PTRAUTH_H
> 
> __ASM_KVM_PTRAUTH_ASM_H ? (to match the file name)
> 
>> +	if (test_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, vcpu->arch.features) ||
>> +		test_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, vcpu->arch.features)) {
>> +		/* Verify that KVM startup matches the conditions for ptrauth */
>> +		if (WARN_ON(!vcpu_has_ptrauth(vcpu)))
>> +			return -EINVAL;
>> +	}
> 
> I think this now needs to have "goto out;" instead of "return -EINVAL;",
> since 5.1-rcX contains commit e761a927bc9a ("KVM: arm/arm64: Reset the
> VCPU without preemption and vcpu state loaded") which changed some of
> this code.
ok missed the changes for this commit.
> 
>> @@ -385,6 +385,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>>   		vcpu_clear_wfe_traps(vcpu);
>>   	else
>>   		vcpu_set_wfe_traps(vcpu);
>> +
>> +	kvm_arm_vcpu_ptrauth_setup_lazy(vcpu);
> 
> This version of the series seems to have lost the arch/arm/ definition
> of kvm_arm_vcpu_ptrauth_setup_lazy (previously
> kvm_arm_vcpu_ptrauth_reset), so KVM no longer compiles for arch/arm/ :(

ok my bad.

Thanks,
Amit D
> 
> Thanks,
> Kristina
> 
