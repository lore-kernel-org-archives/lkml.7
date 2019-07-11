Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291B4C74A52
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F231521019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T6uOw5fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfGKMAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 08:00:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfGKMAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 08:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mk20t0rVpeYwBEDdSRhCZJaIpHfjZGJUpoaHMNtcYEY=; b=T6uOw5fd9BvjTCiLlpJ0vsWiX
        RQyItAuqA2mm9ZkCDQzXLF6ldsNOM+Yz2aW9M1YEEDL75lwyAsClYiOsm3FCnEUnorMzVWg+1L2oz
        Du9x4vtpQ7MTVdbdyxWod2Xg+7HzHKIKj/BndA2nFMZu5oaCNfnwmuMdmrvjFSC9glPDauljnUlUx
        muPCr7XJ2mSFWvRsOEysjzxiaa9T2ZE+wgPyyoh39qskI2lPLcIfrl3ouBnMbC4P+F52aNbh3j4LW
        t/cmJQMchc74/vUOp/wWT/kULa6tBIl478s+u3eZSLjVbuE07nmQw4pHCiY5BY8YJ8DJBdTsjjrco
        rDxvFAzAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlXkh-0001wO-AF; Thu, 11 Jul 2019 12:00:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1A55201247EB; Thu, 11 Jul 2019 14:00:41 +0200 (CEST)
Date:   Thu, 11 Jul 2019 14:00:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org,
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
Message-ID: <20190711120041.GA3402@hirez.programming.kicks-ass.net>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-4-luca.abeni@santannapisa.it>
 <20190708135536.GK3402@hirez.programming.kicks-ass.net>
 <20190709152436.51825f98@luca64>
 <20190709134200.GD3402@hirez.programming.kicks-ass.net>
 <dac4462d-7384-cf8a-6619-2781c16caa89@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dac4462d-7384-cf8a-6619-2781c16caa89@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 01:17:17PM +0200, Dietmar Eggemann wrote:
> On 7/9/19 3:42 PM, Peter Zijlstra wrote:

> >>> That is, we only do those callbacks from:
> >>>
> >>>   schedule_tail()
> >>>   __schedule()
> >>>   rt_mutex_setprio()
> >>>   __sched_setscheduler()
> >>>
> >>> and the above looks like it can happen outside of those.

> Is this what you are concerned about?
> 
> (2 Cpus (CPU1, CPU2), 4 deadline task (thread0-X)) with 
> 
> @@ -1137,6 +1137,13 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
>         rf->cookie = lockdep_pin_lock(&rq->lock);
>  
>  #ifdef CONFIG_SCHED_DEBUG
> +#ifdef CONFIG_SMP
> +       /*
> +        * There should not be pending callbacks at the start of rq_lock();
> +        * all sites that handle them flush them at the end.
> +        */
> +       WARN_ON_ONCE(rq->balance_callback);
> +#endif
> 
> 
> [   87.251237] *** <--- queue_balance_callback(migrate_dl_task) p=[thread0-3 3627] on CPU2
> [   87.251261] WARNING: CPU: 2 PID: 3627 at kernel/sched/sched.h:1145 __schedule+0x56c/0x690
> [   87.615882] WARNING: CPU: 2 PID: 3616 at kernel/sched/sched.h:1145 task_rq_lock+0xe8/0xf0
> [   88.176844] WARNING: CPU: 2 PID: 3616 at kernel/sched/sched.h:1145 load_balance+0x4d0/0xbc0
> [   88.381905] WARNING: CPU: 2 PID: 3616 at kernel/sched/sched.h:1145 load_balance+0x7d8/0xbc0

I'm not sure how we get 4 warns, I was thinking that as soon as we exit
__schedule() we'd procress the callback so further warns would be
avoided.

> [   88.586991] *** ---> migrate_dl_task() p=[thread0-3 3627] to CPU1

But yes, something like this. Basucally I want to avoid calling
queue_balance_callback() from a context where we'll not follow up with
balance_callback().
