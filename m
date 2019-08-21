Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A2C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AF5216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfHUPP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:15:28 -0400
Received: from foss.arm.com ([217.140.110.172]:59808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfHUPP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:15:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BD10337;
        Wed, 21 Aug 2019 08:15:27 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89F1D3F718;
        Wed, 21 Aug 2019 08:15:26 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:15:24 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com
Subject: Re: [PATCH] sched/fair: eliminate redundant code in sched_slice()
Message-ID: <20190821151523.lwazjd2d6rp5otdh@e107158-lin.cambridge.arm.com>
References: <20190816141202.GA3135@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816141202.GA3135@iZj6chx1xj0e0buvshuecpZ>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/19 22:12, Peng Liu wrote:
> Since sched_slice() is used in high frequency,
> small change should also make sense.
> 
> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> ---
>  kernel/sched/fair.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1054d2cf6aaa..6ae2a507aac0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -694,19 +694,16 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
>  
>  	for_each_sched_entity(se) {
> -		struct load_weight *load;
>  		struct load_weight lw;
>  
>  		cfs_rq = cfs_rq_of(se);
> -		load = &cfs_rq->load;
> +		lw = cfs_rq->load;
>  
> -		if (unlikely(!se->on_rq)) {
> +		if (unlikely(!se->on_rq))
>  			lw = cfs_rq->load;
>  
> -			update_load_add(&lw, se->load.weight);
> -			load = &lw;
> -		}
> -		slice = __calc_delta(slice, se->load.weight, load);
> +		update_load_add(&lw, se->load.weight);
> +		slice = __calc_delta(slice, se->load.weight, &lw);

Unless I misread the diff, you changed the behavior.

update_load_add() is only called if (unlikely(!se->on_rq)), but with your
change it is called unconditionally. And lw is set twice.

I think what you intended is this?


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc9cfeaac8bd..6bbe17d5943f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -694,19 +694,15 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
	u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);

	for_each_sched_entity(se) {
-               struct load_weight *load;
		struct load_weight lw;

		cfs_rq = cfs_rq_of(se);
-               load = &cfs_rq->load;
-
-               if (unlikely(!se->on_rq)) {
-                       lw = cfs_rq->load;
+               lw = cfs_rq->load;

+               if (unlikely(!se->on_rq))
			update_load_add(&lw, se->load.weight);
-                       load = &lw;
-               }
-               slice = __calc_delta(slice, se->load.weight, load);
+
+               slice = __calc_delta(slice, se->load.weight, &lw);
	}
	return slice;
 }


Cheers

--
Qais Yousef
