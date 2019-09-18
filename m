Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0AEC4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBA521907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Pm+DD6fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbfIRQKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:10:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38657 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbfIRQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:10:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id j31so402354qta.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wcdh1E3aDcYW0VSo8zkDu4fdNQyYVFyK9x/zIDboSWw=;
        b=Pm+DD6fyBaDRH9/9ombjQP1DOIq/QHt+R642N07n1j75i+TRqduBUrcF3T5FxNs/rE
         nvnAmGsROERoTg9uk2j58G1lUQER3RgDOZWlo314/HZYe6bXIdPnG0k8SA96wrZBruXJ
         4zIw9w5rKQ+mV9+Pc4n0t9K9HCGI7tVzzwLvKgbxVVm3ZGq8wTkYDeHfcik0U8b7qUTl
         4BaHq5hRvn+AjwUNwQgFwnll1S5uvK33S7WEuQYVTcZq+iShaYPSIP2D78ohmr3vB6Q3
         1+A2GMgafnknanZIzaubuPsQFo+abZyMJjCZU5+VgNYB7DC1OmwAch68ipHmYEBHmt8v
         x7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wcdh1E3aDcYW0VSo8zkDu4fdNQyYVFyK9x/zIDboSWw=;
        b=cXrGpiR6l5cu9bZNhAbLUn1AmhACN3uf7PTxxjUeEFEDk+0/9MRQv9YyQJw5wNQZ6m
         2duUmJWpuzIh/n8fjYe5Z7X2O5G3Dm5U4S8MQ8gtuKYpyGA5hCVsxSbrJNIK+Lj3l3vY
         o+uajv13yNO0W6O+KEjN+MOlCLKTA3e7cfxpA7uy1tEPzVsWxp4ivvT2vkg3dhW1G1Xk
         ZCYge+gkntbhVQsDZ63rffIsRMxEyNMKrGBB7WPOb6W6EvKQxAOtL2gWns3xtdx+/Eye
         nd0SdN64nvS79or26xo1/tQmMF0vTcj9iMeeiBl23IZG0OsnN07xYmUqngaDtAL8Wcjk
         p1eA==
X-Gm-Message-State: APjAAAUScUkP1dWZOwxS122j8IJ7NbgbDb5r1E5n2Zq6HxZSkEbrmfY+
        OVf0lGnktgS64n9cZMg0fGzu1Q==
X-Google-Smtp-Source: APXvYqyaH93fYHIG6xa1m+FEZkUpm4C5q/0Zr7v8YJm6TmtzMm+yOIdVbq0S20WswcMaRcxxBNumrg==
X-Received: by 2002:ac8:1289:: with SMTP id y9mr4817062qti.201.1568823009560;
        Wed, 18 Sep 2019 09:10:09 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z12sm3318291qkg.97.2019.09.18.09.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 09:10:08 -0700 (PDT)
Message-ID: <1568823006.5576.178.camel@lca.pw>
Subject: Re: printk() + memory offline deadlock (WAS Re:
 page_alloc.shuffle=1 + CONFIG_PROVE_LOCKING=y = arm64 hang)
From:   Qian Cai <cai@lca.pw>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
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
Date:   Wed, 18 Sep 2019 12:10:06 -0400
In-Reply-To: <20190918155059.GA158834@tigerII.localdomain>
References: <1566509603.5576.10.camel@lca.pw>
         <1567717680.5576.104.camel@lca.pw> <1568128954.5576.129.camel@lca.pw>
         <20190911011008.GA4420@jagdpanzerIV> <1568289941.5576.140.camel@lca.pw>
         <20190916104239.124fc2e5@gandalf.local.home>
         <1568817579.5576.172.camel@lca.pw>
         <20190918155059.GA158834@tigerII.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-19 at 00:50 +0900, Sergey Senozhatsky wrote:
> On (09/18/19 10:39), Qian Cai wrote:
> > > Perhaps for a quick fix (and a comment that says this needs to be fixed
> > > properly). I think the changes to printk() that was discussed at
> > > Plumbers may also solve this properly.
> > 
> > I assume that the new printk() stuff will also fix this deadlock between
> > printk() and memory offline.
> 
> Mother chicken...
> 
> Do you actually see a deadlock? I'd rather expect a lockdep splat, but
> anyway...

Not yet, just a lockdep splat so far.

> 
> > [  317.337595] WARNING: possible circular locking dependency detected
> > [  317.337596] 5.3.0-next-20190917+ #9 Not tainted
> > [  317.337597] ------------------------------------------------------
> > [  317.337597] test.sh/8738 is trying to acquire lock:
> > [  317.337598] ffffffffb33a4978 ((console_sem).lock){-.-.}, at:> down_trylock+0x16/0x50
> > 
> > [  317.337602] but task is already holding lock:
> > [  317.337602] ffff88883fff4318 (&(&zone->lock)->rlock){-.-.}, at:> start_isolate_page_range+0x1f7/0x570
> > 
> > [  317.337606] which lock already depends on the new lock.
> > 
> > [  317.337608] the existing dependency chain (in reverse order) is:
> > 
> > [  317.337609] -> #3 (&(&zone->lock)->rlock){-.-.}:
> > [  317.337612]        __lock_acquire+0x5b3/0xb40
> > [  317.337613]        lock_acquire+0x126/0x280
> > [  317.337613]        _raw_spin_lock+0x2f/0x40
> > [  317.337614]        rmqueue_bulk.constprop.21+0xb6/0x1160
> > [  317.337615]        get_page_from_freelist+0x898/0x22c0
> > [  317.337616]        __alloc_pages_nodemask+0x2f3/0x1cd0
> > [  317.337617]        alloc_page_interleave+0x18/0x130
> > [  317.337618]        alloc_pages_current+0xf6/0x110
> > [  317.337619]        allocate_slab+0x4c6/0x19c0
> > [  317.337620]        new_slab+0x46/0x70
> > [  317.337621]        ___slab_alloc+0x58b/0x960
> > [  317.337621]        __slab_alloc+0x43/0x70
> > [  317.337622]        kmem_cache_alloc+0x354/0x460
> > [  317.337623]        fill_pool+0x272/0x4b0
> > [  317.337624]        __debug_object_init+0x86/0x790
> > [  317.337624]        debug_object_init+0x16/0x20
> > [  317.337625]        hrtimer_init+0x27/0x1e0
> > [  317.337626]        init_dl_task_timer+0x20/0x40
> > [  317.337627]        __sched_fork+0x10b/0x1f0
> > [  317.337627]        init_idle+0xac/0x520
> > [  317.337628]        idle_thread_get+0x7c/0xc0
> > [  317.337629]        bringup_cpu+0x1a/0x1e0
> > [  317.337630]        cpuhp_invoke_callback+0x197/0x1120
> > [  317.337630]        _cpu_up+0x171/0x280
> > [  317.337631]        do_cpu_up+0xb1/0x120
> > [  317.337632]        cpu_up+0x13/0x20
> > [  317.337632]        smp_init+0xa4/0x12d
> > [  317.337633]        kernel_init_freeable+0x37e/0x76e
> > [  317.337634]        kernel_init+0x11/0x12f
> > [  317.337635]        ret_from_fork+0x3a/0x50
> 
> So you have debug objects enabled. Right? This thing does not behave
> when it comes to printing. debug_objects are slightly problematic.

Yes, but there is an also a similar splat without the debug_objects. It looks
like anything try to allocate memory in that path will trigger it anyway.

[  297.425908] WARNING: possible circular locking dependency detected
[  297.425908] 5.3.0-next-20190917 #8 Not tainted
[  297.425909] ------------------------------------------------------
[  297.425910] test.sh/8653 is trying to acquire lock:
[  297.425911] ffffffff865a4460 (console_owner){-.-.}, at:
console_unlock+0x207/0x750

[  297.425914] but task is already holding lock:
[  297.425915] ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
__offline_isolated_pages+0x179/0x3e0

[  297.425919] which lock already depends on the new lock.


[  297.425920] the existing dependency chain (in reverse order) is:

[  297.425922] -> #3 (&(&zone->lock)->rlock){-.-.}:
[  297.425925]        __lock_acquire+0x5b3/0xb40
[  297.425925]        lock_acquire+0x126/0x280
[  297.425926]        _raw_spin_lock+0x2f/0x40
[  297.425927]        rmqueue_bulk.constprop.21+0xb6/0x1160
[  297.425928]        get_page_from_freelist+0x898/0x22c0
[  297.425928]        __alloc_pages_nodemask+0x2f3/0x1cd0
[  297.425929]        alloc_pages_current+0x9c/0x110
[  297.425930]        allocate_slab+0x4c6/0x19c0
[  297.425931]        new_slab+0x46/0x70
[  297.425931]        ___slab_alloc+0x58b/0x960
[  297.425932]        __slab_alloc+0x43/0x70
[  297.425933]        __kmalloc+0x3ad/0x4b0
[  297.425933]        __tty_buffer_request_room+0x100/0x250
[  297.425934]        tty_insert_flip_string_fixed_flag+0x67/0x110
[  297.425935]        pty_write+0xa2/0xf0
[  297.425936]        n_tty_write+0x36b/0x7b0
[  297.425936]        tty_write+0x284/0x4c0
[  297.425937]        __vfs_write+0x50/0xa0
[  297.425938]        vfs_write+0x105/0x290
[  297.425939]        redirected_tty_write+0x6a/0xc0
[  297.425939]        do_iter_write+0x248/0x2a0
[  297.425940]        vfs_writev+0x106/0x1e0
[  297.425941]        do_writev+0xd4/0x180
[  297.425941]        __x64_sys_writev+0x45/0x50
[  297.425942]        do_syscall_64+0xcc/0x76c
[  297.425943]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  297.425944] -> #2 (&(&port->lock)->rlock){-.-.}:
[  297.425946]        __lock_acquire+0x5b3/0xb40
[  297.425947]        lock_acquire+0x126/0x280
[  297.425948]        _raw_spin_lock_irqsave+0x3a/0x50
[  297.425949]        tty_port_tty_get+0x20/0x60
[  297.425949]        tty_port_default_wakeup+0xf/0x30
[  297.425950]        tty_port_tty_wakeup+0x39/0x40
[  297.425951]        uart_write_wakeup+0x2a/0x40
[  297.425952]        serial8250_tx_chars+0x22e/0x440
[  297.425952]        serial8250_handle_irq.part.8+0x14a/0x170
[  297.425953]        serial8250_default_handle_irq+0x5c/0x90
[  297.425954]        serial8250_interrupt+0xa6/0x130
[  297.425955]        __handle_irq_event_percpu+0x78/0x4f0
[  297.425955]        handle_irq_event_percpu+0x70/0x100
[  297.425956]        handle_irq_event+0x5a/0x8b
[  297.425957]        handle_edge_irq+0x117/0x370
[  297.425958]        do_IRQ+0x9e/0x1e0
[  297.425958]        ret_from_intr+0x0/0x2a
[  297.425959]        cpuidle_enter_state+0x156/0x8e0
[  297.425960]        cpuidle_enter+0x41/0x70
[  297.425960]        call_cpuidle+0x5e/0x90
[  297.425961]        do_idle+0x333/0x370
[  297.425962]        cpu_startup_entry+0x1d/0x1f
[  297.425962]        start_secondary+0x290/0x330
[  297.425963]        secondary_startup_64+0xb6/0xc0

[  297.425964] -> #1 (&port_lock_key){-.-.}:
[  297.425967]        __lock_acquire+0x5b3/0xb40
[  297.425967]        lock_acquire+0x126/0x280
[  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
[  297.425969]        serial8250_console_write+0x3e4/0x450
[  297.425970]        univ8250_console_write+0x4b/0x60
[  297.425970]        console_unlock+0x501/0x750
[  297.425971]        vprintk_emit+0x10d/0x340
[  297.425972]        vprintk_default+0x1f/0x30
[  297.425972]        vprintk_func+0x44/0xd4
[  297.425973]        printk+0x9f/0xc5
[  297.425974]        register_console+0x39c/0x520
[  297.425975]        univ8250_console_init+0x23/0x2d
[  297.425975]        console_init+0x338/0x4cd
[  297.425976]        start_kernel+0x534/0x724
[  297.425977]        x86_64_start_reservations+0x24/0x26
[  297.425977]        x86_64_start_kernel+0xf4/0xfb
[  297.425978]        secondary_startup_64+0xb6/0xc0

[  297.425979] -> #0 (console_owner){-.-.}:
[  297.425982]        check_prev_add+0x107/0xea0
[  297.425982]        validate_chain+0x8fc/0x1200
[  297.425983]        __lock_acquire+0x5b3/0xb40
[  297.425984]        lock_acquire+0x126/0x280
[  297.425984]        console_unlock+0x269/0x750
[  297.425985]        vprintk_emit+0x10d/0x340
[  297.425986]        vprintk_default+0x1f/0x30
[  297.425987]        vprintk_func+0x44/0xd4
[  297.425987]        printk+0x9f/0xc5
[  297.425988]        __offline_isolated_pages.cold.52+0x2f/0x30a
[  297.425989]        offline_isolated_pages_cb+0x17/0x30
[  297.425990]        walk_system_ram_range+0xda/0x160
[  297.425990]        __offline_pages+0x79c/0xa10
[  297.425991]        offline_pages+0x11/0x20
[  297.425992]        memory_subsys_offline+0x7e/0xc0
[  297.425992]        device_offline+0xd5/0x110
[  297.425993]        state_store+0xc6/0xe0
[  297.425994]        dev_attr_store+0x3f/0x60
[  297.425995]        sysfs_kf_write+0x89/0xb0
[  297.425995]        kernfs_fop_write+0x188/0x240
[  297.425996]        __vfs_write+0x50/0xa0
[  297.425997]        vfs_write+0x105/0x290
[  297.425997]        ksys_write+0xc6/0x160
[  297.425998]        __x64_sys_write+0x43/0x50
[  297.425999]        do_syscall_64+0xcc/0x76c
[  297.426000]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  297.426001] other info that might help us debug this:

[  297.426002] Chain exists of:
[  297.426002]   console_owner --> &(&port->lock)->rlock --> &(&zone->lock)-
>rlock

[  297.426007]  Possible unsafe locking scenario:

[  297.426008]        CPU0                    CPU1
[  297.426009]        ----                    ----
[  297.426009]   lock(&(&zone->lock)->rlock);
[  297.426011]                                lock(&(&port->lock)->rlock);
[  297.426013]                                lock(&(&zone->lock)->rlock);
[  297.426014]   lock(console_owner);

[  297.426016]  *** DEADLOCK ***

[  297.426017] 9 locks held by test.sh/8653:
[  297.426018]  #0: ffff88839ba7d408 (sb_writers#4){.+.+}, at:
vfs_write+0x25f/0x290
[  297.426021]  #1: ffff888277618880 (&of->mutex){+.+.}, at:
kernfs_fop_write+0x128/0x240
[  297.426024]  #2: ffff8898131fc218 (kn->count#115){.+.+}, at:
kernfs_fop_write+0x138/0x240
[  297.426028]  #3: ffffffff86962a80 (device_hotplug_lock){+.+.}, at:
lock_device_hotplug_sysfs+0x16/0x50
[  297.426031]  #4: ffff8884374f4990 (&dev->mutex){....}, at:
device_offline+0x70/0x110
[  297.426034]  #5: ffffffff86515250 (cpu_hotplug_lock.rw_sem){++++}, at:
__offline_pages+0xbf/0xa10
[  297.426037]  #6: ffffffff867405f0 (mem_hotplug_lock.rw_sem){++++}, at:
percpu_down_write+0x87/0x2f0
[  297.426040]  #7: ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
__offline_isolated_pages+0x179/0x3e0
[  297.426043]  #8: ffffffff865a4920 (console_lock){+.+.}, at:
vprintk_emit+0x100/0x340

[  297.426047] stack backtrace:
[  297.426048] CPU: 1 PID: 8653 Comm: test.sh Not tainted 5.3.0-next-20190917 #8
[  297.426049] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10,
BIOS U34 05/21/2019
[  297.426049] Call Trace:
[  297.426050]  dump_stack+0x86/0xca
[  297.426051]  print_circular_bug.cold.31+0x243/0x26e
[  297.426051]  check_noncircular+0x29e/0x2e0
[  297.426052]  ? stack_trace_save+0x87/0xb0
[  297.426053]  ? print_circular_bug+0x120/0x120
[  297.426053]  check_prev_add+0x107/0xea0
[  297.426054]  validate_chain+0x8fc/0x1200
[  297.426055]  ? check_prev_add+0xea0/0xea0
[  297.426055]  __lock_acquire+0x5b3/0xb40
[  297.426056]  lock_acquire+0x126/0x280
[  297.426057]  ? console_unlock+0x207/0x750
[  297.426057]  ? __kasan_check_read+0x11/0x20
[  297.426058]  console_unlock+0x269/0x750
[  297.426059]  ? console_unlock+0x207/0x750
[  297.426059]  vprintk_emit+0x10d/0x340
[  297.426060]  vprintk_default+0x1f/0x30
[  297.426061]  vprintk_func+0x44/0xd4
[  297.426061]  ? do_raw_spin_lock+0x118/0x1d0
[  297.426062]  printk+0x9f/0xc5
[  297.426063]  ? kmsg_dump_rewind_nolock+0x64/0x64
[  297.426064]  ? __offline_isolated_pages+0x179/0x3e0
[  297.426064]  __offline_isolated_pages.cold.52+0x2f/0x30a
[  297.426065]  ? online_memory_block+0x20/0x20
[  297.426066]  offline_isolated_pages_cb+0x17/0x30
[  297.426067]  walk_system_ram_range+0xda/0x160
[  297.426067]  ? walk_mem_res+0x30/0x30
[  297.426068]  ? dissolve_free_huge_page+0x1e/0x2b0
[  297.426069]  __offline_pages+0x79c/0xa10
[  297.426069]  ? __add_memory+0xc0/0xc0
[  297.426070]  ? __kasan_check_write+0x14/0x20
[  297.426071]  ? __mutex_lock+0x344/0xcd0
[  297.426071]  ? _raw_spin_unlock_irqrestore+0x49/0x50
[  297.426072]  ? device_offline+0x70/0x110
[  297.426073]  ? klist_next+0x1c1/0x1e0
[  297.426073]  ? __mutex_add_waiter+0xc0/0xc0
[  297.426074]  ? klist_next+0x10b/0x1e0
[  297.426075]  ? klist_iter_exit+0x16/0x40
[  297.426076]  ? device_for_each_child+0xd0/0x110
[  297.426076]  offline_pages+0x11/0x20
[  297.426077]  memory_subsys_offline+0x7e/0xc0
[  297.426078]  device_offline+0xd5/0x110
[  297.426078]  ? auto_online_blocks_show+0x70/0x70
[  297.426079]  state_store+0xc6/0xe0
[  297.426080]  dev_attr_store+0x3f/0x60
[  297.426080]  ? device_match_name+0x40/0x40
[  297.426081]  sysfs_kf_write+0x89/0xb0
[  297.426082]  ? sysfs_file_ops+0xa0/0xa0
[  297.426082]  kernfs_fop_write+0x188/0x240
[  297.426083]  __vfs_write+0x50/0xa0
[  297.426084]  vfs_write+0x105/0x290
[  297.426084]  ksys_write+0xc6/0x160
[  297.426085]  ? __x64_sys_read+0x50/0x50
[  297.426086]  ? do_syscall_64+0x79/0x76c
[  297.426086]  ? do_syscall_64+0x79/0x76c
[  297.426087]  __x64_sys_write+0x43/0x50
[  297.426088]  do_syscall_64+0xcc/0x76c
[  297.426088]  ? trace_hardirqs_on_thunk+0x1a/0x20
[  297.426089]  ? syscall_return_slowpath+0x210/0x210
[  297.426090]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
[  297.426091]  ? trace_hardirqs_off_caller+0x3a/0x150
[  297.426092]  ? trace_hardirqs_off_thunk+0x1a/0x20
[  297.426092]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  297.426093] RIP: 0033:0x7fd7336b4e18
[  297.426095] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f
1e fa 48 8d 05 05 59 2d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0
ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
[  297.426096] RSP: 002b:00007ffc58c7b258 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  297.426098] RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007fd7336b4e18
[  297.426098] RDX: 0000000000000008 RSI: 000055ad6d519c70 RDI: 0000000000000001
[  297.426099] RBP: 000055ad6d519c70 R08: 000000000000000a R09: 00007fd733746300
[  297.426100] R10: 000000000000000a R11: 0000000000000246 R12: 00007fd733986780
[  297.426101] R13: 0000000000000008 R14: 00007fd733981740 R15: 0000000000000008


[  763.659202][    C6] WARNING: possible circular locking dependency detected
[  763.659202][    C6] 5.3.0-next-20190917 #3 Not tainted
[  763.659203][    C6] ------------------------------------------------------
[  763.659203][    C6] test.sh/8352 is trying to acquire lock:
[  763.659203][    C6] ffffffffa187e5f8 ((console_sem).lock){..-.}, at:
down_trylock+0x14/0x40
[  763.659206][    C6] 
[  763.659206][    C6] but task is already holding lock:
[  763.659206][    C6] ffff9bcf7f373c58 (&(&zone->lock)->rlock){-.-.}, at:
__offline_isolated_pages+0x11e/0x2d0
[  763.659208][    C6] 
[  763.659208][    C6] which lock already depends on the new lock.
[  763.659209][    C6] 
[  763.659209][    C6] 
[  763.659209][    C6] the existing dependency chain (in reverse order) is:
[  763.659210][    C6] 
[  763.659210][    C6] -> #3 (&(&zone->lock)->rlock){-.-.}:
[  763.659211][    C6]        __lock_acquire+0x44e/0x8c0
[  763.659212][    C6]        lock_acquire+0xc0/0x1c0
[  763.659212][    C6]        _raw_spin_lock+0x2f/0x40
[  763.659212][    C6]        rmqueue_bulk.constprop.24+0x62/0xba0
[  763.659213][    C6]        get_page_from_freelist+0x581/0x1810
[  763.659213][    C6]        __alloc_pages_nodemask+0x20d/0x1750
[  763.659214][    C6]        alloc_page_interleave+0x17/0x100
[  763.659214][    C6]        alloc_pages_current+0xc0/0xe0
[  763.659214][    C6]        allocate_slab+0x4b2/0x1a20
[  763.659215][    C6]        new_slab+0x46/0x70
[  763.659215][    C6]        ___slab_alloc+0x58a/0x960
[  763.659215][    C6]        __slab_alloc+0x43/0x70
[  763.659216][    C6]        kmem_cache_alloc+0x33e/0x440
[  763.659216][    C6]        fill_pool+0x1ae/0x460
[  763.659216][    C6]        __debug_object_init+0x35/0x4a0
[  763.659217][    C6]        debug_object_init+0x16/0x20
[  763.659217][    C6]        hrtimer_init+0x25/0x130
[  763.659218][    C6]        init_dl_task_timer+0x20/0x30
[  763.659218][    C6]        __sched_fork+0x92/0x100
[  763.659218][    C6]        init_idle+0x8d/0x380
[  763.659219][    C6]        fork_idle+0xd9/0x140
[  763.659219][    C6]        idle_threads_init+0xd3/0x15e
[  763.659219][    C6]        smp_init+0x1b/0xbb
[  763.659220][    C6]        kernel_init_freeable+0x248/0x557
[  763.659220][    C6]        kernel_init+0xf/0x11e
[  763.659220][    C6]        ret_from_fork+0x27/0x50
[  763.659221][    C6] 
[  763.659221][    C6] -> #2 (&rq->lock){-.-.}:
[  763.659222][    C6]        __lock_acquire+0x44e/0x8c0
[  763.659223][    C6]        lock_acquire+0xc0/0x1c0
[  763.659223][    C6]        _raw_spin_lock+0x2f/0x40
[  763.659223][    C6]        task_fork_fair+0x37/0x150
[  763.659224][    C6]        sched_fork+0x126/0x230
[  763.659224][    C6]        copy_process+0xafc/0x1e90
[  763.659224][    C6]        _do_fork+0x89/0x720
[  763.659225][    C6]        kernel_thread+0x58/0x70
[  763.659225][    C6]        rest_init+0x28/0x302
[  763.659225][    C6]        arch_call_rest_init+0xe/0x1b
[  763.659226][    C6]        start_kernel+0x581/0x5a0
[  763.659226][    C6]        x86_64_start_reservations+0x24/0x26
[  763.659227][    C6]        x86_64_start_kernel+0xef/0xf6
[  763.659227][    C6]        secondary_startup_64+0xb6/0xc0
[  763.659227][    C6] 
[  763.659227][    C6] -> #1 (&p->pi_lock){-.-.}:
[  763.659229][    C6]        __lock_acquire+0x44e/0x8c0
[  763.659229][    C6]        lock_acquire+0xc0/0x1c0
[  763.659230][    C6]        _raw_spin_lock_irqsave+0x3a/0x50
[  763.659230][    C6]        try_to_wake_up+0x5c/0xbc0
[  763.659230][    C6]        wake_up_process+0x15/0x20
[  763.659231][    C6]        __up+0x4a/0x50
[  763.659231][    C6]        up+0x45/0x50
[  763.659231][    C6]        __up_console_sem+0x37/0x60
[  763.659232][    C6]        console_unlock+0x357/0x600
[  763.659232][    C6]        vprintk_emit+0x101/0x320
[  763.659232][    C6]        vprintk_default+0x1f/0x30
[  763.659233][    C6]        vprintk_func+0x44/0xd4
[  763.659233][    C6]        printk+0x58/0x6f
[  763.659234][    C6]        do_exit+0xd73/0xd80
[  763.659234][    C6]        do_group_exit+0x41/0xd0
[  763.659234][    C6]        __x64_sys_exit_group+0x18/0x20
[  763.659235][    C6]        do_syscall_64+0x6d/0x488
[  763.659235][    C6]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  763.659235][    C6] 
[  763.659236][    C6] -> #0 ((console_sem).lock){..-.}:
[  763.659237][    C6]        check_prev_add+0x9b/0xa10
[  763.659237][    C6]        validate_chain+0x759/0xdc0
[  763.659238][    C6]        __lock_acquire+0x44e/0x8c0
[  763.659238][    C6]        lock_acquire+0xc0/0x1c0
[  763.659239][    C6]        _raw_spin_lock_irqsave+0x3a/0x50
[  763.659239][    C6]        down_trylock+0x14/0x40
[  763.659239][    C6]        __down_trylock_console_sem+0x2b/0xa0
[  763.659240][    C6]        console_trylock+0x16/0x60
[  763.659240][    C6]        vprintk_emit+0xf4/0x320
[  763.659240][    C6]        vprintk_default+0x1f/0x30
[  763.659241][    C6]        vprintk_func+0x44/0xd4
[  763.659241][    C6]        printk+0x58/0x6f
[  763.659242][    C6]        __offline_isolated_pages.cold.55+0x38/0x28e
[  763.659242][    C6]        offline_isolated_pages_cb+0x15/0x20
[  763.659242][    C6]        walk_system_ram_range+0x7b/0xd0
[  763.659243][    C6]        __offline_pages+0x456/0xc10
[  763.659243][    C6]        offline_pages+0x11/0x20
[  763.659243][    C6]        memory_subsys_offline+0x44/0x60
[  763.659244][    C6]        device_offline+0x90/0xc0
[  763.659244][    C6]        state_store+0xbc/0xe0
[  763.659244][    C6]        dev_attr_store+0x17/0x30
[  763.659245][    C6]        sysfs_kf_write+0x4b/0x60
[  763.659245][    C6]        kernfs_fop_write+0x119/0x1c0
[  763.659245][    C6]        __vfs_write+0x1b/0x40
[  763.659246][    C6]        vfs_write+0xbd/0x1c0
[  763.659246][    C6]        ksys_write+0x64/0xe0
[  763.659247][    C6]        __x64_sys_write+0x1a/0x20
[  763.659247][    C6]        do_syscall_64+0x6d/0x488
[  763.659247][    C6]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  763.659248][    C6] 
[  763.659248][    C6] other info that might help us debug this:
[  763.659248][    C6] 
[  763.659248][    C6] Chain exists of:
[  763.659249][    C6]   (console_sem).lock --> &rq->lock --> &(&zone->lock)-
>rlock
[  763.659251][    C6] 
[  763.659251][    C6]  Possible unsafe locking scenario:
[  763.659251][    C6] 
[  763.659252][    C6]        CPU0                    CPU1
[  763.659252][    C6]        ----                    ----
[  763.659252][    C6]   lock(&(&zone->lock)->rlock);
[  763.659253][    C6]                                lock(&rq->lock);
[  763.659254][    C6]                                lock(&(&zone->lock)-
>rlock);
[  763.659255][    C6]   lock((console_sem).lock);
[  763.659256][    C6] 
[  763.659256][    C6]  *** DEADLOCK ***
[  763.659256][    C6] 
[  763.659257][    C6] 8 locks held by test.sh/8352:
[  763.659257][    C6]  #0: ffff9bdf4da39408 (sb_writers#4){.+.+}, at:
vfs_write+0x174/0x1c0
[  763.659259][    C6]  #1: ffff9be348280880 (&of->mutex){+.+.}, at:
kernfs_fop_write+0xe4/0x1c0
[  763.659260][    C6]  #2: ffff9bdb873757d0 (kn->count#125){.+.+}, at:
kernfs_fop_write+0xed/0x1c0
[  763.659262][    C6]  #3: ffffffffa194dec0 (device_hotplug_lock){+.+.}, at:
lock_device_hotplug_sysfs+0x15/0x40
[  763.659264][    C6]  #4: ffff9bcf7314c990 (&dev->mutex){....}, at:
device_offline+0x4e/0xc0
[  763.659265][    C6]  #5: ffffffffa185b9f0 (cpu_hotplug_lock.rw_sem){++++},
at: __offline_pages+0x3b/0xc10
[  763.659267][    C6]  #6: ffffffffa18e0b90 (mem_hotplug_lock.rw_sem){++++},
at: percpu_down_write+0x36/0x1c0
[  763.659268][    C6]  #7: ffff9bcf7f373c58 (&(&zone->lock)->rlock){-.-.}, at:
__offline_isolated_pages+0x11e/0x2d0
[  763.659270][    C6] 
[  763.659270][    C6] stack backtrace:
[  763.659271][    C6] CPU: 6 PID: 8352 Comm: test.sh Not tainted 5.3.0-next-
20190917 #3
[  763.659271][    C6] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385
Gen10, BIOS A40 07/10/2019
[  763.659272][    C6] Call Trace:
[  763.659272][    C6]  dump_stack+0x70/0x9a
[  763.659272][    C6]  print_circular_bug.cold.31+0x1c0/0x1eb
[  763.659273][    C6]  check_noncircular+0x18c/0x1a0
[  763.659273][    C6]  check_prev_add+0x9b/0xa10
[  763.659273][    C6]  validate_chain+0x759/0xdc0
[  763.659274][    C6]  __lock_acquire+0x44e/0x8c0
[  763.659274][    C6]  lock_acquire+0xc0/0x1c0
[  763.659274][    C6]  ? down_trylock+0x14/0x40
[  763.659275][    C6]  ? vprintk_emit+0xf4/0x320
[  763.659275][    C6]  _raw_spin_lock_irqsave+0x3a/0x50
[  763.659275][    C6]  ? down_trylock+0x14/0x40
[  763.659276][    C6]  down_trylock+0x14/0x40
[  763.659276][    C6]  __down_trylock_console_sem+0x2b/0xa0
[  763.659276][    C6]  console_trylock+0x16/0x60
[  763.659277][    C6]  vprintk_emit+0xf4/0x320
[  763.659277][    C6]  vprintk_default+0x1f/0x30
[  763.659277][    C6]  vprintk_func+0x44/0xd4
[  763.659278][    C6]  printk+0x58/0x6f
[  763.659278][    C6]  __offline_isolated_pages.cold.55+0x38/0x28e
[  763.659278][    C6]  ? online_memory_block+0x20/0x20
[  763.659279][    C6]  offline_isolated_pages_cb+0x15/0x20
[  763.659279][    C6]  walk_system_ram_range+0x7b/0xd0
[  763.659279][    C6]  __offline_pages+0x456/0xc10
[  763.659280][    C6]  offline_pages+0x11/0x20
[  763.659280][    C6]  memory_subsys_offline+0x44/0x60
[  763.659280][    C6]  device_offline+0x90/0xc0
[  763.659281][    C6]  state_store+0xbc/0xe0
[  763.659281][    C6]  dev_attr_store+0x17/0x30
[  763.659281][    C6]  sysfs_kf_write+0x4b/0x60
[  763.659282][    C6]  kernfs_fop_write+0x119/0x1c0
[  763.659282][    C6]  __vfs_write+0x1b/0x40
[  763.659282][    C6]  vfs_write+0xbd/0x1c0
[  763.659283][    C6]  ksys_write+0x64/0xe0
[  763.659283][    C6]  __x64_sys_write+0x1a/0x20
[  763.659283][    C6]  do_syscall_64+0x6d/0x488
[  763.659284][    C6]  ? trace_hardirqs_off_thunk+0x1a/0x20
[  763.659284][    C6]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

> 
> This thing does
> 
> 	rq->lock --> zone->lock
> 
> It takes rq->lock and then calls into __sched_fork()->hrtimer_init()->debug_objects()->MM
> 
> This doesn't look very right - a dive into MM under rq->lock.
> 
> Peter, Thomas am I wrong?
> 
> > [  317.337635] -> #2 (&rq->lock){-.-.}:
> > [  317.337638]        __lock_acquire+0x5b3/0xb40
> > [  317.337639]        lock_acquire+0x126/0x280
> > [  317.337639]        _raw_spin_lock+0x2f/0x40
> > [  317.337640]        task_fork_fair+0x43/0x200
> > [  317.337641]        sched_fork+0x29b/0x420
> > [  317.337642]        copy_process+0xf3c/0x2fd0
> > [  317.337642]        _do_fork+0xef/0x950
> > [  317.337643]        kernel_thread+0xa8/0xe0
> > [  317.337644]        rest_init+0x28/0x311
> > [  317.337645]        arch_call_rest_init+0xe/0x1b
> > [  317.337645]        start_kernel+0x6eb/0x724
> > [  317.337646]        x86_64_start_reservations+0x24/0x26
> > [  317.337647]        x86_64_start_kernel+0xf4/0xfb
> > [  317.337648]        secondary_startup_64+0xb6/0xc0
> 
> pi_lock --> rq->lock
> 
> > [  317.337649] -> #1 (&p->pi_lock){-.-.}:
> > [  317.337651]        __lock_acquire+0x5b3/0xb40
> > [  317.337652]        lock_acquire+0x126/0x280
> > [  317.337653]        _raw_spin_lock_irqsave+0x3a/0x50
> > [  317.337653]        try_to_wake_up+0xb4/0x1030
> > [  317.337654]        wake_up_process+0x15/0x20
> > [  317.337655]        __up+0xaa/0xc0
> > [  317.337655]        up+0x55/0x60
> > [  317.337656]        __up_console_sem+0x37/0x60
> > [  317.337657]        console_unlock+0x3a0/0x750
> > [  317.337658]        vprintk_emit+0x10d/0x340
> > [  317.337658]        vprintk_default+0x1f/0x30
> > [  317.337659]        vprintk_func+0x44/0xd4
> > [  317.337660]        printk+0x9f/0xc5
> > [  317.337660]        crng_reseed+0x3cc/0x440
> > [  317.337661]        credit_entropy_bits+0x3e8/0x4f0
> > [  317.337662]        random_ioctl+0x1eb/0x250
> > [  317.337663]        do_vfs_ioctl+0x13e/0xa70
> > [  317.337663]        ksys_ioctl+0x41/0x80
> > [  317.337664]        __x64_sys_ioctl+0x43/0x4c
> > [  317.337665]        do_syscall_64+0xcc/0x76c
> > [  317.337666]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> console_sem->lock --> pi_lock
> 
> This also covers console_sem->lock --> rq->lock, and maintains
> pi_lock --> rq->lock
> 
> So we have
> 
> 	console_sem->lock --> pi_lock --> rq->lock
> 
> > [  317.337667] -> #0 ((console_sem).lock){-.-.}:
> > [  317.337669]        check_prev_add+0x107/0xea0
> > [  317.337670]        validate_chain+0x8fc/0x1200
> > [  317.337671]        __lock_acquire+0x5b3/0xb40
> > [  317.337671]        lock_acquire+0x126/0x280
> > [  317.337672]        _raw_spin_lock_irqsave+0x3a/0x50
> > [  317.337673]        down_trylock+0x16/0x50
> > [  317.337674]        __down_trylock_console_sem+0x2b/0xa0
> > [  317.337675]        console_trylock+0x16/0x60
> > [  317.337676]        vprintk_emit+0x100/0x340
> > [  317.337677]        vprintk_default+0x1f/0x30
> > [  317.337678]        vprintk_func+0x44/0xd4
> > [  317.337678]        printk+0x9f/0xc5
> > [  317.337679]        __dump_page.cold.2+0x73/0x210
> > [  317.337680]        dump_page+0x12/0x50
> > [  317.337680]        has_unmovable_pages+0x3e9/0x4b0
> > [  317.337681]        start_isolate_page_range+0x3b4/0x570
> > [  317.337682]        __offline_pages+0x1ad/0xa10
> > [  317.337683]        offline_pages+0x11/0x20
> > [  317.337683]        memory_subsys_offline+0x7e/0xc0
> > [  317.337684]        device_offline+0xd5/0x110
> > [  317.337685]        state_store+0xc6/0xe0
> > [  317.337686]        dev_attr_store+0x3f/0x60
> > [  317.337686]        sysfs_kf_write+0x89/0xb0
> > [  317.337687]        kernfs_fop_write+0x188/0x240
> > [  317.337688]        __vfs_write+0x50/0xa0
> > [  317.337688]        vfs_write+0x105/0x290
> > [  317.337689]        ksys_write+0xc6/0x160
> > [  317.337690]        __x64_sys_write+0x43/0x50
> > [  317.337691]        do_syscall_64+0xcc/0x76c
> > [  317.337691]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> zone->lock --> console_sem->lock
> 
> So then we have
> 
> 	zone->lock --> console_sem->lock --> pi_lock --> rq->lock
> 
>   vs. the reverse chain
> 
> 	rq->lock --> console_sem->lock
> 
> If I get this right.
> 
> > [  317.337693] other info that might help us debug this:
> > 
> > [  317.337694] Chain exists of:
> > [  317.337694]   (console_sem).lock --> &rq->lock --> &(&zone->lock)->rlock
> > 
> > [  317.337699]  Possible unsafe locking scenario:
> > 
> > [  317.337700]        CPU0                    CPU1
> > [  317.337701]        ----                    ----
> > [  317.337701]   lock(&(&zone->lock)->rlock);
> > [  317.337703]                                lock(&rq->lock);
> > [  317.337705]                                lock(&(&zone->lock)->rlock);
> > [  317.337706]   lock((console_sem).lock);
> > 
> > [  317.337708]  *** DEADLOCK ***
> > 
> > [  317.337710] 8 locks held by test.sh/8738:
> > [  317.337710]  #0: ffff8883940b5408 (sb_writers#4){.+.+}, at: vfs_write+0x25f/0x290
> > [  317.337713]  #1: ffff889fce310280 (&of->mutex){+.+.}, at: kernfs_fop_write+0x128/0x240
> > [  317.337716]  #2: ffff889feb6d4830 (kn->count#115){.+.+}, at: kernfs_fop_write+0x138/0x240
> > [  317.337720]  #3: ffffffffb3762d40 (device_hotplug_lock){+.+.}, at: lock_device_hotplug_sysfs+0x16/0x50
> > [  317.337723]  #4: ffff88981f0dc990 (&dev->mutex){....}, at: device_offline+0x70/0x110
> > [  317.337726]  #5: ffffffffb3315250 (cpu_hotplug_lock.rw_sem){++++}, at: __offline_pages+0xbf/0xa10
> > [  317.337729]  #6: ffffffffb35408b0 (mem_hotplug_lock.rw_sem){++++}, at:  percpu_down_write+0x87/0x2f0
> > [  317.337732]  #7: ffff88883fff4318 (&(&zone->lock)->rlock){-.-.}, at: start_isolate_page_range+0x1f7/0x570
> > [  317.337736] stack backtrace:
> > [  317.337737] CPU: 58 PID: 8738 Comm: test.sh Not tainted 5.3.0-next-20190917+ #9
> > [  317.337738] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10, BIOS U34 05/21/2019
> > [  317.337739] Call Trace:
> > [  317.337739]  dump_stack+0x86/0xca
> > [  317.337740]  print_circular_bug.cold.31+0x243/0x26e
> > [  317.337741]  check_noncircular+0x29e/0x2e0
> > [  317.337742]  ? debug_lockdep_rcu_enabled+0x4b/0x60
> > [  317.337742]  ? print_circular_bug+0x120/0x120
> > [  317.337743]  ? is_ftrace_trampoline+0x9/0x20
> > [  317.337744]  ? kernel_text_address+0x59/0xc0
> > [  317.337744]  ? __kernel_text_address+0x12/0x40
> > [  317.337745]  check_prev_add+0x107/0xea0
> > [  317.337746]  validate_chain+0x8fc/0x1200
> > [  317.337746]  ? check_prev_add+0xea0/0xea0
> > [  317.337747]  ? format_decode+0xd6/0x600
> > [  317.337748]  ? file_dentry_name+0xe0/0xe0
> > [  317.337749]  __lock_acquire+0x5b3/0xb40
> > [  317.337749]  lock_acquire+0x126/0x280
> > [  317.337750]  ? down_trylock+0x16/0x50
> > [  317.337751]  ? vprintk_emit+0x100/0x340
> > [  317.337752]  _raw_spin_lock_irqsave+0x3a/0x50
> > [  317.337753]  ? down_trylock+0x16/0x50
> > [  317.337753]  down_trylock+0x16/0x50
> > [  317.337754]  ? vprintk_emit+0x100/0x340
> > [  317.337755]  __down_trylock_console_sem+0x2b/0xa0
> > [  317.337756]  console_trylock+0x16/0x60
> > [  317.337756]  vprintk_emit+0x100/0x340
> > [  317.337757]  vprintk_default+0x1f/0x30
> > [  317.337758]  vprintk_func+0x44/0xd4
> > [  317.337758]  printk+0x9f/0xc5
> > [  317.337759]  ? kmsg_dump_rewind_nolock+0x64/0x64
> > [  317.337760]  ? __dump_page+0x1d7/0x430
> > [  317.337760]  __dump_page.cold.2+0x73/0x210
> > [  317.337761]  dump_page+0x12/0x50
> > [  317.337762]  has_unmovable_pages+0x3e9/0x4b0
> > [  317.337763]  start_isolate_page_range+0x3b4/0x570
> > [  317.337763]  ? unset_migratetype_isolate+0x280/0x280
> > [  317.337764]  ? rcu_read_lock_bh_held+0xc0/0xc0
> > [  317.337765]  __offline_pages+0x1ad/0xa10
> > [  317.337765]  ? lock_acquire+0x126/0x280
> > [  317.337766]  ? __add_memory+0xc0/0xc0
> > [  317.337767]  ? __kasan_check_write+0x14/0x20
> > [  317.337767]  ? __mutex_lock+0x344/0xcd0
> > [  317.337768]  ? _raw_spin_unlock_irqrestore+0x49/0x50
> > [  317.337769]  ? device_offline+0x70/0x110
> > [  317.337770]  ? klist_next+0x1c1/0x1e0
> > [  317.337770]  ? __mutex_add_waiter+0xc0/0xc0
> > [  317.337771]  ? klist_next+0x10b/0x1e0
> > [  317.337772]  ? klist_iter_exit+0x16/0x40
> > [  317.337772]  ? device_for_each_child+0xd0/0x110
> > [  317.337773]  offline_pages+0x11/0x20
> > [  317.337774]  memory_subsys_offline+0x7e/0xc0
> > [  317.337774]  device_offline+0xd5/0x110
> > [  317.337775]  ? auto_online_blocks_show+0x70/0x70
> > [  317.337776]  state_store+0xc6/0xe0
> > [  317.337776]  dev_attr_store+0x3f/0x60
> > [  317.337777]  ? device_match_name+0x40/0x40
> > [  317.337778]  sysfs_kf_write+0x89/0xb0
> > [  317.337778]  ? sysfs_file_ops+0xa0/0xa0
> > [  317.337779]  kernfs_fop_write+0x188/0x240
> > [  317.337780]  __vfs_write+0x50/0xa0
> > [  317.337780]  vfs_write+0x105/0x290
> > [  317.337781]  ksys_write+0xc6/0x160
> > [  317.337782]  ? __x64_sys_read+0x50/0x50
> > [  317.337782]  ? do_syscall_64+0x79/0x76c
> > [  317.337783]  ? do_syscall_64+0x79/0x76c
> > [  317.337784]  __x64_sys_write+0x43/0x50
> > [  317.337784]  do_syscall_64+0xcc/0x76c
> > [  317.337785]  ? trace_hardirqs_on_thunk+0x1a/0x20
> > [  317.337786]  ? syscall_return_slowpath+0x210/0x210
> > [  317.337787]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
> > [  317.337787]  ? trace_hardirqs_off_caller+0x3a/0x150
> > [  317.337788]  ? trace_hardirqs_off_thunk+0x1a/0x20
> > [  317.337789]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Lovely.
> 
> 	-ss
