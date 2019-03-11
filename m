Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4573EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0BA2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfCKOMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:12:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50000 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfCKOMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:12:07 -0400
Received: by mail-io1-f70.google.com with SMTP id m15so4197076ioc.16
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cl+P7120Fsa6h6k+x+4XuL6GbhgmXrZB7jPLhFeISdo=;
        b=g+a78AdKde+HZOyoX7pymLWo9vhJn1a9Sa4KJQ/1XF4vKarIqMyBCPwBSDB2/mNswr
         tAO0FCQg3S+MzDv3oz1LX5qxFJKpXV/sYAnHuYm9mGMmF3xnJj0lIocEb9Pu+u1w8m1d
         WUFoUsrt7oBxGMG/KqN7/3whw9zXUeiM5TdFKM4+iCRQvoRX+foyg4Yl5Z1aUcdOeQ8+
         NC5/QJ5UH6wfnCGCoLZm+3z3gVrQen80uRxh1LCMKvupip0a9W74GfLvMpc8iAtuaSaO
         bsuCO1PJ/7fhb6hvKDBGh/t7I+UFFo/kwijedDJxsu7SYI4hrehAVn/Nia9ZK59nuSbL
         RE0w==
X-Gm-Message-State: APjAAAW7Ql4Xqnte+2qFTYG596sGPS0z2EvfHvZvQox25F8ZbSY4CgaU
        //xk7eE/UOjmtm9rpvNuRGPqXtoPjMPu4w3VE4M8PKlv1u7C
X-Google-Smtp-Source: APXvYqy8gJdnMCdw7O8QYzcFdeAsSnOQXfeYJsqrWoPVIJX5jGfyU3mNOPe+VYI2RsmogQSMmZ0M4ZdBgG9qei6a1I3d9+GN74dC
MIME-Version: 1.0
X-Received: by 2002:a24:612:: with SMTP id 18mr21348958itv.7.1552313525917;
 Mon, 11 Mar 2019 07:12:05 -0700 (PDT)
Date:   Mon, 11 Mar 2019 07:12:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004aed310583d22822@google.com>
Subject: WARNING in lockdep_unregister_key
From:   syzbot <syzbot+be0c198232f86389c3dd@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    12ad143e Merge branch 'perf-urgent-for-linus' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e7404d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9d91b7192a5e96e
dashboard link: https://syzkaller.appspot.com/bug?extid=be0c198232f86389c3dd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1006dc83200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137d0027200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+be0c198232f86389c3dd@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441019
RDX: 0000000000000001 RSI: 00000000400455c8 RDI: 0000000000000003
RBP: 00007ffee4c7fe00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
WARNING: CPU: 0 PID: 7719 at kernel/locking/lockdep.c:4925  
lockdep_unregister_key+0x1ef/0x4c0 kernel/locking/lockdep.c:4925
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7719 Comm: syz-executor066 Not tainted 5.0.0+ #17
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:lockdep_unregister_key+0x1ef/0x4c0 kernel/locking/lockdep.c:4925
Code: 00 00 00 00 00 fc ff df 4c 89 c2 48 c1 ea 03 80 3c 02 00 0f 85 c9 02  
00 00 48 b8 00 02 00 00 00 00 ad de 49 89 44 24 08 eb 02 <0f> 0b ba 01 00  
00 00 4c 89 e6 4c 89 ff e8 8f de ff ff 4c 89 ff e8
RSP: 0018:ffff88808cd37950 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffffffff12bad2b
RDX: 1ffffffff1465a7c RSI: 0000000000000000 RDI: ffffffff8a32d3e0
RBP: ffff88808cd37980 R08: 1ffff110119a6f1e R09: ffffed10119a6f1f
R10: ffffed10119a6f1e R11: 0000000000000003 R12: ffff888095231398
R13: dffffc0000000000 R14: 0000000000000282 R15: ffffffff8a0a6748
  wq_unregister_lockdep kernel/workqueue.c:3455 [inline]
  alloc_workqueue+0xc52/0xf30 kernel/workqueue.c:4296
  hci_register_dev+0x1b8/0x860 net/bluetooth/hci_core.c:3288
  hci_uart_register_dev drivers/bluetooth/hci_ldisc.c:676 [inline]
  hci_uart_set_proto drivers/bluetooth/hci_ldisc.c:700 [inline]
  hci_uart_tty_ioctl+0x766/0xb00 drivers/bluetooth/hci_ldisc.c:754
  tty_ioctl+0xac9/0x14d0 drivers/tty/tty_io.c:2664
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441019
Code: e8 0c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffee4c7fde8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441019
RDX: 0000000000000001 RSI: 00000000400455c8 RDI: 0000000000000003
RBP: 00007ffee4c7fe00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
