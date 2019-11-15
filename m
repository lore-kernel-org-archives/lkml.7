Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1840CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13922073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dX+DPbwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKOKP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:15:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfKOKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=307qxf8AxoabXpqNRvrAYs2m8iYuBBrAOgYyTa1heOo=; b=dX+DPbwJ/5/OPPy+fQ5FFPbu5
        Zxjadry4/6ee0PzWOMkANVSJZgTFQosJJqQf2lzNVJb4RkktbNJnA6grnzDJFuGA8HrwWzl/Vac66
        dsmVlfOKD255Ch72I3GMHvkpdRD0nTxm9XNyaCWN8pTE98BHBDS6EiSb9gsE6ejC80hlNfP3GoZb/
        tnx7V4GVzW+bIwjlqdg2YJDJBLb58ZV0jdxQKxAl42Pebv7mbET3Uu8i1Tq24Alef1IyYABb8cn/V
        3yDemq9jMq6WuGxjDiy6Kqg36RJCaCHcKFleGtCOJfg+olmQw0X2Z1eTesvXAn4ziJLmrzRaoT/tY
        I3eJgVXmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVYcq-00068R-Rx; Fri, 15 Nov 2019 10:14:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 970493006FB;
        Fri, 15 Nov 2019 11:13:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7CC52B128BE4; Fri, 15 Nov 2019 11:14:45 +0100 (CET)
Date:   Fri, 15 Nov 2019 11:14:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 3/9] sched/vtime: Handle nice updates under vtime
Message-ID: <20191115101445.GB4131@hirez.programming.kicks-ass.net>
References: <20191106030807.31091-1-frederic@kernel.org>
 <20191106030807.31091-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106030807.31091-4-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 04:08:01AM +0100, Frederic Weisbecker wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7880f4f64d0e..fa56a1bdd5d8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4488,6 +4488,7 @@ void set_user_nice(struct task_struct *p, long nice)
>  	int old_prio, delta;
>  	struct rq_flags rf;
>  	struct rq *rq;
> +	int old_static;
>  
>  	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
>  		return;
> @@ -4498,6 +4499,8 @@ void set_user_nice(struct task_struct *p, long nice)
>  	rq = task_rq_lock(p, &rf);
>  	update_rq_clock(rq);
>  
> +	old_static = p->static_prio;
> +
>  	/*
>  	 * The RT priorities are set via sched_setscheduler(), but we still
>  	 * allow the 'normal' nice value to be set - but as expected
> @@ -4532,7 +4535,9 @@ void set_user_nice(struct task_struct *p, long nice)
>  	}
>  	if (running)
>  		set_next_task(rq, p);
> +
>  out_unlock:
> +	vtime_set_nice(rq, p, old_static);
>  	task_rq_unlock(rq, p, &rf);
>  }
>  EXPORT_SYMBOL(set_user_nice);
> @@ -4668,8 +4673,8 @@ static struct task_struct *find_process_by_pid(pid_t pid)
>   */
>  #define SETPARAM_POLICY	-1
>  
> -static void __setscheduler_params(struct task_struct *p,
> -		const struct sched_attr *attr)
> +static void __setscheduler_params(struct rq *rq, struct task_struct *p,
> +				  const struct sched_attr *attr)
>  {
>  	int policy = attr->sched_policy;
>  
> @@ -4680,8 +4685,11 @@ static void __setscheduler_params(struct task_struct *p,
>  
>  	if (dl_policy(policy))
>  		__setparam_dl(p, attr);
> -	else if (fair_policy(policy))
> +	else if (fair_policy(policy)) {
> +		int old_prio = p->static_prio;
>  		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
> +		vtime_set_nice(rq, p, old_prio);
> +	}
>  
>  	/*
>  	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
> @@ -4704,7 +4712,7 @@ static void __setscheduler(struct rq *rq, struct task_struct *p,
>  	if (attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)
>  		return;
>  
> -	__setscheduler_params(p, attr);
> +	__setscheduler_params(rq, p, attr);
>  
>  	/*
>  	 * Keep a potential priority boosting if called from

Would it make sense to add a helper like:

static void
__sched_set_nice(struct rq *rq, struct task_struct *t, long nice)
{
	int old_prio;

	old_prio = t->static_prio;
	t->static_prio = NICE_TO_PRIO(nice);
	vtime_set_nice(rq, t, old_prio);
}

