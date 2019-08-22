Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268A9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC0A206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbfHVQkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:40:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732772AbfHVQkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:40:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A2FF76325640AF5DDC2F;
        Fri, 23 Aug 2019 00:40:01 +0800 (CST)
Received: from localhost (10.227.98.71) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019
 00:39:56 +0800
Date:   Fri, 23 Aug 2019 00:39:45 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Raphael Gault <raphael.gault@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <raph.gault+kdev@gmail.com>, <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <acme@kernel.org>, <mingo@redhat.com>
Subject: Re: [PATCH v4 6/7] arm64: perf: Enable pmu counter direct access
 for perf event on armv8
Message-ID: <20190823003945.00004a69@huawei.com>
In-Reply-To: <20190822144220.27860-7-raphael.gault@arm.com>
References: <20190822144220.27860-1-raphael.gault@arm.com>
        <20190822144220.27860-7-raphael.gault@arm.com>
Organization: Huawei R&D UK Ltd.
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.98.71]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 15:42:19 +0100
Raphael Gault <raphael.gault@arm.com> wrote:

> Keep track of event opened with direct access to the hardware counters
> and modify permissions while they are open.
> 
> The strategy used here is the same which x86 uses: everytime an event
> is mapped, the permissions are set if required. The atomic field added
> in the mm_context helps keep track of the different event opened and
> de-activate the permissions when all are unmapped.
> We also need to update the permissions in the context switch code so
> that tasks keep the right permissions.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>

Hi Raphael,

One trivial comment inline.

Thanks,

Jonathan


> ---
>  arch/arm64/include/asm/mmu.h         |  6 ++++
>  arch/arm64/include/asm/mmu_context.h |  2 ++
>  arch/arm64/include/asm/perf_event.h  | 14 ++++++++
>  arch/arm64/kernel/perf_event.c       |  1 +
>  drivers/perf/arm_pmu.c               | 54 ++++++++++++++++++++++++++++
>  5 files changed, 77 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index fd6161336653..88ed4466bd06 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -18,6 +18,12 @@
>  
>  typedef struct {
>  	atomic64_t	id;
> +
> +	/*
> +	 * non-zero if userspace have access to hardware
> +	 * counters directly.
> +	 */
> +	atomic_t	pmu_direct_access;
>  	void		*vdso;
>  	unsigned long	flags;
>  } mm_context_t;
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 7ed0adb187a8..6e66ff940494 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -21,6 +21,7 @@
>  #include <asm-generic/mm_hooks.h>
>  #include <asm/cputype.h>
>  #include <asm/pgtable.h>
> +#include <asm/perf_event.h>
>  #include <asm/sysreg.h>
>  #include <asm/tlbflush.h>
>  
> @@ -224,6 +225,7 @@ static inline void __switch_mm(struct mm_struct *next)
>  	}
>  
>  	check_and_switch_context(next, cpu);
> +	perf_switch_user_access(next);
>  }
>  
>  static inline void
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> index 2bdbc79bbd01..ba58fa726631 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -8,6 +8,7 @@
>  
>  #include <asm/stack_pointer.h>
>  #include <asm/ptrace.h>
> +#include <linux/mm_types.h>
>  
>  #define	ARMV8_PMU_MAX_COUNTERS	32
>  #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
> @@ -223,4 +224,17 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
>  	(regs)->pstate = PSR_MODE_EL1h;	\
>  }
>  
> +static inline void perf_switch_user_access(struct mm_struct *mm)
> +{
> +	if (!IS_ENABLED(CONFIG_PERF_EVENTS))
> +		return;
> +
> +	if (atomic_read(&mm->context.pmu_direct_access)) {
> +		write_sysreg(ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR,
> +			     pmuserenr_el0);
> +	} else {
> +		write_sysreg(0, pmuserenr_el0);
> +	}
> +}
> +
>  #endif
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index de9b001e8b7c..7de56f22d038 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1285,6 +1285,7 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	 */
>  	freq = arch_timer_get_rate();
>  	userpg->cap_user_time = 1;
> +	userpg->cap_user_rdpmc = !!(event->hw.flags & ARMPMU_EL0_RD_CNTR);
>  
>  	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
>  			NSEC_PER_SEC, 0);
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 2d06b8095a19..d0d3e523a4c4 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -25,6 +25,7 @@
>  #include <linux/irqdesc.h>
>  
>  #include <asm/irq_regs.h>
> +#include <asm/mmu_context.h>
>  
>  static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
>  static DEFINE_PER_CPU(int, cpu_irq);
> @@ -778,6 +779,57 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
>  					    &cpu_pmu->node);
>  }
>  
> +static void refresh_pmuserenr(void *mm)
> +{
> +	perf_switch_user_access(mm);
> +}
> +
> +static int check_homogeneous_cap(struct perf_event *event, struct mm_struct *mm)
> +{
> +	pr_info("checking HAS_HOMOGENEOUS_PMU");

Can we drop this spam from the good path.  Makes a bit of a mess of my
terminal when running the test ;)

> +	if (!cpus_have_cap(ARM64_HAS_HOMOGENEOUS_PMU)) {
> +		pr_info("Disable direct access (!HAS_HOMOGENEOUS_PMU)");
> +		atomic_set(&mm->context.pmu_direct_access, 0);
> +		on_each_cpu(refresh_pmuserenr, mm, 1);
> +		event->hw.flags &= ~ARMPMU_EL0_RD_CNTR;
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static void armpmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> +		return;
> +
> +	/*
> +	 * This function relies on not being called concurrently in two
> +	 * tasks in the same mm.  Otherwise one task could observe
> +	 * pmu_direct_access > 1 and return all the way back to
> +	 * userspace with user access disabled while another task is still
> +	 * doing on_each_cpu_mask() to enable user access.
> +	 *
> +	 * For now, this can't happen because all callers hold mmap_sem
> +	 * for write.  If this changes, we'll need a different solution.
> +	 */
> +	lockdep_assert_held_write(&mm->mmap_sem);
> +
> +	if (check_homogeneous_cap(event, mm) &&
> +	    atomic_inc_return(&mm->context.pmu_direct_access) == 1)
> +		on_each_cpu(refresh_pmuserenr, mm, 1);
> +}
> +
> +static void armpmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> +		return;
> +
> +	if (check_homogeneous_cap(event, mm) &&
> +	    atomic_dec_and_test(&mm->context.pmu_direct_access))
> +		on_each_cpu_mask(mm_cpumask(mm), refresh_pmuserenr, NULL, 1);
> +}
> +
>  static struct arm_pmu *__armpmu_alloc(gfp_t flags)
>  {
>  	struct arm_pmu *pmu;
> @@ -799,6 +851,8 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
>  		.pmu_enable	= armpmu_enable,
>  		.pmu_disable	= armpmu_disable,
>  		.event_init	= armpmu_event_init,
> +		.event_mapped	= armpmu_event_mapped,
> +		.event_unmapped	= armpmu_event_unmapped,
>  		.add		= armpmu_add,
>  		.del		= armpmu_del,
>  		.start		= armpmu_start,


