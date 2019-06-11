Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC28C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0659F208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbfFKNE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:04:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387657AbfFKNEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:04:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54CEC31628E0;
        Tue, 11 Jun 2019 13:04:20 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 481FF27091;
        Tue, 11 Jun 2019 13:04:19 +0000 (UTC)
Date:   Tue, 11 Jun 2019 09:04:17 -0400
From:   Phil Auld <pauld@redhat.com>
To:     bsegall@google.com
Cc:     linux-kernel@vger.kernel.org,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] sched/fair: don't push cfs_bandwith slack timers
 forward
Message-ID: <20190611130417.GA15412@pauld.bos.csb>
References: <xm26ef47yeyh.fsf@bsegall-linux.svl.corp.google.com>
 <eafe846f-d83c-b2f3-4458-45e3ae6e5823@linux.alibaba.com>
 <xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 11 Jun 2019 13:04:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:21:01AM -0700 bsegall@google.com wrote:
> When a cfs_rq sleeps and returns its quota, we delay for 5ms before
> waking any throttled cfs_rqs to coalesce with other cfs_rqs going to
> sleep, as this has to be done outside of the rq lock we hold.
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
> Reviewed-by: Xunlei Pang <xlpang@linux.alibaba.com>
> ---
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
> -- 
> 2.22.0.rc1.257.g3120a18244-goog
> 

I think this looks good. I like not delaying that further even if it
does not fix Dave's use case. 

It does make it glaring that I should have used false/true for setting
distribute_running though :)


Acked-by: Phil Auld <pauld@redhat.com>

-- 
