Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC18CC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CF420873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8wgj9tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfGSN5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:57:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40286 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfGSN5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:57:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so21827633lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8/nNzFy+4g3/Uw/Y2Voc/T0lsK6bGKc+PCOCJ2I7Y4=;
        b=J8wgj9ttpXs+AH/fGsPsJPEMU8BH+So6r+U0gv5OVLJdnH3r0N4oe5ZWdoDiSiDKxQ
         T/Y2BXHohLFh0Aryv5VG+h6UyqwHzOsAWTTAH91rnrFCj5sun2CDYCTkXCIHkZ2jM+zB
         XvvAOnlbd8eT86dcrdTmgEnkRA3Q3CAVRBSeNsM4xFZop6eZ64emAf4qLfMsJ+gza7SE
         i8ZxsMPUadDu5wQEXIEhvMbvfrCs9HBFJUU6ZECw0iZjoDLW7atI1G86eSuXfFtX4w9l
         HeeZzjUXEzy71lDm2UwSTcrk/u6EMxfGaXigfc6akiOXjvdA8tlgUAX+sY3nhlzHcmq4
         zlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8/nNzFy+4g3/Uw/Y2Voc/T0lsK6bGKc+PCOCJ2I7Y4=;
        b=RVtIQMGrxEZZYDRKo4WnKDJFO5WjsCCajdTzF/UUx0zSIA48l3BA/97oDYdssYnhMe
         vi4SgfB40cumNVzJy5E9C81IzdgZOHuRzSdRhmdJDVOA2juFtxOR7ZCewyF48iqT0vvX
         6tkP0wjJraRjDG43QiDRT/uGZlP573CzHh24fWY4+u5ymNBELVFAEthrpyR5aRksW9FL
         Clanjat2xcN8hmzjVYj6NJvLuxYLPwoj+jrmKEI8Eq7IX2VvjbUMxrGv8NaGlp6PoHKu
         q3x1bg0qjDx6AC8/1AKdM6tKAGqzHzQAoTgF8i9kxxaHvraV2Vsi+X0UOIQy8HHviiPd
         9sxA==
X-Gm-Message-State: APjAAAX1c75ERlErrpJjutcX58XD/+lXaB+sQU5MnAo+eRhN71cTOz6q
        aKbAqyllvpZfefhIlx69KotuwQU1N5Ju4WjxGJLNXw==
X-Google-Smtp-Source: APXvYqwh92PfyUj9e2wsjweo019JcreSc9x0X4EUTC/HgNYRXYfMyu7s2D5UokeMAs8TvZufeMrsDroo/XHLF+KiO3o=
X-Received: by 2002:a19:f603:: with SMTP id x3mr21592635lfe.125.1563544639020;
 Fri, 19 Jul 2019 06:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org> <20190719130624.GK3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190719130624.GK3419@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 19 Jul 2019 15:57:08 +0200
Message-ID: <CAKfTPtDzeGG-k6i6d0MBwqV9aBH80FxCXHrqu3LzPaa4-rD6hA@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Phil Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019 at 15:06, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 19, 2019 at 09:58:23AM +0200, Vincent Guittot wrote:
> > @@ -7887,7 +7908,7 @@ static inline int sg_imbalanced(struct sched_group *group)
> >  static inline bool
> >  group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
> >  {
> > -     if (sgs->sum_h_nr_running < sgs->group_weight)
> > +     if (sgs->sum_nr_running < sgs->group_weight)
> >               return true;
> >
> >       if ((sgs->group_capacity * 100) >
> > @@ -7908,7 +7929,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
> >  static inline bool
> >  group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
> >  {
> > -     if (sgs->sum_h_nr_running <= sgs->group_weight)
> > +     if (sgs->sum_nr_running <= sgs->group_weight)
> >               return false;
> >
> >       if ((sgs->group_capacity * 100) <
>
> I suspect this is a change you can pull out into a separate patch after
> the big change. Yes it makes sense to account the other class' task
> presence, but I don't think it is strictly required to be in this patch.

yes
