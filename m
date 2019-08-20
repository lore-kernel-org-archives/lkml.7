Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AD3C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28319205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N5DjTbTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfHTNuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:50:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbfHTNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ORFnO5mFbc4mOEht1POJs7q5/snfb8GWuF8KW3LOEvY=; b=N5DjTbTBq2PDgx7QDjK7KOeB1
        o7p/xclexdtcXOHDnSC/7yHwbdKy8AlUewaxMKdQoVDUEpD/SCljge6kC+siCvGUG7Qwi6XmSkSgQ
        wl+yyDOgYjvtC6p9YSPMXwsuohxX/yuoR0bfXZ2fZCll95pK3PUfe+zERkTMN/t7hjAiTID5zjniN
        l0ibLH2wV5mR1nVXd7DBTUkbMyzCzkUtwXSDKw0CK9PwQinXMgI4HukBf2Xhz4InSiEjfL7v4rTYJ
        0yG2Z/WwUflXPzhP1nb42KFnJ+WP7rxeZr3MOTuiyZzKOfuE7dYKGMKaZuWOopQixfpIVEpHe3Y6q
        CHNJVJwaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i04We-0000Rc-G0; Tue, 20 Aug 2019 13:50:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 182E430768C;
        Tue, 20 Aug 2019 15:49:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 570B120A99A03; Tue, 20 Aug 2019 15:50:14 +0200 (CEST)
Date:   Tue, 20 Aug 2019 15:50:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/core: Schedule new worker even if PI-blocked
Message-ID: <20190820135014.GQ2332@hirez.programming.kicks-ass.net>
References: <20190816160626.12742-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816160626.12742-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 06:06:26PM +0200, Sebastian Andrzej Siewior wrote:
> If a task is PI-blocked (blocking on sleeping spinlock) then we don't want to
> schedule a new kworker if we schedule out due to lock contention because !RT
> does not do that as well.

 s/as well/either/

> A spinning spinlock disables preemption and a worker
> does not schedule out on lock contention (but spin).

I'm not much liking this; it means that rt_mutex and mutex have
different behaviour, and there are 'normal' rt_mutex users in the tree.

> On RT the RW-semaphore implementation uses an rtmutex so
> tsk_is_pi_blocked() will return true if a task blocks on it. In this case we
> will now start a new worker

I'm confused, by bailing out early it does _NOT_ start a new worker; or
am I reading it wrong?

> which may deadlock if one worker is waiting on
> progress from another worker.

> Since a RW-semaphore starts a new worker on !RT, we should do the same on RT.
> 
> XFS is able to trigger this deadlock.
> 
> Allow to schedule new worker if the current worker is PI-blocked.

Which contradicts earlier parts of this changelog.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/sched/core.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3945,7 +3945,7 @@ void __noreturn do_task_dead(void)
>  
>  static inline void sched_submit_work(struct task_struct *tsk)
>  {
> -	if (!tsk->state || tsk_is_pi_blocked(tsk))
> +	if (!tsk->state)
>  		return;
>  
>  	/*
> @@ -3961,6 +3961,9 @@ static inline void sched_submit_work(str
>  		preempt_enable_no_resched();
>  	}
>  
> +	if (tsk_is_pi_blocked(tsk))
> +		return;
> +
>  	/*
>  	 * If we are going to sleep and we have plugged IO queued,
>  	 * make sure to submit it to avoid deadlocks.

What do we need that clause for? Why is pi_blocked special _at_all_?
