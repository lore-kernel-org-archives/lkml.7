Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C9CC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CD020679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iZ3+oVH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfG2U0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:26:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51592 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG2U0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kE4otvHLrwNbM6nfc0GGeMt8xggn42O60VMYMYfGMeM=; b=iZ3+oVH8XMUQQS3HNZ6UNEa/f
        Lc9XLwmuHuzNKqXDtmgLnMy4rZEViJpxJbMIHbIg5yr2u+AG5ox4k7xAKH7vC6zQVNoOIELw6MxK4
        vDh/CHOiievgXS8Dn/AU+dquGOU2LHvNkBjfUjynFCeZW6oeos3XnX+acSm1dzn9XAFCZ/h4wGFT3
        WKJjfX2xVi+VdosGR+UXpp45h8DgEYAL2XS70H5CzEk5EBx21QYzFu311HMh/ydjvukKyhOaZDd4i
        Pb5pDb3KauPfiiugb7sh36X5mu3oIYLQoTxq14jYaYjg+Xj4yBWjmA772oJM/fVO+3QXdfTBv3JmR
        mpjwDnzTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsCDi-00078Y-81; Mon, 29 Jul 2019 20:26:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B63DA203BF70D; Mon, 29 Jul 2019 22:26:08 +0200 (CEST)
Date:   Mon, 29 Jul 2019 22:26:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH 03/14] sched,fair: redefine runnable_load_avg as the sum
 of task_h_load
Message-ID: <20190729202608.GT31398@hirez.programming.kicks-ass.net>
References: <20190722173348.9241-1-riel@surriel.com>
 <20190722173348.9241-4-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722173348.9241-4-riel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:33:37PM -0400, Rik van Riel wrote:
> @@ -263,8 +258,8 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runna
>  
>  int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
>  {
> -	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
> -		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
> +	if (___update_load_sum(now, &se->avg, 0, 0)) {
> +		___update_load_avg(&se->avg, se_weight(se));
>  		return 1;
>  	}
>  

The comment above that needs adjustment too, I think.

--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -234,28 +234,13 @@ ___update_load_avg(struct sched_avg *sa,
 /*
  * sched_entity:
  *
- *   task:
- *     se_runnable() == se_weight()
- *
- *   group: [ see update_cfs_group() ]
- *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
- *     se_runnable() = se_weight(se) * grq->runnable_load_avg / grq->load_avg
- *
  *   load_sum := runnable_sum
  *   load_avg = se_weight(se) * runnable_avg
  *
- *   runnable_load_sum := runnable_sum
- *   runnable_load_avg = se_runnable(se) * runnable_avg
- *
- * XXX collapse load_sum and runnable_load_sum
- *
  * cfq_rq:
  *
  *   load_sum = \Sum se_weight(se) * se->avg.load_sum
  *   load_avg = \Sum se->avg.load_avg
- *
- *   runnable_load_sum = \Sum se_runnable(se) * se->avg.runnable_load_sum
- *   runnable_load_avg = \Sum se->avg.runable_load_avg
  */
 
 int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
