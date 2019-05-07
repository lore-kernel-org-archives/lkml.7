Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A3CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97847205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfEGP5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:57:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58270 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfEGP5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:57:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8898A374;
        Tue,  7 May 2019 08:57:38 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08F583F5AF;
        Tue,  7 May 2019 08:57:35 -0700 (PDT)
Date:   Tue, 7 May 2019 16:57:34 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Luca Abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 6/6] sched/dl: Try not to select a too fast core
Message-ID: <20190507155732.7ravrnld54rb6k5a@queper01-lin>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-7-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506044836.2914-7-luca.abeni@santannapisa.it>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 May 2019 at 06:48:36 (+0200), Luca Abeni wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> When a task can fit on multiple CPU cores, try to select the slowest
> core that is able to properly serve the task. This avoids useless
> future migrations, leaving the "fast cores" idle for more heavyweight
> tasks.

But only if the _current_ capacity of big CPUs (at the current freq) is
higher than the current capacity of the littles, is that right ? So we
don't really have a guarantee to pack small tasks on little cores ...

What is the rationale for looking at the current freq in dl_task_fit() ?
Energy reasons ? If so, I'd argue you should look at the energy model to
break the tie between CPU candidates ... ;)

And in the mean time, you could just look at arch_scale_cpu_capacity()
to check if a task fits ?

> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> ---
>  kernel/sched/cpudeadline.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index 2a4ac7b529b7..897ed71af515 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -143,17 +143,24 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>  	       struct cpumask *later_mask)
>  {
>  	const struct sched_dl_entity *dl_se = &p->dl;
> +	struct cpumask tmp_mask;

Hmm, these can get pretty big, so not sure about having one on the stack ...

>  
>  	if (later_mask &&
> -	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_allowed)) {
> +	    cpumask_and(&tmp_mask, cp->free_cpus, &p->cpus_allowed)) {
>  		int cpu, max_cpu = -1;
> -		u64 max_cap = 0;
> +		u64 max_cap = 0, min_cap = SCHED_CAPACITY_SCALE * SCHED_CAPACITY_SCALE;
>  
> -		for_each_cpu(cpu, later_mask) {
> +		cpumask_clear(later_mask);
> +		for_each_cpu(cpu, &tmp_mask) {
>  			u64 cap;
>  
> -			if (!dl_task_fit(&p->dl, cpu, &cap))
> -				cpumask_clear_cpu(cpu, later_mask);
> +			if (dl_task_fit(&p->dl, cpu, &cap) && (cap <= min_cap)) {
> +				if (cap < min_cap) {
> +					min_cap = cap;
> +					cpumask_clear(later_mask);
> +				}
> +				cpumask_set_cpu(cpu, later_mask);
> +			}
>  
>  			if (cap > max_cap) {
>  				max_cap = cap;
> -- 
> 2.20.1
> 

Thanks,
Quentin
