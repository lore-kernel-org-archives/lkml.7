Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2380C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62B720663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfLQMyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:54:32 -0500
Received: from foss.arm.com ([217.140.110.172]:36206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbfLQMyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:54:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1C7931B;
        Tue, 17 Dec 2019 04:54:31 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C397F3F719;
        Tue, 17 Dec 2019 04:54:29 -0800 (PST)
Subject: Re: [Patch v6 3/7] Add infrastructure to store and update
 instantaneous thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-4-git-send-email-thara.gopinath@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <3ca440af-c459-3b23-64c3-0292b1106594@arm.com>
Date:   Tue, 17 Dec 2019 13:54:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576123908-12105-4-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2019 05:11, Thara Gopinath wrote:

Shouldn't the subject contain something like 'arm,arm64,drivers:' ?

> Add architecture specific APIs to update and track thermal pressure on a
> per cpu basis. A per cpu variable thermal_pressure is introduced to keep
> track of instantaneous per cpu thermal pressure. Thermal pressure is the
> delta between maximum capacity and capped capacity due to a thermal event.
> capacity and capped capacity due to a thermal event.
> 
> topology_get_thermal_pressure can be hooked into the scheduler specified
> arch_scale_thermal_capacity to retrieve instantaneius thermal pressure of

s/instantaneius/instantaneous

> a cpu.
> 
> arch_set_thermal_presure can be used to update the thermal pressure by

s/presure/pressure

> providing a capped maximum capacity.
> 
> Considering topology_get_thermal_pressure reads thermal_pressure and
> arch_set_thermal_pressure writes into thermal_pressure, one can argue for
> some sort of locking mechanism to avoid a stale value.  But considering
> topology_get_thermal_pressure_average can be called from a system critical

s/topology_get_thermal_pressure_average/topology_get_thermal_pressure ?

> path like scheduler tick function, a locking mechanism is not ideal. This
> means that it is possible the thermal_pressure value used to calculate
> average thermal pressure for a cpu can be stale for upto 1 tick period.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v3->v4:
>         - Dropped per cpu max_capacity_info struct and instead added a per
>           delta_capacity variable to store the delta between maximum
>           capacity and capped capacity. The delta is now calculated when
>           thermal pressure is updated and not every tick.
>         - Dropped populate_max_capacity_info api as only per cpu delta
>           capacity is stored.
>         - Renamed update_periodic_maxcap to
>           trigger_thermal_pressure_average and update_maxcap_capacity to
>           update_thermal_pressure.
> v4->v5:
> 	- As per Peter's review comments folded thermal.c into fair.c.
> 	- As per Ionela's review comments revamped update_thermal_pressure
> 	  to take maximum available capacity as input instead of maximum
> 	  capped frequency ration.
> v5->v6:
> 	- As per review comments moved all the infrastructure to track
> 	  and retrieve instantaneous thermal pressure out of scheduler
> 	  to topology files.
> 
>  arch/arm/include/asm/topology.h   |  3 +++
>  arch/arm64/include/asm/topology.h |  3 +++
>  drivers/base/arch_topology.c      | 13 +++++++++++++
>  include/linux/arch_topology.h     | 11 +++++++++++
>  4 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 8a0fae9..90b18c3 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -16,6 +16,9 @@
>  /* Enable topology flag updates */
>  #define arch_update_cpu_topology topology_update_cpu_topology
>  
> +/* Replace task scheduler's defalut thermal pressure retrieve API */
> +#define arch_scale_thermal_capacity topology_get_thermal_pressure
> +
>  #else
>  
>  static inline void init_cpu_topology(void) { }
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index a4d945d..ccb277b 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -25,6 +25,9 @@ int pcibus_to_node(struct pci_bus *bus);
>  /* Enable topology flag updates */
>  #define arch_update_cpu_topology topology_update_cpu_topology
>  
> +/* Replace task scheduler's defalut thermal pressure retrieve API */
> +#define arch_scale_thermal_capacity topology_get_thermal_pressure
> +
>  #include <asm-generic/topology.h>
>  
>  #endif /* _ASM_ARM_TOPOLOGY_H */
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 1eb81f11..3a91379 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -42,6 +42,19 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>  	per_cpu(cpu_scale, cpu) = capacity;
>  }
>  
> +DEFINE_PER_CPU(unsigned long, thermal_pressure);
> +
> +void arch_set_thermal_pressure(struct cpumask *cpus,
> +			       unsigned long capped_capacity)
> +{
> +	int cpu;
> +	unsigned long delta = arch_scale_cpu_capacity(cpumask_first(cpus)) -
> +					capped_capacity;

 unsigned long delta;
 int cpu;

 delta = arch_scale_cpu_capacity(cpumask_first(cpus)) - capped_capacity;

Easier to read plus order local variable declarations from longest to
shortest line.

https://lore.kernel.org/r/20181107171149.165693799@linutronix.de

> +
> +	for_each_cpu(cpu, cpus)
> +		WRITE_ONCE(per_cpu(thermal_pressure, cpu), delta);
> +}
> +
>  static ssize_t cpu_capacity_show(struct device *dev,
>  				 struct device_attribute *attr,
>  				 char *buf)
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 3015ecb..7a04364 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -33,6 +33,17 @@ unsigned long topology_get_freq_scale(int cpu)
>  	return per_cpu(freq_scale, cpu);
>  }
>  
> +DECLARE_PER_CPU(unsigned long, thermal_pressure);
> +
> +static inline
> +unsigned long topology_get_thermal_pressure(int cpu)

Save one line:

static inline unsigned long topology_get_thermal_pressure(int cpu)

> +{
> +	return per_cpu(thermal_pressure, cpu);
> +}
> +
> +void arch_set_thermal_pressure(struct cpumask *cpus,
> +			       unsigned long capped_capacity);
> +
>  struct cpu_topology {
>  	int thread_id;
>  	int core_id;
> 
