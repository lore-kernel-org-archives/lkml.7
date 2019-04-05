Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843D8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B13205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfDEO6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:58:18 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48858 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbfDEO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:58:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TOZE.oT_1554476132;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TOZE.oT_1554476132)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Apr 2019 22:55:42 +0800
Date:   Fri, 5 Apr 2019 22:55:32 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190405145530.GA453@aaronlu>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.667598558@infradead.org>
 <20190402064612.GA46500@aaronlu>
 <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:28:12AM +0200, Peter Zijlstra wrote:
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
		                                         ~~~
I think <= should be used here, so that two tasks with the same vruntime
will return false. Or we could bounce two tasks having different tags
with one set to max in the first round and the other set to max in the
next round. CPU would stuck in __schedule() with irq disabled.

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

After some testing, I figured task_cfs_rq() should be used instead of
task_rq(:-)

With the two changes(and some other minor ones that still need more time
to sort out), I'm now able to start doing 2 full CPU kbuilds in 2 tagged
cgroups. Previouslly, the system would hang pretty soon after I started
kbuild in any tagged cgroup(presumbly, CPUs stucked in __schedule() with
irqs disabled).

And there is no warning appeared due to two tasks having different tags
get scheduled on the same CPU.

Thanks,
Aaron

> +
> +	return __prio_less(a, b, vruntime);
>  }
>  
>  static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
