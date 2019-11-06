Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105C0C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF29B2178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEKMpbqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfKFIYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:24:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38677 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbfKFIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:24:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id q28so17365169lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 00:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AsOm6FtAmQ6Vl+H1p7N9YFJ++I/KjSyKvyrHPkvfmIA=;
        b=vEKMpbqJ9++hi5mE5ogUdGpiztGQeCFzAIQWesE2oYkw0SgVf3O0r+uo8C+7sLnZ/z
         Y8sU1XX/yOz32mxkUpaj+iUfCGBuQV5hlW76GoDH/LQ/0fMVIM2hhcK+5iSCYiPy6D+9
         UcixInKzDXXYdBnqtkuOEkXhSqo9yytjM/2094Jwfd8o5NQdNsAVBj5U5ipHOs9BpF6R
         sp1GzVK2wKk+Sp0Qa/fXI/oqDr++v3/7KDKgpe9AKn3x79Qa5fQ6gONzEQY3wQ5WKcd4
         3qcc8Ue9sYV05Akpqv2vJdLN8jxq2yT1lLq8aMy3+6djJHnL0C3/6jTqhw+7Dii9IanV
         uPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AsOm6FtAmQ6Vl+H1p7N9YFJ++I/KjSyKvyrHPkvfmIA=;
        b=Is22diWdfiASkl2++HdFtJ/mQ0kqy/gT2MECv7zeRCc83/911mM3HezCDiD8ZGPqU2
         mvdHP3GUh37AZZcth7Ih7u4tcPyTOP18HlTQq0EJWJf1gwZcjFfjcc4ZLGVmkVRjPboq
         86wuGCe5q8Mrb6Hw1FKFoCE94yO8rPFo2rqc0TusVXlIlddQk8LmEj18YDnTgw9JG/Zn
         q0D5snWh6vCgG5SrsZVBRbU8inWoAcXdtflqPxyMYKs+FjZEuBBuQe578hyazujfRc/r
         4z6wYnsw/2obTdxrNqVSdB1nQg5q7qUB5An+T5Gu4AsVDNNSLFj7YS+wxeeh0nVKRXPn
         zQGA==
X-Gm-Message-State: APjAAAXRYq+yYWBIV3yCphR+9sIcU7SP3IdHvYM7zuCvFKd88TfHAtlb
        1CTOr1o2HhIKy4lBK+5gjTMkJqJyoVj/FbJjcmpR1Q==
X-Google-Smtp-Source: APXvYqz/5+2HAk95D0764lCPwjBPtI6RqezEJR4AypSA8Kq6VC+7lgzr85MlHcvjysgYB1dbSIm+e4ozss+KhOUPf64=
X-Received: by 2002:ac2:5dc1:: with SMTP id x1mr23012889lfq.177.1573028686091;
 Wed, 06 Nov 2019 00:24:46 -0800 (PST)
MIME-Version: 1.0
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org> <1572979786-20361-2-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1572979786-20361-2-git-send-email-thara.gopinath@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Nov 2019 09:24:34 +0100
Message-ID: <CAKfTPtBgp5sb46qD3Uygk-9E1EDMibJkDiA-o3R_6iqYXEdBmg@mail.gmail.com>
Subject: Re: [Patch v5 1/6] sched/pelt.c: Add support to track thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019 at 19:49, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Extrapolating on the exisiting framework to track rt/dl utilization using
> pelt signals, add a similar mechanism to track thermal pressure. The
> difference here from rt/dl utilization tracking is that, instead of
> tracking time spent by a cpu running a rt/dl task through util_avg,
> the average thermal pressure is tracked through load_avg. This is
> because thermal pressure signal is weighted "delta" capacity
> and is not binary(util_avg is binary). "delta capacity" here
> means delta between the actual capacity of a cpu and the decreased
> capacity a cpu due to a thermal event.
> In order to track average thermal pressure, a new sched_avg variable
> avg_thermal is introduced. Function update_thermal_load_avg can be called
> to do the periodic bookeeping (accumulate, decay and average)
> of the thermal pressure.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/pelt.c  | 13 +++++++++++++
>  kernel/sched/pelt.h  |  7 +++++++
>  kernel/sched/sched.h |  1 +
>  3 files changed, 21 insertions(+)
>
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index a96db50..3821069 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -353,6 +353,19 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>         return 0;
>  }
>
> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
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
> index afff644..c74226d 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -6,6 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
>  int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
>
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  int update_irq_load_avg(struct rq *rq, u64 running);
> @@ -159,6 +160,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>  }
>
>  static inline int
> +update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +       return 0;
> +}
> +
> +static inline int
>  update_irq_load_avg(struct rq *rq, u64 running)
>  {
>         return 0;
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
