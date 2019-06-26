Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C1EC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C006021670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFZP6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:58:53 -0400
Received: from foss.arm.com ([217.140.110.172]:36130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZP6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:58:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BE602B;
        Wed, 26 Jun 2019 08:58:52 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FF7F3F706;
        Wed, 26 Jun 2019 08:58:47 -0700 (PDT)
Subject: Re: [PATCH 5/8] sched,cfs: use explicit cfs_rq of parent se helper
To:     Rik van Riel <riel@surriel.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggemann@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
References: <20190612193227.993-1-riel@surriel.com>
 <20190612193227.993-6-riel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <0032016d-78d1-8338-96af-3077d3219f47@arm.com>
Date:   Wed, 26 Jun 2019 17:58:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612193227.993-6-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 9:32 PM, Rik van Riel wrote:
> Use an explicit "cfs_rq of parent sched_entity" helper in a few
> strategic places, where cfs_rq_of(se) may no longer point at the
> right runqueue once we flatten the hierarchical cgroup runqueues.
> 
> No functional change.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index dcc521d251e3..c6ede2ecc935 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -275,6 +275,15 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
>  	return grp->my_q;
>  }
>  
> +/* runqueue owned by the parent entity */
> +static inline struct cfs_rq *group_cfs_rq_of_parent(struct sched_entity *se)
> +{
> +	if (se->parent)
> +		return group_cfs_rq(se->parent);
> +
> +	return &cfs_rq_of(se)->rq->cfs;

The function name and the description is not 100% correct. For tasks
running naturally (not in a flattened taskgroup) in the root taskgroup
or for the se representing a first level taskgroup (e.g. /tg1 (with
se->depth = 0)) it returns the root cfs_rq or easier se->cfs_rq.

So you could replace

    return &cfs_rq_of(se)->rq->cfs;

with

    return se->cfs_rq;

or

    return cfs_rq_of(se);

I guess a crucial point to understand is that you do need both,
cfs_rq_of(se) to access the flattened and group_cfs_rq_of_parent(se) to
access the hierarchical world.

[...]

