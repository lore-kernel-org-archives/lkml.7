Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC8CC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F010207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="GfglRue7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKXVr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 16:47:56 -0500
Received: from vps.xff.cz ([195.181.215.36]:36380 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfKXVr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 16:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1574632074; bh=IZEcZzNojMW/keCmXCxQjtc5wyYGsTDFt5MlSAapC9Y=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=GfglRue7uwETC5CEbDlnWahlk/AUN4eTE7nLtpf0IuOh33AfEKARxnkypN0af2yIj
         Re7qhtsBfEv/Zc2myJau1cflWVw8vp3Ary4XdGFRyaGTgWimQyiW2rcCPpg1aGxRSV
         6b+33oHdlmZbliFx/iQ4TceQrVS16J/7J2z1/PWc=
Date:   Sun, 24 Nov 2019 22:47:53 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] arm: Fix topology setup in case of CPU hotplug for
 CONFIG_SCHED_MC
Message-ID: <20191124214753.m6lwcdemnddltctw@core.my.home>
Mail-Followup-To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20191120104212.14791-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120104212.14791-1-dietmar.eggemann@arm.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 20, 2019 at 10:42:12AM +0000, Dietmar Eggemann wrote:
> Commit ca74b316df96 ("arm: Use common cpu_topology structure and
> functions.") changed cpu_coregroup_mask() from the ARM32 specific
> implementation in arch/arm/include/asm/topology.h to the one shared
> with ARM64 and RISCV in drivers/base/arch_topology.c.
> 
> Currently on Arm32 (TC2 w/ CONFIG_SCHED_MC) the task scheduler setup
> code (w/ CONFIG_SCHED_DEBUG) shows this during CPU hotplug:
> 
>   ERROR: groups don't span domain->span
> 
> It happens to CPUs of the cluster of the CPU which gets hot-plugged
> out on scheduler domain MC.
> 
> Turns out that the shared cpu_coregroup_mask() requires that the
> hot-plugged CPU is removed from the core_sibling mask via
> remove_cpu_topology(). Otherwise the 'is core_sibling subset of
> cpumask_of_node()' doesn't work. In this case the task scheduler has to
> deal with cpumask_of_node instead of core_sibling which is wrong on
> scheduler domain MC.
> 
> e.g. CPU3 hot-plugged out on TC2 [cluster0: 0,3-4 cluster1: 1-2]:
> 
>   cpu_coregroup_mask(): CPU3 cpumask_of_node=0-2,4 core_sibling=0,3-4
>                                                                   ^
> should be:
> 
>   cpu_coregroup_mask(): CPU3 cpumask_of_node=0-2,4 core_sibling=0,4
> 
> Add remove_cpu_topology() to __cpu_disable() to remove the CPU from the
> topology masks in case of a CPU hotplug out operation.
> 
> At the same time tweak store_cpu_topology() slightly so it will call
> update_siblings_masks() in case of CPU hotplug in operation via
> secondary_start_kernel()->smp_store_cpu_info().
> 
> This aligns the Arm32 implementation with the Arm64 one.
> 
> Fixes: ca74b316df96 ("arm: Use common cpu_topology structure and functions")
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

This fixes CPU hotplug and correspondent suspend to ram/resume failures (that
disables and re-enables non-boot CPUs) on A83T SoC, that I've seen since
5.4-rc1.

Tested-by: Ondrej Jirman <megous@megous.com>

thanks,
	o.

> ---
>  arch/arm/kernel/smp.c      |  2 ++
>  arch/arm/kernel/topology.c | 15 +++++++--------
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 4b0bab2607e4..139c0d98fa29 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -240,6 +240,8 @@ int __cpu_disable(void)
>  	if (ret)
>  		return ret;
>  
> +	remove_cpu_topology(cpu);
> +
>  	/*
>  	 * Take this CPU offline.  Once we clear this, we can't return,
>  	 * and we must not schedule until we're ready to give up the cpu.
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 5b9faba03afb..b37b0a340991 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -196,9 +196,8 @@ void store_cpu_topology(unsigned int cpuid)
>  	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
>  	unsigned int mpidr;
>  
> -	/* If the cpu topology has been already set, just return */
> -	if (cpuid_topo->core_id != -1)
> -		return;
> +	if (cpuid_topo->package_id != -1)
> +		goto topology_populated;
>  
>  	mpidr = read_cpuid_mpidr();
>  
> @@ -231,14 +230,14 @@ void store_cpu_topology(unsigned int cpuid)
>  		cpuid_topo->package_id = -1;
>  	}
>  
> -	update_siblings_masks(cpuid);
> -
>  	update_cpu_capacity(cpuid);
>  
>  	pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
> -		cpuid, cpu_topology[cpuid].thread_id,
> -		cpu_topology[cpuid].core_id,
> -		cpu_topology[cpuid].package_id, mpidr);
> +		cpuid, cpuid_topo->thread_id, cpuid_topo->core_id,
> +		cpuid_topo->package_id, mpidr);
> +
> +topology_populated:
> +	update_siblings_masks(cpuid);
>  }
>  
>  static inline int cpu_corepower_flags(void)
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
