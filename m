Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D803C34991
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE131246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfLMLsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 06:48:23 -0500
Received: from foss.arm.com ([217.140.110.172]:56292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfLMLsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 06:48:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ED401045;
        Fri, 13 Dec 2019 03:48:22 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AD1B3F718;
        Fri, 13 Dec 2019 03:48:20 -0800 (PST)
Subject: Re: [PATCH v2] sched/fair: Optimize select_idle_cpu
To:     Cheng Jian <cj.chengjian@huawei.com>, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     chenwandun@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        huawei.libin@huawei.com, bobo.shaobowang@huawei.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
References: <20191213024530.28052-1-cj.chengjian@huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ac11014d-ffc9-f0b2-3d48-2456c1c5edfa@arm.com>
Date:   Fri, 13 Dec 2019 11:48:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191213024530.28052-1-cj.chengjian@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2019 02:45, Cheng Jian wrote:
> select_idle_cpu() will scan the LLC domain for idle CPUs,
> it's always expensive. so the next commit :
> 
> 	1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")
> 
> introduces a way to limit how many CPUs we scan.
> 
> But it consume some CPUs out of 'nr' that are not allowed
> for the task and thus waste our attempts. The function
> always return nr_cpumask_bits, and we can't find a CPU
> which our task is allowed to run.
> 
> Cpumask may be too big, similar to select_idle_core(), use
> per_cpu_ptr 'select_idle_mask' to prevent stack overflow.
> 
> Fixes: 1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
>  kernel/sched/fair.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..d48244388ce9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5828,6 +5828,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
>   */
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
>  {
> +	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>  	struct sched_domain *this_sd;
>  	u64 avg_cost, avg_idle;
>  	u64 time, cost;
> @@ -5859,11 +5860,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  
>  	time = cpu_clock(this);
>  
> -	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +
> +	for_each_cpu_wrap(cpu, cpus, target) {
>  		if (!--nr)
>  			return si_cpu;
> -		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> -			continue;
>  		if (available_idle_cpu(cpu))
>  			break;
>  		if (si_cpu == -1 && sched_idle_cpu(cpu))
> 
