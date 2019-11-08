Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB2C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C70206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tYXId5j6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbfKHLCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:02:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55684 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfKHLCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:02:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so5697411wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 03:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xt2Dsx7eV0kOKoR7OBulY49njgF5EaP+7J0wKDzJbxg=;
        b=tYXId5j6mgObps3Rl924fGEs56wMPwnO8dbAJTnnuNslLECWWu2S0Nt+Z1UjbAAo9e
         fCeZ+Vd2osoMQIeTRLcR/FpAs3+mUNIHdEU3NlBVw++WbTOfmYv2RRJt3XVRC9L5c/Fj
         9OsCxIThqnEiiS0YYuMAytS82MFPXIQ587JRMwEFGd9ZjE2w6g1/JWbEXwQbiT4LF5uS
         o1ez3RMPc5AI+ykrsWd2Wg41W5aUtaerE9XM3PdyCqNq9ZQag06di7JBWN2+pjue5KVY
         10pFKE64uxNk1SRTMsJfcB4d7a7CQfP/EgmFL/H3TTosredK3x2YBuj+gepf9uP++9BP
         nUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xt2Dsx7eV0kOKoR7OBulY49njgF5EaP+7J0wKDzJbxg=;
        b=Gx4AdiVR5p3ROVtDzfSmU/0KvtBkqPKGcPciRmPKOSIsywuRBNNiEhiI1xse2nSGa/
         hs20njHf+iKQho3ZAXADBYleUcqTuXavoiRx7T1+Y3DqlpKWI+EvtOmIkvmV6UxyWBoQ
         qqcqmJ657n1HbyXUHZhdpal4dvwGhGXsy2ZgX4KHyhj0iOvySbIXTFA0C2FTQnP+m4OA
         Jle5F8i32F2ckXF+7ciR0KUuseZQyGWMw/YzdZ1p0vnNJjFRC15p1uRXdmp6P84t8XEY
         R/xSeN8iDy5FtNOK4S8gwYSzesYrIbiO7g8NxKC9zpoP2R2dEDrcoXsyqRhY4fFoZ2bC
         usqw==
X-Gm-Message-State: APjAAAVyQ8BiCdihSm0QfODnah0tFU+dF3Aiu9KtsesR2EAgYEquH14+
        3zaziPM4e7N9qu9A4eB2zihOUnU2Ua8=
X-Google-Smtp-Source: APXvYqyCBPfeueAyfkWNDGPsxDxgtl4yxF50q7FStDaKhiXs+0wOUBDt7fEBpjs+q255CZrV4D0IWw==
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr7820854wmg.145.1573210936319;
        Fri, 08 Nov 2019 03:02:16 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id d11sm7461036wrf.80.2019.11.08.03.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 03:02:15 -0800 (PST)
Date:   Fri, 8 Nov 2019 11:02:12 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191108110212.GA204618@google.com>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
 <20191107192907.GA30258@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107192907.GA30258@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Nov 2019 at 20:29:07 (+0100), Peter Zijlstra wrote:
> I still havne't had food, but this here compiles...

And it seems to work, too :)

> @@ -3929,13 +3929,17 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	}
> 
>  restart:
> -	/*
> -	 * Ensure that we put DL/RT tasks before the pick loop, such that they
> -	 * can PULL higher prio tasks when we lower the RQ 'priority'.
> -	 */
> -	prev->sched_class->put_prev_task(rq, prev, rf);
> -	if (!rq->nr_running)
> -		newidle_balance(rq, rf);
> +#ifdef CONFIG_SMP
> +	for (class = prev->sched_class;
> +	     class != &idle_sched_class;
> +	     class = class->next) {
> +
> +		if (class->balance(rq, prev, rf))
> +			break;
> +	}
> +#endif
> +
> +	put_prev_task(rq, prev);

Right, that looks much cleaner IMO. I'm thinking if we killed the
special case for CFS above we could do with a single loop to iterate the
classes, and you could fold ->balance() in ->pick_next_task() ...
That would remove one call site to newidle_balance() too, which I think
is good. Hackbench probably won't like that, though.

>  	for_each_class(class) {
>  		p = class->pick_next_task(rq, NULL, NULL);
> @@ -6201,7 +6205,7 @@ static struct task_struct *__pick_migrate_task(struct rq *rq)
>  	for_each_class(class) {
>  		next = class->pick_next_task(rq, NULL, NULL);
>  		if (next) {
> -			next->sched_class->put_prev_task(rq, next, NULL);
> +			next->sched_class->put_prev_task(rq, next);
>  			return next;
>  		}
>  	}
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 2dc48720f189..b6c3fb10cf57 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1778,15 +1778,9 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	return p;
>  }
> 
> -static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
> +static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
>  {
> -	update_curr_dl(rq);
> -
> -	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
> -	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
> -		enqueue_pushable_dl_task(rq, p);
> -

Ah, and this can actually be done after the pull because the two are in
fact mutually exclusive. And same thing for RT. Good :)

> -	if (rf && !on_dl_rq(&p->dl) && need_pull_dl_task(rq, p)) {
> +	if (!on_dl_rq(&p->dl) && need_pull_dl_task(rq, p)) {
>  		/*
>  		 * This is OK, because current is on_cpu, which avoids it being
>  		 * picked for load-balance and preemption/IRQs are still
> @@ -1797,6 +1791,18 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct rq_fla
>  		pull_dl_task(rq);
>  		rq_repin_lock(rq, rf);
>  	}
> +
> +	return rq->dl.dl_nr_running > 0;
> +}
> +
> +
> +static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
> +{
> +	update_curr_dl(rq);
> +
> +	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
> +	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
> +		enqueue_pushable_dl_task(rq, p);
>  }
> 
>  /*
> @@ -2438,6 +2444,7 @@ const struct sched_class dl_sched_class = {
>  	.check_preempt_curr	= check_preempt_curr_dl,
> 
>  	.pick_next_task		= pick_next_task_dl,
> +	.balance		= balance_dl,
>  	.put_prev_task		= put_prev_task_dl,
>  	.set_next_task		= set_next_task_dl,
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a14487462b6c..6b983214e00f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6746,10 +6746,18 @@ done: __maybe_unused;
>  	return NULL;
>  }
> 
> +static int balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> +{
> +	if (rq->cfs.nr_running)
> +		return 1;
> +
> +	return newidle_balance(rq, rf) != 0;

And you can ignore the RETRY_TASK case here under the assumption that
we must have tried to pull from RT/DL before ending up here ?

Thanks,
Quentin
