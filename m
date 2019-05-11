Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2E1C04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 00:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5816217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 00:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/7AW9ND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfEKAdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 20:33:23 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45275 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfEKAdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 20:33:23 -0400
Received: by mail-yw1-f67.google.com with SMTP id w18so6097902ywa.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 17:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgSVfGODZNyEEQFjqirGNZR/8hnjEjcwoRyIzV62s/U=;
        b=j/7AW9ND/YCb7fpUlCIDu4CtWdaw+gNTEb78YjW42tti4DswHvmdv1fY/gad+Gof/S
         2fqgvpZh/3xg9lmvW05tWTyiMqY2v8WnbZfYnssAZHbwgVjL+jOs/rZFKhEnenFyB2yc
         EJ7HXgw6W38QUAkiBqABojxJ7MmmBj2K8BRP0LYmXvLycqiGDta26173/MSOtoyWhgV0
         oUGcrZRVVkUUk6zIVRTPJNuc2mp0lduQlMPk17IujjMLuipV518yH9q0ieS4q/sd1Tq9
         XEXksvzQ2RnJUPvzI4NKRtae7kbccTDP8QyAq8EaJ8rCO/aoTSXyUiBtYazqeZ8XK1nI
         bzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgSVfGODZNyEEQFjqirGNZR/8hnjEjcwoRyIzV62s/U=;
        b=pjYZAh6UW+iSYfYMI+u+b40GPHqb9/N39UK/0R+y15095+FYI21VFGkknWvo7a0M9R
         9P1B+T6k2x/ogdLw7YKu7x8WLT+1Ad9xz1iBff0Fh1upzyp3Ic38qBAVV52Is2VsvfTb
         xHG/PR8vqMeg9sAz9r9z5o3zMWhHycf9HwgrRGbw4JfzloFVwTMfH9zkq536KKtjYNIR
         ju1kbg6CIRCfkw2JVkqNzLXi//e/1ErRg86JzQrz8pTVdakwVMydGrp75wjbc5YDfb8S
         XKQ19caNKV3xI5/0MsUg4jBlz79bDyhSSlvkU5VfYs4mDZ1umMbca+QjdFnko4UOHw+Q
         reAQ==
X-Gm-Message-State: APjAAAWcyeB50d6Nm6yv3QeELxXaaWACIIxGcxCQOQCaAmq3HLDMZro6
        ZB8jjEHvTlZDJDC9YAK60fhUI1mF2AxNM+LU88osYw==
X-Google-Smtp-Source: APXvYqxU2FO4D03Bonf/ZZELd4cfkZT2F6rpo69EGUgTyzSwY6vPlPXacS+XvNL9OVjozme5Yqz/cp9a0cwLEM3xGGU=
X-Received: by 2002:a25:a2c1:: with SMTP id c1mr6893225ybn.496.1557534801871;
 Fri, 10 May 2019 17:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190508202458.550808-1-guro@fb.com> <20190508202458.550808-4-guro@fb.com>
In-Reply-To: <20190508202458.550808-4-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 May 2019 17:33:10 -0700
Message-ID: <CALvZod4nvTnxvb2UKxvRiYMH9NRcuhat5FwvPDOFMCzZ+aeLxQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm: introduce __memcg_kmem_uncharge_memcg()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>
Date: Wed, May 8, 2019 at 1:30 PM
To: Andrew Morton, Shakeel Butt
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
<kernel-team@fb.com>, Johannes Weiner, Michal Hocko, Rik van Riel,
Christoph Lameter, Vladimir Davydov, <cgroups@vger.kernel.org>, Roman
Gushchin

> Let's separate the page counter modification code out of
> __memcg_kmem_uncharge() in a way similar to what
> __memcg_kmem_charge() and __memcg_kmem_charge_memcg() work.
>
> This will allow to reuse this code later using a new
> memcg_kmem_uncharge_memcg() wrapper, which calls
> __memcg_kmem_unchare_memcg() if memcg_kmem_enabled()

__memcg_kmem_uncharge_memcg()

> check is passed.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  include/linux/memcontrol.h | 10 ++++++++++
>  mm/memcontrol.c            | 25 +++++++++++++++++--------
>  2 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 36bdfe8e5965..deb209510902 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1298,6 +1298,8 @@ int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
>  void __memcg_kmem_uncharge(struct page *page, int order);
>  int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
>                               struct mem_cgroup *memcg);
> +void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
> +                                unsigned int nr_pages);
>
>  extern struct static_key_false memcg_kmem_enabled_key;
>  extern struct workqueue_struct *memcg_kmem_cache_wq;
> @@ -1339,6 +1341,14 @@ static inline int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp,
>                 return __memcg_kmem_charge_memcg(page, gfp, order, memcg);
>         return 0;
>  }
> +
> +static inline void memcg_kmem_uncharge_memcg(struct page *page, int order,
> +                                            struct mem_cgroup *memcg)
> +{
> +       if (memcg_kmem_enabled())
> +               __memcg_kmem_uncharge_memcg(memcg, 1 << order);
> +}
> +
>  /*
>   * helper for accessing a memcg's index. It will be used as an index in the
>   * child cache array in kmem_cache, and also to derive its name. This function
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 48a8f1c35176..b2c39f187cbb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2750,6 +2750,22 @@ int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
>         css_put(&memcg->css);
>         return ret;
>  }
> +
> +/**
> + * __memcg_kmem_uncharge_memcg: uncharge a kmem page
> + * @memcg: memcg to uncharge
> + * @nr_pages: number of pages to uncharge
> + */
> +void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
> +                                unsigned int nr_pages)
> +{
> +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +               page_counter_uncharge(&memcg->kmem, nr_pages);
> +
> +       page_counter_uncharge(&memcg->memory, nr_pages);
> +       if (do_memsw_account())
> +               page_counter_uncharge(&memcg->memsw, nr_pages);
> +}
>  /**
>   * __memcg_kmem_uncharge: uncharge a kmem page
>   * @page: page to uncharge
> @@ -2764,14 +2780,7 @@ void __memcg_kmem_uncharge(struct page *page, int order)
>                 return;
>
>         VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
> -
> -       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> -               page_counter_uncharge(&memcg->kmem, nr_pages);
> -
> -       page_counter_uncharge(&memcg->memory, nr_pages);
> -       if (do_memsw_account())
> -               page_counter_uncharge(&memcg->memsw, nr_pages);
> -
> +       __memcg_kmem_uncharge_memcg(memcg, nr_pages);
>         page->mem_cgroup = NULL;
>
>         /* slab pages do not have PageKmemcg flag set */
> --
> 2.20.1
>
