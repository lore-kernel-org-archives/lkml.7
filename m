Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21A6C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A230B2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQEo/pW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfCNJoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:44:15 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52878 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfCNJoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:44:14 -0400
Received: by mail-it1-f195.google.com with SMTP id g17so3594413ita.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vVlXIGUUTwMipB8dwrJZqLuKEZoHvnjGk2ecgreUCA=;
        b=hQEo/pW7w4uMxxsCgSWGECb+BCkmaopXk7y0KbywQtoHEK+yiOOKXL0KtgzayxxNVu
         /PsQEOvyo1aXxS4gCjUMmlUAPMYsmT52uukPIm6pj3fUVYjQgG1FaX/7RXIIxY3xXinE
         ph74gUliHyHgKlCHHnkAHhwYA8jC0B2jEw3ieBt00ntKNAXfX/4Hppse4TDrctncx6Iz
         ul9MzFMXzhgKnURJPIYNWCuWT7KGs4xvX0/3f5AYAupyFdJ7N40VQ139j31ULJk0mKlL
         K5LGnR4crzpxQnzOkuZXidbTMOw/7VOQAYj+SQxSPkOcTjIAIIbDPpAiyRmgQMumqjvp
         bCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vVlXIGUUTwMipB8dwrJZqLuKEZoHvnjGk2ecgreUCA=;
        b=XoHPgrxSc33kroYQT6dc0M1ppIEl7CerHcqw4/tbUOU+Fc9WkdK+WqEOW0fq+9/+jN
         NiBt5lrTMnbAMya8JoN5Wn5S8zto+SnZdVXRUJ6OvXqFWF8x27LRRMdNeDQMeFn8hRkI
         LPHU2x67oljnOXkoRvVtr1k7R8fLFhzXXpT5qo70TDjuGGuSTMH7BJJ80Ea3GGMksqti
         JYh1ZsOZ6Wcd0A7FuK8pfOMN/w9HkWoOdDutRO9FPUOc7NNyIYDDiv33wkw47IXfvZ0J
         2O6Hz8vOoXKWb3eJjh4mVUq9XkTmRFy4C5jthG8FoDxxyu0i30be3itTayjtQGVY7syI
         vqSg==
X-Gm-Message-State: APjAAAXFGvTRi1WeBbE1cj4pVYB8fhfOuJlZeGu0p9EHXk0HdUjPdGKT
        map+zw8tyYckctoSNzHU+RrN+gK2imLd+YiBRXo=
X-Google-Smtp-Source: APXvYqw/84za4ZDlLy2/xrONZkNxmyNLE8qxggABKrVdIJVmZgqLu3hLxS7GqQFtUlmyMRJBXbj2RlWBwkU2EA2vBUc=
X-Received: by 2002:a24:b34f:: with SMTP id z15mr1417610iti.97.1552556652374;
 Thu, 14 Mar 2019 02:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <1551421452-5385-1-git-send-email-laoar.shao@gmail.com> <1551421452-5385-2-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1551421452-5385-2-git-send-email-laoar.shao@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Mar 2019 17:43:36 +0800
Message-ID: <CALOAHbCf-HU4NJ3hp9Cozuy03aVqbOpzNi7+QWNU0AC1Q2tOMA@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: drop may_writepage and classzone_idx from
 direct reclaim begin template
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 2:24 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> There are three tracepoints using this template, which are
> mm_vmscan_direct_reclaim_begin,
> mm_vmscan_memcg_reclaim_begin,
> mm_vmscan_memcg_softlimit_reclaim_begin.
>
> Regarding mm_vmscan_direct_reclaim_begin,
> sc.may_writepage is !laptop_mode, that's a static setting, and
> reclaim_idx is derived from gfp_mask which is already show in this
> tracepoint.
>
> Regarding mm_vmscan_memcg_reclaim_begin,
> may_writepage is !laptop_mode too, and reclaim_idx is (MAX_NR_ZONES-1),
> which are both static value.
>
> mm_vmscan_memcg_softlimit_reclaim_begin is the same with
> mm_vmscan_memcg_reclaim_begin.
>
> So we can drop them all.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/trace/events/vmscan.h | 26 ++++++++++----------------
>  mm/vmscan.c                   | 14 +++-----------
>  2 files changed, 13 insertions(+), 27 deletions(-)
>
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index a1cb913..153d90c 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -105,51 +105,45 @@
>
>  DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
>
> -       TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
> +       TP_PROTO(int order, gfp_t gfp_flags),
>
> -       TP_ARGS(order, may_writepage, gfp_flags, classzone_idx),
> +       TP_ARGS(order, gfp_flags),
>
>         TP_STRUCT__entry(
>                 __field(        int,    order           )
> -               __field(        int,    may_writepage   )
>                 __field(        gfp_t,  gfp_flags       )
> -               __field(        int,    classzone_idx   )
>         ),
>
>         TP_fast_assign(
>                 __entry->order          = order;
> -               __entry->may_writepage  = may_writepage;
>                 __entry->gfp_flags      = gfp_flags;
> -               __entry->classzone_idx  = classzone_idx;
>         ),
>
> -       TP_printk("order=%d may_writepage=%d gfp_flags=%s classzone_idx=%d",
> +       TP_printk("order=%d gfp_flags=%s",
>                 __entry->order,
> -               __entry->may_writepage,
> -               show_gfp_flags(__entry->gfp_flags),
> -               __entry->classzone_idx)
> +               show_gfp_flags(__entry->gfp_flags))
>  );
>
>  DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_begin,
>
> -       TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
> +       TP_PROTO(int order, gfp_t gfp_flags),
>
> -       TP_ARGS(order, may_writepage, gfp_flags, classzone_idx)
> +       TP_ARGS(order, gfp_flags)
>  );
>
>  #ifdef CONFIG_MEMCG
>  DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
>
> -       TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
> +       TP_PROTO(int order, gfp_t gfp_flags),
>
> -       TP_ARGS(order, may_writepage, gfp_flags, classzone_idx)
> +       TP_ARGS(order, gfp_flags)
>  );
>
>  DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_softlimit_reclaim_begin,
>
> -       TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
> +       TP_PROTO(int order, gfp_t gfp_flags),
>
> -       TP_ARGS(order, may_writepage, gfp_flags, classzone_idx)
> +       TP_ARGS(order, gfp_flags)
>  );
>  #endif /* CONFIG_MEMCG */
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ac4806f..cdc0305 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3304,10 +3304,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>         if (throttle_direct_reclaim(sc.gfp_mask, zonelist, nodemask))
>                 return 1;
>
> -       trace_mm_vmscan_direct_reclaim_begin(order,
> -                               sc.may_writepage,
> -                               sc.gfp_mask,
> -                               sc.reclaim_idx);
> +       trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
>
>         nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>
> @@ -3338,9 +3335,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>                         (GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK);
>
>         trace_mm_vmscan_memcg_softlimit_reclaim_begin(sc.order,
> -                                                     sc.may_writepage,
> -                                                     sc.gfp_mask,
> -                                                     sc.reclaim_idx);
> +                                                     sc.gfp_mask);
>
>         /*
>          * NOTE: Although we can get the priority field, using it
> @@ -3389,10 +3384,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>
>         zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];
>
> -       trace_mm_vmscan_memcg_reclaim_begin(0,
> -                                           sc.may_writepage,
> -                                           sc.gfp_mask,
> -                                           sc.reclaim_idx);
> +       trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
>
>         psi_memstall_enter(&pflags);
>         noreclaim_flag = memalloc_noreclaim_save();
> --
> 1.8.3.1
>

Hi Vlastimil, Michal,

Any comments on this patch ?

Thanks
Yafang
