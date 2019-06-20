Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD124C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D902080D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbfFTNRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:17:14 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:43405 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731978AbfFTNRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:17:07 -0400
Received: by mail-io1-f69.google.com with SMTP id y5so5166370ioj.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1/e2L6DnvZPbR4KMxHyd/8EkCFUizcpF3bSLCBxE0Ok=;
        b=nrEansu3m6InLOXxPkusccigjUWIuUsrLguGpF4BYlUShm4vy4X37rHFOZBfiwF6ha
         CPtjnP8IGUUZo7GVq6tBIHqfcVxjE/H2GE5UGgJZVPJWUTEfKOgl7ljV2dP1ZoRw61ZX
         lj+Mn/gSyjMLR7Z8iUG4+T/pVyGiQYXLdAPlNiH88KT1BTRDBzm0IneGSCtDSOXKVJ02
         tLD66hDHMEf9a1HPN2diqHqgv/l15wcykmCX+uywsQ7F8+PuqTH3EtV/j5S5GlR6Bo+/
         ol/SVAuabkyX+STIYDA9EH0z6rF928PRzasIgLE6VdpiGXt11AVggydMDIjgTkCl56it
         JPwA==
X-Gm-Message-State: APjAAAW5Zj/Q5XBdOP0eX9DmUxFXFIRvxxyE4Je6hNc2zYcz6ey85oUO
        KZWLP23HIyi8Mv8MMjQFJb+u3RI5i4iDinzUpxWtxdNgpiNu
X-Google-Smtp-Source: APXvYqwdQoLkzbajBt+QyYeSEnesfU5aTTk/5KMPXDpEUn/zfAOK54qKSuO1477ZMBdllvjg+GRbnPN7nEtso06wsYsmMB+amGeN
MIME-Version: 1.0
X-Received: by 2002:a6b:c803:: with SMTP id y3mr21187652iof.275.1561036626512;
 Thu, 20 Jun 2019 06:17:06 -0700 (PDT)
Date:   Thu, 20 Jun 2019 06:17:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ad686058bc12956@google.com>
Subject: possible deadlock in console_trylock_spinning
From:   syzbot <syzbot+fc1da0f1a577d15b64fc@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bed3c0d8 Merge tag 'for-5.2-rc5-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a165c9a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=fc1da0f1a577d15b64fc
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fc1da0f1a577d15b64fc@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.2.0-rc5+ #3 Not tainted
------------------------------------------------------
syz-executor.1/11011 is trying to acquire lock:
0000000046a921a5 (console_owner){-.-.}, at:  
console_trylock_spinning+0x12f/0x390 kernel/printk/printk.c:1718

but task is already holding lock:
00000000b4370e8d (&(&port->lock)->rlock){-.-.}, at: pty_write+0xbd/0x190  
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
        arch_local_irq_restore arch/x86/include/asm/paravirt.h:767 [inline]
        __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
[inline]
        _raw_spin_unlock_irqrestore+0xad/0xe0 kernel/locking/spinlock.c:191
        spin_unlock_irqrestore include/linux/spinlock.h:393 [inline]
        uart_write+0x841/0xa50 drivers/tty/serial/serial_core.c:612
        process_output_block drivers/tty/n_tty.c:595 [inline]
        n_tty_write+0xd6c/0x12d0 drivers/tty/n_tty.c:2333
        do_tty_write drivers/tty/tty_io.c:961 [inline]
        tty_write+0x581/0x860 drivers/tty/tty_io.c:1045
        redirected_tty_write+0x9e/0xb0 drivers/tty/tty_io.c:1066
        __vfs_write+0xf9/0x7d0 fs/read_write.c:494
        vfs_write+0x227/0x510 fs/read_write.c:558
        ksys_write+0x16b/0x2a0 fs/read_write.c:611
        __do_sys_write fs/read_write.c:623 [inline]
        __se_sys_write fs/read_write.c:620 [inline]
        __x64_sys_write+0x7b/0x90 fs/read_write.c:620
        do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

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
        __should_failslab+0x11a/0x160 mm/failslab.c:32
        should_failslab+0x9/0x20 mm/slab_common.c:1610
        slab_pre_alloc_hook mm/slab.h:420 [inline]
        slab_alloc mm/slab.c:3312 [inline]
        __do_kmalloc mm/slab.c:3658 [inline]
        __kmalloc+0x7a/0x310 mm/slab.c:3669
        kmalloc include/linux/slab.h:552 [inline]
        tty_buffer_alloc drivers/tty/tty_buffer.c:175 [inline]
        __tty_buffer_request_room+0x1ef/0x560 drivers/tty/tty_buffer.c:273
        tty_insert_flip_string_fixed_flag+0xa4/0x2b0  
drivers/tty/tty_buffer.c:318
        tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
        pty_write+0xe2/0x190 drivers/tty/pty.c:122
        tty_put_char+0x115/0x180 drivers/tty/tty_io.c:3031
        __process_echoes+0x47f/0x920 drivers/tty/n_tty.c:728
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

4 locks held by syz-executor.1/11011:
  #0: 000000001e367af1 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 00000000a83060be (&o_tty->termios_rwsem/1){++++}, at:  
n_tty_receive_buf_common+0x8b/0x3080 drivers/tty/n_tty.c:1705
  #2: 0000000055e44ce8 (&ldata->output_lock){+.+.}, at: flush_echoes  
drivers/tty/n_tty.c:827 [inline]
  #2: 0000000055e44ce8 (&ldata->output_lock){+.+.}, at: __receive_buf  
drivers/tty/n_tty.c:1648 [inline]
  #2: 0000000055e44ce8 (&ldata->output_lock){+.+.}, at:  
n_tty_receive_buf_common+0x2940/0x3080 drivers/tty/n_tty.c:1742
  #3: 00000000b4370e8d (&(&port->lock)->rlock){-.-.}, at:  
pty_write+0xbd/0x190 drivers/tty/pty.c:120

stack backtrace:
CPU: 1 PID: 11011 Comm: syz-executor.1 Not tainted 5.2.0-rc5+ #3
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
  __should_failslab+0x11a/0x160 mm/failslab.c:32
  should_failslab+0x9/0x20 mm/slab_common.c:1610
  slab_pre_alloc_hook mm/slab.h:420 [inline]
  slab_alloc mm/slab.c:3312 [inline]
  __do_kmalloc mm/slab.c:3658 [inline]
  __kmalloc+0x7a/0x310 mm/slab.c:3669
  kmalloc include/linux/slab.h:552 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:175 [inline]
  __tty_buffer_request_room+0x1ef/0x560 drivers/tty/tty_buffer.c:273
  tty_insert_flip_string_fixed_flag+0xa4/0x2b0 drivers/tty/tty_buffer.c:318
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0xe2/0x190 drivers/tty/pty.c:122
  tty_put_char+0x115/0x180 drivers/tty/tty_io.c:3031
  __process_echoes+0x47f/0x920 drivers/tty/n_tty.c:728
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
RIP: 0033:0x4592c9
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1a2359dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1a2359dc90 RCX: 00000000004592c9
RDX: 0000000020000000 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1a2359e6d4
R13: 00000000004c3827 R14: 00000000004d71d8 R15: 0000000000000005


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
