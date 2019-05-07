Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B961CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F5520B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfEGIov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:44:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46836 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfEGIou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:44:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C021374;
        Tue,  7 May 2019 01:44:50 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09DC23F238;
        Tue,  7 May 2019 01:44:47 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] arm64: irqflags: Introduce explicit debugging for
 IRQ priorities
To:     Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        yuzenghui@huawei.com, wanghaibin.wang@huawei.com,
        james.morse@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, liwei391@huawei.com
References: <1556553607-46531-1-git-send-email-julien.thierry@arm.com>
 <1556553607-46531-5-git-send-email-julien.thierry@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <9b27cb2c-5159-3001-672e-9391d7490944@arm.com>
Date:   Tue, 7 May 2019 09:44:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556553607-46531-5-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2019 17:00, Julien Thierry wrote:
> Using IRQ priority masking to enable/disable interrupts is a bit
> sensitive as it requires to deal with both ICC_PMR_EL1 and PSR.I.
> 
> Introduce some validity checks to both highlight the states in which
> functions dealing with IRQ enabling/disabling can (not) be called, and
> bark a warning when called in an unexpected state.
> 
> Since these checks are done on hotpaths, introduce a build option to
> choose whether to do the checking.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/Kconfig                 | 11 +++++++++++
>  arch/arm64/include/asm/daifflags.h |  9 +++++++++
>  arch/arm64/include/asm/irqflags.h  | 14 ++++++++++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7e34b9e..3fb38f3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1359,6 +1359,17 @@ config ARM64_PSEUDO_NMI
> 
>  	  If unsure, say N
> 
> +if ARM64_PSEUDO_NMI
> +config ARM64_DEBUG_PRIORITY_MASKING
> +	bool "Debug interrupt priority masking"
> +	help
> +	  This adds runtime checks to functions enabling/disabling
> +	  interrupts when using priority masking. The additional checks verify
> +	  the validity of ICC_PMR_EL1 when calling concerned functions.
> +
> +	  If unsure, say N
> +endif
> +
>  config RELOCATABLE
>  	bool
>  	help
> diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
> index a32ece9..9512968 100644
> --- a/arch/arm64/include/asm/daifflags.h
> +++ b/arch/arm64/include/asm/daifflags.h
> @@ -28,6 +28,11 @@
>  /* mask/save/unmask/restore all exceptions, including interrupts. */
>  static inline void local_daif_mask(void)
>  {
> +	WARN_ON(IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
> +		system_uses_irq_prio_masking() &&

Given that you repeat these conditions all over the place, how about a
helper:

#define DEBUG_PRIORITY_MASKING_CHECK(x)			\
	(IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) && \
	 system_uses_irq_prio_masking() && (x))

or some variant thereof.

> +		(read_sysreg_s(SYS_ICC_PMR_EL1) == (GIC_PRIO_IRQOFF |
> +						    GIC_PRIO_IGNORE_PMR)));
> +
>  	asm volatile(
>  		"msr	daifset, #0xf		// local_daif_mask\n"
>  		:
> @@ -62,6 +67,10 @@ static inline void local_daif_restore(unsigned long flags)
>  {
>  	bool irq_disabled = flags & PSR_I_BIT;
> 
> +	WARN_ON(IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
> +		system_uses_irq_prio_masking() &&
> +		!(read_sysreg(daif) & PSR_I_BIT));
> +
>  	if (!irq_disabled) {
>  		trace_hardirqs_on();
> 
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 516cdfc..a40abc2 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -40,6 +40,13 @@
>   */
>  static inline void arch_local_irq_enable(void)
>  {
> +	if (IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
> +	    system_uses_irq_prio_masking()) {
> +		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
> +
> +		WARN_ON(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
> +	}
> +
>  	asm volatile(ALTERNATIVE(
>  		"msr	daifclr, #2		// arch_local_irq_enable\n"
>  		"nop",
> @@ -53,6 +60,13 @@ static inline void arch_local_irq_enable(void)
> 
>  static inline void arch_local_irq_disable(void)
>  {
> +	if (IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
> +	    system_uses_irq_prio_masking()) {
> +		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
> +
> +		WARN_ON(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
> +	}
> +
>  	asm volatile(ALTERNATIVE(
>  		"msr	daifset, #2		// arch_local_irq_disable",
>  		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> --
> 1.9.1
> 

nit: There is also the question of using WARN_ON in a context that will
be extremely noisy if we're in a condition where this fires.
WARN_ON_ONCE, maybe? This is a debugging thing, so maybe we just don't care.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
