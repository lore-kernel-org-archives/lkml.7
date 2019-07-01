Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBBFC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806BF2146F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="fBN2ccnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfGAUeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:34:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42687 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAUeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:34:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so16087954qtk.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 13:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lxwf8EigDTjUMcQ2S9HrDomi73FeV7tK0TNhlwkjJJ4=;
        b=fBN2ccnTdlwh6wD4GrsEU2cappYiKGRWPcEDpigiXL8yZmJx5YyU/sxns42aXlHxTc
         xFP8d857+ij+9vYxJm8406EYo+FXrDbgdMRuhhNTOk0RgkFHMDjBFlEBVZ1RshXHOFJB
         cg6+obLCAe7mKO1ifpyqwYL59wt8ljYSLnYqWuW2Fwvywjnb80je7ElncazzfIQEPdxr
         +mMvfwNwAPkXr9N+g8Ie4dVpGQIbRFdiZRa/+YDWsguaE5iKKluj/w9bIH61NIqXlY8F
         h26Pe149nPr0/8KoQzTxk9BJ6dcaeKISnXayGt2Y4aEfDB5+Vd6GbjIVNX/llEWikELN
         welQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxwf8EigDTjUMcQ2S9HrDomi73FeV7tK0TNhlwkjJJ4=;
        b=ny55T0nhjkShGR4Vyb6z4zMm+yEgYxjs2Nh+HL/tZLejKQ1SOtmkdABp5E8w6JeS3x
         /LEIV408cMFt3Bqb8EN6rJczU5CcynodsPg5ZpOholCDRhH6wHz8S9fEX7735rghnBpp
         AlxJ8KpyBbWRlOLSATWF4Fus0Eh+pVZBEtzf2TWpOB0nWBJd5iZlqOZ32MY/H8BPBOz5
         GUSNYOwPne3yuoHDH+aGtKofhkPL+fLgUe2SMjyTAmoGgba7CjBk1boIsm/w97LHg6AE
         wDPaQ4eTFNazthgpW8O7dr+66IHoDBOOkdj6ZnooqrmkJPrE80EuYLgrmtk0nkvd0+1z
         6vFw==
X-Gm-Message-State: APjAAAXZlYKYRbLFU81TY6sadx7yQPoBI22yY7KeNfFW0SIa2xHyJ7GA
        EhxdtyAU9AIqeD4BPW0LnnPRqA==
X-Google-Smtp-Source: APXvYqwP0SrWHfHb4rOy0ljG1H7elw5F1/C/iiFjjQBp+29naGQOgHzJboOfBgeQWQX7F8fIJqHXeg==
X-Received: by 2002:ac8:7349:: with SMTP id q9mr22326933qtp.151.1562013249704;
        Mon, 01 Jul 2019 13:34:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::2ce6])
        by smtp.gmail.com with ESMTPSA id a21sm5511998qkg.47.2019.07.01.13.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 13:34:09 -0700 (PDT)
Date:   Mon, 1 Jul 2019 16:34:08 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH 10/10] sched,fair: flatten hierarchical runqueues
Message-ID: <20190701203407.4fmsavivebyrocmw@macbook-pro-91.dhcp.thefacebook.com>
References: <20190628204913.10287-1-riel@surriel.com>
 <20190628204913.10287-11-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628204913.10287-11-riel@surriel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:49:13PM -0400, Rik van Riel wrote:
> Flatten the hierarchical runqueues into just the per CPU rq.cfs runqueue.
> 
> Iteration of the sched_entity hierarchy is rate limited to once per jiffy
> per sched_entity, which is a smaller change than it seems, because load
> average adjustments were already rate limited to once per jiffy before this
> patch series.
> 
> This patch breaks CONFIG_CFS_BANDWIDTH. The plan for that is to park tasks
> from throttled cgroups onto their cgroup runqueues, and slowly (using the
> GENTLE_FAIR_SLEEPERS) wake them back up, in vruntime order, once the cgroup
> gets unthrottled, to prevent thundering herd issues.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  include/linux/sched.h |   2 +
>  kernel/sched/fair.c   | 452 +++++++++++++++---------------------------
>  kernel/sched/pelt.c   |   6 +-
>  kernel/sched/pelt.h   |   2 +-
>  kernel/sched/sched.h  |   2 +-
>  5 files changed, 171 insertions(+), 293 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 84a6cc6f5c47..901c710363e7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -453,6 +453,8 @@ struct sched_entity {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	int				depth;
>  	unsigned long			enqueued_h_load;
> +	unsigned long			enqueued_h_weight;
> +	struct load_weight		h_load;
>  	struct sched_entity		*parent;
>  	/* rq on which this entity is (to be) queued: */
>  	struct cfs_rq			*cfs_rq;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6fea8849cc12..c31d3da081fb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -450,6 +450,19 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
>  	}
>  }
>  
> +/* Add the cgroup cfs_rqs to the list, for update_blocked_averages */
> +static void enqueue_entity_cfs_rqs(struct sched_entity *se)
> +{
> +	SCHED_WARN_ON(!entity_is_task(se));
> +
> +	for_each_sched_entity(se) {
> +		struct cfs_rq *cfs_rq = group_cfs_rq_of_parent(se);
> +
> +		if (list_add_leaf_cfs_rq(cfs_rq))
> +			break;
> +	}
> +}
> +
>  #else	/* !CONFIG_FAIR_GROUP_SCHED */
>  
>  static inline struct task_struct *task_of(struct sched_entity *se)
> @@ -672,8 +685,14 @@ int sched_proc_update_handler(struct ctl_table *table, int write,
>   */
>  static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
>  {
> -	if (unlikely(se->load.weight != NICE_0_LOAD))
> +	if (task_se_in_cgroup(se)) {
> +		unsigned long h_weight = task_se_h_weight(se);
> +		if (h_weight != se->h_load.weight)
> +			update_load_set(&se->h_load, h_weight);
> +		delta = __calc_delta(delta, NICE_0_LOAD, &se->h_load);
> +	} else if (unlikely(se->load.weight != NICE_0_LOAD)) {
>  		delta = __calc_delta(delta, NICE_0_LOAD, &se->load);
> +	}
>  
>  	return delta;
>  }
> @@ -687,22 +706,16 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
>  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
>  	u64 slice = sysctl_sched_latency;
> +	struct load_weight *load = &cfs_rq->load;
> +	struct load_weight lw;
>  
> -	for_each_sched_entity(se) {
> -		struct load_weight *load;
> -		struct load_weight lw;
> -
> -		cfs_rq = cfs_rq_of(se);
> -		load = &cfs_rq->load;
> +	if (unlikely(!se->on_rq)) {
> +		lw = cfs_rq->load;
>  
> -		if (unlikely(!se->on_rq)) {
> -			lw = cfs_rq->load;
> -
> -			update_load_add(&lw, se->load.weight);
> -			load = &lw;
> -		}
> -		slice = __calc_delta(slice, se->load.weight, load);
> +		update_load_add(&lw, task_se_h_weight(se));
> +		load = &lw;
>  	}
> +	slice = __calc_delta(slice, task_se_h_weight(se), load);
>  
>  	/*
>  	 * To avoid cache thrashing, run at least sysctl_sched_min_granularity.
> @@ -2703,16 +2716,28 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
>  static void
>  account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -	update_load_add(&cfs_rq->load, se->load.weight);
> -	if (!parent_entity(se))
> +	struct rq *rq;
> +
> +	if (task_se_in_cgroup(se)) {
> +		struct cfs_rq *cgroup_rq = group_cfs_rq_of_parent(se);
> +		unsigned long h_weight;
> +
> +		update_load_add(&cgroup_rq->load, se->load.weight);
> +		cgroup_rq->nr_running++;
> +
> +		/* Add the hierarchical weight to the CPU rq */
> +		h_weight = task_se_h_weight(se);
> +		se->enqueued_h_weight = h_weight;
> +		update_load_add(&rq_of(cfs_rq)->load, h_weight);

Ok I think this is where we need to handle the newly enqueued se's potential
weight.  Right now task_se_h_weight() is based on it's weight _and_ its load.
So it's really it's task_se_h_weighted_load_avg, and not really
task_se_h_weight, right?  Instead we should separate these two things out, one
gives us our heirarchal load, and one that gives us our heirarchal weight based
purely on the ratio of (our weight) / (total se weight on parent).  Then we can
take this number and max it with the heirarchal load avg and use that with the
update_load_add.  Does that make sense?  Thanks,

Josef
