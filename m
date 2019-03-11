Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43F02075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfCKIUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:20:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:40720 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfCKIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:20:06 -0400
Received: by mail-io1-f72.google.com with SMTP id 68so3561174iov.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GWn4w8jVQT2UQt2lPKqTzyhyuteAYzrVuL102XVeqA8=;
        b=K7JaPAYhrEfbmowlnInPB60sRdDo0ECDHe5lA6/QywgottkuC3Ap1E7E0Eldo8dnTw
         8mWPnUP7HP35qwMVHjuLgo/b8WKgBaQmdC1FWhTkEOo6GXTWUWHHMiMCMKBIaQvAU1V8
         N9ljbeJ+UPrqeSF/kJaJcB5SiEwcalYrGZ2U30hXcxArJgIKDiPI257sFFxGjwuhY2x3
         zDgRqxqKfCYvbT177w4+oZciRF4T2gCh8XIl4/zGm6Hxw/x8Y0i/5gIaHdBD4IVxlon2
         ptGANrSskUMR5nebNKMsein0RX+iVw4ic+6G/0/Y+D6gqcess5b+4+kh/NkeIEP8Xx0Z
         P1xg==
X-Gm-Message-State: APjAAAW4YlUfblnCP6Niyr0j8JQg1SENkJ0UUU+LUrT3S6cc73HxCo4G
        VUjbImti60vGSqH0VHCO7v3RR0DXqAdpsdpH2FzXjGOf++1t
X-Google-Smtp-Source: APXvYqzMqtodRVUeqdnXwAdHoV6BXPtnOrvygpjlMnI81l35w0lbvtnbmnd9ZcLeo1kQKcATxiybuDQngYBgF0LmJ8574gNEmn5I
MIME-Version: 1.0
X-Received: by 2002:a24:c1:: with SMTP id 184mr19696535ita.21.1552292405470;
 Mon, 11 Mar 2019 01:20:05 -0700 (PDT)
Date:   Mon, 11 Mar 2019 01:20:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a71990583cd3d9c@google.com>
Subject: INFO: task hung in tls_sw_sendmsg
From:   syzbot <syzbot+8a6df99c3b1812093b70@syzkaller.appspotmail.com>
To:     ast@kernel.org, aviadye@mellanox.com, borisp@mellanox.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, john.fastabend@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d9862cfb Merge tag 'mips_5.1' of git://git.kernel.org/pub/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16e9d977200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73d88a42238825ad
dashboard link: https://syzkaller.appspot.com/bug?extid=8a6df99c3b1812093b70
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8a6df99c3b1812093b70@syzkaller.appspotmail.com

INFO: task syz-executor.0:8515 blocked for more than 140 seconds.
       Not tainted 5.0.0+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D26688  8515   7527 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2844 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3485
  schedule+0x92/0x180 kernel/sched/core.c:3529
  schedule_timeout+0x8ca/0xfd0 kernel/time/timer.c:1779
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x29c/0x440 kernel/sched/completion.c:136
  crypto_wait_req include/linux/crypto.h:680 [inline]
  crypto_wait_req include/linux/crypto.h:675 [inline]
  tls_sw_sendmsg+0x13a6/0x17b0 net/tls/tls_sw.c:1057
  inet_sendmsg+0x147/0x5d0 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:632
  sock_write_iter+0x27c/0x3e0 net/socket.c:923
  call_write_iter include/linux/fs.h:1869 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x613/0x8e0 fs/read_write.c:487
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0xea/0x1f0 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457f29
Code: Bad RIP value.
RSP: 002b:00007f97c3eecc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457f29
RDX: 0000000000000008 RSI: 0000000020000200 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f97c3eed6d4
R13: 00000000004c7360 R14: 00000000004dcee8 R15: 00000000ffffffff
INFO: task syz-executor.0:8521 blocked for more than 140 seconds.
       Not tainted 5.0.0+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29856  8521   7527 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2844 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3485
  schedule+0x92/0x180 kernel/sched/core.c:3529
  __lock_sock+0x165/0x290 net/core/sock.c:2389
  lock_sock_nested+0xfe/0x120 net/core/sock.c:2914
  lock_sock include/net/sock.h:1507 [inline]
  tls_sw_sendmsg+0x25d/0x17b0 net/tls/tls_sw.c:885
  inet_sendmsg+0x147/0x5d0 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:632
  __sys_sendto+0x262/0x380 net/socket.c:1809
  __do_sys_sendto net/socket.c:1821 [inline]
  __se_sys_sendto net/socket.c:1817 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1817
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457f29
Code: Bad RIP value.
RSP: 002b:00007f97c3ecbc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000457f29
RDX: ffffffffffffffc1 RSI: 00000000200005c0 RDI: 0000000000000003
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 923d000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f97c3ecc6d4
R13: 00000000004c565d R14: 00000000004d95a0 R15: 00000000ffffffff
INFO: task syz-executor.0:8526 blocked for more than 140 seconds.
       Not tainted 5.0.0+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D30160  8526   7527 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2844 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3485
  schedule+0x92/0x180 kernel/sched/core.c:3529
  __lock_sock+0x165/0x290 net/core/sock.c:2389
  lock_sock_nested+0xfe/0x120 net/core/sock.c:2914
  lock_sock include/net/sock.h:1507 [inline]
  do_tcp_setsockopt.isra.0+0x15e/0x2330 net/ipv4/tcp.c:2822
  tcp_setsockopt+0xc4/0xf0 net/ipv4/tcp.c:3110
  tls_setsockopt+0xac/0x8e0 net/tls/tls_main.c:564
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3120
  __sys_setsockopt+0x180/0x280 net/socket.c:1923
  __do_sys_setsockopt net/socket.c:1934 [inline]
  __se_sys_setsockopt net/socket.c:1931 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1931
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457f29
Code: Bad RIP value.
RSP: 002b:00007f97c3eaac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457f29
RDX: 0000000000000012 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 000000000073c040 R08: 0000000000000004 R09: 0000000000000000
R10: 00000000200001c0 R11: 0000000000000246 R12: 00007f97c3eab6d4
R13: 00000000004c5d49 R14: 00000000004da278 R15: 00000000ffffffff

Showing all locks held in the system:
1 lock held by khungtaskd/1041:
  #0: 0000000022d9f463 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:4389
1 lock held by rsyslogd/7399:
  #0: 0000000091d241ec (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:795
2 locks held by getty/7489:
  #0: 00000000612e0e59 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000095db3241 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7490:
  #0: 000000004ad623b4 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000004a51f0b6 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7491:
  #0: 00000000fd8913ca (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000dd317f0f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7492:
  #0: 00000000d815aded (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000bd34c3e8 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7493:
  #0: 000000001816ff5a (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000a8f03d42 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7494:
  #0: 000000006ff010e8 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000be21b3dc (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7495:
  #0: 00000000404259d6 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000015c29e40 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
1 lock held by syz-executor.0/8515:
  #0: 00000000ab597fc5 (sk_lock-AF_INET6){+.+.}, at: lock_sock  
include/net/sock.h:1507 [inline]
  #0: 00000000ab597fc5 (sk_lock-AF_INET6){+.+.}, at:  
tls_sw_sendmsg+0x25d/0x17b0 net/tls/tls_sw.c:885

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1041 Comm: khungtaskd Not tainted 5.0.0+ #97
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:203 [inline]
  watchdog+0x9df/0xee0 kernel/hung_task.c:287
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2573 Comm: kworker/u4:4 Not tainted 5.0.0+ #97
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:hlock_class kernel/locking/lockdep.c:155 [inline]
RIP: 0010:mark_lock+0x63/0x1380 kernel/locking/lockdep.c:3036
Code: 20 0f b6 04 02 84 c0 74 08 3c 01 0f 8e 5d 07 00 00 41 0f b7 44 24 20  
66 a9 ff 1f 74 7e 48 ba 00 00 00 00 00 fc ff df 4c 89 c9 <48> c1 e9 03 0f  
b6 14 11 84 d2 74 09 80 fa 03 0f 8e 44 07 00 00 25
RSP: 0018:ffff8880a1657a28 EFLAGS: 00000006
RAX: 000000000000002b RBX: 0000000000000000 RCX: ffff8880a164aeb0
RDX: dffffc0000000000 RSI: ffff8880a164ae90 RDI: ffff8880a164a5c0
RBP: ffff8880a1657a70 R08: 0000000000000002 R09: ffff8880a164aeb0
R10: ffff8880a164ae90 R11: 0000000000000000 R12: ffff8880a164ae90
R13: 0000000000000100 R14: 0000000000000008 R15: ffff8880a164a5c0
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000000958a1000 CR4: 00000000001406e0
Call Trace:
  __lock_acquire+0x53b/0x4700 kernel/locking/lockdep.c:3299
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
  rcu_lock_acquire include/linux/rcupdate.h:223 [inline]
  rcu_read_lock include/linux/rcupdate.h:607 [inline]
  batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:419 [inline]
  batadv_nc_worker+0x117/0x760 net/batman-adv/network-coding.c:730
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2173
  worker_thread+0x98/0xe40 kernel/workqueue.c:2319
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
