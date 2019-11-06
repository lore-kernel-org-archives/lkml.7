Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340EBC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C142173B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNP1KXd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfKFIc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:32:29 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41973 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbfKFIc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:32:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id m9so25023824ljh.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 00:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfU4NeD6tWwvbn+OCuUBpeKGLeW4/SjBIuSOjEeExYc=;
        b=uNP1KXd/gAPRLd0Eazn3Zf4B0u8fajPWtMoC9BhRbuQx6jrzvJIGhOKHc48SewNhIg
         +p0aF/NYvyVmb9Z2R71vkEHF+YP0R5eZ0oKTyc1Bx7MGXTDlPXmwXkxAVfv6hyVibwXE
         vNwWUTMz2t1bgLmyV/Iu7TrlvZx7KiiyUBdkDw0OLrjxmeBEUJkNmTCw4xdEZ/19a4Gp
         8BiZlp/7mn4WkmyiVuD0czhy6lzDAWn4qXJEjXvSwfFb5k1x+r04X1H7OWziYK3NzUxh
         +4XXa41XBfE4RfdqcRhV+r6tugdU/FQh9l6Gr8VqABhaCV2HpqHS9E4YuaI9kPs8b0Ma
         crTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfU4NeD6tWwvbn+OCuUBpeKGLeW4/SjBIuSOjEeExYc=;
        b=fVnxC6yFcf+g989+jgQlQY4pLuGBevwrVxKn90t1souZiS4WiYIbL7nutmJb7zW58f
         yUafhvLj8r2iOb4zLcgmcvdIGG++0yt0rSMdBYDJmcwWkl4rGPA/cCVmKchTgxqJ7w2N
         IqR5ZCo8GXFqesQs2RXS+g4VUINLmGk9LVEiddBbqzOYPk/6Jgnj/4KTL1taXyjoBOo0
         7lTPL+qrDAOG5T1hOT8XBkV4Gf6tLb6cIMey+QE86SeP4v9PAMchzct2lRKGHQ7wNTS9
         zK7OVBcntUXt9TG1EDf1oVEDAHmCJPTdURtL3WsLhcS+IGWFgCDadkkns6Xk7MzT/abQ
         ErOA==
X-Gm-Message-State: APjAAAX1Rv7pTNbIWH2SzvCytlZBOSrFQD3daG5JBEz5LYBXy5TrPKC9
        cS6ZRVr2UfBZm1IWJ1wODEsIYk31Hapxq3ddZ4eBIg==
X-Google-Smtp-Source: APXvYqyUjaV0HLLoLBDZjU01SCdwFqenALueMpCsP0M5G1ItAp8nKWFv5O/8RqXbxvrD1P9/GlN7mNy08s4jH85/gCY=
X-Received: by 2002:a2e:b053:: with SMTP id d19mr1001036ljl.36.1573029147514;
 Wed, 06 Nov 2019 00:32:27 -0800 (PST)
MIME-Version: 1.0
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org> <1572979786-20361-4-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1572979786-20361-4-git-send-email-thara.gopinath@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Nov 2019 09:32:16 +0100
Message-ID: <CAKfTPtBrOdiN+wBfy-1cHr65d48-cBZc3LS7Jt_65Ptssb0Gpg@mail.gmail.com>
Subject: Re: [Patch v5 3/6] sched/fair: Enable periodic update of average
 thermal pressure
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
> Introduce support in CFS periodic tick and other bookkeeping apis
> to trigger the process of computing average thermal pressure for a
> cpu. Also consider avg_thermal.load_avg in others_have_blocked
> which allows for decay of pelt signals.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>
> v4->v5:
>         - Updated both versions of update_blocked_averages to trigger the
>           process of computing average thermal pressure.
>         - Updated others_have_blocked to considerd avg_thermal.load_avg.
>
>  kernel/sched/fair.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2e907cc..9fb0494 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -92,6 +92,8 @@ const_debug unsigned int sysctl_sched_migration_cost  = 500000UL;
>   */
>  static DEFINE_PER_CPU(unsigned long, thermal_pressure);
>
> +static void trigger_thermal_pressure_average(struct rq *rq);
> +
>  #ifdef CONFIG_SMP
>  /*
>   * For asym packing, by default the lower numbered CPU has higher priority.
> @@ -7493,6 +7495,9 @@ static inline bool others_have_blocked(struct rq *rq)
>         if (READ_ONCE(rq->avg_dl.util_avg))
>                 return true;
>
> +       if (READ_ONCE(rq->avg_thermal.load_avg))
> +               return true;
> +
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>         if (READ_ONCE(rq->avg_irq.util_avg))
>                 return true;
> @@ -7580,6 +7585,8 @@ static void update_blocked_averages(int cpu)
>                 done = false;
>
>         update_blocked_load_status(rq, !done);
> +
> +       trigger_thermal_pressure_average(rq);

This must be called before others_have_blocked() to take into account
the latest update

>         rq_unlock_irqrestore(rq, &rf);
>  }
>
> @@ -7646,6 +7653,7 @@ static inline void update_blocked_averages(int cpu)
>         update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>         update_irq_load_avg(rq, 0);
>         update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
> +       trigger_thermal_pressure_average(rq);

idem

>         rq_unlock_irqrestore(rq, &rf);
>  }
>
> @@ -9939,6 +9947,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>
>         update_misfit_status(curr, rq);
>         update_overutilized_status(task_rq(curr));
> +

remove blank line

> +       trigger_thermal_pressure_average(rq);
>  }
>
>  /*
> --
> 2.1.4
>
