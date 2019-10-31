Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D560CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4098520873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfJaNRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:17:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:58728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbfJaNRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:17:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA6B6B5F2;
        Thu, 31 Oct 2019 13:17:40 +0000 (UTC)
Date:   Thu, 31 Oct 2019 13:17:31 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     ?????? <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/numa: advanced per-cgroup numa statistic
Message-ID: <20191031131731.GJ28938@suse.de>
References: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
 <20191030095505.GF28938@suse.de>
 <6f5e43db-24f1-5283-0881-f264b0d5f835@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f5e43db-24f1-5283-0881-f264b0d5f835@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 11:31:24AM +0800, ?????? wrote:
> On 2019/10/30 ??????5:55, Mel Gorman wrote:
> [snip]
> >> In order to address this, we introduced new per-cgroup statistic
> >> for numa:
> >>   * the numa locality to imply the numa balancing efficiency
> > 
> > That is clear to some extent with the obvious caveat that a cgroup bound
> > to a memory node will report this as being nearly 100% with shared pages
> > being a possible exception.Locality might be fine but there could be
> > large latencies due to reclaim if the cgroup limits are exceeded or the
> > NUMA node is too small. It can give an artifical sense of benefit.
> 
> Currently we rely on locality on telling whether there are issues rather
> than the benefit, mostly the deployment and configuration issues.
> 
> For example, tasks bind to the cpus of node_0 could have their memory on
> node_1 when node_0 almost run out of memory, numa balancing may not be
> able to help in this case, while by reading locality we could know how
> critical the problem is, and may take action to rebind cpus to node_1 or
> reclaim the memory of node_0.
> 

You can already do this by walking each cgroup, identifying what tasks are
in it and look at /proc/PID/numa_maps and /proc/PID/status to see what
CPU bindings if any exist. This would use the actual memory placements
and not those sampled by NUMA balancing, would not require NUMA balancing
and would work on older kernels. It would be costly to access so I would
not suggest doing it at high frequency but it makes sense for the tool
that cares to pay the cost instead of spreading tidy bits of cost to
every task whether there is an interested tool or not.

> > 
> >>   * the numa execution time on each node
> >>
> > 
> > This is less obvious because it does not define what NUMA execution time
> > is and it's not documented by the patch.
> > 
> >> The task locality is the local page accessing ratio traced on numa
> >> balancing PF, and the group locality is the topology of task execution
> >> time, sectioned by the locality into 8 regions.
> >>
> > 
> > This is another important limitation. Disabling NUMA balancing will also
> > disable the stats which may be surprising to some users. It's not a
> > show-stopper but arguably the file should be non-existant or always
> > zeros if NUMA balancing is disabled.
> 
> Maybe a check on sched_numa_balancing before showing the data could
> be helpful? when user turn off numa balancing dynamically, we no longer
> showing the data.
> 

That would be an improvement but it would not address the point that the
data required can already be gathered from userspace.

> >> By monitoring the new statistic, we will be able to know the numa
> >> efficiency of each per-cgroup workloads on machine, whatever they
> >> sharing the CPUs or not, we will be able to find out which one
> >> introduced the remote access mostly.
> >>
> >> Besides, per-node memory topology from 'memory.numa_stat' become
> >> more useful when we have the per-node execution time, workloads
> >> always executing on node_0 while it's memory is all on node_1 is
> >> usually a bad case.
> >>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Michal Koutný <mkoutny@suse.com>
> >> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> > 
> > So, superficially, I'm struggling to see what action a sysadmin would take,
> > if any, with this information. It makes sense to track what individual
> > tasks are doing but this can be done with ftrace if required.
> 
> The idea here is to give user the ability of monitoring numa efficiency
> per-cgroup, just like monitoring per-cgroup CPU or memory usages, ftrace
> is a good way of further debugging, while IMHO not that suitable for
> daily monitoring.
> 

Basic monitoring of efficiency per cgroup can be done from userspace.
Further debugging with ftrace could be needed in some cases with or
without this patch.

> One common usecase is to alarm user when some cgroup's locality is
> always low, and usually this is caused by wrong memory policy, or
> exhausted numa node, then user can adjust the policy or binding other
> nodes, or reclaim the exhausted node.
> 

Again, can be done from userspace.

> >>  include/linux/sched.h |  8 ++++++-
> >>  kernel/sched/core.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  kernel/sched/debug.c  |  7 ++++++
> >>  kernel/sched/fair.c   | 51 ++++++++++++++++++++++++++++++++++++++++++++
> >>  kernel/sched/sched.h  | 29 +++++++++++++++++++++++++
> >>  5 files changed, 153 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index 263cf089d1b3..46995be622c1 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -1114,8 +1114,14 @@ struct task_struct {
> >>  	 * scan window were remote/local or failed to migrate. The task scan
> >>  	 * period is adapted based on the locality of the faults with different
> >>  	 * weights depending on whether they were shared or private faults
> >> +	 *
> >> +	 * 0 -- remote faults
> >> +	 * 1 -- local faults
> >> +	 * 2 -- page migration failure
> >> +	 * 3 -- remote page accessing
> >> +	 * 4 -- local page accessing
> >>  	 */
> >> -	unsigned long			numa_faults_locality[3];
> >> +	unsigned long			numa_faults_locality[5];
> >>
> > 
> > Not clear from the comment what the difference between a remote fault
> > and a remote page access is. Superficially, they're the same thing.
> 
> The 'fault' is recording before page migration while 'accessing'
> is after, they could be different when the page has been migrated.
> 

That's a very small distinction given that the counters may only differ
by number of pages migrated which may be a very small number.

> > It might still be misleading because the failure could be due to lack of
> > memory or because the page is pinned. However, I would not worry about
> > that in this case.
> > 
> > What *does* make this dangerous is that numa_faults_locality is often
> > cleared. A user could easily think that this data somehow accumulates
> > over time but it does not. This exposes implementation details as
> > numa_faults_locality could change its behaviour in the future and tools
> > should not rely on the contents being stable. While I recognise that
> > some numa balancing information is already exposed in that file, it's
> > relatively harmless with the possible exception of numa_scan_seq but
> > at least that value is almost worthless (other than detecting if NUMA
> > balancing is completely broken) and very unlikely to change behaviour.
> 
> Yeah, each new scan will drop the faults data of last scan, which is
> important for group locality accumulation since we don't want to tracing
> the out dated data for too long.
> 
> I think I get your point, these per-task faults are not accumulated, so they
> are meaningless on period checking, actually they are not so helpful when
> we consider cgroup as a unit for numa adapting, will remove them in next
> version then.
> 

And besides, gathering the information from userspace reflects the
reality of placement and not guesswork.

> > 
> >> +	SEQ_printf(m, "lhit=%lu rhit=%lu\n",
> >> +			p->numa_faults_locality[4],
> >> +			p->numa_faults_locality[3]);
> >>  	show_numa_stats(p, m);
> >>  	mpol_put(pol);
> >>  #endif
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index a81c36472822..4ba3a41cdca3 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -2466,6 +2466,12 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
> >>  	p->numa_faults[task_faults_idx(NUMA_MEMBUF, mem_node, priv)] += pages;
> >>  	p->numa_faults[task_faults_idx(NUMA_CPUBUF, cpu_node, priv)] += pages;
> >>  	p->numa_faults_locality[local] += pages;
> >> +	/*
> >> +	 * We want to have the real local/remote page access statistic
> >> +	 * here, so use 'mem_node' which is the real residential node of
> >> +	 * page after migrate_misplaced_page().
> >> +	 */
> >> +	p->numa_faults_locality[3 + !!(mem_node == numa_node_id())] += pages;
> >>  }
> >>
> > 
> > This may be misleading if a task is using a preferred node policy that
> > happens to be remote. It'll report bad locality but it's how the task
> > waqs configured. Similarly, shared pages that are interleaves will show
> > as remote accesses which is not necessarily bad. It goes back to "what
> > does a sysadmin do with this information?"
> 
> IMHO a very important usage of these data is to tell the numa users
> "something maybe going wrong", could be on purpose or really a setting
> issue, users could then try to figure out whether this is a false alarm
> or not.
> 

While this has value, again I think it should be done in userspace. I
didn't read v2 or respond to the individual points because I cannot
convince myself this needs to be in the kernel at all. If different
historical information was ever needed, it's easier to do that in a
userspace tool that is independent of the kernel version.

-- 
Mel Gorman
SUSE Labs
