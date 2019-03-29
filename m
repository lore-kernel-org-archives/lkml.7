Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236D9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EFA2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfC2KmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:42:06 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:57130 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfC2KmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:42:06 -0400
Received: by mail-it1-f198.google.com with SMTP id s21so1696465ite.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=G1IkAv5Mm09tszkK9Bx/FunD9vRNGa+23Am2MDT6NmM=;
        b=QbmB4z1IRWvNr/2BZcOTP0Lhf8w96zAPLt81KzZC/pBtbb68uVjMh/Je5IufOpFxs/
         I2+2LAGsqdqz6dfpVKtBtc37yfvJHs5m0v0zpF24smApuChShZgyZFPqxqaeSlMeZJk+
         31ETvkPUaZnjTq4tWJCqXpfSOtm+FRqFTTT2KyS/j5BxwgWOfUG0NLTNo2/Pu9o1z3AZ
         8tvuuvE8JnQYjUy61+JXtCIbzQdGnKbxg0+5dlPfUVyv9UFyKtOHop67NKV2RXnTgn/A
         oLumgWUq+r8t+50QpqbvR88zmQmUTpcq18CJdr5FmOt/tavR2DvOLQJpT2vPc2eY26ZW
         KDFw==
X-Gm-Message-State: APjAAAXyTJkIKRbbs+voBtOmYrkyYyaFFF+YrWkd+K0GzkYYCW1qMOZE
        aypCpCi8yvl9kaHmuqVcj+j2wgxU+p09t8ST58gq8atAwafn
X-Google-Smtp-Source: APXvYqwvpyYRq7LLupD1YYQkxbV8eIVsPqIc/KiQ4bqHWwKsdTGYZ1k6FFyyrxAngchyGQ6HeXNc7WVximRaoRfYUZOJTAo54jKa
MIME-Version: 1.0
X-Received: by 2002:a6b:6a11:: with SMTP id x17mr5032461iog.35.1553856125202;
 Fri, 29 Mar 2019 03:42:05 -0700 (PDT)
Date:   Fri, 29 Mar 2019 03:42:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ff8b20585395280@google.com>
Subject: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
From:   syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>
To:     darrick.wong@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1a9df9e2 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14dc2f2b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
dashboard link: https://syzkaller.appspot.com/bug?extid=6f39a9deb697359fe520
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com

XFS (loop4): Invalid superblock magic number
BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.
CPU: 0 PID: 1067 Comm: syz-executor.4 Not tainted 5.1.0-rc2+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  save_trace kernel/locking/lockdep.c:467 [inline]
  save_trace.cold+0x14/0x19 kernel/locking/lockdep.c:437
  check_prev_add.constprop.0+0x8dc/0x23c0 kernel/locking/lockdep.c:2268
  check_prevs_add kernel/locking/lockdep.c:2333 [inline]
  validate_chain kernel/locking/lockdep.c:2714 [inline]
  __lock_acquire+0x239c/0x3fb0 kernel/locking/lockdep.c:3701
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
  flush_workqueue+0x126/0x14c0 kernel/workqueue.c:2774
  drain_workqueue+0x1b4/0x470 kernel/workqueue.c:2939
  destroy_workqueue+0x21/0x700 kernel/workqueue.c:4320
  xfs_destroy_mount_workqueues+0xc5/0x1c0 fs/xfs/xfs_super.c:904
  xfs_fs_fill_super+0x8e9/0x1670 fs/xfs/xfs_super.c:1786
  mount_bdev+0x307/0x3c0 fs/super.c:1346
  xfs_fs_mount+0x35/0x40 fs/xfs/xfs_super.c:1834
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
RIP: 0033:0x45ac7a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 2d 8e fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0a 8e fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f5a0187aa88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f5a0187ab40 RCX: 000000000045ac7a
RDX: 00007f5a0187aae0 RSI: 00000000200006c0 RDI: 00007f5a0187ab00
RBP: 0000000000000000 R08: 00007f5a0187ab40 R09: 00007f5a0187aae0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000003
R13: 00000000004c6bd2 R14: 00000000004dc5b0 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
