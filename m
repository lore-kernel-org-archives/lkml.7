Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC83AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07192465E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VH7XmMTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLMIhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:37:41 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35794 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfLMIhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:37:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id 15so1350843lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 00:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IViYxUVtxhmy+DhoYbq41mJ5frzvzah03nv9ueXSwIM=;
        b=VH7XmMTYa7gkUtI0dk0K3xQG+rHb2TE89MdDnwaMmu/omPIeRmBQT7R00hlMq46Vop
         n/L7FWABeXBTjQHxUhlvc3iobGa8yZ3q34qp+H9FTf8HLq36L37n4C/BjbMXVEQsKxcH
         qq8KUavWNUAneUOUX31KLR0ZjLlgFCKGPMRPHnhWbqNaY9cXTQjAYj50EF5ZRpZbmPpK
         /4X2wO+R+/qBv5J0kAXLzlCOg5Afx6y6VmzNEIzBMLDGTFYbbrTZDcuFFACi/1dq7HE1
         Vevyj4b4HzDEbN8cwGI2xILgLmVjGeKKFYPrA3BMNWgR08JCBFHnwcyUDYFATs1rjXn2
         yL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IViYxUVtxhmy+DhoYbq41mJ5frzvzah03nv9ueXSwIM=;
        b=Pl2rlXGx1R4FRvyMOPZgty6xQNtVwT1Pw8FnaBuoWpCkzxMaKCffm236ejGxGtahY9
         OTCqc/u0NTsM5+zv+0lYI1cMe/LjGICiNaC54UmyxNHST6XzcZdT69TjjYqfj41LLsfJ
         I0RHW2yp0JYibaQr4XQxO5e2sNcvkSmxZMq/N2PS71pJ+HZIGO8i/93xwKe+tl1jkcvB
         +49DzwMGYC4yrxBiQeJ6pm+rH3p2FNkcXST7KmzQVp2dVzIhVLYSGMFo3TaEHbj5Cye+
         WvZuuwK/tWugrhduHvU4FoYuSjSFzb0poohYWVj4RyjE+dR8B2ede29spco14ps4Qz+g
         tbqA==
X-Gm-Message-State: APjAAAUK0AMD0sLQZtBE0pF3gcq+DYAYLDZiJdCf98Wwo5pj+ESiqzTj
        6jSMtCShHLDHWNMTYCzq+BhCc8D7i4l4VZ7HXY4GOw==
X-Google-Smtp-Source: APXvYqz6KzhzKX65oJt06EFCN7iEWegIfKRRv5k7uFFbbaYlDeM5+NLKuOtf+MEbqH6/PWvxcsi1B/JW7yfDPu2sQEk=
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr7603624lfl.125.1576226259104;
 Fri, 13 Dec 2019 00:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20191213024530.28052-1-cj.chengjian@huawei.com>
In-Reply-To: <20191213024530.28052-1-cj.chengjian@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Dec 2019 09:37:27 +0100
Message-ID: <CAKfTPtCQCQio=D3nRTRgbhthKWo752OeaM2X4UcNwr2jByvoNg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Optimize select_idle_cpu
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chenwandun@huawei.com, Xie XiuQi <xiexiuqi@huawei.com>,
        liwei391@huawei.com, huawei.libin@huawei.com,
        bobo.shaobowang@huawei.com, Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 at 03:48, Cheng Jian <cj.chengjian@huawei.com> wrote:
>
> select_idle_cpu() will scan the LLC domain for idle CPUs,
> it's always expensive. so the next commit :
>
>         1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")
>
> introduces a way to limit how many CPUs we scan.
>
> But it consume some CPUs out of 'nr' that are not allowed
> for the task and thus waste our attempts. The function
> always return nr_cpumask_bits, and we can't find a CPU
> which our task is allowed to run.
>
> Cpumask may be too big, similar to select_idle_core(), use
> per_cpu_ptr 'select_idle_mask' to prevent stack overflow.
>
> Fixes: 1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..d48244388ce9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5828,6 +5828,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
>   */
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
>  {
> +       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>         struct sched_domain *this_sd;
>         u64 avg_cost, avg_idle;
>         u64 time, cost;
> @@ -5859,11 +5860,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>
>         time = cpu_clock(this);
>
> -       for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
> +       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +
> +       for_each_cpu_wrap(cpu, cpus, target) {
>                 if (!--nr)
>                         return si_cpu;
> -               if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> -                       continue;
>                 if (available_idle_cpu(cpu))
>                         break;
>                 if (si_cpu == -1 && sched_idle_cpu(cpu))
> --
> 2.20.1
>
