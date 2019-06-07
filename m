Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0084C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B450B2064A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfFGQbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:31:31 -0400
Received: from foss.arm.com ([217.140.110.172]:44210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfFGQba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:31:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 952823EF;
        Fri,  7 Jun 2019 09:31:29 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E28B3F71A;
        Fri,  7 Jun 2019 09:31:28 -0700 (PDT)
Subject: Re: [PATCH v3 6/8] arm64: irqflags: Introduce explicit debugging for
 IRQ priorities
To:     Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        yuzenghui@huawei.com, wanghaibin.wang@huawei.com,
        james.morse@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, liwei391@huawei.com
References: <1559813517-41540-1-git-send-email-julien.thierry@arm.com>
 <1559813517-41540-7-git-send-email-julien.thierry@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
 Z46HaNmN2hZS/oJ69c1DI5Rcww==
Organization: ARM Ltd
Message-ID: <acc8bb85-04cb-f8af-5162-79788a5cacbb@arm.com>
Date:   Fri, 7 Jun 2019 17:31:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559813517-41540-7-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2019 10:31, Julien Thierry wrote:
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
>  arch/arm64/Kconfig                  | 11 +++++++++++
>  arch/arm64/include/asm/cpufeature.h |  6 ++++++
>  arch/arm64/include/asm/daifflags.h  |  7 +++++++
>  arch/arm64/include/asm/irqflags.h   | 14 +++++++++++++-
>  4 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 697ea05..8acc40e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1436,6 +1436,17 @@ config ARM64_PSEUDO_NMI
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
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index bc895c8..693a086 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -617,6 +617,12 @@ static inline bool system_uses_irq_prio_masking(void)
>  	       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
>  }
> 
> +static inline bool system_has_prio_mask_debugging(void)
> +{
> +	return IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
> +	       system_uses_irq_prio_masking();
> +}
> +
>  #define ARM64_SSBD_UNKNOWN		-1
>  #define ARM64_SSBD_FORCE_DISABLE	0
>  #define ARM64_SSBD_KERNEL		1
> diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
> index f93204f..eca5bee 100644
> --- a/arch/arm64/include/asm/daifflags.h
> +++ b/arch/arm64/include/asm/daifflags.h
> @@ -28,6 +28,10 @@
>  /* mask/save/unmask/restore all exceptions, including interrupts. */
>  static inline void local_daif_mask(void)
>  {
> +	WARN_ON(system_has_prio_mask_debugging() &&
> +		(read_sysreg_s(SYS_ICC_PMR_EL1) == (GIC_PRIO_IRQOFF |
> +						    GIC_PRIO_PSR_I_SET)));
> +
>  	asm volatile(
>  		"msr	daifset, #0xf		// local_daif_mask\n"
>  		:
> @@ -62,6 +66,9 @@ static inline void local_daif_restore(unsigned long flags)
>  {
>  	bool irq_disabled = flags & PSR_I_BIT;
> 
> +	WARN_ON(system_has_prio_mask_debugging() &&
> +		!(read_sysreg(daif) & PSR_I_BIT));
> +
>  	if (!irq_disabled) {
>  		trace_hardirqs_on();
> 
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index b6f757f..cac2d2a 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -40,6 +40,12 @@
>   */
>  static inline void arch_local_irq_enable(void)
>  {
> +	if (system_has_prio_mask_debugging()) {
> +		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
> +
> +		WARN_ON_ONCE(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
> +	}
> +
>  	asm volatile(ALTERNATIVE(
>  		"msr	daifclr, #2		// arch_local_irq_enable\n"
>  		"nop",
> @@ -53,6 +59,12 @@ static inline void arch_local_irq_enable(void)
> 
>  static inline void arch_local_irq_disable(void)
>  {
> +	if (system_has_prio_mask_debugging()) {
> +		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
> +
> +		WARN_ON_ONCE(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
> +	}
> +
>  	asm volatile(ALTERNATIVE(
>  		"msr	daifset, #2		// arch_local_irq_disable",
>  		__msr_s(SYS_ICC_PMR_EL1, "%0"),
> @@ -86,7 +98,7 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
> 
>  	asm volatile(ALTERNATIVE(
>  		"and	%w0, %w1, #" __stringify(PSR_I_BIT),
> -		"eor	%w0, %w1, #" __stringify(GIC_PRIO_IRQOFF),
> +		"eor	%w0, %w1, #" __stringify(GIC_PRIO_IRQON),

Err... Which version is the correct one? This one, or the previous one?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
