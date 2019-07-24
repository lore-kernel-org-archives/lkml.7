Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D84C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC7821850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvpW/OrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfGXWez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:34:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39347 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfGXWez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:34:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so32590796wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UaaYQjOom/rBedcmfeqJ2SI1/RfkITskc6E8mQACYxM=;
        b=mvpW/OrV5vZp7+uvzXd/fPQocMFHXoUGw2MBI+s4vyA0vP8Stum++rw4Frwd62MsWx
         wwPUZAZwQub1YF+hOyMfdfTRT3cBjDSMkrdRa+0Xgg8DO3iNAo300TFZlh9/fxFV74z2
         bz02tQaihF8DvvWtEvyr6zsPKr0dggJbnfPARqZU5xJp4ZinbSZYPUta0BoMwB0tF7Bw
         36usvx4LTjvAyd+ANeqxSOkwQbvo6eHoWKtv/GHpr22vFojGBNzMCrQg5mW5ril2K7qV
         VcnsqU/pz/MMuSGpK3wiKN4PrKy4kifnsIAcDQJGRsUwCfBbG6dUFkNBhu2jNTesysCH
         lWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UaaYQjOom/rBedcmfeqJ2SI1/RfkITskc6E8mQACYxM=;
        b=kHCMwAiYWqincsP9jJo6ubxqujbV7Hqzu80VZcJFXtPsVQtlPT7ihdLSA5icudknQ0
         obNs7PsHnxN+hDm8ZMhG9c27TkFEb4m4wUP42vwmeeB1perF+iTnqkWulBl2J762Q9WQ
         sG9GvPUL2z94H3SmM748SaroCyDEn1i9c6zjRQzxKXlaBPmdD5wmSlVtoUk+JwVe8N/Z
         LbhsT3K3eJ5y1qSGOSP8WKl1Q+gavkFu0G6uKFbXPZ6OZGfMSXAWQmWpZCZHd/vgQ8Bv
         cTf3xHnPO50WOx+ExG4J53cCU2cucBOU3gD/9Mpn5OSd3NfC1iw7fMK2inEL8pU2JLtN
         WLLA==
X-Gm-Message-State: APjAAAX2tPSt0VV5Thd9s4H63eYIYWHoGlT/P0uzMgGa/P8zN/81wF9l
        rIdHV1a0vrOMd5Of+lvWRzxBNNBbohEkAyRBuVuw1Q==
X-Google-Smtp-Source: APXvYqw13DzvmJbH/WR3ahTOZdE6oV0KztUziVEs86+1CR7H5FOBEvnfnj/5DVLig0AOSbyiAZOkBhWtFiNn0dOy4Uk=
X-Received: by 2002:a7b:c106:: with SMTP id w6mr80061933wmi.80.1564007692187;
 Wed, 24 Jul 2019 15:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com> <20190702065955.165738-4-irogers@google.com>
 <20190708163021.GG3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190708163021.GG3419@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Jul 2019 15:34:40 -0700
Message-ID: <CAP-5=fV4xmK=4ocyfzGzj5avGFZojZn-KXp9xDCATkiFLpCmcg@mail.gmail.com>
Subject: Re: [PATCH 3/7] perf: order iterators for visit_groups_merge into a min-heap
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 9:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 01, 2019 at 11:59:51PM -0700, Ian Rogers wrote:
> > The groups rbtree holding perf events, either for a CPU or a task, needs
> > to have multiple iterators that visit events in group_index (insertion)
> > order. Rather than linearly searching the iterators, use a min-heap to go
> > from a O(#iterators) search to a O(log2(#iterators)) insert cost per event
> > visited.
>
> Is this actually faster for the common (very small n) case?
>
> ISTR 'stupid' sorting algorithms are actually faster when the data fits
> into L1

A common case is for there to be 1 cgroup iterator, for which all the
min_heapify calls will do no work as the event is always a leaf. It'd
be expected a min-heap to be optimal for a large number of iterators.
I'm not sure it is worth optimizing the space between small number of
iterators and large number of iterators.

Thanks,
Ian


> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  kernel/events/core.c | 123 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 95 insertions(+), 28 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 9a2ad34184b8..396b5ac6dcd4 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -3318,6 +3318,77 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
> >       ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
> >  }
> >
> > +/* Data structure used to hold a min-heap, ordered by group_index, of a fixed
> > + * maximum size.
> > + */
>
> Broken comment style.
>
> > +struct perf_event_heap {
> > +     struct perf_event **storage;
> > +     int num_elements;
> > +     int max_elements;
> > +};
> > +
> > +static void min_heap_swap(struct perf_event_heap *heap,
> > +                       int pos1, int pos2)
> > +{
> > +     struct perf_event *tmp = heap->storage[pos1];
> > +
> > +     heap->storage[pos1] = heap->storage[pos2];
> > +     heap->storage[pos2] = tmp;
> > +}
> > +
> > +/* Sift the perf_event at pos down the heap. */
> > +static void min_heapify(struct perf_event_heap *heap, int pos)
> > +{
> > +     int left_child, right_child;
> > +
> > +     while (pos > heap->num_elements / 2) {
> > +             left_child = pos * 2;
> > +             right_child = pos * 2 + 1;
> > +             if (heap->storage[pos]->group_index >
> > +                 heap->storage[left_child]->group_index) {
> > +                     min_heap_swap(heap, pos, left_child);
> > +                     pos = left_child;
> > +             } else if (heap->storage[pos]->group_index >
> > +                        heap->storage[right_child]->group_index) {
> > +                     min_heap_swap(heap, pos, right_child);
> > +                     pos = right_child;
> > +             } else {
> > +                     break;
> > +             }
> > +     }
> > +}
> > +
> > +/* Floyd's approach to heapification that is O(n). */
> > +static void min_heapify_all(struct perf_event_heap *heap)
> > +{
> > +     int i;
> > +
> > +     for (i = heap->num_elements / 2; i > 0; i--)
> > +             min_heapify(heap, i);
> > +}
> > +
> > +/* Remove minimum element from the heap. */
> > +static void min_heap_pop(struct perf_event_heap *heap)
> > +{
> > +     WARN_ONCE(heap->num_elements <= 0, "Popping an empty heap");
> > +     heap->num_elements--;
> > +     heap->storage[0] = heap->storage[heap->num_elements];
> > +     min_heapify(heap, 0);
> > +}
>
> Is this really the first heap implementation in the kernel?
>
> > @@ -3378,12 +3453,14 @@ static int visit_groups_merge(struct perf_event_context *ctx,
> >                       struct cgroup_subsys_state *css;
> >
> >                       for (css = &cpuctx->cgrp->css; css; css = css->parent) {
> > -                             itrs[num_itrs] = perf_event_groups_first(groups,
> > +                             heap.storage[heap.num_elements] =
> > +                                             perf_event_groups_first(groups,
> >                                                                  cpu,
> >                                                                  css->cgroup);
> > -                             if (itrs[num_itrs]) {
> > -                                     num_itrs++;
> > -                                     if (num_itrs == max_itrs) {
> > +                             if (heap.storage[heap.num_elements]) {
> > +                                     heap.num_elements++;
> > +                                     if (heap.num_elements ==
> > +                                         heap.max_elements) {
> >                                               WARN_ONCE(
> >                                    max_cgroups_with_events_depth,
> >                                    "Insufficient iterators for cgroup depth");
>
> That's turning into unreadable garbage due to indentation; surely
> there's a solution for that.
