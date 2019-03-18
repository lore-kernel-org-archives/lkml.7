Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB67C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873DB20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfCRQyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:54:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37730 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfCRQyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:54:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8231D1650;
        Mon, 18 Mar 2019 09:54:36 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DC143F614;
        Mon, 18 Mar 2019 09:54:33 -0700 (PDT)
Date:   Mon, 18 Mar 2019 16:54:30 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Suren Baghdasaryan <surenb@google.com>
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
Subject: Re: [PATCH v7 12/15] sched/core: uclamp: Propagate parent clamps
Message-ID: <20190318165430.n222vuq4tv3ntbod@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-13-patrick.bellasi@arm.com>
 <CAJuCfpHTtokPFHu3KHYGj9arbPYn6ZZ=-qNpmVPrDwhPvnA9Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHTtokPFHu3KHYGj9arbPYn6ZZ=-qNpmVPrDwhPvnA9Ow@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-Mar 09:17, Suren Baghdasaryan wrote:
> On Fri, Feb 8, 2019 at 2:06 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >
> > In order to properly support hierarchical resources control, the cgroup
> > delegation model requires that attribute writes from a child group never
> > fail but still are (potentially) constrained based on parent's assigned
> > resources. This requires to properly propagate and aggregate parent
> > attributes down to its descendants.
> >
> > Let's implement this mechanism by adding a new "effective" clamp value
> > for each task group. The effective clamp value is defined as the smaller
> > value between the clamp value of a group and the effective clamp value
> > of its parent. This is the actual clamp value enforced on tasks in a
> > task group.
> 
> In patch 10 in this series you mentioned "b) do not enforce any
> constraints and/or dependencies between the parent and its child
> nodes"
> 
> This patch seems to change that behavior. If so, should it be documented?

Not, I actually have to update the changelog of that patch.

What I mean is that we do not enforce constraints among "requested"
values thus ensuring that each sub-group can always request a clamp
value.
Of course, if it gets that value or not depends on parent constraints,
which are propagated down the hierarchy under the form of "effective"
values by cpu_util_update_heir()

I'll fix the changelog in patch 10 which seems to be confusing for
Tejun too.

[...]

> > @@ -7011,6 +7029,53 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
> >  }
> >
> >  #ifdef CONFIG_UCLAMP_TASK_GROUP
> > +static void cpu_util_update_hier(struct cgroup_subsys_state *css,
> 
> s/cpu_util_update_hier/cpu_util_update_heir ?

Mmm... why?

That "_hier" stands for "hierarchical".

However, since there we update the effective values, maybe I can
better rename it in "_eff" ?

> > +                                unsigned int clamp_id, unsigned int bucket_id,
> > +                                unsigned int value)
> > +{
> > +       struct cgroup_subsys_state *top_css = css;
> > +       struct uclamp_se *uc_se, *uc_parent;
> > +
> > +       css_for_each_descendant_pre(css, top_css) {
> > +               /*
> > +                * The first visited task group is top_css, which clamp value
> > +                * is the one passed as parameter. For descendent task
> > +                * groups we consider their current value.
> > +                */
> > +               uc_se = &css_tg(css)->uclamp[clamp_id];
> > +               if (css != top_css) {
> > +                       value = uc_se->value;
> > +                       bucket_id = uc_se->effective.bucket_id;
> > +               }
> > +               uc_parent = NULL;
> > +               if (css_tg(css)->parent)
> > +                       uc_parent = &css_tg(css)->parent->uclamp[clamp_id];
> > +
> > +               /*
> > +                * Skip the whole subtrees if the current effective clamp is
> > +                * already matching the TG's clamp value.
> > +                * In this case, all the subtrees already have top_value, or a
> > +                * more restrictive value, as effective clamp.
> > +                */
> > +               if (uc_se->effective.value == value &&
> > +                   uc_parent && uc_parent->effective.value >= value) {
> > +                       css = css_rightmost_descendant(css);
> > +                       continue;
> > +               }
> > +
> > +               /* Propagate the most restrictive effective value */
> > +               if (uc_parent && uc_parent->effective.value < value) {
> > +                       value = uc_parent->effective.value;
> > +                       bucket_id = uc_parent->effective.bucket_id;
> > +               }
> > +               if (uc_se->effective.value == value)
> > +                       continue;
> > +
> > +               uc_se->effective.value = value;
> > +               uc_se->effective.bucket_id = bucket_id;
> > +       }
> > +}
> > +
> >  static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
> >                                   struct cftype *cftype, u64 min_value)
> >  {

[...]

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
