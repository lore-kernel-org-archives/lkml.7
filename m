Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C816C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 02:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC4B206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 02:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RncI3AG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFUCb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 22:31:28 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33920 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfFUCb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 22:31:27 -0400
Received: by mail-yb1-f196.google.com with SMTP id x32so2054553ybh.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 19:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QgpFL+6ymJMczlIkTzBjRU1WPesBaEDjjKVHMai+DRY=;
        b=RncI3AG0jrzPSPrUFfh2M1ccOyQCBhkEQFXS0sVWXSnc5pOmVqDLTEK19ntrBouXkj
         Ur57RL1TBfQCT1S5vclt6WSiTRaClYUuIXSKH23tjIpdOI3ozfQcLQ0BYbWY66ROC4hG
         zvCGnAhunRrlBbWQX2OrjVN+x5z2UXV4fvHCw8slkx9cUUfuBhDDHtsRL+T+vYwE8u57
         aFU08pzd+xWDc0gwr0kCnZQki0AVV5VwX90eDj7XqNrjZDG1fFERC4MSYSmbjVpNii9O
         +aCQtJD/KzYsM+TWZZtmaMWHSMrZEVbTkx+evTdxJHAR4S6oUxKyo/v+PeBpE/uKUJGD
         3s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QgpFL+6ymJMczlIkTzBjRU1WPesBaEDjjKVHMai+DRY=;
        b=JAzjtayn5FWYhvGKE043T1sDu8B6FftXQFm0MF80bqhaBkYgJL37DwiytMlAvbEAct
         y6NRuHUlt9ExorII7xlA//ET8Y4AMBzWVYOVYbL+8wOTA94erihnYgcVRP3DqokztP/V
         Gyn6SlW65tuuwFHpCbBDD9McV7jeLexg5GHzH2KJO5pH6/pmOKxy+BMvlyppivKYNoph
         +cxfe3vEBgfdWt58iyf6Y8xC9CqZ67SZEfvZFKJ8K2yVBBR9AHvjVGpWb108pJz7krve
         WYs69WG6u8lMwKbU4ouAR0MUQpW4pO8oiVtA/tOwqVb/pj5jd6aysoGgDhtRS2o4WIer
         h6gQ==
X-Gm-Message-State: APjAAAVaf2Do/tatsqX+G/RVyPLg6TXZ/xkA7dJMZqIA7EJa2gxidGbl
        pG24CglwhdsYZohz6PEN/6/DWDr4ErA7pA0Ju5nO9BNoHVY=
X-Google-Smtp-Source: APXvYqyLnUhjOcuQYOaU8t0La8g94tqvg35AO0PoEVbEw5GKrr/yk6PqunkZ8TYXUWg7mCHVZERPkhSUI4JO0qgqR/Q=
X-Received: by 2002:a25:1ed6:: with SMTP id e205mr67236770ybe.467.1561084286070;
 Thu, 20 Jun 2019 19:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190620213427.1691847-1-guro@fb.com>
In-Reply-To: <20190620213427.1691847-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Jun 2019 19:31:14 -0700
Message-ID: <CALvZod6V0BTqPaF7dX3oBkFMQ1cU1yPh_4f4ZVY9k-3opYLziA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg/slab: properly handle kmem_caches reparented
 to root_mem_cgroup
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 2:35 PM Roman Gushchin <guro@fb.com> wrote:
>
> As a result of reparenting a kmem_cache might belong to the root
> memory cgroup. It happens when a top-level memory cgroup is removed,
> and all associated kmem_caches are reparented to the root memory
> cgroup.
>
> The root memory cgroup is special, and requires a special handling.
> Let's make sure that we don't try to charge or uncharge it,
> and we handle system-wide vmstats exactly as for root kmem_caches.
>
> Note, that we still need to alter the kmem_cache reference counter,
> so that the kmem_cache can be released properly.
>
> The issue was discovered by running CRIU tests; the following warning
> did appear:
>
> [  381.345960] WARNING: CPU: 0 PID: 11655 at mm/page_counter.c:62
> page_counter_cancel+0x26/0x30
> [  381.345992] Modules linked in:
> [  381.345998] CPU: 0 PID: 11655 Comm: kworker/0:8 Not tainted
> 5.2.0-rc5-next-20190618+ #1
> [  381.346001] Hardware name: Google Google Compute Engine/Google
> Compute Engine, BIOS Google 01/01/2011
> [  381.346010] Workqueue: memcg_kmem_cache kmemcg_workfn
> [  381.346013] RIP: 0010:page_counter_cancel+0x26/0x30
> [  381.346017] Code: 1f 44 00 00 0f 1f 44 00 00 48 89 f0 53 48 f7 d8
> f0 48 0f c1 07 48 29 f0 48 89 c3 48 89 c6 e8 61 ff ff ff 48 85 db 78
> 02 5b c3 <0f> 0b 5b c3 66 0f 1f 44 00 00 0f 1f 44 00 00 48 85 ff 74 41
> 41 55
> [  381.346019] RSP: 0018:ffffb3b34319f990 EFLAGS: 00010086
> [  381.346022] RAX: fffffffffffffffc RBX: fffffffffffffffc RCX: 0000000000000004
> [  381.346024] RDX: 0000000000000000 RSI: fffffffffffffffc RDI: ffff9c2cd7165270
> [  381.346026] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000001
> [  381.346028] R10: 00000000000000c8 R11: ffff9c2cd684e660 R12: 00000000fffffffc
> [  381.346030] R13: 0000000000000002 R14: 0000000000000006 R15: ffff9c2c8ce1f200
> [  381.346033] FS:  0000000000000000(0000) GS:ffff9c2cd8200000(0000)
> knlGS:0000000000000000
> [  381.346039] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  381.346041] CR2: 00000000007be000 CR3: 00000001cdbfc005 CR4: 00000000001606f0
> [  381.346043] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  381.346045] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  381.346047] Call Trace:
> [  381.346054]  page_counter_uncharge+0x1d/0x30
> [  381.346065]  __memcg_kmem_uncharge_memcg+0x39/0x60
> [  381.346071]  __free_slab+0x34c/0x460
> [  381.346079]  deactivate_slab.isra.80+0x57d/0x6d0
> [  381.346088]  ? add_lock_to_list.isra.36+0x9c/0xf0
> [  381.346095]  ? __lock_acquire+0x252/0x1410
> [  381.346106]  ? cpumask_next_and+0x19/0x20
> [  381.346110]  ? slub_cpu_dead+0xd0/0xd0
> [  381.346113]  flush_cpu_slab+0x36/0x50
> [  381.346117]  ? slub_cpu_dead+0xd0/0xd0
> [  381.346125]  on_each_cpu_mask+0x51/0x70
> [  381.346131]  ? ksm_migrate_page+0x60/0x60
> [  381.346134]  on_each_cpu_cond_mask+0xab/0x100
> [  381.346143]  __kmem_cache_shrink+0x56/0x320
> [  381.346150]  ? ret_from_fork+0x3a/0x50
> [  381.346157]  ? unwind_next_frame+0x73/0x480
> [  381.346176]  ? __lock_acquire+0x252/0x1410
> [  381.346188]  ? kmemcg_workfn+0x21/0x50
> [  381.346196]  ? __mutex_lock+0x99/0x920
> [  381.346199]  ? kmemcg_workfn+0x21/0x50
> [  381.346205]  ? kmemcg_workfn+0x21/0x50
> [  381.346216]  __kmemcg_cache_deactivate_after_rcu+0xe/0x40
> [  381.346220]  kmemcg_cache_deactivate_after_rcu+0xe/0x20
> [  381.346223]  kmemcg_workfn+0x31/0x50
> [  381.346230]  process_one_work+0x23c/0x5e0
> [  381.346241]  worker_thread+0x3c/0x390
> [  381.346248]  ? process_one_work+0x5e0/0x5e0
> [  381.346252]  kthread+0x11d/0x140
> [  381.346255]  ? kthread_create_on_node+0x60/0x60
> [  381.346261]  ret_from_fork+0x3a/0x50
> [  381.346275] irq event stamp: 10302
> [  381.346278] hardirqs last  enabled at (10301): [<ffffffffb2c1a0b9>]
> _raw_spin_unlock_irq+0x29/0x40
> [  381.346282] hardirqs last disabled at (10302): [<ffffffffb2182289>]
> on_each_cpu_mask+0x49/0x70
> [  381.346287] softirqs last  enabled at (10262): [<ffffffffb2191f4a>]
> cgroup_idr_replace+0x3a/0x50
> [  381.346290] softirqs last disabled at (10260): [<ffffffffb2191f2d>]
> cgroup_idr_replace+0x1d/0x50
> [  381.346293] ---[ end trace b324ba73eb3659f0 ]---
>
> v2: fixed return value from memcg_charge_slab(), spotted by Shakeel
>
> Reported-by: Andrei Vagin <avagin@gmail.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> Cc: Christoph Lameter <cl@linux.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> ---
>  mm/slab.h | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index a4c9b9d042de..a62372d0f271 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -294,8 +294,12 @@ static __always_inline int memcg_charge_slab(struct page *page,
>                 memcg = parent_mem_cgroup(memcg);
>         rcu_read_unlock();
>
> -       if (unlikely(!memcg))
> -               return true;
> +       if (unlikely(!memcg || mem_cgroup_is_root(memcg))) {
> +               mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> +                                   (1 << order));
> +               percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
> +               return 0;
> +       }
>
>         ret = memcg_kmem_charge_memcg(page, gfp, order, memcg);
>         if (ret)
> @@ -324,9 +328,14 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
>
>         rcu_read_lock();
>         memcg = READ_ONCE(s->memcg_params.memcg);
> -       lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> -       mod_lruvec_state(lruvec, cache_vmstat_idx(s), -(1 << order));
> -       memcg_kmem_uncharge_memcg(page, order, memcg);
> +       if (likely(!mem_cgroup_is_root(memcg))) {
> +               lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> +               mod_lruvec_state(lruvec, cache_vmstat_idx(s), -(1 << order));
> +               memcg_kmem_uncharge_memcg(page, order, memcg);
> +       } else {
> +               mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> +                                   -(1 << order));
> +       }
>         rcu_read_unlock();
>
>         percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
> --
> 2.21.0
>
