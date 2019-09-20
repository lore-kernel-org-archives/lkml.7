Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1584C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA65A21928
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TvdMtOJy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="glf8992B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437103AbfITDCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 23:02:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405830AbfITDCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 23:02:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 252AD613A8; Fri, 20 Sep 2019 03:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568948544;
        bh=QIJWG6caLaWwd5v0ncOFpPPGx8GXJqON0TsfQqoQpAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TvdMtOJy5shV2RGoR6nG5lm8yI26T8CtpMfBA/b5FYDRNFcTFYqRHjg9PAhZ2qd0A
         /fIb/A2VSFDgSpEav5K8wWkw5aQ4X1n0ElJEv187sgca1V86OYhD4WyxtbdWbwVzai
         RqDVf0I7UuYp3lIbVZU7gVnuDRqeD8aYyWkTFCQc=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29F8360735;
        Fri, 20 Sep 2019 03:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568948543;
        bh=QIJWG6caLaWwd5v0ncOFpPPGx8GXJqON0TsfQqoQpAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glf8992BlH0H9MnIHQ0KWiCJMQZfvd+6Eu74U8BOMBHNwj0WoSoOnRbwQILnMGgbc
         qH2Rs1h7YzIfJ2f3We9gNDko3eIY0zEIZje7CZBDoPJ9HPkpsxMXXhf0yX9JywwKiC
         dYFOhJLKOgyinPTSugX7IxUnQtCEDn9qKwRAi3dA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29F8360735
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Fri, 20 Sep 2019 08:32:15 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Quentin Perret <qperret@qperret.net>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com, rjw@rjwysocki.net,
        morten.rasmussen@arm.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, tkjos@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Speed-up energy-aware wake-ups
Message-ID: <20190920030215.GA20250@codeaurora.org>
References: <20190912094404.13802-1-qperret@qperret.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912094404.13802-1-qperret@qperret.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Thu, Sep 12, 2019 at 11:44:04AM +0200, Quentin Perret wrote:
> From: Quentin Perret <quentin.perret@arm.com>
> 
> EAS computes the energy impact of migrating a waking task when deciding
> on which CPU it should run. However, the current approach is known to
> have a high algorithmic complexity, which can result in prohibitively
> high wake-up latencies on systems with complex energy models, such as
> systems with per-CPU DVFS. On such systems, the algorithm complexity is
> in O(n^2) (ignoring the cost of searching for performance states in the
> EM) with 'n' the number of CPUs.
> 
> To address this, re-factor the EAS wake-up path to compute the energy
> 'delta' (with and without the task) on a per-performance domain basis,
> rather than system-wide, which brings the complexity down to O(n).
> 
> No functional changes intended.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
>  

[snip]

>  /*
> @@ -6381,21 +6367,19 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>   * other use-cases too. So, until someone finds a better way to solve this,
>   * let's keep things simple by re-using the existing slow path.
>   */
> -
>  static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  {
> -	unsigned long prev_energy = ULONG_MAX, best_energy = ULONG_MAX;
> +	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
>  	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
> +	unsigned long cpu_cap, util, base_energy = 0;
>  	int cpu, best_energy_cpu = prev_cpu;
> -	struct perf_domain *head, *pd;
> -	unsigned long cpu_cap, util;
>  	struct sched_domain *sd;
> +	struct perf_domain *pd;
>  
>  	rcu_read_lock();
>  	pd = rcu_dereference(rd->pd);
>  	if (!pd || READ_ONCE(rd->overutilized))
>  		goto fail;
> -	head = pd;
>  
>  	/*
>  	 * Energy-aware wake-up happens on the lowest sched_domain starting
> @@ -6412,9 +6396,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		goto unlock;
>  
>  	for (; pd; pd = pd->next) {
> -		unsigned long cur_energy, spare_cap, max_spare_cap = 0;
> +		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
> +		unsigned long base_energy_pd;
>  		int max_spare_cap_cpu = -1;
>  
> +		/* Compute the 'base' energy of the pd, without @p */
> +		base_energy_pd = compute_energy(p, -1, pd);
> +		base_energy += base_energy_pd;
> +
>  		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
>  			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>  				continue;
> @@ -6427,9 +6416,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  
>  			/* Always use prev_cpu as a candidate. */
>  			if (cpu == prev_cpu) {
> -				prev_energy = compute_energy(p, prev_cpu, head);
> -				best_energy = min(best_energy, prev_energy);
> -				continue;
> +				prev_delta = compute_energy(p, prev_cpu, pd);
> +				prev_delta -= base_energy_pd;
> +				best_delta = min(best_delta, prev_delta);
>  			}

Earlier, we are not checking the spare capacity for the prev_cpu. Now that the
continue statement is removed, prev_cpu could also be the max_spare_cap_cpu.
Actually that makes sense. Because there is no reason why we want to select
another CPU which has less spare capacity than previous CPU.

Is this behavior intentional?

When prev_cpu == max_spare_cap_cpu, we are evaluating the energy again for the
same CPU below. That could have been skipped by returning prev_cpu when
prev_cpu == max_spare_cap_cpu.

>  
>  			/*
> @@ -6445,9 +6434,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  
>  		/* Evaluate the energy impact of using this CPU. */
>  		if (max_spare_cap_cpu >= 0) {
> -			cur_energy = compute_energy(p, max_spare_cap_cpu, head);
> -			if (cur_energy < best_energy) {
> -				best_energy = cur_energy;
> +			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
> +			cur_delta -= base_energy_pd;
> +			if (cur_delta < best_delta) {
> +				best_delta = cur_delta;
>  				best_energy_cpu = max_spare_cap_cpu;
>  			}
>  		}
> @@ -6459,10 +6449,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
>  	 * least 6% of the energy used by prev_cpu.
>  	 */
> -	if (prev_energy == ULONG_MAX)
> +	if (prev_delta == ULONG_MAX)
>  		return best_energy_cpu;
>  
> -	if ((prev_energy - best_energy) > (prev_energy >> 4))
> +	if ((prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
>  		return best_energy_cpu;
>  
>  	return prev_cpu;
> -- 
> 2.22.1
> 

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

