Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AED3FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26FD217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9PsUp0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbfKGCut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:50:49 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40335 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732990AbfKGCut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:50:49 -0500
Received: by mail-oi1-f196.google.com with SMTP id 22so649050oip.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 18:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10UEJHReRRkCxqogp9ovKAQzTbWMZb9ETtZvBc2w3vc=;
        b=n9PsUp0qLOLm3wGK6uOzCOXqKvmgPnWWAlsm+bH61fBp5I7s0DOeNJAHiWoawbMzlJ
         UBNhIcvRd60O+T2/7puYtioivkiGfDSKcW95AogUygR40udqSIvMMm1ctuaW1MbeH7B2
         nx2IDJ7a8R52fGrCK8GjN5xYz1k8FzHSiINa/nW+Xi1UOfMK1SSkhxWNO1O4WL4xNDy7
         YFx8ofRoa/3PuOrCSE4b/8D478nKxV63gjcYW8a5n1W00TtkmSSR/ERQeOS0FJhWDwpi
         MojGBQ5ILh+cI9z1z47DnjqqlWBvMytlSohM2JWKkAuA+it3n8s5M8f86M4QwUYvFHxv
         hJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10UEJHReRRkCxqogp9ovKAQzTbWMZb9ETtZvBc2w3vc=;
        b=OjzftQKsv8OIIZ/UTwFm0B7gsqrKLPSa5cZHIKCIZCHXXzTXu80fq58+3zaDJfRi24
         ImPakv92XC5/MHz3X25wsb0AP7ArlSW4jf/hLQQEfDRHb+eNHHgdJ1kDYdna+fhuIssd
         5tTSQQQGV7BMybvFo6CiPqf6GKhaus9pnNngn/CHDA/9BQDdkX2bIhbt1tnLNdUiVfIl
         Bi7caFea9jJiTN5C9UydPuehjdFOuGlY34qmfPpfyA97eKVc2CC+/dTQXtbn8cUOZMcD
         Z/TlLEp+1bcPgmjBKwFcy3XdXWgf3makrpsa3+rL8zMFOwysdRgVVm2L3C8FodHu1Zf/
         YgcQ==
X-Gm-Message-State: APjAAAVwDIAyC4i8ANamppZmZJNqXaWscn2wWQ144eXzX/Umo8O0fZdv
        uKHxHPThSmSbvuOCyi/80jrgNgfkWTY5pG97ghJnTQ==
X-Google-Smtp-Source: APXvYqzyjKzgEyRmRo9wOEa5cehiAL+Sv7Mn/3zkI13/srHen06wd5TqdFNxutTAASUvt49xy0qAPDm/qOCOQiKf/Tc=
X-Received: by 2002:aca:f1c5:: with SMTP id p188mr1092234oih.125.1573095048014;
 Wed, 06 Nov 2019 18:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20190603210746.15800-1-hannes@cmpxchg.org> <20190603210746.15800-2-hannes@cmpxchg.org>
In-Reply-To: <20190603210746.15800-2-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:50:37 -0800
Message-ID: <CALvZod64t1OGuhrvB1QChUYvUs2yQF-qAi5F=gcntHN84rr=sQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] mm: vmscan: move inactive_list_is_low() swap check
 to the caller
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

On Mon, Jun 3, 2019 at 3:05 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> inactive_list_is_low() should be about one thing: checking the ratio
> between inactive and active list. Kitchensink checks like the one for
> swap space makes the function hard to use and modify its
> callsites. Luckly, most callers already have an understanding of the
> swap situation, so it's easy to clean up.
>
> get_scan_count() has its own, memcg-aware swap check, and doesn't even
> get to the inactive_list_is_low() check on the anon list when there is
> no swap space available.
>
> shrink_list() is called on the results of get_scan_count(), so that
> check is redundant too.
>
> age_active_anon() has its own totalswap_pages check right before it
> checks the list proportions.
>
> The shrink_node_memcg() site is the only one that doesn't do its own
> swap check. Add it there.
>
> Then delete the swap check from inactive_list_is_low().
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  mm/vmscan.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 84dcb651d05c..f396424850aa 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2165,13 +2165,6 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
>         unsigned long refaults;
>         unsigned long gb;
>
> -       /*
> -        * If we don't have swap space, anonymous page deactivation
> -        * is pointless.
> -        */
> -       if (!file && !total_swap_pages)
> -               return false;
> -
>         inactive = lruvec_lru_size(lruvec, inactive_lru, sc->reclaim_idx);
>         active = lruvec_lru_size(lruvec, active_lru, sc->reclaim_idx);
>
> @@ -2592,7 +2585,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
>          * Even if we did not try to evict anon pages at all, we want to
>          * rebalance the anon lru active/inactive ratio.
>          */
> -       if (inactive_list_is_low(lruvec, false, sc, true))
> +       if (total_swap_pages && inactive_list_is_low(lruvec, false, sc, true))
>                 shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
>                                    sc, LRU_ACTIVE_ANON);
>  }
> --
> 2.21.0
>
