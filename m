Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7C8C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCB620859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbfFJHxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:53:41 -0400
Received: from foss.arm.com ([217.140.110.172]:37464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387781AbfFJHxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:53:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D961344;
        Mon, 10 Jun 2019 00:53:40 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18E3A3F246;
        Mon, 10 Jun 2019 00:53:37 -0700 (PDT)
Subject: Re: [PATCH v3 6/8] arm64: irqflags: Introduce explicit debugging for
 IRQ priorities
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        yuzenghui@huawei.com, wanghaibin.wang@huawei.com,
        james.morse@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, liwei391@huawei.com
References: <1559813517-41540-1-git-send-email-julien.thierry@arm.com>
 <1559813517-41540-7-git-send-email-julien.thierry@arm.com>
 <acc8bb85-04cb-f8af-5162-79788a5cacbb@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <e26f0761-b682-ef42-b510-53654bed1f4b@arm.com>
Date:   Mon, 10 Jun 2019 08:53:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <acc8bb85-04cb-f8af-5162-79788a5cacbb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/2019 17:31, Marc Zyngier wrote:
> On 06/06/2019 10:31, Julien Thierry wrote:
>> Using IRQ priority masking to enable/disable interrupts is a bit
>> sensitive as it requires to deal with both ICC_PMR_EL1 and PSR.I.
>>
>> Introduce some validity checks to both highlight the states in which
>> functions dealing with IRQ enabling/disabling can (not) be called, and
>> bark a warning when called in an unexpected state.
>>
>> Since these checks are done on hotpaths, introduce a build option to
>> choose whether to do the checking.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  arch/arm64/Kconfig                  | 11 +++++++++++
>>  arch/arm64/include/asm/cpufeature.h |  6 ++++++
>>  arch/arm64/include/asm/daifflags.h  |  7 +++++++
>>  arch/arm64/include/asm/irqflags.h   | 14 +++++++++++++-
>>  4 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 697ea05..8acc40e 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1436,6 +1436,17 @@ config ARM64_PSEUDO_NMI
>>
>>  	  If unsure, say N
>>
>> +if ARM64_PSEUDO_NMI
>> +config ARM64_DEBUG_PRIORITY_MASKING
>> +	bool "Debug interrupt priority masking"
>> +	help
>> +	  This adds runtime checks to functions enabling/disabling
>> +	  interrupts when using priority masking. The additional checks verify
>> +	  the validity of ICC_PMR_EL1 when calling concerned functions.
>> +
>> +	  If unsure, say N
>> +endif
>> +
>>  config RELOCATABLE
>>  	bool
>>  	help
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index bc895c8..693a086 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -617,6 +617,12 @@ static inline bool system_uses_irq_prio_masking(void)
>>  	       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
>>  }
>>
>> +static inline bool system_has_prio_mask_debugging(void)
>> +{
>> +	return IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
>> +	       system_uses_irq_prio_masking();
>> +}
>> +
>>  #define ARM64_SSBD_UNKNOWN		-1
>>  #define ARM64_SSBD_FORCE_DISABLE	0
>>  #define ARM64_SSBD_KERNEL		1
>> diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
>> index f93204f..eca5bee 100644
>> --- a/arch/arm64/include/asm/daifflags.h
>> +++ b/arch/arm64/include/asm/daifflags.h
>> @@ -28,6 +28,10 @@
>>  /* mask/save/unmask/restore all exceptions, including interrupts. */
>>  static inline void local_daif_mask(void)
>>  {
>> +	WARN_ON(system_has_prio_mask_debugging() &&
>> +		(read_sysreg_s(SYS_ICC_PMR_EL1) == (GIC_PRIO_IRQOFF |
>> +						    GIC_PRIO_PSR_I_SET)));
>> +
>>  	asm volatile(
>>  		"msr	daifset, #0xf		// local_daif_mask\n"
>>  		:
>> @@ -62,6 +66,9 @@ static inline void local_daif_restore(unsigned long flags)
>>  {
>>  	bool irq_disabled = flags & PSR_I_BIT;
>>
>> +	WARN_ON(system_has_prio_mask_debugging() &&
>> +		!(read_sysreg(daif) & PSR_I_BIT));
>> +
>>  	if (!irq_disabled) {
>>  		trace_hardirqs_on();
>>
>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
>> index b6f757f..cac2d2a 100644
>> --- a/arch/arm64/include/asm/irqflags.h
>> +++ b/arch/arm64/include/asm/irqflags.h
>> @@ -40,6 +40,12 @@
>>   */
>>  static inline void arch_local_irq_enable(void)
>>  {
>> +	if (system_has_prio_mask_debugging()) {
>> +		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
>> +
>> +		WARN_ON_ONCE(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
>> +	}
>> +
>>  	asm volatile(ALTERNATIVE(
>>  		"msr	daifclr, #2		// arch_local_irq_enable\n"
>>  		"nop",
>> @@ -53,6 +59,12 @@ static inline void arch_local_irq_enable(void)
>>
>>  static inline void arch_local_irq_disable(void)
>>  {
>> +	if (system_has_prio_mask_debugging()) {
>> +		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
>> +
>> +		WARN_ON_ONCE(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
>> +	}
>> +
>>  	asm volatile(ALTERNATIVE(
>>  		"msr	daifset, #2		// arch_local_irq_disable",
>>  		__msr_s(SYS_ICC_PMR_EL1, "%0"),
>> @@ -86,7 +98,7 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
>>
>>  	asm volatile(ALTERNATIVE(
>>  		"and	%w0, %w1, #" __stringify(PSR_I_BIT),
>> -		"eor	%w0, %w1, #" __stringify(GIC_PRIO_IRQOFF),
>> +		"eor	%w0, %w1, #" __stringify(GIC_PRIO_IRQON),
> 
> Err... Which version is the correct one? This one, or the previous one?
> 

Argh, bad fixup of the patches. This one is the correct one (any state
!= GIC_PRIO_IRQON means interrupts are disabled), but the correct value
should already be in use in the previous patch.

Will fix that in the next posting.

Thanks,

-- 
Julien Thierry
