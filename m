Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF5BC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DE92464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWR2xPu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfLESwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:52:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36554 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfLESwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:52:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so4826510ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 10:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ht7dtWEHK8ylixaAnLm+mdZJE6X6uVaXMa+UHe6XCr4=;
        b=cWR2xPu+hGM3ED5V3ye8FC6l8nisRhrh2GK/cve5h7bGUeMJVu+084AHDVkAZojIgH
         OTLpU8JzrbH/G2TghRvhHo/83RlVws12VI3y0F4UZpJqcbDn48fXYVW2FzdQj7R7oqO3
         pVsUUsp/VNVA5XljlfHAwsiApgbuEQKLYNPEdA23imaRGaY7esbR/qFxg4K/+3mAXSl2
         c7PMuIxbvSKZyTIXSkooo7ct3/CqrfaHwYh3B1DVIYe1s/i8GrY+tD1IzViNgl7gzJ2n
         TNYWfAaYqJAt0hBwhjZz/d1xSPVYdeQHfmI9yMd8axyZOCCP3GIediZpNMK2ab2TUYNq
         HSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ht7dtWEHK8ylixaAnLm+mdZJE6X6uVaXMa+UHe6XCr4=;
        b=KdJ9FVdKhzxKbO3bpz7KXPWCY09is7x0Ishm0Kwy76spDEOojNh7kDSmWoD++We29k
         U45NHIFtUpTw8vSi5KQFtT+UBEO1WQAMcKrvUm/aW6WJa7K7dsBL2KLCsnodilddR0yZ
         KzcxnEUrlhUP3XpCcElnv3eSOgd8WYKoLOOnEvcZplUnebcXB62VLUk/ecca6DUgPEwT
         K3S0fphiMfvHGtl0+KJ2uxelePSE0BsPGj0irDCZamtkBPqKLjHZ8nmlwJGAbpN9xsgn
         EMFrv87CPj41TxUuDyxnrwA0e+Sy09vZ7l3riBZ/78E42Fs6Wx7Mvl3Bv9QWD4TsHssU
         9fzA==
X-Gm-Message-State: APjAAAUvsuPz7jsbKS7hLU69a5LsmbjQN5J/lWvDqQfRP/ct/eATsMj3
        u6beVaLREiVGh5hXuAfAlK8oh9ydWoR+l+TvrIJaag==
X-Google-Smtp-Source: APXvYqzas+51ScnmoogtvquXvx9rC4DtZ8c+60WU0s/ymf0gGxLDk3FNQAGiVStpHqKGL1uzFQdse1cZad6yHJTt/hg=
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr6170120ljj.206.1575571972456;
 Thu, 05 Dec 2019 10:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20191205172316.8198-1-srikar@linux.vnet.ibm.com>
 <CAKfTPtBH9ff=efTeJbM4UdzrHCXZs7wwn=pdE4As8pB859e++Q@mail.gmail.com> <20191205175153.GA14172@linux.vnet.ibm.com>
In-Reply-To: <20191205175153.GA14172@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 Dec 2019 19:52:40 +0100
Message-ID: <CAKfTPtDp097ww0war7H1THtRxDWzA3CDuokDQSUoqzRDcD1d3g@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Optimize select_idle_core
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019 at 18:52, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [2019-12-05 18:27:51]:
>
> > Hi Srikar,
> >
> > On Thu, 5 Dec 2019 at 18:23, Srikar Dronamraju
> > <srikar@linux.vnet.ibm.com> wrote:
> > >
> > > Currently we loop through all threads of a core to evaluate if the core
> > > is idle or not. This is unnecessary. If a thread of a core is not
> > > idle, skip evaluating other threads of a core.
> >
> > I think that the goal is also to clear all CPUs of the core from the
> > cpumask  of the loop above so it will not try the same core next time
> >
> > >
>
> That goal we still continue to maintain by the way of cpumask_andnot.
> i.e instead of clearing CPUs one at a time, we clear all the CPUs in the
> core at one shot.

ah yes sorry, I have been to quick and overlooked the cpumask_andnot line

>
> > > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > > ---
> > >  kernel/sched/fair.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 69a81a5709ff..b9d628128cfc 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -5872,10 +5872,12 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
> > >                 bool idle = true;
> > >
> > >                 for_each_cpu(cpu, cpu_smt_mask(core)) {
> > > -                       __cpumask_clear_cpu(cpu, cpus);
> > > -                       if (!available_idle_cpu(cpu))
> > > +                       if (!available_idle_cpu(cpu)) {
> > >                                 idle = false;
> > > +                               break;
> > > +                       }
> > >                 }
> > > +               cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> > >
> > >                 if (idle)
> > >                         return core;
> > > --
> > > 2.18.1
> > >
>
> --
> Thanks and Regards
> Srikar Dronamraju
>
