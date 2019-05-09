Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4CFC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24663217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQJMF1J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfEIQGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:06:13 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41559 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfEIQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:06:12 -0400
Received: by mail-yw1-f65.google.com with SMTP id o65so2282602ywd.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bZRaBuaJVzOagPgAxGnwl37KeIxRpAUuki7qHiwS7w=;
        b=lQJMF1J3Hq9E2jyZLMr011Qppcx+H+511s6SILzdH2F5jrBYvd7nkNxUY1FX0ESHU7
         EgKbptxzbUfCTPygnZGyReLUb6p9aZ5h7qv0WnVnKliRI4f8Lurl9Ge0Vs/nEGhf/jko
         JbCaUPv2yMdy3be/pvaZJp7d9vfwtZ5/67SB5faK9ry2CYsF92ymF5Dq6lJLWefmso/h
         1D1bPpKvuwR5vDBgRn24Uo/XG2Ix49bJ+Kw+A9NggKf4vPZougpgmSRsEstw0q4KVhn6
         WCWdjAJfCFckonpFRaVdI99ABUANiwAVNrk3EwUJS/3kNJTH/mlTAc2Ln+sA8c/Ma63n
         5Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bZRaBuaJVzOagPgAxGnwl37KeIxRpAUuki7qHiwS7w=;
        b=hXtxd1W3/W7UOVD0ng3MaoGWlO9QyvRFE2c6Y1MWK1IZEBFHpX5k0x6aqK9+fvKSP3
         3eJ7Z9JJDxTx/ttrmzYxtlMq3j+SmE/PnH948m1TCA4JNrAkPqs8sKq5vhRo0l3zKOvU
         2DcVA+A1N1P52xkaM62vDSw3EF0+TuwRZGYXpuhNRs2NSlntR4O5qSmeBRcwGozBg7zj
         ujOjWlkGojtgpOdFvUe+weR5HeLiQsGAKMyPOGV8LxRyVER+eqNGtpNDf+4588HU3DSK
         ZnB69w3hmwHrrgOytjPO5lJCuBysYAnl3YYE6BYcW2yMe0In7yXN8JQH7VwaDs9McKhi
         7Iqg==
X-Gm-Message-State: APjAAAXhtVRFm/1ej0ZRNmh5Pjb+0Miwx9asWgCWat7qXn9toDt+6rEn
        oOOhbMLVr0yNnKvxWdANsdoB7bMhrEz4XAsZrCIYqw==
X-Google-Smtp-Source: APXvYqweZrD+zILYGdfGDFSodB430IV2ssIGLyfSySK91X9eI9OCm0enlDb2HZZMq2Dl6OiaG9Agp2/SSX2hbrTSMcs=
X-Received: by 2002:a25:6708:: with SMTP id b8mr2579929ybc.377.1557417970993;
 Thu, 09 May 2019 09:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <359d98e6-044a-7686-8522-bdd2489e9456@suse.cz> <20190429105939.11962-1-jslaby@suse.cz>
 <20190509122526.ck25wscwanooxa3t@esperanza>
In-Reply-To: <20190509122526.ck25wscwanooxa3t@esperanza>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 9 May 2019 09:05:59 -0700
Message-ID: <CALvZod5MseXtY_BTHegdqBphCein20ou=zbvYymBJ9_zTUdWmg@mail.gmail.com>
Subject: Re: [PATCH] memcg: make it work on sparse non-0-node systems
To:     Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 5:25 AM Vladimir Davydov <vdavydov.dev@gmail.com> wrote:
>
> On Mon, Apr 29, 2019 at 12:59:39PM +0200, Jiri Slaby wrote:
> > We have a single node system with node 0 disabled:
> >   Scanning NUMA topology in Northbridge 24
> >   Number of physical nodes 2
> >   Skipping disabled node 0
> >   Node 1 MemBase 0000000000000000 Limit 00000000fbff0000
> >   NODE_DATA(1) allocated [mem 0xfbfda000-0xfbfeffff]
> >
> > This causes crashes in memcg when system boots:
> >   BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> >   #PF error: [normal kernel read fault]
> > ...
> >   RIP: 0010:list_lru_add+0x94/0x170
> > ...
> >   Call Trace:
> >    d_lru_add+0x44/0x50
> >    dput.part.34+0xfc/0x110
> >    __fput+0x108/0x230
> >    task_work_run+0x9f/0xc0
> >    exit_to_usermode_loop+0xf5/0x100
> >
> > It is reproducible as far as 4.12. I did not try older kernels. You have
> > to have a new enough systemd, e.g. 241 (the reason is unknown -- was not
> > investigated). Cannot be reproduced with systemd 234.
> >
> > The system crashes because the size of lru array is never updated in
> > memcg_update_all_list_lrus and the reads are past the zero-sized array,
> > causing dereferences of random memory.
> >
> > The root cause are list_lru_memcg_aware checks in the list_lru code.
> > The test in list_lru_memcg_aware is broken: it assumes node 0 is always
> > present, but it is not true on some systems as can be seen above.
> >
> > So fix this by checking the first online node instead of node 0.
> >
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: <cgroups@vger.kernel.org>
> > Cc: <linux-mm@kvack.org>
> > Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> > ---
> >  mm/list_lru.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > index 0730bf8ff39f..7689910f1a91 100644
> > --- a/mm/list_lru.c
> > +++ b/mm/list_lru.c
> > @@ -37,11 +37,7 @@ static int lru_shrinker_id(struct list_lru *lru)
> >
> >  static inline bool list_lru_memcg_aware(struct list_lru *lru)
> >  {
> > -     /*
> > -      * This needs node 0 to be always present, even
> > -      * in the systems supporting sparse numa ids.
> > -      */
> > -     return !!lru->node[0].memcg_lrus;
> > +     return !!lru->node[first_online_node].memcg_lrus;
> >  }
> >
> >  static inline struct list_lru_one *
>
> Yep, I didn't expect node 0 could ever be unavailable, my bad.
> The patch looks fine to me:
>
> Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
>
> However, I tend to agree with Michal that (ab)using node[0].memcg_lrus
> to check if a list_lru is memcg aware looks confusing. I guess we could
> simply add a bool flag to list_lru instead. Something like this, may be:
>

I think the bool flag approach is much better. No assumption on the
node initialization.

If we go with bool approach then add

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index aa5efd9351eb..d5ceb2839a2d 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -54,6 +54,7 @@ struct list_lru {
>  #ifdef CONFIG_MEMCG_KMEM
>         struct list_head        list;
>         int                     shrinker_id;
> +       bool                    memcg_aware;
>  #endif
>  };
>
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 0730bf8ff39f..8e605e40a4c6 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -37,11 +37,7 @@ static int lru_shrinker_id(struct list_lru *lru)
>
>  static inline bool list_lru_memcg_aware(struct list_lru *lru)
>  {
> -       /*
> -        * This needs node 0 to be always present, even
> -        * in the systems supporting sparse numa ids.
> -        */
> -       return !!lru->node[0].memcg_lrus;
> +       return lru->memcg_aware;
>  }
>
>  static inline struct list_lru_one *
> @@ -451,6 +447,7 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
>  {
>         int i;
>
> +       lru->memcg_aware = memcg_aware;
>         if (!memcg_aware)
>                 return 0;
>
