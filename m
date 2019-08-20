Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898E3C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659BC22CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfHTPX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:23:26 -0400
Received: from foss.arm.com ([217.140.110.172]:43078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbfHTPX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:23:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B32E28;
        Tue, 20 Aug 2019 08:23:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 613EC3F246;
        Tue, 20 Aug 2019 08:23:24 -0700 (PDT)
Date:   Tue, 20 Aug 2019 16:23:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, raph.gault+kdev@gmail.com
Subject: Re: [PATCH v3 2/5] arm64: cpufeature: Add feature to detect
 heterogeneous systems
Message-ID: <20190820152316.GA38082@lakrids.cambridge.arm.com>
References: <20190816125934.18509-1-raphael.gault@arm.com>
 <20190816125934.18509-3-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816125934.18509-3-raphael.gault@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raphael,

On Fri, Aug 16, 2019 at 01:59:31PM +0100, Raphael Gault wrote:
> This feature is required in order to enable PMU counters direct
> access from userspace only when the system is homogeneous.
> This feature checks the model of each CPU brought online and compares it
> to the boot CPU. If it differs then it is heterogeneous.

I t would be worth noting that this patch prevents heterogeneous CPUs
being brought online late if the system was uniform at boot time.

> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  arch/arm64/include/asm/cpucaps.h |  3 ++-
>  arch/arm64/kernel/cpufeature.c   | 20 ++++++++++++++++++++
>  arch/arm64/kernel/perf_event.c   |  1 +
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index f19fe4b9acc4..040370af38ad 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -52,7 +52,8 @@
>  #define ARM64_HAS_IRQ_PRIO_MASKING		42
>  #define ARM64_HAS_DCPODP			43
>  #define ARM64_WORKAROUND_1463225		44
> +#define ARM64_HAS_HETEROGENEOUS_PMU		45
>  
> -#define ARM64_NCAPS				45
> +#define ARM64_NCAPS				46
>  
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9323bcc40a58..bbdd809f12a6 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1260,6 +1260,15 @@ static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
>  }
>  #endif
>  
> +static bool has_heterogeneous_pmu(const struct arm64_cpu_capabilities *entry,
> +				     int scope)
> +{
> +	u32 model = read_cpuid_id() & MIDR_CPU_MODEL_MASK;
> +	struct cpuinfo_arm64 *boot = &per_cpu(cpu_data, 0);
> +
> +	return  (boot->reg_midr & MIDR_CPU_MODEL_MASK) != model;
> +}

We should use boot_cpu_data rather than &per_cpu(cpu_data, 0) here. We
can make that __ro_after_init, and declare it in
arch/arm64/includ/asm/smp.h.

That caters for CPU0 being hotplugged off and then a different physical
CPU being hotplugged on in its place.

> +
>  static const struct arm64_cpu_capabilities arm64_features[] = {
>  	{
>  		.desc = "GIC system register CPU interface",
> @@ -1560,6 +1569,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.min_field_value = 1,
>  	},
>  #endif
> +	{
> +		/*
> +		 * Detect whether the system is heterogeneous or
> +		 * homogeneous
> +		 */
> +		.desc = "Detect whether we have heterogeneous CPUs",

The desc gets printed in dmesg with a prefix, e.g.

[    0.058267][    T1] CPU features: detected: Privileged Access Never
[    0.058340][    T1] CPU features: detected: LSE atomic instructions
[    0.058416][    T1] CPU features: detected: RAS Extension Support
[    0.058489][    T1] CPU features: detected: CRC32 instructions

... so this should only say "Heterogeneous CPUs".

> +		.capability = ARM64_HAS_HETEROGENEOUS_PMU,
> +		.type = ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU,
> +		.matches = has_heterogeneous_pmu,
> +	},
>  	{},
>  };
>  
> @@ -1727,6 +1746,7 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
>  			cap_set_elf_hwcap(hwcaps);
>  }
>  
> +

This whitespace addition can go.

>  static void update_cpu_capabilities(u16 scope_mask)
>  {
>  	int i;
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 2d3bdebdf6df..a0b4f1bca491 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/perf/arm_pmu.h>
>  #include <linux/platform_device.h>
> +#include <linux/smp.h>

I think this should be added in a separate patch.

It looks like this is a missing include that we need today for
smp_processor_id(), so please spin that as a preparatory patch (with my
Acked-by).

Thanks,
Mark.

>  
>  /* ARMv8 Cortex-A53 specific event types. */
>  #define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
> -- 
> 2.17.1
> 
