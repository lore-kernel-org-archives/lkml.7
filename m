Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E024C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0200620854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd/lj9oL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfCNKoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:44:22 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33788 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfCNKoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:44:22 -0400
Received: by mail-it1-f194.google.com with SMTP id f186so7478426ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qd8n3KqbDahoPwCZIcSO29r3/qbS//0/Sc4AHCuc2OA=;
        b=cd/lj9oLnlnFZtNouHHalTbuFniLYV5Qji+yNGwBxL7Qa2yMXRBYYpJtbMf1TLG1aO
         IwS13cvtko4rV1IjGpftQ0GkqOHurddGkGrpSzWMTuRg9YqOsEDpE0H0YNtg8t4v26Zv
         mPJwZ2xRjLUj73DaX0T84XAhQ4fVGOSwpgKvPobeLnV4WG3r0YAoZGASKJicfSaIF3Gi
         9eL5XjQsLUjEihVdVkyx+UEi2qwn1MgGLKwLpOQwPNFZAhcprFHNB62Xw3vxwqjpxAbF
         hP1aI61EdhP3zQ7JuMNTjfpKHXt538V9jppV2VY3wl0Gd6P1ftrt0X22PcRymRU2M8SJ
         X8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qd8n3KqbDahoPwCZIcSO29r3/qbS//0/Sc4AHCuc2OA=;
        b=W5uPMNXJOIKtMgJsrXg/ivUJIql/2qCgdCUwO0AcS4lTf4mOcymR4X1ONJUYMSP2zK
         pz1Z28Q1zwsArOGJnrNKlvmxSHHn/EkDCzmpnJHVYrj02OefTkD1DpnBjKghzHVtxjNJ
         WSlICi+qBtGdiO4HbIiW1PqNKfhmiK2hb+Tezbl3EM38Yi7T+Lm71wa+B/LYg7VU8RS/
         wr9Td/F6UWfI5coB1tuCdeXQz+z8lw9R5xIF8qZUm+g4wf1DLh4FqepANVlPLcNSr2Kq
         C/8MZ3sEvQUwhfSsKgvuoOuLBkmymCY/pP+SeA0MgnjMsHgMFclj6PWxEYm4655CMIWE
         rWBA==
X-Gm-Message-State: APjAAAU4HHC0W4pCs941/J9amnU310hLIp6TOGCl/mBtMI/zBxAXebUc
        cQeVlR4rAwjs20dsEKBab619LVubsR3euZcLWDo=
X-Google-Smtp-Source: APXvYqwTZ2icNGbQbSX9V2gpjOJMOh3gHL8RUUHTBbZgmkW7UUxUjnRP77DQXawmmoMxdJ/jxOWWhU4yRpZ6YrbHsdc=
X-Received: by 2002:a24:b34f:: with SMTP id z15mr1543254iti.97.1552560260894;
 Thu, 14 Mar 2019 03:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <1551421452-5385-1-git-send-email-laoar.shao@gmail.com>
 <1551421452-5385-2-git-send-email-laoar.shao@gmail.com> <20190314101915.GI7473@dhcp22.suse.cz>
In-Reply-To: <20190314101915.GI7473@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Mar 2019 18:43:44 +0800
Message-ID: <CALOAHbAuGLe_Cw+xChmM3=cuhdis3=LwaT1yRoH72zmg+uhUTw@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: drop may_writepage and classzone_idx from
 direct reclaim begin template
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 6:19 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 01-03-19 14:24:12, Yafang Shao wrote:
> > There are three tracepoints using this template, which are
> > mm_vmscan_direct_reclaim_begin,
> > mm_vmscan_memcg_reclaim_begin,
> > mm_vmscan_memcg_softlimit_reclaim_begin.
> >
> > Regarding mm_vmscan_direct_reclaim_begin,
> > sc.may_writepage is !laptop_mode, that's a static setting, and
> > reclaim_idx is derived from gfp_mask which is already show in this
> > tracepoint.
> >
> > Regarding mm_vmscan_memcg_reclaim_begin,
> > may_writepage is !laptop_mode too, and reclaim_idx is (MAX_NR_ZONES-1),
> > which are both static value.
> >
> > mm_vmscan_memcg_softlimit_reclaim_begin is the same with
> > mm_vmscan_memcg_reclaim_begin.
> >
> > So we can drop them all.
>
> I agree. Although classzone_idx is PITA to calculate nothing really
> prevents us to have a tool to do that. may_writepage is not all that
> useful anymore.
>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> From a quick glance this looks ok. I haven't really checked deeply or
> tried to compile it but the change makes sense.
>

Thanks for your quick response!
This patch works fine, I have verified it.

> Acked-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  include/trace/events/vmscan.h | 26 ++++++++++----------------
> >  mm/vmscan.c                   | 14 +++-----------
> >  2 files changed, 13 insertions(+), 27 deletions(-)
> >
> > diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> > index a1cb913..153d90c 100644
> > --- a/include/trace/events/vmscan.h
> > +++ b/include/trace/events/vmscan.h
> > @@ -105,51 +105,45 @@
> >
> >  DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
> >
> > -     TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
> > +     TP_PROTO(int order, gfp_t gfp_flags),
> >
> > -     TP_ARGS(order, may_writepage, gfp_flags, classzone_idx),
> > +     TP_ARGS(order, gfp_flags),
> >
> >       TP_STRUCT__entry(
> >               __field(        int,    order           )
> > -             __field(        int,    may_writepage   )
> >               __field(        gfp_t,  gfp_flags       )
> > -             __field(        int,    classzone_idx   )
> >       ),
> >
> >       TP_fast_assign(
> >               __entry->order          = order;
> > -             __entry->may_writepage  = may_writepage;
> >               __entry->gfp_flags      = gfp_flags;
> > -             __entry->classzone_idx  = classzone_idx;
> >       ),
> >
> > -     TP_printk("order=%d may_writepage=%d gfp_flags=%s classzone_idx=%d",
> > +     TP_printk("order=%d gfp_flags=%s",
> >               __entry->order,
> > -             __entry->may_writepage,
> > -             show_gfp_flags(__entry->gfp_flags),
> > -             __entry->classzone_idx)
> > +             show_gfp_flags(__entry->gfp_flags))
> >  );
> >
> >  DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_begin,
> >
> > -     TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
> > +     TP_PROTO(int order, gfp_t gfp_flags),
> >
> > -     TP_ARGS(order, may_writepage, gfp_flags, classzone_idx)
> > +     TP_ARGS(order, gfp_flags)
> >  );
> >
> >  #ifdef CONFIG_MEMCG
> >  DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
> >
> > -     TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
> > +     TP_PROTO(int order, gfp_t gfp_flags),
> >
> > -     TP_ARGS(order, may_writepage, gfp_flags, classzone_idx)
> > +     TP_ARGS(order, gfp_flags)
> >  );
> >
> >  DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_softlimit_reclaim_begin,
> >
> > -     TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
> > +     TP_PROTO(int order, gfp_t gfp_flags),
> >
> > -     TP_ARGS(order, may_writepage, gfp_flags, classzone_idx)
> > +     TP_ARGS(order, gfp_flags)
> >  );
> >  #endif /* CONFIG_MEMCG */
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index ac4806f..cdc0305 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3304,10 +3304,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> >       if (throttle_direct_reclaim(sc.gfp_mask, zonelist, nodemask))
> >               return 1;
> >
> > -     trace_mm_vmscan_direct_reclaim_begin(order,
> > -                             sc.may_writepage,
> > -                             sc.gfp_mask,
> > -                             sc.reclaim_idx);
> > +     trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
> >
> >       nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
> >
> > @@ -3338,9 +3335,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
> >                       (GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK);
> >
> >       trace_mm_vmscan_memcg_softlimit_reclaim_begin(sc.order,
> > -                                                   sc.may_writepage,
> > -                                                   sc.gfp_mask,
> > -                                                   sc.reclaim_idx);
> > +                                                   sc.gfp_mask);
> >
> >       /*
> >        * NOTE: Although we can get the priority field, using it
> > @@ -3389,10 +3384,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> >
> >       zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];
> >
> > -     trace_mm_vmscan_memcg_reclaim_begin(0,
> > -                                         sc.may_writepage,
> > -                                         sc.gfp_mask,
> > -                                         sc.reclaim_idx);
> > +     trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
> >
> >       psi_memstall_enter(&pflags);
> >       noreclaim_flag = memalloc_noreclaim_save();
> > --
> > 1.8.3.1
> >
>
> --
> Michal Hocko
> SUSE Labs
