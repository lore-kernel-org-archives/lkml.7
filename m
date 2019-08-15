Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AC3C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D540121743
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbfHOQgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:36:47 -0400
Received: from foss.arm.com ([217.140.110.172]:46420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbfHOQgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:36:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 620AA28;
        Thu, 15 Aug 2019 09:36:46 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25F4A3F706;
        Thu, 15 Aug 2019 09:36:44 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: don't assign runtime for throttled cfs_rq
To:     Liangyan <liangyan.peng@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     shanpeic@linux.alibaba.com, xlpang@linux.alibaba.com
References: <20190814180021.165389-1-liangyan.peng@linux.alibaba.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <2994a6ee-9238-5285-3227-cb7084a834c8@arm.com>
Date:   Thu, 15 Aug 2019 17:36:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190814180021.165389-1-liangyan.peng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2019 19:00, Liangyan wrote:
> do_sched_cfs_period_timer() will refill cfs_b runtime and call
> distribute_cfs_runtime() to unthrottle cfs_rq, sometimes cfs_b->runtime
> will allocate all quota to one cfs_rq incorrectly.

> This will cause other cfs_rq can't get runtime and will be throttled.
> We find that one throttled cfs_rq has non-negative
> cfs_rq->runtime_remaining and cause an unexpetced cast from s64 to u64
> in snippet: distribute_cfs_runtime() {
> runtime = -cfs_rq->runtime_remaining + 1; }.

> This cast will cause that runtime will be a large number and
> cfs_b->runtime will be subtracted to be zero at last.
> 

I'm a complete CFS bandwidth noob but let me give this a try...


-Wconversion does pick this up (turning this thing on made me understand
why it's not on by default)

kernel/sched/fair.c: In function ‘distribute_cfs_runtime’:
kernel/sched/fair.c:4633:13: warning: conversion to ‘u64’ {aka ‘long long unsigned int’} from ‘s64’ {aka ‘long long int’} may change the sign of the result [-Wsign-conversion]
   runtime = -cfs_rq->runtime_remaining + 1;
             ^
kernel/sched/fair.c:4638:29: warning: conversion to ‘long long unsigned int’ from ‘s64’ {aka ‘long long int’} may change the sign of the result [-Wsign-conversion]
   cfs_rq->runtime_remaining += runtime;
                             ^~


The thing is we have a !cfs_rq_throttled() check just before the snippet
you're calling out, so AFAICT cfs_rq->runtime_remaining has to be <= 0
there (otherwise this cfs_rq wouldn't be throttled).

I doubt you can get this to fire, but just to be sure...
-----8<-----
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bbd90adabe2a..836948a3ae23 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4630,6 +4630,8 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
+		WARN_ON(cfs_rq->runtime_remaining > 0);
+
 		runtime = -cfs_rq->runtime_remaining + 1;
 		if (runtime > remaining)
 			runtime = remaining;
----->8-----

Other than those signed/unsigned shenanigans, I only see one other scenario
that leads to a cfs_rq getting allocated all the remaining runtime: its
.runtime_remaining just has to be greater or equal (in absolute value)
than the remaining runtime.

If that's happening consistently, I suppose that could be due to long
delays between update_curr_fair() calls, but I can't think right why that
would happen.

> This commit prevents cfs_rq to be assgined new runtime if it has been
> throttled to avoid the above incorrect type cast.
> 
> Signed-off-by: Liangyan <liangyan.peng@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 81fd8a2a605b..b14d67d28138 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4068,6 +4068,8 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
>  	if (likely(cfs_rq->runtime_remaining > 0))
>  		return;
>  
> +	if (cfs_rq->throttled)
> +		return;
>  	/*
>  	 * if we're unable to extend our runtime we resched so that the active
>  	 * hierarchy can be throttled
> 
