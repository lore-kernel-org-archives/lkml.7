Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D258CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295E721734
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iVuCnOTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbfJ1NCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:02:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58120 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfJ1NCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MD08IaRMVjFfIvRAApgyfhpfS8l+L1midKNfES5kgEA=; b=iVuCnOTx3bu24bTobnX/UCxlxV
        N6hi3SNHwJSRZ7ZlcJu7AmOqwupaA2XqqnUZNUsH/5g1h/WoWnJqbpd5WffYih5nPPhGcZgA8Zkpn
        wnD8xNIb0ud5jo5VK37coPAhnv/kP5H4hcIc/lw46bATKBhSiay1/sZcYF2cRJ/4xp4Fxrk3CWuW2
        JkthbZFukVVI4T6iRh0zY4DwnHqe5DQDOmhEEbJCNnbng0uM+g0GyOm7bEFy1h2kRnqCFC2RcrKG2
        n5rKgxVYDZc2KXLlAzH2ZrbQxgAJmt4PFkWM6G1n4p+hdsfx6kEEIibemkJaVrAg53cGlD0GLvFiC
        BzBdut/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP4fC-0007Ai-Mb; Mon, 28 Oct 2019 13:02:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 17245306091;
        Mon, 28 Oct 2019 14:01:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3FB7520761E44; Mon, 28 Oct 2019 14:02:22 +0100 (CET)
Date:   Mon, 28 Oct 2019 14:02:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/numa: advanced per-cgroup numa statistic
Message-ID: <20191028130222.GM4131@hirez.programming.kicks-ass.net>
References: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 11:08:01AM +0800, 王贇 wrote:
> Currently there are no good approach to monitoring the per-cgroup
> numa efficiency, this could be a trouble especially when groups
> are sharing CPUs, it's impossible to tell which one caused the
> remote-memory access by reading hardware counter since multiple
> workloads could sharing the same CPU, which make it painful when
> one want to find out the root cause and fix the issue.
> 
> In order to address this, we introduced new per-cgroup statistic
> for numa:
>   * the numa locality to imply the numa balancing efficiency
>   * the numa execution time on each node
> 
> The task locality is the local page accessing ratio traced on numa
> balancing PF, and the group locality is the topology of task execution
> time, sectioned by the locality into 8 regions.
> 
> For example the new entry 'cpu.numa_stat' show:
>   locality 15393 21259 13023 44461 21247 17012 28496 145402
>   exectime 311900 407166
> 
> Here we know the workloads executed 311900ms on node_0 and 407166ms
> on node_1, tasks with locality around 0~12% executed for 15393 ms, and
> tasks with locality around 88~100% executed for 145402 ms, which imply
> most of the memory access is local access, for the workloads of this
> group.
> 
> By monitoring the new statistic, we will be able to know the numa
> efficiency of each per-cgroup workloads on machine, whatever they
> sharing the CPUs or not, we will be able to find out which one
> introduced the remote access mostly.
> 
> Besides, per-node memory topology from 'memory.numa_stat' become
> more useful when we have the per-node execution time, workloads
> always executing on node_0 while it's memory is all on node_1 is
> usually a bad case.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>

Mel, can you have a peek at this too?


So this is the part I like least:

> +DEFINE_PER_CPU(struct numa_stat, root_numa_stat);
> +
> +int alloc_tg_numa_stat(struct task_group *tg)
> +{
> +	tg->numa_stat = alloc_percpu(struct numa_stat);
> +	if (!tg->numa_stat)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +void free_tg_numa_stat(struct task_group *tg)
> +{
> +	free_percpu(tg->numa_stat);
> +}
> +
> +static void update_tg_numa_stat(struct task_struct *p)
> +{
> +	struct task_group *tg;
> +	unsigned long remote = p->numa_faults_locality[3];
> +	unsigned long local = p->numa_faults_locality[4];
> +	int idx = -1;
> +
> +	/* Tobe scaled? */
> +	if (remote || local)
> +		idx = NR_NL_INTERVAL * local / (remote + local + 1);
> +
> +	rcu_read_lock();
> +
> +	tg = task_group(p);
> +	while (tg) {
> +		/* skip account when there are no faults records */
> +		if (idx != -1)
> +			this_cpu_inc(tg->numa_stat->locality[idx]);
> +
> +		this_cpu_inc(tg->numa_stat->jiffies);
> +
> +		tg = tg->parent;
> +	}
> +
> +	rcu_read_unlock();
> +}

Thing is, we already have a cgroup hierarchy walk in the tick; see
task_tick_fair().

On top of that, you're walking an entirely different set of pointers,
instead of cfs_rq, you're walking tg->parent, which pretty much
guarantees you're adding even more cache misses.

How about you stick those numa_stats in cfs_rq (with cacheline
alignment) and see if you can frob your update loop into the cgroup walk
we already do.
