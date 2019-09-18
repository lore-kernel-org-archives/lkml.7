Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB8DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED8D21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LdZ3+5kZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfIROjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:39:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40945 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIROjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:39:44 -0400
Received: by mail-qk1-f193.google.com with SMTP id y144so8272208qkb.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39TMjm09PPJULcfPTY3RKiwrDA/uqRh1/RHxmc+MCjU=;
        b=LdZ3+5kZOiOmJf6GE1ZAenwp5s+4qnyzmsIkBEdjFlOYGofFjpbVt8QybKV34iB80P
         WyWA+SmuwEL5SOTnWswld1djbBOEoZaHy833XFAXPzDOPro49K72ZFXRhZA6UX+IwvAd
         AdoeU2qt8hGjP08J/LavkZNVkn+bKq7QQevtzf3OFcH4JJ6GR/1fNk9zXGtAictc3hX3
         dJRzA2/hzQ93xh+eM2JndWf9OdeRSpi30U0rWjI3NfWcW9UWMah5uCV6mQyqF/UHxu0w
         dhJ6y397/EW3/TWDkAl1LYfiT9b5b11uQB6bzp5b6NvejgnRznFB59pTdPUflnDuWT4L
         IMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39TMjm09PPJULcfPTY3RKiwrDA/uqRh1/RHxmc+MCjU=;
        b=qB9HJYfg1dgAp396RUtzbu53YdF/JWHEH0wx3N6eFzRADGscnlVWmmy4zc2YzNmOwA
         ZIU7jpoS4vXNVZ5g2OojcWnmb6PSXNFe9XaVwbeZidk81vENFTcpB9ggyXjsriF9SODV
         VmpCI52rG9cRZkJf516m3Q1qIU1H7W5DJxL1BhJ2hvJovGXffmsFrpjTeQBeBMUVuREY
         /x5G6bRnIgJwPf7IItiYwki+ZSiuSBXlfNAHa6o4n9iQI0SX8TolsUB54n/1eo6xtYoX
         eMlD2jTWxBWWIrpVq6oAPXG0Sy8UnXPVmLoYPOWuxLk0rUCrBGP/iVDa+Hc/RfMoHYo+
         kp8w==
X-Gm-Message-State: APjAAAUSL9R3Ce+0uPKo44KYQjVOXlLUUN/U/Pr0U4WUoGDOiPqGYbg2
        k0LV/lPlhzvC0VTIqx3kvN7Kng==
X-Google-Smtp-Source: APXvYqw/cj5A7F5rE9ZMYQX2wevZPwfA+g2UL1gtiJk/hkM8gBbrP5EeLce9Y0kR+BLXeJyPa0+G+A==
X-Received: by 2002:a37:a03:: with SMTP id 3mr4052297qkk.405.1568817582926;
        Wed, 18 Sep 2019 07:39:42 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g33sm2681351qtd.12.2019.09.18.07.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 07:39:42 -0700 (PDT)
Message-ID: <1568817579.5576.172.camel@lca.pw>
Subject: printk() + memory offline deadlock (WAS Re: page_alloc.shuffle=1 +
 CONFIG_PROVE_LOCKING=y = arm64 hang)
From:   Qian Cai <cai@lca.pw>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Date:   Wed, 18 Sep 2019 10:39:39 -0400
In-Reply-To: <20190916104239.124fc2e5@gandalf.local.home>
References: <1566509603.5576.10.camel@lca.pw>
         <1567717680.5576.104.camel@lca.pw> <1568128954.5576.129.camel@lca.pw>
         <20190911011008.GA4420@jagdpanzerIV> <1568289941.5576.140.camel@lca.pw>
         <20190916104239.124fc2e5@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-16 at 10:42 -0400, Steven Rostedt wrote:
> On Thu, 12 Sep 2019 08:05:41 -0400
> Qian Cai <cai@lca.pw> wrote:
> 
> > >  drivers/char/random.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > > index 9b54cdb301d3..975015857200 100644
> > > --- a/drivers/char/random.c
> > > +++ b/drivers/char/random.c
> > > @@ -1687,8 +1687,9 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller,
> > >  	print_once = true;
> > >  #endif
> > >  	if (__ratelimit(&unseeded_warning))
> > > -		pr_notice("random: %s called from %pS with crng_init=%d\n",
> > > -			  func_name, caller, crng_init);
> > > +		printk_deferred(KERN_NOTICE "random: %s called from %pS "
> > > +				"with crng_init=%d\n", func_name, caller,
> > > +				crng_init);
> > >  }
> > >  
> > >  /*
> > > @@ -2462,4 +2463,4 @@ void add_bootloader_randomness(const void *buf, unsigned int size)
> > >  	else
> > >  		add_device_randomness(buf, size);
> > >  }
> > > -EXPORT_SYMBOL_GPL(add_bootloader_randomness);
> > > \ No newline at end of file
> > > +EXPORT_SYMBOL_GPL(add_bootloader_randomness);  
> > 
> > This will also fix the hang.
> > 
> > Sergey, do you plan to submit this Ted?
> 
> Perhaps for a quick fix (and a comment that says this needs to be fixed
> properly). I think the changes to printk() that was discussed at
> Plumbers may also solve this properly.

I assume that the new printk() stuff will also fix this deadlock between
printk() and memory offline.

[  317.337595] WARNING: possible circular locking dependency detected
[  317.337596] 5.3.0-next-20190917+ #9 Not tainted
[  317.337597] ------------------------------------------------------
[  317.337597] test.sh/8738 is trying to acquire lock:
[  317.337598] ffffffffb33a4978 ((console_sem).lock){-.-.}, at:
down_trylock+0x16/0x50

[  317.337602] but task is already holding lock:
[  317.337602] ffff88883fff4318 (&(&zone->lock)->rlock){-.-.}, at:
start_isolate_page_range+0x1f7/0x570

[  317.337606] which lock already depends on the new lock.


[  317.337608] the existing dependency chain (in reverse order) is:

[  317.337609] -> #3 (&(&zone->lock)->rlock){-.-.}:
[  317.337612]        __lock_acquire+0x5b3/0xb40
[  317.337613]        lock_acquire+0x126/0x280
[  317.337613]        _raw_spin_lock+0x2f/0x40
[  317.337614]        rmqueue_bulk.constprop.21+0xb6/0x1160
[  317.337615]        get_page_from_freelist+0x898/0x22c0
[  317.337616]        __alloc_pages_nodemask+0x2f3/0x1cd0
[  317.337617]        alloc_page_interleave+0x18/0x130
[  317.337618]        alloc_pages_current+0xf6/0x110
[  317.337619]        allocate_slab+0x4c6/0x19c0
[  317.337620]        new_slab+0x46/0x70
[  317.337621]        ___slab_alloc+0x58b/0x960
[  317.337621]        __slab_alloc+0x43/0x70
[  317.337622]        kmem_cache_alloc+0x354/0x460
[  317.337623]        fill_pool+0x272/0x4b0
[  317.337624]        __debug_object_init+0x86/0x790
[  317.337624]        debug_object_init+0x16/0x20
[  317.337625]        hrtimer_init+0x27/0x1e0
[  317.337626]        init_dl_task_timer+0x20/0x40
[  317.337627]        __sched_fork+0x10b/0x1f0
[  317.337627]        init_idle+0xac/0x520
[  317.337628]        idle_thread_get+0x7c/0xc0
[  317.337629]        bringup_cpu+0x1a/0x1e0
[  317.337630]        cpuhp_invoke_callback+0x197/0x1120
[  317.337630]        _cpu_up+0x171/0x280
[  317.337631]        do_cpu_up+0xb1/0x120
[  317.337632]        cpu_up+0x13/0x20
[  317.337632]        smp_init+0xa4/0x12d
[  317.337633]        kernel_init_freeable+0x37e/0x76e
[  317.337634]        kernel_init+0x11/0x12f
[  317.337635]        ret_from_fork+0x3a/0x50

[  317.337635] -> #2 (&rq->lock){-.-.}:
[  317.337638]        __lock_acquire+0x5b3/0xb40
[  317.337639]        lock_acquire+0x126/0x280
[  317.337639]        _raw_spin_lock+0x2f/0x40
[  317.337640]        task_fork_fair+0x43/0x200
[  317.337641]        sched_fork+0x29b/0x420
[  317.337642]        copy_process+0xf3c/0x2fd0
[  317.337642]        _do_fork+0xef/0x950
[  317.337643]        kernel_thread+0xa8/0xe0
[  317.337644]        rest_init+0x28/0x311
[  317.337645]        arch_call_rest_init+0xe/0x1b
[  317.337645]        start_kernel+0x6eb/0x724
[  317.337646]        x86_64_start_reservations+0x24/0x26
[  317.337647]        x86_64_start_kernel+0xf4/0xfb
[  317.337648]        secondary_startup_64+0xb6/0xc0

[  317.337649] -> #1 (&p->pi_lock){-.-.}:
[  317.337651]        __lock_acquire+0x5b3/0xb40
[  317.337652]        lock_acquire+0x126/0x280
[  317.337653]        _raw_spin_lock_irqsave+0x3a/0x50
[  317.337653]        try_to_wake_up+0xb4/0x1030
[  317.337654]        wake_up_process+0x15/0x20
[  317.337655]        __up+0xaa/0xc0
[  317.337655]        up+0x55/0x60
[  317.337656]        __up_console_sem+0x37/0x60
[  317.337657]        console_unlock+0x3a0/0x750
[  317.337658]        vprintk_emit+0x10d/0x340
[  317.337658]        vprintk_default+0x1f/0x30
[  317.337659]        vprintk_func+0x44/0xd4
[  317.337660]        printk+0x9f/0xc5
[  317.337660]        crng_reseed+0x3cc/0x440
[  317.337661]        credit_entropy_bits+0x3e8/0x4f0
[  317.337662]        random_ioctl+0x1eb/0x250
[  317.337663]        do_vfs_ioctl+0x13e/0xa70
[  317.337663]        ksys_ioctl+0x41/0x80
[  317.337664]        __x64_sys_ioctl+0x43/0x4c
[  317.337665]        do_syscall_64+0xcc/0x76c
[  317.337666]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  317.337667] -> #0 ((console_sem).lock){-.-.}:
[  317.337669]        check_prev_add+0x107/0xea0
[  317.337670]        validate_chain+0x8fc/0x1200
[  317.337671]        __lock_acquire+0x5b3/0xb40
[  317.337671]        lock_acquire+0x126/0x280
[  317.337672]        _raw_spin_lock_irqsave+0x3a/0x50
[  317.337673]        down_trylock+0x16/0x50
[  317.337674]        __down_trylock_console_sem+0x2b/0xa0
[  317.337675]        console_trylock+0x16/0x60
[  317.337676]        vprintk_emit+0x100/0x340
[  317.337677]        vprintk_default+0x1f/0x30
[  317.337678]        vprintk_func+0x44/0xd4
[  317.337678]        printk+0x9f/0xc5
[  317.337679]        __dump_page.cold.2+0x73/0x210
[  317.337680]        dump_page+0x12/0x50
[  317.337680]        has_unmovable_pages+0x3e9/0x4b0
[  317.337681]        start_isolate_page_range+0x3b4/0x570
[  317.337682]        __offline_pages+0x1ad/0xa10
[  317.337683]        offline_pages+0x11/0x20
[  317.337683]        memory_subsys_offline+0x7e/0xc0
[  317.337684]        device_offline+0xd5/0x110
[  317.337685]        state_store+0xc6/0xe0
[  317.337686]        dev_attr_store+0x3f/0x60
[  317.337686]        sysfs_kf_write+0x89/0xb0
[  317.337687]        kernfs_fop_write+0x188/0x240
[  317.337688]        __vfs_write+0x50/0xa0
[  317.337688]        vfs_write+0x105/0x290
[  317.337689]        ksys_write+0xc6/0x160
[  317.337690]        __x64_sys_write+0x43/0x50
[  317.337691]        do_syscall_64+0xcc/0x76c
[  317.337691]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  317.337693] other info that might help us debug this:

[  317.337694] Chain exists of:
[  317.337694]   (console_sem).lock --> &rq->lock --> &(&zone->lock)->rlock

[  317.337699]  Possible unsafe locking scenario:

[  317.337700]        CPU0                    CPU1
[  317.337701]        ----                    ----
[  317.337701]   lock(&(&zone->lock)->rlock);
[  317.337703]                                lock(&rq->lock);
[  317.337705]                                lock(&(&zone->lock)->rlock);
[  317.337706]   lock((console_sem).lock);

[  317.337708]  *** DEADLOCK ***

[  317.337710] 8 locks held by test.sh/8738:
[  317.337710]  #0: ffff8883940b5408 (sb_writers#4){.+.+}, at:
vfs_write+0x25f/0x290
[  317.337713]  #1: ffff889fce310280 (&of->mutex){+.+.}, at:
kernfs_fop_write+0x128/0x240
[  317.337716]  #2: ffff889feb6d4830 (kn->count#115){.+.+}, at:
kernfs_fop_write+0x138/0x240
[  317.337720]  #3: ffffffffb3762d40 (device_hotplug_lock){+.+.}, at:
lock_device_hotplug_sysfs+0x16/0x50
[  317.337723]  #4: ffff88981f0dc990 (&dev->mutex){....}, at:
device_offline+0x70/0x110
[  317.337726]  #5: ffffffffb3315250 (cpu_hotplug_lock.rw_sem){++++}, at:
__offline_pages+0xbf/0xa10
[  317.337729]  #6: ffffffffb35408b0 (mem_hotplug_lock.rw_sem){++++}, at:
percpu_down_write+0x87/0x2f0
[  317.337732]  #7: ffff88883fff4318 (&(&zone->lock)->rlock){-.-.}, at:
start_isolate_page_range+0x1f7/0x570
[  317.337736] stack backtrace:
[  317.337737] CPU: 58 PID: 8738 Comm: test.sh Not tainted 5.3.0-next-20190917+
#9
[  317.337738] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10,
BIOS U34 05/21/2019
[  317.337739] Call Trace:
[  317.337739]  dump_stack+0x86/0xca
[  317.337740]  print_circular_bug.cold.31+0x243/0x26e
[  317.337741]  check_noncircular+0x29e/0x2e0
[  317.337742]  ? debug_lockdep_rcu_enabled+0x4b/0x60
[  317.337742]  ? print_circular_bug+0x120/0x120
[  317.337743]  ? is_ftrace_trampoline+0x9/0x20
[  317.337744]  ? kernel_text_address+0x59/0xc0
[  317.337744]  ? __kernel_text_address+0x12/0x40
[  317.337745]  check_prev_add+0x107/0xea0
[  317.337746]  validate_chain+0x8fc/0x1200
[  317.337746]  ? check_prev_add+0xea0/0xea0
[  317.337747]  ? format_decode+0xd6/0x600
[  317.337748]  ? file_dentry_name+0xe0/0xe0
[  317.337749]  __lock_acquire+0x5b3/0xb40
[  317.337749]  lock_acquire+0x126/0x280
[  317.337750]  ? down_trylock+0x16/0x50
[  317.337751]  ? vprintk_emit+0x100/0x340
[  317.337752]  _raw_spin_lock_irqsave+0x3a/0x50
[  317.337753]  ? down_trylock+0x16/0x50
[  317.337753]  down_trylock+0x16/0x50
[  317.337754]  ? vprintk_emit+0x100/0x340
[  317.337755]  __down_trylock_console_sem+0x2b/0xa0
[  317.337756]  console_trylock+0x16/0x60
[  317.337756]  vprintk_emit+0x100/0x340
[  317.337757]  vprintk_default+0x1f/0x30
[  317.337758]  vprintk_func+0x44/0xd4
[  317.337758]  printk+0x9f/0xc5
[  317.337759]  ? kmsg_dump_rewind_nolock+0x64/0x64
[  317.337760]  ? __dump_page+0x1d7/0x430
[  317.337760]  __dump_page.cold.2+0x73/0x210
[  317.337761]  dump_page+0x12/0x50
[  317.337762]  has_unmovable_pages+0x3e9/0x4b0
[  317.337763]  start_isolate_page_range+0x3b4/0x570
[  317.337763]  ? unset_migratetype_isolate+0x280/0x280
[  317.337764]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  317.337765]  __offline_pages+0x1ad/0xa10
[  317.337765]  ? lock_acquire+0x126/0x280
[  317.337766]  ? __add_memory+0xc0/0xc0
[  317.337767]  ? __kasan_check_write+0x14/0x20
[  317.337767]  ? __mutex_lock+0x344/0xcd0
[  317.337768]  ? _raw_spin_unlock_irqrestore+0x49/0x50
[  317.337769]  ? device_offline+0x70/0x110
[  317.337770]  ? klist_next+0x1c1/0x1e0
[  317.337770]  ? __mutex_add_waiter+0xc0/0xc0
[  317.337771]  ? klist_next+0x10b/0x1e0
[  317.337772]  ? klist_iter_exit+0x16/0x40
[  317.337772]  ? device_for_each_child+0xd0/0x110
[  317.337773]  offline_pages+0x11/0x20
[  317.337774]  memory_subsys_offline+0x7e/0xc0
[  317.337774]  device_offline+0xd5/0x110
[  317.337775]  ? auto_online_blocks_show+0x70/0x70
[  317.337776]  state_store+0xc6/0xe0
[  317.337776]  dev_attr_store+0x3f/0x60
[  317.337777]  ? device_match_name+0x40/0x40
[  317.337778]  sysfs_kf_write+0x89/0xb0
[  317.337778]  ? sysfs_file_ops+0xa0/0xa0
[  317.337779]  kernfs_fop_write+0x188/0x240
[  317.337780]  __vfs_write+0x50/0xa0
[  317.337780]  vfs_write+0x105/0x290
[  317.337781]  ksys_write+0xc6/0x160
[  317.337782]  ? __x64_sys_read+0x50/0x50
[  317.337782]  ? do_syscall_64+0x79/0x76c
[  317.337783]  ? do_syscall_64+0x79/0x76c
[  317.337784]  __x64_sys_write+0x43/0x50
[  317.337784]  do_syscall_64+0xcc/0x76c
[  317.337785]  ? trace_hardirqs_on_thunk+0x1a/0x20
[  317.337786]  ? syscall_return_slowpath+0x210/0x210
[  317.337787]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
[  317.337787]  ? trace_hardirqs_off_caller+0x3a/0x150
[  317.337788]  ? trace_hardirqs_off_thunk+0x1a/0x20
[  317.337789]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
