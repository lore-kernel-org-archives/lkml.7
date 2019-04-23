Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D942C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553EE208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfDWQ0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:26:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45255 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfDWQ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:26:06 -0400
Received: by mail-io1-f69.google.com with SMTP id j25so7381654ioj.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nxET34CTJGSqBUhNonjtkCyeIOlmF8kca1pTA634dck=;
        b=iosd6YgDdZNrxbWiUTHhxJbuKe+3ciNfLwCKzEy/XK9PfhwjtDRDvcwW7BsSOEyQuw
         SPnJa8jFEhPU+KAurpmNUEEAsUZ1DSj4N49c3ecfk1CLBoLNQPkjvsuHoUGx6o7Scp/G
         0EpuIenV21DKeGN+M6+tbf123yQaiCkv1pd9j5AN4uxQWlajs6pYK7NGBz9Zj5tyh0a/
         EOje8fk/AtazrPPOgkV8J88UHd27olmpjpJXGBk36i7GGnF+8g0IMTdyBzuaFCZClFar
         Jw/LaidDwryyZ599kB/qaEFvURbuSqdQjAdgYQ6A+/TDuiexKQShKBEKfo3nYJSe1rQ3
         +OtQ==
X-Gm-Message-State: APjAAAUkVX6llYi9XWB43JrlaSewNcw/xqOxSlJ1DmE7HAuOQ1qzASar
        iYWfAKeWvVotWkFiWCmoggWdQt5xLnhwxZy3ABtBp+1lilZc
X-Google-Smtp-Source: APXvYqyKxiODX5ftHuh2JCLZF/kKvikCrR5XVJD3JrwaT9Ghy7fEs0G+TQG6FAy1jEZR/ZnUE2fD/rn8ESAoZ5h90USRkGdYQRxD
MIME-Version: 1.0
X-Received: by 2002:a02:2a8a:: with SMTP id w132mr6399978jaw.101.1556036766008;
 Tue, 23 Apr 2019 09:26:06 -0700 (PDT)
Date:   Tue, 23 Apr 2019 09:26:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b20dd60587350ae0@google.com>
Subject: general protection fault in debugfs_remove
From:   syzbot <syzbot+c091783d82e47615bb28@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    dc4060a5 Linux 5.1-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146c7ab7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=c091783d82e47615bb28
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c091783d82e47615bb28@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 17253 Comm: syz-executor.2 Not tainted 5.1.0-rc5 #68
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_acquire+0xbef/0x3fb0 kernel/locking/lockdep.c:3573
Code: 00 0f 85 a5 1f 00 00 48 81 c4 10 01 00 00 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f  
85 4a 21 00 00 49 81 7d 00 20 54 9c 89 0f 84 cf f4
RSP: 0018:ffff88805c8c7af0 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000027 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff88805c8c7c28 R08: 0000000000000001 R09: 0000000000000000
R10: ffffed100bd89a87 R11: ffff8880a447e640 R12: 0000000000000000
R13: 0000000000000138 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae900000(0063) knlGS:00000000f5d5bb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007fa5913df4a0 CR3: 0000000098cec000 CR4: 00000000001426e0
Call Trace:
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
  down_write+0x38/0x90 kernel/locking/rwsem.c:70
  inode_lock include/linux/fs.h:772 [inline]
  debugfs_remove+0x94/0x130 fs/debugfs/inode.c:691
  blk_trace_free+0x38/0x140 kernel/trace/blktrace.c:312
  blk_trace_cleanup kernel/trace/blktrace.c:339 [inline]
  __blk_trace_remove+0x78/0xa0 kernel/trace/blktrace.c:352
  blk_trace_ioctl+0x239/0x300 kernel/trace/blktrace.c:731
  compat_blkdev_ioctl+0x461/0x1a60 block/compat_ioctl.c:402
  __do_compat_sys_ioctl fs/compat_ioctl.c:1052 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:998 [inline]
  __ia32_compat_sys_ioctl+0x197/0x620 fs/compat_ioctl.c:998
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x281/0xc98 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f5f869
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5d5b0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000001276
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 91aa7acaf1536f2c ]---
RIP: 0010:__lock_acquire+0xbef/0x3fb0 kernel/locking/lockdep.c:3573
Code: 00 0f 85 a5 1f 00 00 48 81 c4 10 01 00 00 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f  
85 4a 21 00 00 49 81 7d 00 20 54 9c 89 0f 84 cf f4
RSP: 0018:ffff88805c8c7af0 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000027 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff88805c8c7c28 R08: 0000000000000001 R09: 0000000000000000
R10: ffffed100bd89a87 R11: ffff8880a447e640 R12: 0000000000000000
R13: 0000000000000138 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae900000(0063) knlGS:00000000f5d5bb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007fa5913df4a0 CR3: 0000000098cec000 CR4: 00000000001426e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
