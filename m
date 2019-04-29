Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA01C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208F42087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfD2FiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 01:38:23 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:56283 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbfD2FiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:38:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TQTvTUn_1556516298;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TQTvTUn_1556516298)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Apr 2019 13:38:20 +0800
Date:   Mon, 29 Apr 2019 13:38:18 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 09/17] sched: Introduce sched_class::pick_task()
Message-ID: <20190429053817.GC128241@aaronlu>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <e2f1d30b0b3bb62c01824f422badf159147982d7.1556025155.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2f1d30b0b3bb62c01824f422badf159147982d7.1556025155.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:18:14PM +0000, Vineeth Remanan Pillai wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c055bad249a9..45d86b862750 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4132,7 +4132,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  	 * Avoid running the skip buddy, if running something else can
>  	 * be done without getting too unfair.
>  	 */
> -	if (cfs_rq->skip == se) {
> +	if (cfs_rq->skip && cfs_rq->skip == se) {
>  		struct sched_entity *second;
>  
>  		if (se == curr) {
> @@ -4150,13 +4150,13 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  	/*
>  	 * Prefer last buddy, try to return the CPU to a preempted task.
>  	 */
> -	if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
> +	if (left && cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
>  		se = cfs_rq->last;
>  
>  	/*
>  	 * Someone really wants this to run. If it's not unfair, run it.
>  	 */
> -	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
> +	if (left && cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
>  		se = cfs_rq->next;
>  
>  	clear_buddies(cfs_rq, se);
> @@ -6937,6 +6937,37 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>  		set_last_buddy(se);
>  }
>  
> +static struct task_struct *
> +pick_task_fair(struct rq *rq)
> +{
> +	struct cfs_rq *cfs_rq = &rq->cfs;
> +	struct sched_entity *se;
> +
> +	if (!cfs_rq->nr_running)
> +		return NULL;
> +
> +	do {
> +		struct sched_entity *curr = cfs_rq->curr;
> +
> +		se = pick_next_entity(cfs_rq, NULL);
> +
> +		if (!(se || curr))
> +			return NULL;

I think you have already avoided the null pointer access bug in
the above pick_next_entity() by doing multiple checks for null pointers:
cfs_rq->skip and left.

An alternative way to fix the null pointer access bug: if curr is the
only runnable entity in this cfs_rq, there is no need to call
pick_next_entity(cfs_rq, NULL) since the rbtree is empty. This way
pick_next_entity() doesn't need change. something like:

	do {
		struct sched_entity *curr = cfs_rq->curr;

		if (curr && curr->on_rq && cfs_rq->nr_running == 1)
			se = NULL;
		else
			se = pick_next_entity(cfs_rq, NULL);

		/* the following code doesn't change */
> +
> +		if (curr) {
> +			if (se && curr->on_rq)
> +				update_curr(cfs_rq);
> +
> +			if (!se || entity_before(curr, se))
> +				se = curr;
> +		}
> +
> +		cfs_rq = group_cfs_rq(se);
> +	} while (cfs_rq);
> +
> +	return task_of(se);
> +}

There is another problem I'm thinking: suppose cpu0 and cpu1 are
siblings and task A, B are runnable on cpu0 and curr is A. When cpu1
schedules, pick_task_fair() will also be called for cpu0 to decide
which CPU's task to preempt the other.

When pick_task_fair() is called for cpu0 due to cpu1 schedules:
curr(i.e. A) may only run a few nanoseconds, and thus can have a higher
vruntime than B. So we chose B to fight with task chosen from cpu1. If
B wins, we will schedule B on cpu0. If B loses, we will probably
schedule idle on cpu0(if cookie unmatch). Either case, A didn't get its
share. We probably want to make sure a task at least running for some
time before being considered to be preempted.
