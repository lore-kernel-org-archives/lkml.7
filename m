Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660D3C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C555206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZS2kl+q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfLSPl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:41:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44238 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLSPlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:41:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so6427908wrm.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 07:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pxGtfXL0AJvqR+hUazQc4FysXcLTyJt3Et3/qZjWzYw=;
        b=ZS2kl+q/EEPFxzkqxa5QfTY+CRfdrbxkkSJccYECCa/povRNSULfx2mROYyTr+H66n
         uQGddaDAIk4CEDeNsWCVS8p7E2jUJii+huXBX2ilvLqE79o8+lFh/rpPQOFsOFuvGaEh
         lHm3/iB0VcF9pVMjTiByeIQozTGQL8BxV5ExOkhGFXz0znFd9Cc92FYGePLMwXBXmUKA
         X4eBMoLbiONRukzTh3/nEkTYYr96S8Wl24cP7B7CGUbrNRQbtO06YX2e1a038fmcljRX
         7/OIJmKJlJqmA/gGYt3sRABd7apxofjgiZK7XnaV3Z+A4a8dtvaqITnFwA6QIdWtLIZW
         p3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pxGtfXL0AJvqR+hUazQc4FysXcLTyJt3Et3/qZjWzYw=;
        b=K66Bz+89XMPe8bPoldF9rK7rBVUMkyDCFumOI9ywnuOyRyTj70VDKn2zyv6rswDvnR
         FIlNTwSQ9tTp4NwfhU2LQh+hZJXqxFJfH3wrWWqc+hHdMWzVZKD/9zkaZtzX0Ox1GrkL
         Jc/vUrJyhk6EjeM1/pQhINJQ1z4ANysLsMUl2qirpuk6fnFAP/kwp93sY62rGFHY9hDt
         fD20Htp6Khy0GjWROIorhT8sSmTXQfjdDHdmQ3FwWw+Mq6UXQJFNKOuMYzmHN6Gr0vDG
         vM0sjP7e+Lu78dqup1zdiILQd/O1rnOoq79EDOZIV4VT+u7VEgdZRL5ZjjXrO6PawF/Q
         hRRw==
X-Gm-Message-State: APjAAAXUpPsL2Zy5tahs7dNPVAYlXZn4n8hBXwl5LbkWIcwEJ5SuW1wb
        xVGrXCjR99bEQ+uigo5qAFxuqg==
X-Google-Smtp-Source: APXvYqzQBM6tB1vE2wum7vJYxNV9HS4RL/GkbkhjvmCWUv0XkQrIya0I+0zzRNQE4PNump5iGlI4tQ==
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr9880426wrq.243.1576770080824;
        Thu, 19 Dec 2019 07:41:20 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:3953:d503:a17e:8209])
        by smtp.gmail.com with ESMTPSA id v22sm6198167wml.11.2019.12.19.07.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 07:41:19 -0800 (PST)
Date:   Thu, 19 Dec 2019 16:41:17 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        riel@surriel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
Message-ID: <20191219154117.GB19614@linaro.org>
References: <20191218154402.GF3178@techsingularity.net>
 <20191219144539.GA19614@linaro.org>
 <20191219151824.GI3178@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191219151824.GI3178@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thursday 19 Dec 2019 à 15:18:24 (+0000), Mel Gorman a écrit :
> On Thu, Dec 19, 2019 at 03:45:39PM +0100, Vincent Guittot wrote:
> > Hi Mel,
> > 
> > Thanks for looking at this NUMA locality vs spreading tasks point.
> > 
> 
> No problem.
> 
> > > @@ -8680,7 +8676,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> > >  			env->migration_type = migrate_task;
> > >  			lsub_positive(&nr_diff, local->sum_nr_running);
> > >  			env->imbalance = nr_diff >> 1;
> > > -			return;
> > > +			goto out_spare;
> > 
> > Why are you doing this only for prefer_sibling case ? That's probably the default case of most of numa system but you should also consider others case too.
> > 
> 
> It's the common case for NUMA machines I'm aware of and from the
> perspective of allowing a slight imbalance when there are spare CPUs, I
> felt it was the same whether we were considering idle CPUs or the number
> of tasks running.
> 
> The prefer_sibling case applies to the children and the corner case is
> that balancing NUMA domains takes into account whether the MC domain
> prefers siblings which is a bit odd. I believe, but don't know, that the
> reasoning may have been to spread load for memory bandwidth usage.
> 
> > So you should probably add your
> > 
> > > +                * Whether balancing the number of running tasks or the number
> > > +                * of idle CPUs, consider allowing some degree of imbalance if
> > > +                * migrating between NUMA domains.
> > > +                */
> > > +               if (env->sd->flags & SD_NUMA) {
> > > +                       unsigned int imbalance_adj, imbalance_max;
> > 
> > ...
> > 
> > > +               }
> > 
> > before the prefer_sibling case :
> > 
> > 		if (busiest->group_weight == 1 || sds->prefer_sibling) {
> > 			unsigned int nr_diff = busiest->sum_nr_running;
> > 			/*
> > 			 * When prefer sibling, evenly spread running tasks on
> > 			 * groups.
> > 			 */
> > 
> 
> I don't understand. If I move SD_NUMA checks above the imbalance
> calculation, how do I know whether the imbalance should be ignored?

You are only clearing env->imbalance before returning if the condition
between sum_nr_running with weight doesn't  match so you don't care about
what will be the value of env->imbalance in the other case so you can have 

		if ((env->sd->flags & SD_NUMA) &&
			( allow some degrees of imbalance )) {
				env->imbalance = 0
				return;
		}

		if (busiest->group_weight == 1 || sds->prefer_sibling) {
			unsigned int nr_diff = busiest->sum_nr_running;
			/*
			 * When prefer sibling, evenly spread running tasks on
			 * groups.
			 */
			env->migration_type = migrate_task;
			lsub_positive(&nr_diff, local->sum_nr_running);
			env->imbalance = nr_diff >> 1;
			return;
		}

		/*
		 * If there is no overload, we just want to even the number of
		 * idle cpus.
		 */
		env->migration_type = migrate_task;
		env->imbalance = max_t(long, 0, (local->idle_cpus -
						 busiest->idle_cpus) >> 1);
		return;
	}
	
		
> 
> > 
> > >
> > >  		}
> > >  
> > >  		/*
> > > @@ -8690,6 +8686,38 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> > >  		env->migration_type = migrate_task;
> > >  		env->imbalance = max_t(long, 0, (local->idle_cpus -
> > >  						 busiest->idle_cpus) >> 1);
> > > +
> > > +out_spare:
> > > +		/*
> > > +		 * Whether balancing the number of running tasks or the number
> > > +		 * of idle CPUs, consider allowing some degree of imbalance if
> > > +		 * migrating between NUMA domains.
> > > +		 */
> > > +		if (env->sd->flags & SD_NUMA) {
> > > +			unsigned int imbalance_adj, imbalance_max;
> > > +
> > > +			/*
> > > +			 * imbalance_adj is the allowable degree of imbalance
> > > +			 * to exist between two NUMA domains. It's calculated
> > > +			 * relative to imbalance_pct with a minimum of two
> > > +			 * tasks or idle CPUs.
> > > +			 */
> > > +			imbalance_adj = (busiest->group_weight *
> > > +				(env->sd->imbalance_pct - 100) / 100) >> 1;
> > > +			imbalance_adj = max(imbalance_adj, 2U);
> > > +
> > > +			/*
> > > +			 * Ignore imbalance unless busiest sd is close to 50%
> > > +			 * utilisation. At that point balancing for memory
> > > +			 * bandwidth and potentially avoiding unnecessary use
> > > +			 * of HT siblings is as relevant as memory locality.
> > > +			 */
> > > +			imbalance_max = (busiest->group_weight >> 1) - imbalance_adj;
> > > +			if (env->imbalance <= imbalance_adj &&
> > > +			    busiest->sum_nr_running < imbalance_max) {i
> > 
> > Shouldn't you consider the number of busiest->idle_cpus instead of the busiest->sum_nr_running ?
> > 
> 
> Why? CPU affinity could have stacked multiple tasks on one CPU where
> as I'm looking for a proxy hint on the amount of bandwidth required.
> sum_nr_running does not give me an accurate estimate but it's better than
> idle cpus.

Because even if you have multiple tasks on one CPU, only one will run at a
time on the CPU and others will wait so the bandwidth is effectively link to
the number of running CPUs more than number of runnable tasks

> 
> > and you could simplify by 
> > 
> > 
> > 	if ((env->sd->flags & SD_NUMA) &&
> > 		((100 * busiest->group_weight) <= (env->sd->imbalance_pct * (busiest->idle_cpus << 1)))) {
> > 			env->imbalance = 0;
> > 			return;
> > 	}
> > 
> > And otherwise it will continue with the current path
> > 
> 
> I ended up doing something similar to this in v2 but it's a bit more
> expanded so I can put in comments on why the comparisons are the way
> they are. The multiplications are in the slow path.
> 
> > Also I'm a bit worry about using a 50% threshold that look a bit like a
> > heuristic which can change depending of platform and the UCs that run of the
> > system.
> > 
> 
> UCs?

Use Cases

> 
> And yes, it's a heuristic. In this case, I'm as concerned about memory
> bandwidth availability as I am about improper locality due to agressive
> balancing. We do not know the available memory bandwidth and we do not
> know how much bandwidth the tasks required so 50% was as good as threshold
> as any. I do not know of any way that can cheaply measure either bandwidth
> usage (PMUs are not cheap) or available bandwidth (theoretical bandwidth !=
> actual bandwidth).
> 
> In an earlier version that I never posted, I had no cutoff at all and
> NAS took a roughly 30% performance penalty across all computational
> kernels. Debug tracing led me to this cutoff and running a battery
> of workloads led me to believe that it was a reasonable cutoff. It's
> important.
> 
> > In fact i was hoping that we could use the numa_preferred_nid ?
> 
> Unfortunately not. For some tasks, they are not long-lived enough for NUMA
> balancing to make a decision. For longer-lived tasks, if load balancing is
> spreading the load across nodes and wakeups are pulling tasks together,
> NUMA balancing will get a mix of remote/local samples and will be unable
> to pick a node properly.
> 
> In the netperf figures I put in the changelog, I pointed out that NUMA
> balancing sampled roughly 50% of accesses were remote. With the patch,
> 100% of the samples are local.
> 
> > During the
> > detach of tasks, we don't detach the task if busiest has spare capacity and
> > preferred_nid of the task is busiest.
> > 
> 
> Sure, but again if load balancing and waker/wakees are fighting each
> other, NUMA balancing gets caught in the crossfire and cannot make a
> sensible decision.
> 
> -- 
> Mel Gorman
> SUSE Labs
