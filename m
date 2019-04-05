Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AD8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FC4217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfDELBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:01:05 -0400
Received: from foss.arm.com ([217.140.101.70]:45944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730546AbfDELBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:01:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FA6A168F;
        Fri,  5 Apr 2019 04:01:04 -0700 (PDT)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DACD33F557;
        Fri,  5 Apr 2019 04:01:00 -0700 (PDT)
Subject: Re: [PATCH v8 7/9] KVM: arm/arm64: context-switch ptrauth registers
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
References: <1554172037-4516-1-git-send-email-amit.kachhap@arm.com>
 <1554172037-4516-8-git-send-email-amit.kachhap@arm.com>
 <efe4fd6b-7f1f-c8b7-0667-e2bf636dcf4f@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <4065308b-20ed-31ba-9fe9-f8a63531444e@arm.com>
Date:   Fri, 5 Apr 2019 16:30:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <efe4fd6b-7f1f-c8b7-0667-e2bf636dcf4f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kristina,

On 4/5/19 12:59 AM, Kristina Martsenko wrote:
> On 02/04/2019 03:27, Amit Daniel Kachhap wrote:
>> From: Mark Rutland <mark.rutland@arm.com>
>>
>> When pointer authentication is supported, a guest may wish to use it.
>> This patch adds the necessary KVM infrastructure for this to work, with
>> a semi-lazy context switch of the pointer auth state.
> 
> [...]
> 
>> diff --git a/arch/arm64/include/asm/kvm_ptrauth_asm.h b/arch/arm64/include/asm/kvm_ptrauth_asm.h
>> new file mode 100644
>> index 0000000..65f99e9
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/kvm_ptrauth_asm.h
>> @@ -0,0 +1,106 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* arch/arm64/include/asm/kvm_ptrauth_asm.h: Guest/host ptrauth save/restore
>> + * Copyright 2019 Arm Limited
>> + * Author: Mark Rutland <mark.rutland@arm.com>
>> + *         Amit Daniel Kachhap <amit.kachhap@arm.com>
>> + */
>> +
>> +#ifndef __ASM_KVM_PTRAUTH_ASM_H
>> +#define __ASM_KVM_PTRAUTH_ASM_H
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#define __ptrauth_save_key(regs, key)						\
>> +({										\
>> +	regs[key ## KEYLO_EL1] = read_sysreg_s(SYS_ ## key ## KEYLO_EL1);	\
>> +	regs[key ## KEYHI_EL1] = read_sysreg_s(SYS_ ## key ## KEYHI_EL1);	\
>> +})
>> +
>> +#define __ptrauth_save_state(ctxt)						\
>> +({										\
>> +	__ptrauth_save_key(ctxt->sys_regs, APIA);				\
>> +	__ptrauth_save_key(ctxt->sys_regs, APIB);				\
>> +	__ptrauth_save_key(ctxt->sys_regs, APDA);				\
>> +	__ptrauth_save_key(ctxt->sys_regs, APDB);				\
>> +	__ptrauth_save_key(ctxt->sys_regs, APGA);				\
>> +})
>> +
>> +#else /* __ASSEMBLY__ */
>> +
>> +#include <asm/sysreg.h>
>> +
>> +#ifdef	CONFIG_ARM64_PTR_AUTH
>> +
>> +#define PTRAUTH_REG_OFFSET(x)	(x - CPU_APIAKEYLO_EL1)
>> +
>> +/*
>> + * CPU_AP*_EL1 values exceed immediate offset range (512) for stp instruction
>> + * so below macros takes CPU_APIAKEYLO_EL1 as base and calculates the offset of
>> + * the keys from this base to avoid an extra add instruction. These macros
>> + * assumes the keys offsets are aligned in a specific increasing order.
>> + */
>> +.macro	ptrauth_save_state base, reg1, reg2
>> +	mrs_s	\reg1, SYS_APIAKEYLO_EL1
>> +	mrs_s	\reg2, SYS_APIAKEYHI_EL1
>> +	stp	\reg1, \reg2, [\base, #PTRAUTH_REG_OFFSET(CPU_APIAKEYLO_EL1)]
>> +	mrs_s	\reg1, SYS_APIBKEYLO_EL1
>> +	mrs_s	\reg2, SYS_APIBKEYHI_EL1
>> +	stp	\reg1, \reg2, [\base, #PTRAUTH_REG_OFFSET(CPU_APIBKEYLO_EL1)]
>> +	mrs_s	\reg1, SYS_APDAKEYLO_EL1
>> +	mrs_s	\reg2, SYS_APDAKEYHI_EL1
>> +	stp	\reg1, \reg2, [\base, #PTRAUTH_REG_OFFSET(CPU_APDAKEYLO_EL1)]
>> +	mrs_s	\reg1, SYS_APDBKEYLO_EL1
>> +	mrs_s	\reg2, SYS_APDBKEYHI_EL1
>> +	stp	\reg1, \reg2, [\base, #PTRAUTH_REG_OFFSET(CPU_APDBKEYLO_EL1)]
>> +	mrs_s	\reg1, SYS_APGAKEYLO_EL1
>> +	mrs_s	\reg2, SYS_APGAKEYHI_EL1
>> +	stp	\reg1, \reg2, [\base, #PTRAUTH_REG_OFFSET(CPU_APGAKEYLO_EL1)]
>> +.endm
>> +
>> +.macro	ptrauth_restore_state base, reg1, reg2
>> +	ldp	\reg1, \reg2, [\base, #PTRAUTH_REG_OFFSET(CPU_APIAKEYLO_EL1)]
>> +	msr_s	SYS_APIAKEYLO_EL1, \reg1
>> +	msr_s	SYS_APIAKEYHI_EL1, \reg2
>> +	ldp	\reg1, \reg2, [\base, #PTRAUTH_REG_OFFSET(CPU_APIBKEYLO_EL1)]
>> +	msr_s	SYS_APIBKEYLO_EL1, \reg1
>> +	msr_s	SYS_APIBKEYHI_EL1, \reg2
>> +	ldp	\reg1, \reg2, [\base, #PTRAUTH_REG_OFFSET(CPU_APDAKEYLO_EL1)]
>> +	msr_s	SYS_APDAKEYLO_EL1, \reg1
>> +	msr_s	SYS_APDAKEYHI_EL1, \reg2
>> +	ldp	\reg1, \reg2, [\base, #PTRAUTH_REG_OFFSET(CPU_APDBKEYLO_EL1)]
>> +	msr_s	SYS_APDBKEYLO_EL1, \reg1
>> +	msr_s	SYS_APDBKEYHI_EL1, \reg2
>> +	ldp	\reg1, \reg2, [\base, #PTRAUTH_REG_OFFSET(CPU_APGAKEYLO_EL1)]
>> +	msr_s	SYS_APGAKEYLO_EL1, \reg1
>> +	msr_s	SYS_APGAKEYHI_EL1, \reg2
>> +.endm
>> +
>> +.macro ptrauth_switch_to_guest g_ctxt, reg1, reg2, reg3
>> +	ldr	\reg1, [\g_ctxt, #CPU_HCR_EL2]
>> +	and	\reg1, \reg1, #(HCR_API | HCR_APK)
>> +	cbz	\reg1, 1f
>> +	add	\reg1, \g_ctxt, #CPU_APIAKEYLO_EL1
>> +	ptrauth_restore_state	\reg1, \reg2, \reg3
>> +1:
> 
> Nit: the label in assembly macros is usually a larger number (see
> assembler.h or alternative.h for example). I think this is to avoid
> future accidents like
> 
> 	cbz	x0, 1f
> 	ptrauth_switch_to_guest	x1, x2, x3, x4
> 	add	x5, x5, x6
> 1:
> 	...
> 
> where the code would incorrectly branch to the label inside
> ptrauth_switch_to_guest, instead of the one after it.
Yes agree that these kind of labels are problematic. I will update in 
the next iteration.

Thanks,
Amit Daniel
> 
> Thanks,
> Kristina
> 
>> +.endm
>> +
>> +.macro ptrauth_switch_to_host g_ctxt, h_ctxt, reg1, reg2, reg3
>> +	ldr	\reg1, [\g_ctxt, #CPU_HCR_EL2]
>> +	and	\reg1, \reg1, #(HCR_API | HCR_APK)
>> +	cbz	\reg1, 2f
>> +	add	\reg1, \g_ctxt, #CPU_APIAKEYLO_EL1
>> +	ptrauth_save_state	\reg1, \reg2, \reg3
>> +	add	\reg1, \h_ctxt, #CPU_APIAKEYLO_EL1
>> +	ptrauth_restore_state	\reg1, \reg2, \reg3
>> +	isb
>> +2:
>> +.endm
>> +
>> +#else /* !CONFIG_ARM64_PTR_AUTH */
>> +.macro ptrauth_switch_to_guest g_ctxt, reg1, reg2, reg3
>> +.endm
>> +.macro ptrauth_switch_to_host g_ctxt, h_ctxt, reg1, reg2, reg3
>> +.endm
>> +#endif /* CONFIG_ARM64_PTR_AUTH */
>> +#endif /* __ASSEMBLY__ */
>> +#endif /* __ASM_KVM_PTRAUTH_ASM_H */
> 
>> diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
>> index 675fdc1..3a70213 100644
>> --- a/arch/arm64/kvm/hyp/entry.S
>> +++ b/arch/arm64/kvm/hyp/entry.S
>> @@ -24,6 +24,7 @@
>>   #include <asm/kvm_arm.h>
>>   #include <asm/kvm_asm.h>
>>   #include <asm/kvm_mmu.h>
>> +#include <asm/kvm_ptrauth_asm.h>
>>   
>>   #define CPU_GP_REG_OFFSET(x)	(CPU_GP_REGS + x)
>>   #define CPU_XREG_OFFSET(x)	CPU_GP_REG_OFFSET(CPU_USER_PT_REGS + 8*x)
>> @@ -64,6 +65,9 @@ ENTRY(__guest_enter)
>>   
>>   	add	x18, x0, #VCPU_CONTEXT
>>   
>> +	// Macro ptrauth_switch_to_guest(guest cxt, tmp1, tmp2, tmp3).
>> +	ptrauth_switch_to_guest x18, x0, x1, x2
>> +
>>   	// Restore guest regs x0-x17
>>   	ldp	x0, x1,   [x18, #CPU_XREG_OFFSET(0)]
>>   	ldp	x2, x3,   [x18, #CPU_XREG_OFFSET(2)]
>> @@ -118,6 +122,9 @@ ENTRY(__guest_exit)
>>   
>>   	get_host_ctxt	x2, x3
>>   
>> +	// Macro ptrauth_switch_to_host(guest cxt, host cxt, tmp1, tmp2, tmp3).
>> +	ptrauth_switch_to_host x1, x2, x3, x4, x5
>> +
>>   	// Now restore the host regs
>>   	restore_callee_saved_regs x2
>>   
