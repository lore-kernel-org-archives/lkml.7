Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D0A20850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfCYKcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:32:21 -0400
Received: from foss.arm.com ([217.140.101.70]:45020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730491AbfCYKcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:32:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CED71596;
        Mon, 25 Mar 2019 03:32:20 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 022E63F575;
        Mon, 25 Mar 2019 03:32:17 -0700 (PDT)
Date:   Mon, 25 Mar 2019 10:32:14 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <marc.zyngier@arm.com>,
        <suzuki.poulose@arm.com>, <Dave.Martin@arm.com>,
        <shankerd@codeaurora.org>, <julien.thierry@arm.com>,
        <mlangsdo@redhat.com>, <stefan.wahren@i2e.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v6 03/10] arm64: add sysfs vulnerability show for
 meltdown
Message-ID: <20190325103214.33401868@donnerap.cambridge.arm.com>
In-Reply-To: <20190321230557.45107-4-jeremy.linton@arm.com>
References: <20190321230557.45107-1-jeremy.linton@arm.com>
        <20190321230557.45107-4-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 18:05:50 -0500
Jeremy Linton <jeremy.linton@arm.com> wrote:

Hi,

> Display the system vulnerability status. This means that
> while its possible to have the mitigation enabled, the
> sysfs entry won't indicate that status. This is because
> the core ABI doesn't express the concept of mitigation
> when the system isn't vulnerable.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks for the changes, look good to me now for all the cases I tried on
the logic.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> ---
>  arch/arm64/kernel/cpufeature.c | 58 ++++++++++++++++++++++++++--------
>  1 file changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 4061de10cea6..6b7e1556460a 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -947,7 +947,7 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>  	return has_cpuid_feature(entry, scope);
>  }
>  
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +static bool __meltdown_safe = true;
>  static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>  
>  static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> @@ -967,6 +967,16 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  		{ /* sentinel */ }
>  	};
>  	char const *str = "command line option";
> +	bool meltdown_safe;
> +
> +	meltdown_safe = is_midr_in_range_list(read_cpuid_id(), kpti_safe_list);
> +
> +	/* Defer to CPU feature registers */
> +	if (has_cpuid_feature(entry, scope))
> +		meltdown_safe = true;
> +
> +	if (!meltdown_safe)
> +		__meltdown_safe = false;
>  
>  	/*
>  	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
> @@ -978,6 +988,19 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  		__kpti_forced = -1;
>  	}
>  
> +	/* Useful for KASLR robustness */
> +	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_offset() > 0) {
> +		if (!__kpti_forced) {
> +			str = "KASLR";
> +			__kpti_forced = 1;
> +		}
> +	}
> +
> +	if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0)) {
> +		pr_info_once("kernel page table isolation disabled by CONFIG\n");
> +		return false;
> +	}
> +
>  	/* Forced? */
>  	if (__kpti_forced) {
>  		pr_info_once("kernel page table isolation forced %s by %s\n",
> @@ -985,18 +1008,10 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  		return __kpti_forced > 0;
>  	}
>  
> -	/* Useful for KASLR robustness */
> -	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> -		return kaslr_offset() > 0;
> -
> -	/* Don't force KPTI for CPUs that are not vulnerable */
> -	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
> -		return false;
> -
> -	/* Defer to CPU feature registers */
> -	return !has_cpuid_feature(entry, scope);
> +	return !meltdown_safe;
>  }
>  
> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  static void
>  kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
>  {
> @@ -1026,6 +1041,12 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
>  
>  	return;
>  }
> +#else
> +static void
> +kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
> +{
> +}
> +#endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
>  
>  static int __init parse_kpti(char *str)
>  {
> @@ -1039,7 +1060,6 @@ static int __init parse_kpti(char *str)
>  	return 0;
>  }
>  early_param("kpti", parse_kpti);
> -#endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
>  
>  #ifdef CONFIG_ARM64_HW_AFDBM
>  static inline void __cpu_enable_hw_dbm(void)
> @@ -1306,7 +1326,6 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.field_pos = ID_AA64PFR0_EL0_SHIFT,
>  		.min_field_value = ID_AA64PFR0_EL0_32BIT_64BIT,
>  	},
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  	{
>  		.desc = "Kernel page table isolation (KPTI)",
>  		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
> @@ -1322,7 +1341,6 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = unmap_kernel_at_el0,
>  		.cpu_enable = kpti_install_ng_mappings,
>  	},
> -#endif
>  	{
>  		/* FP/SIMD is not implemented */
>  		.capability = ARM64_HAS_NO_FPSIMD,
> @@ -2101,3 +2119,15 @@ static int __init enable_mrs_emulation(void)
>  }
>  
>  core_initcall(enable_mrs_emulation);
> +
> +ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	if (__meltdown_safe)
> +		return sprintf(buf, "Not affected\n");
> +
> +	if (arm64_kernel_unmapped_at_el0())
> +		return sprintf(buf, "Mitigation: KPTI\n");
> +
> +	return sprintf(buf, "Vulnerable\n");
> +}

