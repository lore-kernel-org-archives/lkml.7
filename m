Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50BAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ED420851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfCAKiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:38:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32826 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbfCAKiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:38:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26407EBD;
        Fri,  1 Mar 2019 02:38:00 -0800 (PST)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C60A3F575;
        Fri,  1 Mar 2019 02:37:57 -0800 (PST)
Subject: Re: [kvmtool PATCH v6 6/6] arm/kvm: arm64: Add a vcpu feature for
 pointer authentication
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        linux-kernel@vger.kernel.org
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-7-git-send-email-amit.kachhap@arm.com>
 <20190221155409.GA3567@e103592.cambridge.arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <048f772a-1faf-5fa3-d82c-25212a5104af@arm.com>
Date:   Fri, 1 Mar 2019 16:07:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221155409.GA3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/21/19 9:24 PM, Dave Martin wrote:
> On Tue, Feb 19, 2019 at 02:54:31PM +0530, Amit Daniel Kachhap wrote:
>> This is a runtime capabality for KVM tool to enable Armv8.3 Pointer
>> Authentication in guest kernel. A command line option --ptrauth is
>> required for this.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> ---
>>   arm/aarch32/include/kvm/kvm-cpu-arch.h    | 1 +
>>   arm/aarch64/include/asm/kvm.h             | 1 +
>>   arm/aarch64/include/kvm/kvm-config-arch.h | 4 +++-
>>   arm/aarch64/include/kvm/kvm-cpu-arch.h    | 1 +
>>   arm/include/arm-common/kvm-config-arch.h  | 1 +
>>   arm/kvm-cpu.c                             | 6 ++++++
>>   include/linux/kvm.h                       | 1 +
>>   7 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arm/aarch32/include/kvm/kvm-cpu-arch.h b/arm/aarch32/include/kvm/kvm-cpu-arch.h
>> index d28ea67..520ea76 100644
>> --- a/arm/aarch32/include/kvm/kvm-cpu-arch.h
>> +++ b/arm/aarch32/include/kvm/kvm-cpu-arch.h
>> @@ -13,4 +13,5 @@
>>   #define ARM_CPU_ID		0, 0, 0
>>   #define ARM_CPU_ID_MPIDR	5
>>   
>> +#define ARM_VCPU_PTRAUTH_FEATURE	0
>>   #endif /* KVM__KVM_CPU_ARCH_H */
>> diff --git a/arm/aarch64/include/asm/kvm.h b/arm/aarch64/include/asm/kvm.h
>> index 97c3478..1068fd1 100644
>> --- a/arm/aarch64/include/asm/kvm.h
>> +++ b/arm/aarch64/include/asm/kvm.h
>> @@ -102,6 +102,7 @@ struct kvm_regs {
>>   #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
>>   #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
>>   #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */
>> +#define KVM_ARM_VCPU_PTRAUTH		4 /* CPU uses pointer authentication */
>>   
>>   struct kvm_vcpu_init {
>>   	__u32 target;
>> diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
>> index 04be43d..2074684 100644
>> --- a/arm/aarch64/include/kvm/kvm-config-arch.h
>> +++ b/arm/aarch64/include/kvm/kvm-config-arch.h
>> @@ -8,7 +8,9 @@
>>   			"Create PMUv3 device"),				\
>>   	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
>>   			"Specify random seed for Kernel Address Space "	\
>> -			"Layout Randomization (KASLR)"),
>> +			"Layout Randomization (KASLR)"),		\
>> +	OPT_BOOLEAN('\0', "ptrauth", &(cfg)->has_ptrauth,		\
>> +			"Enable address authentication"),
> 
> Nit: doesn't this enable address *and* generic authentication?  The
> discussion on what capababilities and enables the ABI exposes probably
> needs to conclude before we can finalise this here.
ok.
> 
> However, I would recommend that we provide a single option here that
> turns both address authentication and generic authentication on, even
> if the ABI treats them independently.  This is expected to be the common
> case by far.
ok
> 
> We can always add more fine-grained options later if it turns out to be
> necessary.
Mark suggested to provide 2 flags [1] for Address and Generic 
authentication so I was thinking of adding 2 features like,

+#define KVM_ARM_VCPU_PTRAUTH_ADDR		4 /* CPU uses pointer address 
authentication */
+#define KVM_ARM_VCPU_PTRAUTH_GENERIC		5 /* CPU uses pointer generic 
authentication */

And supply both of them concatenated in VCPU_INIT stage. Kernel KVM 
would expect both feature requested together.

[1]: https://www.spinics.net/lists/arm-kernel/msg709181.html
> 
>>   #include "arm-common/kvm-config-arch.h"
>>   
>> diff --git a/arm/aarch64/include/kvm/kvm-cpu-arch.h b/arm/aarch64/include/kvm/kvm-cpu-arch.h
>> index a9d8563..496ece8 100644
>> --- a/arm/aarch64/include/kvm/kvm-cpu-arch.h
>> +++ b/arm/aarch64/include/kvm/kvm-cpu-arch.h
>> @@ -17,4 +17,5 @@
>>   #define ARM_CPU_CTRL		3, 0, 1, 0
>>   #define ARM_CPU_CTRL_SCTLR_EL1	0
>>   
>> +#define ARM_VCPU_PTRAUTH_FEATURE	(1UL << KVM_ARM_VCPU_PTRAUTH)
>>   #endif /* KVM__KVM_CPU_ARCH_H */
>> diff --git a/arm/include/arm-common/kvm-config-arch.h b/arm/include/arm-common/kvm-config-arch.h
>> index 5734c46..5badcbd 100644
>> --- a/arm/include/arm-common/kvm-config-arch.h
>> +++ b/arm/include/arm-common/kvm-config-arch.h
>> @@ -10,6 +10,7 @@ struct kvm_config_arch {
>>   	bool		aarch32_guest;
>>   	bool		has_pmuv3;
>>   	u64		kaslr_seed;
>> +	bool		has_ptrauth;
>>   	enum irqchip_type irqchip;
>>   	u64		fw_addr;
>>   };
>> diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
>> index 7780251..4ac80f8 100644
>> --- a/arm/kvm-cpu.c
>> +++ b/arm/kvm-cpu.c
>> @@ -68,6 +68,12 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
>>   		vcpu_init.features[0] |= (1UL << KVM_ARM_VCPU_PSCI_0_2);
>>   	}
>>   
>> +	/* Set KVM_ARM_VCPU_PTRAUTH if available */
>> +	if (kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH)) {
>> +		if (kvm->cfg.arch.has_ptrauth)
>> +			vcpu_init.features[0] |= ARM_VCPU_PTRAUTH_FEATURE;
>> +	}
>> +
> 
> I'm not too keen on requiring a dummy #define for AArch32 here.  How do
> we handle other subarch-specific feature flags?  Is there something we
> can reuse?
I will check it.

Thanks,
Amit D
> 
> (For SVE I didn''t have a proper solution for this yet: my kvmtool
> patches are still a dirty hack...)
> 
> [...]
> 
> Cheers
> ---Dave
> 
