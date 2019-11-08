Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9356AC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFB02084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfKHDUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:20:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:2306 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfKHDUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:20:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 19:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,280,1569308400"; 
   d="scan'208";a="213157134"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2019 19:20:00 -0800
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
 <fa51e794-6e46-1c25-a405-8a92f8dac96f@linux.intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <62ab08b1-b5f9-243e-e884-8307d57b09d0@linux.intel.com>
Date:   Fri, 8 Nov 2019 11:20:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <fa51e794-6e46-1c25-a405-8a92f8dac96f@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/1 19:33, Li, Aubrey wrote:
> On 2019/10/31 19:42, Li, Aubrey wrote:
>> On 2019/10/31 2:33, Vineeth Remanan Pillai wrote:
>>> Fourth iteration of the Core-Scheduling feature.
>>>
>>> This version was aiming mostly at addressing the vruntime comparison
>>> issues with v3. The main issue seen in v3 was the starvation of
>>> interactive tasks when competing with cpu intensive tasks. This issue
>>> is mitigated to a large extent.
>>>
>>> We have tested and verified that incompatible processes are not
>>> selected during schedule. In terms of performance, the impact
>>> depends on the workload:
>>> - on CPU intensive applications that use all the logical CPUs with
>>>   SMT enabled, enabling core scheduling performs better than nosmt.
>>> - on mixed workloads with considerable io compared to cpu usage,
>>>   nosmt seems to perform better than core scheduling.
>>>
>>> v4 is rebased on top of 5.3.5(dc073f193b70):
>>> https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.3.5
>>
>> Thanks to post V4 out. Refresh the data on my side. Since we have played
>> with Aaron's core vruntime patch for a while, no surprise in the result.
>>
> I have three small patches against V4. The basic idea is,
> - for load balance, don't pull/push task if its cookie does not match with
> destination CPU's core cookie
> - for task wakeup, select idle CPU whose core cookie matches with task's
> cookie.
> 
> Sysbench MySQL result shows significant improvement for the overload cases.
>
> This may be the workload specific. Looking forward to more testing and comments.
> 

Here is another one for task numa migration. We saw significant latency
improvement of workload sysbench MYSQL+gemmbench, for the overloaded case
on a 8-node system, the latency is reduced from 93.78ms to 28.36ms. So I
think it's worth to post this twist to draw more ideas and better solutions.

Thanks,
-Aubrey

----------------------------------------------------------------------
From 89fc5fd70d5dcc426dc4724afdf35d2c916cd303 Mon Sep 17 00:00:00 2001
From: Aubrey Li <aubrey.li@intel.com>
Date: Thu, 7 Nov 2019 14:51:28 +0800
Subject: [PATCH 1/2] sched/numa: don't migrate task if cookie not match

For the NUMA load balance, don't migrate task to the CPU whose core
cookie does not match with task's cookie

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3aec68a..2909030 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1827,6 +1827,16 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
 			continue;
 
+#ifdef CONFIG_SCHED_CORE
+		/*
+		 * Skip this cpu if source task's cookie does not match
+		 * with CPU's core cookie.
+		 */
+		if (sched_core_enabled(cpu_rq(cpu)) && (env->p->core_cookie !=
+		    cpu_rq(cpu)->core->core_cookie))
+				continue;
+#endif
+
 		env->dst_cpu = cpu;
 		task_numa_compare(env, taskimp, groupimp, maymove);
 	}
-- 
2.7.4


