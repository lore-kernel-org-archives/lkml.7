Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C77C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594562089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H7Gffehm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKUMiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:38:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfKUMiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TXLU5lx1Bkxo3ywrxVI3JlMFn+Xwo+ncCfBlxFtyhyU=; b=H7GffehmG0T3CLTlYNJs8Zerl
        vBvHd+/Y9VHhblQSJK0+3y3VxQVbjsnySzbA2VXp7pls9EPyj8FQBjeCXYuwkpXlvTB7x3+9A9jgQ
        BTDz5w/5gaSpAHTz/+X0lkryVpqUplpR88jRos7wX7OmOdqmS9yrtno9n3t7/7oqI9EZX1xgJZnde
        0urUc2hGCUFeToxnX/uCsrvABdvS9XC2EBLnKjHdqoa/njUrpXQfMj5fLoFa0x2Ux8uKXloDxAttu
        9xNfk5LADrUoH9iufgkhoGWFyIR7tESo14eqUiOCqjtIbU0/4lJIkkETR9Y5mfLEG/d8sDELZQXdn
        ips9IxP7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXlin-0005qq-Qq; Thu, 21 Nov 2019 12:38:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55B7E300565;
        Thu, 21 Nov 2019 13:36:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33847201DD6AF; Thu, 21 Nov 2019 13:38:04 +0100 (CET)
Date:   Thu, 21 Nov 2019 13:38:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     YT Chang <yt.chang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 1/1] sched: cfs_rq h_load might not update due to irq
 disable
Message-ID: <20191121123804.GR4097@hirez.programming.kicks-ass.net>
References: <1574325009-10846-1-git-send-email-yt.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574325009-10846-1-git-send-email-yt.chang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 04:30:09PM +0800, YT Chang wrote:
> Syndrome:
> 
> Two CPUs might do idle balance in the same time.
> One CPU does idle balance and pulls some tasks.
> However before pick next task, ALL task are pulled back to other CPU.
> That results in infinite loop in both CPUs.

Can you easily reproduce this?

> =========================================
> code flow:
> 
> in pick_next_task_fair()
> 
> again:
> 
> if nr_running == 0
> 	goto idle
> pick next task
> 	return
> 
> idle:
> 	idle_balance
>        /* pull some tasks from other CPU,
>         * However other CPU are also do idle balance,
> 	* and pull back these task */
> 
> 	go to again
> 
> =========================================
> The result to pull ALL tasks back when the task_h_load
> is incorrect and too low.

Clearly you're not running a PREEMPT kernel, otherwise the break in
detach_tasks() would've saved you, right?

> static unsigned long task_h_load(struct task_struct *p)
> {
>         struct cfs_rq *cfs_rq = task_cfs_rq(p);
> 
> 	update_cfs_rq_h_load(cfs_rq);
> 	return div64_ul(p->se.avg.load_avg_contrib * cfs_rq->h_load,
> 			cfs_rq->runnable_load_avg + 1);
> }
> 
> The cfs_rq->h_load is incorrect and might too small.
> The original idea of cfs_rq::last_h_load_update will not
> update cfs_rq::h_load more than once a jiffies.
> When the Two CPUs pull each other in the pick_next_task_fair,
> the irq disabled and result in jiffie not update.
> (Other CPUs wait for runqueue lock locked by the two CPUs.
> So, ALL CPUs are irq disabled.)

This cannot be true; because the loop drops rq->lock, so other CPUs
should have an opportunity to acquire the lock and make progress.

> Solution:
> cfs_rq h_load might not update due to irq disable
> use sched_clock instead jiffies
> 
> Signed-off-by: YT Chang <yt.chang@mediatek.com>
> ---
>  kernel/sched/fair.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 83ab35e..231c53f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7578,9 +7578,11 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
>  {
>  	struct rq *rq = rq_of(cfs_rq);
>  	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
> -	unsigned long now = jiffies;
> +	u64 now = sched_clock_cpu(cpu_of(rq));
>  	unsigned long load;
>  
> +	now = now * HZ >> 30;
> +
>  	if (cfs_rq->last_h_load_update == now)
>  		return;
>  

This is disguisting and wrong. That is not the correct relation between
sched_clock() and jiffies.
