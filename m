Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46DEFC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8614F218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHGybIy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbfKGCvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:51:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35264 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733048AbfKGCvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:51:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id z6so728725otb.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 18:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKO7/fbdppvBINU5UzZk1jxJvjGwB3qbyKeLUMFG0WY=;
        b=lHGybIy/4+Wd5Xs4rFF43Igo7QNmIxIkOuOeO28hVod0YQrbdceC97gt53BQZ/IXhX
         5XUSf0vl69ZMl/BHL/QP2dXa5rAauS3uo4T33ETfaQHSlKrFGEKWmMkuA1mx95AcHix5
         x+/uzcZlA1JTfMck4Lia9FP9eTVtJHq8rJTe6Zd977QZlsYRi4cOhgWUCFGnv2iXZiyA
         1qfoMzmCQ3/yTKxORuIPubW5CpJM2JJczPR77EO8tyN+1q5X8jHiaB+vPpZ2r6SMTQNt
         f+gBkwqBIA7GiVBBHaRKE5Ooff8jHI6UtIccu7HdP9NybJy8Dp0ur2UrYxED2hpmKSPf
         PAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKO7/fbdppvBINU5UzZk1jxJvjGwB3qbyKeLUMFG0WY=;
        b=G/IiNykkFdbZc2RYL4pX2zgyfRwDdAyEMDg6387aMEM6ZW90pH9vA8ywcFn3J13sJi
         OZMQqdi8dYzLsdkDVjVGlmWybtMmylwma+XiPYykXd27xZL/OQd9NgxU92TCWE6rf1HG
         2nxkxiE1uT7iP/RmZ3VrpXnFkUFXdArw/4S6uNmpW3gQD5ufjlQnh0pxqBr24kTinPI+
         jo3kgkU8/Y3ve5MzSv5ONTb4w5ge78584ymvI7/HQofqXDW2EKbiwz70Z/qRyNdJDjSO
         XytKuYegsv28ZGfND5dKKV8T1pSfVvHR5xJeX909np8o5yOEG4Z0sBrVwKmNplNIC0+t
         YCgw==
X-Gm-Message-State: APjAAAWwsElpINWUf35umy/CZ5M+afv1oZGaJ6XCwbTdBfvWHS5u/TnC
        dGwLIhVRJqlzW5XRKfQIgExCAZtkDxEHqQe7oB2r9A==
X-Google-Smtp-Source: APXvYqzzv7HIbB64JiAktrqXuieu+Qi+ofExLaTWbbpI/vhljtRTUn8VDqOTsN6GKkLyWX6YVdkOZMePuaQRtZtspAA=
X-Received: by 2002:a9d:71cc:: with SMTP id z12mr840037otj.124.1573095073108;
 Wed, 06 Nov 2019 18:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20190603210746.15800-1-hannes@cmpxchg.org> <20190603210746.15800-4-hannes@cmpxchg.org>
In-Reply-To: <20190603210746.15800-4-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:51:02 -0800
Message-ID: <CALvZod5ac0fmfD+92kg8nu4zV31ow95DJmvsTp8Rh4Ff+FhcXg@mail.gmail.com>
Subject: Re: [PATCH 03/11] mm: vmscan: simplify lruvec_lru_size()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 2:59 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> This function currently takes the node or lruvec size and subtracts
> the zones that are excluded by the classzone index of the
> allocation. It uses four different types of counters to do this.
>
> Just add up the eligible zones.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I think this became part of other series. Anyways:

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  mm/vmscan.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 853be16ee5e2..69c4c82a9b5a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -342,30 +342,21 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
>   */
>  unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
>  {
> -       unsigned long lru_size;
> +       unsigned long size = 0;
>         int zid;
>
> -       if (!mem_cgroup_disabled())
> -               lru_size = lruvec_page_state_local(lruvec, NR_LRU_BASE + lru);
> -       else
> -               lru_size = node_page_state(lruvec_pgdat(lruvec), NR_LRU_BASE + lru);
> -
> -       for (zid = zone_idx + 1; zid < MAX_NR_ZONES; zid++) {
> +       for (zid = 0; zid <= zone_idx; zid++) {
>                 struct zone *zone = &lruvec_pgdat(lruvec)->node_zones[zid];
> -               unsigned long size;
>
>                 if (!managed_zone(zone))
>                         continue;
>
>                 if (!mem_cgroup_disabled())
> -                       size = mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
> +                       size += mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
>                 else
> -                       size = zone_page_state(&lruvec_pgdat(lruvec)->node_zones[zid],
> -                                      NR_ZONE_LRU_BASE + lru);
> -               lru_size -= min(size, lru_size);
> +                       size += zone_page_state(zone, NR_ZONE_LRU_BASE + lru);
>         }
> -
> -       return lru_size;
> +       return size;
>
>  }
>
> --
> 2.21.0
>
