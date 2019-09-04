Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2FDC3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9E320870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1CINYHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfIDFio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 01:38:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55753 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDFio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:38:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id g207so1761343wmg.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 22:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjkIYBZ84wViixpo736u9BuUnFigJEHvSnUL+P/PBcU=;
        b=F1CINYHyzlUuWZl/czJ2J2eXoJ6RO+aZjWVtRRvpQ04XNip4g1qvS0SnTm7MmvFS1y
         KTr7bBI5MOxx+H9tbQgMgTKNDeirqidEiQWdHM89bcFP84N1uP0D1OJL318t8mxafI9d
         6UFhEQsMAEsmzotDK/cUepM1Js+mpP9wFQ4jdq8o+TbgsrMTeMzKlynQMg5rPBKU5DeL
         EEVxthZVl8ZNhLB+7KXynM4h/jFTP7LAQ15SE3BQYZlDbcXL6IfzlAJbAOJswPmcsXTJ
         5mWWyU+nuBCPrtP9IFWLawEU53OQuWdaio5HmNoxHn89B5GZ39pSvwLVxK8wlHcnkbv3
         VtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjkIYBZ84wViixpo736u9BuUnFigJEHvSnUL+P/PBcU=;
        b=CJ26RZhioqjL5CNFjPDQcxMfDbkZvS/9C33qHxI/oGrbhOOf2cvIs+3q7+OCkY3Ow0
         ZGl59D6kdOWrmc3Blbzg695k7+1XJzF4m2qMyIKlnlJf9Fg8fg9unLUwTVILnjg8Bg94
         yO0hvkQreTaQjuogPdPpb0yMGFtkYwjEQWp29UaJzDsSuNOOZCQmfjSV0nV4eSZegtNR
         qjRhnogQ3sq7GHUGBGWgOpEDwdstsGyvc8tYjz9e0lW2BjT3RoaULvB/g6IOiDg2ravA
         KbDg9O0sJjlJO5ONoXTN1oNyFlQ6/g0QBUHEElCmui4ITCfQCGOiWypeo6vdXua9HhX2
         wkiA==
X-Gm-Message-State: APjAAAXPMeWxpzfrX2I4wKdApUUh39XOy9nAskluiIqWEFGx5KC0eNJE
        Te4JSBGpkw2wiGoPRh/G9+jQ9dEIiB3dr/+KMIe5gg==
X-Google-Smtp-Source: APXvYqzFPPpVWAqotpZJ/8I6yBwvNX3PeJCESPEiyFpyvXZYHeO7T3dOG/NOPNEfyRJ0xEytKCyVCGrAuk59O0c0BqQ=
X-Received: by 2002:a1c:80d0:: with SMTP id b199mr2723540wmd.102.1567575520837;
 Tue, 03 Sep 2019 22:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <CAJuCfpEXpYq2i3zNbJ3w+R+QXTuMyzwL6S9UpiGEDvTioKORhQ@mail.gmail.com> <20190904050240.GD144846@google.com>
In-Reply-To: <20190904050240.GD144846@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Sep 2019 22:38:29 -0700
Message-ID: <CAJuCfpF8czXD1bZ84Uw9pMhfVMwgPRc-4Xb4oNz9TohS7Bzfyg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Carmen Jackson <carmenjackson@google.com>,
        mayankgupta@google.com, Daniel Colascione <dancol@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team <kernel-team@android.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.cz>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 10:02 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Sep 03, 2019 at 09:44:51PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Sep 3, 2019 at 1:09 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > Useful to track how RSS is changing per TGID to detect spikes in RSS and
> > > memory hogs. Several Android teams have been using this patch in various
> > > kernel trees for half a year now. Many reported to me it is really
> > > useful so I'm posting it upstream.
> > >
> > > Initial patch developed by Tim Murray. Changes I made from original patch:
> > > o Prevent any additional space consumed by mm_struct.
> > > o Keep overhead low by checking if tracing is enabled.
> > > o Add some noise reduction and lower overhead by emitting only on
> > >   threshold changes.
> > >
> > > Co-developed-by: Tim Murray <timmurray@google.com>
> > > Signed-off-by: Tim Murray <timmurray@google.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > ---
> > >
> > > v1->v2: Added more commit message.
> > >
> > > Cc: carmenjackson@google.com
> > > Cc: mayankgupta@google.com
> > > Cc: dancol@google.com
> > > Cc: rostedt@goodmis.org
> > > Cc: minchan@kernel.org
> > > Cc: akpm@linux-foundation.org
> > > Cc: kernel-team@android.com
> > >
> > >  include/linux/mm.h          | 14 +++++++++++---
> > >  include/trace/events/kmem.h | 21 +++++++++++++++++++++
> > >  mm/memory.c                 | 20 ++++++++++++++++++++
> > >  3 files changed, 52 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 0334ca97c584..823aaf759bdb 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -1671,19 +1671,27 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
> > >         return (unsigned long)val;
> > >  }
> > >
> > > +void mm_trace_rss_stat(int member, long count, long value);
> > > +
> > >  static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
> > >  {
> > > -       atomic_long_add(value, &mm->rss_stat.count[member]);
> > > +       long count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
> > > +
> > > +       mm_trace_rss_stat(member, count, value);
> > >  }
> > >
> > >  static inline void inc_mm_counter(struct mm_struct *mm, int member)
> > >  {
> > > -       atomic_long_inc(&mm->rss_stat.count[member]);
> > > +       long count = atomic_long_inc_return(&mm->rss_stat.count[member]);
> > > +
> > > +       mm_trace_rss_stat(member, count, 1);
> > >  }
> > >
> > >  static inline void dec_mm_counter(struct mm_struct *mm, int member)
> > >  {
> > > -       atomic_long_dec(&mm->rss_stat.count[member]);
> > > +       long count = atomic_long_dec_return(&mm->rss_stat.count[member]);
> > > +
> > > +       mm_trace_rss_stat(member, count, -1);
> > >  }
> > >
> > >  /* Optimized variant when page is already known not to be PageAnon */
> > > diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> > > index eb57e3037deb..8b88e04fafbf 100644
> > > --- a/include/trace/events/kmem.h
> > > +++ b/include/trace/events/kmem.h
> > > @@ -315,6 +315,27 @@ TRACE_EVENT(mm_page_alloc_extfrag,
> > >                 __entry->change_ownership)
> > >  );
> > >
> > > +TRACE_EVENT(rss_stat,
> > > +
> > > +       TP_PROTO(int member,
> > > +               long count),
> > > +
> > > +       TP_ARGS(member, count),
> > > +
> > > +       TP_STRUCT__entry(
> > > +               __field(int, member)
> > > +               __field(long, size)
> > > +       ),
> > > +
> > > +       TP_fast_assign(
> > > +               __entry->member = member;
> > > +               __entry->size = (count << PAGE_SHIFT);
> > > +       ),
> > > +
> > > +       TP_printk("member=%d size=%ldB",
> > > +               __entry->member,
> > > +               __entry->size)
> > > +       );
> > >  #endif /* _TRACE_KMEM_H */
> > >
> > >  /* This part must be outside protection */
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index e2bb51b6242e..9d81322c24a3 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -72,6 +72,8 @@
> > >  #include <linux/oom.h>
> > >  #include <linux/numa.h>
> > >
> > > +#include <trace/events/kmem.h>
> > > +
> > >  #include <asm/io.h>
> > >  #include <asm/mmu_context.h>
> > >  #include <asm/pgalloc.h>
> > > @@ -140,6 +142,24 @@ static int __init init_zero_pfn(void)
> > >  }
> > >  core_initcall(init_zero_pfn);
> > >
> > > +/*
> > > + * This threshold is the boundary in the value space, that the counter has to
> > > + * advance before we trace it. Should be a power of 2. It is to reduce unwanted
> > > + * trace overhead. The counter is in units of number of pages.
> > > + */
> > > +#define TRACE_MM_COUNTER_THRESHOLD 128
> >
> > IIUC the counter has to change by 128 pages (512kB assuming 4kB pages)
> > before the change gets traced. Would it make sense to make this step
> > size configurable? For a system with limited memory size change of
> > 512kB might be considerable while on systems with plenty of memory
> > that might be negligible. Not even mentioning possible difference in
> > page sizes. Maybe something like
> > /sys/kernel/debug/tracing/rss_step_order with
> > TRACE_MM_COUNTER_THRESHOLD=(1<<rss_step_order)?
>
> I would not want to complicate this more to be honest. It is already a bit
> complex, and I am not sure about the win in making it as configurable as you
> seem to want. The "threshold" thing is just a slight improvement, it is not
> aiming to be optimal. If in your tracing, this granularity is an issue, we
> can visit it then.

I guess that can be done as a separate patch later on if necessary.

>
> thanks,
>
>  - Joel
>
>
>
> > > +void mm_trace_rss_stat(int member, long count, long value)
> > > +{
> > > +       long thresh_mask = ~(TRACE_MM_COUNTER_THRESHOLD - 1);
> > > +
> > > +       if (!trace_rss_stat_enabled())
> > > +               return;
> > > +
> > > +       /* Threshold roll-over, trace it */
> > > +       if ((count & thresh_mask) != ((count - value) & thresh_mask))
> > > +               trace_rss_stat(member, count);
> > > +}
> > >
> > >  #if defined(SPLIT_RSS_COUNTING)
> > >
> > > --
> > > 2.23.0.187.g17f5b7556c-goog
> > >
> > > --
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> > >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
