Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F556C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9222087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfKHShg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:37:36 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:59638 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbfKHShg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:37:36 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 2D6A71C2E59
        for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2019 18:37:33 +0000 (GMT)
Received: (qmail 22085 invoked from network); 8 Nov 2019 18:37:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.195])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Nov 2019 18:37:32 -0000
Date:   Fri, 8 Nov 2019 18:37:30 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 04/11] sched/fair: rework load_balance
Message-ID: <20191108183730.GU3016@techsingularity.net>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-5-git-send-email-vincent.guittot@linaro.org>
 <20191030154534.GJ3016@techsingularity.net>
 <CAKfTPtB_6kBq69E=-YFuon6fg21CxHneMpncpbLcPGk6uoVcMQ@mail.gmail.com>
 <20191031101544.GP3016@techsingularity.net>
 <CAKfTPtByO7oLQZxF_+-FxZ9u1JhO24-rujW3j-QDqr+PFDOQ=Q@mail.gmail.com>
 <20191031114020.GQ3016@techsingularity.net>
 <20191108163501.GA26528@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191108163501.GA26528@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 05:35:01PM +0100, Vincent Guittot wrote:
> > Fair enough, netperf hits the corner case where it does not work but
> > that is also true without your series.
> 
> I run mmtest/netperf test on my setup. It's a mix of small positive or
> negative differences (see below)
> 
> <SNIP>
>
> netperf-tcp
>                                5.3-rc2                5.3-rc2
>                                    tip               +rwk+fix
> Hmean     64         871.30 (   0.00%)      860.90 *  -1.19%*
> Hmean     128       1689.39 (   0.00%)     1679.31 *  -0.60%*
> Hmean     256       3199.59 (   0.00%)     3241.98 *   1.32%*
> Hmean     1024      9390.47 (   0.00%)     9268.47 *  -1.30%*
> Hmean     2048     13373.95 (   0.00%)    13395.61 *   0.16%*
> Hmean     3312     16701.30 (   0.00%)    17165.96 *   2.78%*
> Hmean     4096     15831.03 (   0.00%)    15544.66 *  -1.81%*
> Hmean     8192     19720.01 (   0.00%)    20188.60 *   2.38%*
> Hmean     16384    23925.90 (   0.00%)    23914.50 *  -0.05%*
> Stddev    64           7.38 (   0.00%)        4.23 (  42.67%)
> Stddev    128         11.62 (   0.00%)       10.13 (  12.85%)
> Stddev    256         34.33 (   0.00%)        7.94 (  76.88%)
> Stddev    1024        35.61 (   0.00%)      116.34 (-226.66%)
> Stddev    2048       285.30 (   0.00%)       80.50 (  71.78%)
> Stddev    3312       304.74 (   0.00%)      449.08 ( -47.36%)
> Stddev    4096       668.11 (   0.00%)      569.30 (  14.79%)
> Stddev    8192       733.23 (   0.00%)      944.38 ( -28.80%)
> Stddev    16384      553.03 (   0.00%)      299.44 (  45.86%)
> 
>                      5.3-rc2     5.3-rc2
>                          tip    +rwk+fix
> Duration User         138.05      140.95
> Duration System      1210.60     1208.45
> Duration Elapsed     1352.86     1352.90
> 

This roughly matches what I've seen. The interesting part to me for
netperf is the next section of the report that reports the locality of
numa hints. With netperf on a 2-socket machine, it's generally around
50% as the client/server are pulled apart. Because netperf is not
heavily memory bound, it doesn't have much impact on the overall
performance but it's good at catching the cross-node migrations.

> > 
> > > I agree that additional patches are probably needed to improve load
> > > balance at NUMA level and I expect that this rework will make it
> > > simpler to add.
> > > I just wanted to get the output of some real use cases before defining
> > > more numa level specific conditions. Some want to spread on there numa
> > > nodes but other want to keep everything together. The preferred node
> > > and fbq_classify_group was the only sensible metrics to me when he
> > > wrote this patchset but changes can be added if they make sense.
> > > 
> > 
> > That's fair. While it was possible to address the case before your
> > series, it was a hatchet job. If the changelog simply notes that some
> > special casing may still be required for SD_NUMA but it's outside the
> > scope of the series, then I'd be happy. At least there is a good chance
> > then if there is follow-up work that it won't be interpreted as an
> > attempt to reintroduce hacky heuristics.
> >
> 
> Would the additional comment make sense for you about work to be done
> for SD_NUMA ?
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0ad4b21..7e4cb65 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6960,11 +6960,34 @@ enum fbq_type { regular, remote, all };
>   * group. see update_sd_pick_busiest().
>   */
>  enum group_type {
> +	/*
> +	 * The group has spare capacity that can be used to process more work.
> +	 */
>  	group_has_spare = 0,
> +	/*
> +	 * The group is fully used and the tasks don't compete for more CPU
> +	 * cycles. Nevetheless, some tasks might wait before running.
> +	 */
>  	group_fully_busy,
> +	/*
> +	 * One task doesn't fit with CPU's capacity and must be migrated on a
> +	 * more powerful CPU.
> +	 */
>  	group_misfit_task,
> +	/*
> +	 * One local CPU with higher capacity is available and task should be
> +	 * migrated on it instead on current CPU.
> +	 */
>  	group_asym_packing,
> +	/*
> +	 * The tasks affinity prevents the scheduler to balance the load across
> +	 * the system.
> +	 */
>  	group_imbalanced,
> +	/*
> +	 * The CPU is overloaded and can't provide expected CPU cycles to all
> +	 * tasks.
> +	 */
>  	group_overloaded
>  };

Looks good.

>  
> @@ -8563,7 +8586,11 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  
>  	/*
>  	 * Try to use spare capacity of local group without overloading it or
> -	 * emptying busiest
> +	 * emptying busiest.
> +	 * XXX Spreading tasks across numa nodes is not always the best policy
> +	 * and special cares should be taken for SD_NUMA domain level before
> +	 * spreading the tasks. For now, load_balance() fully relies on
> +	 * NUMA_BALANCING and fbq_classify_group/rq to overide the decision.
>  	 */
>  	if (local->group_type == group_has_spare) {
>  		if (busiest->group_type > group_fully_busy) {

Perfect. Any patch in that are can then update the comment and it
should be semi-obvious to the next reviewer that it's expected.

Thanks Vincent.

-- 
Mel Gorman
SUSE Labs
