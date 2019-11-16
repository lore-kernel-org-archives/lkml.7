Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDC0C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D416520733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCNUy1hJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKPBVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:21:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44220 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKPBVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:21:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id f2so12857249wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJ0SkJIz+5H3YZ8Yb3fYixvmTl9l4YLJEwb349Zu19s=;
        b=NCNUy1hJFDLbGXbz+/f4bYw2HIp5keSo5U7EjrA4Lr0+RfyGa8EfJlOLZape8Z5qDN
         pZOUZ6r4m+kfQleB/aB3dASUwgaDXadeK9IQmlWLAwJtZed0+TdPzwQ0v36xXTbDX6aQ
         Ag6H12m0lQbu41sKFqGcy+wk9ZxhdskakEFVYYjB9MXf/M6b9RxCkaKC6kau7KMrVkZj
         Ziiq8MnJph9A0+qVXOR+qtwu7oyxhD40X81bmrbLQ+WIV5bEXmN+Fr8myQ4mQJczI8dI
         t6qFUYK6i9uZYCeqWUsJV49uZpK3XccNaYSdoYprtceu/jQvhKkPdbQ0CxpS0Bxr0lWP
         dVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJ0SkJIz+5H3YZ8Yb3fYixvmTl9l4YLJEwb349Zu19s=;
        b=CjSPJ8s3lmyDizRo8/p1f0ANuHTXuA22hyp6Y/qzIKAyc0koNXuidmbLBI/q9Rm1Gg
         rmKnCDlyOBf1oUqNLYexOgLx1+hmBLOWfRH223wMqHTxn7o7xdimBmRUCBgBLwToKc+q
         nLf9JZ/Bdv/9smwdE6Ehcj5S5rfIsXWJGbevrFx+LXRAD3+bA+Dwy5OwSZ+ThDFSxqDn
         y+D/sD0/rEgl3ZbDsKzv9Z3OOwLyEtsM41vd8KsWxrzxD01p0/D25tO3OGLKoQuwEC4D
         7l5hFVGYmkVsSYx9zWgVPGH3ZuP6vQClOEwFjNv2EqvCxYrkqrqcAbV2gBpZYd5KKmMw
         SwRQ==
X-Gm-Message-State: APjAAAXE3YzKjH9JaYoR2MSf+xyPO44q0rGNNeq2YXAU2VS+lQ6JCdlt
        j6DrdhhD9KLvgLmrK13v7Bm53QGrvIg5HpOLk8oXZw==
X-Google-Smtp-Source: APXvYqzYs8gQn14W+2d0N3KRg+GVFPSmNl+rKUUe8GU7K1WTWuEgrRzaneGOJ6SZpPUY6rrA3AYqkAh20gq+S2ekPxg=
X-Received: by 2002:a5d:6cc3:: with SMTP id c3mr18477540wrc.202.1573867263755;
 Fri, 15 Nov 2019 17:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191114003042.85252-9-irogers@google.com>
 <20191114102544.GS4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191114102544.GS4131@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 Nov 2019 17:20:52 -0800
Message-ID: <CAP-5=fUpwG833vooezqyYpKQdJ1k-RN=2E0fPHG3832h9qECLQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] perf: cache perf_event_groups_first for cgroups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 2:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Nov 13, 2019 at 04:30:40PM -0800, Ian Rogers wrote:
> > Add a per-CPU cache of the pinned and flexible perf_event_groups_first
> > value for a cgroup avoiding an O(log(#perf events)) searches during
> > sched_in.
> >
> > Based-on-work-by: Kan Liang <kan.liang@linux.intel.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  include/linux/perf_event.h |  6 +++
> >  kernel/events/core.c       | 79 +++++++++++++++++++++++++++-----------
> >  2 files changed, 62 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index b3580afbf358..cfd0b320418c 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -877,6 +877,12 @@ struct perf_cgroup_info {
> >  struct perf_cgroup {
> >       struct cgroup_subsys_state      css;
> >       struct perf_cgroup_info __percpu *info;
> > +     /* A cache of the first event with the perf_cpu_context's
> > +      * perf_event_context for the first event in pinned_groups or
> > +      * flexible_groups. Avoids an rbtree search during sched_in.
> > +      */
>
> Broken comment style.

Done.

> > +     struct perf_event * __percpu    *pinned_event;
> > +     struct perf_event * __percpu    *flexible_event;
>
> Where is the actual storage allocated? There is a conspicuous lack of
> alloc_percpu() in this patch, see for example perf_cgroup_css_alloc()
> which fills out the above @info field.

Apologies, missed from Kan's original patch but was in v2. Added again.

> >  };
> >
> >  /*
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 11594d8bbb2e..9f0febf51d97 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -1638,6 +1638,25 @@ perf_event_groups_insert(struct perf_event_groups *groups,
> >
> >       rb_link_node(&event->group_node, parent, node);
> >       rb_insert_color(&event->group_node, &groups->tree);
> > +#ifdef CONFIG_CGROUP_PERF
> > +     if (is_cgroup_event(event)) {
> > +             struct perf_event **cgrp_event;
> > +
> > +             if (event->attr.pinned)
> > +                     cgrp_event = per_cpu_ptr(event->cgrp->pinned_event,
> > +                                             event->cpu);
> > +             else
> > +                     cgrp_event = per_cpu_ptr(event->cgrp->flexible_event,
> > +                                             event->cpu);
>
> Codingstyle requires { } here (or just bust the line length a little).

Done.

> > +             /*
> > +              * Cgroup events for the same cgroup on the same CPU will
> > +              * always be inserted at the right because of bigger
> > +              * @groups->index. Only need to set *cgrp_event when it's NULL.
> > +              */
> > +             if (!*cgrp_event)
> > +                     *cgrp_event = event;
>
> I would feel much better if you had some actual leftmost logic in the
> insertion iteration.

Done. Also altered the comment to address the possibility of overflow.

> > +     }
> > +#endif
> >  }
> >
> >  /*
> > @@ -1652,6 +1671,9 @@ add_event_to_groups(struct perf_event *event, struct perf_event_context *ctx)
> >       perf_event_groups_insert(groups, event);
> >  }
> >
> > +static struct perf_event *
> > +perf_event_groups_next(struct perf_event *event);
> > +
> >  /*
> >   * Delete a group from a tree.
> >   */
> > @@ -1662,6 +1684,22 @@ perf_event_groups_delete(struct perf_event_groups *groups,
> >       WARN_ON_ONCE(RB_EMPTY_NODE(&event->group_node) ||
> >                    RB_EMPTY_ROOT(&groups->tree));
> >
> > +#ifdef CONFIG_CGROUP_PERF
> > +     if (is_cgroup_event(event)) {
> > +             struct perf_event **cgrp_event;
> > +
> > +             if (event->attr.pinned)
> > +                     cgrp_event = per_cpu_ptr(event->cgrp->pinned_event,
> > +                                             event->cpu);
> > +             else
> > +                     cgrp_event = per_cpu_ptr(event->cgrp->flexible_event,
> > +                                             event->cpu);
>
> Codingstyle again.

Done.

> > +
> > +             if (*cgrp_event == event)
> > +                     *cgrp_event = perf_event_groups_next(event);
> > +     }
> > +#endif
> > +
> >       rb_erase(&event->group_node, &groups->tree);
> >       init_event_group(event);
> >  }
> > @@ -1679,20 +1717,14 @@ del_event_from_groups(struct perf_event *event, struct perf_event_context *ctx)
> >  }
> >
> >  /*
> > - * Get the leftmost event in the cpu/cgroup subtree.
> > + * Get the leftmost event in the cpu subtree without a cgroup (ie task or
> > + * system-wide).
> >   */
> >  static struct perf_event *
> > -perf_event_groups_first(struct perf_event_groups *groups, int cpu,
> > -                     struct cgroup *cgrp)
> > +perf_event_groups_first_no_cgroup(struct perf_event_groups *groups, int cpu)
>
> I'm going to impose a function name length limit soon :/ That's insane
> (again).

Done, with the argument added back in.

> >  {
> >       struct perf_event *node_event = NULL, *match = NULL;
> >       struct rb_node *node = groups->tree.rb_node;
> > -#ifdef CONFIG_CGROUP_PERF
> > -     int node_cgrp_id, cgrp_id = 0;
> > -
> > -     if (cgrp)
> > -             cgrp_id = cgrp->id;
> > -#endif
> >
> >       while (node) {
> >               node_event = container_of(node, struct perf_event, group_node);
> > @@ -1706,18 +1738,10 @@ perf_event_groups_first(struct perf_event_groups *groups, int cpu,
> >                       continue;
> >               }
> >  #ifdef CONFIG_CGROUP_PERF
> > -             node_cgrp_id = 0;
> > -             if (node_event->cgrp && node_event->cgrp->css.cgroup)
> > -                     node_cgrp_id = node_event->cgrp->css.cgroup->id;
> > -
> > -             if (cgrp_id < node_cgrp_id) {
> > +             if (node_event->cgrp) {
> >                       node = node->rb_left;
> >                       continue;
> >               }
> > -             if (cgrp_id > node_cgrp_id) {
> > -                     node = node->rb_right;
> > -                     continue;
> > -             }
> >  #endif
> >               match = node_event;
> >               node = node->rb_left;
>
> Also, just leave that in and let callers have: .cgrp = NULL. Then you
> can forgo that monstrous name.

Done. It is a shame that there is some extra logic for the task/no-cgroup case.
