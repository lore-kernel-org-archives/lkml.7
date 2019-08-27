Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB20C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3636206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhA1kkrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfH0M3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:29:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41736 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfH0M27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:28:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id j4so4129216lfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IrvTyiP5uOe3nkt4yyBHrThnDSmKFkgXLFlJJeQFR3o=;
        b=xhA1kkrz9zuMoZ661z6on04LYIQa+xd0K/cfJXpljR8KT+VLM8k0Jyf7nHDehNy7r/
         hiHA2D7Ke/OKsD7/IzFlcKniW4cUMh1tnlCpEUG7FUalFCZae6aq5ekCGEhEXY2SeelY
         T+HtQZNKY4H25B4PYDAK+MvzvQ+In0p9RsxTWtcTHtOsObWptvWE6R67bA6cdzmYDyLA
         FnfoElL5s2OUVf6Oi8SnQR3XW5SJU1kq+vIQeg6wf7vcYmBeSOfqiK+2IJ35HKVwNzXb
         tk2ycU5PYcnQW5dXIaKFHeAbkyh5f+Gh7MlXFyCqnrYVknOrwq74Tbxjhv3NL5cW/mfI
         I9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IrvTyiP5uOe3nkt4yyBHrThnDSmKFkgXLFlJJeQFR3o=;
        b=nqyFUlQSewpMqwShQsurM224x/9ebf8jHc3LVeYxsCzVNIFES6MANFQcPOabDY4AZ9
         OMwwR+hgEad2fshXzTzQOR8wURd0dwrgWp8k6gBWhokA9Ysi/sBTZGAnaBG9jk3pxuyt
         7ClYduYKrihxtQOAZx/O4AU0XooSH1mY4CL+UmfUWj71q1eJuccLs4Yszi/SxyCYz/Wl
         T8CuAwv2daWybIVZ0IQXBeLfQu/h83wISA+RoxU+sRAk04MsDPFHpr/3lkgMNCqwPiFR
         ZfRqztuTzoidKjJ9NZt7/qhxzBIRi25fFbCOrTXEfIzlVtiSAsTyqhYPW/yniyuoXO2s
         rpXA==
X-Gm-Message-State: APjAAAUlKJ+bT6sSs/G8fPowQjqrzwP6EKahgJaZ5IYf3yd6OmJx46C6
        8yCfzXr5u3GUt5ovNZptc5jDCMqPvJE4+bOcd4N3Rw==
X-Google-Smtp-Source: APXvYqwKc5xbpTi5UK/jpybetG3Q8v8fzsVk7UFbXP4lz3ieVaSgQhTDMzwcNzFVlt9uBZmZD+PuBjJWkmFnwa4OQBw=
X-Received: by 2002:a19:f603:: with SMTP id x3mr12851076lfe.125.1566908937534;
 Tue, 27 Aug 2019 05:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190815145107.5318-1-valentin.schneider@arm.com> <20190815145107.5318-5-valentin.schneider@arm.com>
In-Reply-To: <20190815145107.5318-5-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 27 Aug 2019 14:28:46 +0200
Message-ID: <CAKfTPtCq3fv_ajgwnUUodnd+G_Bx6Jqod3751FnB5AASxZczYg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] sched/fair: Prevent active LB from preempting
 higher sched classes
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019 at 16:52, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> The CFS load balancer can cause the cpu_stopper to run a function to
> try and steal a remote rq's running task. However, it so happens
> that while only CFS tasks will ever be migrated by that function, we
> can end up preempting higher sched class tasks, since it is executed
> by the cpu_stopper.
>
> This can potentially occur whenever a rq's running task is > CFS but
> the rq has runnable CFS tasks.
>
> Check the sched class of the remote rq's running task after we've
> grabbed its lock. If it's CFS, carry on, otherwise run
> detach_one_task() locally since we don't need the cpu_stopper (that
> !CFS task is doing the exact same thing).

AFAICT, this doesn't prevent from preempting !CFS task but only reduce
the window.
As soon as you unlock, !CFS task can preempt CFS before you start stop thread

testing  busiest->cfs.h_nr_running < 1 and/or
busiest->curr->sched_class != &fair_sched_class
in need_active_balance() will do almost the same and is much simpler
than this patchset IMO.

>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8f5f6cad5008..bf4f7f43252f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8759,6 +8759,7 @@ static inline enum alb_status active_load_balance(struct lb_env *env)
>         enum alb_status status = cancelled;
>         struct sched_domain *sd = env->sd;
>         struct rq *busiest = env->src_rq;
> +       struct task_struct *p = NULL;
>         unsigned long flags;
>
>         schedstat_inc(sd->lb_failed[env->idle]);
> @@ -8780,6 +8781,16 @@ static inline enum alb_status active_load_balance(struct lb_env *env)
>         if (busiest->cfs.h_nr_running < 1)
>                 goto unlock;
>
> +       /*
> +        * If busiest->curr isn't CFS, then there's no point in running the
> +        * cpu_stopper. We can try to nab one CFS task though, since they're
> +        * all ready to be plucked.
> +        */
> +       if (busiest->curr->sched_class != &fair_sched_class) {
> +               p = detach_one_task(env);
> +               goto unlock;
> +       }
> +
>         /*
>          * Don't kick the active_load_balance_cpu_stop, if the curr task on
>          * busiest CPU can't be moved to dst_cpu:
> @@ -8803,7 +8814,9 @@ static inline enum alb_status active_load_balance(struct lb_env *env)
>  unlock:
>         raw_spin_unlock_irqrestore(&busiest->lock, flags);
>
> -       if (status == started)
> +       if (p)
> +               attach_one_task(env->dst_rq, p);
> +       else if (status == started)
>                 stop_one_cpu_nowait(cpu_of(busiest),
>                                     active_load_balance_cpu_stop, busiest,
>                                     &busiest->active_balance_work);
> --
> 2.22.0
>
