Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B850C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6F520663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfLLPoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:44:30 -0500
Received: from foss.arm.com ([217.140.110.172]:51206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbfLLPo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:44:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E55B530E;
        Thu, 12 Dec 2019 07:44:28 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93E793F6CF;
        Thu, 12 Dec 2019 07:44:27 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Optimize select_idle_cpu
To:     Peter Zijlstra <peterz@infradead.org>,
        Cheng Jian <cj.chengjian@huawei.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        chenwandun@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        huawei.libin@huawei.com, bobo.shaobowang@huawei.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
References: <20191212144102.181510-1-cj.chengjian@huawei.com>
 <20191212152406.GB2827@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <2498b792-8549-5ffd-0d85-179740e356a0@arm.com>
Date:   Thu, 12 Dec 2019 15:44:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191212152406.GB2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2019 15:24, Peter Zijlstra wrote:
> On Thu, Dec 12, 2019 at 10:41:02PM +0800, Cheng Jian wrote:
> 
>> Fixes: 1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")
> 
> The 'funny' thing is that select_idle_core() actually does the right
> thing.
> 
> Copying that should work:
> 
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..416d574dcebf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5828,6 +5837,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
>   */
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
>  {
> +	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>  	struct sched_domain *this_sd;
>  	u64 avg_cost, avg_idle;
>  	u64 time, cost;
> @@ -5859,11 +5869,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
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

That looks sane enough. I'd only argue the changelog should directly point
out that the issue is we consume some CPUs out of 'nr' that are not allowed
for the task and thus waste our attempts.
