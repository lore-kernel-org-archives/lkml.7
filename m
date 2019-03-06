Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E474C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF43206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="csMyyHvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfCFKJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:09:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40792 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbfCFKJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mbAFQfrua3LFcwC9n1LQJ6VRsjyd4tKMk9+m8oI3H4M=; b=csMyyHvSAlxvrvq/yaA8F2Tug
        r9yI8HVLTpgG7gX224QuFDN+nW0r9O3IcqEnkRcLl3GQvE5ZaTgVnfrSW1iQ/kCpq0q77h1vR9a05
        +hD+1BV+oTzYopRspAn0EdEZ1bQwUGV2SDJ8eVPLfSpi52j58QINgYH04m65x+zZbt4+fJQjtWHC6
        3xNcML/xQGwXAjQMv6zEcxgHmpAWvwNOK0A6S+FbO9GRSyT1MnPqeblZhgL2TLBz1QRWV3gkaePOS
        4yU1YnANPNGXB7KiIHLZc7/753zDtW1bZ9jt4ZfFBndh6EZHoUyjODtnHoZQFpIijTM0M/jgjZCxW
        Lozw11pnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1TU5-0001Yp-Rb; Wed, 06 Mar 2019 10:09:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2290D2029E064; Wed,  6 Mar 2019 11:09:07 +0100 (CET)
Date:   Wed, 6 Mar 2019 11:09:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        shaoyafang@didiglobal.com
Subject: Re: [PATCH] sched: fair: fix missed CONFIG_SCHEDSTATS
Message-ID: <20190306100907.GT32477@hirez.programming.kicks-ass.net>
References: <1551861826-12592-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551861826-12592-1-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 04:43:46PM +0800, Yafang Shao wrote:
> When I'm using trace_sched_stat_{iowait, blocked, wait, sleep} to
> measure how long the processes are stalled, there's always no output from
> trace_pipe while there're really some tasks in uninterruptible sleep
> state. That makes me confused, so I try to investigate why.
> Finally I find the reason is that CONFIG_SCHEDSTATS is not set.
> 
> To avoid such kind of confusion, we should not expose these tracepoints
> if CONFIG_SCHEDSTATS is not set.

Yeah, lets not sprinkle #ifdef. Big fat NAK.

Also, the below seem to indicate your compiler is stupid. Without
CONFIG_SCHEDSTAT, schedstat_enabled() should be a constant 0 and DCE
should delete all code.

> @@ -976,6 +982,7 @@ static void update_curr_fair(struct rq *rq)
>  static inline void
>  update_stats_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> +#ifdef CONFIG_SCHEDSTATS
>  	if (!schedstat_enabled())
>  		return;
>  
> @@ -988,12 +995,13 @@ static void update_curr_fair(struct rq *rq)
>  
>  	if (flags & ENQUEUE_WAKEUP)
>  		update_stats_enqueue_sleeper(cfs_rq, se);
> +#endif
>  }
>  
>  static inline void
>  update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> -
> +#ifdef CONFIG_SCHEDSTATS
>  	if (!schedstat_enabled())
>  		return;
>  
> @@ -1014,6 +1022,7 @@ static void update_curr_fair(struct rq *rq)
>  			__schedstat_set(se->statistics.block_start,
>  				      rq_clock(rq_of(cfs_rq)));
>  	}
> +#endif
>  }
>  
>  /*
> @@ -4090,6 +4099,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	update_stats_curr_start(cfs_rq, se);
>  	cfs_rq->curr = se;
>  
> +#ifdef CONFIG_SCHEDSTATS
>  	/*
>  	 * Track our maximum slice length, if the CPU's load is at
>  	 * least twice that of our own weight (i.e. dont track it
> @@ -4100,6 +4110,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  			max((u64)schedstat_val(se->statistics.slice_max),
>  			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
>  	}
> +#endif
>  
>  	se->prev_sum_exec_runtime = se->sum_exec_runtime;
>  }
> -- 
> 1.8.3.1
> 
