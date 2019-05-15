Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384C1C04AB7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096242082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ii41x4BP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEOAQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:16:32 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45490 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfEOAQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:16:32 -0400
Received: by mail-yb1-f194.google.com with SMTP id v2so283064ybm.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 17:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6UubTu1HxL5JVqa4cIS4IiqN2UOsI0+Vavy5s5bkSQ=;
        b=Ii41x4BPQ69+lEiDQCtrEuc+lF56MxJAe2Nu9E3XbvbR4rUAzOZNAXuAlZRNS6P1H0
         g1yyCvGfKBvZs2+YsXBIRXAAt9TKkYkQT8esPIAPxIMrzkMFFDmkcCGxuibr51tDIoEf
         hOvtu0p5Qti7QFT1qMeD2cxKaHTYxfMIvR16MTXd+gcnStMT2TE8onV6SNVb465wsnXH
         wJp8kOMWTtX8IzL1/yOc8GesomdBPegBNpb3c6rVynA4KMxgNmF6NSTnPBOPUCewSG7b
         unooTfA0p8UWmIEaIJ3dtmy1DpodFr7a94oCGmib2FAfj7Xgdla1FlVXjyqxjZB9wq8E
         /Ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6UubTu1HxL5JVqa4cIS4IiqN2UOsI0+Vavy5s5bkSQ=;
        b=k8Bn1rUdSYKRtTHS4htyIsaPGi11mPHIXgEvG78aIIa5dCrp0b/6jfIIEnD2jai1br
         mrjoGDdGzy4ZABySxlDiTKVVUDMvCTDz44LKwai+w0K77MMU+7Sac3p2brFXGGKhjePo
         CrUg/44X9Q3Pl9Z5Tl1nG8m0MnWmk0lsZmj5JvuK8sUSDMPAhS7Ed96HkngZdPIsEbto
         Ozq90l8DiPVwhgsDREm3Hpxpzp56OleYCAuTd2tv7oZ7tBtk4DFmpzGKppeEF4gLC4uk
         hmiJbEKCS7ZPl0OmSkYQwQxZ28z0yEGbCFPK0dmN8mCI+Qf6uJZxCKZGRfcNK+v4gsHg
         fXwA==
X-Gm-Message-State: APjAAAVsCaoPW8vsVZemHUCy9dEenwwWK0UnEK8eiH+XbZCJWoBLtZbN
        2mxKgHyYOrSF76DeTh6sO/yO0f7+O+Dudwy6bMYCnA==
X-Google-Smtp-Source: APXvYqwXpG8BpCaAhxMLZu1bQsUf0ZlBvmb6V18GIGFeDsrDFmUXX3NvR6sEHYqBkd0VzopGg8Iw+LuwYseyH2LTLrI=
X-Received: by 2002:a25:ad11:: with SMTP id y17mr18143295ybi.393.1557879391180;
 Tue, 14 May 2019 17:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190514213940.2405198-1-guro@fb.com> <20190514213940.2405198-8-guro@fb.com>
In-Reply-To: <20190514213940.2405198-8-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 14 May 2019 17:16:19 -0700
Message-ID: <CALvZod5sPsvUCLS1Ud0sW=n+UoJb=DR5LbmMJKRhUeUoi+=64w@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] mm: fix /proc/kpagecgroup interface for slab pages
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
Date: Tue, May 14, 2019 at 2:54 PM
To: Andrew Morton, Shakeel Butt
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
<kernel-team@fb.com>, Johannes Weiner, Michal Hocko, Rik van Riel,
Christoph Lameter, Vladimir Davydov, <cgroups@vger.kernel.org>, Roman
Gushchin

> Switching to an indirect scheme of getting mem_cgroup pointer for
> !root slab pages broke /proc/kpagecgroup interface for them.
>
> Let's fix it by learning page_cgroup_ino() how to get memcg
> pointer for slab pages.
>
> Reported-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/memcontrol.c  |  5 ++++-
>  mm/slab.h        | 25 +++++++++++++++++++++++++
>  mm/slab_common.c |  1 +
>  3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0655639433ed..9b2413c2e9ea 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -494,7 +494,10 @@ ino_t page_cgroup_ino(struct page *page)
>         unsigned long ino = 0;
>
>         rcu_read_lock();
> -       memcg = READ_ONCE(page->mem_cgroup);
> +       if (PageHead(page) && PageSlab(page))
> +               memcg = memcg_from_slab_page(page);
> +       else
> +               memcg = READ_ONCE(page->mem_cgroup);
>         while (memcg && !(memcg->css.flags & CSS_ONLINE))
>                 memcg = parent_mem_cgroup(memcg);
>         if (memcg)
> diff --git a/mm/slab.h b/mm/slab.h
> index 7ba50e526d82..50fa534c0fc0 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -256,6 +256,26 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
>         return s->memcg_params.root_cache;
>  }
>
> +/*
> + * Expects a pointer to a slab page. Please note, that PageSlab() check
> + * isn't sufficient, as it returns true also for tail compound slab pages,
> + * which do not have slab_cache pointer set.
> + * So this function assumes that the page can pass PageHead() and PageSlab()
> + * checks.
> + */
> +static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
> +{
> +       struct kmem_cache *s;
> +
> +       WARN_ON_ONCE(!rcu_read_lock_held());
> +
> +       s = READ_ONCE(page->slab_cache);
> +       if (s && !is_root_cache(s))
> +               return rcu_dereference(s->memcg_params.memcg);
> +
> +       return NULL;
> +}
> +
>  /*
>   * Charge the slab page belonging to the non-root kmem_cache.
>   * Can be called for non-root kmem_caches only.
> @@ -353,6 +373,11 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
>         return s;
>  }
>
> +static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
> +{
> +       return NULL;
> +}
> +
>  static inline int memcg_charge_slab(struct page *page, gfp_t gfp, int order,
>                                     struct kmem_cache *s)
>  {
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 354762394162..9d2a3d6245dc 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -254,6 +254,7 @@ static void memcg_unlink_cache(struct kmem_cache *s)
>                 list_del(&s->memcg_params.kmem_caches_node);
>                 mem_cgroup_put(rcu_dereference_protected(s->memcg_params.memcg,
>                         lockdep_is_held(&slab_mutex)));
> +               rcu_assign_pointer(s->memcg_params.memcg, NULL);
>         }
>  }
>  #else
> --
> 2.20.1
>
