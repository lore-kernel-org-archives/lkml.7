Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A042DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658C120863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VR9ImPtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfCRQ64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:58:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41600 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfCRQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:58:56 -0400
Received: by mail-io1-f65.google.com with SMTP id v10so15117363iom.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCSjK1Dk6w+M0CcBcRsq6gEkd5BO241ZrrOfpC+KdRY=;
        b=VR9ImPtulW6zwmUf9/D6bnIdxIGodimz2bexHQr69a+ciZHtn5XIi0Xe/ACSGJyobd
         xOUPiClkN5egBUwB+FYz5nrCRo965NapsF8E8CU91bV2lZJU/8jnVhUAO3k/PLBESQo9
         lyl5HV9rUZceWgR1q4UEuHLgDGZbpL27k2DjxC13T4biRnfl9ejxAvSRajYeuWZhGPRP
         Dj0Dq9hyuYOqjOhHpafPRndtUlQTK102LjEJBmYB7EcvVod3LoUiwwPlKkbNJw//ecP5
         i2nGeKG9uTt7CslR6FUDNUWIy4MlkUlBIda/CO2rGtfrcR1sPnssVVHjdNm4P9/N36qv
         gVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCSjK1Dk6w+M0CcBcRsq6gEkd5BO241ZrrOfpC+KdRY=;
        b=DnR93gFR4u6Oy+zxpbmn7YKgx371AqpvT+EEJtCj0EjyXOwCO+PUs+cG37VoTzH2Cv
         vCJWAMyOZBRSfK8FznQKWCJNc5+J9tjDkgebFwxN+cAPaskyccx74yW9VvI8IyQTjDyT
         72yCG2BkUC9OsMyUA4LtPNFwNUEGveHEKGXWYgRGVuogyB8/HbX7TMhG0Tz+zbIIG53r
         EupldohJ/cB95vZgLVH3Ydr8knFROlD9OTpnhiqJmYHYo7GuAbfTjORFxGWGe3L+05wB
         jzvgYmJTDPXWjw+lkAi5gbEdPmjWdAUX0Fxro2+ddJEddGf1p4Gkh2X/WtzPx8xd8Fl3
         HpGg==
X-Gm-Message-State: APjAAAUm4ZGXdSp/E6P0N2761aPzziSyMapsfz8DNoeGo45Rd3Udx6Re
        6FVrQKkyP0PnY0Wtn/cYORHMFfJNnXdAyQ1YauvMKrCr
X-Google-Smtp-Source: APXvYqyBpZ1FELE5MwhkHA2Um9ziXNOC4M1bh/jrWbFTLYPqqyp2XC6GFTg/+OvXOpnFXJ3EEKPi7AodVDVsdVk2Xao=
X-Received: by 2002:a5d:968a:: with SMTP id m10mr7483612ion.134.1552928334657;
 Mon, 18 Mar 2019 09:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-13-patrick.bellasi@arm.com> <CAJuCfpHTtokPFHu3KHYGj9arbPYn6ZZ=-qNpmVPrDwhPvnA9Ow@mail.gmail.com>
 <20190318165430.n222vuq4tv3ntbod@e110439-lin>
In-Reply-To: <20190318165430.n222vuq4tv3ntbod@e110439-lin>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 18 Mar 2019 09:58:43 -0700
Message-ID: <CAJuCfpGzisorEyJ4kyhGGjfPVVDt9KA++2MwHez0MXrnycRHcQ@mail.gmail.com>
Subject: Re: [PATCH v7 12/15] sched/core: uclamp: Propagate parent clamps
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 9:54 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 14-Mar 09:17, Suren Baghdasaryan wrote:
> > On Fri, Feb 8, 2019 at 2:06 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > >
> > > In order to properly support hierarchical resources control, the cgroup
> > > delegation model requires that attribute writes from a child group never
> > > fail but still are (potentially) constrained based on parent's assigned
> > > resources. This requires to properly propagate and aggregate parent
> > > attributes down to its descendants.
> > >
> > > Let's implement this mechanism by adding a new "effective" clamp value
> > > for each task group. The effective clamp value is defined as the smaller
> > > value between the clamp value of a group and the effective clamp value
> > > of its parent. This is the actual clamp value enforced on tasks in a
> > > task group.
> >
> > In patch 10 in this series you mentioned "b) do not enforce any
> > constraints and/or dependencies between the parent and its child
> > nodes"
> >
> > This patch seems to change that behavior. If so, should it be documented?
>
> Not, I actually have to update the changelog of that patch.
>
> What I mean is that we do not enforce constraints among "requested"
> values thus ensuring that each sub-group can always request a clamp
> value.
> Of course, if it gets that value or not depends on parent constraints,
> which are propagated down the hierarchy under the form of "effective"
> values by cpu_util_update_heir()
>
> I'll fix the changelog in patch 10 which seems to be confusing for
> Tejun too.
>
> [...]
>
> > > @@ -7011,6 +7029,53 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
> > >  }
> > >
> > >  #ifdef CONFIG_UCLAMP_TASK_GROUP
> > > +static void cpu_util_update_hier(struct cgroup_subsys_state *css,
> >
> > s/cpu_util_update_hier/cpu_util_update_heir ?
>
> Mmm... why?
>
> That "_hier" stands for "hierarchical".

Yeah, I realized that later on but did not want to create more
chatter. _hier seems fine.

> However, since there we update the effective values, maybe I can
> better rename it in "_eff" ?
>
> > > +                                unsigned int clamp_id, unsigned int bucket_id,
> > > +                                unsigned int value)
> > > +{
> > > +       struct cgroup_subsys_state *top_css = css;
> > > +       struct uclamp_se *uc_se, *uc_parent;
> > > +
> > > +       css_for_each_descendant_pre(css, top_css) {
> > > +               /*
> > > +                * The first visited task group is top_css, which clamp value
> > > +                * is the one passed as parameter. For descendent task
> > > +                * groups we consider their current value.
> > > +                */
> > > +               uc_se = &css_tg(css)->uclamp[clamp_id];
> > > +               if (css != top_css) {
> > > +                       value = uc_se->value;
> > > +                       bucket_id = uc_se->effective.bucket_id;
> > > +               }
> > > +               uc_parent = NULL;
> > > +               if (css_tg(css)->parent)
> > > +                       uc_parent = &css_tg(css)->parent->uclamp[clamp_id];
> > > +
> > > +               /*
> > > +                * Skip the whole subtrees if the current effective clamp is
> > > +                * already matching the TG's clamp value.
> > > +                * In this case, all the subtrees already have top_value, or a
> > > +                * more restrictive value, as effective clamp.
> > > +                */
> > > +               if (uc_se->effective.value == value &&
> > > +                   uc_parent && uc_parent->effective.value >= value) {
> > > +                       css = css_rightmost_descendant(css);
> > > +                       continue;
> > > +               }
> > > +
> > > +               /* Propagate the most restrictive effective value */
> > > +               if (uc_parent && uc_parent->effective.value < value) {
> > > +                       value = uc_parent->effective.value;
> > > +                       bucket_id = uc_parent->effective.bucket_id;
> > > +               }
> > > +               if (uc_se->effective.value == value)
> > > +                       continue;
> > > +
> > > +               uc_se->effective.value = value;
> > > +               uc_se->effective.bucket_id = bucket_id;
> > > +       }
> > > +}
> > > +
> > >  static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
> > >                                   struct cftype *cftype, u64 min_value)
> > >  {
>
> [...]
>
> Cheers,
> Patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
