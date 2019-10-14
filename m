Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECF4C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C3A2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kl8Q9TYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbfJNNz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:55:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38725 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbfJNNz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:55:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id u28so11879561lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXwy1ZfXmnwZ3hifWlYThMGXSNlwZ/MYnTxH+t42hRk=;
        b=Kl8Q9TYEwJsyah3aNcP75PA8oy/jmHqhnhgmMg20jrDsUzR9Ioyg4VL+nl67XgzpwR
         wBmLU9vD5UWaxzcW11uY0XoYAjD/dVwlFMB5Rv/on1AVoHbkxeG15oMad1+F3CS1GkAR
         nIxybmiwqKCyVRvq0V5YqgtfgiiZ4uX8/CYnv2lMqFeul1wD1H2eAvyRDZ3Kxvold7fm
         ZIPZPIxYU22CvvJiEJs8sRD/xKxmBiJRQMUaoq5PMQCcR1DtwS/DvaeuQU/9E/gxsGLR
         G+uo5slLa7d9XZTztqhqUZDJAe9T6x3AK4yykx6Al1oq1CMTz52b/14BujuQFHM1upiy
         9LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXwy1ZfXmnwZ3hifWlYThMGXSNlwZ/MYnTxH+t42hRk=;
        b=FKYtH1gQEtifG44qkwE5kmpqKRgMl5RfBwmYVIg3MQb/Kl6jxeJBVR5Z07XOqY5CoG
         /ZuIMxS9IvNxb4eWWNC5J4jgLPhwh2ifTrU0PwjtJyc1/dzVARPsxpQPvLBJoyQIceYS
         b9dOR7aOCmeD1BziPIcd1eqqX4TkLAh2/jbVsHSpuiHys+Oj6ssz2KYjpF2xm6ya5Z1s
         uq7xYa3ccNP5/N+bJY3yYoTPb3/Y24Us/WemZuITtxYqQICikGqXHOWNdN8qIqwtV/an
         +URLTthg8Hrh1U5ElMFp2RO2O8V7PGn9n7LM0PFT3DMECSxLmYmUXc9cwNBSqzh4Vqwg
         qXfQ==
X-Gm-Message-State: APjAAAWUc0c+EfipKqYdJT5QPPimfIoKJ5sde7C/z7743mS1sKPA/52H
        x+gMZNbGSsuvZ4n9X0rGWC3ST3mCeLko+EpDtIG8fA==
X-Google-Smtp-Source: APXvYqxnVb+5mh/Zgb9iLIpqLC8zBUR7RgvkoPI5yGMzs0v2vphxtYKl2lltO6U3MrQJ/oxOHmqmMQtA6/uOO20LpeE=
X-Received: by 2002:a19:4f0e:: with SMTP id d14mr17070099lfb.177.1571061354112;
 Mon, 14 Oct 2019 06:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org> <1571014705-19646-2-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1571014705-19646-2-git-send-email-thara.gopinath@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Oct 2019 15:55:42 +0200
Message-ID: <CAKfTPtCCjETcDNdP1xuRJ0w3futRV+J+hqkXgYyPQXzOqnaoVg@mail.gmail.com>
Subject: Re: [Patch v3 1/7] sched/pelt.c: Add support to track thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On Mon, 14 Oct 2019 at 02:58, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Extrapolating on the exisitng framework to track rt/dl utilization using

s/exisitng/existing/

> pelt signals, add a similar mechanism to track thermal pressue. The

s/pessure/pressure/

> difference here from rt/dl utilization tracking is that, instead of
> tracking time spent by a cpu running a rt/dl task through util_avg,
> the average thermal pressure is tracked through load_avg.

It would be good to mention why you use load_avg field instead of
util_avg field: because the signal is weighted with the capped
capacity and is not binary
And also explained a bit what capacity refer to

> In order to track average thermal pressure, a new sched_avg variable
> avg_thermal is introduced. Function update_thermal_avg can be called
> to do the periodic bookeeping (accumulate, decay and average)
> of the thermal pressure.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/pelt.c  | 13 +++++++++++++
>  kernel/sched/pelt.h  |  7 +++++++
>  kernel/sched/sched.h |  1 +
>  3 files changed, 21 insertions(+)
>
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index a96db50..f06aae3 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -353,6 +353,19 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>         return 0;
>  }
>
> +int update_thermal_avg(u64 now, struct rq *rq, u64 capacity)

All the other functions are named :
update_cfs_rq/rt_rq/dl_rq/irq_load_avg

might be good to keep similar name with update_thermal_load_avg

> +{
> +       if (___update_load_sum(now, &rq->avg_thermal,
> +                              capacity,
> +                              capacity,
> +                              capacity)) {
> +               ___update_load_avg(&rq->avg_thermal, 1, 1);
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  /*
>   * irq:
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index afff644..01c5436 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -6,6 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
>  int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
> +int update_thermal_avg(u64 now, struct rq *rq, u64 capacity);
>
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  int update_irq_load_avg(struct rq *rq, u64 running);
> @@ -175,6 +176,12 @@ update_rq_clock_pelt(struct rq *rq, s64 delta) { }
>  static inline void
>  update_idle_rq_clock_pelt(struct rq *rq) { }
>
> +static inline int

can you keep some function ordering as above and move
update_thermal_avg() just after update_dl_rq_load_avg


> +update_thermal_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +       return 0;
> +}
> +
>  #endif
>
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 0db2c1b..d5d82c8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -944,6 +944,7 @@ struct rq {
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>         struct sched_avg        avg_irq;
>  #endif
> +       struct sched_avg        avg_thermal;
>         u64                     idle_stamp;
>         u64                     avg_idle;
>
> --
> 2.1.4
>
