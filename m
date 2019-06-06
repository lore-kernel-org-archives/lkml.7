Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3E4C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6AB20673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfFFOLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:11:41 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35153 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbfFFOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:11:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TTaIHVa_1559830289;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0TTaIHVa_1559830289)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Jun 2019 22:11:30 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] sched/fair: don't push cfs_bandwith slack timers forward
To:     bsegall@google.com, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>
References: <xm26ef47yeyh.fsf@bsegall-linux.svl.corp.google.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <eafe846f-d83c-b2f3-4458-45e3ae6e5823@linux.alibaba.com>
Date:   Thu, 6 Jun 2019 22:11:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <xm26ef47yeyh.fsf@bsegall-linux.svl.corp.google.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/6 AM 4:06, bsegall@google.com wrote:
> When a cfs_rq sleeps and returns its quota, we delay for 5ms before
> waking any throttled cfs_rqs to coalesce with other cfs_rqs going to
> sleep, as this has has to be done outside of the rq lock we hold.

two "has".

> 
> The current code waits for 5ms without any sleeps, instead of waiting
> for 5ms from the first sleep, which can delay the unthrottle more than
> we want. Switch this around so that we can't push this forward forever.
> 
> This requires an extra flag rather than using hrtimer_active, since we
> need to start a new timer if the current one is in the process of
> finishing.
> 
> Signed-off-by: Ben Segall <bsegall@google.com>
> ---

We've also suffered from this performance issue recently:
Reviewed-by: Xunlei Pang <xlpang@linux.alibaba.com>

>  kernel/sched/fair.c  | 7 +++++++
>  kernel/sched/sched.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8213ff6e365d..2ead252cfa32 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4729,6 +4729,11 @@ static void start_cfs_slack_bandwidth(struct cfs_bandwidth *cfs_b)
>  	if (runtime_refresh_within(cfs_b, min_left))
>  		return;
>  
> +	/* don't push forwards an existing deferred unthrottle */
> +	if (cfs_b->slack_started)
> +		return;
> +	cfs_b->slack_started = true;
> +
>  	hrtimer_start(&cfs_b->slack_timer,
>  			ns_to_ktime(cfs_bandwidth_slack_period),
>  			HRTIMER_MODE_REL);
> @@ -4782,6 +4787,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>  
>  	/* confirm we're still not at a refresh boundary */
>  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> +	cfs_b->slack_started = false;
>  	if (cfs_b->distribute_running) {
>  		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  		return;
> @@ -4920,6 +4926,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
>  	cfs_b->distribute_running = 0;
> +	cfs_b->slack_started = false;
>  }
>  
>  static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index efa686eeff26..60219acda94b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -356,6 +356,7 @@ struct cfs_bandwidth {
>  	u64			throttled_time;
>  
>  	bool                    distribute_running;
> +	bool                    slack_started;
>  #endif
>  };
>  
> 
