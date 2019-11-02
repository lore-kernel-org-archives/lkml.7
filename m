Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABEDCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 23:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87BD2067D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 23:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfKBXcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 19:32:10 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:37787 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfKBXcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 19:32:10 -0400
Received: by mail-il1-f200.google.com with SMTP id u68so12212423ilc.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 16:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gOo8e0PXJkgnVZEt5v8DHGk5xf9TLv5CgNHA6EYSduE=;
        b=RtZZ3o4pC3v4vii4cNJhXHghsYHqf64j3duXvMahNcLUhE0cEE6cCqTZdVxg5JwCLt
         gR4UuXVv8/5Vhbn3GGqofT2dvxJmZUBxvtYgRY3C7Xpu/8YmQE6VfHS41YyQFJ/hzWFo
         s6RElNEnVTExyIJjfvdvF298t2INk7umPKJd2F2HgS/V39KA8cR7q1AdlO4EIqouGJft
         kbQ8FNGXEItzHxWiLkxjzJco81xLtRwACduWyOeIFVCk2jAYsq2YUp+Q1t1VaF9X5t2I
         DGJ+Z75+8D7BhG4IPDtzXDPYpMRCKc68xj1AABJgY+DTQQ6a/1fCc8JSkiTjNA2M//Bn
         vgHg==
X-Gm-Message-State: APjAAAUOJ50poix7X6yRh+vD8AY9JxXfcCv2AhEfkmIULJ7/MGTW4APp
        Xp+XhR9uOj2StocyBAnjegf/GCvGxWcuOkMGB/8/4MLS2woc
X-Google-Smtp-Source: APXvYqzRFWUNXknkDI0aIvjZT0gVuBJEGdytxnKk2NSTBvBKCqc4fjzTxOjLhgVhOJYNcalBzv/PTn+JS+Z2ZaeGvl9gXU4lKYkn
MIME-Version: 1.0
X-Received: by 2002:a92:9117:: with SMTP id t23mr20221286ild.307.1572737528986;
 Sat, 02 Nov 2019 16:32:08 -0700 (PDT)
Date:   Sat, 02 Nov 2019 16:32:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd85b40596657dfa@google.com>
Subject: WARNING: suspicious RCU usage in kvm_dev_ioctl
From:   syzbot <syzbot+75475908cd0910f141ee@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9d234505 Merge tag 'hwmon-for-v5.4-rc6' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b06934e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbbed3e8d4eb64bf
dashboard link: https://syzkaller.appspot.com/bug?extid=75475908cd0910f141ee
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+75475908cd0910f141ee@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.4.0-rc5+ #0 Not tainted
-----------------------------
include/linux/kvm_host.h:534 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor.4/19966.

stack backtrace:
CPU: 0 PID: 19966 Comm: syz-executor.4 Not tainted 5.4.0-rc5+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x153/0x15d kernel/locking/lockdep.c:5438
  kvm_get_bus include/linux/kvm_host.h:534 [inline]
  kvm_get_bus include/linux/kvm_host.h:532 [inline]
  kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:706 [inline]
  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3444  
[inline]
  kvm_dev_ioctl+0x100c/0x1610 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3496
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459f49
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2cbb4fbc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459f49
RDX: 0000000000000002 RSI: 000000000000ae01 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2cbb4fc6d4
R13: 00000000004c30a8 R14: 00000000004d7018 R15: 00000000ffffffff

=============================
WARNING: suspicious RCU usage
5.4.0-rc5+ #0 Not tainted
-----------------------------
include/linux/kvm_host.h:629 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor.4/19966.

stack backtrace:
CPU: 0 PID: 19966 Comm: syz-executor.4 Not tainted 5.4.0-rc5+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x153/0x15d kernel/locking/lockdep.c:5438
  __kvm_memslots include/linux/kvm_host.h:629 [inline]
  __kvm_memslots include/linux/kvm_host.h:626 [inline]
  kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:708 [inline]
  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3444  
[inline]
  kvm_dev_ioctl+0x116c/0x1610 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3496
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459f49
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2cbb4fbc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459f49
RDX: 0000000000000002 RSI: 000000000000ae01 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2cbb4fc6d4
R13: 00000000004c30a8 R14: 00000000004d7018 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
