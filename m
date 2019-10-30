Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1E2CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287AC2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wpso2Uet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfJ3Ukt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 16:40:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45140 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfJ3Ukt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 16:40:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id 41so3344913oti.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxhTNdcXi1iSw45vhfEhl1l1cZifBtpWm7YMx8V/F14=;
        b=Wpso2UetFVj77NjHviuT0FEGL2UuDhKUDp2LUKH5Cl81X0s/m4j69C4nk4zPjgZyEU
         spxnLSa5IaPaHPQiFb7ybHezMgAZE7/crJ4+STddhL9i4K1PVaD74ptW1nZuBB1Iclco
         h9uWXs0nq7574ny5w9crAS9EbFmHSWuaz/AZYfRObNSk0JZYTfhZBDogxXSAbSse9+MG
         4DO5BTPt3G1nM9Mcv/0eLa0dCHj9xn/oOvIxFRTYOTr3ITZBKwGWGCASDyaB+qr+cSfJ
         peQufOEY7xxazpql5HyYFrOw7PslZIPczo3z+VmsL1QgA09KSmpYqqwsV2gbuuHraFZK
         Hnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxhTNdcXi1iSw45vhfEhl1l1cZifBtpWm7YMx8V/F14=;
        b=X2ZqlMDX03+2DcEGp5Cn+SoLMCQEv7LozhekHfRa6vRHvGc0xBnlj6HvtC6GDCJRhu
         EiLe0m2ejfBqsqYbvcXOTbByI6lPDYSiB2NDYwU3slBIE8chvp7eE2SzBMrMIfFpY9C0
         XP8x9lk0+zK7UssEZSegi52ktO4HVSOVM1uLuz35l00CA+EYQhmtagQH7zBCKBiz42GE
         R9x4VLsf7+82AOrjhb05ZRm+pVIC1YmfAeOgnNZTRYRhgqCfC4i6VMIlfiNGIrt6FkAS
         SNIV2KmRRL5wXudt1CDQGYjbrzfAu59BGP4Y7LfztAhJk8s4p8O2jME/9TVXgB15e1+X
         w2Gg==
X-Gm-Message-State: APjAAAWkBB77C8PMPMYl25xoAJM6usFD7nsqyuer2UHLjy8BRqJP9qwm
        JSwzeeqmtD66mpWKgmIMHGMb9uFWIDc6heOKISe81Q==
X-Google-Smtp-Source: APXvYqycOyKPScktzrGCfVEovcqq7O+1VV0i/yWjURxuY0dKAyi5wxsuzlNaxT1bGJCEGODLaJcnzyEwQWlpE0WsUeo=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr1527700oti.191.1572468048210;
 Wed, 30 Oct 2019 13:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191025232710.4081957-1-guro@fb.com>
In-Reply-To: <20191025232710.4081957-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 30 Oct 2019 13:40:36 -0700
Message-ID: <CALvZod53EboWVN_fGOwKKmfARX7SNxciLkVo-jLPUn6pj=f3vw@mail.gmail.com>
Subject: Re: [PATCH] mm: slab: make page_cgroup_ino() to recognize
 non-compound slab pages properly
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 4:28 PM Roman Gushchin <guro@fb.com> wrote:
>
> page_cgroup_ino() doesn't return a valid memcg pointer for non-compund

non-compound

> slab pages, because it depends on PgHead AND PgSlab flags to be set
> to determine the memory cgroup from the kmem_cache.
> It's correct for compound pages, but not for generic small pages. Those
> don't have PgHead set, so it ends up returning zero.
>
> Fix this by replacing the condition to PageSlab() && !PageTail().
>
> Before this patch:
> [root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.slice/user@0.service/ | grep slab
> 0x0000000000000080              38        0  _______S___________________________________        slab
>
> After this patch:
> [root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.slice/user@0.service/ | grep slab
> 0x0000000000000080             147        0  _______S___________________________________        slab
>
> Fixes: 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup pointer for slab pages")
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ea085877c548..00b4188b1bed 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -476,7 +476,7 @@ ino_t page_cgroup_ino(struct page *page)
>         unsigned long ino = 0;
>
>         rcu_read_lock();
> -       if (PageHead(page) && PageSlab(page))
> +       if (PageSlab(page) && !PageTail(page))
>                 memcg = memcg_from_slab_page(page);
>         else
>                 memcg = READ_ONCE(page->mem_cgroup);
> --
> 2.17.1
>
