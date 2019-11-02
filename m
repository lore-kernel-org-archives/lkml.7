Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14996CA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72E2208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfKBAQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 20:16:10 -0400
Received: from foss.arm.com ([217.140.110.172]:43092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfKBAQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:16:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B23711FB;
        Fri,  1 Nov 2019 17:16:09 -0700 (PDT)
Received: from [192.168.1.46] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C7B23F719;
        Fri,  1 Nov 2019 17:16:08 -0700 (PDT)
Subject: Re: [GIT PULL] scheduler fixes
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20191101175508.GA125660@gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <99326811-b88f-6748-2675-a97460dac678@arm.com>
Date:   Sat, 2 Nov 2019 01:15:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101175508.GA125660@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/11/2019 18:55, Ingo Molnar wrote:
> Linus,
> 
> Please pull the latest sched-urgent-for-linus git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus
> 
>    # HEAD: e284df705cf1eeedb5ec3a66ed82d17a64659150 sched/topology: Allow sched_asym_cpucapacity to be disabled
> 
> Fix two scheduler topology bugs/oversights on Juno r0 2+4 big.LITTLE 
> systems.
>

I was hoping to fix this up before the PR got out, but as I've been traveling
that didn't happen. FWIW Michal spotted that the empty cpumask fix is not
complete, it also needs to check against the housekeeping cpumask. I've done
that at 20191102001406.10208-1-valentin.schneider@arm.com.

Sorry about that,
Valentin
 
>  Thanks,
> 
> 	Ingo
> 
> ------------------>
> Valentin Schneider (2):
>       sched/topology: Don't try to build empty sched domains
>       sched/topology: Allow sched_asym_cpucapacity to be disabled
> 
> 
>  kernel/cgroup/cpuset.c  |  3 ++-
>  kernel/sched/topology.c | 11 +++++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c52bc91f882b..c87ee6412b36 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -798,7 +798,8 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
>  			continue;
>  
> -		if (is_sched_load_balance(cp))
> +		if (is_sched_load_balance(cp) &&
> +		    !cpumask_empty(cp->effective_cpus))
>  			csa[csn++] = cp;
>  
>  		/* skip @cp's subtree if not a partition root */
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b5667a273bf6..49b835f1305f 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1948,7 +1948,7 @@ static struct sched_domain_topology_level
>  static int
>  build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *attr)
>  {
> -	enum s_alloc alloc_state;
> +	enum s_alloc alloc_state = sa_none;
>  	struct sched_domain *sd;
>  	struct s_data d;
>  	struct rq *rq = NULL;
> @@ -1956,6 +1956,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  	struct sched_domain_topology_level *tl_asym;
>  	bool has_asym = false;
>  
> +	if (WARN_ON(cpumask_empty(cpu_map)))
> +		goto error;
> +
>  	alloc_state = __visit_domain_allocation_hell(&d, cpu_map);
>  	if (alloc_state != sa_rootdomain)
>  		goto error;
> @@ -2026,7 +2029,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  	rcu_read_unlock();
>  
>  	if (has_asym)
> -		static_branch_enable_cpuslocked(&sched_asym_cpucapacity);
> +		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
>  
>  	if (rq && sched_debug_enabled) {
>  		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
> @@ -2121,8 +2124,12 @@ int sched_init_domains(const struct cpumask *cpu_map)
>   */
>  static void detach_destroy_domains(const struct cpumask *cpu_map)
>  {
> +	unsigned int cpu = cpumask_any(cpu_map);
>  	int i;
>  
> +	if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, cpu)))
> +		static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
> +
>  	rcu_read_lock();
>  	for_each_cpu(i, cpu_map)
>  		cpu_attach_domain(NULL, &def_root_domain, i);
> 
