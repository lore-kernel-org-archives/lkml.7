Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0BAC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 10:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D0C21743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 10:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEAKxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 06:53:30 -0400
Received: from foss.arm.com ([217.140.101.70]:57994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfEAKxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 06:53:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C372680D;
        Wed,  1 May 2019 03:53:29 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 825A83F719;
        Wed,  1 May 2019 03:53:28 -0700 (PDT)
Date:   Wed, 1 May 2019 11:53:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/arm_arch_timer: extract elf_hwcap use to
 arch-helper
Message-ID: <20190501105325.GC11740@lakrids.cambridge.arm.com>
References: <20190430131413.10017-1-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430131413.10017-1-andrew.murray@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 02:14:13PM +0100, Andrew Murray wrote:
> Different mechanisms are used to test and set elf_hwcaps between ARM
> and ARM64, this results in the use of #ifdef's in this file when

Nit: greengrocer's apostrophe -- you can say "use of ifdeferry" to clean
that up.

> setting/testing for the EVTSTRM hwcap.
> 
> Let's improve readability by extracting this to an arch helper.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/arm/include/asm/arch_timer.h    | 13 +++++++++++++
>  arch/arm64/include/asm/arch_timer.h  | 13 +++++++++++++
>  drivers/clocksource/arm_arch_timer.c | 15 ++-------------
>  3 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 0a8d7bba2cb0..f21e038dc9f3 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -4,6 +4,7 @@
>  
>  #include <asm/barrier.h>
>  #include <asm/errno.h>
> +#include <asm/hwcap.h>
>  #include <linux/clocksource.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
> @@ -110,6 +111,18 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
>  	isb();
>  }
>  
> +static inline bool arch_timer_set_evtstrm_feature(void)
> +{
> +	elf_hwcap |= HWCAP_EVTSTRM;
> +#ifdef CONFIG_COMPAT
> +	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
> +#endif

This can go; 32-bit arm doesn't have COMPAT.

Otherwise, this looks good to me, so with those changes:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> +}
> +
> +static inline bool arch_timer_have_evtstrm_feature(void)
> +{
> +	return elf_hwcap & HWCAP_EVTSTRM;
> +}
>  #endif
>  
>  #endif
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index f2a234d6516c..f371d4a94f06 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -20,6 +20,7 @@
>  #define __ASM_ARCH_TIMER_H
>  
>  #include <asm/barrier.h>
> +#include <asm/hwcap.h>
>  #include <asm/sysreg.h>
>  
>  #include <linux/bug.h>
> @@ -165,4 +166,16 @@ static inline int arch_timer_arch_init(void)
>  	return 0;
>  }
>  
> +static inline void arch_timer_set_evtstrm_feature(void)
> +{
> +	cpu_set_named_feature(EVTSTRM);
> +#ifdef CONFIG_COMPAT
> +	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
> +#endif
> +}
> +
> +static inline bool arch_timer_have_evtstrm_feature(void)
> +{
> +	return cpu_have_named_feature(EVTSTRM);
> +}
>  #endif
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 6cc8aff83805..5e507e81515f 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -833,14 +833,7 @@ static void arch_timer_evtstrm_enable(int divider)
>  	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
>  			| ARCH_TIMER_VIRT_EVT_EN;
>  	arch_timer_set_cntkctl(cntkctl);
> -#ifdef CONFIG_ARM64
> -	cpu_set_named_feature(EVTSTRM);
> -#else
> -	elf_hwcap |= HWCAP_EVTSTRM;
> -#endif
> -#ifdef CONFIG_COMPAT
> -	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
> -#endif
> +	arch_timer_set_evtstrm_feature();
>  	cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
>  }
>  
> @@ -1059,11 +1052,7 @@ static int arch_timer_cpu_pm_notify(struct notifier_block *self,
>  	} else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT) {
>  		arch_timer_set_cntkctl(__this_cpu_read(saved_cntkctl));
>  
> -#ifdef CONFIG_ARM64
> -		if (cpu_have_named_feature(EVTSTRM))
> -#else
> -		if (elf_hwcap & HWCAP_EVTSTRM)
> -#endif
> +		if (arch_timer_have_evtstrm_feature())
>  			cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
>  	}
>  	return NOTIFY_OK;
> -- 
> 2.21.0
> 
