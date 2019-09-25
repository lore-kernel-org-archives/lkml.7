Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA65C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F3121D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dvvzP1gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439354AbfIYPSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:18:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42280 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfIYPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:18:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id w14so7002735qto.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ghAxxiYIqFLDFa+1mBl8boCylk/lh1uTWDDIQYvrkHY=;
        b=dvvzP1gwHT3G+DFKG9KecVFPHNJ7Fh/0IGBOK35cbnb03U3PwJ52GnpLdTuli7d0fs
         QNNu0ZTScR+a9D5Az78wSIC7DwTymMMyeiqgrrTn0OmYOt9W8YS0NGJLM8MN0KlJKUE6
         F9TOFquYdIgHlll2bIRXDLGRnbc5pB46/WC1bk9GGjmmmaHaKvNI3+3o1Z1P+OcJVGqE
         uPn2gRz/h5qCgZ1JtHegt+9pFXwHxsE1HJw4CJCk2TeAl2EhN/iaN5U+l2uc2dHjsuuk
         be9n8qo1VASTsU89OhS5SJ2oSf3lBRNClX/G7g62ZXyw9EaOHlaoTF1d/NQ946NnSven
         G/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghAxxiYIqFLDFa+1mBl8boCylk/lh1uTWDDIQYvrkHY=;
        b=jp6lXvCptWGuxlIuR6jp2t1FO0JbbfGMCPXYOhxKYIAXtzJa7XzzBpyiPJxMXv7B7Q
         /8fpwORgIlNaBCp/uIllOzkHzIGKd/duOdoKuIxd293juSIB3WCGsR4oRdQCqF57yRoU
         U7rhFA5/HVnTMTTGOh+p9XFcFBdFrgC9uklsZ48EKKGjUgOh559A60OhRRpornUUDmFE
         JQJV11UU5Yeqg1mzUVGJM+Sksz16M+4irGhNB+fEmkbS8lB4GjyR1FpE8VUdqU+82DO9
         ql2PvvCbyOhjx264xYigv6jHdQWhAxdfY60PeIQDyPbm5RFhPYl5cP8cC2Tg379IyDxL
         Hkpg==
X-Gm-Message-State: APjAAAW9p6fif8VOfKKnptjx3oueXpPf6sbtjsj2NoPepc6cP78/JRkz
        6jSs45iqbel4xhs4CfVlHglCOw==
X-Google-Smtp-Source: APXvYqzXrPkILsLkpLfMz8EbdENfPe9ZQ3t8JKL8zalv3Xh3qfXOCdQnszAjeZYj1aN4AlPMk/kz1Q==
X-Received: by 2002:a05:6214:1354:: with SMTP id b20mr7949547qvw.43.1569424731492;
        Wed, 25 Sep 2019 08:18:51 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k46sm4508510qtc.96.2019.09.25.08.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 08:18:50 -0700 (PDT)
Message-ID: <1569424727.5576.221.camel@lca.pw>
Subject: Re: [PATCH] mm/slub: fix a deadlock in shuffle_freelist()
From:   Qian Cai <cai@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        mingo@redhat.com, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Date:   Wed, 25 Sep 2019 11:18:47 -0400
In-Reply-To: <20190925093153.GC4553@hirez.programming.kicks-ass.net>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
         <20190925093153.GC4553@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-25 at 11:31 +0200, Peter Zijlstra wrote:
> On Fri, Sep 13, 2019 at 12:27:44PM -0400, Qian Cai wrote:
> > The commit b7d5dc21072c ("random: add a spinlock_t to struct
> > batched_entropy") insists on acquiring "batched_entropy_u32.lock" in
> > get_random_u32() which introduced the lock chain,
> > 
> > "&rq->lock --> batched_entropy_u32.lock"
> > 
> > even after crng init. As the result, it could result in deadlock below.
> > Fix it by using get_random_bytes() in shuffle_freelist() which does not
> > need to take on the batched_entropy locks.
> > 
> > WARNING: possible circular locking dependency detected
> > 5.3.0-rc7-mm1+ #3 Tainted: G             L
> > ------------------------------------------------------
> > make/7937 is trying to acquire lock:
> > ffff900012f225f8 (random_write_wait.lock){....}, at:
> > __wake_up_common_lock+0xa8/0x11c
> > 
> > but task is already holding lock:
> > ffff0096b9429c00 (batched_entropy_u32.lock){-.-.}, at:
> > get_random_u32+0x6c/0x1dc
> > 
> > which lock already depends on the new lock.
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #3 (batched_entropy_u32.lock){-.-.}:
> >        lock_acquire+0x31c/0x360
> >        _raw_spin_lock_irqsave+0x7c/0x9c
> >        get_random_u32+0x6c/0x1dc
> >        new_slab+0x234/0x6c0
> >        ___slab_alloc+0x3c8/0x650
> >        kmem_cache_alloc+0x4b0/0x590
> >        __debug_object_init+0x778/0x8b4
> >        debug_object_init+0x40/0x50
> >        debug_init+0x30/0x29c
> >        hrtimer_init+0x30/0x50
> >        init_dl_task_timer+0x24/0x44
> >        __sched_fork+0xc0/0x168
> >        init_idle+0x78/0x26c
> >        fork_idle+0x12c/0x178
> >        idle_threads_init+0x108/0x178
> >        smp_init+0x20/0x1bc
> >        kernel_init_freeable+0x198/0x26c
> >        kernel_init+0x18/0x334
> >        ret_from_fork+0x10/0x18
> > 
> > -> #2 (&rq->lock){-.-.}:
> 
> This relation is silly..
> 
> I suspect the below 'works'...

Unfortunately, the relation is still there,

copy_process()->rt_mutex_init_task()->"&p->pi_lock"

[24438.676716][    T2] -> #2 (&rq->lock){-.-.}:
[24438.676727][    T2]        __lock_acquire+0x5b4/0xbf0
[24438.676736][    T2]        lock_acquire+0x130/0x360
[24438.676754][    T2]        _raw_spin_lock+0x54/0x80
[24438.676771][    T2]        task_fork_fair+0x60/0x190
[24438.676788][    T2]        sched_fork+0x128/0x270
[24438.676806][    T2]        copy_process+0x7a4/0x1bf0
[24438.676823][    T2]        _do_fork+0xac/0xac0
[24438.676841][    T2]        kernel_thread+0x70/0xa0
[24438.676858][    T2]        rest_init+0x4c/0x42c
[24438.676884][    T2]        start_kernel+0x778/0x7c0
[24438.676902][    T2]        start_here_common+0x1c/0x334

Whole thing,

[24438.675704][    T2] WARNING: possible circular locking dependency detected
[24438.675714][    T2] 5.3.0-next-20190924 #2 Not tainted
[24438.675722][    T2] ------------------------------------------------------
[24438.675731][    T2] kthreadd/2 is trying to acquire lock:
[24438.675740][    T2] c0000000010a7450 (random_write_wait.lock){..-.}, at:
__wake_up_common_lock+0x88/0x110
[24438.675768][    T2] 
[24438.675768][    T2] but task is already holding lock:
[24438.675778][    T2] c000001ffd2f06e0 (batched_entropy_u64.lock){-...}, at:
get_random_u64+0x60/0x100
[24438.675803][    T2] 
[24438.675803][    T2] which lock already depends on the new lock.
[24438.675803][    T2] 
[24438.675816][    T2] 
[24438.675816][    T2] the existing dependency chain (in reverse order) is:
[24438.675836][    T2] 
[24438.675836][    T2] -> #4 (batched_entropy_u64.lock){-...}:
[24438.675860][    T2]        __lock_acquire+0x5b4/0xbf0
[24438.675878][    T2]        lock_acquire+0x130/0x360
[24438.675906][    T2]        _raw_spin_lock_irqsave+0x70/0xa0
[24438.675923][    T2]        get_random_u64+0x60/0x100
[24438.675944][    T2]        add_to_free_area_random+0x164/0x1b0
[24438.675962][    T2]        free_one_page+0xb24/0xcf0
[24438.675980][    T2]        __free_pages_ok+0x448/0xbf0
[24438.675999][    T2]        deferred_init_maxorder+0x404/0x4a4
[24438.676018][    T2]        deferred_grow_zone+0x158/0x1f0
[24438.676035][    T2]        get_page_from_freelist+0x1dc8/0x1e10
[24438.676063][    T2]        __alloc_pages_nodemask+0x1d8/0x1940
[24438.676083][    T2]        allocate_slab+0x130/0x2740
[24438.676091][    T2]        new_slab+0xa8/0xe0
[24438.676101][    T2]        kmem_cache_open+0x254/0x660
[24438.676119][    T2]        __kmem_cache_create+0x44/0x2a0
[24438.676136][    T2]        create_boot_cache+0xcc/0x110
[24438.676154][    T2]        kmem_cache_init+0x90/0x1f0
[24438.676173][    T2]        start_kernel+0x3b8/0x7c0
[24438.676191][    T2]        start_here_common+0x1c/0x334
[24438.676208][    T2] 
[24438.676208][    T2] -> #3 (&(&zone->lock)->rlock){-.-.}:
[24438.676221][    T2]        __lock_acquire+0x5b4/0xbf0
[24438.676247][    T2]        lock_acquire+0x130/0x360
[24438.676264][    T2]        _raw_spin_lock+0x54/0x80
[24438.676282][    T2]        rmqueue_bulk.constprop.23+0x64/0xf20
[24438.676300][    T2]        get_page_from_freelist+0x718/0x1e10
[24438.676319][    T2]        __alloc_pages_nodemask+0x1d8/0x1940
[24438.676339][    T2]        alloc_page_interleave+0x34/0x170
[24438.676356][    T2]        allocate_slab+0xd1c/0x2740
[24438.676374][    T2]        new_slab+0xa8/0xe0
[24438.676391][    T2]        ___slab_alloc+0x580/0xef0
[24438.676408][    T2]        __slab_alloc+0x64/0xd0
[24438.676426][    T2]        kmem_cache_alloc+0x5c4/0x6c0
[24438.676444][    T2]        fill_pool+0x280/0x540
[24438.676461][    T2]        __debug_object_init+0x60/0x6b0
[24438.676479][    T2]        hrtimer_init+0x5c/0x310
[24438.676497][    T2]        init_dl_task_timer+0x34/0x60
[24438.676516][    T2]        __sched_fork+0x8c/0x110
[24438.676535][    T2]        init_idle+0xb4/0x3c0
[24438.676553][    T2]        idle_thread_get+0x78/0x120
[24438.676572][    T2]        bringup_cpu+0x30/0x230
[24438.676590][    T2]        cpuhp_invoke_callback+0x190/0x1580
[24438.676618][    T2]        do_cpu_up+0x248/0x460
[24438.676636][    T2]        smp_init+0x118/0x1c0
[24438.676662][    T2]        kernel_init_freeable+0x3f8/0x8dc
[24438.676681][    T2]        kernel_init+0x2c/0x154
[24438.676699][    T2]        ret_from_kernel_thread+0x5c/0x74
[24438.676716][    T2] 
[24438.676716][    T2] -> #2 (&rq->lock){-.-.}:
[24438.676727][    T2]        __lock_acquire+0x5b4/0xbf0
[24438.676736][    T2]        lock_acquire+0x130/0x360
[24438.676754][    T2]        _raw_spin_lock+0x54/0x80
[24438.676771][    T2]        task_fork_fair+0x60/0x190
[24438.676788][    T2]        sched_fork+0x128/0x270
[24438.676806][    T2]        copy_process+0x7a4/0x1bf0
[24438.676823][    T2]        _do_fork+0xac/0xac0
[24438.676841][    T2]        kernel_thread+0x70/0xa0
[24438.676858][    T2]        rest_init+0x4c/0x42c
[24438.676884][    T2]        start_kernel+0x778/0x7c0
[24438.676902][    T2]        start_here_common+0x1c/0x334
[24438.676910][    T2] 
[24438.676910][    T2] -> #1 (&p->pi_lock){-.-.}:
[24438.676921][    T2]        __lock_acquire+0x5b4/0xbf0
[24438.676929][    T2]        lock_acquire+0x130/0x360
[24438.676947][    T2]        _raw_spin_lock_irqsave+0x70/0xa0
[24438.676973][    T2]        try_to_wake_up+0x70/0x1600
[24438.676991][    T2]        pollwake+0x88/0xc0
[24438.677009][    T2]        __wake_up_common+0xec/0x280
[24438.677026][    T2]        __wake_up_common_lock+0xac/0x110
[24438.677044][    T2]        account.constprop.8+0x284/0x430
[24438.677061][    T2]        extract_entropy.constprop.7+0xd4/0x330
[24438.677080][    T2]        _xfer_secondary_pool+0x104/0x3e0
[24438.677097][    T2]        push_to_pool+0x58/0x310
[24438.677116][    T2]        process_one_work+0x300/0x8e0
[24438.677133][    T2]        worker_thread+0x78/0x530
[24438.677151][    T2]        kthread+0x1a8/0x1b0
[24438.677180][    T2]        ret_from_kernel_thread+0x5c/0x74
[24438.677245][    T2] 
[24438.677245][    T2] -> #0 (random_write_wait.lock){..-.}:
[24438.677329][    T2]        check_prev_add+0x100/0x11b0
[24438.677377][    T2]        validate_chain+0x868/0x1530
[24438.677446][    T2]        __lock_acquire+0x5b4/0xbf0
[24438.677516][    T2]        lock_acquire+0x130/0x360
[24438.677563][    T2]        _raw_spin_lock_irqsave+0x70/0xa0
[24438.677618][    T2]        __wake_up_common_lock+0x88/0x110
[24438.677678][    T2]        account.constprop.8+0x284/0x430
[24438.677743][    T2]        extract_entropy.constprop.7+0xd4/0x330
[24438.677802][    T2]        crng_reseed+0x68/0x490
[24438.677867][    T2]        _extract_crng+0x104/0x110
[24438.677914][    T2]        crng_reseed+0x284/0x490
[24438.677983][    T2]        _extract_crng+0x104/0x110
[24438.678032][    T2]        get_random_u64+0xdc/0x100
[24438.678101][    T2]        copy_process+0x2d8/0x1bf0
[24438.678148][    T2]        _do_fork+0xac/0xac0
[24438.678208][    T2]        kernel_thread+0x70/0xa0
[24438.678246][    T2]        kthreadd+0x270/0x330
[24438.678301][    T2]        ret_from_kernel_thread+0x5c/0x74
[24438.678342][    T2] 
[24438.678342][    T2] other info that might help us debug this:
[24438.678342][    T2] 
[24438.678459][    T2] Chain exists of:
[24438.678459][    T2]   random_write_wait.lock --> &(&zone->lock)->rlock -->
batched_entropy_u64.lock
[24438.678459][    T2] 
[24438.678636][    T2]  Possible unsafe locking scenario:
[24438.678636][    T2] 
[24438.678692][    T2]        CPU0                    CPU1
[24438.678754][    T2]        ----                    ----
[24438.678814][    T2]   lock(batched_entropy_u64.lock);
[24438.678878][    T2]                                lock(&(&zone->lock)-
>rlock);
[24438.678951][    T2]                                lock(batched_entropy_u64.l
ock);
[24438.679038][    T2]   lock(random_write_wait.lock);
[24438.679098][    T2] 
[24438.679098][    T2]  *** DEADLOCK ***
[24438.679098][    T2] 
[24438.679174][    T2] 1 lock held by kthreadd/2:
[24438.679230][    T2]  #0: c000001ffd2f06e0 (batched_entropy_u64.lock){-...},
at: get_random_u64+0x60/0x100
[24438.679341][    T2] 
[24438.679341][    T2] stack backtrace:
[24438.679413][    T2] CPU: 13 PID: 2 Comm: kthreadd Not tainted 5.3.0-next-
20190924 #2
[24438.679485][    T2] Call Trace:
[24438.679507][    T2] [c00000002c84efe0] [c00000000091a574]
dump_stack+0xe8/0x164 (unreliable)
[24438.679618][    T2] [c00000002c84f030] [c0000000001cc9b8]
print_circular_bug+0x3a8/0x420
[24438.679701][    T2] [c00000002c84f0e0] [c0000000001ccc90]
check_noncircular+0x260/0x320
[24438.679769][    T2] [c00000002c84f1e0] [c0000000001ce7e0]
check_prev_add+0x100/0x11b0
[24438.679868][    T2] [c00000002c84f2c0] [c0000000001d00f8]
validate_chain+0x868/0x1530
[24438.679950][    T2] [c00000002c84f3f0] [c0000000001d3064]
__lock_acquire+0x5b4/0xbf0
[24438.680059][    T2] [c00000002c84f4f0] [c0000000001d3ed0]
lock_acquire+0x130/0x360
[24438.680122][    T2] [c00000002c84f5d0] [c000000000947d70]
_raw_spin_lock_irqsave+0x70/0xa0
[24438.680207][    T2] [c00000002c84f610] [c0000000001a9488]
__wake_up_common_lock+0x88/0x110
[24438.680298][    T2] [c00000002c84f690] [c0000000006f11a4]
account.constprop.8+0x284/0x430
[24438.680399][    T2] [c00000002c84f750] [c0000000006f1554]
extract_entropy.constprop.7+0xd4/0x330
[24438.680495][    T2] [c00000002c84f7d0] [c0000000006f1818]
crng_reseed+0x68/0x490
[24438.680590][    T2] [c00000002c84f910] [c0000000006f4094]
_extract_crng+0x104/0x110
[24438.680662][    T2] [c00000002c84f950] [c0000000006f1a34]
crng_reseed+0x284/0x490
[24438.680751][    T2] [c00000002c84fa90] [c0000000006f4094]
_extract_crng+0x104/0x110
[24438.680828][    T2] [c00000002c84fad0] [c0000000006f4c0c]
get_random_u64+0xdc/0x100
[24438.680931][    T2] [c00000002c84fb10] [c000000000106988]
copy_process+0x2d8/0x1bf0
[24438.681007][    T2] [c00000002c84fc30] [c00000000010861c] _do_fork+0xac/0xac0
[24438.681074][    T2] [c00000002c84fd10] [c0000000001090d0]
kernel_thread+0x70/0xa0
[24438.681170][    T2] [c00000002c84fd80] [c0000000001518f0]
kthreadd+0x270/0x330
[24438.681257][    T2] [c00000002c84fe20] [c00000000000b748]
ret_from_kernel_thread+0x5c/0x74

> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 63900ca029e0..ec1d72f18b34 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6027,10 +6027,11 @@ void init_idle(struct task_struct *idle, int cpu)
>  	struct rq *rq = cpu_rq(cpu);
>  	unsigned long flags;
>  
> +	__sched_fork(0, idle);
> +
>  	raw_spin_lock_irqsave(&idle->pi_lock, flags);
>  	raw_spin_lock(&rq->lock);
>  
> -	__sched_fork(0, idle);
>  	idle->state = TASK_RUNNING;
>  	idle->se.exec_start = sched_clock();
>  	idle->flags |= PF_IDLE;
