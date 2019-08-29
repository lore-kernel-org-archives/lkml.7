Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B58C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB362215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfH2TXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:23:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfH2TXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:23:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37FF3756;
        Thu, 29 Aug 2019 19:23:08 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14DC55D9D3;
        Thu, 29 Aug 2019 19:23:07 +0000 (UTC)
Date:   Thu, 29 Aug 2019 15:23:05 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com
Subject: Re: [PATCH v2 0/8] sched/fair: rework the CFS load balance
Message-ID: <20190829192305.GD20736@pauld.bos.csb>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 29 Aug 2019 19:23:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 04:40:16PM +0200 Vincent Guittot wrote:
> Several wrong task placement have been raised with the current load
> balance algorithm but their fixes are not always straight forward and
> end up with using biased values to force migrations. A cleanup and rework
> of the load balance will help to handle such UCs and enable to fine grain
> the behavior of the scheduler for other cases.
> 
> Patch 1 has already been sent separatly and only consolidate asym policy
> in one place and help the review of the changes in load_balance.
> 
> Patch 2 renames the sum of h_nr_running in stats.
> 
> Patch 3 removes meaningless imbalance computation to make review of
> patch 4 easier.
> 
> Patch 4 reworks load_balance algorithm and fixes some wrong task placement
> but try to stay conservative.
> 
> Patch 5 add the sum of nr_running to monitor non cfs tasks and take that
> into account when pulling tasks.
> 
> Patch 6 replaces runnable_load by load now that the metrics is only used
> when overloaded.
> 
> Patch 7 improves the spread of tasks at the 1st scheduling level.
> 
> Patch 8 uses utilization instead of load in all steps of misfit task
> path.
> 
> Some benchmarks results based on 8 iterations of each tests:
> - small arm64 dual quad cores system
> 
>            tip/sched/core        w/ this patchset    improvement
> schedpipe      54981 +/-0.36%        55459 +/-0.31%   (+0.97%)
> 
> hackbench
> 1 groups       0.906 +/-2.34%        0.906 +/-2.88%   (+0.06%)
> 
> - large arm64 2 nodes / 224 cores system
> 
>            tip/sched/core        w/ this patchset    improvement
> schedpipe     125665 +/-0.61%       125455 +/-0.62%   (-0.17%)
> 
> hackbench -l (256000/#grp) -g #grp
> 1 groups      15.263 +/-3.53%       13.776 +/-3.30%   (+9.74%)
> 4 groups       5.852 +/-0.57%        5.340 +/-8.03%   (+8.75%)
> 16 groups      3.097 +/-1.08%        3.246 +/-0.97%   (-4.81%)
> 32 groups      2.882 +/-1.04%        2.845 +/-1.02%   (+1.29%)
> 64 groups      2.809 +/-1.30%        2.712 +/-1.17%   (+3.45%)
> 128 groups     3.129 +/-9.74%        2.813 +/-6.22%   (+9.11%)
> 256 groups     3.559 +/-11.07%       3.020 +/-1.75%  (+15.15%)
> 
> dbench
> 1 groups     330.897 +/-0.27%      330.612 +/-0.77%   (-0.09%)
> 4 groups     932.922 +/-0.54%      941.817 +/*1.10%   (+0.95%)
> 16 groups   1932.346 +/-1.37%     1962.944 +/-0.62%   (+1.58%)
> 32 groups   2251.079 +/-7.93%     2418.531 +/-0.69%   (+7.44%)
> 64 groups   2104.114 +/-9.67%     2348.698 +/-11.24% (+11.62%)
> 128 groups  2093.756 +/-7.26%     2278.156 +/-9.74%   (+8.81%)
> 256 groups  1216.736 +/-2.46%     1665.774 +/-4.68%  (+36.91%)
> 
> tip/sched/core sha1:
>   a1dc0446d649 ('sched/core: Silence a warning in sched_init()')
> 
> Changes since v1:
> - fixed some bugs
> - Used switch case
> - Renamed env->src_grp_type to env->balance_type
> - split patches in smaller ones
> - added comments
> 
> Vincent Guittot (8):
>   sched/fair: clean up asym packing
>   sched/fair: rename sum_nr_running to sum_h_nr_running
>   sched/fair: remove meaningless imbalance calculation
>   sched/fair: rework load_balance
>   sched/fair: use rq->nr_running when balancing load
>   sched/fair: use load instead of runnable load
>   sched/fair: evenly spread tasks when not overloaded
>   sched/fair: use utilization to select misfit task
> 
>  kernel/sched/fair.c  | 769 ++++++++++++++++++++++++++++-----------------------
>  kernel/sched/sched.h |   2 +-
>  2 files changed, 419 insertions(+), 352 deletions(-)
> 
> -- 
> 2.7.4
> 

I keep expecting a v3 so I have not dug into all the patches in detail. However, I've 
been working with them from Vincent's tree while they were under development so I thought 
I'd add some results.

The workload is a test our perf team came up with to illustrate the issues we were seeing
with imbalance in the presence of group scheduling. 

On a 4-numa X 20 cpu system (smt on) we run a 76 thread lu.C benchmark from the NAS Parallel 
suite. And at the same time run 2 stress cpu burn processes.  The GROUP test puts the 
benchmark and the stress processes each in its own cgroup.  The NORMAL case puts them all 
in the first cgroup.  The results show first the average number of threads of each type 
running on each of the numa nodes based on sampling taken during the run.  This is followed
by the lu.C benchmark results. There are 3 runs of GROUP and 2 runs of NORMAL shown.

Before (linux-5.3-rc1+  @  a1dc0446d649)

lu.C.x_76_GROUP_1.stress.ps.numa.hist   Average    0.00  1.00  1.00
lu.C.x_76_GROUP_2.stress.ps.numa.hist   Average    0.00  1.00  1.00
lu.C.x_76_GROUP_3.stress.ps.numa.hist   Average    0.00  1.00  1.00
lu.C.x_76_NORMAL_1.stress.ps.numa.hist  Average    1.15  0.23  0.00  0.62
lu.C.x_76_NORMAL_2.stress.ps.numa.hist  Average    1.67  0.00  0.00  0.33

lu.C.x_76_GROUP_1.ps.numa.hist   Average    30.45  6.95  4.52  34.08
lu.C.x_76_GROUP_2.ps.numa.hist   Average    32.33  8.94  9.21  25.52
lu.C.x_76_GROUP_3.ps.numa.hist   Average    30.45  8.91  12.09  24.55
lu.C.x_76_NORMAL_1.ps.numa.hist  Average    18.54  19.23  19.69  18.54
lu.C.x_76_NORMAL_2.ps.numa.hist  Average    17.25  19.83  20.00  18.92

============76_GROUP========Mop/s===================================
min	q1	median	q3	max
2119.92	2418.1	2716.28	3147.82	3579.36
============76_GROUP========time====================================
min	q1	median	q3	max
569.65	660.155	750.66	856.245	961.83
============76_NORMAL========Mop/s===================================
min	q1	median	q3	max
30424.5	31486.4	31486.4	31486.4	32548.4
============76_NORMAL========time====================================
min	q1	median	q3	max
62.65	64.835	64.835	64.835	67.02


After (linux-5.3-rc1+  @  a1dc0446d649 + this v2 series pulled from 
Vincent's git on ~8/15)

lu.C.x_76_GROUP_1.stress.ps.numa.hist   Average    0.36  1.00  0.64
lu.C.x_76_GROUP_2.stress.ps.numa.hist   Average    1.00  1.00
lu.C.x_76_GROUP_3.stress.ps.numa.hist   Average    1.00  1.00
lu.C.x_76_NORMAL_1.stress.ps.numa.hist  Average    0.23  0.15  0.31  1.31
lu.C.x_76_NORMAL_2.stress.ps.numa.hist  Average    1.00  0.00  0.00  1.00

lu.C.x_76_GROUP_1.ps.numa.hist   Average    18.91  18.36  18.91  19.82
lu.C.x_76_GROUP_2.ps.numa.hist   Average    18.36  18.00  19.91  19.73
lu.C.x_76_GROUP_3.ps.numa.hist   Average    18.17  18.42  19.25  20.17
lu.C.x_76_NORMAL_1.ps.numa.hist  Average    19.08  20.00  18.62  18.31
lu.C.x_76_NORMAL_2.ps.numa.hist  Average    18.09  19.91  19.18  18.82

============76_GROUP========Mop/s===================================
min	q1	median	q3	max
32304.1	33176	34047.9	34166.8	34285.7
============76_GROUP========time====================================
min	q1	median	q3	max
59.47	59.68	59.89	61.505	63.12
============76_NORMAL========Mop/s===================================
min	q1	median	q3	max
29825.5	32454	32454	32454	35082.5
============76_NORMAL========time====================================
min	q1	median	q3	max
58.12	63.24	63.24	63.24	68.36


I had initially tracked this down to two issues. The first was picking the wrong
group in find_busiest_group due to using the average load. The second was in 
fix_small_imbalance(). The "load" of the lu.C tasks was so low it often failed 
to move anything even when it did find a group that was overloaded (nr_running 
> width). I have two small patches which fix this but since Vincent was embarking
on a re-work which also addressed this I dropped them.

We've also run a series of performance tests we use to check for regressions and 
did not find any bad results on our workloads and systems.

So...

Tested-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil
-- 
