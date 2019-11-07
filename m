Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2094FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815AC21D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlCeuEiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbfKGCv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:51:27 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40374 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733048AbfKGCv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:51:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id 22so650066oip.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 18:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJgjLii01IGGdUCsYrzd4gYjlTvDiWueI/o8CqoLYI4=;
        b=rlCeuEiCGh7lsXngMqUCH816OSSAwW5c+4c+hmAyE/ruz/i3CAd226pxUWdOkAwMV5
         Y2vPchFkJoWzr8dSiKPbmMnzTpqFNJbj/npNbC+nwyeUh+2na5zPYMcupa7V219gY5QQ
         n18znZB1l1X3eI473qpX5oK0eCLoYA1B+m8r/7RLgqyYxLeGsMSaAOjhI+N86Bf62IRp
         UOSmS6XrKL8AfEu3nxL5/D2WQILh4cipww7Lqj2buj1l4CStbh2qig/SIowcQlgTPawz
         SQDRqJ1/U/o4JxfoC54TRxE+NvVH3iM7YDzr9FAMUxVkuWmKtifVYfYytRvlQiN8++am
         c88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJgjLii01IGGdUCsYrzd4gYjlTvDiWueI/o8CqoLYI4=;
        b=QR0KTTgmlpto6HvTPpGQE6kK5StUfZPZizd3uwRFIyTW4fY2vZcMlUkGFuGeDaiudU
         61z0g54ToL3fh35ol+PuQdkdx6R7AUZ9DyC8GSCeAPmpQaaVIivpQ+FnH9r8bCIN+LBh
         OnTZGLkR3Wa/f65mrycc5AyWzI2/u0IqAGGR/quSFajXlSgoNxp0ShHsa9KHdHcMjpsq
         j94oJXjZldr4Ae2CISHIsgqD3V8X9XudwbeQpnC96NzFJPuIyEa5lcpYmRrhgjzkLyFl
         fgO5j5futJyni2GoJAW79/d+xC62NwsqCYvtudu7VMnWpK3AUs8Ufd+InRB1GK2RrqDc
         3bZg==
X-Gm-Message-State: APjAAAXrU6HXyq1P8WSWjvc3XtFveV7viT0T7DgwnceYRKVGAsvq/U1B
        qA+JoQgMhdnECl0H8fe+COnMQlhdreAr0cG5eLKypw==
X-Google-Smtp-Source: APXvYqxVb+X95mYEAd2Ugk1BumgEAruoupSYZRK2d7E+6AIUYLX4CVCCjXCrigXtcqjbBQQP/G/PAGC9+XuoVmpaskU=
X-Received: by 2002:aca:f506:: with SMTP id t6mr1159853oih.69.1573095085224;
 Wed, 06 Nov 2019 18:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20190603210746.15800-1-hannes@cmpxchg.org> <20190603210746.15800-5-hannes@cmpxchg.org>
In-Reply-To: <20190603210746.15800-5-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:51:14 -0800
Message-ID: <CALvZod4EyAX_Q-YdHkVOquL2dJYMYN7YNi3V0rZ0yDtB09SszQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] mm: vmscan: naming fixes: cgroup_reclaim() and writeback_working()
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

On Mon, Jun 3, 2019 at 3:02 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Seven years after introducing the global_reclaim() function, I still
> have to double take when reading a callsite. I don't know how others
> do it. This is a terrible name.
>
> Invert the meaning and rename it to cgroup_reclaim().
>
> [ After all, "global reclaim" is just regular reclaim invoked from the
>   page allocator. It's reclaim on behalf of a cgroup limit that is a
>   special case of reclaim, and should be explicit - not the reverse. ]
>

Not really confusing for me at least but no objection on cgroup_reclaim().

> sane_reclaim() isn't very descriptive either: it tests whether we can
> use the regular writeback throttling - available during regular page
> reclaim or cgroup2 limit reclaim - or need to use the broken
> wait_on_page_writeback() method. Rename it to writeback_working().

Totally agree here.

>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  mm/vmscan.c | 38 ++++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 69c4c82a9b5a..afd5e2432a8e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -239,13 +239,13 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  #endif /* CONFIG_MEMCG_KMEM */
>
>  #ifdef CONFIG_MEMCG
> -static bool global_reclaim(struct scan_control *sc)
> +static bool cgroup_reclaim(struct scan_control *sc)
>  {
> -       return !sc->target_mem_cgroup;
> +       return sc->target_mem_cgroup;
>  }
>
>  /**
> - * sane_reclaim - is the usual dirty throttling mechanism operational?
> + * writeback_working - is the usual dirty throttling mechanism unavailable?
>   * @sc: scan_control in question
>   *
>   * The normal page dirty throttling mechanism in balance_dirty_pages() is
> @@ -257,11 +257,9 @@ static bool global_reclaim(struct scan_control *sc)
>   * This function tests whether the vmscan currently in progress can assume
>   * that the normal dirty throttling mechanism is operational.
>   */
> -static bool sane_reclaim(struct scan_control *sc)
> +static bool writeback_working(struct scan_control *sc)
>  {
> -       struct mem_cgroup *memcg = sc->target_mem_cgroup;
> -
> -       if (!memcg)
> +       if (!cgroup_reclaim(sc))
>                 return true;
>  #ifdef CONFIG_CGROUP_WRITEBACK
>         if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> @@ -293,12 +291,12 @@ static bool memcg_congested(pg_data_t *pgdat,
>
>  }
>  #else
> -static bool global_reclaim(struct scan_control *sc)
> +static bool cgroup_reclaim(struct scan_control *sc)
>  {
> -       return true;
> +       return false;
>  }
>
> -static bool sane_reclaim(struct scan_control *sc)
> +static bool writeback_working(struct scan_control *sc)
>  {
>         return true;
>  }
> @@ -1211,7 +1209,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>                                 goto activate_locked;
>
>                         /* Case 2 above */
> -                       } else if (sane_reclaim(sc) ||
> +                       } else if (writeback_working(sc) ||
>                             !PageReclaim(page) || !may_enter_fs) {
>                                 /*
>                                  * This is slightly racy - end_page_writeback()
> @@ -1806,7 +1804,7 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
>         if (current_is_kswapd())
>                 return 0;
>
> -       if (!sane_reclaim(sc))
> +       if (!writeback_working(sc))
>                 return 0;
>
>         if (file) {
> @@ -1957,7 +1955,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>         reclaim_stat->recent_scanned[file] += nr_taken;
>
>         item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
> -       if (global_reclaim(sc))
> +       if (!cgroup_reclaim(sc))
>                 __count_vm_events(item, nr_scanned);
>         __count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
>         spin_unlock_irq(&pgdat->lru_lock);
> @@ -1971,7 +1969,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>         spin_lock_irq(&pgdat->lru_lock);
>
>         item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
> -       if (global_reclaim(sc))
> +       if (!cgroup_reclaim(sc))
>                 __count_vm_events(item, nr_reclaimed);
>         __count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
>         reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
> @@ -2239,7 +2237,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>          * using the memory controller's swap limit feature would be
>          * too expensive.
>          */
> -       if (!global_reclaim(sc) && !swappiness) {
> +       if (cgroup_reclaim(sc) && !swappiness) {
>                 scan_balance = SCAN_FILE;
>                 goto out;
>         }
> @@ -2263,7 +2261,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>          * thrashing file LRU becomes infinitely more attractive than
>          * anon pages.  Try to detect this based on file LRU size.
>          */
> -       if (global_reclaim(sc)) {
> +       if (!cgroup_reclaim(sc)) {
>                 unsigned long pgdatfile;
>                 unsigned long pgdatfree;
>                 int z;
> @@ -2494,7 +2492,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
>          * abort proportional reclaim if either the file or anon lru has already
>          * dropped to zero at the first pass.
>          */
> -       scan_adjusted = (global_reclaim(sc) && !current_is_kswapd() &&
> +       scan_adjusted = (!cgroup_reclaim(sc) && !current_is_kswapd() &&
>                          sc->priority == DEF_PRIORITY);
>
>         blk_start_plug(&plug);
> @@ -2816,7 +2814,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>                  * Legacy memcg will stall in page writeback so avoid forcibly
>                  * stalling in wait_iff_congested().
>                  */
> -               if (!global_reclaim(sc) && sane_reclaim(sc) &&
> +               if (cgroup_reclaim(sc) && writeback_working(sc) &&
>                     sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
>                         set_memcg_congestion(pgdat, root, true);
>
> @@ -2911,7 +2909,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>                  * Take care memory controller reclaiming has small influence
>                  * to global LRU.
>                  */
> -               if (global_reclaim(sc)) {
> +               if (!cgroup_reclaim(sc)) {
>                         if (!cpuset_zone_allowed(zone,
>                                                  GFP_KERNEL | __GFP_HARDWALL))
>                                 continue;
> @@ -3011,7 +3009,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>  retry:
>         delayacct_freepages_start();
>
> -       if (global_reclaim(sc))
> +       if (!cgroup_reclaim(sc))
>                 __count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
>
>         do {
> --
> 2.21.0
>
