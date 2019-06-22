Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0371CC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 13:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBCF20652
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 13:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFVNzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 09:55:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36040 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFVNzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 09:55:07 -0400
Received: by mail-io1-f70.google.com with SMTP id k21so15000945ioj.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 06:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qbrJM6Ye5Pt4x7XqRtU2DwwYFWqcL+4qZQUo5wdHhqQ=;
        b=KcAi2GgziEO8uefKGVy4tPNR++gcD7b6GmMs/a0N5+ktPGsVkmN8isQLfoCJpX22KP
         kLodo1zH1iTxp1dTunw0Mg36aN8YvyarMYrDdAuvBBrI64dgC/byoo16unaM4AlLE/jc
         nLgy547LpsFziRZ9fCIIe+Aq97/K9XKLC/6vomfeCH5dHu07k0k9WnBvXopcFtSfRlMq
         Xpk2g8iddSqIViQAR5xcFk1wUXBjFLgJdrKllaqbSf4eAiJIHCW4m1a8qkypqmD+WAZs
         kRWrmHsrSQEY+/KcYZgfs3bH7AnMjKKcD8/U3KkT9MF7w1RVN2dIjCtMAUHRYzO7UZUv
         /TNg==
X-Gm-Message-State: APjAAAURibCp5ciRd1ttmEBKN29DNo4mckUnnxR08UMqZ7mTxEith04l
        +DNhvGOvyEt2JNpDWJgykCIzktb6ygmmW++0M4t8y8qhva4B
X-Google-Smtp-Source: APXvYqynhtoGsN4BZz8kBNFFc+54WGJ/VNa2zN+tiV/WGxbNpW+co8aDFnhlobpSwdq1xWXJFAVQPus6QPV8ZJyalQFbv18toFJF
MIME-Version: 1.0
X-Received: by 2002:a6b:2bcd:: with SMTP id r196mr7593948ior.73.1561211705795;
 Sat, 22 Jun 2019 06:55:05 -0700 (PDT)
Date:   Sat, 22 Jun 2019 06:55:05 -0700
In-Reply-To: <0000000000009ad686058bc12956@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024ae6f058be9ed51@google.com>
Subject: Re: possible deadlock in console_trylock_spinning
From:   syzbot <syzbot+fc1da0f1a577d15b64fc@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11834c41a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=fc1da0f1a577d15b64fc
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1357add6a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1611ac89a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fc1da0f1a577d15b64fc@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.2.0-rc5+ #4 Not tainted
------------------------------------------------------
syz-executor155/8057 is trying to acquire lock:
000000009bd46550 (console_owner){-.-.}, at:  
console_trylock_spinning+0x12f/0x390 kernel/printk/printk.c:1718

but task is already holding lock:
0000000056678186 (&(&port->lock)->rlock){-.-.}, at: pty_write+0xbd/0x190  
drivers/tty/pty.c:120

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&(&port->lock)->rlock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0xa1/0xc0 kernel/locking/spinlock.c:159
        tty_port_tty_get drivers/tty/tty_port.c:287 [inline]
        tty_port_default_wakeup+0x20/0xa0 drivers/tty/tty_port.c:47
        tty_port_tty_wakeup+0x5a/0x70 drivers/tty/tty_port.c:387
        uart_write_wakeup+0x48/0x60 drivers/tty/serial/serial_core.c:103
        serial8250_tx_chars+0x623/0x830  
drivers/tty/serial/8250/8250_port.c:1806
        serial8250_handle_irq+0x255/0x390  
drivers/tty/serial/8250/8250_port.c:1879
        serial8250_default_handle_irq+0xc5/0x1d0  
drivers/tty/serial/8250/8250_port.c:1895
        serial8250_interrupt+0xad/0x190  
drivers/tty/serial/8250/8250_core.c:125
        __handle_irq_event_percpu+0x113/0x560 kernel/irq/handle.c:149
        handle_irq_event_percpu kernel/irq/handle.c:189 [inline]
        handle_irq_event+0x10a/0x2f0 kernel/irq/handle.c:206
        handle_edge_irq+0x29f/0xca0 kernel/irq/chip.c:822
        generic_handle_irq_desc include/linux/irqdesc.h:156 [inline]
        handle_irq+0x3e/0x50 arch/x86/kernel/irq_64.c:34
        do_IRQ+0xc4/0x1a0 arch/x86/kernel/irq.c:247
        ret_from_intr+0x0/0x1e
        native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60
        arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:571
        default_idle_call kernel/sched/idle.c:94 [inline]
        cpuidle_idle_call kernel/sched/idle.c:154 [inline]
        do_idle+0x18a/0x760 kernel/sched/idle.c:263
        cpu_startup_entry+0x25/0x30 kernel/sched/idle.c:354
        start_secondary+0x425/0x4c0 arch/x86/kernel/smpboot.c:265
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #1 (&port_lock_key){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0xa1/0xc0 kernel/locking/spinlock.c:159
        serial8250_console_write+0x1d1/0xba0  
drivers/tty/serial/8250/8250_port.c:3245
        univ8250_console_write+0x50/0x70  
drivers/tty/serial/8250/8250_core.c:586
        call_console_drivers kernel/printk/printk.c:1779 [inline]
        console_unlock+0x95f/0xf20 kernel/printk/printk.c:2463
        vprintk_emit+0x239/0x3a0 kernel/printk/printk.c:1986
        vprintk_default+0x28/0x30 kernel/printk/printk.c:2013
        vprintk_func+0x158/0x170 kernel/printk/printk_safe.c:386
        printk+0xc4/0x11d kernel/printk/printk.c:2046
        register_console+0xa81/0xe30 kernel/printk/printk.c:2788
        univ8250_console_init+0x4b/0x4d  
drivers/tty/serial/8250/8250_core.c:681
        console_init+0x56/0x9c kernel/printk/printk.c:2874
        start_kernel+0x49e/0x860 init/main.c:688
        x86_64_start_reservations+0x18/0x2e arch/x86/kernel/head64.c:470
        x86_64_start_kernel+0x7a/0x7d arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #0 (console_owner){-.-.}:
        lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4303
        console_trylock_spinning+0x14f/0x390 kernel/printk/printk.c:1735
        vprintk_emit+0x21c/0x3a0 kernel/printk/printk.c:1985
        vprintk_default+0x28/0x30 kernel/printk/printk.c:2013
        vprintk_func+0x158/0x170 kernel/printk/printk_safe.c:386
        printk+0xc4/0x11d kernel/printk/printk.c:2046
        fail_dump lib/fault-inject.c:45 [inline]
        should_fail+0x5c5/0x860 lib/fault-inject.c:144
        __should_fail_alloc_page mm/page_alloc.c:3278 [inline]
        should_fail_alloc_page+0x55/0x60 mm/page_alloc.c:3315
        prepare_alloc_pages+0x283/0x460 mm/page_alloc.c:4598
        __alloc_pages_nodemask+0x11c/0x790 mm/page_alloc.c:4645
        __alloc_pages include/linux/gfp.h:473 [inline]
        __alloc_pages_node include/linux/gfp.h:486 [inline]
        kmem_getpages+0x46/0x480 mm/slab.c:1373
        cache_grow_begin+0x7e/0x2c0 mm/slab.c:2606
        cache_alloc_refill+0x311/0x3f0 mm/slab.c:2978
        ____cache_alloc mm/slab.c:3061 [inline]
        __do_cache_alloc mm/slab.c:3283 [inline]
        slab_alloc mm/slab.c:3318 [inline]
        __do_kmalloc mm/slab.c:3658 [inline]
        __kmalloc+0x2e5/0x310 mm/slab.c:3669
        kmalloc include/linux/slab.h:552 [inline]
        tty_buffer_alloc drivers/tty/tty_buffer.c:175 [inline]
        __tty_buffer_request_room+0x1ef/0x560 drivers/tty/tty_buffer.c:273
        tty_insert_flip_string_fixed_flag+0xa4/0x2b0  
drivers/tty/tty_buffer.c:318
        tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
        pty_write+0xe2/0x190 drivers/tty/pty.c:122
        tty_put_char+0x115/0x180 drivers/tty/tty_io.c:3031
        __process_echoes+0x19d/0x920 drivers/tty/n_tty.c:746
        flush_echoes drivers/tty/n_tty.c:829 [inline]
        __receive_buf drivers/tty/n_tty.c:1648 [inline]
        n_tty_receive_buf_common+0x297f/0x3080 drivers/tty/n_tty.c:1742
        n_tty_receive_buf+0x30/0x40 drivers/tty/n_tty.c:1771
        tiocsti drivers/tty/tty_io.c:2195 [inline]
        tty_ioctl+0xd63/0x15d0 drivers/tty/tty_io.c:2571
        do_vfs_ioctl+0x7d4/0x1890 fs/ioctl.c:46
        ksys_ioctl fs/ioctl.c:713 [inline]
        __do_sys_ioctl fs/ioctl.c:720 [inline]
        __se_sys_ioctl fs/ioctl.c:718 [inline]
        __x64_sys_ioctl+0xe3/0x120 fs/ioctl.c:718
        do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   console_owner --> &port_lock_key --> &(&port->lock)->rlock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&(&port->lock)->rlock);
                                lock(&port_lock_key);
                                lock(&(&port->lock)->rlock);
   lock(console_owner);

  *** DEADLOCK ***

4 locks held by syz-executor155/8057:
  #0: 00000000537d947b (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 00000000edca1b1e (&o_tty->termios_rwsem/1){++++}, at:  
n_tty_receive_buf_common+0x8b/0x3080 drivers/tty/n_tty.c:1705
  #2: 00000000e4a6cb09 (&ldata->output_lock){+.+.}, at: flush_echoes  
drivers/tty/n_tty.c:827 [inline]
  #2: 00000000e4a6cb09 (&ldata->output_lock){+.+.}, at: __receive_buf  
drivers/tty/n_tty.c:1648 [inline]
  #2: 00000000e4a6cb09 (&ldata->output_lock){+.+.}, at:  
n_tty_receive_buf_common+0x2940/0x3080 drivers/tty/n_tty.c:1742
  #3: 0000000056678186 (&(&port->lock)->rlock){-.-.}, at:  
pty_write+0xbd/0x190 drivers/tty/pty.c:120

stack backtrace:
CPU: 1 PID: 8057 Comm: syz-executor155 Not tainted 5.2.0-rc5+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  print_circular_bug+0xd34/0xf20 kernel/locking/lockdep.c:1564
  check_prev_add kernel/locking/lockdep.c:2310 [inline]
  check_prevs_add kernel/locking/lockdep.c:2418 [inline]
  validate_chain+0x59d0/0x84f0 kernel/locking/lockdep.c:2800
  __lock_acquire+0xcf7/0x1a40 kernel/locking/lockdep.c:3793
  lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4303
  console_trylock_spinning+0x14f/0x390 kernel/printk/printk.c:1735
  vprintk_emit+0x21c/0x3a0 kernel/printk/printk.c:1985
  vprintk_default+0x28/0x30 kernel/printk/printk.c:2013
  vprintk_func+0x158/0x170 kernel/printk/printk_safe.c:386
  printk+0xc4/0x11d kernel/printk/printk.c:2046
  fail_dump lib/fault-inject.c:45 [inline]
  should_fail+0x5c5/0x860 lib/fault-inject.c:144
  __should_fail_alloc_page mm/page_alloc.c:3278 [inline]
  should_fail_alloc_page+0x55/0x60 mm/page_alloc.c:3315
  prepare_alloc_pages+0x283/0x460 mm/page_alloc.c:4598
  __alloc_pages_nodemask+0x11c/0x790 mm/page_alloc.c:4645
  __alloc_pages include/linux/gfp.h:473 [inline]
  __alloc_pages_node include/linux/gfp.h:486 [inline]
  kmem_getpages+0x46/0x480 mm/slab.c:1373
  cache_grow_begin+0x7e/0x2c0 mm/slab.c:2606
  cache_alloc_refill+0x311/0x3f0 mm/slab.c:2978
  ____cache_alloc mm/slab.c:3061 [inline]
  __do_cache_alloc mm/slab.c:3283 [inline]
  slab_alloc mm/slab.c:3318 [inline]
  __do_kmalloc mm/slab.c:3658 [inline]
  __kmalloc+0x2e5/0x310 mm/slab.c:3669
  kmalloc include/linux/slab.h:552 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:175 [inline]
  __tty_buffer_request_room+0x1ef/0x560 drivers/tty/tty_buffer.c:273
  tty_insert_flip_string_fixed_flag+0xa4/0x2b0 drivers/tty/tty_buffer.c:318
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0xe2/0x190 drivers/tty/pty.c:122
  tty_put_char+0x115/0x180 drivers/tty/tty_io.c:3031
  __process_echoes+0x19d/0x920 drivers/tty/n_tty.c:746
  flush_echoes drivers/tty/n_tty.c:829 [inline]
  __receive_buf drivers/tty/n_tty.c:1648 [inline]
  n_tty_receive_buf_common+0x297f/0x3080 drivers/tty/n_tty.c:1742
  n_tty_receive_buf+0x30/0x40 drivers/tty/n_tty.c:1771
  tiocsti drivers/tty/tty_io.c:2195 [inline]
  tty_ioctl+0xd63/0x15d0 drivers/tty/tty_io.c:2571
  do_vfs_ioctl+0x7d4/0x1890 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:713 [inline]
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0xe3/0x120 fs/ioctl.c:718
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441439
Code: e8 8c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffeff301068 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441439
RDX: 0000000020000040 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 00007ffeff301080 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000

