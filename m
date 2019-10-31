Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5079CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2D620659
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOt/U4mM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfJaQbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:31:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41453 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJaQbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:31:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id j14so5183835lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJy+/1CBSTIBM4kMR9zV2cJD7nIKgEp9xFX8JUKFW2E=;
        b=jOt/U4mMtKIUnd6iQExm2RnkfdpqCGqZsZ1DNnTOaUulO7dtPJ2YzxmzhKa+O+TCGn
         00RC+P7bmfZ3WE65lTa8ej6+/5Jle55joSu8YwvzLEkjqhHErp6ELt48+Ne5gIau8wJO
         xPO+oHZsISV1M6oOSrc/2xRxCloRQEtAuOhPTAdkOrdv3QbVGO2CFcX37aPQGoos/wFY
         zGFj07ivqUJErado0/trG6eyVHsDPWPRMRnaeOC7JyzegJjl1CkST4UV2Wm7zNmrvBL1
         AYeciSD2W2g3Ho68LJdYqlvXSuCZ5PeNEVpeQRirVQavIc+i+i29CvuNWxLWpKlImZcx
         Ogng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJy+/1CBSTIBM4kMR9zV2cJD7nIKgEp9xFX8JUKFW2E=;
        b=Mkh7GWlpc7EmI+EfDbOFfUBVPlrrtxa8OK6y4C/rutxp43OoZzVgmd2JQxzOkJcVGG
         p36Q8F7Il5Nh0yYk7D807024B9xdtul03dkEu/O4rp24awGTIMJd2bNg9wXuqtaDPhkU
         Nwdln34AwE4vSQemMBGtqGEVPNyVsRBzyCzhDt/SuKVrZkgrJ8ujNFk6MosHTq7Zwenb
         8NpZjQnJaK8gwMRJwFNrlAsmz6HY0A+WfZQECkstUNqfi6LMj+EnWL5JuSk3fUBmvjt9
         jZZ9Q79TPmLmbqEneF0/NMldDOdH3rPUlb/8/2xZtCJfEuLySn6VfrXc6cshsadhoHOe
         KubQ==
X-Gm-Message-State: APjAAAUey9bhrenJ3Y3TTJ7/v84R+rp6C20fEqiCLL0Dslh88MqrvDCu
        xJFPChKzy+gXcxDJpoEwl9Fe3stLef+LCrbPyhAUlA==
X-Google-Smtp-Source: APXvYqw8mOlWJ/N/hmIRPZrWSFfby917eKiZ41AwHu273ooh2iE0nJZSOupFUJHV/DFSo7bPrYDUKRRrlXIJSIvFE3w=
X-Received: by 2002:a19:800a:: with SMTP id b10mr4231686lfd.15.1572539511165;
 Thu, 31 Oct 2019 09:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-5-git-send-email-thara.gopinath@linaro.org>
 <20191023122252.dz7obopab6iizy4s@e107158-lin.cambridge.arm.com>
 <20191028153010.GE4097@hirez.programming.kicks-ass.net> <20191031105342.b3sl5xhysldfla3g@e107158-lin.cambridge.arm.com>
 <e875ef90-d561-4eee-4951-6556ac89c6a2@arm.com> <CAKfTPtCTYOBQ+TUYaGsEGK-UTQ=2of=1WYeeiMzak7ZhEPRxmA@mail.gmail.com>
 <e38e9c86-7433-7c4b-d9c1-38fd2458b953@arm.com>
In-Reply-To: <e38e9c86-7433-7c4b-d9c1-38fd2458b953@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 31 Oct 2019 17:31:39 +0100
Message-ID: <CAKfTPtCQe8qd1e5s-jf_5C7eaGVc7OYcXYgdvBK+ACF8aL7ByQ@mail.gmail.com>
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

On Thu, 31 Oct 2019 at 17:17, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 31.10.19 16:48, Vincent Guittot wrote:
> > On Thu, 31 Oct 2019 at 16:38, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 31.10.19 11:53, Qais Yousef wrote:
> >>> On 10/28/19 16:30, Peter Zijlstra wrote:
> >>>> On Wed, Oct 23, 2019 at 01:28:40PM +0100, Qais Yousef wrote:
> >>>>> On 10/22/19 16:34, Thara Gopinath wrote:
>
> [...]
>
> >>> To make sure I got this correctly - it's because avg_thermal.load_avg
> >>> represents delta_capacity which is already a 'converted' form of load. So this
> >>> makes avg_thermal.load_avg a util_avg really. Correct?
> >>>
> >>> If I managed to get it right somehow. It'd be nice if we can do inverse
> >>> conversion on delta_capacity so that avg_thermal.{load_avg, util_avg} meaning
> >>> is consistent across the board. But I don't feel strongly about it if this gets
> >>> documented properly.
> >>
> >> So why can't we use rq->avg_thermal.util_avg here? Since capacity is
> >> closer to util than to load?
> >>
> >> Is it because you want to use the influence of ___update_load_sum(...,
> >> unsigned long load eq. per-cpu delta_capacity in your signal?
> >>
> >> Why not call it this way then?
> >
> > util_avg tracks a binary state with 2 fixed weights: running(1024)  vs
> > not running (0)
> > In the case of thermal pressure, we want to track how much pressure is
> > put on the CPU: capping to half the max frequency is not the same as
> > capping only 10%
> > load_avg is not boolean but you set the weight  you want to apply and
> > this weight reflects the amount of pressure.
>
> I see. This is what I meant by 'load (weight) eq. per-cpu delta_capacity
> (pressure)'.
>
>
> >> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> >> index 38210691c615..d3035457483f 100644
> >> --- a/kernel/sched/pelt.c
> >> +++ b/kernel/sched/pelt.c
> >> @@ -357,9 +357,9 @@ int update_thermal_load_avg(u64 now, struct rq *rq,
> >> u64 capacity)
> >>  {
> >>         if (___update_load_sum(now, &rq->avg_thermal,
> >>                                capacity,
> >> -                              capacity,
> >> -                              capacity)) {
> >> -               ___update_load_avg(&rq->avg_thermal, 1, 1);
> >> +                              0,
> >> +                              0)) {
> >> +               ___update_load_avg(&rq->avg_thermal, 1, 0);
> >>                 return 1;
> >>         }
>
> So we could call it this way since we don't care about runnable_load or
> util?

one way or the other is quite similar but the current solution is
aligned with other irq, rt, dl signals which duplicates the same state
in each fields
