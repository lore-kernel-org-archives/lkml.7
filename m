Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A582AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379D1205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0ip7uyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfD2XCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 19:02:46 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43449 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfD2XCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:02:46 -0400
Received: by mail-ua1-f65.google.com with SMTP id n16so4102203uae.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 16:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1Awg28ir9plZiead9SyV1VZqzLmYv6WPCrVJuvct5Q=;
        b=p0ip7uyDr74NRd4dlO9xL9nCHgIyDNqmfRHmf2CMxpGG8501EOweyAFeSM90ec3a6K
         SZUgd1/thIl3srpVq+O5K26nF1GmRHbpUbatT4AUrFl8WvIybLiJuqEQ0f/bxZev5nmW
         WiAVozb/iXl9IQX2T9zVn+/z0DjkLI7NnUS6iFZWlmQxho0CsK2UVu6xUc7IaK9MW7Jw
         xUa7TuJYOtlFE1wB6HC+/SC9FHfYEFy+jyJUyQrDubfUjk2kOQ3SYu3+Il41Rnf/+O/T
         3AYIgojLKDJQgrsrmslcoCLiJx+fd2v3s9CFEPHQmD9VoqXeoWp1rP4nbVtaIVWSa8N9
         O54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1Awg28ir9plZiead9SyV1VZqzLmYv6WPCrVJuvct5Q=;
        b=Hro7D+92KEwF9d4e54vbuKF5RehR+leWmhhL5GLCNXxdK7EQSUFgFsPdMZ8NQZ3Rae
         cjozNYhBLFo5R3vBFZKyAagv7tLdmPTIA2x2Pq6mGkrMNh+apQ9nUOObU4PAtgRi+xVI
         B/WnuEzMXXPP2QSkyaKwUrlEJzTG2HJ3K/AinmKECPZaMSgjNOs3l+M5ZtUsjK1OJqYI
         Y94up0wQtECnkk1Dez8pdFFYlLxnfQMcOi2PdhCpj2ShNFrzAN7d1knUfWoWe0jhw5Qx
         15FMyDD+YQj6UFwzfFcgDDrgbpK05e2YsCRTRk6Y/+OjEKw7WxlpgrlWVPM0FNMiPDON
         MJVw==
X-Gm-Message-State: APjAAAWo8f9p2iwTjj7K3h8gSfMjZvjemMkmYhzLWwhx84rBtadANVcT
        86MHQvO8z5F6xeW0BhZeOMPFTfKOf7uqEnSZ3sG0dA==
X-Google-Smtp-Source: APXvYqwUH1tTz7OEwYtUli1AuyPlGq7+5tC7bUuER4dYW++O+PajU3Z3vieLkD23/es9UM5gCzXBM97tYW/DwbxaUx8=
X-Received: by 2002:ab0:3445:: with SMTP id a5mr2709314uaq.136.1556578964748;
 Mon, 29 Apr 2019 16:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com> <1556549045-71814-4-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1556549045-71814-4-git-send-email-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 Apr 2019 16:02:33 -0700
Message-ID: <CAP-5=fUKeyj=yFCBdeKgtTP=e8DYL_5zLi=gF9OeiOFquuD7YQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf cgroup: Add cgroup ID as a key of RB tree
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>, tj@kernel.org,
        ak@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is very interesting. How does the code handle cgroup hierarchies?
For example, if we have:

cgroup0 is the cgroup root
cgroup1 whose parent is cgroup0
cgroup2 whose parent is cgroup1

we have task0 running in cgroup0, task1 in cgroup1, task2 in cgroup2
and then a perf command line like:
perf stat -e cycles,cycles,cycles -G cgroup0,cgroup1,cgroup2 --no-merge sleep 10

we expected 3 cycles counts:
 - for cgroup0 including task2, task1 and task0
 - for cgroup1 including task2 and task1
 - for cgroup2 just including task2

It looks as though:
+       if (next && (next->cpu == event->cpu) && (next->cgrp_id ==
event->cgrp_id))

will mean that events will only consider cgroups that directly match
the cgroup of the event. Ie we'd get 3 cycles counts of:
 - for cgroup0 just task0
 - for cgroup1 just task1
 - for cgroup2 just task2

Thanks,
Ian


On Mon, Apr 29, 2019 at 7:45 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Current RB tree for pinned/flexible groups doesn't take cgroup into
> account. All events on a given CPU will be fed to
> pinned/flexible_sched_in(), which relies on perf_cgroup_match() to
> filter the events for a specific cgroup. The method has high overhead,
> especially in frequent context switch with several events and cgroups
> involved.
>
> Add unique cgrp_id for each cgroup, which is composed by CPU ID and css
> subsys-unique ID. The low 32bit of cgrp_id (css subsys-unique ID) is
> used as part of complex key of RB tree.
> Events in the same cgroup has the same cgrp_id.
> The cgrp_id is always zero for non-cgroup case. There is no functional
> change for non-cgroup case.
>
> Add perf_event_groups_first_cgroup() and
> perf_event_groups_next_cgroup(), which will be used later to traverse
> the events for a specific cgroup on a given CPU.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  include/linux/perf_event.h |  6 ++++
>  kernel/events/core.c       | 84 ++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 83 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 039e2f2..7eff286 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -703,6 +703,7 @@ struct perf_event {
>
>  #ifdef CONFIG_CGROUP_PERF
>         struct perf_cgroup              *cgrp; /* cgroup event is attach to */
> +       u64                             cgrp_id; /* perf cgroup ID */
>  #endif
>
>         struct list_head                sb_list;
> @@ -825,6 +826,9 @@ struct bpf_perf_event_data_kern {
>
>  #ifdef CONFIG_CGROUP_PERF
>
> +#define PERF_CGROUP_ID_MASK            0xffffffff
> +#define cgrp_id_low(id)                        (id & PERF_CGROUP_ID_MASK)
> +
>  /*
>   * perf_cgroup_info keeps track of time_enabled for a cgroup.
>   * This is a per-cpu dynamically allocated data structure.
> @@ -837,6 +841,8 @@ struct perf_cgroup_info {
>  struct perf_cgroup {
>         struct cgroup_subsys_state      css;
>         struct perf_cgroup_info __percpu *info;
> +       /* perf cgroup ID = (CPU ID << 32) | css subsys-unique ID */
> +       u64 __percpu                    *cgrp_id;
>  };
>
>  /*
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 782fd86..5ecc048 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -901,6 +901,7 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
>         struct cgroup_subsys_state *css;
>         struct fd f = fdget(fd);
>         int ret = 0;
> +       u64 cgrp_id;
>
>         if (!f.file)
>                 return -EBADF;
> @@ -915,6 +916,10 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
>         cgrp = container_of(css, struct perf_cgroup, css);
>         event->cgrp = cgrp;
>
> +       cgrp_id = ((u64)smp_processor_id() << 32) | css->id;
> +       event->cgrp_id = cgrp_id;
> +       *per_cpu_ptr(cgrp->cgrp_id, event->cpu) = cgrp_id;
> +
>         /*
>          * all events in a group must monitor
>          * the same cgroup because a task belongs
> @@ -1494,6 +1499,9 @@ static void init_event_group(struct perf_event *event)
>  {
>         RB_CLEAR_NODE(&event->group_node);
>         event->group_index = 0;
> +#ifdef CONFIG_CGROUP_PERF
> +       event->cgrp_id = 0;
> +#endif
>  }
>
>  /*
> @@ -1521,8 +1529,8 @@ static void perf_event_groups_init(struct perf_event_groups *groups)
>  /*
>   * Compare function for event groups;
>   *
> - * Implements complex key that first sorts by CPU and then by virtual index
> - * which provides ordering when rotating groups for the same CPU.
> + * Implements complex key that first sorts by CPU and cgroup ID, then by
> + * virtual index which provides ordering when rotating groups for the same CPU.
>   */
>  static bool
>  perf_event_groups_less(struct perf_event *left, struct perf_event *right)
> @@ -1532,6 +1540,13 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
>         if (left->cpu > right->cpu)
>                 return false;
>
> +#ifdef CONFIG_CGROUP_PERF
> +       if (cgrp_id_low(left->cgrp_id) < cgrp_id_low(right->cgrp_id))
> +               return true;
> +       if (cgrp_id_low(left->cgrp_id) > cgrp_id_low(right->cgrp_id))
> +               return false;
> +#endif
> +
>         if (left->group_index < right->group_index)
>                 return true;
>         if (left->group_index > right->group_index)
> @@ -1541,7 +1556,8 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
>  }
>
>  /*
> - * Insert @event into @groups' tree; using {@event->cpu, ++@groups->index} for
> + * Insert @event into @groups' tree;
> + * Using {@event->cpu, @event->cgrp_id, ++@groups->index} for
>   * key (see perf_event_groups_less). This places it last inside the CPU
>   * subtree.
>   */
> @@ -1650,6 +1666,50 @@ perf_event_groups_next(struct perf_event *event)
>         return NULL;
>  }
>
> +#ifdef CONFIG_CGROUP_PERF
> +
> +static struct perf_event *
> +perf_event_groups_first_cgroup(struct perf_event_groups *groups,
> +                              int cpu, u64 cgrp_id)
> +{
> +       struct perf_event *node_event = NULL, *match = NULL;
> +       struct rb_node *node = groups->tree.rb_node;
> +
> +       while (node) {
> +               node_event = container_of(node, struct perf_event, group_node);
> +
> +               if (cpu < node_event->cpu) {
> +                       node = node->rb_left;
> +               } else if (cpu > node_event->cpu) {
> +                       node = node->rb_right;
> +               } else {
> +                       if (cgrp_id_low(cgrp_id) < cgrp_id_low(node_event->cgrp_id))
> +                               node = node->rb_left;
> +                       else if (cgrp_id_low(cgrp_id) > cgrp_id_low(node_event->cgrp_id))
> +                               node = node->rb_right;
> +                       else {
> +                               match = node_event;
> +                               node = node->rb_left;
> +                               }
> +                       }
> +               }
> +               return match;
> +}
> +
> +static struct perf_event *
> +perf_event_groups_next_cgroup(struct perf_event *event)
> +{
> +       struct perf_event *next;
> +
> +       next = rb_entry_safe(rb_next(&event->group_node), typeof(*event), group_node);
> +       if (next && (next->cpu == event->cpu) && (next->cgrp_id == event->cgrp_id))
> +               return next;
> +
> +       return NULL;
> +}
> +
> +#endif
> +
>  /*
>   * Iterate through the whole groups tree.
>   */
> @@ -12127,18 +12187,28 @@ perf_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>                 return ERR_PTR(-ENOMEM);
>
>         jc->info = alloc_percpu(struct perf_cgroup_info);
> -       if (!jc->info) {
> -               kfree(jc);
> -               return ERR_PTR(-ENOMEM);
> -       }
> +       if (!jc->info)
> +               goto free_jc;
> +
> +       jc->cgrp_id = alloc_percpu(u64);
> +       if (!jc->cgrp_id)
> +               goto free_jc_info;
>
>         return &jc->css;
> +
> +free_jc_info:
> +       free_percpu(jc->info);
> +free_jc:
> +       kfree(jc);
> +
> +       return ERR_PTR(-ENOMEM);
>  }
>
>  static void perf_cgroup_css_free(struct cgroup_subsys_state *css)
>  {
>         struct perf_cgroup *jc = container_of(css, struct perf_cgroup, css);
>
> +       free_percpu(jc->cgrp_id);
>         free_percpu(jc->info);
>         kfree(jc);
>  }
> --
> 2.7.4
>
