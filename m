Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC492C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B355A206E4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nn8mWKLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfLBNWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:22:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44282 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfLBNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ByS6cD7gHgezj2QYsDI0rCaLPzSlfQQauHPBggjUu7I=; b=nn8mWKLLbMKOmA3ZsBMGrY8vJ
        oKPxt6FMFyDq9qjHHN89s8Qf9NvSnVRlJIZLwNm/zjdd3Yn2J3ncJc1A83cWHYhIwZxb/UjQsNQIP
        boUEmaup22i3FqmH/aj5nvcWVduxnEfY5bDgT8v8XGeNJPvxbYFnEFJcKBOjba+l+3xe/770v8F37
        Tpj4tklgf5gIJ1BufrlZ+b5GaLncPAMDmskVvT849QuxtlcehhyLwfRrEc9J3v/7ump96LRkeqwoG
        4wPi1BwRR4aW/NyhAsbQgo81MslJv3/em2HExZqqpMXxQGqxcStYgfUiHiUnwYmKTt+Wg89fZYLnm
        wXoE5yy/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibleQ-0008FP-19; Mon, 02 Dec 2019 13:22:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 657E83006E3;
        Mon,  2 Dec 2019 14:20:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1606E20236A4D; Mon,  2 Dec 2019 14:22:04 +0100 (CET)
Date:   Mon, 2 Dec 2019 14:22:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cfs: fix spurious active migration
Message-ID: <20191202132204.GK2844@hirez.programming.kicks-ass.net>
References: <1575036287-6052-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575036287-6052-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 03:04:47PM +0100, Vincent Guittot wrote:
> The load balance can fail to find a suitable task during the periodic check
> because  the imbalance is smaller than half of the load of the waiting
> tasks. This results in the increase of the number of failed load balance,
> which can end up to start an active migration. This active migration is
> useless because the current running task is not a better choice than the
> waiting ones. In fact, the current task was probably not running but
> waiting for the CPU during one of the previous attempts and it had already
> not been selected.
> 
> When load balance fails too many times to migrate a task, we should relax
> the contraint on the maximum load of the tasks that can be migrated
> similarly to what is done with cache hotness.
> 
> Before the rework, load balance used to set the imbalance to the average
> load_per_task in order to mitigate such situation. This increased the
> likelihood of migrating a task but also of selecting a larger task than
> needed while more appropriate ones were in the list.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> I haven't seen any noticable performance changes on the benchmarks that I
> usually run but the problem can be easily highlight with a simple test
> with 9 always running tasks on 8 cores.
> 
>  kernel/sched/fair.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e0d662a..d1b4fa7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7433,7 +7433,14 @@ static int detach_tasks(struct lb_env *env)
>  			    load < 16 && !env->sd->nr_balance_failed)
>  				goto next;
>  
> -			if (load/2 > env->imbalance)
> +			/*
> +			 * Make sure that we don't migrate too much load.
> +			 * Nevertheless, let relax the constraint if
> +			 * scheduler fails to find a good waiting task to
> +			 * migrate.
> +			 */
> +			if (load/2 > env->imbalance &&
> +			    env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
>  				goto next;
>  
>  			env->imbalance -= load;

The alternative is carrying a flag that inhibits incrementing
nr_balance_failed.

Not migrating anything when doing so would make the imbalance worse is
not a failure after all.
