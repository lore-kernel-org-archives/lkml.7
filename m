Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BECCC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 08:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46398206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 08:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfDNI2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 04:28:09 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53792 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfDNI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 04:28:08 -0400
Received: by mail-io1-f72.google.com with SMTP id w11so11602379iom.20
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 01:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VxuBRvLbNB3G4nmyiGOz93DLtiV+Qz/IMubZNm/6mlM=;
        b=eh+IvtzHN38GSZwAG+VguaPxZh31xmfK44+WTxMY7VBtF6GTjV5MbPqMDvuXMXjjui
         uza//Z+NimwVbgiSzXgWsc/Be7xRquroH9+bwQfLcpW0WVFQvrIaJRr145sVUgW9xDzm
         XrLv8pGcFnKGHUL268+TguYzkyq+Gmv3d2LqEH0BwZGQ0jleSxPFJpifyS8+FAddnm0Z
         e55uWr3TShhwvdhXLNo1gmpzuW6SmjNbUt4vqLCRcEllcS/ZPXAoKUntd+rASGvjpaTA
         0IBQp4YOC4T8uDHx5lKOcrAwNE2Cckq51RfSw2rHSU3sxUqtfhjHaYe1SSFELitoagNl
         hgRg==
X-Gm-Message-State: APjAAAWu8IvszWzh+46XP8IW6jIST3DO0VPENNgv+fEgOtEdmCOp7ahY
        D277vcvNaKDWSTA5abiXRn6wpgiz64jLS7nJhyRxywYxxajQ
X-Google-Smtp-Source: APXvYqxE7B1Nv9LpLvfTsoDNqZHxkPcOg93HpSyF4zzk3oPk+vsXiefPvPg+4tVWH4qpKkEVwP8j7AjUdwdZ5KtXX7Cj0aey++IS
MIME-Version: 1.0
X-Received: by 2002:a6b:6f0e:: with SMTP id k14mr11195785ioc.11.1555230487525;
 Sun, 14 Apr 2019 01:28:07 -0700 (PDT)
Date:   Sun, 14 Apr 2019 01:28:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0bffa0586795098@google.com>
Subject: WARNING: bad unlock balance in rcu_core
From:   syzbot <syzbot+36baa6c2180e959e19b1@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6d0a5984 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15629ab7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=36baa6c2180e959e19b1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+36baa6c2180e959e19b1@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
5.1.0-rc4+ #66 Not tainted
-------------------------------------
syz-executor.1/17297 is trying to release lock (rcu_callback) at:
[<ffffffff815f08d6>] __write_once_size include/linux/compiler.h:220 [inline]
[<ffffffff815f08d6>] __rcu_reclaim kernel/rcu/rcu.h:226 [inline]
[<ffffffff815f08d6>] rcu_do_batch kernel/rcu/tree.c:2475 [inline]
[<ffffffff815f08d6>] invoke_rcu_callbacks kernel/rcu/tree.c:2788 [inline]
[<ffffffff815f08d6>] rcu_core+0x906/0x13a0 kernel/rcu/tree.c:2769
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor.1/17297:
  #0: 00000000248f8dcd (&type->s_umount_key#59/1){+.+.}, at:  
alloc_super+0x158/0x890 fs/super.c:228

stack backtrace:
CPU: 0 PID: 17297 Comm: syz-executor.1 Not tainted 5.1.0-rc4+ #66
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_unlock_imbalance_bug kernel/locking/lockdep.c:3754 [inline]
  print_unlock_imbalance_bug.cold+0x114/0x123 kernel/locking/lockdep.c:3731
  __lock_release kernel/locking/lockdep.c:3970 [inline]
  lock_release+0x67e/0xa00 kernel/locking/lockdep.c:4230
  rcu_lock_release include/linux/rcupdate.h:215 [inline]
  __rcu_reclaim kernel/rcu/rcu.h:228 [inline]
  rcu_do_batch kernel/rcu/tree.c:2475 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2788 [inline]
  rcu_core+0x92e/0x13a0 kernel/rcu/tree.c:2769
  __do_softirq+0x266/0x95a kernel/softirq.c:293
  invoke_softirq kernel/softirq.c:374 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:414
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x14a/0x570 arch/x86/kernel/apic/apic.c:1062
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:767  
[inline]
RIP: 0010:console_unlock+0xb82/0xed0 kernel/printk/printk.c:2460
Code: 92 88 48 c1 e8 03 42 80 3c 30 00 0f 85 e4 02 00 00 48 83 3d 4f fa 37  
07 00 0f 84 91 01 00 00 e8 84 f0 15 00 48 8b 7d 98 57 9d <0f> 1f 44 00 00  
e9 6b ff ff ff e8 6f f0 15 00 48 8b 7d 08 c7 05 11
RSP: 0018:ffff88805aa4f8d0 EFLAGS: 00000212 ORIG_RAX: ffffffffffffff13
RAX: 0000000000040000 RBX: 0000000000000200 RCX: ffffc90008209000
RDX: 00000000000101de RSI: ffffffff815a9c2c RDI: 0000000000000212
RBP: ffff88805aa4f958 R08: ffff888099a66100 R09: fffffbfff11335b9
R10: fffffbfff11335b8 R11: 0000000000000001 R12: 0000000000000000
R13: ffffffff84210cf0 R14: dffffc0000000000 R15: ffffffff88f90710
  vprintk_emit+0x280/0x6d0 kernel/printk/printk.c:1975
  vprintk_default+0x28/0x30 kernel/printk/printk.c:2002
  vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
  printk+0xba/0xed kernel/printk/printk.c:2035
  __ntfs_error.cold+0x91/0xc7 fs/ntfs/debug.c:103
  ntfs_fill_super+0x2015/0x3150 fs/ntfs/super.c:2792
  mount_bdev+0x307/0x3c0 fs/super.c:1346
  ntfs_mount+0x35/0x40 fs/ntfs/super.c:3065
  legacy_get_tree+0xf2/0x200 fs/fs_context.c:584
  vfs_get_tree+0x123/0x450 fs/super.c:1481
  do_new_mount fs/namespace.c:2622 [inline]
  do_mount+0x1436/0x2c40 fs/namespace.c:2942
  ksys_mount+0xdb/0x150 fs/namespace.c:3151
  __do_sys_mount fs/namespace.c:3165 [inline]
  __se_sys_mount fs/namespace.c:3162 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3162
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45b69a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 2d 8e fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0a 8e fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f2f99d0ba88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f2f99d0bb40 RCX: 000000000045b69a
RDX: 00007f2f99d0bae0 RSI: 0000000020000140 RDI: 00007f2f99d0bb00
RBP: 0000000000000000 R08: 00007f2f99d0bb40 R09: 00007f2f99d0bae0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000008
R13: 00000000004c7802 R14: 00000000004dd850 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
