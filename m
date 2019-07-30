Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7ADC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AAE20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yda1/XJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbfG3Jge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:36:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56488 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731650AbfG3Jgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BjOHjVPfh/LIDc/7yA8zCGr8rEtbAuSVPSXO0TtCsmw=; b=Yda1/XJjb3FN+q2ECDJ6KEagM
        ssrhRStV83jWbvjnRgBm4fIf0BySi2pU8EmlG1CVG6llnlNT2ROpmZ1k/0wdr1T4il5KRcgzOXRY1
        pZSxaC8CuYkwo49Ou5K5mcpbjII5VAtWsT9fFZdryg4TaTGb/ZSCX5wxcswS9EeK+iE2fYJ+7jTPB
        aw6JDXO3ptJ93jRGtmec0PMMwCP8uikcIYbDAc7lmSogV4ml8q8l41vyAspIIiT4rOnxwSP435Ckw
        poCOgxq6WRUm4Z9aBoOQuYOWo7w9PiShNmnlh0ZuCZnBYK66uhmBmyUmpdhfal6aMhH/sG5odmrt6
        GmZJFR6rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsOYO-00062W-Kf; Tue, 30 Jul 2019 09:36:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7558520AFFE9E; Tue, 30 Jul 2019 11:36:17 +0200 (CEST)
Date:   Tue, 30 Jul 2019 11:36:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH 09/14] sched,fair: refactor enqueue/dequeue_entity
Message-ID: <20190730093617.GV31398@hirez.programming.kicks-ass.net>
References: <20190722173348.9241-1-riel@surriel.com>
 <20190722173348.9241-10-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722173348.9241-10-riel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:33:43PM -0400, Rik van Riel wrote:
> Refactor enqueue_entity, dequeue_entity, and update_load_avg, in order
> to split out the things we still want to happen at every level in the
> cgroup hierarchy with a flat runqueue from the things we only need to
> happen once.
> 
> No functional changes.

> @@ -3500,7 +3500,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  #define DO_ATTACH	0x4
>  
>  /* Update task and its cfs_rq load average */
> -static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
>  	u64 now = cfs_rq_clock_pelt(cfs_rq);
>  	int decayed;
> @@ -3529,6 +3529,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  
>  	} else if (decayed && (flags & UPDATE_TG))
>  		update_tg_load_avg(cfs_rq, 0);
> +
> +	return decayed;
>  }
>  
>  #ifndef CONFIG_64BIT
> @@ -3745,9 +3747,10 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  #define SKIP_AGE_LOAD	0x0
>  #define DO_ATTACH	0x0
>  
> -static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
> +static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
>  {
>  	cfs_rq_util_change(cfs_rq, 0);
> +	return false;
>  }
>  
>  static inline void remove_entity_load_avg(struct sched_entity *se) {}
> @@ -3870,6 +3873,24 @@ static inline void check_schedstat_required(void)
>   * CPU and an up-to-date min_vruntime on the destination CPU.
>   */
>  
> +static bool
> +enqueue_entity_groups(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +{
> +	/*
> +	 * When enqueuing a sched_entity, we must:
> +	 *   - Update loads to have both entity and cfs_rq synced with now.
> +	 *   - Add its load to cfs_rq->runnable_avg
> +	 *   - For group_entity, update its weight to reflect the new share of
> +	 *     its group cfs_rq
> +	 *   - Add its new weight to cfs_rq->load.weight
> +	 */
> +	if (!update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH))
> +		return false;
> +
> +	update_cfs_group(se);
> +	return true;
> +}
> +
>  static void
>  enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> @@ -3894,16 +3915,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	if (renorm && !curr)
>  		se->vruntime += cfs_rq->min_vruntime;
>  
> -	/*
> -	 * When enqueuing a sched_entity, we must:
> -	 *   - Update loads to have both entity and cfs_rq synced with now.
> -	 *   - Add its load to cfs_rq->runnable_avg
> -	 *   - For group_entity, update its weight to reflect the new share of
> -	 *     its group cfs_rq
> -	 *   - Add its new weight to cfs_rq->load.weight
> -	 */
> -	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
> -	update_cfs_group(se);
>  	enqueue_runnable_load_avg(cfs_rq, se);
>  	account_entity_enqueue(cfs_rq, se);
>  

No functional, but you did make update_cfs_group() conditional. Now that
looks OK, but maybe you can do that part in a separate patch with a
little justification of its own.
