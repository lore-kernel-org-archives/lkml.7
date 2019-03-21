Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2078DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89542184E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfCUF3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 01:29:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50746 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfCUF3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 01:29:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69F8B374;
        Wed, 20 Mar 2019 22:29:15 -0700 (PDT)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EE203F71A;
        Wed, 20 Mar 2019 22:29:11 -0700 (PDT)
Subject: Re: [PATCH v7 3/10] KVM: arm64: Move hyp_symbol_addr to fix
 dependency
To:     Julien Thierry <julien.thierry@arm.com>,
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
        James Morse <james.morse@arm.com>
References: <1552984243-7689-1-git-send-email-amit.kachhap@arm.com>
 <1552984243-7689-4-git-send-email-amit.kachhap@arm.com>
 <aca8f96c-8f38-8688-f6e2-a50c0a79f4ae@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <7fda2a45-cd34-b981-44b5-7ca0a596d100@arm.com>
Date:   Thu, 21 Mar 2019 10:59:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <aca8f96c-8f38-8688-f6e2-a50c0a79f4ae@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 3/20/19 2:19 PM, Julien Thierry wrote:
> Hi Amit,
> 
> On 19/03/2019 08:30, Amit Daniel Kachhap wrote:
>> Currently hyp_symbol_addr is palced in kvm_mmu.h which is mostly
>> used by __hyp_this_cpu_ptr in kvm_asm.h but it cannot include
>> kvm_mmu.h directly as kvm_mmu.h uses kvm_ksym_ref which is
>> defined inside kvm_asm.h. Hence, hyp_symbol_addr is moved inside
>> kvm_asm.h to fix this dependency on each other.
>>
>> Also kvm_ksym_ref is corresponding counterpart of hyp_symbol_addr
>> so should be ideally placed inside kvm_asm.h.
>>
> 
> This part is a bit confusing, it lead me to think that kvm_ksym_ref was
> in kvm_mmu.h and should moved to kvm_asm.h as well. I'd suggest
> rephrasing it with something along the lines:
> 
> "Also, hyp_symbol_addr corresponding counterpart, kvm_ksym_ref, is
> already in kvm_asm.h, making it more sensible to move kvm_symbol_addr to
> the same file."
ok, will rephrase.
> 
> Otherwise:
> 
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Thanks,
Amit
> 
> Cheers,
> 
> Julien
> 
>> Suggested by: James Morse <james.morse@arm.com>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: kvmarm@lists.cs.columbia.edu
>> ---
>>   arch/arm64/include/asm/kvm_asm.h | 20 ++++++++++++++++++++
>>   arch/arm64/include/asm/kvm_mmu.h | 20 --------------------
>>   2 files changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
>> index f5b79e9..57a07e8 100644
>> --- a/arch/arm64/include/asm/kvm_asm.h
>> +++ b/arch/arm64/include/asm/kvm_asm.h
>> @@ -80,6 +80,26 @@ extern void __vgic_v3_init_lrs(void);
>>   
>>   extern u32 __kvm_get_mdcr_el2(void);
>>   
>> +/*
>> + * Obtain the PC-relative address of a kernel symbol
>> + * s: symbol
>> + *
>> + * The goal of this macro is to return a symbol's address based on a
>> + * PC-relative computation, as opposed to a loading the VA from a
>> + * constant pool or something similar. This works well for HYP, as an
>> + * absolute VA is guaranteed to be wrong. Only use this if trying to
>> + * obtain the address of a symbol (i.e. not something you obtained by
>> + * following a pointer).
>> + */
>> +#define hyp_symbol_addr(s)						\
>> +	({								\
>> +		typeof(s) *addr;					\
>> +		asm("adrp	%0, %1\n"				\
>> +		    "add	%0, %0, :lo12:%1\n"			\
>> +		    : "=r" (addr) : "S" (&s));				\
>> +		addr;							\
>> +	})
>> +
>>   /* Home-grown __this_cpu_{ptr,read} variants that always work at HYP */
>>   #define __hyp_this_cpu_ptr(sym)						\
>>   	({								\
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index b0742a1..3dea6af 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -118,26 +118,6 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
>>   #define kern_hyp_va(v) 	((typeof(v))(__kern_hyp_va((unsigned long)(v))))
>>   
>>   /*
>> - * Obtain the PC-relative address of a kernel symbol
>> - * s: symbol
>> - *
>> - * The goal of this macro is to return a symbol's address based on a
>> - * PC-relative computation, as opposed to a loading the VA from a
>> - * constant pool or something similar. This works well for HYP, as an
>> - * absolute VA is guaranteed to be wrong. Only use this if trying to
>> - * obtain the address of a symbol (i.e. not something you obtained by
>> - * following a pointer).
>> - */
>> -#define hyp_symbol_addr(s)						\
>> -	({								\
>> -		typeof(s) *addr;					\
>> -		asm("adrp	%0, %1\n"				\
>> -		    "add	%0, %0, :lo12:%1\n"			\
>> -		    : "=r" (addr) : "S" (&s));				\
>> -		addr;							\
>> -	})
>> -
>> -/*
>>    * We currently support using a VM-specified IPA size. For backward
>>    * compatibility, the default IPA size is fixed to 40bits.
>>    */
>>
> 
