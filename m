Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243D5C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E024021929
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="G0QbIUCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfJIOTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:19:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45652 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJIOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:19:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so3598154qtj.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFj1u3KIrCIdvk4FcEGdOY8BpCzC8kRESL9rMPXwG1Q=;
        b=G0QbIUCIb4sGD9a1Qv1+jWTfqGh6stl2V1S5+a8mHuxcAk8xRlphxdZgmGDkWHtZUO
         i/4MYd6mFCBBOvETLY8n3iOqT1y4EwjD29Q51gj+KRUDMpBs9HjR68P3mEckx3Uks4lT
         Pea/tHrNFYvS4K1wudFmleqgflW7Rg1rmx7Q+sl0LI0o8r6CnNYi6YDp4R0S86c3HKO1
         qVJ6QWVmvRv4m1X4+2pZ++x5TgvUA1S3eXpdTNa9FjynXK1y++qL09DlwGRPngCZgSws
         zhvqXtJS1tooB7IJ9wIF1jzYu3f9oDkq86S2ND+2g5oH0iBMs2N+rf4Hvo/9eZdI5Wq9
         Fwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFj1u3KIrCIdvk4FcEGdOY8BpCzC8kRESL9rMPXwG1Q=;
        b=bznTYWVgYeef5TA6gaoLpIhoh9Nd/hCAaYnV8TdV0Z+9JO+f79L4OmN5c8fuMbd9cn
         1PuVVvWRc+GypXjGbIKpBaAPpcZ+pabGkAYdAJVmQPOMO4SsqbgHYSI8MsL367lh1cNr
         Rl4jPrlui1FL+KDkgRyuBPvzJ3MckPuX6r7ChiNyiabcVQnalPcwo1o+d6/opZT2yiRD
         ezUybkZOR66sxazd9LVfgMEIzx3AVzm7r8bpsq6r+p8E9p/Ae5yZJ7UtPev5fjBrZOYT
         A5n5XAj5Pa6bCkgVGexCoGhxPuEEkTQ4wOCBAWxWVMWYO8dA8LO/5T9AgvwEDmwSg0ZN
         ENQQ==
X-Gm-Message-State: APjAAAXbw8UnWG4orFcdmmnohx0f0iO0SjwbPQ6yiCoXg2PDMQgXWd1C
        icwl8L48JiPFljGqKcog9MDPHw==
X-Google-Smtp-Source: APXvYqwCk2qWG3zWDBDhL+VGWadBtkugM0UqLMXjsol3Z0i+OHscZEnYcywZ24ZaHyAHutqSWHmuOg==
X-Received: by 2002:a0c:e982:: with SMTP id z2mr3799888qvn.58.1570630787603;
        Wed, 09 Oct 2019 07:19:47 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v94sm1078574qtd.43.2019.10.09.07.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 07:19:46 -0700 (PDT)
Message-ID: <1570630784.5937.5.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Oct 2019 10:19:44 -0400
In-Reply-To: <20191009135155.GC6681@dhcp22.suse.cz>
References: <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
         <1570550917.5576.303.camel@lca.pw> <20191008183525.GQ6681@dhcp22.suse.cz>
         <1570561573.5576.307.camel@lca.pw> <20191008191728.GS6681@dhcp22.suse.cz>
         <1570563324.5576.309.camel@lca.pw>
         <20191009114903.aa6j6sa56z2cssom@pathway.suse.cz>
         <1570626402.5937.1.camel@lca.pw> <20191009132746.GA6681@dhcp22.suse.cz>
         <1570628593.5937.3.camel@lca.pw> <20191009135155.GC6681@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 15:51 +0200, Michal Hocko wrote:
> On Wed 09-10-19 09:43:13, Qian Cai wrote:
> > On Wed, 2019-10-09 at 15:27 +0200, Michal Hocko wrote:
> > > On Wed 09-10-19 09:06:42, Qian Cai wrote:
> > > [...]
> > > > https://lore.kernel.org/linux-mm/1570460350.5576.290.camel@lca.pw/
> > > > 
> > > > [  297.425964] -> #1 (&port_lock_key){-.-.}:
> > > > [  297.425967]        __lock_acquire+0x5b3/0xb40
> > > > [  297.425967]        lock_acquire+0x126/0x280
> > > > [  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
> > > > [  297.425969]        serial8250_console_write+0x3e4/0x450
> > > > [  297.425970]        univ8250_console_write+0x4b/0x60
> > > > [  297.425970]        console_unlock+0x501/0x750
> > > > [  297.425971]        vprintk_emit+0x10d/0x340
> > > > [  297.425972]        vprintk_default+0x1f/0x30
> > > > [  297.425972]        vprintk_func+0x44/0xd4
> > > > [  297.425973]        printk+0x9f/0xc5
> > > > [  297.425974]        register_console+0x39c/0x520
> > > > [  297.425975]        univ8250_console_init+0x23/0x2d
> > > > [  297.425975]        console_init+0x338/0x4cd
> > > > [  297.425976]        start_kernel+0x534/0x724
> > > > [  297.425977]        x86_64_start_reservations+0x24/0x26
> > > > [  297.425977]        x86_64_start_kernel+0xf4/0xfb
> > > > [  297.425978]        secondary_startup_64+0xb6/0xc0
> > > > 
> > > > where the report again show the early boot call trace for the locking
> > > > dependency,
> > > > 
> > > > console_owner --> port_lock_key
> > > > 
> > > > but that dependency clearly not only happen in the early boot.
> > > 
> > > Can you provide an example of the runtime dependency without any early
> > > boot artifacts? Because this discussion really doens't make much sense
> > > without a clear example of a _real_ lockdep report that is not a false
> > > possitive. All of them so far have been concluded to be false possitive
> > > AFAIU.
> > 
> > An obvious one is in the above link. Just replace the trace in #1 above with
> > printk() from anywhere, i.e., just ignore the early boot calls there as they are
> >  not important.
> > 
> > printk()
> >   console_unlock()
> >     console_lock_spinning_enable() --> console_owner_lock
> >   call_console_drivers()
> >     serial8250_console_write() --> port->lock
> 
> Can you paste the full lock chain graph to be sure we are on the same
> page?

WARNING: possible circular locking dependency detected
5.3.0-next-20190917 #8 Not tainted
------------------------------------------------------
test.sh/8653 is trying to acquire lock:
ffffffff865a4460 (console_owner){-.-.}, at:
console_unlock+0x207/0x750

but task is already holding lock:
ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
__offline_isolated_pages+0x179/0x3e0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&(&zone->lock)->rlock){-.-.}:
       __lock_acquire+0x5b3/0xb40
       lock_acquire+0x126/0x280
       _raw_spin_lock+0x2f/0x40
       rmqueue_bulk.constprop.21+0xb6/0x1160
       get_page_from_freelist+0x898/0x22c0
       __alloc_pages_nodemask+0x2f3/0x1cd0
       alloc_pages_current+0x9c/0x110
       allocate_slab+0x4c6/0x19c0
       new_slab+0x46/0x70
       ___slab_alloc+0x58b/0x960
       __slab_alloc+0x43/0x70
       __kmalloc+0x3ad/0x4b0
       __tty_buffer_request_room+0x100/0x250
       tty_insert_flip_string_fixed_flag+0x67/0x110
       pty_write+0xa2/0xf0
       n_tty_write+0x36b/0x7b0
       tty_write+0x284/0x4c0
       __vfs_write+0x50/0xa0
       vfs_write+0x105/0x290
       redirected_tty_write+0x6a/0xc0
       do_iter_write+0x248/0x2a0
       vfs_writev+0x106/0x1e0
       do_writev+0xd4/0x180
       __x64_sys_writev+0x45/0x50
       do_syscall_64+0xcc/0x76c
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (&(&port->lock)->rlock){-.-.}:
       __lock_acquire+0x5b3/0xb40
       lock_acquire+0x126/0x280
       _raw_spin_lock_irqsave+0x3a/0x50
       tty_port_tty_get+0x20/0x60
       tty_port_default_wakeup+0xf/0x30
       tty_port_tty_wakeup+0x39/0x40
       uart_write_wakeup+0x2a/0x40
       serial8250_tx_chars+0x22e/0x440
       serial8250_handle_irq.part.8+0x14a/0x170
       serial8250_default_handle_irq+0x5c/0x90
       serial8250_interrupt+0xa6/0x130
       __handle_irq_event_percpu+0x78/0x4f0
       handle_irq_event_percpu+0x70/0x100
       handle_irq_event+0x5a/0x8b
       handle_edge_irq+0x117/0x370
       do_IRQ+0x9e/0x1e0
       ret_from_intr+0x0/0x2a
       cpuidle_enter_state+0x156/0x8e0
       cpuidle_enter+0x41/0x70
       call_cpuidle+0x5e/0x90
       do_idle+0x333/0x370
       cpu_startup_entry+0x1d/0x1f
       start_secondary+0x290/0x330
       secondary_startup_64+0xb6/0xc0

-> #1 (&port_lock_key){-.-.}:
       __lock_acquire+0x5b3/0xb40
       lock_acquire+0x126/0x280
       _raw_spin_lock_irqsave+0x3a/0x50
       serial8250_console_write+0x3e4/0x450
       univ8250_console_write+0x4b/0x60
       console_unlock+0x501/0x750
       vprintk_emit+0x10d/0x340
       vprintk_default+0x1f/0x30
       vprintk_func+0x44/0xd4
       printk+0x9f/0xc5

-> #0 (console_owner){-.-.}:
       check_prev_add+0x107/0xea0
       validate_chain+0x8fc/0x1200
       __lock_acquire+0x5b3/0xb40
       lock_acquire+0x126/0x280
       console_unlock+0x269/0x750
       vprintk_emit+0x10d/0x340
       vprintk_default+0x1f/0x30
       vprintk_func+0x44/0xd4
       printk+0x9f/0xc5
       __offline_isolated_pages.cold.52+0x2f/0x30a
       offline_isolated_pages_cb+0x17/0x30
       walk_system_ram_range+0xda/0x160
       __offline_pages+0x79c/0xa10
       offline_pages+0x11/0x20
       memory_subsys_offline+0x7e/0xc0
       device_offline+0xd5/0x110
       state_store+0xc6/0xe0
       dev_attr_store+0x3f/0x60
       sysfs_kf_write+0x89/0xb0
       kernfs_fop_write+0x188/0x240
       __vfs_write+0x50/0xa0
       vfs_write+0x105/0x290
       ksys_write+0xc6/0x160
       __x64_sys_write+0x43/0x50
       do_syscall_64+0xcc/0x76c
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  console_owner --> &(&port->lock)->rlock --> &(&zone->lock)-
>rlock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&zone->lock)->rlock);
                               lock(&(&port->lock)->rlock);
                               lock(&(&zone->lock)->rlock);
  lock(console_owner);

 *** DEADLOCK ***

9 locks held by test.sh/8653:
 #0: ffff88839ba7d408 (sb_writers#4){.+.+}, at:
vfs_write+0x25f/0x290
 #1: ffff888277618880 (&of->mutex){+.+.}, at:
kernfs_fop_write+0x128/0x240
 #2: ffff8898131fc218 (kn->count#115){.+.+}, at:
kernfs_fop_write+0x138/0x240
 #3: ffffffff86962a80 (device_hotplug_lock){+.+.}, at:
lock_device_hotplug_sysfs+0x16/0x50
 #4: ffff8884374f4990 (&dev->mutex){....}, at:
device_offline+0x70/0x110
 #5: ffffffff86515250 (cpu_hotplug_lock.rw_sem){++++}, at:
__offline_pages+0xbf/0xa10
 #6: ffffffff867405f0 (mem_hotplug_lock.rw_sem){++++}, at:
percpu_down_write+0x87/0x2f0
 #7: ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
__offline_isolated_pages+0x179/0x3e0
 #8: ffffffff865a4920 (console_lock){+.+.}, at:
vprintk_emit+0x100/0x340

stack backtrace:
CPU: 1 PID: 8653 Comm: test.sh Not tainted 5.3.0-next-20190917 #8
Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10,
BIOS U34 05/21/2019
Call Trace:
 dump_stack+0x86/0xca
 print_circular_bug.cold.31+0x243/0x26e
 check_noncircular+0x29e/0x2e0
 check_prev_add+0x107/0xea0
 validate_chain+0x8fc/0x1200
 __lock_acquire+0x5b3/0xb40
 lock_acquire+0x126/0x280
 console_unlock+0x269/0x750
 vprintk_emit+0x10d/0x340
 vprintk_default+0x1f/0x30
 vprintk_func+0x44/0xd4
 printk+0x9f/0xc5
 __offline_isolated_pages.cold.52+0x2f/0x30a
 offline_isolated_pages_cb+0x17/0x30
 walk_system_ram_range+0xda/0x160
 __offline_pages+0x79c/0xa10
 offline_pages+0x11/0x20
 memory_subsys_offline+0x7e/0xc0
 device_offline+0xd5/0x110
 state_store+0xc6/0xe0
 dev_attr_store+0x3f/0x60
 sysfs_kf_write+0x89/0xb0
 kernfs_fop_write+0x188/0x240
 __vfs_write+0x50/0xa0
 vfs_write+0x105/0x290
 ksys_write+0xc6/0x160
 __x64_sys_write+0x43/0x50
 do_syscall_64+0xcc/0x76c
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
