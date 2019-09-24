Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB31C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0454421655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Vbus0KPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387987AbfIXPD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:03:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34554 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfIXPD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:03:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id 3so2533922qta.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 08:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YsMeuyoMleb9QtVsaOT25mI20JAueG4RElFK0Rnm9yE=;
        b=Vbus0KPgjf7ASZHaDu1c+Lei8f2AaozrpsjDyCbIhsTQJfxrJASuBdfqZJ6kn7BgGL
         oCpYOlxoeHh7bT/ZxUzPgPjHkgHQNqZkQUoGNRaEbVG65uD4pSK2++OxeO/wiklRBhBg
         t1wFpcGsmK16qm3bLtCxRFe4/M+3UlQU+SBr8jVPYKNNfRY394u5gXUO9BdqQBk/e5L1
         E4jdykk9Xrad94zISEVAdu6DMVq3c79WGSVLdRsITv0MDdGRNDu7qpBdg9o9U4o+cANQ
         PJJjm1qZIvyEUmyOa+pG9gNG7/1YUP4G4BPTD+Y6pYSXpekMUY+KxcqcI5jThAgTB1+p
         9qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YsMeuyoMleb9QtVsaOT25mI20JAueG4RElFK0Rnm9yE=;
        b=Jao+v5gh+sm2aF/Ga4BNVVRw8/6FPQAfSmyJN4ajskLo2eYvfCf+63of6NUoPDlQzh
         t0YlV5j4Gzec0VjMHA2bT7JDI9mWkD1r1cizIYwVgm9lxfgXZO4aonmZlE4BoDABFN9a
         VNd8q0GDkv07MfWNVqilzbz62RKf5fpaKwzNu8lBv7YTDwf/4p8bsKjEXZ3V9iCK40QT
         xzVk2IaZI+ZKITpQBB7kvXhHljyXRNDGB+hfVlCOlpc289KQKoqXmTcDW+PEQP6EAKGB
         LfL1LDjDJG6cZlQ+6xBzRC2P1BbJ4mzgp2hx44o0qvHsU01xOyBf+u7662cR7BCS2W4k
         1DyA==
X-Gm-Message-State: APjAAAXj6fRfm8p8bEc72eul931g8+Sg3u+CNMmsK4j2mhKIpsTObii6
        Vn86Q86L8KnCkUUvezDZz4M5jwSMTrg=
X-Google-Smtp-Source: APXvYqzxIxph97ZiUsFZUjd8SrGbTm+lU1/+SYyTCtgIbt5Pqbs40pvTONiAwb7S+/oHN6ow094PHw==
X-Received: by 2002:ac8:7587:: with SMTP id s7mr3328024qtq.288.1569337404243;
        Tue, 24 Sep 2019 08:03:24 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s17sm946702qkg.79.2019.09.24.08.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 08:03:23 -0700 (PDT)
Message-ID: <1569337401.5576.217.camel@lca.pw>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
From:   Qian Cai <cai@lca.pw>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 24 Sep 2019 11:03:21 -0400
In-Reply-To: <20190924143615.19628-1-david@redhat.com>
References: <20190924143615.19628-1-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-24 at 16:36 +0200, David Hildenbrand wrote:
> Since commit 3f906ba23689 ("mm/memory-hotplug: switch locking to a percpu
> rwsem") we do a cpus_read_lock() in mem_hotplug_begin(). This was
> introduced to fix a potential deadlock between get_online_mems() and
> get_online_cpus() - the memory and cpu hotplug lock. The root issue was
> that build_all_zonelists() -> stop_machine() required the cpu hotplug lock:
>     The reason is that memory hotplug takes the memory hotplug lock and
>     then calls stop_machine() which calls get_online_cpus().  That's the
>     reverse lock order to get_online_cpus(); get_online_mems(); in
>     mm/slub_common.c
> 
> So memory hotplug never really required any cpu lock itself, only
> stop_machine() and lru_add_drain_all() required it. Back then,
> stop_machine_cpuslocked() and lru_add_drain_all_cpuslocked() were used
> as the cpu hotplug lock was now obtained in the caller.
> 
> Since commit 11cd8638c37f ("mm, page_alloc: remove stop_machine from build
> all_zonelists"), the stop_machine_cpuslocked() call is gone.
> build_all_zonelists() does no longer require the cpu lock and does no
> longer make use of stop_machine().
> 
> Since commit 9852a7212324 ("mm: drop hotplug lock from
> lru_add_drain_all()"), lru_add_drain_all() "Doesn't need any cpu hotplug
> locking because we do rely on per-cpu kworkers being shut down before our
> page_alloc_cpu_dead callback is executed on the offlined cpu.". The
> lru_add_drain_all_cpuslocked() variant was removed.
> 
> So there is nothing left that requires the cpu hotplug lock. The memory
> hotplug lock and the device hotplug lock are sufficient.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> RFC -> v1:
> - Reword and add more details why the cpu hotplug lock was needed here
>   in the first place, and why we no longer require it.
> 
> ---
>  mm/memory_hotplug.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c3e9aed6023f..5fa30f3010e1 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -88,14 +88,12 @@ __setup("memhp_default_state=", setup_memhp_default_state);
>  
>  void mem_hotplug_begin(void)
>  {
> -	cpus_read_lock();
>  	percpu_down_write(&mem_hotplug_lock);
>  }
>  
>  void mem_hotplug_done(void)
>  {
>  	percpu_up_write(&mem_hotplug_lock);
> -	cpus_read_unlock();
>  }
>  
>  u64 max_mem_size = U64_MAX;

While at it, it might be a good time to rethink the whole locking over there, as
it right now read files under /sys/kernel/slab/ could trigger a possible
deadlock anyway.

[  442.258806][ T5224] WARNING: possible circular locking dependency detected
[  442.265678][ T5224] 5.3.0-rc7-mm1+ #6 Tainted: G             L   
[  442.271766][ T5224] ------------------------------------------------------
[  442.278635][ T5224] cat/5224 is trying to acquire lock:
[  442.283857][ T5224] ffff900012ac3120 (mem_hotplug_lock.rw_sem){++++}, at:
show_slab_objects+0x94/0x3a8
[  442.293189][ T5224] 
[  442.293189][ T5224] but task is already holding lock:
[  442.300404][ T5224] b8ff009693eee398 (kn->count#45){++++}, at:
kernfs_seq_start+0x44/0xf0
[  442.308587][ T5224] 
[  442.308587][ T5224] which lock already depends on the new lock.
[  442.308587][ T5224] 
[  442.318841][ T5224] 
[  442.318841][ T5224] the existing dependency chain (in reverse order) is:
[  442.327705][ T5224] 
[  442.327705][ T5224] -> #2 (kn->count#45){++++}:
[  442.334413][ T5224]        lock_acquire+0x31c/0x360
[  442.339286][ T5224]        __kernfs_remove+0x290/0x490
[  442.344428][ T5224]        kernfs_remove+0x30/0x44
[  442.349224][ T5224]        sysfs_remove_dir+0x70/0x88
[  442.354276][ T5224]        kobject_del+0x50/0xb0
[  442.358890][ T5224]        sysfs_slab_unlink+0x2c/0x38
[  442.364025][ T5224]        shutdown_cache+0xa0/0xf0
[  442.368898][ T5224]        kmemcg_cache_shutdown_fn+0x1c/0x34
[  442.374640][ T5224]        kmemcg_workfn+0x44/0x64
[  442.379428][ T5224]        process_one_work+0x4f4/0x950
[  442.384649][ T5224]        worker_thread+0x390/0x4bc
[  442.389610][ T5224]        kthread+0x1cc/0x1e8
[  442.394052][ T5224]        ret_from_fork+0x10/0x18
[  442.398835][ T5224] 
[  442.398835][ T5224] -> #1 (slab_mutex){+.+.}:
[  442.405365][ T5224]        lock_acquire+0x31c/0x360
[  442.410240][ T5224]        __mutex_lock_common+0x16c/0xf78
[  442.415722][ T5224]        mutex_lock_nested+0x40/0x50
[  442.420855][ T5224]        memcg_create_kmem_cache+0x38/0x16c
[  442.426598][ T5224]        memcg_kmem_cache_create_func+0x3c/0x70
[  442.432687][ T5224]        process_one_work+0x4f4/0x950
[  442.437908][ T5224]        worker_thread+0x390/0x4bc
[  442.442868][ T5224]        kthread+0x1cc/0x1e8
[  442.447307][ T5224]        ret_from_fork+0x10/0x18
[  442.452090][ T5224] 
[  442.452090][ T5224] -> #0 (mem_hotplug_lock.rw_sem){++++}:
[  442.459748][ T5224]        validate_chain+0xd10/0x2bcc
[  442.464883][ T5224]        __lock_acquire+0x7f4/0xb8c
[  442.469930][ T5224]        lock_acquire+0x31c/0x360
[  442.474803][ T5224]        get_online_mems+0x54/0x150
[  442.479850][ T5224]        show_slab_objects+0x94/0x3a8
[  442.485072][ T5224]        total_objects_show+0x28/0x34
[  442.490292][ T5224]        slab_attr_show+0x38/0x54
[  442.495166][ T5224]        sysfs_kf_seq_show+0x198/0x2d4
[  442.500473][ T5224]        kernfs_seq_show+0xa4/0xcc
[  442.505433][ T5224]        seq_read+0x30c/0x8a8
[  442.509958][ T5224]        kernfs_fop_read+0xa8/0x314
[  442.515007][ T5224]        __vfs_read+0x88/0x20c
[  442.519620][ T5224]        vfs_read+0xd8/0x10c
[  442.524060][ T5224]        ksys_read+0xb0/0x120
[  442.528586][ T5224]        __arm64_sys_read+0x54/0x88
[  442.533634][ T5224]        el0_svc_handler+0x170/0x240
[  442.538768][ T5224]        el0_svc+0x8/0xc
[  442.542858][ T5224] 
[  442.542858][ T5224] other info that might help us debug this:
[  442.542858][ T5224] 
[  442.552936][ T5224] Chain exists of:
[  442.552936][ T5224]   mem_hotplug_lock.rw_sem --> slab_mutex --> kn->count#45
[  442.552936][ T5224] 
[  442.565803][ T5224]  Possible unsafe locking scenario:
[  442.565803][ T5224] 
[  442.573105][ T5224]        CPU0                    CPU1
[  442.578322][ T5224]        ----                    ----
[  442.583539][ T5224]   lock(kn->count#45);
[  442.587545][ T5224]                                lock(slab_mutex);
[  442.593898][ T5224]                                lock(kn->count#45);
[  442.600433][ T5224]   lock(mem_hotplug_lock.rw_sem);
[  442.605393][ T5224] 
[  442.605393][ T5224]  *** DEADLOCK ***
[  442.605393][ T5224] 
[  442.613390][ T5224] 3 locks held by cat/5224:
[  442.617740][ T5224]  #0: 9eff00095b14b2a0 (&p->lock){+.+.}, at:
seq_read+0x4c/0x8a8
[  442.625399][ T5224]  #1: 0eff008997041480 (&of->mutex){+.+.}, at:
kernfs_seq_start+0x34/0xf0
[  442.633842][ T5224]  #2: b8ff009693eee398 (kn->count#45){++++}, at:
kernfs_seq_start+0x44/0xf0
[  442.642477][ T5224] 
[  442.642477][ T5224] stack backtrace:
[  442.648221][ T5224] CPU: 117 PID: 5224 Comm: cat Tainted:
G             L    5.3.0-rc7-mm1+ #6
[  442.656826][ T5224] Hardware name: HPE Apollo
70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[  442.667253][ T5224] Call trace:
[  442.670391][ T5224]  dump_backtrace+0x0/0x248
[  442.674743][ T5224]  show_stack+0x20/0x2c
[  442.678750][ T5224]  dump_stack+0xd0/0x140
[  442.682841][ T5224]  print_circular_bug+0x368/0x380
[  442.687715][ T5224]  check_noncircular+0x248/0x250
[  442.692501][ T5224]  validate_chain+0xd10/0x2bcc
[  442.697115][ T5224]  __lock_acquire+0x7f4/0xb8c
[  442.701641][ T5224]  lock_acquire+0x31c/0x360
[  442.705993][ T5224]  get_online_mems+0x54/0x150
[  442.710519][ T5224]  show_slab_objects+0x94/0x3a8
[  442.715219][ T5224]  total_objects_show+0x28/0x34
[  442.719918][ T5224]  slab_attr_show+0x38/0x54
[  442.724271][ T5224]  sysfs_kf_seq_show+0x198/0x2d4
[  442.729056][ T5224]  kernfs_seq_show+0xa4/0xcc
[  442.733494][ T5224]  seq_read+0x30c/0x8a8
[  442.737498][ T5224]  kernfs_fop_read+0xa8/0x314
[  442.742025][ T5224]  __vfs_read+0x88/0x20c
[  442.746118][ T5224]  vfs_read+0xd8/0x10c
[  442.750036][ T5224]  ksys_read+0xb0/0x120
[  442.754042][ T5224]  __arm64_sys_read+0x54/0x88
[  442.758569][ T5224]  el0_svc_handler+0x170/0x240
[  442.763180][ T5224]  el0_svc+0x8/0xc
