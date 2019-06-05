Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7766CC28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 04:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC3F2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 04:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6etWU3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfFEEfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 00:35:15 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33803 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfFEEfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 00:35:14 -0400
Received: by mail-yb1-f195.google.com with SMTP id x32so6304037ybh.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 21:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EiZjBZHC5Luc27kYIuZtZXOYiqvfneCugvkG3Zxzj+0=;
        b=l6etWU3hoAIzk502NCLzqzCwueHjUuAnf/eR/wuiZbG2FPIk0eHDh2w2W5nSiNQHEq
         yUf6WkAw/xmU45plNLxfP6qOhMt0ugZl9MoJ8xIDlaCWNsHoct8OGKM/PKs61uNe3pPZ
         aIscz2/I4HZncJ6NXVBtM0ugZJlklYIwDqHhbISCJNKhl0MNuXwsRXEQbntjyqDTFqd0
         Lk8t0r90YIAdrU2QKZzfq0ofEgZnHL22HS/F2/jiThl65tNXqWA69ZpWgKUW+PUUDna2
         ExMgFaz75HDTB0wHox6aUC5wAp8HAFCKs/DTCOZRynpNNf6VylThXCEwBBXdNvFIgtgZ
         QkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiZjBZHC5Luc27kYIuZtZXOYiqvfneCugvkG3Zxzj+0=;
        b=Xhz6lqAh3m90jp0MpPpxH0SqINhD5Gib6EPxh9/aBcOFCSt8xDefnhwy8Bnh7dy0lh
         71I/l3edI/fXGpFD2NmSCBDu36HrknVJ4ge9aw0FQf9udX1f5iRw63uATSfWSlaWMfK/
         jJKFzyvpp5dagQ/hcRH3WZqnRExlc3op+n/mlWNp+CO5k2Jv4mfkxFIFl1Q91dsoGWMX
         T2izOIxgpobTDjvIfX4w1uFbA3SJvjjcP16oflrAlpQGJXGDa0OrCbCZOMBmkaDElDAZ
         64EzPTIQaesEUzCJ5XVK+RK/F91lBs31Bo9bx4Cc8U4gSW0ZBmumLpzpLIUna1oV04CJ
         cI/g==
X-Gm-Message-State: APjAAAUeb1YFajRuKyExklnp9DBHYd1asp7XfjM2XwZ4Rah0f0OU2gav
        mPLY7lCGrGVtpRurspaucI0ouahpT0ZzmNvy752ibQ==
X-Google-Smtp-Source: APXvYqwYEsTxKXLhDDZZLM7bg5/6GEAiuuqGq8PUklt7d0KxCckL9NGG4Q/b5VxneyZkVXRh6FDzTj9EDbju++v3JZk=
X-Received: by 2002:a25:943:: with SMTP id u3mr17294262ybm.293.1559709313724;
 Tue, 04 Jun 2019 21:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190605024454.1393507-1-guro@fb.com> <20190605024454.1393507-2-guro@fb.com>
In-Reply-To: <20190605024454.1393507-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 Jun 2019 21:35:02 -0700
Message-ID: <CALvZod4F4FqO27Y+msXrxT9yaDLLN7njmBsRoTkmQSPE_7=FtQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] mm: add missing smp read barrier on getting
 memcg kmem_cache pointer
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 7:45 PM Roman Gushchin <guro@fb.com> wrote:
>
> Johannes noticed that reading the memcg kmem_cache pointer in
> cache_from_memcg_idx() is performed using READ_ONCE() macro,
> which doesn't implement a SMP barrier, which is required
> by the logic.
>
> Add a proper smp_rmb() to be paired with smp_wmb() in
> memcg_create_kmem_cache().
>
> The same applies to memcg_create_kmem_cache() itself,
> which reads the same value without barriers and READ_ONCE().
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

This seems like independent to the series. Shouldn't this be Cc'ed stable?

> ---
>  mm/slab.h        | 1 +
>  mm/slab_common.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 739099af6cbb..1176b61bb8fc 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -260,6 +260,7 @@ cache_from_memcg_idx(struct kmem_cache *s, int idx)
>          * memcg_caches issues a write barrier to match this (see
>          * memcg_create_kmem_cache()).
>          */
> +       smp_rmb();
>         cachep = READ_ONCE(arr->entries[idx]);
>         rcu_read_unlock();
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 58251ba63e4a..8092bdfc05d5 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -652,7 +652,8 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
>          * allocation (see memcg_kmem_get_cache()), several threads can try to
>          * create the same cache, but only one of them may succeed.
>          */
> -       if (arr->entries[idx])
> +       smp_rmb();
> +       if (READ_ONCE(arr->entries[idx]))
>                 goto out_unlock;
>
>         cgroup_name(css->cgroup, memcg_name_buf, sizeof(memcg_name_buf));
> --
> 2.20.1
>
