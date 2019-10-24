Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7027CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7626821655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMZ44Hqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404696AbfJXOAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:00:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45227 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbfJXOAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:00:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so25136703ljb.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETnYlIOesiteekWPyJgAfWES8RdJm16QvlmzUfSowEU=;
        b=GMZ44Hqbk53I7pWfgmTWV0ZC0+4UtToR0khtqVu3jop0xojD9Qc6m7uvG/cXC6Eupz
         1+z1NnTXTuTrwhSojYGP/I+564V+XBCWiHDArS8VV9EDfsDToOYfiMSpFpFPv3tKasD+
         C6koPzlrid7OURuuLNPI7mUQTDL11F3oj2gYr3JwHjV1Fb+K3kOKRudFMEz22lEx5RjX
         5cTFtIxxlIpKVL6RRRagXS2tN7MPN5vTEtWhQSlbHunwGdrGXdH/4PZfE+3b/yjCZ4rB
         c78h+YOrVm84Gff9+ugQYgxvweeFElDbEalp5uBfnS06so4/eYWj8YweGVtIycCDnyDc
         owUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETnYlIOesiteekWPyJgAfWES8RdJm16QvlmzUfSowEU=;
        b=MU939PqTW66K6lOwm+dzUF9y5ayxE7S9LdTMo6znd/06c3wl9Du5kiYdfaoM80fXMO
         kePaZbRPpgAb/CEdp5QalQx9O1lj47ywSYoUfVaL2tLAkyphF6govygzSrwLOKr6EI1L
         0qycyt8BoVAwD0okBISXePW9yteGwUpSNj59k+ZIXYRLD9uxu48xYz78fj1YLFyjCHyb
         +FTsxlhmKG/m/aFvqJWMjoERcsoVZYiPy5Gy/3iK0O7Le0CFPEO9LHLUiq9ySVjAmCb8
         Y/Fl20LqX9MM0/y2ueN6Sep9odLt67ZWYitKNJgv711uXsmFSytPwp6ciCFrIdDjcMYo
         QVpw==
X-Gm-Message-State: APjAAAUFDXdZGaDpqXT5aPLo7LKDYheolxl0t/ZRox0hZTOYzjsoBKWk
        2p2BrH+AOWtEuCDwQ3z9/9UbYIWoK8oeMgX/s5uS4Q==
X-Google-Smtp-Source: APXvYqyMDp5Uuaml1Ws/21yGHZv6a4hjyBotJCALB8+5EfrsYKWTASAc2wy+o3/eAiLik4SRk8Q3DrYyombrkyLxW2M=
X-Received: by 2002:a05:651c:237:: with SMTP id z23mr3559694ljn.214.1571925613874;
 Thu, 24 Oct 2019 07:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191023205630.14469-1-patrick.bellasi@matbug.net>
In-Reply-To: <20191023205630.14469-1-patrick.bellasi@matbug.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 24 Oct 2019 16:00:02 +0200
Message-ID: <CAKfTPtAegZKuGoLv0PTRV8J9Bz8Qz3=xtAtkjfnv5_jFOn8u6g@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: util_est: fast ramp-up EWMA on utilization increases
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 at 22:56, Patrick Bellasi
<patrick.bellasi@matbug.net> wrote:
>
> The estimated utilization for a task:
>
>    util_est = max(util_avg, est.enqueue, est.ewma)
>
> is defined based on:
>  - util_avg: the PELT defined utilization
>  - est.enqueued: the util_avg at the end of the last activation
>  - est.ewma:     a exponential moving average on the est.enqueued
>                  samples
>
> According to this definition, when a task suddenly change its bandwidth
> requirements from small to big, the EWMA will need to collect multiple
> samples before converging up to track the new big utilization.
>
> This slow convergence towards bigger utilization values is not
> aligned to the default scheduler behavior, which is to optimize for
> performance. Moreover, the est.ewma component fails to compensate for
> temporarely utilization drops which spans just few est.enqueued samples.
>
> To let util_est do a better job in the scenario depicted above, change
> its definition by making util_est directly follow upward motion and
> only decay the est.ewma on downward.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@matbug.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c     | 14 +++++++++++++-
>  kernel/sched/features.h |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a81c36472822..a14487462b6c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3768,11 +3768,22 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
>         if (ue.enqueued & UTIL_AVG_UNCHANGED)
>                 return;
>
> +       /*
> +        * Reset EWMA on utilization increases, the moving average is used only
> +        * to smooth utilization decreases.
> +        */
> +       ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
> +       if (sched_feat(UTIL_EST_FASTUP)) {
> +               if (ue.ewma < ue.enqueued) {
> +                       ue.ewma = ue.enqueued;
> +                       goto done;
> +               }
> +       }
> +
>         /*
>          * Skip update of task's estimated utilization when its EWMA is
>          * already ~1% close to its last activation value.
>          */
> -       ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
>         last_ewma_diff = ue.enqueued - ue.ewma;
>         if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
>                 return;
> @@ -3805,6 +3816,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
>         ue.ewma <<= UTIL_EST_WEIGHT_SHIFT;
>         ue.ewma  += last_ewma_diff;
>         ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
> +done:
>         WRITE_ONCE(p->se.avg.util_est, ue);
>  }
>
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 2410db5e9a35..7481cd96f391 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -89,3 +89,4 @@ SCHED_FEAT(WA_BIAS, true)
>   * UtilEstimation. Use estimated CPU utilization.
>   */
>  SCHED_FEAT(UTIL_EST, true)
> +SCHED_FEAT(UTIL_EST_FASTUP, true)
> --
> 2.17.1
>
