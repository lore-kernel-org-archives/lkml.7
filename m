Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EA7206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfH0Kho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:37:44 -0400
Received: from foss.arm.com ([217.140.110.172]:42494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfH0Khn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:37:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1640E28;
        Tue, 27 Aug 2019 03:37:41 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B0B53F718;
        Tue, 27 Aug 2019 03:37:39 -0700 (PDT)
Subject: Re: [PATCH 12/15] sched,fair: flatten update_curr functionality
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, peterz@infradead.org,
        mingo@redhat.com, morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
References: <20190822021740.15554-1-riel@surriel.com>
 <20190822021740.15554-13-riel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <63f17078-b467-b239-2824-a0f9b9d14537@arm.com>
Date:   Tue, 27 Aug 2019 12:37:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822021740.15554-13-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2019 04:17, Rik van Riel wrote:
> Make it clear that update_curr only works on tasks any more.
> 
> There is no need for task_tick_fair to call it on every sched entity up
> the hierarchy, so move the call out of entity_tick.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>`
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fa8e88731821..5cfa3dbeba49 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -872,10 +872,11 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
>  static void update_curr(struct cfs_rq *cfs_rq)
>  {
>  	struct sched_entity *curr = cfs_rq->curr;
> +	struct task_struct *curtask;
>  	u64 now = rq_clock_task(rq_of(cfs_rq));
>  	u64 delta_exec;
>  
> -	if (unlikely(!curr))
> +	if (unlikely(!curr) || !entity_is_task(curr))
>  		return;

Shouldn't this be

-       if (unlikely(!curr) || !entity_is_task(curr))
+       if (unlikely(!curr))
                return;

+       BUG_ON(!entity_is_task(curr));

IMHO, cfs_rq->curr can only be a task with your changes.
