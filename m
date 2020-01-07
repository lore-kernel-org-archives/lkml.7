Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8613FC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54065206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QI0EPnZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgAGIoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:44:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43154 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgAGIoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:44:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so53820964ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 00:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCHTLlvSSFUfmz+CkuEE+w2aqN9hLb1R9/51NebftNY=;
        b=QI0EPnZSXZ0Fjqfn7lDbNP3A6Xp3IxHa848tS4/Pq3C6ER+Il/zU93St0jmV+MjG7e
         m1Pz5iIGkWELOwQjmhEd8y6zaWQxX9n90zTiv2hhDUqdIQ6T7QDu6X+Bs/bVTbWms6N/
         kLsaGsVIeiWC3YqEXt41Bc6SgbZdNJUiLaW0l4pBn0QQ74EihwG8QLazikqhx65+GJOQ
         bs7WpqhJ+9D1SwX8UXOMdSttWU0cLKS3wchLa2fTZOcEc1Q5FNfANZzEzx5FYLFlqCFc
         hemw5jWmN+06OpT2mE7t6qYGJP6B2hzAWwBqchXGddcKC2x0v/9rPuUQt+n7NP5X586n
         9Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCHTLlvSSFUfmz+CkuEE+w2aqN9hLb1R9/51NebftNY=;
        b=BvBaEKkZASRzC+ne/zX1jibqvvV300cSBIuxP8zzK76LSrMyaKdgJ1VZca5mzts12W
         lbdaYWw4/fY24OErm5xqMV2OgEPX6HdwGRNnYo8ELdpiLFFTugSIeDQmovJdUL6YhY2y
         8Pa+0z8OyTYIAjT496KeekMOa/Uak7iTVVJZ7vqEnmpGFoSyLT0shwTOtD0snAQlXxEZ
         PNXe4kE2NzywxNrU4yDRKzRh6tMUowi4fFPsjJNHoGX74nh6y6ONjEflMnckxBfrw15z
         ++nj5ffKMVoftmDzmnZl8eyV+ohNgsSibjhRJAYjzQypneQonOSyFY7rcZsEVBjSM1P2
         yF/Q==
X-Gm-Message-State: APjAAAU02CvoUVhWO/vcFLLw8YsDW7FaYn7IJppZ8G78QJ+qVey1fOYk
        5ferNKCcPWy6TYmvF1l42vSXIR5xJNaMOeQORKjv0Q==
X-Google-Smtp-Source: APXvYqzt5goxNpfW6G31u52Tc1LhR+nBg2ru10rb0GisOUvdNyLI4/A3uSks6cIkcTeAm5RoSSIEwkFZJeR7T3DHMyo=
X-Received: by 2002:a2e:9b03:: with SMTP id u3mr52699558lji.87.1578386674763;
 Tue, 07 Jan 2020 00:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20200106144250.GA3466@techsingularity.net> <04033a63f11a9c59ebd2b099355915e4e889b772.camel@surriel.com>
 <20200106163303.GC3466@techsingularity.net> <20200107015111.4836-1-hdanton@sina.com>
In-Reply-To: <20200107015111.4836-1-hdanton@sina.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Jan 2020 09:44:23 +0100
Message-ID: <CAKfTPtB_9uf+f8ZWFW-=-orS3KGKDGPwY3YrPSFn54z0C=7o6g@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v3
To:     Hillf Danton <hdanton@sina.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Parth Shah <parth@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 at 02:51, Hillf Danton <hdanton@sina.com> wrote:
>
>
> Hi Folks
>
> On Mon, 06 Jan 2020 11:44:57 -0500 Rik van Riel wrote:
> > On Mon, 2020-01-06 at 16:33 +0000, Mel Gorman wrote:
> > > On Mon, Jan 06, 2020 at 10:47:18AM -0500, Rik van Riel wrote:
> > > > > +                       imbalance_adj = (100 / (env->sd->imbalance_pct - 100)) - 1;
> > > > > +
> > > > > +                       /*
> > > > > +                        * Allow small imbalances when the busiest group has
> > > > > +                        * low utilisation.
> > > > > +                        */
> > > > > +                       imbalance_max = imbalance_adj << 1;
> > > > > +                       if (busiest->sum_nr_running < imbalance_max)
> > > > > +                               env->imbalance -= min(env->imbalance, imbalance_adj);
> > > > > +               }
> > > > > +
> > > >
> > > > Wait, so imbalance_max is a function only of
> > > > env->sd->imbalance_pct, and it gets compared
> > > > against busiest->sum_nr_running, which is related
> > > > to the number of CPUs in the node?
> > > >
> > >
> > > It's not directly related to the number of CPUs in the node. Are you
> > > thinking of busiest->group_weight?
> >
> > I am, because as it is right now that if condition
> > looks like it might never be true for imbalance_pct 115.
> >
> > Presumably you put that check there for a reason, and
> > would like it to trigger when the amount by which a node
> > is busy is less than 2 * (imbalance_pct - 100).
>
>
> If three per cent can make any sense in helping determine utilisation
> low then the busy load has to meet
>
>         busiest->sum_nr_running < max(3, cpus in the node / 32);

I agree that we should take into account the size or the utilization
of the node in some way

>
> And we can't skip pulling tasks from a numa node without comparing it
> to the local load
>
>         local->sum_nr_running * env->sd->imbalance_pct <
>         busiest->sum_nr_running * 100;

A similar test has already been done in fbg and we call calculate
imbalance only if busiest is busier than local

>
> with imbalance_pct taken into account.
>
> Hillf
>
