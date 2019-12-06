Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A2C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691BA24659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLFMAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:00:07 -0500
Received: from foss.arm.com ([217.140.110.172]:41226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfLFMAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:00:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E36231B;
        Fri,  6 Dec 2019 04:00:06 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 268B63F52E;
        Fri,  6 Dec 2019 04:00:05 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Optimize select_idle_core
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20191205172316.8198-1-srikar@linux.vnet.ibm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <6242deaa-e570-3384-0737-e49abb0599dd@arm.com>
Date:   Fri, 6 Dec 2019 12:00:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191205172316.8198-1-srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2019 17:23, Srikar Dronamraju wrote:
> Currently we loop through all threads of a core to evaluate if the core
> is idle or not. This is unnecessary. If a thread of a core is not
> idle, skip evaluating other threads of a core.
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69a81a5709ff..b9d628128cfc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5872,10 +5872,12 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>  		bool idle = true;
>  
>  		for_each_cpu(cpu, cpu_smt_mask(core)) {
> -			__cpumask_clear_cpu(cpu, cpus);
> -			if (!available_idle_cpu(cpu))
> +			if (!available_idle_cpu(cpu)) {
>  				idle = false;
> +				break;
> +			}
>  		}
> +		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
>  

That looks sensible enough to me. I do have one random thought, however.


Say you have a 4-core SMT2 system with the usual numbering scheme:

{0, 4}  {1, 5}  {2, 6}  {3, 7}
CORE0   CORE1   CORE2   CORE3


Say 'target' is the prev_cpu, in that case let's pick 5. Because we do a
for_each_cpu_wrap(), our iteration for 'core' would start with 

  5, 6, 7, ...

So say CORE2 is entirely idle and CORE1 isn't, we would go through the
inner loop on CORE1 (with 'core' == 5), then go through CORE2 (with
'core' == 6) and return 'core'. I find it a bit unusual that we wouldn't
return the first CPU in the SMT mask, usually we try to fill sched_groups
in cpumask order.


If we could have 'cpus' start with only primary CPUs, that would simplify
things methinks:

  for_each_cpu_wrap(core, cpus, target) {
	  bool idle = true;

	  for_each_cpu(cpu, cpu_smt_mask(core)) {
		  if (!available_idle_cpu(cpu)) {
			  idle = false;
			  break;
		  }

	  __cpumask_clear_cpu(core, cpus);

	  if (idle)
		  return core;


Food for thought; your change itself looks fine as it is.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>


>  		if (idle)
>  			return core;
> 
