Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CA1C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24CC20740
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLZVZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:25:13 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:48931 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfLZVZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:25:10 -0500
Received: by mail-il1-f198.google.com with SMTP id u14so12328623ilq.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 13:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZKQ8t0LgRq3eSEQ30gZDP+qRt7+3uldP2yAu+ovI0lM=;
        b=OSQweBjFuMUebGg0jYHcDMffnvP6H/PCYpXebkvTMZdrsm6DpwZGUkRioWkTUdNpeW
         6J/DkNPgfuvURpFjYYxe85kRndGfPUStKvdCsJg5if4ae+Sba4WCs9me3BQf90o9SMdT
         H0BZRFtAyL0KXCHLlW1DszLf6MrDx2CyQVMC5ZCQRKNjaYPvYXRzC2wVOS1Mu1pNXn0M
         fAs5A0skf7/E4JrJkaReRnHk5+t+4hUyyDKXOajKXdFX6tsQo0TCFK5KM0Ou2w33YpB7
         YpEJeqNMWmhxPEIZo5dmcEqrAZnS4RXn1FG9x6wy3vMB2aSFjS4cQGI5woTM2h74HgPM
         nUGg==
X-Gm-Message-State: APjAAAXYsfoX8X5N7NNcu672opdpsMWOMlT0ZX4eC7BH3s2EUj1ENHR1
        dIMBQdnoaq5pqiCXcqkwSp3w6Fn6OFWO/nVPcQy5kSpCAiNS
X-Google-Smtp-Source: APXvYqySw3c5SYTM6WDiwD4RYyo/I1NRODtqLrRrqlDXUw9CGt3QivfVdV9pGcz2LrRCJChL1rfewTyX7Bb2B4uEEkIVNSco22P1
MIME-Version: 1.0
X-Received: by 2002:a5d:8901:: with SMTP id b1mr30764167ion.246.1577395509730;
 Thu, 26 Dec 2019 13:25:09 -0800 (PST)
Date:   Thu, 26 Dec 2019 13:25:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000072c55059aa2033b@google.com>
Subject: possible deadlock in uart_write
From:   syzbot <syzbot+b0e376d3731cd5e82bb7@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    46cf053e Linux 5.5-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17295351e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=b0e376d3731cd5e82bb7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b0e376d3731cd5e82bb7@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.5.0-rc3-syzkaller #0 Not tainted
--------------------------------------------
syz-executor.2/25003 is trying to acquire lock:
ffffffff8c103048 (&port_lock_key){-.-.}, at: uart_write+0x1e1/0x6f0  
drivers/tty/serial/serial_core.c:592

but task is already holding lock:
ffffffff8c103048 (&port_lock_key){-.-.}, at:  
serial8250_handle_irq.part.0+0x24/0x330  
drivers/tty/serial/8250/8250_port.c:1823

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&port_lock_key);
   lock(&port_lock_key);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

5 locks held by syz-executor.2/25003:
  #0: ffff8880942de858 (&(ptlock_ptr(page))->rlock#2){+.+.}, at: spin_lock  
include/linux/spinlock.h:338 [inline]
  #0: ffff8880942de858 (&(ptlock_ptr(page))->rlock#2){+.+.}, at:  
zap_pte_range mm/memory.c:1038 [inline]
  #0: ffff8880942de858 (&(ptlock_ptr(page))->rlock#2){+.+.}, at:  
zap_pmd_range mm/memory.c:1184 [inline]
  #0: ffff8880942de858 (&(ptlock_ptr(page))->rlock#2){+.+.}, at:  
zap_pud_range mm/memory.c:1213 [inline]
  #0: ffff8880942de858 (&(ptlock_ptr(page))->rlock#2){+.+.}, at:  
zap_p4d_range mm/memory.c:1234 [inline]
  #0: ffff8880942de858 (&(ptlock_ptr(page))->rlock#2){+.+.}, at:  
unmap_page_range+0x885/0x28a0 mm/memory.c:1255
  #1: ffffffff899a5680 (rcu_read_lock){....}, at: lock_page_memcg+0x0/0x240  
include/linux/cgroup.h:491
  #2: ffff88809ed05430 (&(&i->lock)->rlock){-.-.}, at: spin_lock  
include/linux/spinlock.h:338 [inline]
  #2: ffff88809ed05430 (&(&i->lock)->rlock){-.-.}, at:  
serial8250_interrupt+0x2d/0x1a0 drivers/tty/serial/8250/8250_core.c:116
  #3: ffffffff8c103048 (&port_lock_key){-.-.}, at:  
serial8250_handle_irq.part.0+0x24/0x330  
drivers/tty/serial/8250/8250_port.c:1823
  #4: ffff88808c386090 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref+0x22/0x90  
drivers/tty/tty_ldisc.c:288

stack backtrace:
CPU: 1 PID: 25003 Comm: syz-executor.2 Not tainted 5.5.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_deadlock_bug kernel/locking/lockdep.c:2371 [inline]
  check_deadlock kernel/locking/lockdep.c:2412 [inline]
  validate_chain kernel/locking/lockdep.c:2955 [inline]
  __lock_acquire.cold+0x15d/0x385 kernel/locking/lockdep.c:3955
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
  uart_write+0x1e1/0x6f0 drivers/tty/serial/serial_core.c:592
  n_hdlc_send_frames+0x29a/0x480 drivers/tty/n_hdlc.c:403
  n_hdlc_tty_wakeup+0xc0/0xe0 drivers/tty/n_hdlc.c:479
  tty_wakeup+0xe9/0x120 drivers/tty/tty_io.c:536
  tty_port_default_wakeup+0x2b/0x40 drivers/tty/tty_port.c:50
  tty_port_tty_wakeup+0x57/0x70 drivers/tty/tty_port.c:388
  uart_write_wakeup+0x46/0x70 drivers/tty/serial/serial_core.c:104
  serial8250_tx_chars+0x495/0xaf0 drivers/tty/serial/8250/8250_port.c:1761
  serial8250_handle_irq.part.0+0x2a2/0x330  
drivers/tty/serial/8250/8250_port.c:1834
  serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1820 [inline]
  serial8250_default_handle_irq+0xc0/0x150  
drivers/tty/serial/8250/8250_port.c:1850
  serial8250_interrupt+0xf1/0x1a0 drivers/tty/serial/8250/8250_core.c:126
  __handle_irq_event_percpu+0x15d/0x970 kernel/irq/handle.c:149
  handle_irq_event_percpu+0x74/0x160 kernel/irq/handle.c:189
  handle_irq_event+0xa7/0x134 kernel/irq/handle.c:206
  handle_edge_irq+0x25e/0x8d0 kernel/irq/chip.c:830
  generic_handle_irq_desc include/linux/irqdesc.h:156 [inline]
  do_IRQ+0xde/0x280 arch/x86/kernel/irq.c:250
  common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:607
  </IRQ>
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:174 [inline]
RIP: 0010:check_memory_region+0x105/0x1a0 mm/kasan/generic.c:192
Code: eb 0c 49 83 c0 01 4c 89 c8 4d 39 c8 74 10 41 80 38 00 74 ee 4b 8d 44  
25 00 4d 85 c0 75 31 49 89 d9 49 29 c1 e9 68 ff ff ff 5b <b8> 01 00 00 00  
41 5c 41 5d 5d c3 4d 85 c9 74 ef 4d 01 e1 eb 09 48
RSP: 0018:ffffc9000749f8a0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffda
RAX: ffffed1015d2703d RBX: ffff8880ae938100 RCX: ffffffff8162ae44
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880ae9381e0
RBP: ffffc9000749f8b0 R08: 1ffff11015d2703c R09: ffffed1015d2703d
R10: ffffed1015d2703c R11: ffff8880ae9381e3 R12: ffffed1015d2703c
R13: 0000000000000000 R14: ffffea0001b62008 R15: dead000000000100
  __kasan_check_read+0x11/0x20 mm/kasan/common.c:95
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  rcu_dynticks_curr_cpu_in_eqs+0x54/0xb0 kernel/rcu/tree.c:301
  rcu_is_watching+0x10/0x30 kernel/rcu/tree.c:922
  rcu_read_unlock include/linux/rcupdate.h:667 [inline]
  __unlock_page_memcg+0x73/0x100 mm/memcontrol.c:2019
  unlock_page_memcg+0x2c/0x40 mm/memcontrol.c:2028
  page_remove_file_rmap mm/rmap.c:1273 [inline]
  page_remove_rmap+0x60c/0x11d0 mm/rmap.c:1330
  zap_pte_range mm/memory.c:1080 [inline]
  zap_pmd_range mm/memory.c:1184 [inline]
  zap_pud_range mm/memory.c:1213 [inline]
  zap_p4d_range mm/memory.c:1234 [inline]
  unmap_page_range+0xde0/0x28a0 mm/memory.c:1255
  unmap_single_vma+0x19d/0x300 mm/memory.c:1300
  unmap_vmas+0x184/0x2f0 mm/memory.c:1332
  exit_mmap+0x2ba/0x530 mm/mmap.c:3140
  __mmput kernel/fork.c:1082 [inline]
  mmput+0x179/0x4d0 kernel/fork.c:1103
  exit_mm kernel/exit.c:485 [inline]
  do_exit+0x806/0x2ef0 kernel/exit.c:784
  do_group_exit+0x135/0x360 kernel/exit.c:895
  __do_sys_exit_group kernel/exit.c:906 [inline]
  __se_sys_exit_group kernel/exit.c:904 [inline]
  __ia32_sys_exit_group+0x44/0x50 kernel/exit.c:904
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f32a39
Code: 00 00 00 89 d3 5b 5e 5f 5d c3 b8 80 96 98 00 eb c4 8b 04 24 c3 8b 1c  
24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:000000000848fd7c EFLAGS: 00000202 ORIG_RAX: 00000000000000fc
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000080589db
RBP: 00000000fffffff7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
