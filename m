Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2519C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 16:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92984206E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 16:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfLaQlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 11:41:04 -0500
Received: from foss.arm.com ([217.140.110.172]:35818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfLaQlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 11:41:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AAF2328;
        Tue, 31 Dec 2019 08:41:03 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C23C3F68F;
        Tue, 31 Dec 2019 08:41:02 -0800 (PST)
Date:   Tue, 31 Dec 2019 16:40:51 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     z00214469 <prime.zeng@hisilicon.com>
Cc:     linuxarm@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
Message-ID: <20191231164051.GA4864@bogus>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 04:16:19PM +0800, z00214469 wrote:
> As we know, from sched domain's perspective, the DIE layer should be
> larger than or at least equal to the MC layer, and in some cases, MC
> is defined by the arch specified hardware, MPIDR for example, but NUMA
> can be defined by users,

Who are the users you are referring above ?

> with the following system configrations:

Do you mean ACPI tables or DT or some firmware tables ?

> *************************************
> NUMA:      	 0-2,  3-7

Is the above simply wrong with respect to hardware and it actually match
core_siblings ?

> core_siblings:   0-3,  4-7
> *************************************
> Per the current code, for core 3, its MC cpu map fallbacks to 3~7(its
> core_sibings is 0~3 while its numa node map is 3~7).
>
> For the sched MC, when we are build sched groups:
> step1. core3 's sched groups chain is built like this: 3->4->5->6->7->3
> step2. core4's sched groups chain is built like this: 4->5->6->7->4
> so after step2, core3's sched groups for MC level is overlapped, more
> importantly, it will fall to dead loop if while(sg != sg->groups)
>
> Obviously, the NUMA node with cpu 3-7 conflict with the MC level cpu
> map, but unfortunately, there is no way even detect such cases.
>

Again, is cpu 3-7 actually in a NUMA node or is it 4-7 ?

> In this patch, prompt a warning message to help with the above cases.
>
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> ---
>  drivers/base/arch_topology.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 1eb81f11..5fe44b3 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -439,10 +439,18 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
>  	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
>  		/* not numa in package, lets use the package siblings */
>  		core_mask = &cpu_topology[cpu].core_sibling;
> -	}
> +	} else
> +		pr_warn_once("Warning: suspicous broken topology: cpu:[%d]'s core_sibling:[%*pbl] not a subset of numa node:[%*pbl]\n",
> +			cpu, cpumask_pr_args(&cpu_topology[cpu].core_sibling),
> +			cpumask_pr_args(core_mask));
> +

Won't this print warning on all systems that don't have numa within a
package ? What are you trying to achieve here ?

>  	if (cpu_topology[cpu].llc_id != -1) {
>  		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
>  			core_mask = &cpu_topology[cpu].llc_sibling;
> +		else
> +			pr_warn_once("Warning: suspicous broken topology: cpu:[%d]'s llc_sibling:[%*pbl] not a subset of numa node:[%*pbl]\n",
> +				cpu, cpumask_pr_args(&cpu_topology[cpu].llc_sibling),
> +				cpumask_pr_args(core_mask));
>  	}
>

This will trigger warning on all systems that lack cacheinfo topology.
I don't understand the intent of this patch at all. Can you explain
all the steps you follow and the issue you face ?

--
Regards,
Sudeep
