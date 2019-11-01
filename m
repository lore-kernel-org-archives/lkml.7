Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEB1CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E3821855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfKALdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:33:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:13042 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfKALdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:33:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 04:33:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="212755131"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga002.jf.intel.com with ESMTP; 01 Nov 2019 04:33:16 -0700
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <ac746638-9d6e-dde6-59ef-dc6f4e19caa0@linux.intel.com>
Message-ID: <fa51e794-6e46-1c25-a405-8a92f8dac96f@linux.intel.com>
Date:   Fri, 1 Nov 2019 19:33:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <ac746638-9d6e-dde6-59ef-dc6f4e19caa0@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/31 19:42, Li, Aubrey wrote:
> On 2019/10/31 2:33, Vineeth Remanan Pillai wrote:
>> Fourth iteration of the Core-Scheduling feature.
>>
>> This version was aiming mostly at addressing the vruntime comparison
>> issues with v3. The main issue seen in v3 was the starvation of
>> interactive tasks when competing with cpu intensive tasks. This issue
>> is mitigated to a large extent.
>>
>> We have tested and verified that incompatible processes are not
>> selected during schedule. In terms of performance, the impact
>> depends on the workload:
>> - on CPU intensive applications that use all the logical CPUs with
>>   SMT enabled, enabling core scheduling performs better than nosmt.
>> - on mixed workloads with considerable io compared to cpu usage,
>>   nosmt seems to perform better than core scheduling.
>>
>> v4 is rebased on top of 5.3.5(dc073f193b70):
>> https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.3.5
> 
> Thanks to post V4 out. Refresh the data on my side. Since we have played
> with Aaron's core vruntime patch for a while, no surprise in the result.
> 
I have three small patches against V4. The basic idea is,
- for load balance, don't pull/push task if its cookie does not match with
destination CPU's core cookie
- for task wakeup, select idle CPU whose core cookie matches with task's
cookie.

Sysbench MySQL result shows significant improvement for the overload cases.

Here is original data of coresched_v4(for comparison):
.--------------------------------------------------------------------------------------------------------------------------------------.
|NA/AVX	vanilla-SMT	[std% / sem%]	  cpu% |coresched-SMT	[std% / sem%]	  +/-	  cpu% |  no-SMT [std% / sem%]	 +/-	  cpu% |
|--------------------------------------------------------------------------------------------------------------------------------------|
|  1/1	     1018.2	[ 1.0%/ 0.1%]	  1.9% |        915.8	[ 0.9%/ 0.1%]	-10.1%	  1.9% |   994.0 [ 1.4%/ 0.2%]  -2.4%	  3.9% |
|  2/2	     1941.2	[ 0.7%/ 0.1%]	  3.9% |       1746.0	[ 0.5%/ 0.1%]	-10.1%	  3.9% |  1946.2 [ 0.8%/ 0.1%]   0.3%	  7.8% |
|  4/4	     3763.9	[ 0.5%/ 0.0%]	  7.8% |       3426.0	[ 1.5%/ 0.2%]	 -9.0%	  7.8% |  3745.1 [ 1.1%/ 0.1%]  -0.5%	 15.6% |
|  8/8	     7375.5	[ 1.3%/ 0.1%]	 15.5% |       6647.1	[ 1.1%/ 0.1%]	 -9.9%	 16.1% |  7368.4 [ 0.8%/ 0.1%]  -0.1%	 31.1% |
| 16/16	    12990.3	[ 0.6%/ 0.1%]	 31.1% |      10903.7	[ 1.9%/ 0.2%]	-16.1%	 32.0% | 12082.6 [ 4.7%/ 0.5%]  -7.0%	 62.9% |
| 32/32	    18238.1	[ 6.1%/ 0.6%]	 62.1% |      16580.8	[ 3.0%/ 0.3%]	 -9.1%	 62.8% | 21193.6 [ 4.9%/ 0.6%]  16.2%	 97.8% |
| 48/48	    21708.6	[ 8.3%/ 0.8%]	 90.3% |      17064.1	[ 9.5%/ 0.9%]	-21.4%	 90.4% | 18531.4 [16.6%/ 1.8%] -14.6%	 99.5% |
| 64/64	    18636.9	[13.1%/ 1.3%]	 97.9% |      12376.1	[20.9%/ 2.1%]	-33.6%	 96.8% | 20025.8 [14.9%/ 2.4%]   7.5%	100.0% |
|128/128    16204.2	[16.8%/ 1.7%]	 99.4% |       3776.1	[88.7%/ 8.9%]	-76.7%	 97.6% | 20263.5 [12.7%/ 6.8%]  25.1%	100.0% |
|256/256    16730.5	[17.9%/ 1.8%]	 98.9% |       1499.7	[210.3%/21.0%]	-91.0%	 98.4% | 17633.1 [ 7.5%/ 8.9%]   5.4%	100.0% |
'--------------------------------------------------------------------------------------------------------------------------------------'

And the following is the new data with cookie match checking,
coresched-SMT is coresched_v4 plus my patches.
.--------------------------------------------------------------------------------------------------------------------------------------.
|NA/AVX	vanilla-SMT	[std% / sem%]	  cpu% |coresched-SMT	[std% / sem%]	  +/-	  cpu% |  no-SMT [std% / sem%]	 +/-	  cpu% |
|--------------------------------------------------------------------------------------------------------------------------------------|
|  1/1	     1018.2	[ 1.0%/ 0.1%]	  1.9% |        901.2	[ 0.7%/ 0.1%]	-11.5%	  1.9% |   994.0 [ 1.4%/ 0.2%]  -2.4%	  3.9% |
|  2/2	     1941.2	[ 0.7%/ 0.1%]	  3.9% |       1733.9	[ 0.8%/ 0.1%]	-10.7%	  3.9% |  1946.2 [ 0.8%/ 0.1%]   0.3%	  7.8% |
|  4/4	     3763.9	[ 0.5%/ 0.0%]	  7.8% |       3429.4	[ 1.0%/ 0.1%]	 -8.9%	  7.8% |  3745.1 [ 1.1%/ 0.1%]  -0.5%	 15.6% |
|  8/8	     7375.5	[ 1.3%/ 0.1%]	 15.5% |       6571.3	[ 1.2%/ 0.1%]	-10.9%	 16.1% |  7368.4 [ 0.8%/ 0.1%]  -0.1%	 31.1% |
| 16/16	    12990.3	[ 0.6%/ 0.1%]	 31.1% |       9365.1	[ 2.6%/ 0.3%]	-27.9%	 31.1% | 12082.6 [ 4.7%/ 0.6%]  -7.0%	 62.9% |
| 32/32	    18238.1	[ 6.1%/ 0.6%]	 62.1% |      16181.9	[ 4.0%/ 0.4%]	-11.3%	 63.6% | 21193.6 [ 4.9%/ 0.6%]  16.2%	 97.8% |
| 48/48	    21708.6	[ 8.3%/ 0.8%]	 90.3% |      18390.4	[ 6.0%/ 0.6%]	-15.3%	 85.3% | 18531.4 [16.6%/ 1.7%] -14.6%	 99.5% |
| 64/64	    18636.9	[13.1%/ 1.3%]	 97.9% |      12831.7	[22.5%/ 2.2%]	-31.1%	 96.2% | 20025.8 [14.9%/ 2.3%]   7.5%	100.0% |
|128/128    16204.2	[16.8%/ 1.7%]	 99.4% |      10199.4	[16.3%/ 1.6%]	-37.1%	 97.9% | 20263.5 [12.7%/ 2.5%]  25.1%	100.0% |
|256/256    16730.5	[17.9%/ 1.8%]	 98.9% |       7739.4	[15.6%/ 1.6%]	-53.7%	 96.4% | 17633.1 [ 7.5%/ 1.7%]   5.4%	100.0% |
'--------------------------------------------------------------------------------------------------------------------------------------'

This may be the workload specific. Looking forward to more testing and comments.

Thanks,
-Aubrey
----------------------------------------------------------------------
From 48f27dde3a54915c25f08b0dfff0a8d148cd6093 Mon Sep 17 00:00:00 2001
From: Aubrey Li <aubrey.li@intel.com>
Date: Fri, 1 Nov 2019 14:17:01 +0800
Subject: [PATCH 1/3] sched/fair: don't migrate task if cookie not match

Load balance tries to move task from busiest CPU to the destination
CPU. When core scheduling is enabled, if the task's cookie does not
match with the destination CPU's core cookie, this task will be
skipped by this CPU. This mitigates the forced idle time on the
destination CPU.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 kernel/sched/fair.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4728f5e..ba937b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7366,8 +7366,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	 * We do not migrate tasks that are:
 	 * 1) throttled_lb_pair, or
 	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 3) running (obviously), or
-	 * 4) are cache-hot on their current CPU.
+	 * 3) task's cookie does not match with this CPU's core cookie
+	 * 4) running (obviously), or
+	 * 5) are cache-hot on their current CPU.
 	 */
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
@@ -7402,6 +7403,17 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 0;
 	}
 
+#ifdef CONFIG_SCHED_CORE
+	if (sched_core_enabled(cpu_rq(env->dst_cpu))) {
+		/*
+		 * Don't migrate task if task's cookie does not match
+		 * with core cookie
+		 */
+		if (p->core_cookie != cpu_rq(env->dst_cpu)->core->core_cookie)
+			return 0;
+	}
+#endif
+
 	/* Record that we found atleast one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
-- 
2.7.4

----------------------------------------------------------------------
From c6cd478408097c47f60a124bf67562d0e2994f7d Mon Sep 17 00:00:00 2001
From: Aubrey Li <aubrey.li@intel.com>
Date: Fri, 1 Nov 2019 14:28:09 +0800
Subject: [PATCH 2/3] sched/fair: select cookie matched idle CPU

In the fast path of task wakeup, select the first cookie matched idle
CPU instead of the first idle CPU.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 kernel/sched/fair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ba937b9..19ea8d8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6074,7 +6074,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 			continue;
 		if (available_idle_cpu(cpu))
+#ifdef CONFIG_SCHED_CORE
+			if (sched_core_enabled(cpu_rq(cpu)) &&
+			    (p->core_cookie == cpu_rq(cpu)->core->core_cookie))
+				break;
+#else
 			break;
+#endif
 	}
 
 	time = cpu_clock(this) - time;
-- 
2.7.4

----------------------------------------------------------------------
From 1dc91d6b3e95c81d1387f4989f160a1a9924a8f4 Mon Sep 17 00:00:00 2001
From: Aubrey Li <aubrey.li@intel.com>
Date: Fri, 1 Nov 2019 14:49:00 +0800
Subject: [PATCH 3/3] sched/fair: find cookie matched idlest CPU

In the slow path of task wakeup, find the idlest CPU whose core
cookie matches with task's cookie

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 kernel/sched/fair.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19ea8d8..3aec68a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5692,6 +5692,22 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 					p->cpus_ptr))
 			continue;
 
+#ifdef CONFIG_SCHED_CORE
+		if (sched_core_enabled(cpu_rq(this_cpu))) {
+			bool cookie_match = false;
+
+			for_each_cpu(i, sched_group_span(group)) {
+				struct rq *rq = cpu_rq(i);
+
+				if (p->core_cookie == rq->core->core_cookie)
+					cookie_match = true;
+			}
+			/* Skip over this group if no cookie matched */
+			if (!cookie_match)
+				continue;
+		}
+#endif
+
 		local_group = cpumask_test_cpu(this_cpu,
 					       sched_group_span(group));
 
@@ -5817,8 +5833,14 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
+		struct rq *rq = cpu_rq(i);
+
+#ifdef CONFIG_SCHED_CORE
+		if (sched_core_enabled(rq) && (p->core_cookie !=
+			rq->core->core_cookie))
+			continue;
+#endif
 		if (available_idle_cpu(i)) {
-			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
 				/*
-- 
2.7.4

