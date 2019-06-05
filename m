Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F16C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135AE20870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvDUXyVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFEHj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:39:29 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:39559 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFEHj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:39:28 -0400
Received: by mail-vk1-f201.google.com with SMTP id o3so8553471vke.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EDTxCxcNHL556kqhPzcTfA1xZzULf1Gez0maK4Ox1iQ=;
        b=GvDUXyVvyxLCvV/+addi6w1Q4z3X2ywCTF++ZtLGrCnS35NqwNKaEoKggI1CuaorgB
         MQvfCkOJaobkMcHaGlSaoT0eLU8rzhhp6LxZvwdhQf880jxkj7M9ol5tok2ga3mnSTt3
         4hfcCTAxJfNh8eqFJbyLGoNcs6TUpWL1nE+NTRpF2arLgPQ3P6PmbtnRKyfi4zfvC/u3
         KI/rA/orx+IPk0qA9xZpK3jh2mCgApEAXZ8ElZvuxn4k/thGOWFVw71XwhCkJz52Rtt2
         YUJNZMHHeSGnU+UObziZhOF7qFByOUmtWQH22TS2OeVKtfvORrB9uWQg7FHLf4O7QZe+
         WGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EDTxCxcNHL556kqhPzcTfA1xZzULf1Gez0maK4Ox1iQ=;
        b=nsHQRLsK18BjBQLquYlfZBd9b52E6yFMKGe6rVCS6xkgYLnIW3Vo0J6mHqtnrz6hAL
         i7QpBS91yau/U6KwuF+2co8OPGsdrePXCBLJeBolpvAWVNelWkDw+6xsTRedmWD9PT3p
         rDmW4ohBya21Zd9v1VUIOj77xMH8VXJm9MGNLxx/FCGFcoDVV1li4W4/9YifF2Fadg/s
         jBbWvrHIK6e+Rh/qJM/GCCLVkknuDMxqnW8OCYTg3BEjSBVfQ3+54NK2m1AKHIRp/3gI
         HGdW0nar2xD9uPpr8oGAQ+J657s0l4oJlNv862kOB0ZUiP4YUibDU37Ug4zezlBRSiXr
         9J1Q==
X-Gm-Message-State: APjAAAURq5BePPPEPpqs4pR/PqpxIXQf20ZN1bZjG/XHqh2tehvmvCl9
        BNx3Cwy7d+S7Vz6AGd3mY47L07gowXb7
X-Google-Smtp-Source: APXvYqwFLzP0xkrD7H7S1pBpntPPuM18KVu0pgkuD4DgNePlzTUoNOZzKkaZ7yuykXKVZk60Sdd0jPCa7AvG
X-Received: by 2002:ab0:2395:: with SMTP id b21mr18693223uan.108.1559720367134;
 Wed, 05 Jun 2019 00:39:27 -0700 (PDT)
Date:   Wed, 05 Jun 2019 00:39:24 -0700
In-Reply-To: <20190514213940.2405198-1-guro@fb.com>
Message-Id: <xr93ef48v5ub.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20190514213940.2405198-1-guro@fb.com>
Subject: Re: [PATCH v4 0/7] mm: reparent slab memory on cgroup removal
From:   Greg Thelen <gthelen@google.com>
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Gushchin <guro@fb.com> wrote:

> # Why do we need this?
>
> We've noticed that the number of dying cgroups is steadily growing on most
> of our hosts in production. The following investigation revealed an issue
> in userspace memory reclaim code [1], accounting of kernel stacks [2],
> and also the mainreason: slab objects.
>
> The underlying problem is quite simple: any page charged
> to a cgroup holds a reference to it, so the cgroup can't be reclaimed unless
> all charged pages are gone. If a slab object is actively used by other cgroups,
> it won't be reclaimed, and will prevent the origin cgroup from being reclaimed.
>
> Slab objects, and first of all vfs cache, is shared between cgroups, which are
> using the same underlying fs, and what's even more important, it's shared
> between multiple generations of the same workload. So if something is running
> periodically every time in a new cgroup (like how systemd works), we do
> accumulate multiple dying cgroups.
>
> Strictly speaking pagecache isn't different here, but there is a key difference:
> we disable protection and apply some extra pressure on LRUs of dying cgroups,
> and these LRUs contain all charged pages.
> My experiments show that with the disabled kernel memory accounting the number
> of dying cgroups stabilizes at a relatively small number (~100, depends on
> memory pressure and cgroup creation rate), and with kernel memory accounting
> it grows pretty steadily up to several thousands.
>
> Memory cgroups are quite complex and big objects (mostly due to percpu stats),
> so it leads to noticeable memory losses. Memory occupied by dying cgroups
> is measured in hundreds of megabytes. I've even seen a host with more than 100Gb
> of memory wasted for dying cgroups. It leads to a degradation of performance
> with the uptime, and generally limits the usage of cgroups.
>
> My previous attempt [3] to fix the problem by applying extra pressure on slab
> shrinker lists caused a regressions with xfs and ext4, and has been reverted [4].
> The following attempts to find the right balance [5, 6] were not successful.
>
> So instead of trying to find a maybe non-existing balance, let's do reparent
> the accounted slabs to the parent cgroup on cgroup removal.
>
>
> # Implementation approach
>
> There is however a significant problem with reparenting of slab memory:
> there is no list of charged pages. Some of them are in shrinker lists,
> but not all. Introducing of a new list is really not an option.
>
> But fortunately there is a way forward: every slab page has a stable pointer
> to the corresponding kmem_cache. So the idea is to reparent kmem_caches
> instead of slab pages.
>
> It's actually simpler and cheaper, but requires some underlying changes:
> 1) Make kmem_caches to hold a single reference to the memory cgroup,
>    instead of a separate reference per every slab page.
> 2) Stop setting page->mem_cgroup pointer for memcg slab pages and use
>    page->kmem_cache->memcg indirection instead. It's used only on
>    slab page release, so it shouldn't be a big issue.
> 3) Introduce a refcounter for non-root slab caches. It's required to
>    be able to destroy kmem_caches when they become empty and release
>    the associated memory cgroup.
>
> There is a bonus: currently we do release empty kmem_caches on cgroup
> removal, however all other are waiting for the releasing of the memory cgroup.
> These refactorings allow kmem_caches to be released as soon as they
> become inactive and free.
>
> Some additional implementation details are provided in corresponding
> commit messages.
>
> # Results
>
> Below is the average number of dying cgroups on two groups of our production
> hosts. They do run some sort of web frontend workload, the memory pressure
> is moderate. As we can see, with the kernel memory reparenting the number
> stabilizes in 60s range; however with the original version it grows almost
> linearly and doesn't show any signs of plateauing. The difference in slab
> and percpu usage between patched and unpatched versions also grows linearly.
> In 7 days it exceeded 200Mb.
>
> day           0    1    2    3    4    5    6    7
> original     56  362  628  752 1070 1250 1490 1560
> patched      23   46   51   55   60   57   67   69
> mem diff(Mb) 22   74  123  152  164  182  214  241

No objection to the idea, but a question...

In patched kernel, does slabinfo (or similar) show the list reparented
slab caches?  A pile of zombie kmem_caches is certainly better than a
pile of zombie mem_cgroup.  But it still seems like it'll might cause
degradation - does cache_reap() walk an ever growing set of zombie
caches?

We've found it useful to add a slabinfo_full file which includes zombie
kmem_cache with their memcg_name.  This can help hunt down zombies.

> # History
>
> v4:
>   1) removed excessive memcg != parent check in memcg_deactivate_kmem_caches()
>   2) fixed rcu_read_lock() usage in memcg_charge_slab()
>   3) fixed synchronization around dying flag in kmemcg_queue_cache_shutdown()
>   4) refreshed test results data
>   5) reworked PageTail() checks in memcg_from_slab_page()
>   6) added some comments in multiple places
>
> v3:
>   1) reworked memcg kmem_cache search on allocation path
>   2) fixed /proc/kpagecgroup interface
>
> v2:
>   1) switched to percpu kmem_cache refcounter
>   2) a reference to kmem_cache is held during the allocation
>   3) slabs stats are fixed for !MEMCG case (and the refactoring
>      is separated into a standalone patch)
>   4) kmem_cache reparenting is performed from deactivatation context
>
> v1:
>   https://lkml.org/lkml/2019/4/17/1095
>
>
> # Links
>
> [1]: commit 68600f623d69 ("mm: don't miss the last page because of
> round-off error")
> [2]: commit 9b6f7e163cd0 ("mm: rework memcg kernel stack accounting")
> [3]: commit 172b06c32b94 ("mm: slowly shrink slabs with a relatively
> small number of objects")
> [4]: commit a9a238e83fbb ("Revert "mm: slowly shrink slabs
> with a relatively small number of objects")
> [5]: https://lkml.org/lkml/2019/1/28/1865
> [6]: https://marc.info/?l=linux-mm&m=155064763626437&w=2
>
>
> Roman Gushchin (7):
>   mm: postpone kmem_cache memcg pointer initialization to
>     memcg_link_cache()
>   mm: generalize postponed non-root kmem_cache deactivation
>   mm: introduce __memcg_kmem_uncharge_memcg()
>   mm: unify SLAB and SLUB page accounting
>   mm: rework non-root kmem_cache lifecycle management
>   mm: reparent slab memory on cgroup removal
>   mm: fix /proc/kpagecgroup interface for slab pages
>
>  include/linux/memcontrol.h |  10 +++
>  include/linux/slab.h       |  13 +--
>  mm/memcontrol.c            | 101 ++++++++++++++++-------
>  mm/slab.c                  |  25 ++----
>  mm/slab.h                  | 137 ++++++++++++++++++++++++-------
>  mm/slab_common.c           | 162 +++++++++++++++++++++----------------
>  mm/slub.c                  |  36 ++-------
>  7 files changed, 299 insertions(+), 185 deletions(-)
