Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0650C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB1A217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KV6HAxQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbfGQSCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 14:02:37 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43504 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfGQSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 14:02:37 -0400
Received: by mail-yw1-f65.google.com with SMTP id n205so11062555ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDzRsEyxIuuSai2DRMs+IGwIO+YipV0U+XFpyiaB7ek=;
        b=KV6HAxQGdn6bho66u6GdESZdwwdD5tjW0fDv1ZWRFWmhV9jQO5H7q5tBN4YlahuMN8
         xHlxAttU7druDTETF9Oi1KMdYnaRSqBOoIn64k5cuiuYGQ4v+oGTISwXQraV6l5MxKnI
         /pXA0Z9KuUVxOjF1INofKw1JWFWI5GKL38xdnoah2mPGzZqrDlZuiPgsshkxn9SkE9RD
         4/C90o3L6ZPqIEBmWavIP7H2Mp3oautWncUe1weerJg8VfUv4DDUnoCeZp8rfQMjLfkU
         gDyKAi9AdYmM2rxLhZ3O2qlqNqvnSp+ODNOPhS3edwqcT+5bAxOtHefqfQAih6cPsWOx
         zMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDzRsEyxIuuSai2DRMs+IGwIO+YipV0U+XFpyiaB7ek=;
        b=WANQFAvX73aKXz/eXItD2gayitoglCmG9ANb9ylOxYGZhJYKztGs3CjZ6BMmrgEYto
         6WOe+Crfa++KjBe1fX0L/AxjOAdKA5H7FmCxF5RMLVmCxw3dak+OpgVC0N/1LbWZHeQ4
         Gs0+7V28z7b32OaiIbAbdJ3/HL3Sz3f2v0M6o3s6GmMPvkPYgjL0SNGvFJerFWh9V5Lb
         G1EtYdkUp74EDZQoEJSLSVVlaaWmxIP3HKWZdB5yJ0mmqt7JdWRVMTCLV7APyVvyCJtV
         8BufQiUV1abUv2BGywMBdQdjVeG6EwPZZPPwTp8TjIHxn3DSsRrGu4O/qcWbzJdT55CF
         T06A==
X-Gm-Message-State: APjAAAWdQtMG+cbpMcTU92/5zuGic0SWCV3chOVfBWnBFpwwvEzLbxMh
        s6gD4lWBPcmo/dwTI9b8ZJcS8F54hG5xnOYnRqU41A==
X-Google-Smtp-Source: APXvYqx8Dv3M/w0Y+tfgf5v5o8BgqNuNH2nvV6nFlb9tCRft8Hoq2fYaYtrbULzBbF+h70b2g7Pn/ZHWVRQWxxJXD1U=
X-Received: by 2002:a0d:c345:: with SMTP id f66mr23890145ywd.10.1563386555880;
 Wed, 17 Jul 2019 11:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <1563385526-20805-1-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1563385526-20805-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 17 Jul 2019 11:02:24 -0700
Message-ID: <CALvZod7CJ6W5RGRVzyc8J=dWgOHeHGFT+43NWGQjATvEqRjkMg@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: check if mem cgroup is disabled or not before
 calling memcg slab shrinker
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>, Hugh Dickins <hughd@google.com>,
        Qian Cai <cai@lca.pw>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 10:45 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> Shakeel Butt reported premature oom on kernel with
> "cgroup_disable=memory" since mem_cgroup_is_root() returns false even
> though memcg is actually NULL.  The drop_caches is also broken.
>
> It is because commit aeed1d325d42 ("mm/vmscan.c: generalize shrink_slab()
> calls in shrink_node()") removed the !memcg check before
> !mem_cgroup_is_root().  And, surprisingly root memcg is allocated even
> though memory cgroup is disabled by kernel boot parameter.
>
> Add mem_cgroup_disabled() check to make reclaimer work as expected.
>
> Fixes: aeed1d325d42 ("mm/vmscan.c: generalize shrink_slab() calls in shrink_node()")
> Reported-by: Shakeel Butt <shakeelb@google.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: stable@vger.kernel.org  4.19+
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/vmscan.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f8e3dcd..c10dc02 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -684,7 +684,14 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>         unsigned long ret, freed = 0;
>         struct shrinker *shrinker;
>
> -       if (!mem_cgroup_is_root(memcg))
> +       /*
> +        * The root memcg might be allocated even though memcg is disabled
> +        * via "cgroup_disable=memory" boot parameter.  This could make
> +        * mem_cgroup_is_root() return false, then just run memcg slab
> +        * shrink, but skip global shrink.  This may result in premature
> +        * oom.
> +        */
> +       if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>                 return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>
>         if (!down_read_trylock(&shrinker_rwsem))
> --
> 1.8.3.1
>
