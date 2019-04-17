Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522E0C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2372820835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbfDQQqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:46:05 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:44234 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:46:05 -0400
Received: by mail-it1-f197.google.com with SMTP id v193so3009366itv.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7co44nLOWjQeJ/TtpZT/ZBlkOxE7xwFSYDM8ynWRqQQ=;
        b=lWpwnEX5sAs1Iqo3rb+URM8FwqE8WAhOkr4HYUh8Xj6RP2mAyF8PLFbDgUCMJx7iG9
         UbINDUQJqu2W1Wi3cd/js90ZrQswQ4S2ricVY1OAimz1KKwj2rP7tGyayckAXWg+crpG
         DNMp9/QBfFQYFmkfszVp8xif1r1f0nbXswbtVzp1EmXE5WkCDvP9NGc6lwHbWxmYtJj2
         y69jKH2N8Ng1rWVVHLR1dSZXyRzQy1MxYhfBBPgXXZ/Ki4kSVtT8hbDf2PqiodlSMLnk
         HW1iDe+zlKxErvWT84sZ08W+VDlm4+4b5ArNeqRbxhGv3wBt8Uaa/G34dmOKLDEaxIET
         WMMw==
X-Gm-Message-State: APjAAAU9EvVswiohe4ryAM3Bo61QwJ60vwQVvrDzZZgEq1PpKisPUgqX
        fW0UDN48Fmsi6nRoFf1HwgguudgydKTtXtRsDA+6f8p64xdE
X-Google-Smtp-Source: APXvYqwYxdEYuTU8dSIKcYFUiLg/LznLl3v5YwVwEjWGBSd+/hgwXeKJ+XLMRdixd1wHgy6Ji+Z/5XEKhcsEH87tMTZmndvyBPgx
MIME-Version: 1.0
X-Received: by 2002:a02:7f90:: with SMTP id r138mr38201303jac.94.1555519564487;
 Wed, 17 Apr 2019 09:46:04 -0700 (PDT)
Date:   Wed, 17 Apr 2019 09:46:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000152b680586bc9f8b@google.com>
Subject: possible deadlock in lock_trace (2)
From:   syzbot <syzbot+4b7e4be91bb87d4158e5@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        casey@schaufler-ca.com, keescook@chromium.org,
        kent.overstreet@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    444fe991 Merge tag 'riscv-for-linus-5.1-rc6' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b8f5d3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=4b7e4be91bb87d4158e5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4b7e4be91bb87d4158e5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.1.0-rc5+ #71 Not tainted
------------------------------------------------------
syz-executor.5/9344 is trying to acquire lock:
000000002573c5cd (&sig->cred_guard_mutex){+.+.}, at: lock_trace+0x4a/0xe0  
fs/proc/base.c:388

but task is already holding lock:
00000000e68fae9b (&p->lock){+.+.}, at: seq_read+0x71/0x1130  
fs/seq_file.c:161

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->lock){+.+.}:
        lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0xf7/0x1310 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        seq_read+0x71/0x1130 fs/seq_file.c:161
        do_loop_readv_writev fs/read_write.c:701 [inline]
        do_loop_readv_writev fs/read_write.c:688 [inline]
        do_iter_read+0x4a9/0x660 fs/read_write.c:922
        vfs_readv+0xf0/0x160 fs/read_write.c:984
        kernel_readv fs/splice.c:358 [inline]
        default_file_splice_read+0x475/0x890 fs/splice.c:413
        do_splice_to+0x12a/0x190 fs/splice.c:876
        splice_direct_to_actor+0x2d2/0x970 fs/splice.c:953
        do_splice_direct+0x1da/0x2a0 fs/splice.c:1062
        do_sendfile+0x597/0xd00 fs/read_write.c:1443
        __do_sys_sendfile64 fs/read_write.c:1504 [inline]
        __se_sys_sendfile64 fs/read_write.c:1490 [inline]
        __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1490
        do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (sb_writers#4){.+.+}:
        lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
        percpu_down_read include/linux/percpu-rwsem.h:36 [inline]
        __sb_start_write+0x20b/0x360 fs/super.c:1613
        sb_start_write include/linux/fs.h:1621 [inline]
        mnt_want_write+0x3f/0xc0 fs/namespace.c:358
        ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:24
        ovl_rename+0x22b/0x1940 fs/overlayfs/dir.c:1079
        vfs_rename+0x803/0x1ac0 fs/namei.c:4475
        do_renameat2+0xb0f/0xc40 fs/namei.c:4625
        __do_sys_rename fs/namei.c:4671 [inline]
        __se_sys_rename fs/namei.c:4669 [inline]
        __x64_sys_rename+0x61/0x80 fs/namei.c:4669
        do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_dir_key[depth]){++++}:
        lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
        down_read+0x3b/0x90 kernel/locking/rwsem.c:24
        inode_lock_shared include/linux/fs.h:782 [inline]
        do_last fs/namei.c:3321 [inline]
        path_openat+0x1e98/0x46e0 fs/namei.c:3533
        do_filp_open+0x1a1/0x280 fs/namei.c:3563
        do_open_execat+0x137/0x690 fs/exec.c:856
        __do_execve_file.isra.0+0x178d/0x23f0 fs/exec.c:1758
        do_execveat_common fs/exec.c:1865 [inline]
        do_execve fs/exec.c:1882 [inline]
        __do_sys_execve fs/exec.c:1958 [inline]
        __se_sys_execve fs/exec.c:1953 [inline]
        __x64_sys_execve+0x8f/0xc0 fs/exec.c:1953
        do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sig->cred_guard_mutex){+.+.}:
        check_prevs_add kernel/locking/lockdep.c:2333 [inline]
        validate_chain kernel/locking/lockdep.c:2714 [inline]
        __lock_acquire+0x239c/0x3fb0 kernel/locking/lockdep.c:3701
        lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0xf7/0x1310 kernel/locking/mutex.c:1072
        mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1102
        lock_trace+0x4a/0xe0 fs/proc/base.c:388
        proc_pid_syscall+0x8a/0x220 fs/proc/base.c:623
        proc_single_show+0xf6/0x170 fs/proc/base.c:744
        seq_read+0x4db/0x1130 fs/seq_file.c:229
        do_loop_readv_writev fs/read_write.c:701 [inline]
        do_loop_readv_writev fs/read_write.c:688 [inline]
        do_iter_read+0x4a9/0x660 fs/read_write.c:922
        vfs_readv+0xf0/0x160 fs/read_write.c:984
        kernel_readv fs/splice.c:358 [inline]
        default_file_splice_read+0x475/0x890 fs/splice.c:413
        do_splice_to+0x12a/0x190 fs/splice.c:876
        splice_direct_to_actor+0x2d2/0x970 fs/splice.c:953
        do_splice_direct+0x1da/0x2a0 fs/splice.c:1062
        do_sendfile+0x597/0xd00 fs/read_write.c:1443
        __do_sys_sendfile64 fs/read_write.c:1504 [inline]
        __se_sys_sendfile64 fs/read_write.c:1490 [inline]
        __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1490
        do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &sig->cred_guard_mutex --> sb_writers#4 --> &p->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&p->lock);
                                lock(sb_writers#4);
                                lock(&p->lock);
   lock(&sig->cred_guard_mutex);

  *** DEADLOCK ***

2 locks held by syz-executor.5/9344:
  #0: 000000003ef5ac57 (sb_writers#7){.+.+}, at: file_start_write  
include/linux/fs.h:2825 [inline]
  #0: 000000003ef5ac57 (sb_writers#7){.+.+}, at: do_sendfile+0x9b9/0xd00  
fs/read_write.c:1442
  #1: 00000000e68fae9b (&p->lock){+.+.}, at: seq_read+0x71/0x1130  
fs/seq_file.c:161

stack backtrace:
CPU: 0 PID: 9344 Comm: syz-executor.5 Not tainted 5.1.0-rc5+ #71
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_circular_bug.isra.0.cold+0x1cc/0x28f kernel/locking/lockdep.c:1571
  check_prev_add.constprop.0+0xf11/0x23c0 kernel/locking/lockdep.c:2220
  check_prevs_add kernel/locking/lockdep.c:2333 [inline]
  validate_chain kernel/locking/lockdep.c:2714 [inline]
  __lock_acquire+0x239c/0x3fb0 kernel/locking/lockdep.c:3701
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0xf7/0x1310 kernel/locking/mutex.c:1072
  mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1102
  lock_trace+0x4a/0xe0 fs/proc/base.c:388
  proc_pid_syscall+0x8a/0x220 fs/proc/base.c:623
  proc_single_show+0xf6/0x170 fs/proc/base.c:744
  seq_read+0x4db/0x1130 fs/seq_file.c:229
  do_loop_readv_writev fs/read_write.c:701 [inline]
  do_loop_readv_writev fs/read_write.c:688 [inline]
  do_iter_read+0x4a9/0x660 fs/read_write.c:922
  vfs_readv+0xf0/0x160 fs/read_write.c:984
  kernel_readv fs/splice.c:358 [inline]
  default_file_splice_read+0x475/0x890 fs/splice.c:413
  do_splice_to+0x12a/0x190 fs/splice.c:876
  splice_direct_to_actor+0x2d2/0x970 fs/splice.c:953
  do_splice_direct+0x1da/0x2a0 fs/splice.c:1062
  do_sendfile+0x597/0xd00 fs/read_write.c:1443
  __do_sys_sendfile64 fs/read_write.c:1504 [inline]
  __se_sys_sendfile64 fs/read_write.c:1490 [inline]
  __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1490
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9b470bec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000458c29
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f9b470bf6d4
R13: 00000000004c5e10 R14: 00000000004da5c8 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
