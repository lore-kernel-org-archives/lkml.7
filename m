Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACACC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B6B206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qmZ7jENn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbfDQJFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:05:12 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37167 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQJFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:05:12 -0400
Received: by mail-it1-f195.google.com with SMTP id u65so3200127itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpqAEWbkSY7jtV5npEFqgE9rP4l4CAetbH80EuIkdpM=;
        b=qmZ7jENnF+PWDZ1yjTjAPPyfIISseXu2YJoKEZT867UIe2cwJvf6Fq7TxuzcoqL1IB
         Zggj1tYj0yauqYLjdOZbut9KVAo392CPz/CzDIwzT0PEvwd1M5crKazlzTY3GB5bdFZ8
         DtlHP+xWcplqCst2DtD8DXwCv8BrdSRWk1nGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpqAEWbkSY7jtV5npEFqgE9rP4l4CAetbH80EuIkdpM=;
        b=TCYs92eygXqvZC3DWkkbKBMrRMBN1aACuciakoIHFyAWp6Hcpi1heEnh5oW4ScNEt8
         jt1eqkR9uXXPx1yTaieP46xZjaxfVQQW/LIgQJ3nj0i79xb6F6FRmwErn4om/s6z7ac7
         b/EQbfxH555CnADOYxQCpf1K7s3FTXATBdTLqWqEgLXDtuLqjenYA6Sb5YGRWvx5E731
         GtbpOBLs+yVxqBOg55jSa93CQT06jKQ/+JMq2EvyUdiRFGg+RU4YmfXB+KdlkADDhnXa
         uKGuW0LGJRSdj4/kQQxo46E3Jf9XSQegwzyErdD8G8q6pCByncIwGwU2kOmb4e4PSkBJ
         Bh4w==
X-Gm-Message-State: APjAAAW+FgnKZKtA06MsbbNMOvfD3t3ZSkbl+6CY7g0dlUh6WRTyk1eH
        EfTEm+Qqp42tzsmiFDgU+wNmvxWb5ywTO071DN4FlQ==
X-Google-Smtp-Source: APXvYqwqO7gvn/FDZnkIamnJW/WgMXRscC8i2Zq/s4GBBp7jxvSIdz+mxw0Z5v2neYRdVbNEJ+BVNrEol3puw02EVZc=
X-Received: by 2002:a24:650d:: with SMTP id u13mr22184665itb.1.1555491911387;
 Wed, 17 Apr 2019 02:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a0f82805867fb67e@google.com>
In-Reply-To: <000000000000a0f82805867fb67e@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Apr 2019 11:05:00 +0200
Message-ID: <CAJfpegv2HM+Ex30HrP23eA_t-tp-tT9ZE1yij2w7goC_nG=4Ag@mail.gmail.com>
Subject: Re: possible deadlock in seq_read (2)
To:     syzbot <syzbot+5378878b09e052edef7f@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC linux-unionfs@]

On Sun, Apr 14, 2019 at 6:06 PM syzbot
<syzbot+5378878b09e052edef7f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    bcb67f0f Add linux-next specific files for 20190412
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=135b5e9f200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=35c479ecf64ba753
> dashboard link: https://syzkaller.appspot.com/bug?extid=5378878b09e052edef7f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5378878b09e052edef7f@syzkaller.appspotmail.com
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.1.0-rc4-next-20190412 #24 Not tainted
> ------------------------------------------------------
> syz-executor.5/30036 is trying to acquire lock:
> 00000000dfc2e8ba (&p->lock){+.+.}, at: seq_read+0x71/0x1130
> fs/seq_file.c:161
>
> but task is already holding lock:
> 00000000471a7795 (sb_writers#5){.+.+}, at: file_start_write
> include/linux/fs.h:2825 [inline]
> 00000000471a7795 (sb_writers#5){.+.+}, at: do_sendfile+0x9b9/0xd00
> fs/read_write.c:1442
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #3 (sb_writers#5){.+.+}:
>         lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
>         percpu_down_read include/linux/percpu-rwsem.h:36 [inline]
>         __sb_start_write+0x20b/0x360 fs/super.c:1613
>         sb_start_write include/linux/fs.h:1621 [inline]
>         mnt_want_write+0x3f/0xc0 fs/namespace.c:358
>         ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:24
>         ovl_create_object+0xb3/0x2c0 fs/overlayfs/dir.c:599
>         ovl_create+0x28/0x30 fs/overlayfs/dir.c:630
>         lookup_open+0x12e0/0x1b10 fs/namei.c:3232
>         do_last fs/namei.c:3322 [inline]
>         path_openat+0x14ac/0x46e0 fs/namei.c:3533
>         do_filp_open+0x1a1/0x280 fs/namei.c:3563
>         do_sys_open+0x3fe/0x5d0 fs/open.c:1069
>         ksys_open include/linux/syscalls.h:1373 [inline]
>         __do_sys_creat fs/open.c:1127 [inline]
>         __se_sys_creat fs/open.c:1125 [inline]
>         __x64_sys_creat+0x61/0x80 fs/open.c:1125
>         do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> -> #2 (&ovl_i_mutex_dir_key[depth]){++++}:
>         lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
>         down_read+0x3b/0x90 kernel/locking/rwsem.c:24
>         inode_lock_shared include/linux/fs.h:782 [inline]
>         do_last fs/namei.c:3321 [inline]
>         path_openat+0x1e98/0x46e0 fs/namei.c:3533
>         do_filp_open+0x1a1/0x280 fs/namei.c:3563
>         do_open_execat+0x137/0x690 fs/exec.c:856
>         __do_execve_file.isra.0+0x178d/0x23f0 fs/exec.c:1758
>         do_execveat_common fs/exec.c:1865 [inline]
>         do_execve fs/exec.c:1882 [inline]
>         __do_sys_execve fs/exec.c:1958 [inline]
>         __se_sys_execve fs/exec.c:1953 [inline]
>         __x64_sys_execve+0x8f/0xc0 fs/exec.c:1953
>         do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> -> #1 (&sig->cred_guard_mutex){+.+.}:
>         lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
>         __mutex_lock_common kernel/locking/mutex.c:925 [inline]
>         __mutex_lock+0xf7/0x1310 kernel/locking/mutex.c:1072
>         mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1102
>         lock_trace+0x4a/0xe0 fs/proc/base.c:388
>         proc_pid_syscall+0x8a/0x220 fs/proc/base.c:623
>         proc_single_show+0xf6/0x170 fs/proc/base.c:744
>         seq_read+0x4db/0x1130 fs/seq_file.c:229
>         do_loop_readv_writev fs/read_write.c:701 [inline]
>         do_loop_readv_writev fs/read_write.c:688 [inline]
>         do_iter_read+0x4a9/0x660 fs/read_write.c:922
>         vfs_readv+0xf0/0x160 fs/read_write.c:984
>         kernel_readv fs/splice.c:358 [inline]
>         default_file_splice_read+0x475/0x890 fs/splice.c:413
>         do_splice_to+0x12a/0x190 fs/splice.c:876
>         splice_direct_to_actor+0x2d2/0x970 fs/splice.c:953
>         do_splice_direct+0x1da/0x2a0 fs/splice.c:1062
>         do_sendfile+0x597/0xd00 fs/read_write.c:1443
>         __do_sys_sendfile64 fs/read_write.c:1504 [inline]
>         __se_sys_sendfile64 fs/read_write.c:1490 [inline]
>         __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1490
>         do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> -> #0 (&p->lock){+.+.}:
>         check_prevs_add kernel/locking/lockdep.c:2333 [inline]
>         validate_chain kernel/locking/lockdep.c:2714 [inline]
>         __lock_acquire+0x239c/0x3fb0 kernel/locking/lockdep.c:3701
>         lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
>         __mutex_lock_common kernel/locking/mutex.c:925 [inline]
>         __mutex_lock+0xf7/0x1310 kernel/locking/mutex.c:1072
>         mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
>         seq_read+0x71/0x1130 fs/seq_file.c:161
>         proc_reg_read+0x1fe/0x2c0 fs/proc/inode.c:227
>         do_loop_readv_writev fs/read_write.c:701 [inline]
>         do_loop_readv_writev fs/read_write.c:688 [inline]
>         do_iter_read+0x4a9/0x660 fs/read_write.c:922
>         vfs_readv+0xf0/0x160 fs/read_write.c:984
>         kernel_readv fs/splice.c:358 [inline]
>         default_file_splice_read+0x475/0x890 fs/splice.c:413
>         do_splice_to+0x12a/0x190 fs/splice.c:876
>         splice_direct_to_actor+0x2d2/0x970 fs/splice.c:953
>         do_splice_direct+0x1da/0x2a0 fs/splice.c:1062
>         do_sendfile+0x597/0xd00 fs/read_write.c:1443
>         __do_sys_sendfile64 fs/read_write.c:1504 [inline]
>         __se_sys_sendfile64 fs/read_write.c:1490 [inline]
>         __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1490
>         do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> other info that might help us debug this:
>
> Chain exists of:
>    &p->lock --> &ovl_i_mutex_dir_key[depth] --> sb_writers#5
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(sb_writers#5);
>                                 lock(&ovl_i_mutex_dir_key[depth]);
>                                 lock(sb_writers#5);
>    lock(&p->lock);
>
>   *** DEADLOCK ***
>
> 1 lock held by syz-executor.5/30036:
>   #0: 00000000471a7795 (sb_writers#5){.+.+}, at: file_start_write
> include/linux/fs.h:2825 [inline]
>   #0: 00000000471a7795 (sb_writers#5){.+.+}, at: do_sendfile+0x9b9/0xd00
> fs/read_write.c:1442
>
> stack backtrace:
> CPU: 1 PID: 30036 Comm: syz-executor.5 Not tainted 5.1.0-rc4-next-20190412
> #24
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>   print_circular_bug.isra.0.cold+0x1cc/0x28f kernel/locking/lockdep.c:1571
>   check_prev_add.constprop.0+0xf11/0x23c0 kernel/locking/lockdep.c:2220
>   check_prevs_add kernel/locking/lockdep.c:2333 [inline]
>   validate_chain kernel/locking/lockdep.c:2714 [inline]
>   __lock_acquire+0x239c/0x3fb0 kernel/locking/lockdep.c:3701
>   lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
>   __mutex_lock_common kernel/locking/mutex.c:925 [inline]
>   __mutex_lock+0xf7/0x1310 kernel/locking/mutex.c:1072
>   mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
>   seq_read+0x71/0x1130 fs/seq_file.c:161
>   proc_reg_read+0x1fe/0x2c0 fs/proc/inode.c:227
>   do_loop_readv_writev fs/read_write.c:701 [inline]
>   do_loop_readv_writev fs/read_write.c:688 [inline]
>   do_iter_read+0x4a9/0x660 fs/read_write.c:922
>   vfs_readv+0xf0/0x160 fs/read_write.c:984
>   kernel_readv fs/splice.c:358 [inline]
>   default_file_splice_read+0x475/0x890 fs/splice.c:413
>   do_splice_to+0x12a/0x190 fs/splice.c:876
>   splice_direct_to_actor+0x2d2/0x970 fs/splice.c:953
>   do_splice_direct+0x1da/0x2a0 fs/splice.c:1062
>   do_sendfile+0x597/0xd00 fs/read_write.c:1443
>   __do_sys_sendfile64 fs/read_write.c:1504 [inline]
>   __se_sys_sendfile64 fs/read_write.c:1490 [inline]
>   __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1490
>   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x458c29
> Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f0f57706c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000458c29
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000006
> RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000020 R11: 0000000000000246 R12: 00007f0f577076d4
> R13: 00000000004c5e10 R14: 00000000004da5c8 R15: 00000000ffffffff
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
