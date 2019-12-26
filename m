Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29FCC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCB8206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfLZVZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:25:11 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:49328 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfLZVZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:25:10 -0500
Received: by mail-io1-f69.google.com with SMTP id c11so5972688iod.16
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 13:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=E9RtJIqbLTDYvo+ld1HlAJTT2aRb3Zwj2e/n97RqUfo=;
        b=NuXnIYQP9oNoWmW3ISsZby8HBjhoJPNqtoxLJkX6agYMK5eMnkGzEZ6XPUVM82fA11
         2A0qj1wsWZF2OuyvuVqj+VmY8BzWmagG17GLIXMizJ/5IkQtKzfBp3HIhpcBnIk8FTEB
         yhhMZqqLxI3i6YB2n4xuACOdExgRCGnlVaKupY5VomtfniOD866UAapMSk83NNgsnMCG
         w/z97+KSEzB3goGfrFi3/4yNNdq2nagwZbflFXrouJzDRDA5CAI0I8qYdkQkL/dykiSd
         oqcLaWNBQQQ8wpt13Duh5klKQFFa+dZujsTitpgEcZ8zwhfCjrK+km+u8ptWWy8DPZdp
         MoTA==
X-Gm-Message-State: APjAAAXuy3gtJ95zVur2iS2PJDhjLzOAtRXG/qUdw/VYFrs+2M/0qKQU
        k06OHafiItQHDzuIC4lSrjqMobEkwezXAQpo6msssFtBx4w8
X-Google-Smtp-Source: APXvYqyyRp6N8NJELmQkJQYnlQ1REt0NTlaowWKnAZZjALv0DW6K7lQEZLvY4HBkuG0S+0XU1dfNPK5qaupeWCKqCOyPDhzYzoCp
MIME-Version: 1.0
X-Received: by 2002:a92:c990:: with SMTP id y16mr42871600iln.105.1577395509517;
 Thu, 26 Dec 2019 13:25:09 -0800 (PST)
Date:   Thu, 26 Dec 2019 13:25:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003e6cb059aa20399@google.com>
Subject: BUG: sleeping function called from invalid context in do_con_write
From:   syzbot <syzbot+c9278c0d201bb6cff538@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    46cf053e Linux 5.5-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c3fa15e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=c9278c0d201bb6cff538
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c9278c0d201bb6cff538@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at  
drivers/tty/vt/vt.c:2568
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 30842, name:  
syz-executor.5
3 locks held by syz-executor.5/30842:
  #0: ffff888094d05090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffff888094d05390 (&(&tty->flow_lock)->rlock){....}, at: spin_lock_irq  
include/linux/spinlock.h:363 [inline]
  #1: ffff888094d05390 (&(&tty->flow_lock)->rlock){....}, at:  
n_tty_ioctl_helper drivers/tty/tty_ioctl.c:914 [inline]
  #1: ffff888094d05390 (&(&tty->flow_lock)->rlock){....}, at:  
n_tty_ioctl_helper+0xd1/0x3b0 drivers/tty/tty_ioctl.c:894
  #2: ffff888094d05090 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref+0x22/0x90  
drivers/tty/tty_ldisc.c:288
irq event stamp: 3506
hardirqs last  enabled at (3505): [<ffffffff81b29986>] kfree+0x226/0x2c0  
mm/slab.c:3758
hardirqs last disabled at (3506): [<ffffffff87c8c09a>] __raw_spin_lock_irq  
include/linux/spinlock_api_smp.h:126 [inline]
hardirqs last disabled at (3506): [<ffffffff87c8c09a>]  
_raw_spin_lock_irq+0x3a/0x80 kernel/locking/spinlock.c:167
softirqs last  enabled at (3386): [<ffffffff864dc83b>] sock_net  
include/net/sock.h:2474 [inline]
softirqs last  enabled at (3386): [<ffffffff864dc83b>]  
netlink_release+0xd4b/0x1c60 net/netlink/af_netlink.c:799
softirqs last disabled at (3384): [<ffffffff864dc7ff>]  
netlink_release+0xd0f/0x1c60 net/netlink/af_netlink.c:780
Preemption disabled at:
[<ffffffff83dc30f1>] spin_lock_irq include/linux/spinlock.h:363 [inline]
[<ffffffff83dc30f1>] n_tty_ioctl_helper drivers/tty/tty_ioctl.c:914 [inline]
[<ffffffff83dc30f1>] n_tty_ioctl_helper+0xd1/0x3b0  
drivers/tty/tty_ioctl.c:894
CPU: 0 PID: 30842 Comm: syz-executor.5 Not tainted 5.5.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6800
  __might_sleep+0x95/0x190 kernel/sched/core.c:6753
  do_con_write.part.0+0xa6/0x1ef0 drivers/tty/vt/vt.c:2568
  do_con_write drivers/tty/vt/vt.c:2565 [inline]
  con_write+0x46/0xd0 drivers/tty/vt/vt.c:3135
  n_hdlc_send_frames+0x29a/0x480 drivers/tty/n_hdlc.c:403
  n_hdlc_tty_wakeup+0xc0/0xe0 drivers/tty/n_hdlc.c:479
  tty_wakeup+0xe9/0x120 drivers/tty/tty_io.c:536
  __start_tty.part.0+0xd6/0x100 drivers/tty/tty_io.c:808
  __start_tty+0x64/0x80 drivers/tty/tty_io.c:803
  n_tty_ioctl_helper drivers/tty/tty_ioctl.c:917 [inline]
  n_tty_ioctl_helper+0x355/0x3b0 drivers/tty/tty_ioctl.c:894
  n_hdlc_tty_ioctl+0x107/0x360 drivers/tty/n_hdlc.c:783
  tty_ioctl+0xaf9/0x14f0 drivers/tty/tty_io.c:2669
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a919
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc3234f5c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a919
RDX: 0000000000000001 RSI: 000000000000540a RDI: 0000000000000007
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc3234f66d4
R13: 00000000004c5a99 R14: 00000000004dbdc8 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
