Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC743C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E633207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6gx9D8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfLDPW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:22:58 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45829 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfLDPW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:22:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so6410314lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QhRtjHCPm4dHMmypfZVrC9ZvTuu/tqs6/qPMMGAKlVc=;
        b=f6gx9D8Fzo/082KBagEd5YUwuwdJPV3+2qN3Jp4bwdirB80/PSKKbQ7uBb7HKSDXb8
         +c+51IgPuusWznWQZhf6FWGXKC9P3GTNOIr/01a75a+J48vUKtrNEn00TGazRBiLDA2j
         LTr+DaLi1Yw/2qONCSlT0LgGHVp6wRzWm+ejW5wrlQA9XSHrOVYnTcoI7dHn5A6tFuZd
         +ISQXjrhL4bRbSXG8PCPna852/LauG1Chvu7YAjtfuFxs73ZBH9r79iC3rH38mulvwsW
         ejzMTXHEqq6H06yY6l6btr9ixgQpTxytuCNE7HJHwn7I+Hkt1jEt6xdORy7ZbkTrmx8A
         QhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhRtjHCPm4dHMmypfZVrC9ZvTuu/tqs6/qPMMGAKlVc=;
        b=mXLseGaNYF2bG+y1oj9F4jj90w3FVSXrVKF6x6Co/AMoq75wt4p4K28AltvnZVCW7D
         oY10Wk/SbNwvSXnj75SZ85FbHoMYI8Mn9/5ggiJ+EaOIcyL5h4pRPBSEOA6DW6yHF7nq
         WzC72Nmv+uXuzg2X0LEjDIewupeSegEad6AHhw4yENqnWx5dS/FnHh4m+je1OzePWVbA
         E4wO3/FCAP/IcGi/VwTVQhH4+xtJVLSDuJb1XGsbZustELSbZNMjfeeg8RckhRBeM5GS
         bLg2Qd6zsxFK3+RPbICGLdkdSUX+wqLID5po8VsjS1GYWHXlE/cP68XCeWyn41/qEYjB
         YRRA==
X-Gm-Message-State: APjAAAVpHc0Fkhcgr4fadwPMe4KiH4FRrIHBXeWEdTBr4je+nPc3O1wl
        ZTk+j+GBB0BDKYT0beGUD6R0Jtk20p0+PGcmU5c1Nw==
X-Google-Smtp-Source: APXvYqz1JOMHjPsCC+aY+OEI89bDT/1JuNAZxEJcfVpYtKmNUbCuezV4Z0Q0k2J97y3sSPrVRzqqqde2RKoNvY8ETzg=
X-Received: by 2002:a19:f701:: with SMTP id z1mr2364885lfe.133.1575472975799;
 Wed, 04 Dec 2019 07:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20191203155907.2086-1-valentin.schneider@arm.com> <20191203155907.2086-2-valentin.schneider@arm.com>
In-Reply-To: <20191203155907.2086-2-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Dec 2019 16:22:44 +0100
Message-ID: <CAKfTPtC-9nxGCAq8ck0Av6zuqCySvO87oP4hhBE=qKL3gxu+ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] sched/uclamp: Make uclamp_util_*() helpers use and
 return UL values
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019 at 17:02, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Vincent pointed out recently that the canonical type for utilization
> values is 'unsigned long'. Internally uclamp uses 'unsigned int' values for
> cache optimization, but this doesn't have to be exported to its users.
>
> Make the uclamp helpers that deal with utilization use and return unsigned
> long values.
>
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/sched.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 280a3c735935..f1d035e5df7e 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2303,15 +2303,15 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>  unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);

Why not changing uclamp_eff_value to return unsigned long too ? The
returned value represents a utilization to be compared with other
utilization value

>
>  static __always_inline
> -unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
> -                             struct task_struct *p)
> +unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
> +                              struct task_struct *p)
>  {
> -       unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> -       unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
> +       unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> +       unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
>
>         if (p) {
> -               min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
> -               max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
> +               min_util = max_t(unsigned long, min_util, uclamp_eff_value(p, UCLAMP_MIN));

As mentioned above, uclamp_eff_value should return an unsigned long

> +               max_util = max_t(unsigned long, max_util, uclamp_eff_value(p, UCLAMP_MAX));
>         }
>
>         /*
> @@ -2325,17 +2325,17 @@ unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
>         return clamp(util, min_util, max_util);
>  }
>
> -static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
> +static inline unsigned long uclamp_util(struct rq *rq, unsigned long util)
>  {
>         return uclamp_util_with(rq, util, NULL);
>  }
>  #else /* CONFIG_UCLAMP_TASK */
> -static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
> -                                           struct task_struct *p)
> +static inline unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
> +                                            struct task_struct *p)
>  {
>         return util;
>  }
> -static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
> +static inline unsigned long uclamp_util(struct rq *rq, unsigned long util)
>  {
>         return util;
>  }
> --
> 2.24.0
>
