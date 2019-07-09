Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1DEC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CB6214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xzCXfbzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfGINvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:51:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38728 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGINvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hl0+rltCj7A4DwHLnmy+27zNEkIbfMaqSjIVhe+Ho0M=; b=xzCXfbzr5fF5j7nABfmHnBPAw
        S2zMXTMeX7gnhCmYSookkMqPcBPcNweok0psXUJwS3/7vv10XlH+m9EfOplvE8vRxySc9iKxFloNJ
        j5OtxT37aagyEbj8zVuH2AEQejbzVuZaOZrV0SzbxMcp8j4Wx501XroNMb1xf2qSdvwP7pxFvp38i
        La+R7ekABmbSWsMmrOz+szPJOuj7HOyULQaHjkI1noEgsY5AViDO/Okp3CmNmmRlJC1+72qOeS/X2
        JC+GMM9bmOI0Cjlcsu2JLCESnyYF2Sc2CiCAUdZM2hx7JgA6ehnPOioK2QchxEWAplLxfH83xMMJT
        8XP3noOcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkqWF-0006uy-NH; Tue, 09 Jul 2019 13:50:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76FD320976EE5; Tue,  9 Jul 2019 15:50:54 +0200 (CEST)
Date:   Tue, 9 Jul 2019 15:50:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Redpath <chris.redpath@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Update rq_clock, cfs_rq before migrating for
 asym cpu capacity
Message-ID: <20190709135054.GF3402@hirez.programming.kicks-ass.net>
References: <20190709115759.10451-1-chris.redpath@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709115759.10451-1-chris.redpath@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 12:57:59PM +0100, Chris Redpath wrote:
> The ancient workaround to avoid the cost of updating rq clocks in the
> middle of a migration causes some issues on asymmetric CPU capacity
> systems where we use task utilization to determine which cpus fit a task.
> On quiet systems we can inflate task util after a migration which
> causes misfit to fire and force-migrate the task.
> 
> This occurs when:
> 
> (a) a task has util close to the non-overutilized capacity limit of a
>     particular cpu (cpu0 here); and
> (b) the prev_cpu was quiet otherwise, such that rq clock is
>     sufficiently out of date (cpu1 here).
> 
> e.g.
>                               _____
> cpu0: ________________________|   |______________
> 
>                                   |<- misfit happens
>           ______                  ___         ___
> cpu1: ____|    |______________|___| |_________|
> 
>              ->|              |<- wakeup migration time
> last rq clock update
> 
> When the task util is in just the right range for the system, we can end
> up migrating an unlucky task back and forth many times until we are lucky
> and the source rq happens to be updated close to the migration time.
> 
> In order to address this, lets update both rq_clock and cfs_rq where
> this could be an issue.

Can you quantify how much of a problem this really is? It is really sad,
but this is already the second place where we take rq->lock on
migration. We worked so hard to avoid having to acquire it :/

> Signed-off-by: Chris Redpath <chris.redpath@arm.com>
> ---
>  kernel/sched/fair.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b798fe7ff7cd..51791db26a2a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6545,6 +6545,21 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  		 * wakee task is less decayed, but giving the wakee more load
>  		 * sounds not bad.
>  		 */
> +		if (static_branch_unlikely(&sched_asym_cpucapacity) &&
> +			p->state == TASK_WAKING) {

nit: indent fail.

> +			/*
> +			 * On asymmetric capacity systems task util guides
> +			 * wake placement so update rq_clock and cfs_rq
> +			 */
> +			struct cfs_rq *cfs_rq = task_cfs_rq(p);
> +			struct rq *rq = task_rq(p);
> +			struct rq_flags rf;
> +
> +			rq_lock_irqsave(rq, &rf);
> +			update_rq_clock(rq);
> +			update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> +			rq_unlock_irqrestore(rq, &rf);
> +		}
>  		remove_entity_load_avg(&p->se);
>  	}
>  
> -- 
> 2.17.1
> 
