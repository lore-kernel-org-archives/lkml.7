Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E48CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6283220856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfJ3Ovl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:51:41 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:43649 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbfJ3Ovh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:51:37 -0400
Received: from mail.blacknight.com (unknown [81.17.254.17])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 23EEB1C2CBF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 14:51:35 +0000 (GMT)
Received: (qmail 16615 invoked from network); 30 Oct 2019 14:51:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Oct 2019 14:51:35 -0000
Date:   Wed, 30 Oct 2019 14:51:33 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
Subject: Re: [PATCH v4 01/11] sched/fair: clean up asym packing
Message-ID: <20191030145133.GH3016@techsingularity.net>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-2-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1571405198-27570-2-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:26:28PM +0200, Vincent Guittot wrote:
> Clean up asym packing to follow the default load balance behavior:
> - classify the group by creating a group_asym_packing field.
> - calculate the imbalance in calculate_imbalance() instead of bypassing it.
> 
> We don't need to test twice same conditions anymore to detect asym packing
> and we consolidate the calculation of imbalance in calculate_imbalance().
> 
> There is no functional changes.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 63 ++++++++++++++---------------------------------------
>  1 file changed, 16 insertions(+), 47 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1f0a5e1..617145c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7675,6 +7675,7 @@ struct sg_lb_stats {
>  	unsigned int group_weight;
>  	enum group_type group_type;
>  	int group_no_capacity;
> +	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
>  	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
>  #ifdef CONFIG_NUMA_BALANCING
>  	unsigned int nr_numa_running;
> @@ -8129,9 +8130,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	 * ASYM_PACKING needs to move all the work to the highest
>  	 * prority CPUs in the group, therefore mark all groups
>  	 * of lower priority than ourself as busy.
> +	 *
> +	 * This is primarily intended to used at the sibling level.  Some
> +	 * cores like POWER7 prefer to use lower numbered SMT threads.  In the
> +	 * case of POWER7, it can move to lower SMT modes only when higher
> +	 * threads are idle.  When in lower SMT modes, the threads will
> +	 * perform better since they share less core resources.  Hence when we
> +	 * have idle threads, we want them to be the higher ones.
>  	 */
>  	if (sgs->sum_nr_running &&
>  	    sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
> +		sgs->group_asym_packing = 1;
>  		if (!sds->busiest)
>  			return true;
>  

(I did not read any of the earlier implementations of this series, maybe
this was discussed already in which case, sorry for the noise)

Are you *sure* this is not a functional change?

Asym packing is a twisty maze of headaches and I'm not familiar enough
with it to be 100% certain without spending a lot of time on this. Even
spotting how Power7 ends up using asym packing with lower-numbered SMT
threads is a bit of a challenge.  Specifically, it relies on the scheduler
domain SD_ASYM_PACKING flag for SMT domains to use the weak implementation
of arch_asym_cpu_priority which by defaults favours the lower-numbered CPU.

The check_asym_packing implementation checks that flag but I can't see
the equiavlent type of check here. update_sd_pick_busiest  could be called
for domains that span NUMA or basically any domain that does not specify
SD_ASYM_PACKING and end up favouring a lower-numbered CPU (or whatever
arch_asym_cpu_priority returns in the case of x86 which has a different
idea for favoured CPUs).

sched_asym_prefer appears to be a function that is very easy to use
incorrectly. Should it take env and check the SD flags first?

-- 
Mel Gorman
SUSE Labs
