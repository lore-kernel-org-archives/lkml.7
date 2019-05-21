Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D321C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F6D21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfEUNq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:46:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:1156 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbfEUNq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:46:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 06:46:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,495,1549958400"; 
   d="scan'208";a="174026366"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga002.fm.intel.com with ESMTP; 21 May 2019 06:46:25 -0700
Date:   Tue, 21 May 2019 21:46:46 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Aaron Lu <aaron.lu@intel.com>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [LKP] [mm] 42a3003535: will-it-scale.per_process_ops -25.9%
 regression
Message-ID: <20190521134646.GE19312@shao2-debian>
References: <20190520063534.GB19312@shao2-debian>
 <20190520215328.GA1186@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520215328.GA1186@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 05:53:28PM -0400, Johannes Weiner wrote:
> Hello,
> 
> On Mon, May 20, 2019 at 02:35:34PM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a -25.9% regression of will-it-scale.per_process_ops due to commit:
> > 
> > 
> > commit: 42a300353577ccc17ecc627b8570a89fa1678bec ("mm: memcontrol: fix recursive statistics correctness & scalabilty")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: will-it-scale
> > on test machine: 192 threads Skylake-SP with 256G memory
> > with following parameters:
> 
> Ouch. That has to be the additional cache footprint of the split
> local/recursive stat counters, rather than the extra instructions.
> 
> Could you please try re-running the test on that host with the below
> patch applied?

Hi,

The patch can fix the regression.

tests: 1
testcase/path_params/tbox_group/run: will-it-scale/performance-process-100%-page_fault3/lkp-skl-4sp1

db9adbcbe7 ("mm: memcontrol: move stat/event counting functions out-of-line")
8d8245997d ("mm: memcontrol: don't batch updates of local VM stats and events")

db9adbcbe740e098  8d8245997dbd17c5056094f15c  
----------------  --------------------------  
         %stddev      change         %stddev
             \          |                \  
  87819982                    85307742        will-it-scale.workload
    457395                      444310        will-it-scale.per_process_ops
      7275               5%       7636 ±  5%  boot-time.idle
       122                         120        turbostat.RAMWatt
       388                         392        time.voluntary_context_switches
     61093               5%      64277        proc-vmstat.nr_slab_unreclaimable
  60343904                    58838096        proc-vmstat.pgalloc_normal
  60301946                    58797053        proc-vmstat.pgfree
  60227822                    58720057        proc-vmstat.numa_hit
  60082905                    58575049        proc-vmstat.numa_local
 2.646e+10                    2.57e+10        proc-vmstat.pgfault
  94586813 ±  5%       368%  4.423e+08        perf-stat.i.iTLB-loads
  94208530 ±  5%       367%  4.403e+08        perf-stat.ps.iTLB-loads
  40821938              86%   75753326        perf-stat.i.node-loads
  40664993              85%   75428605        perf-stat.ps.node-loads
      1334               4%       1387        perf-stat.overall.instructions-per-iTLB-miss
      1341               4%       1394        perf-stat.i.instructions-per-iTLB-miss
      1414               4%       1464        perf-stat.overall.cycles-between-cache-misses
      1435               3%       1482        perf-stat.i.cycles-between-cache-misses
      1.65                        1.69        perf-stat.overall.cpi
     70.00                       70.98        perf-stat.i.cache-miss-rate%
     70.23                       71.14        perf-stat.overall.cache-miss-rate%
      7755                        7695        perf-stat.ps.context-switches
      3.44                        3.40        perf-stat.i.dTLB-store-miss-rate%
 4.045e+10                   3.998e+10        perf-stat.i.dTLB-stores
 7.381e+10                   7.292e+10        perf-stat.i.dTLB-loads
 4.028e+10                   3.978e+10        perf-stat.ps.dTLB-stores
      3.45                        3.41        perf-stat.overall.dTLB-store-miss-rate%
 7.351e+10                   7.257e+10        perf-stat.ps.dTLB-loads
 2.512e+11                    2.47e+11        perf-stat.i.instructions
 2.502e+11                   2.458e+11        perf-stat.ps.instructions
 7.618e+13                   7.472e+13        perf-stat.total.instructions
      7.18                        7.04        perf-stat.overall.node-store-miss-rate%
      0.60                        0.59        perf-stat.i.ipc
      0.61                        0.59        perf-stat.overall.ipc
 1.447e+09                   1.412e+09        perf-stat.i.dTLB-store-misses
   5.1e+10                   4.971e+10        perf-stat.i.branch-instructions
 1.441e+09                   1.405e+09        perf-stat.ps.dTLB-store-misses
 5.079e+10                   4.947e+10        perf-stat.ps.branch-instructions
   6885297                     6705138        perf-stat.i.node-store-misses
      1.66                        1.62        perf-stat.overall.MPKI
   6859094                     6676984        perf-stat.ps.node-store-misses
  86898473                    84521835        perf-stat.ps.minor-faults
  86899384                    84522278        perf-stat.ps.page-faults
  87236715                    84845389        perf-stat.i.minor-faults
  87237611                    84846088        perf-stat.i.page-faults
 4.024e+08                   3.905e+08        perf-stat.i.branch-misses
 2.932e+08              -3%  2.843e+08        perf-stat.i.cache-misses
 4.011e+08              -3%  3.888e+08        perf-stat.ps.branch-misses
  2.92e+08              -3%  2.829e+08        perf-stat.ps.cache-misses
 4.174e+08              -4%  3.996e+08        perf-stat.i.cache-references
 4.158e+08              -4%  3.977e+08        perf-stat.ps.cache-references
 1.882e+08              -5%  1.779e+08        perf-stat.i.iTLB-load-misses
 1.874e+08              -6%  1.771e+08        perf-stat.ps.iTLB-load-misses
      1.27 ± 34%       -40%       0.76 ± 17%  perf-stat.i.node-load-miss-rate%
      0.90 ±  9%       -41%       0.53        perf-stat.overall.node-load-miss-rate%
     68.74             -53%      32.36        perf-stat.i.iTLB-load-miss-rate%
     66.57             -57%      28.69        perf-stat.overall.iTLB-load-miss-rate%

Best Regards,
Rong Chen

> 
> Also CCing Aaron Lu, who has previously investigated the cache layout
> in the struct memcg stat counters.
> 
> > 	nr_task: 100%
> > 	mode: process
> > 	test: page_fault3
> > 	cpufreq_governor: performance
> 
> From c9ed8f78dfa25c4d29adf5a09cf9adeeb43e8bdd Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 20 May 2019 14:18:26 -0400
> Subject: [PATCH] mm: memcontrol: don't batch updates of local VM stats and
>  events
> 
> The kernel test robot noticed a 26% will-it-scale pagefault regression
> from commit 42a300353577 ("mm: memcontrol: fix recursive statistics
> correctness & scalabilty"). This appears to be caused by bouncing the
> additional cachelines from the new hierarchical statistics counters.
> 
> We can fix this by getting rid of the batched local counters instead.
> 
> Originally, there were *only* group-local counters, and they were
> fully maintained per cpu. A reader of a stats file high up in the
> cgroup tree would have to walk the entire subtree and collect each
> level's per-cpu counters to get the recursive view. This was
> prohibitively expensive, and so we switched to per-cpu batched updates
> of the local counters during a983b5ebee57 ("mm: memcontrol: fix
> excessive complexity in memory.stat reporting"), reducing the
> complexity from nr_subgroups * nr_cpus to nr_subgroups.
> 
> With growing machines and cgroup trees, the tree walk itself became
> too expensive for monitoring top-level groups, and this is when the
> culprit patch added hierarchy counters on each cgroup level. When the
> per-cpu batch size would be reached, both the local and the hierarchy
> counters would get batch-updated from the per-cpu delta simultaneously.
> 
> This makes local and hierarchical counter reads blazingly fast, but it
> unfortunately makes the write-side too cache line intense.
> 
> Since local counter reads were never a problem - we only centralized
> them to accelerate the hierarchy walk - and use of the local counters
> are becoming rarer due to replacement with hierarchical views (ongoing
> rework in the page reclaim and workingset code), we can make those
> local counters unbatched per-cpu counters again.
> 
> The scheme will then be as such:
> 
>    when a memcg statistic changes, the writer will:
>    - update the local counter (per-cpu)
>    - update the batch counter (per-cpu). If the batch is full:
>    - spill the batch into the group's atomic_t
>    - spill the batch into all ancestors' atomic_ts
>    - empty out the batch counter (per-cpu)
> 
>    when a local memcg counter is read, the reader will:
>    - collect the local counter from all cpus
> 
>    when a hiearchy memcg counter is read, the reader will:
>    - read the atomic_t
> 
> We might be able to simplify this further and make the recursive
> counters unbatched per-cpu counters as well (batch upward propagation,
> but leave per-cpu collection to the readers), but that will require a
> more in-depth analysis and testing of all the callsites. Deal with the
> immediate regression for now.
> 
> Fixes: 42a300353577 ("mm: memcontrol: fix recursive statistics correctness & scalabilty")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/memcontrol.h | 26 ++++++++++++++++--------
>  mm/memcontrol.c            | 41 ++++++++++++++++++++++++++------------
>  2 files changed, 46 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index bc74d6a4407c..2d23ae7bd36d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -126,9 +126,12 @@ struct memcg_shrinker_map {
>  struct mem_cgroup_per_node {
>  	struct lruvec		lruvec;
>  
> +	/* Legacy local VM stats */
> +	struct lruvec_stat __percpu *lruvec_stat_local;
> +
> +	/* Subtree VM stats (batched updates) */
>  	struct lruvec_stat __percpu *lruvec_stat_cpu;
>  	atomic_long_t		lruvec_stat[NR_VM_NODE_STAT_ITEMS];
> -	atomic_long_t		lruvec_stat_local[NR_VM_NODE_STAT_ITEMS];
>  
>  	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
>  
> @@ -274,17 +277,18 @@ struct mem_cgroup {
>  	atomic_t		moving_account;
>  	struct task_struct	*move_lock_task;
>  
> -	/* memory.stat */
> +	/* Legacy local VM stats and events */
> +	struct memcg_vmstats_percpu __percpu *vmstats_local;
> +
> +	/* Subtree VM stats and events (batched updates) */
>  	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
>  
>  	MEMCG_PADDING(_pad2_);
>  
>  	atomic_long_t		vmstats[MEMCG_NR_STAT];
> -	atomic_long_t		vmstats_local[MEMCG_NR_STAT];
> -
>  	atomic_long_t		vmevents[NR_VM_EVENT_ITEMS];
> -	atomic_long_t		vmevents_local[NR_VM_EVENT_ITEMS];
>  
> +	/* memory.events */
>  	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
>  
>  	unsigned long		socket_pressure;
> @@ -576,7 +580,11 @@ static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>  static inline unsigned long memcg_page_state_local(struct mem_cgroup *memcg,
>  						   int idx)
>  {
> -	long x = atomic_long_read(&memcg->vmstats_local[idx]);
> +	long x = 0;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		x += per_cpu(memcg->vmstats_local->stat[idx], cpu);
>  #ifdef CONFIG_SMP
>  	if (x < 0)
>  		x = 0;
> @@ -650,13 +658,15 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  						    enum node_stat_item idx)
>  {
>  	struct mem_cgroup_per_node *pn;
> -	long x;
> +	long x = 0;
> +	int cpu;
>  
>  	if (mem_cgroup_disabled())
>  		return node_page_state(lruvec_pgdat(lruvec), idx);
>  
>  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	x = atomic_long_read(&pn->lruvec_stat_local[idx]);
> +	for_each_possible_cpu(cpu)
> +		x += per_cpu(pn->lruvec_stat_local->count[idx], cpu);
>  #ifdef CONFIG_SMP
>  	if (x < 0)
>  		x = 0;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e50a2db5b4ff..8d42e5c7bf37 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -700,11 +700,12 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
>  	if (mem_cgroup_disabled())
>  		return;
>  
> +	__this_cpu_add(memcg->vmstats_local->stat[idx], val);
> +
>  	x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
>  	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
>  		struct mem_cgroup *mi;
>  
> -		atomic_long_add(x, &memcg->vmstats_local[idx]);
>  		for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
>  			atomic_long_add(x, &mi->vmstats[idx]);
>  		x = 0;
> @@ -754,11 +755,12 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  	__mod_memcg_state(memcg, idx, val);
>  
>  	/* Update lruvec */
> +	__this_cpu_add(pn->lruvec_stat_local->count[idx], val);
> +
>  	x = val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
>  	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
>  		struct mem_cgroup_per_node *pi;
>  
> -		atomic_long_add(x, &pn->lruvec_stat_local[idx]);
>  		for (pi = pn; pi; pi = parent_nodeinfo(pi, pgdat->node_id))
>  			atomic_long_add(x, &pi->lruvec_stat[idx]);
>  		x = 0;
> @@ -780,11 +782,12 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
>  	if (mem_cgroup_disabled())
>  		return;
>  
> +	__this_cpu_add(memcg->vmstats_local->events[idx], count);
> +
>  	x = count + __this_cpu_read(memcg->vmstats_percpu->events[idx]);
>  	if (unlikely(x > MEMCG_CHARGE_BATCH)) {
>  		struct mem_cgroup *mi;
>  
> -		atomic_long_add(x, &memcg->vmevents_local[idx]);
>  		for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
>  			atomic_long_add(x, &mi->vmevents[idx]);
>  		x = 0;
> @@ -799,7 +802,12 @@ static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
>  
>  static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
>  {
> -	return atomic_long_read(&memcg->vmevents_local[event]);
> +	long x = 0;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		x += per_cpu(memcg->vmstats_local->events[event], cpu);
> +	return x;
>  }
>  
>  static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
> @@ -2200,11 +2208,9 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  			long x;
>  
>  			x = this_cpu_xchg(memcg->vmstats_percpu->stat[i], 0);
> -			if (x) {
> -				atomic_long_add(x, &memcg->vmstats_local[i]);
> +			if (x)
>  				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
>  					atomic_long_add(x, &memcg->vmstats[i]);
> -			}
>  
>  			if (i >= NR_VM_NODE_STAT_ITEMS)
>  				continue;
> @@ -2214,12 +2220,10 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  
>  				pn = mem_cgroup_nodeinfo(memcg, nid);
>  				x = this_cpu_xchg(pn->lruvec_stat_cpu->count[i], 0);
> -				if (x) {
> -					atomic_long_add(x, &pn->lruvec_stat_local[i]);
> +				if (x)
>  					do {
>  						atomic_long_add(x, &pn->lruvec_stat[i]);
>  					} while ((pn = parent_nodeinfo(pn, nid)));
> -				}
>  			}
>  		}
>  
> @@ -2227,11 +2231,9 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  			long x;
>  
>  			x = this_cpu_xchg(memcg->vmstats_percpu->events[i], 0);
> -			if (x) {
> -				atomic_long_add(x, &memcg->vmevents_local[i]);
> +			if (x)
>  				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
>  					atomic_long_add(x, &memcg->vmevents[i]);
> -			}
>  		}
>  	}
>  
> @@ -4492,8 +4494,15 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  	if (!pn)
>  		return 1;
>  
> +	pn->lruvec_stat_local = alloc_percpu(struct lruvec_stat);
> +	if (!pn->lruvec_stat_local) {
> +		kfree(pn);
> +		return 1;
> +	}
> +
>  	pn->lruvec_stat_cpu = alloc_percpu(struct lruvec_stat);
>  	if (!pn->lruvec_stat_cpu) {
> +		free_percpu(pn->lruvec_stat_local);
>  		kfree(pn);
>  		return 1;
>  	}
> @@ -4515,6 +4524,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  		return;
>  
>  	free_percpu(pn->lruvec_stat_cpu);
> +	free_percpu(pn->lruvec_stat_local);
>  	kfree(pn);
>  }
>  
> @@ -4525,6 +4535,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
>  	for_each_node(node)
>  		free_mem_cgroup_per_node_info(memcg, node);
>  	free_percpu(memcg->vmstats_percpu);
> +	free_percpu(memcg->vmstats_local);
>  	kfree(memcg);
>  }
>  
> @@ -4553,6 +4564,10 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>  	if (memcg->id.id < 0)
>  		goto fail;
>  
> +	memcg->vmstats_local = alloc_percpu(struct memcg_vmstats_percpu);
> +	if (!memcg->vmstats_local)
> +		goto fail;
> +
>  	memcg->vmstats_percpu = alloc_percpu(struct memcg_vmstats_percpu);
>  	if (!memcg->vmstats_percpu)
>  		goto fail;
> -- 
> 2.21.0
> 
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp
