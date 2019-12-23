Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA49C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C98520709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLWRuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:50:23 -0500
Received: from foss.arm.com ([217.140.110.172]:47474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfLWRuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:50:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52FCF1FB;
        Mon, 23 Dec 2019 09:50:22 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E55103F68F;
        Mon, 23 Dec 2019 09:50:21 -0800 (PST)
Date:   Mon, 23 Dec 2019 17:50:20 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
Subject: Re: [Patch v6 3/7] Add infrastructure to store and update
 instantaneous thermal pressure
Message-ID: <20191223175005.GA31446@arm.com>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-4-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576123908-12105-4-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On Wednesday 11 Dec 2019 at 23:11:44 (-0500), Thara Gopinath wrote:
> Add architecture specific APIs to update and track thermal pressure on a
> per cpu basis. A per cpu variable thermal_pressure is introduced to keep
> track of instantaneous per cpu thermal pressure. Thermal pressure is the
> delta between maximum capacity and capped capacity due to a thermal event.
> capacity and capped capacity due to a thermal event.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This line seems to be a duplicate (initially I thought I was seeing
double :) ).

> topology_get_thermal_pressure can be hooked into the scheduler specified
> arch_scale_thermal_capacity to retrieve instantaneius thermal pressure of
> a cpu.
> 
> arch_set_thermal_presure can be used to update the thermal pressure by
> providing a capped maximum capacity.
> 
> Considering topology_get_thermal_pressure reads thermal_pressure and
> arch_set_thermal_pressure writes into thermal_pressure, one can argue for
> some sort of locking mechanism to avoid a stale value.  But considering
> topology_get_thermal_pressure_average can be called from a system critical
> path like scheduler tick function, a locking mechanism is not ideal. This
> means that it is possible the thermal_pressure value used to calculate
> average thermal pressure for a cpu can be stale for upto 1 tick period.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
[...]
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 8a0fae9..90b18c3 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -16,6 +16,9 @@
>  /* Enable topology flag updates */
>  #define arch_update_cpu_topology topology_update_cpu_topology
>  
> +/* Replace task scheduler's defalut thermal pressure retrieve API */

s/defalut/default

> +#define arch_scale_thermal_capacity topology_get_thermal_pressure
> +

I also think this is deserving of a better name. I would drop the
'scale' part as well as it is not used as a scale factor, as
freq_scale or cpu_scale, but it's used as a reduction in capacity
(thermal capacity pressure) due to a thermal event.

It might be too much but what do you think about:
arch_thermal_capacity_pressure?

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

s/defalut/default

Regards,
Ionela.
