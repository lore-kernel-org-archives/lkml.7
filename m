Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86D6CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C69F2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dh4TGDJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfJaPsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:48:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39740 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfJaPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:48:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so7167694ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=260kgN6VgY6Es3AEFNd7jvs6pF/ZLC/U45J3qC3o/uw=;
        b=dh4TGDJtErpngjh3cftUdxn1H6gwpzif+48xDGcGO4LGaRGJoBtzVgEcC3ZzOSoMyj
         wIr5lM3nHRu7jgj0Rs1AXUp0t/k1QyqRfNdj58AMOdb99NjWhInTJjqFyucZedX82W5X
         L9nJBqgwgnKbOtcZpIw56vM+UUn4IFHVOf5KBlNRwVu1yxiG4yS7CjaKQOXkHK7P+B2U
         gOOIl6j5sCAquS/lgAbmeMVIFdxUJ4sngLAhLfTIVmmVHYSIXHZeO2riREnuMRq0rqnS
         ZkKYsCDhCfUiNWCtmhjmleoZG7d0OhRLKz80orPetY+RBKT80asOHnzT3TRJ7f6HjLi4
         7VQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=260kgN6VgY6Es3AEFNd7jvs6pF/ZLC/U45J3qC3o/uw=;
        b=jjBUCF3/WZZTvavwvoLZjxRb74O2mBh89qTbIeMtx2u8X5A2h1P5r26jbZOdvcENne
         k2vDzZNTTBLLKrgC+YHhiAVytRQsi7TenKiuzIkI5nz1YitvWXPIle0PJsNnVy3Sn7P2
         DRFXueR052p2aUYVn8m/ZmmsfmvM4c6lewwPLfc/iu08T+VpgIm6eAkYztatBqZf8YYf
         pjaFnOtnwTJ/TvxDcJvZ6fBsbrwjuBw8X2Tm0v47efOukTNs1HzZv5LffPLdfbmkhtDy
         q2+TGW8DyWXipdldQTc+XAWcFQWmG1DhyJx6rRYp0cZc0YTslzs3F0TfvZaO03Iubm2h
         2j8Q==
X-Gm-Message-State: APjAAAUTTWcKHs+pVNSTWgoUKC1i2Rpv0gIQHG8KC/uIpeuhblotEsKE
        IXpV187x9q9unAELq5UOu5Xh8y95Fx70n41ADm6E1w==
X-Google-Smtp-Source: APXvYqwIOpjm1wQOSMhsTm0PkFDqCRdtOX91pbAmii64wZS/ela7esFj6jNlYxPS4Agba6LwPHYe1NblM09lKPWOHkA=
X-Received: by 2002:a2e:a16d:: with SMTP id u13mr4890381ljl.214.1572536926284;
 Thu, 31 Oct 2019 08:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-5-git-send-email-thara.gopinath@linaro.org>
 <20191023122252.dz7obopab6iizy4s@e107158-lin.cambridge.arm.com>
 <20191028153010.GE4097@hirez.programming.kicks-ass.net> <20191031105342.b3sl5xhysldfla3g@e107158-lin.cambridge.arm.com>
 <e875ef90-d561-4eee-4951-6556ac89c6a2@arm.com>
In-Reply-To: <e875ef90-d561-4eee-4951-6556ac89c6a2@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 31 Oct 2019 16:48:34 +0100
Message-ID: <CAKfTPtCTYOBQ+TUYaGsEGK-UTQ=2of=1WYeeiMzak7ZhEPRxmA@mail.gmail.com>
Subject: Re: [Patch v4 4/6] sched/fair: update cpu_capcity to reflect thermal pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Thu, 31 Oct 2019 at 16:38, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 31.10.19 11:53, Qais Yousef wrote:
> > On 10/28/19 16:30, Peter Zijlstra wrote:
> >> On Wed, Oct 23, 2019 at 01:28:40PM +0100, Qais Yousef wrote:
> >>> On 10/22/19 16:34, Thara Gopinath wrote:
> >>>> cpu_capacity relflects the maximum available capacity of a cpu. Thermal
> >>>> pressure on a cpu means this maximum available capacity is reduced. This
> >>>> patch reduces the average thermal pressure for a cpu from its maximum
> >>>> available capacity so that cpu_capacity reflects the actual
> >>>> available capacity.
> >>>>
> >>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> >>>> ---
> >>>>  kernel/sched/fair.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>> index 4f9c2cb..be3e802 100644
> >>>> --- a/kernel/sched/fair.c
> >>>> +++ b/kernel/sched/fair.c
> >>>> @@ -7727,6 +7727,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
> >>>>
> >>>>    used = READ_ONCE(rq->avg_rt.util_avg);
> >>>>    used += READ_ONCE(rq->avg_dl.util_avg);
> >>>> +  used += READ_ONCE(rq->avg_thermal.load_avg);
> >>>
> >>> Maybe a naive question - but can we add util_avg with load_avg without
> >>> a conversion? I thought the 2 signals have different properties.
> >>
> >> Changelog of patch #1 explains, it's in that dense blob of text.
> >>
> >> But yes, you're quite right that that wants a comment here.
> >
> > Thanks for the pointer! A comment would be nice indeed.
> >
> > To make sure I got this correctly - it's because avg_thermal.load_avg
> > represents delta_capacity which is already a 'converted' form of load. So this
> > makes avg_thermal.load_avg a util_avg really. Correct?
> >
> > If I managed to get it right somehow. It'd be nice if we can do inverse
> > conversion on delta_capacity so that avg_thermal.{load_avg, util_avg} meaning
> > is consistent across the board. But I don't feel strongly about it if this gets
> > documented properly.
>
> So why can't we use rq->avg_thermal.util_avg here? Since capacity is
> closer to util than to load?
>
> Is it because you want to use the influence of ___update_load_sum(...,
> unsigned long load eq. per-cpu delta_capacity in your signal?
>
> Why not call it this way then?

util_avg tracks a binary state with 2 fixed weights: running(1024)  vs
not running (0)
In the case of thermal pressure, we want to track how much pressure is
put on the CPU: capping to half the max frequency is not the same as
capping only 10%
load_avg is not boolean but you set the weight  you want to apply and
this weight reflects the amount of pressure.

>
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 38210691c615..d3035457483f 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -357,9 +357,9 @@ int update_thermal_load_avg(u64 now, struct rq *rq,
> u64 capacity)
>  {
>         if (___update_load_sum(now, &rq->avg_thermal,
>                                capacity,
> -                              capacity,
> -                              capacity)) {
> -               ___update_load_avg(&rq->avg_thermal, 1, 1);
> +                              0,
> +                              0)) {
> +               ___update_load_avg(&rq->avg_thermal, 1, 0);
>                 return 1;
>         }
