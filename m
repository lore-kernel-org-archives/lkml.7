Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB5DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6228E20673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfD2PMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:12:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60016 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbfD2PMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:12:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ACE580D;
        Mon, 29 Apr 2019 08:12:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84DFF3F5C1;
        Mon, 29 Apr 2019 08:12:28 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:12:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, tj@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH 2/4] perf: Add filter_match() as a parameter for
 pinned/flexible_sched_in()
Message-ID: <20190429151225.GC2182@lakrids.cambridge.arm.com>
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
 <1556549045-71814-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556549045-71814-3-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 07:44:03AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A fast path will be introduced in the following patches to speed up the
> cgroup events sched in, which only needs a simpler filter_match().
> 
> Add filter_match() as a parameter for pinned/flexible_sched_in().
> 
> No functional change.

I suspect that the cost you're trying to avoid is pmu_filter_match()
iterating over the entire group, which arm systems rely upon for correct
behaviour on big.LITTLE systems.

Is that the case?

Thanks,
Mark.

> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  kernel/events/core.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 388dd42..782fd86 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3251,7 +3251,8 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
>  }
>  
>  static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
> -			      int (*func)(struct perf_event *, void *), void *data)
> +			      int (*func)(struct perf_event *, void *, int (*)(struct perf_event *)),
> +			      void *data)
>  {
>  	struct perf_event **evt, *evt1, *evt2;
>  	int ret;
> @@ -3271,7 +3272,7 @@ static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
>  			evt = &evt2;
>  		}
>  
> -		ret = func(*evt, data);
> +		ret = func(*evt, data, event_filter_match);
>  		if (ret)
>  			return ret;
>  
> @@ -3287,7 +3288,8 @@ struct sched_in_data {
>  	int can_add_hw;
>  };
>  
> -static int pinned_sched_in(struct perf_event *event, void *data)
> +static int pinned_sched_in(struct perf_event *event, void *data,
> +			   int (*filter_match)(struct perf_event *))
>  {
>  	struct sched_in_data *sid = data;
>  
> @@ -3300,7 +3302,7 @@ static int pinned_sched_in(struct perf_event *event, void *data)
>  		return 0;
>  #endif
>  
> -	if (!event_filter_match(event))
> +	if (!filter_match(event))
>  		return 0;
>  
>  	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
> @@ -3318,7 +3320,8 @@ static int pinned_sched_in(struct perf_event *event, void *data)
>  	return 0;
>  }
>  
> -static int flexible_sched_in(struct perf_event *event, void *data)
> +static int flexible_sched_in(struct perf_event *event, void *data,
> +			     int (*filter_match)(struct perf_event *))
>  {
>  	struct sched_in_data *sid = data;
>  
> @@ -3331,7 +3334,7 @@ static int flexible_sched_in(struct perf_event *event, void *data)
>  		return 0;
>  #endif
>  
> -	if (!event_filter_match(event))
> +	if (!filter_match(event))
>  		return 0;
>  
>  	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
> -- 
> 2.7.4
> 
