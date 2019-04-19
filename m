Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C53C282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F00B208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TN+lD0Yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfDSVOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:14:42 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38827 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfDSVOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:14:41 -0400
Received: by mail-yb1-f195.google.com with SMTP id w206so2436498ybg.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ep33f62HX3AzUBDcVwFjTp0Z/qGrzWSSxgy6irC3Dwc=;
        b=TN+lD0YxK8/Z39tQFNeng7o7MdFoxCJhCMdqBA3VkWcQCiVs/XYz7qebhQCkvh98UL
         QYtk4dk9C4miikKW7ebUyVThbhx3xOBfed7dosNc80MVG1HOVIEDJwbCgFx4BBOxXmuZ
         9BJC9skhYCCPRcDFlVoAk1wWJi5QPd3x7bV9nZrQOdhbYWEdfxh+qFEzSbhjh2zcF+Qk
         nEUxMY1lIEric7Sr22cPqLby1FKEYg8H2b/hKJaehzG2Bhsi5DI8SaX8kUlMXuKmwFZp
         2fucI4cAXY9cXKu/jqmNdiuJqUHmBHXRYYAbiFf+Wwhsg2U7d7P+0QNi3h2mwT28yPuy
         9j6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ep33f62HX3AzUBDcVwFjTp0Z/qGrzWSSxgy6irC3Dwc=;
        b=UKiatOk8Lxl8OAqOF71UV3G7Z0f+HS80il6/Wo4L5GOShD58YjoFQjc5qK6tDXfz9G
         7+kC8A76h8wmFP1GcKFUHCsAx3aVA7aqp4T2GD4Ofg9gWfleomN/2bLkBvDcjsdy7xaS
         b7mmv3hmRzE5zLh68XqvUSJCiNHtDiVYwMA629q7ugflYEifQqyYv6zJWDtl65Ze7S80
         0rCzfR1QrT0yumaOHXTWDuKDHWTUzYSKG6r4G65qYKVfRMn0XBd6Glu/WRcUyc8PnthE
         RzYBw+0t3o8zBuqDG8Fns+WZL/fUb5opI3nwIrEEpcj+Nz7Xo893CIs9qiMIf+zL6N2X
         Ik7w==
X-Gm-Message-State: APjAAAXw2HWVwiyvhz4v6O7AdVApyPwdGkWCTVCGdP0RmiclP4cxgJEx
        PtpYMBXXo6308zOM+pkqN8dpBpsx+h4UG/H9Ca/IVw==
X-Google-Smtp-Source: APXvYqwP8W9joct14TvJoGQu1QeSZbbs3jHQ7fURiorHFky435pvPWJhgSP+s96y780vcjdoFGt8mEO4Ajd7ZHl7V9g=
X-Received: by 2002:a25:4147:: with SMTP id o68mr5056203yba.148.1555708480546;
 Fri, 19 Apr 2019 14:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190418214224.61900-1-shakeelb@google.com> <20190419200733.GB31878@tower.DHCP.thefacebook.com>
In-Reply-To: <20190419200733.GB31878@tower.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Apr 2019 14:14:29 -0700
Message-ID: <CALvZod4N7XJ5Zxd-0pO0_tpnnmGHyY=6PMVcvCg49virdp=6SA@mail.gmail.com>
Subject: Re: [PATCH] memcg: refill_stock for kmem uncharging too
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 1:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Apr 18, 2019 at 02:42:24PM -0700, Shakeel Butt wrote:
> > The commit 475d0487a2ad ("mm: memcontrol: use per-cpu stocks for socket
> > memory uncharging") added refill_stock() for skmem uncharging path to
> > optimize workloads having high network traffic. Do the same for the kmem
> > uncharging as well. However bypass the refill for offlined memcgs to not
> > cause zombie apocalypse.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> Hello, Shakeel!
>
> > ---
> >  mm/memcontrol.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 2535e54e7989..7b8de091f572 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -178,6 +178,7 @@ struct mem_cgroup_event {
> >
> >  static void mem_cgroup_threshold(struct mem_cgroup *memcg);
> >  static void mem_cgroup_oom_notify(struct mem_cgroup *memcg);
> > +static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages);
> >
> >  /* Stuffs for move charges at task migration. */
> >  /*
> > @@ -2097,10 +2098,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
> >       struct mem_cgroup *old = stock->cached;
> >
> >       if (stock->nr_pages) {
> > -             page_counter_uncharge(&old->memory, stock->nr_pages);
> > -             if (do_memsw_account())
> > -                     page_counter_uncharge(&old->memsw, stock->nr_pages);
> > -             css_put_many(&old->css, stock->nr_pages);
> > +             cancel_charge(old, stock->nr_pages);
> >               stock->nr_pages = 0;
> >       }
> >       stock->cached = NULL;
> > @@ -2133,6 +2131,11 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> >       struct memcg_stock_pcp *stock;
> >       unsigned long flags;
> >
> > +     if (unlikely(!mem_cgroup_online(memcg))) {
> > +             cancel_charge(memcg, nr_pages);
> > +             return;
> > +     }
>
> I'm slightly concerned about this part. Do we really need it?
> The number of "zombies" which we can pin is limited by the number of CPUs,
> and it will drop fast if there is any load on the machine.
>
> If we skip offline memcgs, it can slow down charging/uncharging of skmem,
> which might be a problem, if the socket is in active use by an other cgroup.
> Honestly, I'd drop this part.
>

Sure, I will wait for comments from others and then send the v2 without this.

Shakeel
