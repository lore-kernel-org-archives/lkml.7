Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54EFCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 03:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4D92080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 03:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfJaDb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 23:31:28 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36514 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbfJaDb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 23:31:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TgkVYbQ_1572492684;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TgkVYbQ_1572492684)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 11:31:25 +0800
Subject: Re: [PATCH] sched/numa: advanced per-cgroup numa statistic
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
References: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
 <20191030095505.GF28938@suse.de>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <6f5e43db-24f1-5283-0881-f264b0d5f835@linux.alibaba.com>
Date:   Thu, 31 Oct 2019 11:31:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030095505.GF28938@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mel

Thanks for the comments :-)

On 2019/10/30 下午5:55, Mel Gorman wrote:
[snip]
>> In order to address this, we introduced new per-cgroup statistic
>> for numa:
>>   * the numa locality to imply the numa balancing efficiency
> 
> That is clear to some extent with the obvious caveat that a cgroup bound
> to a memory node will report this as being nearly 100% with shared pages
> being a possible exception.Locality might be fine but there could be
> large latencies due to reclaim if the cgroup limits are exceeded or the
> NUMA node is too small. It can give an artifical sense of benefit.

Currently we rely on locality on telling whether there are issues rather
than the benefit, mostly the deployment and configuration issues.

For example, tasks bind to the cpus of node_0 could have their memory on
node_1 when node_0 almost run out of memory, numa balancing may not be
able to help in this case, while by reading locality we could know how
critical the problem is, and may take action to rebind cpus to node_1 or
reclaim the memory of node_0.

> 
>>   * the numa execution time on each node
>>
> 
> This is less obvious because it does not define what NUMA execution time
> is and it's not documented by the patch.
> 
>> The task locality is the local page accessing ratio traced on numa
>> balancing PF, and the group locality is the topology of task execution
>> time, sectioned by the locality into 8 regions.
>>
> 
> This is another important limitation. Disabling NUMA balancing will also
> disable the stats which may be surprising to some users. It's not a
> show-stopper but arguably the file should be non-existant or always
> zeros if NUMA balancing is disabled.

Maybe a check on sched_numa_balancing before showing the data could
be helpful? when user turn off numa balancing dynamically, we no longer
showing the data.

> 
>> For example the new entry 'cpu.numa_stat' show:
>>   locality 15393 21259 13023 44461 21247 17012 28496 145402
>>   exectime 311900 407166
>>
>> Here we know the workloads executed 311900ms on node_0 and 407166ms
>> on node_1, tasks with locality around 0~12% executed for 15393 ms, and
>> tasks with locality around 88~100% executed for 145402 ms, which imply
>> most of the memory access is local access, for the workloads of this
>> group.
>>
> 
> This needs documentation because it's not obvious at all that the
> locality values are roughly percentiles. It's also not obvious what a
> sysadmin would *do* with this information.

Make sense, I'll draft a doc regarding how to read and handle these
data then.

> 
>> By monitoring the new statistic, we will be able to know the numa
>> efficiency of each per-cgroup workloads on machine, whatever they
>> sharing the CPUs or not, we will be able to find out which one
>> introduced the remote access mostly.
>>
>> Besides, per-node memory topology from 'memory.numa_stat' become
>> more useful when we have the per-node execution time, workloads
>> always executing on node_0 while it's memory is all on node_1 is
>> usually a bad case.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Michal Koutný <mkoutny@suse.com>
>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> 
> So, superficially, I'm struggling to see what action a sysadmin would take,
> if any, with this information. It makes sense to track what individual
> tasks are doing but this can be done with ftrace if required.

The idea here is to give user the ability of monitoring numa efficiency
per-cgroup, just like monitoring per-cgroup CPU or memory usages, ftrace
is a good way of further debugging, while IMHO not that suitable for
daily monitoring.

One common usecase is to alarm user when some cgroup's locality is
always low, and usually this is caused by wrong memory policy, or
exhausted numa node, then user can adjust the policy or binding other
nodes, or reclaim the exhausted node.

> 
>> ---
>>  include/linux/sched.h |  8 ++++++-
>>  kernel/sched/core.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  kernel/sched/debug.c  |  7 ++++++
>>  kernel/sched/fair.c   | 51 ++++++++++++++++++++++++++++++++++++++++++++
>>  kernel/sched/sched.h  | 29 +++++++++++++++++++++++++
>>  5 files changed, 153 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 263cf089d1b3..46995be622c1 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1114,8 +1114,14 @@ struct task_struct {
>>  	 * scan window were remote/local or failed to migrate. The task scan
>>  	 * period is adapted based on the locality of the faults with different
>>  	 * weights depending on whether they were shared or private faults
>> +	 *
>> +	 * 0 -- remote faults
>> +	 * 1 -- local faults
>> +	 * 2 -- page migration failure
>> +	 * 3 -- remote page accessing
>> +	 * 4 -- local page accessing
>>  	 */
>> -	unsigned long			numa_faults_locality[3];
>> +	unsigned long			numa_faults_locality[5];
>>
> 
> Not clear from the comment what the difference between a remote fault
> and a remote page access is. Superficially, they're the same thing.

The 'fault' is recording before page migration while 'accessing'
is after, they could be different when the page has been migrated.

> 
>>  	unsigned long			numa_pages_migrated;
[snip]
>>  	unsigned long ptr = 0;
>> @@ -6593,6 +6597,10 @@ void __init sched_init(void)
>>  	init_defrootdomain();
>>  #endif
>>
>> +#ifdef CONFIG_NUMA_BALANCING
>> +	root_task_group.numa_stat = &root_numa_stat;
>> +#endif
>> +
>>  #ifdef CONFIG_RT_GROUP_SCHED
>>  	init_rt_bandwidth(&root_task_group.rt_bandwidth,
>>  			global_rt_period(), global_rt_runtime());
> 
> This is an indication that there is a universal hit to collect this data
> whether cgroups are enabled or not. That hits the same problem I had
> with PSI when it was first introduced. For users that care, the
> information is useful, particularly as they generally have an
> application consuming the data>
>> @@ -6918,6 +6926,7 @@ static inline void alloc_uclamp_sched_group(struct task_group *tg,
>>
>>  static void sched_free_group(struct task_group *tg)
>>  {
>> +	free_tg_numa_stat(tg);
>>  	free_fair_sched_group(tg);
>>  	free_rt_sched_group(tg);
>>  	autogroup_free(tg);
>> @@ -6933,6 +6942,9 @@ struct task_group *sched_create_group(struct task_group *parent)
>>  	if (!tg)
>>  		return ERR_PTR(-ENOMEM);
>>
>> +	if (!alloc_tg_numa_stat(tg))
>> +		goto err;
>> +
>>  	if (!alloc_fair_sched_group(tg, parent))
>>  		goto err;
>>
> 
> While this is very unlikely to fail, I find it odd to think that an
> entire cgroup could fail to be created simply because stats cannot be
> collected, particularly when no userspace component may care at all.

We have rework the implementation in v2 (sent) and put the data into cfs_rq,
all these init works have been saved :-)

> 
[snip]>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index f7e4579e746c..a22b2a62aee2 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -848,6 +848,13 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
>>  	P(total_numa_faults);
>>  	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
>>  			task_node(p), task_numa_group_id(p));
>> +	SEQ_printf(m, "faults_locality local=%lu remote=%lu failed=%lu ",
>> +			p->numa_faults_locality[1],
>> +			p->numa_faults_locality[0],
>> +			p->numa_faults_locality[2]);
> 
> This should be a separate patch. "failed=" does not tell much. It should
> be at least migfailed to give some indication it's about failed
> migrations.

I'm always doing bad on naming :-P

> 
> It might still be misleading because the failure could be due to lack of
> memory or because the page is pinned. However, I would not worry about
> that in this case.
> 
> What *does* make this dangerous is that numa_faults_locality is often
> cleared. A user could easily think that this data somehow accumulates
> over time but it does not. This exposes implementation details as
> numa_faults_locality could change its behaviour in the future and tools
> should not rely on the contents being stable. While I recognise that
> some numa balancing information is already exposed in that file, it's
> relatively harmless with the possible exception of numa_scan_seq but
> at least that value is almost worthless (other than detecting if NUMA
> balancing is completely broken) and very unlikely to change behaviour.

Yeah, each new scan will drop the faults data of last scan, which is
important for group locality accumulation since we don't want to tracing
the out dated data for too long.

I think I get your point, these per-task faults are not accumulated, so they
are meaningless on period checking, actually they are not so helpful when
we consider cgroup as a unit for numa adapting, will remove them in next
version then.

> 
>> +	SEQ_printf(m, "lhit=%lu rhit=%lu\n",
>> +			p->numa_faults_locality[4],
>> +			p->numa_faults_locality[3]);
>>  	show_numa_stats(p, m);
>>  	mpol_put(pol);
>>  #endif
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index a81c36472822..4ba3a41cdca3 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -2466,6 +2466,12 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
>>  	p->numa_faults[task_faults_idx(NUMA_MEMBUF, mem_node, priv)] += pages;
>>  	p->numa_faults[task_faults_idx(NUMA_CPUBUF, cpu_node, priv)] += pages;
>>  	p->numa_faults_locality[local] += pages;
>> +	/*
>> +	 * We want to have the real local/remote page access statistic
>> +	 * here, so use 'mem_node' which is the real residential node of
>> +	 * page after migrate_misplaced_page().
>> +	 */
>> +	p->numa_faults_locality[3 + !!(mem_node == numa_node_id())] += pages;
>>  }
>>
> 
> This may be misleading if a task is using a preferred node policy that
> happens to be remote. It'll report bad locality but it's how the task
> waqs configured. Similarly, shared pages that are interleaves will show
> as remote accesses which is not necessarily bad. It goes back to "what
> does a sysadmin do with this information?"

IMHO a very important usage of these data is to tell the numa users
"something maybe going wrong", could be on purpose or really a setting
issue, users could then try to figure out whether this is a false alarm
or not.

Maybe we could give some hints for users on how to handle it when seeing
the downturn locality, in the coming docs :-)

> 
>>  static void reset_ptenuma_scan(struct task_struct *p)
[snip]
>> +void free_tg_numa_stat(struct task_group *tg)
>> +{
>> +	free_percpu(tg->numa_stat);
>> +}
>> +
>> +static void update_tg_numa_stat(struct task_struct *p)
>> +{
>> +	struct task_group *tg;
>> +	unsigned long remote = p->numa_faults_locality[3];
>> +	unsigned long local = p->numa_faults_locality[4];
>> +	int idx = -1;
>> +
>> +	/* Tobe scaled? */
>> +	if (remote || local)
>> +		idx = NR_NL_INTERVAL * local / (remote + local + 1);
>> +
>> +	rcu_read_lock();
>> +
>> +	tg = task_group(p);
>> +	while (tg) {
>> +		/* skip account when there are no faults records */
>> +		if (idx != -1)
>> +			this_cpu_inc(tg->numa_stat->locality[idx]);
>> +
>> +		this_cpu_inc(tg->numa_stat->jiffies);
>> +
>> +		tg = tg->parent;
>> +	}
>> +
>> +	rcu_read_unlock();
>> +}
>> +
> 
> This is potentially a long walk to do in the task tick context if there
> are a lot of groups. Also, if no faults are recorded because the scanner is
> running slowly, what does that mean for detecting locality? The information
> could be way off if a lot of accesses are remote and simply not caught
> by faults because of recent changes.

We have merge the work into entity_tick() in V2, which just add few
lines to the existed hierarchy updating.

As you point out, locality assume the task-page node position won't
change too much between each scan, which is definitely not true all
the times.

However, scan period adapting it self based on the faults info, which
means when it getting longer, the task-page node relationship are
becoming stable, the locality are more reliable, and when it getting
shorter, the updating of faults becoming rapidly, which also make the
locality more accurate.

Anyway, locality is not supposed to be accurate all the times, but
should always telling the right tendency, if one found the locality
is always low, it can't be a good task-page node relationship in there.

> 
> So, overall, I see the general intent that you want to identify cgroups
> that have bad locality but it incurs a universal cost regardless of
> whether the user wants it or not. The documentation is non-existant but
> the biggest kicker is that it's unclear how a sysadmin would consume this
> information. The problem is compounded by the fact that interpreting
> the data accurately and making a decision requires knowledge of the
> implementation and that severely limits who can benefit.  In my mind, it
> makes more sense to track the locality and NUMA behaviour of individual
> tasks which can be already done with ftrace. If cgroup tracking was
> required, a userspace application using ftrace could correlate task
> activity with what cgroup it belongs to and collect the data from userspace
> -- this is not necessarily easy and tracepoints might need updating, but
> it makes more sense to track this in userspace instead of in the kernel
> which never consumes the data
Yeah, per-cgroup ftrace tracing may could work, but IMHO it also introduce
overhead (maybe even more), and not very likely a general monitoring way,
I suppose locality could be something similar to load_1/5/15, not so accurate
but help to warn the possible issues.

We have sent v2 which reworked the implementation according to Peter's
suggestions, would be very appreciate if you could help review to see if
the overhead concern has been addressed, and we will:
 * stop showing the per-task faults info
 * add checks for sched_numa_balancing before showing locality
in next version, also doc is on the way ;-)

Best Regards,
Michael Wang

> 
