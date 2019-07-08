Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D24FC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C519220861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ISRiZEZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbfGHNzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:55:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731401AbfGHNzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z7WcggLAejPzEpSoHTmfAATgZoGx2QqDsys6bSdrrxM=; b=ISRiZEZ66YGoTqn07Ke3eUgF4
        0oQOIuAyAQnRMcG3rrcypTh1+D7cXB7f1zv1mtzxST8wFhPrly2T0SiTI7zYJboDdQb/9G+Arm2/I
        EckJr0WF3bs3OalPk0UvwP0ZXNLLPNlEaNHUe3o1a5QYnq5CdgiO2sQFNFJwQm2q+glyEZ/UWGW3l
        TDPr1GNUEJvvQINCBWrUu1nC+fYbbdVj/mioF2yH/0aofIQ9Ft7U7yYffIL7pjm2bWJGKNZVSN7Mx
        Jv/aCmeze/IKL7cwE+eMcm6Oug3u4Dw3OICM6GQoAAkcM7M3zbBwhwHeh6m24Dfboyr00aYk3bOca
        rRjn67KuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkU7G-0004LA-8w; Mon, 08 Jul 2019 13:55:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CA4120B28AD7; Mon,  8 Jul 2019 15:55:36 +0200 (CEST)
Date:   Mon, 8 Jul 2019 15:55:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luca Abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 3/6] sched/dl: Try better placement even for deadline
 tasks that do not block
Message-ID: <20190708135536.GK3402@hirez.programming.kicks-ass.net>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-4-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506044836.2914-4-luca.abeni@santannapisa.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 06:48:33AM +0200, Luca Abeni wrote:
> @@ -1223,8 +1250,17 @@ static void update_curr_dl(struct rq *rq)
>  			dl_se->dl_overrun = 1;
>  
>  		__dequeue_task_dl(rq, curr, 0);
> -		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
> +		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr))) {
>  			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
> +#ifdef CONFIG_SMP
> +		} else if (dl_se->dl_adjust) {
> +			if (rq->migrating_task == NULL) {
> +				queue_balance_callback(rq, &per_cpu(dl_migrate_head, rq->cpu), migrate_dl_task);

I'm not entirely sure about this one.

That is, we only do those callbacks from:

  schedule_tail()
  __schedule()
  rt_mutex_setprio()
  __sched_setscheduler()

and the above looks like it can happen outside of those.

The pattern in those sites is:

	rq_lock();
	... do crap that leads to queue_balance_callback()
	rq_unlock()
	if (rq->balance_callback) {
		raw_spin_lock_irqsave(rq->lock, flags);
		... do callbacks
		raw_spin_unlock_irqrestore(rq->lock, flags);
	}

So I suppose can catch abuse of this API by doing something like the
below; can you validate?

---

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aaca0e743776..89e615f1eae6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1134,6 +1134,14 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 	rf->cookie = lockdep_pin_lock(&rq->lock);
 
 #ifdef CONFIG_SCHED_DEBUG
+#ifdef CONFIG_SMP
+	/*
+	 * There should not be pending callbacks at the start of rq_lock();
+	 * all sites that handle them flush them at the end.
+	 */
+	WARN_ON_ONCE(rq->balance_callback);
+#endif
+
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
 #endif
