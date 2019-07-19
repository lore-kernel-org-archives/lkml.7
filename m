Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175B8C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5FA20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kIsVLGRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfGSNzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:55:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40961 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:55:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so30872362ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfKjdd4jfIoTccghK7pWcsEpU2/Nd09MjPTNSJWRhB4=;
        b=kIsVLGRdoX6IH7ccke2IbWoecVugltuE7jUmLF8RRhgzZ28SH4/BGfTE9bqu8rqJlz
         GyfKbp+EjiR26HR2eURgrps6Th/tRkO2fjhREWD72L9gtQr3GIm2VuAZvenNONarSq/2
         tpsrtcOaiAsY8aF6pfR7DWSEMdqUUh4vRahYbn8eoLk6pS9X0nFRxyqVUZL0Za+WsLP/
         ZW79EAI64bCEZyRGnogucN+fp/8fMCkVCcCN0DO92d/RMyiswfOYztIM7OYQanYkWP/Q
         gqDZ/wJwupLSlwDYObasiov5wagm7MEp8/4VXR6df85/BtvaG5hJZL/41StI7kiZ+gN0
         W4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfKjdd4jfIoTccghK7pWcsEpU2/Nd09MjPTNSJWRhB4=;
        b=Ah1L02Q7EesgEACyu+DB1TUc8ijibbRZIjGvgYTvmYssO6080/j9+S7LN+AzOZ/XIH
         zrSfr4FACL/Q1bOohCGsNa5voIASMwe3nDMygyPV/wE2QwE4nMev+hQSAmNoVFbm6gge
         DpUs8pamcKWRM60QdtwsJXY7eaavNU5Gg9zAJSYMgxf+RxGS7vzB39xI3Wut/NlEBe1J
         3qevIf8vwI7u+gxNsOWVy8CQGRtH41QBGNrufJzjO5bjSGzEDPqCeGnrRcQggzYDoUZg
         U0XFIsCXfpj1GnfebDXfkp1lKC3r+IAPa/kmAV3fk+EisGzzZUXo5OtUpL6QpZHKWlaa
         aKmw==
X-Gm-Message-State: APjAAAVEd7GHQtS6c2x0bkoscCbYNoj9ZxjbJDfUZJI9MYBZHVYioH7S
        uRiXLlqKd94kW/PsHMwXNjQJDuFhZs/CsQe7vLdHTQ==
X-Google-Smtp-Source: APXvYqy+g3dfp+7Nz5gMS40s2QLg/L8mkmq3Cz6sOZNz3H0fWW77/0IlWR32qgYxqo+nXRaoiibNtXDbjaXt8KfSDQE=
X-Received: by 2002:a2e:1290:: with SMTP id 16mr26757782ljs.88.1563544522265;
 Fri, 19 Jul 2019 06:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org> <20190719132207.GM3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190719132207.GM3419@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 19 Jul 2019 15:55:11 +0200
Message-ID: <CAKfTPtCsYeX5ej-o1WL2kpO2MjLyCJis0kwFq7cgjHEiBYQPog@mail.gmail.com>
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

On Fri, 19 Jul 2019 at 15:22, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 19, 2019 at 09:58:23AM +0200, Vincent Guittot wrote:
> >  enum group_type {
> > -     group_other = 0,
> > +     group_has_spare = 0,
> > +     group_fully_busy,
> >       group_misfit_task,
> > +     group_asym_capacity,
> >       group_imbalanced,
> >       group_overloaded,
> >  };
>
> The order of this group_type is important, maybe add a few words on how
> this order got to be.

Yes, I will
>
> >  static inline enum
> > -group_type group_classify(struct sched_group *group,
> > +group_type group_classify(struct lb_env *env,
> > +                       struct sched_group *group,
> >                         struct sg_lb_stats *sgs)
> >  {
> > -     if (sgs->group_no_capacity)
> > +     if (group_is_overloaded(env, sgs))
> >               return group_overloaded;
> >
> >       if (sg_imbalanced(group))
> > @@ -7953,7 +7975,13 @@ group_type group_classify(struct sched_group *group,
> >       if (sgs->group_misfit_task_load)
> >               return group_misfit_task;
> >
> > -     return group_other;
> > +     if (sgs->group_asym_capacity)
> > +             return group_asym_capacity;
> > +
> > +     if (group_has_capacity(env, sgs))
> > +             return group_has_spare;
> > +
> > +     return group_fully_busy;
> >  }
>
> OCD is annoyed that this function doesn't have the same / reverse order
> of the one in the enum.

I will reorder them

>
> > @@ -8070,7 +8111,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >        */
> >       if (sgs->group_type == group_misfit_task &&
> >           (!group_smaller_max_cpu_capacity(sg, sds->local) ||
> > -          !group_has_capacity(env, &sds->local_stat)))
> > +          sds->local_stat.group_type != group_has_spare))
> >               return false;
> >
> >       if (sgs->group_type > busiest->group_type)
> > @@ -8079,11 +8120,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >       if (sgs->group_type < busiest->group_type)
> >               return false;
>
> from reading the patch it wasn't obvious that at this point

I will add a comment to mention this

> sgs->group_type == busiest->group_type, and I wondered if
> busiest->avg_load below was pointing to garbage, it isn't.
>
> > -     if (sgs->avg_load <= busiest->avg_load)
> > +     /* Select the overloaded group with highest avg_load */
> > +     if (sgs->group_type == group_overloaded &&
> > +         sgs->avg_load <= busiest->avg_load)
> > +             return false;
> > +
> > +     /* Prefer to move from lowest priority CPU's work */
> > +     if (sgs->group_type == group_asym_capacity && sds->busiest &&
> > +         sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
> >               return false;
> >
> >       if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
> > -             goto asym_packing;
> > +             goto spare_capacity;
> >
> >       /*
> >        * Candidate sg has no more than one task per CPU and
>
> Can we do a switch (sds->group_type) here? it seems to have most of them
> listed.

I will have a look but I'm afraid that the
 if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
prevents us to get something readbale
