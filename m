Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A34C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F350621734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfD3Pp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:45:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:20895 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfD3Pp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:45:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 08:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="166308278"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 30 Apr 2019 08:45:58 -0700
Received: from [10.254.90.156] (kliang2-mobl.ccr.corp.intel.com [10.254.90.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1CD84580372;
        Tue, 30 Apr 2019 08:45:58 -0700 (PDT)
Subject: Re: [PATCH 1/4] perf: Fix system-wide events miscounting during
 cgroup monitoring
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        eranian@google.com, tj@kernel.org, ak@linux.intel.com
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
 <1556549045-71814-2-git-send-email-kan.liang@linux.intel.com>
 <20190430085640.GJ2623@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9c367dc6-7c1c-5db4-2d41-50d7efdd0c00@linux.intel.com>
Date:   Tue, 30 Apr 2019 11:45:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430085640.GJ2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/2019 4:56 AM, Peter Zijlstra wrote:
> On Mon, Apr 29, 2019 at 07:44:02AM -0700, kan.liang@linux.intel.com wrote:
> 
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index e47ef76..039e2f2 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -795,6 +795,7 @@ struct perf_cpu_context {
>>   #ifdef CONFIG_CGROUP_PERF
>>   	struct perf_cgroup		*cgrp;
>>   	struct list_head		cgrp_cpuctx_entry;
>> +	unsigned int			cgrp_switch		:1;
> 
> If you're not adding more bits, why not just keep it an int?
>

Yes, there is no more bits for now.
Sure, I will change it to int.


>>   #endif
>>   
>>   	struct list_head		sched_cb_entry;
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index dc7dead..388dd42 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -809,6 +809,7 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
>>   
>>   		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>>   		perf_pmu_disable(cpuctx->ctx.pmu);
>> +		cpuctx->cgrp_switch = true;
>>   
>>   		if (mode & PERF_CGROUP_SWOUT) {
>>   			cpu_ctx_sched_out(cpuctx, EVENT_ALL);
>> @@ -832,6 +833,7 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
>>   							     &cpuctx->ctx);
>>   			cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
>>   		}
>> +		cpuctx->cgrp_switch = false;
>>   		perf_pmu_enable(cpuctx->ctx.pmu);
>>   		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>>   	}
> 
> That is a bit of a hack...

We need an indicator to indicate the context switch, so we can apply the 
optimization.
I was thinking to use the existing variables, e.g. cpuctx->cgrp. But it 
doesn't work. We cannot tell if it's the first sched_in or in a context 
switch by checking cpuctx->cgrp.
cgrp_switch should be the simplest method.

> 
>> @@ -2944,13 +2946,25 @@ static void ctx_sched_out(struct perf_event_context *ctx,
>>   
>>   	perf_pmu_disable(ctx->pmu);
>>   	if (is_active & EVENT_PINNED) {
>> -		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
>> +		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list) {
>> +#ifdef CONFIG_CGROUP_PERF
>> +			/* Don't sched system-wide event when cgroup context switch */
>> +			if (cpuctx->cgrp_switch && !event->cgrp)
>> +				continue;
>> +#endif
>>   			group_sched_out(event, cpuctx, ctx);
>> +		}
>>   	}
> 
> This works by accident, however..
> 
>>   
>>   	if (is_active & EVENT_FLEXIBLE) {
>> -		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list)
>> +		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list) {
>> +#ifdef CONFIG_CGROUP_PERF
>> +			/* Don't sched system-wide event when cgroup context switch */
>> +			if (cpuctx->cgrp_switch && !event->cgrp)
>> +				continue;
>> +#endif
>>   			group_sched_out(event, cpuctx, ctx);
>> +		}
>>   	}
>>   	perf_pmu_enable(ctx->pmu);
>>   }
> 
> this one is just wrong afaict.
> 
> Suppose the new cgroup has pinned events, which we cannot schedule
> because you left !cgroup flexible events on.
> 

Right, the priority order may be changed.

I think we can track the event type in perf_cgroup.
If the new cgroup has pinned events, we can fall back to slow path, 
which will switch everything.

How about the patch as below? (Not test yet)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7eff286..f751852 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -843,6 +843,8 @@ struct perf_cgroup {
  	struct perf_cgroup_info	__percpu *info;
  	/* perf cgroup ID = (CPU ID << 32) | css subsys-unique ID */
  	u64 __percpu			*cgrp_id;
+
+	int				cgrp_event_type;
  };

  /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2066322..557d371 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -839,6 +839,22 @@ static void perf_cgroup_switch(struct task_struct 
*task, int mode)
  			 */
  			cpuctx->cgrp = perf_cgroup_from_task(task,
  							     &cpuctx->ctx);
+
+			/*
+			 * The system-wide events weren't sched out.
+			 * To keep the following priority order:
+			 * cpu pinned, cpu flexible
+			 * We need to switch system-wide events as well,
+			 * if the new cgroup has pinned events.
+			 *
+			 * Disable fast path and sched out the flexible events.
+			 */
+			if (cpuctx->cgrp->cgrp_event_type & EVENT_PINNED) {
+				/* disable fast path */
+				cpuctx->cgrp_switch = false;
+				cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
+			}
+
  			cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
  		}
  		cpuctx->cgrp_switch = false;
@@ -924,6 +940,11 @@ static inline int perf_cgroup_connect(int fd, 
struct perf_event *event,
  	cgrp = container_of(css, struct perf_cgroup, css);
  	event->cgrp = cgrp;

+	if (event->attr.pinned)
+		cgrp->cgrp_event_type |= EVENT_PINNED;
+	else
+		cgrp->cgrp_event_type |= EVENT_FLEXIBLE;
+
  	cgrp_id = ((u64)smp_processor_id() << 32) | css->id;
  	event->cgrp_id = cgrp_id;
  	*per_cpu_ptr(cgrp->cgrp_id, event->cpu) = cgrp_id;


Thanks,
Kan
