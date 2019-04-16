Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B65AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2BA21924
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfDPNoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:44:03 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42808 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbfDPNoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:44:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TPTXiJY_1555422231;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TPTXiJY_1555422231)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Apr 2019 21:43:58 +0800
Date:   Tue, 16 Apr 2019 21:43:51 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aubrey Li <aubrey.intel@gmail.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190416134350.GA66092@aaronlu>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.667598558@infradead.org>
 <20190402064612.GA46500@aaronlu>
 <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:28:12AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 02, 2019 at 02:46:13PM +0800, Aaron Lu wrote:
...
> > Perhaps we can test if max is on the same cpu as class_pick and then
> > use cpu_prio_less() or core_prio_less() accordingly here, or just
> > replace core_prio_less(max, p) with cpu_prio_less(max, p) in
> > pick_next_task(). The 2nd obviously breaks the comment of
> > core_prio_less() though: /* cannot compare vruntime across CPUs */.
> 
> Right, so as the comment states, you cannot directly compare vruntime
> across CPUs, doing that is completely buggered.
> 
> That also means that the cpu_prio_less(max, class_pick) in pick_task()
> is buggered, because there is no saying @max is on this CPU to begin
> with.

I find it difficult to decide which task of fair_sched_class having
higher priority when the two tasks belong to different CPUs.

Please see below.

> Another approach would be something like the below:
> 
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -87,7 +87,7 @@ static inline int __task_prio(struct tas
>   */
>  
>  /* real prio, less is less */
> -static inline bool __prio_less(struct task_struct *a, struct task_struct *b, bool runtime)
> +static inline bool __prio_less(struct task_struct *a, struct task_struct *b, u64 vruntime)
>  {
>  	int pa = __task_prio(a), pb = __task_prio(b);
>  
> @@ -104,21 +104,25 @@ static inline bool __prio_less(struct ta
>  	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
>  		return !dl_time_before(a->dl.deadline, b->dl.deadline);
>  
> -	if (pa == MAX_RT_PRIO + MAX_NICE && runtime) /* fair */
> -		return !((s64)(a->se.vruntime - b->se.vruntime) < 0);
> +	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
> +		return !((s64)(a->se.vruntime - vruntime) < 0);
>  
>  	return false;
>  }
>  
>  static inline bool cpu_prio_less(struct task_struct *a, struct task_struct *b)
>  {
> -	return __prio_less(a, b, true);
> +	return __prio_less(a, b, b->se.vruntime);
>  }
>  
>  static inline bool core_prio_less(struct task_struct *a, struct task_struct *b)
>  {
> -	/* cannot compare vruntime across CPUs */
> -	return __prio_less(a, b, false);
> +	u64 vruntime = b->se.vruntime;
> +
> +	vruntime -= task_rq(b)->cfs.min_vruntime;
> +	vruntime += task_rq(a)->cfs.min_vruntime

(I used task_cfs_rq() instead of task_rq() above.)

Consider the following scenario:
(assume cpu0 and cpu1 are siblings of core0)

1 a cpu-intensive task belonging to cgroupA running on cpu0;
2 launch 'ls' from a shell(bash) which belongs to cgroupB;
3 'ls' blocked for a long time(if not forever).

Per my limited understanding: the launch of 'ls' cause bash to fork,
then the newly forked process' vruntime will be 6ms(probably not
precise) ahead of its cfs_rq due to START_DEBIT. Since there is no other
running task on that cfs_rq, the cfs_rq's min_vruntime doesn't have a
chance to get updated and the newly forked process will always have a
distance of 6ms compared to its cfs_rq and it will always 'lose' to the
cpu-intensive task belonging to cgroupA by core_prio_less().

No idea how to solve this...

> +
> +	return __prio_less(a, b, vruntime);
>  }
>  
>  static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
