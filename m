Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75394C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48737208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/WOC96g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfFZLkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:40:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38285 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZLkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:40:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so1842739ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYohbdTP+qi05cLfUWJvNGeXSNNDpZFJT2u1pfMCJFQ=;
        b=X/WOC96gM9XFBSCuYaLiV7UizFhzSKW1n840H5XnynGoPLXgpdp3e7zfW7dSxgxDXx
         GRKBnOJJ+blBUpc4srK2TmA1j9XcI89gVGAQfzvXYPlDsyB+VulIxWsaX8a0gSVF4L3p
         YuXc+c6FOE30/O7o7tSM5kC72i2J3FE9lEyqFaunUlJ0VS1/GoOSrtKR4mb7oKmws2IA
         NTU8+adeHzt0u/Y73tmeHSCkAQ0sURg+v4BBpoxl2VweUcCjJmVxtb3p9hxDh7TwKxbp
         sZj1ZqmSjR9Inft0cfggYtUMBDx2t0ykTt6WN8nd8N4S3CHjTgj0vZYugX3DIXGn5/Af
         n3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYohbdTP+qi05cLfUWJvNGeXSNNDpZFJT2u1pfMCJFQ=;
        b=FwVn0t4Ysno70TLMuDqNs1C5g7fiaQLyQQuZ9fLMZ+x9QmVLLh+hdczBd+H9LNOFP5
         sBnKmKnwvtJta0Tr2PoZsCYmy/dCUf8N2l0/vOfrAu5UxQUo/B2SapDs7b2CrszGR0N2
         T9pMGrweaNuArM94Cf9+lPL9CIP/WYnUCTdZE/ddAjpePEpmkVpbRBAY4yy1sV1MeZgc
         fAwIhWoHL1m8PmftwVTqMNQJKIENJXBe15uisIo5uGWGpp+wFP+dq1MPHnZzjjkKULH5
         4bKlywUGmacIihP+YINgoflFzEOmQ6dIEg8cr9JAMoA12sZlYTUPvd4lI3hathCXgzym
         jAFw==
X-Gm-Message-State: APjAAAXXz1/Eca2IHK4i/y0oi//bNywCrBiohwkA8Rd7XNyaGc/mi1/P
        Lx2ozNjfKPnFvMFF06U/EgpB8EropntXqN3M/yzwjA==
X-Google-Smtp-Source: APXvYqzOU57v7j5hotdy3IYre+J7rnEQgFT2xh9ij1j2gX60WHYctIWv/FRBnEhB/faeqOrx8gjlWgGTAoLQHCYaPHg=
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr2696243ljj.24.1561549237702;
 Wed, 26 Jun 2019 04:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
In-Reply-To: <20190620150555.15717-1-patrick.bellasi@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 26 Jun 2019 13:40:26 +0200
Message-ID: <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization increases
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On Thu, 20 Jun 2019 at 17:06, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> The estimated utilization for a task is currently defined based on:
>  - enqueued: the utilization value at the end of the last activation
>  - ewma:     an exponential moving average which samples are the enqueued values
>
> According to this definition, when a task suddenly change it's bandwidth
> requirements from small to big, the EWMA will need to collect multiple
> samples before converging up to track the new big utilization.
>
> Moreover, after the PELT scale invariance update [1], in the above scenario we
> can see that the utilization of the task has a significant drop from the first
> big activation to the following one. That's implied by the new "time-scaling"

Could you give us more details about this? I'm not sure to understand
what changes between the 1st big activation and the following one ?
The utilization implied by new "time-scaling" should be the same as
always running at max frequency with previous  method

> mechanisms instead of the previous "delta-scaling" approach.
>
> Unfortunately, these drops cannot be fully absorbed by the current util_est
> implementation. Indeed, the low-frequency filtering introduced by the "ewma" is
> entirely useless while converging up and it does not help in stabilizing sooner
> the PELT signal.
>
> To make util_est do better service in the above scenario, do change its
> definition to slow down only utilization decreases. Do that by resetting the
> "ewma" every time the last collected sample increases.
>
> This change makes also the default util_est implementation more aligned with
> the major scheduler behavior, which is to optimize for performance.
> In the future, this implementation can be further refined to consider
> task specific hints.
>
> [1] sched/fair: Update scale invariance of PELT
>     Message-ID: <tip-23127296889fe84b0762b191b5d041e8ba6f2599@git.kernel.org>
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  kernel/sched/fair.c     | 14 +++++++++++++-
>  kernel/sched/features.h |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3c11dcdedcbc..27b33caaaaf4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3685,11 +3685,22 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
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
> @@ -3722,6 +3733,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
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
> 2.21.0
>
