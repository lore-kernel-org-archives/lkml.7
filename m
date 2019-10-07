Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9542EECE596
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2B4206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hDz7FSJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfJGO7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:59:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33153 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfJGO7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:59:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so19632068qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWUQJAJjrSG/oR8emlwroKGhXQlMbIbkS+DjQZTyjDY=;
        b=hDz7FSJaMHjD/wfcHMVeF1V9uMpLfR410C+bxVBIeCI2Lk/8kk/VhiZrYWIZI18q5l
         6TaFXxGTNWPJVnEtlKR0dnWxmUUIJbRT1+dvoXseBSpd85GbciQr4XjdPzvaaN2BQaeN
         d7ZfBkpG2zasY3moSt5r1y+o09/P7Cyp6ZmmTHd2Yt3/TMtbv4CetOQiS/v9pg7vim7I
         k2BXqbVKz6qstqCSAUx7123vOWzdzyf7aZiLcL84DmRF4g9Y/i1FCDHm5xUopVO4Bg6C
         vs2rYD9quI04thsa1Qu2auNzgrnJJpgsrlWohnPTE6qY70hECpQtON64abmUN7HQ4IGJ
         sRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWUQJAJjrSG/oR8emlwroKGhXQlMbIbkS+DjQZTyjDY=;
        b=ZfpfCh95N7EqpHP/NO6IFkZ2girYzuaCzVGvFoWwOGLOpPH5FUJxABg+21dPs0i6+0
         ytM7J8i0/eEFKHSIAjdb+P1kofVJcV0gT9JofG7XKolnJlm1XBMAi/7TvAWYuQVMlxRx
         adJ29p4v8ILFeqv5OxJVu+y9mVWOO0AWGABB/rYl7MjAf/wBQVjoIt6woYT7aFi+EgJq
         gjzYBCc2e5J8H7hgz1OGobmN1BylhfyaOahmeNykfEPmDb1VEwJRU/S/fWs7JqEYtcBQ
         ipWnZQf0t1UQ9bRWFc5v1G8uXAqN7T5kY+Kam1A675qa3HbW3BMnBBoX4Cq6+SOXYVCo
         NSuQ==
X-Gm-Message-State: APjAAAWsCvACjSbwZFJXuYTuGlGGZnDTzWJyOr6N99Z6+1NM8uKvgx2r
        gEsHlIei26XuBX7nUUOstdRnts4jvgs=
X-Google-Smtp-Source: APXvYqxW4Vveu+QxZoLmUKPJktSntsFPrzssxZy8j89azDd7FqyrBHETo0swmvrA+bWgvGkI77Qjhw==
X-Received: by 2002:ac8:e82:: with SMTP id v2mr30183145qti.78.1570460353231;
        Mon, 07 Oct 2019 07:59:13 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q47sm14106240qtq.95.2019.10.07.07.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:59:12 -0700 (PDT)
Message-ID: <1570460350.5576.290.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Petr Mladek <pmladek@suse.com>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        rostedt@goodmis.org, peterz@infradead.org, mhocko@kernel.org,
        linux-mm@kvack.org, john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Oct 2019 10:59:10 -0400
In-Reply-To: <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
         <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-07 at 16:30 +0200, Petr Mladek wrote:
> On Fri 2019-10-04 18:26:45, Qian Cai wrote:
> > It is unsafe to call printk() while zone->lock was held, i.e.,
> > 
> > zone->lock --> console_lock
> > 
> > because the console could always allocate some memory in different code
> > paths and form locking chains in an opposite order,
> > 
> > console_lock --> * --> zone->lock
> > 
> > As the result, it triggers lockdep splats like below and in different
> > code paths in this thread [1]. Since has_unmovable_pages() was only used
> > in set_migratetype_isolate() and is_pageblock_removable_nolock(). Only
> > the former will set the REPORT_FAILURE flag which will call printk().
> > Hence, unlock the zone->lock just before the dump_page() there where
> > when has_unmovable_pages() returns true, there is no need to hold the
> > lock anyway in the rest of set_migratetype_isolate().
> > 
> > While at it, remove a problematic printk() in __offline_isolated_pages()
> > only for debugging as well which will always disable lockdep on debug
> > kernels.
> > 
> > The problem is probably there forever, but neither many developers will
> > run memory offline with the lockdep enabled nor admins in the field are
> > lucky enough yet to hit a perfect timing which required to trigger a
> > real deadlock. In addition, there aren't many places that call printk()
> > while zone->lock was held.
> > 
> > WARNING: possible circular locking dependency detected
> > ------------------------------------------------------
> > test.sh/1724 is trying to acquire lock:
> > 0000000052059ec0 (console_owner){-...}, at: console_unlock+0x
> > 01: 328/0xa30
> > 
> > but task is already holding lock:
> > 000000006ffd89c8 (&(&zone->lock)->rlock){-.-.}, at: start_iso
> > 01: late_page_range+0x216/0x538
> > 
> > which lock already depends on the new lock.
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #2 (&(&zone->lock)->rlock){-.-.}:
> >        lock_acquire+0x21a/0x468
> >        _raw_spin_lock+0x54/0x68
> >        get_page_from_freelist+0x8b6/0x2d28
> >        __alloc_pages_nodemask+0x246/0x658
> >        __get_free_pages+0x34/0x78
> >        sclp_init+0x106/0x690
> >        sclp_register+0x2e/0x248
> >        sclp_rw_init+0x4a/0x70
> >        sclp_console_init+0x4a/0x1b8
> >        console_init+0x2c8/0x410
> >        start_kernel+0x530/0x6a0
> >        startup_continue+0x70/0xd0
> 
> This code takes locks: sclp_lock --> &(&zone->lock)->rlock
> 
> > -> #1 (sclp_lock){-.-.}:
> >        lock_acquire+0x21a/0x468
> >        _raw_spin_lock_irqsave+0xcc/0xe8
> >        sclp_add_request+0x34/0x308
> >        sclp_conbuf_emit+0x100/0x138
> >        sclp_console_write+0x96/0x3b8
> >        console_unlock+0x6dc/0xa30
> >        vprintk_emit+0x184/0x3c8
> >        vprintk_default+0x44/0x50
> >        printk+0xa8/0xc0
> >        iommu_debugfs_setup+0xf2/0x108
> >        iommu_init+0x6c/0x78
> >        do_one_initcall+0x162/0x680
> >        kernel_init_freeable+0x4e8/0x5a8
> >        kernel_init+0x2a/0x188
> >        ret_from_fork+0x30/0x34
> >        kernel_thread_starter+0x0/0xc
> 
> This code path takes: console_owner --> sclp_lock
> 
> > -> #0 (console_owner){-...}:
> >        check_noncircular+0x338/0x3e0
> >        __lock_acquire+0x1e66/0x2d88
> >        lock_acquire+0x21a/0x468
> >        console_unlock+0x3a6/0xa30
> >        vprintk_emit+0x184/0x3c8
> >        vprintk_default+0x44/0x50
> >        printk+0xa8/0xc0
> >        __dump_page+0x1dc/0x710
> >        dump_page+0x2e/0x58
> >        has_unmovable_pages+0x2e8/0x470
> >        start_isolate_page_range+0x404/0x538
> >        __offline_pages+0x22c/0x1338
> >        memory_subsys_offline+0xa6/0xe8
> >        device_offline+0xe6/0x118
> >        state_store+0xf0/0x110
> >        kernfs_fop_write+0x1bc/0x270
> >        vfs_write+0xce/0x220
> >        ksys_write+0xea/0x190
> >        system_call+0xd8/0x2b4
> 
> And this code path takes: &(&zone->lock)->rlock --> console_owner
> 
> > other info that might help us debug this:
> > 
> > Chain exists of:
> >   console_owner --> sclp_lock --> &(&zone->lock)->rlock
> 
> All three code paths together create a cyclic dependency. This
> is why lockdep reports a possible deadlock.
> 
> I believe that it cannot really happen because:
> 
> 	static int __init
> 	sclp_console_init(void)
> 	{
> 	[...]
> 		rc = sclp_rw_init();
> 	[...]
> 		register_console(&sclp_console);
> 		return 0;
> 	}
> 
> sclp_rw_init() is called before register_console(). And
> console_unlock() will never call sclp_console_write() before
> the console is registered.

It could really hard to tell for sure unless someone fully audit every place in
the code could do,

console_owner_lock --> sclp_lock

The lockdep will save only the earliest trace after first saw the lock order, so
those early boot one will always be there in the report.

> 
> AFAIK, lockdep only compares existing chain of locks. It does
> not know about console registration that would make some
> code paths mutually exclusive.

Yes.

> 
> I believe that it is a false positive. I do not know how to
> avoid this lockdep report. I hope that it will disappear
> by deferring all printk() calls rather soon.

However, the similar splat is for console_owner_lock --> port_lock below. I have
even seen the another one before with a 4-way lockdep splat (which was shot down
separately),

https://lore.kernel.org/lkml/1568817579.5576.172.camel@lca.pw/

console_sem --> pi_lock --> rq_lock --> zone_lock
zone_lock --> console_sem

It is almost impossible to eliminate all the indirect call chains from
console_sem/console_owner_lock to zone->lock because it is too normal that
something later needs to allocate some memory dynamically, so as long as it
directly call printk() with zone->lock held, it will be in trouble.

I really hope the new printk() will solve this class of the problem, but it is
essentially up to the air until a patchset was posted. There are just too many
questions out there to be answered.

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
