Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0058C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF592207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNze13Zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbfIRPvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:51:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33625 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387526AbfIRPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:51:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id t11so166252plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jTTWKpsvlDAAGPBEiAK3KNt1r6uKkJveEDVY0RCCMk8=;
        b=DNze13ZqH9jWL1S269TGdPGoDbwatxps0RjOVStSzrkveCBcc5wDJiADRZISQeMum2
         j2pcdEW7ldqhqBlPeQQHGam2bcOVcFM4AqM7lyLby2iK5yHUr5cbxdsCSUYx16MB0wVB
         H8BlefBaDZuC+3U6EefprdmbHebqVCOYNAT6HneMAqhlA/KsIylyrS+ht21twDTnrAmF
         6FXwK4s1elerP7UJQjTZ95F1enoq95yQR1ulYypA7p3BtOmAe7hIJbmEc7zSx+1c/y3p
         GfdNvGtShvpfLkx7qQNrBIaZCQO9cPpU+xDFY67JGCu0gvgcO/a+vMVErM52/QfxH2WG
         uMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jTTWKpsvlDAAGPBEiAK3KNt1r6uKkJveEDVY0RCCMk8=;
        b=gCQgJ2kST4IYtGult3WgQTO22Y2Hx1Chk2ULTQIrSFyxvSIogO9KTlN60KSvzog9Hg
         c+nsMntwEw205ysI8/Dc6UUTGZHXLyNAp6UcVkG1aMk0DLcNKQ9OXIvst/iuhbyyYFXD
         OOspp552eq/kUAzGnmv2XJ5KnGXlzKMoucVWRk6RtKb6MXtUeFulmh53vP/9mbFNeVIC
         RTmLQrkKC9F7NYIqH06Pa8hAbLnifAz+njMUjcneaGFtGZUus/FE07vPBGJAh0VxEwzG
         ve5q6HBntcpaXn2p50QkMb0WC5WJkCqbOXW8ttVeOq2o+SoCI4Y4rA4wBbX6+Esx5Jra
         jgUA==
X-Gm-Message-State: APjAAAVZoC5LH82vGIujCnaJcWwxC8nC435ZVUfPWXZamqhkVQ4nE3Be
        P0G4KvuKXa3YL2AmlqBRaJU=
X-Google-Smtp-Source: APXvYqyIKJEjwnZ+fBfJHBVtZs1ScWtbuqV0j9hLldeHtCy7n5HIQLT2YNa80/DMuOUunnEA2S0png==
X-Received: by 2002:a17:902:7c14:: with SMTP id x20mr4834409pll.289.1568821862962;
        Wed, 18 Sep 2019 08:51:02 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id 4sm2489770pja.29.2019.09.18.08.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 08:51:01 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 19 Sep 2019 00:50:59 +0900
To:     Qian Cai <cai@lca.pw>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: printk() + memory offline deadlock (WAS Re: page_alloc.shuffle=1
 + CONFIG_PROVE_LOCKING=y = arm64 hang)
Message-ID: <20190918155059.GA158834@tigerII.localdomain>
References: <1566509603.5576.10.camel@lca.pw>
 <1567717680.5576.104.camel@lca.pw>
 <1568128954.5576.129.camel@lca.pw>
 <20190911011008.GA4420@jagdpanzerIV>
 <1568289941.5576.140.camel@lca.pw>
 <20190916104239.124fc2e5@gandalf.local.home>
 <1568817579.5576.172.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568817579.5576.172.camel@lca.pw>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/18/19 10:39), Qian Cai wrote:
> > Perhaps for a quick fix (and a comment that says this needs to be fixed
> > properly). I think the changes to printk() that was discussed at
> > Plumbers may also solve this properly.
> 
> I assume that the new printk() stuff will also fix this deadlock between
> printk() and memory offline.

Mother chicken...

Do you actually see a deadlock? I'd rather expect a lockdep splat, but
anyway...

> [  317.337595] WARNING: possible circular locking dependency detected
> [  317.337596] 5.3.0-next-20190917+ #9 Not tainted
> [  317.337597] ------------------------------------------------------
> [  317.337597] test.sh/8738 is trying to acquire lock:
> [  317.337598] ffffffffb33a4978 ((console_sem).lock){-.-.}, at:> down_trylock+0x16/0x50
> 
> [  317.337602] but task is already holding lock:
> [  317.337602] ffff88883fff4318 (&(&zone->lock)->rlock){-.-.}, at:> start_isolate_page_range+0x1f7/0x570
> 
> [  317.337606] which lock already depends on the new lock.
>
> [  317.337608] the existing dependency chain (in reverse order) is:
> 
> [  317.337609] -> #3 (&(&zone->lock)->rlock){-.-.}:
> [  317.337612]        __lock_acquire+0x5b3/0xb40
> [  317.337613]        lock_acquire+0x126/0x280
> [  317.337613]        _raw_spin_lock+0x2f/0x40
> [  317.337614]        rmqueue_bulk.constprop.21+0xb6/0x1160
> [  317.337615]        get_page_from_freelist+0x898/0x22c0
> [  317.337616]        __alloc_pages_nodemask+0x2f3/0x1cd0
> [  317.337617]        alloc_page_interleave+0x18/0x130
> [  317.337618]        alloc_pages_current+0xf6/0x110
> [  317.337619]        allocate_slab+0x4c6/0x19c0
> [  317.337620]        new_slab+0x46/0x70
> [  317.337621]        ___slab_alloc+0x58b/0x960
> [  317.337621]        __slab_alloc+0x43/0x70
> [  317.337622]        kmem_cache_alloc+0x354/0x460
> [  317.337623]        fill_pool+0x272/0x4b0
> [  317.337624]        __debug_object_init+0x86/0x790
> [  317.337624]        debug_object_init+0x16/0x20
> [  317.337625]        hrtimer_init+0x27/0x1e0
> [  317.337626]        init_dl_task_timer+0x20/0x40
> [  317.337627]        __sched_fork+0x10b/0x1f0
> [  317.337627]        init_idle+0xac/0x520
> [  317.337628]        idle_thread_get+0x7c/0xc0
> [  317.337629]        bringup_cpu+0x1a/0x1e0
> [  317.337630]        cpuhp_invoke_callback+0x197/0x1120
> [  317.337630]        _cpu_up+0x171/0x280
> [  317.337631]        do_cpu_up+0xb1/0x120
> [  317.337632]        cpu_up+0x13/0x20
> [  317.337632]        smp_init+0xa4/0x12d
> [  317.337633]        kernel_init_freeable+0x37e/0x76e
> [  317.337634]        kernel_init+0x11/0x12f
> [  317.337635]        ret_from_fork+0x3a/0x50

So you have debug objects enabled. Right? This thing does not behave
when it comes to printing. debug_objects are slightly problematic.

This thing does

	rq->lock --> zone->lock

It takes rq->lock and then calls into __sched_fork()->hrtimer_init()->debug_objects()->MM

This doesn't look very right - a dive into MM under rq->lock.

Peter, Thomas am I wrong?

> [  317.337635] -> #2 (&rq->lock){-.-.}:
> [  317.337638]        __lock_acquire+0x5b3/0xb40
> [  317.337639]        lock_acquire+0x126/0x280
> [  317.337639]        _raw_spin_lock+0x2f/0x40
> [  317.337640]        task_fork_fair+0x43/0x200
> [  317.337641]        sched_fork+0x29b/0x420
> [  317.337642]        copy_process+0xf3c/0x2fd0
> [  317.337642]        _do_fork+0xef/0x950
> [  317.337643]        kernel_thread+0xa8/0xe0
> [  317.337644]        rest_init+0x28/0x311
> [  317.337645]        arch_call_rest_init+0xe/0x1b
> [  317.337645]        start_kernel+0x6eb/0x724
> [  317.337646]        x86_64_start_reservations+0x24/0x26
> [  317.337647]        x86_64_start_kernel+0xf4/0xfb
> [  317.337648]        secondary_startup_64+0xb6/0xc0

pi_lock --> rq->lock

> [  317.337649] -> #1 (&p->pi_lock){-.-.}:
> [  317.337651]        __lock_acquire+0x5b3/0xb40
> [  317.337652]        lock_acquire+0x126/0x280
> [  317.337653]        _raw_spin_lock_irqsave+0x3a/0x50
> [  317.337653]        try_to_wake_up+0xb4/0x1030
> [  317.337654]        wake_up_process+0x15/0x20
> [  317.337655]        __up+0xaa/0xc0
> [  317.337655]        up+0x55/0x60
> [  317.337656]        __up_console_sem+0x37/0x60
> [  317.337657]        console_unlock+0x3a0/0x750
> [  317.337658]        vprintk_emit+0x10d/0x340
> [  317.337658]        vprintk_default+0x1f/0x30
> [  317.337659]        vprintk_func+0x44/0xd4
> [  317.337660]        printk+0x9f/0xc5
> [  317.337660]        crng_reseed+0x3cc/0x440
> [  317.337661]        credit_entropy_bits+0x3e8/0x4f0
> [  317.337662]        random_ioctl+0x1eb/0x250
> [  317.337663]        do_vfs_ioctl+0x13e/0xa70
> [  317.337663]        ksys_ioctl+0x41/0x80
> [  317.337664]        __x64_sys_ioctl+0x43/0x4c
> [  317.337665]        do_syscall_64+0xcc/0x76c
> [  317.337666]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

console_sem->lock --> pi_lock

This also covers console_sem->lock --> rq->lock, and maintains
pi_lock --> rq->lock

So we have

	console_sem->lock --> pi_lock --> rq->lock

> [  317.337667] -> #0 ((console_sem).lock){-.-.}:
> [  317.337669]        check_prev_add+0x107/0xea0
> [  317.337670]        validate_chain+0x8fc/0x1200
> [  317.337671]        __lock_acquire+0x5b3/0xb40
> [  317.337671]        lock_acquire+0x126/0x280
> [  317.337672]        _raw_spin_lock_irqsave+0x3a/0x50
> [  317.337673]        down_trylock+0x16/0x50
> [  317.337674]        __down_trylock_console_sem+0x2b/0xa0
> [  317.337675]        console_trylock+0x16/0x60
> [  317.337676]        vprintk_emit+0x100/0x340
> [  317.337677]        vprintk_default+0x1f/0x30
> [  317.337678]        vprintk_func+0x44/0xd4
> [  317.337678]        printk+0x9f/0xc5
> [  317.337679]        __dump_page.cold.2+0x73/0x210
> [  317.337680]        dump_page+0x12/0x50
> [  317.337680]        has_unmovable_pages+0x3e9/0x4b0
> [  317.337681]        start_isolate_page_range+0x3b4/0x570
> [  317.337682]        __offline_pages+0x1ad/0xa10
> [  317.337683]        offline_pages+0x11/0x20
> [  317.337683]        memory_subsys_offline+0x7e/0xc0
> [  317.337684]        device_offline+0xd5/0x110
> [  317.337685]        state_store+0xc6/0xe0
> [  317.337686]        dev_attr_store+0x3f/0x60
> [  317.337686]        sysfs_kf_write+0x89/0xb0
> [  317.337687]        kernfs_fop_write+0x188/0x240
> [  317.337688]        __vfs_write+0x50/0xa0
> [  317.337688]        vfs_write+0x105/0x290
> [  317.337689]        ksys_write+0xc6/0x160
> [  317.337690]        __x64_sys_write+0x43/0x50
> [  317.337691]        do_syscall_64+0xcc/0x76c
> [  317.337691]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

zone->lock --> console_sem->lock

So then we have

	zone->lock --> console_sem->lock --> pi_lock --> rq->lock

  vs. the reverse chain

	rq->lock --> console_sem->lock

If I get this right.

> [  317.337693] other info that might help us debug this:
> 
> [  317.337694] Chain exists of:
> [  317.337694]   (console_sem).lock --> &rq->lock --> &(&zone->lock)->rlock
> 
> [  317.337699]  Possible unsafe locking scenario:
> 
> [  317.337700]        CPU0                    CPU1
> [  317.337701]        ----                    ----
> [  317.337701]   lock(&(&zone->lock)->rlock);
> [  317.337703]                                lock(&rq->lock);
> [  317.337705]                                lock(&(&zone->lock)->rlock);
> [  317.337706]   lock((console_sem).lock);
>
> [  317.337708]  *** DEADLOCK ***
> 
> [  317.337710] 8 locks held by test.sh/8738:
> [  317.337710]  #0: ffff8883940b5408 (sb_writers#4){.+.+}, at: vfs_write+0x25f/0x290
> [  317.337713]  #1: ffff889fce310280 (&of->mutex){+.+.}, at: kernfs_fop_write+0x128/0x240
> [  317.337716]  #2: ffff889feb6d4830 (kn->count#115){.+.+}, at: kernfs_fop_write+0x138/0x240
> [  317.337720]  #3: ffffffffb3762d40 (device_hotplug_lock){+.+.}, at: lock_device_hotplug_sysfs+0x16/0x50
> [  317.337723]  #4: ffff88981f0dc990 (&dev->mutex){....}, at: device_offline+0x70/0x110
> [  317.337726]  #5: ffffffffb3315250 (cpu_hotplug_lock.rw_sem){++++}, at: __offline_pages+0xbf/0xa10
> [  317.337729]  #6: ffffffffb35408b0 (mem_hotplug_lock.rw_sem){++++}, at:  percpu_down_write+0x87/0x2f0
> [  317.337732]  #7: ffff88883fff4318 (&(&zone->lock)->rlock){-.-.}, at: start_isolate_page_range+0x1f7/0x570
> [  317.337736] stack backtrace:
> [  317.337737] CPU: 58 PID: 8738 Comm: test.sh Not tainted 5.3.0-next-20190917+ #9
> [  317.337738] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10, BIOS U34 05/21/2019
> [  317.337739] Call Trace:
> [  317.337739]  dump_stack+0x86/0xca
> [  317.337740]  print_circular_bug.cold.31+0x243/0x26e
> [  317.337741]  check_noncircular+0x29e/0x2e0
> [  317.337742]  ? debug_lockdep_rcu_enabled+0x4b/0x60
> [  317.337742]  ? print_circular_bug+0x120/0x120
> [  317.337743]  ? is_ftrace_trampoline+0x9/0x20
> [  317.337744]  ? kernel_text_address+0x59/0xc0
> [  317.337744]  ? __kernel_text_address+0x12/0x40
> [  317.337745]  check_prev_add+0x107/0xea0
> [  317.337746]  validate_chain+0x8fc/0x1200
> [  317.337746]  ? check_prev_add+0xea0/0xea0
> [  317.337747]  ? format_decode+0xd6/0x600
> [  317.337748]  ? file_dentry_name+0xe0/0xe0
> [  317.337749]  __lock_acquire+0x5b3/0xb40
> [  317.337749]  lock_acquire+0x126/0x280
> [  317.337750]  ? down_trylock+0x16/0x50
> [  317.337751]  ? vprintk_emit+0x100/0x340
> [  317.337752]  _raw_spin_lock_irqsave+0x3a/0x50
> [  317.337753]  ? down_trylock+0x16/0x50
> [  317.337753]  down_trylock+0x16/0x50
> [  317.337754]  ? vprintk_emit+0x100/0x340
> [  317.337755]  __down_trylock_console_sem+0x2b/0xa0
> [  317.337756]  console_trylock+0x16/0x60
> [  317.337756]  vprintk_emit+0x100/0x340
> [  317.337757]  vprintk_default+0x1f/0x30
> [  317.337758]  vprintk_func+0x44/0xd4
> [  317.337758]  printk+0x9f/0xc5
> [  317.337759]  ? kmsg_dump_rewind_nolock+0x64/0x64
> [  317.337760]  ? __dump_page+0x1d7/0x430
> [  317.337760]  __dump_page.cold.2+0x73/0x210
> [  317.337761]  dump_page+0x12/0x50
> [  317.337762]  has_unmovable_pages+0x3e9/0x4b0
> [  317.337763]  start_isolate_page_range+0x3b4/0x570
> [  317.337763]  ? unset_migratetype_isolate+0x280/0x280
> [  317.337764]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [  317.337765]  __offline_pages+0x1ad/0xa10
> [  317.337765]  ? lock_acquire+0x126/0x280
> [  317.337766]  ? __add_memory+0xc0/0xc0
> [  317.337767]  ? __kasan_check_write+0x14/0x20
> [  317.337767]  ? __mutex_lock+0x344/0xcd0
> [  317.337768]  ? _raw_spin_unlock_irqrestore+0x49/0x50
> [  317.337769]  ? device_offline+0x70/0x110
> [  317.337770]  ? klist_next+0x1c1/0x1e0
> [  317.337770]  ? __mutex_add_waiter+0xc0/0xc0
> [  317.337771]  ? klist_next+0x10b/0x1e0
> [  317.337772]  ? klist_iter_exit+0x16/0x40
> [  317.337772]  ? device_for_each_child+0xd0/0x110
> [  317.337773]  offline_pages+0x11/0x20
> [  317.337774]  memory_subsys_offline+0x7e/0xc0
> [  317.337774]  device_offline+0xd5/0x110
> [  317.337775]  ? auto_online_blocks_show+0x70/0x70
> [  317.337776]  state_store+0xc6/0xe0
> [  317.337776]  dev_attr_store+0x3f/0x60
> [  317.337777]  ? device_match_name+0x40/0x40
> [  317.337778]  sysfs_kf_write+0x89/0xb0
> [  317.337778]  ? sysfs_file_ops+0xa0/0xa0
> [  317.337779]  kernfs_fop_write+0x188/0x240
> [  317.337780]  __vfs_write+0x50/0xa0
> [  317.337780]  vfs_write+0x105/0x290
> [  317.337781]  ksys_write+0xc6/0x160
> [  317.337782]  ? __x64_sys_read+0x50/0x50
> [  317.337782]  ? do_syscall_64+0x79/0x76c
> [  317.337783]  ? do_syscall_64+0x79/0x76c
> [  317.337784]  __x64_sys_write+0x43/0x50
> [  317.337784]  do_syscall_64+0xcc/0x76c
> [  317.337785]  ? trace_hardirqs_on_thunk+0x1a/0x20
> [  317.337786]  ? syscall_return_slowpath+0x210/0x210
> [  317.337787]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
> [  317.337787]  ? trace_hardirqs_off_caller+0x3a/0x150
> [  317.337788]  ? trace_hardirqs_off_thunk+0x1a/0x20
> [  317.337789]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Lovely.

	-ss
