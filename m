Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D428C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B6220850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k5ZZKMdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDKKxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:53:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4DMwqE/wpi84eAYFosQgSFv8KAYn6/tb1LsU1fVxDRo=; b=k5ZZKMdguMvKaSN4FVOzyWy8I
        5OuorJNKkj9YHN3NvBi9oBpRwAP/mXvKHJ6mz/k3GU6szlKEjyVo7w/NA9t863sHjTR/y8WUxdOXu
        gjQ9MUwWO+nFjfM8pePvtQ/Pd2DrYJT3dZdlBfwwfMGkQPfLJDk4jA/gIXY/u7J7z7I9EMYKhvyMu
        3Ea8Fas+WxJ8DMJNuHwQF3QwvETmDtlwqVvkYQ747ToOc+Ze63/S4B+3w1IpFuuEmCHNE1rSwJGUS
        MpY7fNf5pwAxjsak4DEgk2hwoDnK9/ZQOpX/lbskR8luc6QVWEdbqLeHOcLgnflF7p3O/5kRhwSq6
        RZoOfXSAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEXKs-0000X8-DM; Thu, 11 Apr 2019 10:53:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D30A929AAD021; Thu, 11 Apr 2019 12:53:36 +0200 (CEST)
Date:   Thu, 11 Apr 2019 12:53:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20190411105336.GK4038@hirez.programming.kicks-ass.net>
References: <20190411060536.22409-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411060536.22409-1-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Was this supposed to be patch 6/5 of your previous series?

On Thu, Apr 11, 2019 at 04:05:36PM +1000, Nicholas Piggin wrote:
> Date: Tue, 9 Apr 2019 20:23:16 +1000
> Subject: [PATCH] kernel/sched: run nohz idle load balancer on HK_FLAG_MISC
>  CPUs
> 
> The nohz idle balancer runs on the lowest idle CPU. This can
> interfere with isolated CPUs, so confine it to HK_FLAG_MISC
> housekeeping CPUs.
> 
> HK_FLAG_SCHED is not used for this because it is not set anywhere
> at the moment. This could be folded into HK_FLAG_SCHED once that
> option is fixed.
> 
> The problem was observed with increased jitter on an application
> running on CPU0, caused by nohz idle load balancing being run on
> CPU1 (an SMT sibling).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  kernel/sched/fair.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fdab7eb6f351..d29ca323214d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9522,22 +9522,26 @@ static inline int on_null_domain(struct rq *rq)
>   * - When one of the busy CPUs notice that there may be an idle rebalancing
>   *   needed, they will kick the idle load balancer, which then does idle
>   *   load balancing for all the idle CPUs.
> + * - HK_FLAG_MISC CPUs are used for this task, because HK_FLAG_SCHED not set
> + *   anywhere yet.
>   */
>  
>  static inline int find_new_ilb(void)
>  {
> -	int ilb = cpumask_first(nohz.idle_cpus_mask);
> +	int ilb;
>  
> -	if (ilb < nr_cpu_ids && idle_cpu(ilb))
> -		return ilb;
> +	for_each_cpu_and(ilb, nohz.idle_cpus_mask,
> +			      housekeeping_cpumask(HK_FLAG_MISC)) {
> +		if (idle_cpu(ilb))
> +			return ilb;
> +	}
>  
>  	return nr_cpu_ids;
>  }
>  
>  /*
> - * Kick a CPU to do the nohz balancing, if it is time for it. We pick the
> - * nohz_load_balancer CPU (if there is one) otherwise fallback to any idle
> - * CPU (if there is one).
> + * Kick a CPU to do the nohz balancing, if it is time for it. We pick any
> + * idle CPU in the HK_FLAG_MISC housekeeping set (if there is one).
>   */
>  static void kick_ilb(unsigned int flags)
>  {
> -- 
> 2.20.1
> 
