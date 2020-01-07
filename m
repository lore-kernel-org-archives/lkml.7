Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47764C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A5720656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnOHsKhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgAGT0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:26:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30922 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728307AbgAGT0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578425196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2X8Ng3taPEp3AOj/TL8+kC9oHAVV9wxrEQAhxTW9iJ4=;
        b=bnOHsKhksVeAurIYNH8WKf6jO28Dm7xyKlVWGaXwMhbawdq4wpy84zPNnpXvR5F87AmH8q
        9Km1W/GdGo3+I3KHH8brxnB/sLxUjMAqVNnRWdweyyjokzVfuGwSVL6yS+0nJfWnqFj24F
        IUeaqiYEzFEDAe/pH4w2t65VSggwhso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-q9JTVvYuO8K7IYuaXr1Dkw-1; Tue, 07 Jan 2020 14:26:33 -0500
X-MC-Unique: q9JTVvYuO8K7IYuaXr1Dkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55C7463CDF;
        Tue,  7 Jan 2020 19:26:31 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83BA75D9D6;
        Tue,  7 Jan 2020 19:26:28 +0000 (UTC)
Date:   Tue, 7 Jan 2020 14:26:26 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
Message-ID: <20200107192626.GA19298@pauld.bos.csb>
References: <20191220084252.GL3178@techsingularity.net>
 <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net>
 <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net>
 <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
 <20200107095655.GF3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107095655.GF3466@techsingularity.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Tue, Jan 07, 2020 at 09:56:55AM +0000 Mel Gorman wrote:
> 
> util_avg can be skewed if there are big outliers. Even then, it's not
> a great metric for the low utilisation cutoff. Large numbers of mostly
> idle but running tasks would be treated similarly to small numbers of
> fully active tasks. It's less predictable and harder to reason about how
> load balancing behaves across a variety of workloads.
> 
> Based on what you suggest, the result looks like this (build tested
> only)

(Here I'm calling the below patch v4 for lack of a better name.)

One of my concerns is to have the group imbalance issue addressed. This
is the one remaining issue from the wasted cores paper. I have a setup
that is designed to illustrate this case. I ran a number of tests with
the small imbalance patches (v3 and v4 in this case) and both before
and after Vincent's load balancing rework. 

The basic test is to run an LU.c benchmark from the NAS parallel benchmark 
suite along with a couple of other cpu burning tasks. The GROUP case is LU 
and each cpu hog in separate cgroups. The NORMAL case is all of these in 
one cgroup.  This shows of the problems of averaging the group 
scheduling load by failing to balance the jobs across the NUMA nodes.
It ends up with idle CPUs in the nodes where the cpu hogs are running while
overloading LU.c threads on others, with a big impact on the benchmark's
performance.  This test benefits from getting balanced well quickly.


The test machine is a 4-node 80 cpu x86_64 system (smt on).  There are 76 
threads in the LU.c test and 2 stress cpu jobs.  Each row shows the numbers
for 10 runs to smooth it out and make the mean more, well, meaningful.  
It's still got a fair bit of variance as you can see from the 3 sets of
data points for each kernel. 

5.4.0 is before load balancing rework (the really bad case).
5.5-rc2  is with the load balancing rework.
lbv3  is Mel's posted v3 patch on top of 5.5-rc2
lbv4 is Mel's experimental v4 which is from email discussion with Vincent.


lbv4 appears a little worse for the GROUP case. v3 and 5.5-rc2 are pretty 
close to the same.  

All of the post 5.4.0 cases lose a little on the NORMAL case. lbv3 seems
to get a fair bit of that loss back on average but with a bit higher 
variability. 
 

This test can be pretty variable though so the minor differences probably
don't mean that much. In all the post re-work cases we are still showing
vast improvement in the GROUP case, which given the common use of cgroups
in modern workloads is a good thing. 

----------------------------------

GROUP - LU.c and cpu hogs in separate cgroups
Mop/s - Higher is better
============76_GROUP========Mop/s===================================
	min	q1	median	q3	max
5.4.0	 1671.8	 4211.2	 6103.0	 6934.1	 7865.4
5.4.0	 1777.1	 3719.9	 4861.8	 5822.5	13479.6
5.4.0	 2015.3	 2716.2	 5007.1	 6214.5	 9491.7
5.5-rc2	27641.0	30684.7	32091.8	33417.3	38118.1
5.5-rc2	27386.0	29795.2	32484.1	36004.0	37704.3
5.5-rc2	26649.6	29485.0	30379.7	33116.0	36832.8
lbv3	28496.3	29716.0	30634.8	32998.4	40945.2
lbv3	27294.7	29336.4	30186.0	31888.3	35839.1
lbv3	27099.3	29325.3	31680.1	35973.5	39000.0
lbv4	27936.4	30109.0	31724.8	33150.7	35905.1
lbv4	26431.0	29355.6	29850.1	32704.4	36060.3
lbv4	27436.6	29945.9	31076.9	32207.8	35401.5

Runtime - Lower is better
============76_GROUP========time====================================
	min	q1	median	q3	max
5.4.0	259.2	294.92	335.39	484.33	1219.61
5.4.0	151.3	351.1	419.4	551.99	1147.3
5.4.0	214.8	328.16	407.27	751.03	1011.77
5.5-rc2	 53.49	 61.03	 63.56	 66.46	  73.77
5.5-rc2  54.08	 56.67	 62.78	 68.44	  74.45
5.5-rc2	 55.36	 61.61	 67.14	 69.16	  76.51
lbv3	 49.8	 61.8	 66.59	 68.62	  71.55
lbv3	 56.89	 63.95	 67.55	 69.51	  74.7
lbv3	 52.28	 56.68	 64.38	 69.54	  75.24
lbv4	 56.79	 61.52	 64.3	 67.73	  72.99
lbv4	 56.54	 62.36	 68.31	 69.47	  77.14
lbv4	 57.6	 63.33	 65.64	 68.11	  74.32

NORMAL - LU.c and cpu hogs all in one cgroup
Mop/s - Higher is better
============76_NORMAL========Mop/s===================================
	min	q1	median	q3	max
5.4.0	32912.6	34047.5	36739.4	39124.1	41592.5
5.4.0	29937.7	33060.6	34860.8	39528.8	43328.1
5.4.0	31851.2	34281.1	35284.4	36016.8	38847.4
5.5-rc2	30475.6	32505.1	33977.3	34876	36233.8
5.5-rc2	30657.7	31301.1	32059.4	34396.7	38661.8
5.5-rc2	31022	32247.6	32628.9	33245	38572.3
lbv3	30606.4	32794.4	34258.6	35699	38669.2
lbv3	29722.7	30558.9	32731.2	36412	40752.3
lbv3	30297.7	32568.3	36654.6	38066.2	38988.3
lbv4	30084.9	31227.5	32312.8	33222.8	36039.7
lbv4	29875.9	32903.6	33803.1	34519.3	38663.5
lbv4	27923.3	30631.1	32666.9	33516.7	36663.4

Runtime - Lower is better
============76_NORMAL========time====================================
	min	q1	median	q3	max
5.4.0	49.02	52.115	55.58	59.89	61.95
5.4.0	47.06	51.615	58.57	61.68	68.11
5.4.0	52.49	56.615	57.795	59.48	64.02
5.5-rc2	56.27	58.47	60.02	62.735	66.91
5.5-rc2	52.74	59.295	63.605	65.145	66.51
5.5-rc2	52.86	61.335	62.495	63.23	65.73
lbv3	52.73	57.12	59.52	62.19	66.62
lbv3	50.03	56.02	62.39	66.725	68.6
lbv3	52.3	53.565	55.65	62.645	67.3
lbv4	56.58	61.375	63.135	65.3	67.77
lbv4	52.74	59.07	60.335	61.97	68.25
lbv4	55.61	60.835	62.42	66.635	73.02


So aside from the theoretical disputes the posted v3 seems reasonable.
When a final version comes toghether I'll have the perf team run a
fuller set of tests. 


Cheers,
Phil


> 
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ba749f579714..1b2c7bed2db5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8648,10 +8648,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  	/*
>  	 * Try to use spare capacity of local group without overloading it or
>  	 * emptying busiest.
> -	 * XXX Spreading tasks across NUMA nodes is not always the best policy
> -	 * and special care should be taken for SD_NUMA domain level before
> -	 * spreading the tasks. For now, load_balance() fully relies on
> -	 * NUMA_BALANCING and fbq_classify_group/rq to override the decision.
>  	 */
>  	if (local->group_type == group_has_spare) {
>  		if (busiest->group_type > group_fully_busy) {
> @@ -8691,16 +8687,41 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  			env->migration_type = migrate_task;
>  			lsub_positive(&nr_diff, local->sum_nr_running);
>  			env->imbalance = nr_diff >> 1;
> -			return;
> -		}
> +		} else {
>  
> -		/*
> -		 * If there is no overload, we just want to even the number of
> -		 * idle cpus.
> -		 */
> -		env->migration_type = migrate_task;
> -		env->imbalance = max_t(long, 0, (local->idle_cpus -
> +			/*
> +			 * If there is no overload, we just want to even the number of
> +			 * idle cpus.
> +			 */
> +			env->migration_type = migrate_task;
> +			env->imbalance = max_t(long, 0, (local->idle_cpus -
>  						 busiest->idle_cpus) >> 1);
> +		}
> +
> +		/* Consider allowing a small imbalance between NUMA groups */
> +		if (env->sd->flags & SD_NUMA) {
> +			struct sched_domain *child = env->sd->child;
> +			unsigned int imbalance_adj;
> +
> +			/*
> +			 * Calculate an acceptable degree of imbalance based
> +			 * on imbalance_adj. However, do not allow a greater
> +			 * imbalance than the child domains weight to avoid
> +			 * a case where the allowed imbalance spans multiple
> +			 * LLCs.
> +			 */
> +			imbalance_adj = busiest->group_weight * (env->sd->imbalance_pct - 100) / 100;
> +			imbalance_adj = min(imbalance_adj, child->span_weight);
> +			imbalance_adj >>= 1;
> +
> +			/*
> +			 * Ignore small imbalances when the busiest group has
> +			 * low utilisation.
> +			 */
> +			if (busiest->sum_nr_running < imbalance_adj)
> +				env->imbalance = 0;
> +		}
> +
>  		return;
>  	}
>  
> 

-- 

