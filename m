Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914A0C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC2E20862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfEPNne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:43:34 -0400
Received: from foss.arm.com ([217.140.101.70]:46308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPNnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:43:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 939901715;
        Thu, 16 May 2019 06:43:33 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE5F23F575;
        Thu, 16 May 2019 06:43:27 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] arm64: irqflags: Introduce explicit debugging for
 IRQ priorities
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        yuzenghui@huawei.com, wanghaibin.wang@huawei.com,
        james.morse@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, liwei391@huawei.com
References: <1556553607-46531-1-git-send-email-julien.thierry@arm.com>
 <1556553607-46531-5-git-send-email-julien.thierry@arm.com>
 <9b27cb2c-5159-3001-672e-9391d7490944@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <890a91fd-da1e-50b4-6567-d732a850e32c@arm.com>
Date:   Thu, 16 May 2019 14:43:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9b27cb2c-5159-3001-672e-9391d7490944@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/05/2019 09:44, Marc Zyngier wrote:
> On 29/04/2019 17:00, Julien Thierry wrote:
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
>>  arch/arm64/Kconfig                 | 11 +++++++++++
>>  arch/arm64/include/asm/daifflags.h |  9 +++++++++
>>  arch/arm64/include/asm/irqflags.h  | 14 ++++++++++++++
>>  3 files changed, 34 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 7e34b9e..3fb38f3 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1359,6 +1359,17 @@ config ARM64_PSEUDO_NMI
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
>> diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
>> index a32ece9..9512968 100644
>> --- a/arch/arm64/include/asm/daifflags.h
>> +++ b/arch/arm64/include/asm/daifflags.h
>> @@ -28,6 +28,11 @@
>>  /* mask/save/unmask/restore all exceptions, including interrupts. */
>>  static inline void local_daif_mask(void)
>>  {
>> +	WARN_ON(IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
>> +		system_uses_irq_prio_masking() &&
> 
> Given that you repeat these conditions all over the place, how about a
> helper:
> 
> #define DEBUG_PRIORITY_MASKING_CHECK(x)			\
> 	(IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) && \
> 	 system_uses_irq_prio_masking() && (x))
> 
> or some variant thereof.
> 

Yes, good point, I'll do that.

>> +		(read_sysreg_s(SYS_ICC_PMR_EL1) == (GIC_PRIO_IRQOFF |
>> +						    GIC_PRIO_IGNORE_PMR)));
>> +
>>  	asm volatile(
>>  		"msr	daifset, #0xf		// local_daif_mask\n"
>>  		:
>> @@ -62,6 +67,10 @@ static inline void local_daif_restore(unsigned long flags)
>>  {
>>  	bool irq_disabled = flags & PSR_I_BIT;
>>
>> +	WARN_ON(IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
>> +		system_uses_irq_prio_masking() &&
>> +		!(read_sysreg(daif) & PSR_I_BIT));
>> +
>>  	if (!irq_disabled) {
>>  		trace_hardirqs_on();
>>
>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
>> index 516cdfc..a40abc2 100644
>> --- a/arch/arm64/include/asm/irqflags.h
>> +++ b/arch/arm64/include/asm/irqflags.h
>> @@ -40,6 +40,13 @@
>>   */
>>  static inline void arch_local_irq_enable(void)
>>  {
>> +	if (IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
>> +	    system_uses_irq_prio_masking()) {
>> +		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
>> +
>> +		WARN_ON(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
>> +	}
>> +
>>  	asm volatile(ALTERNATIVE(
>>  		"msr	daifclr, #2		// arch_local_irq_enable\n"
>>  		"nop",
>> @@ -53,6 +60,13 @@ static inline void arch_local_irq_enable(void)
>>
>>  static inline void arch_local_irq_disable(void)
>>  {
>> +	if (IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
>> +	    system_uses_irq_prio_masking()) {
>> +		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
>> +
>> +		WARN_ON(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
>> +	}
>> +
>>  	asm volatile(ALTERNATIVE(
>>  		"msr	daifset, #2		// arch_local_irq_disable",
>>  		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
>> --
>> 1.9.1
>>
> 
> nit: There is also the question of using WARN_ON in a context that will
> be extremely noisy if we're in a condition where this fires.
> WARN_ON_ONCE, maybe? This is a debugging thing, so maybe we just don't care.
> 

Yes, thinking about it, it did get pretty noisy when I checked this was
working. WARN_ON_ONCE might be a good option.

Thanks,

-- 
Julien Thierry
