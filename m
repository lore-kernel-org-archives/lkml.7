Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8506FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5926020657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfG3PIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:08:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50425 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfG3PIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:08:06 -0400
Received: by mail-io1-f71.google.com with SMTP id m26so71773913ioh.17
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iiV4JMEMqBTVZHkxXccUjnbePzc1Lr7GZ4Ely3PF0kQ=;
        b=IY8TkeR9xcIayYqmww2SSCOTEdXP6/mBxvNuHgFk5C8CeTMv5tGf6Itfy5Rnny8kq+
         Z9Pe8DvEKkkc3Beo4O5yEaudYLkh6mSyLzep01U3CpimgndMgS7s3+XYyJtMhaRiHeDu
         V/bHNsBRZ4bWbEEpvPQ7JR8VCHdhXhOXCv2jwaXGDEeMfKFYC2lgk3bQTgWzSgwMWtTm
         WIq9Z7iOZb5bQPcqjSG4Sc1eufVpUp2kjXQ3LnGQmUgGv2zA/A4PEGqvcO0p6/8tUJdl
         WfMGHnFwlxnyFvoOib3Di1CVu81DG9b4GTFG5Ob9jhYZLBvm9uz4GVMobnmRzRGYG8a/
         fDFw==
X-Gm-Message-State: APjAAAVf0aw7tQohS6hHFbVVd1pL+vQQtn4AuvUNRE/WOJfcpyj/3brL
        sQF2B9RdGfwB2YEsXTqz7KM/KNIu0squR0hyOuuNVzLB8H4B
X-Google-Smtp-Source: APXvYqzZSliusSMGXyyV5CnNd1grb1nSEbpKy9m7x1oFZYmS+OcnmGrs2HiJhVZ8bt3NfFntt0EWwAd1AahY9fA1czuZOF7bfsG1
MIME-Version: 1.0
X-Received: by 2002:a6b:b206:: with SMTP id b6mr115926380iof.286.1564499285689;
 Tue, 30 Jul 2019 08:08:05 -0700 (PDT)
Date:   Tue, 30 Jul 2019 08:08:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cd2b1058ee760fe@google.com>
Subject: memory leak in pty_common_install
From:   syzbot <syzbot+bdebcbf44250d75bdd82@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6789f873 Merge tag 'pm-5.3-rc2' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1696897c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=339b6a6b3640d115
dashboard link: https://syzkaller.appspot.com/bug?extid=bdebcbf44250d75bdd82
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153d7544600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bdebcbf44250d75bdd82@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810d84d400 (size 512):
   comm "syz-executor.5", pid 7522, jiffies 4294954305 (age 14.260s)
   hex dump (first 32 bytes):
     50 d4 84 0d 81 88 ff ff e0 ff ff ff 0f 00 00 00  P...............
     10 d4 84 0d 81 88 ff ff 10 d4 84 0d 81 88 ff ff  ................
   backtrace:
     [<000000003d61da44>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000003d61da44>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000003d61da44>] slab_alloc mm/slab.c:3319 [inline]
     [<000000003d61da44>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000a6239e0a>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000a6239e0a>] pty_common_install+0x4e/0x2b0 drivers/tty/pty.c:391
     [<00000000bd8cb19d>] pty_unix98_install+0x20/0x30 drivers/tty/pty.c:740
     [<000000001b46b5e1>] tty_driver_install_tty drivers/tty/tty_io.c:1227  
[inline]
     [<000000001b46b5e1>] tty_init_dev drivers/tty/tty_io.c:1340 [inline]
     [<000000001b46b5e1>] tty_init_dev+0x86/0x210 drivers/tty/tty_io.c:1317
     [<00000000845ae712>] ptmx_open drivers/tty/pty.c:845 [inline]
     [<00000000845ae712>] ptmx_open+0xba/0x1c0 drivers/tty/pty.c:811
     [<000000007e87d771>] chrdev_open+0xe3/0x290 fs/char_dev.c:414
     [<00000000bd556826>] do_dentry_open+0x199/0x4f0 fs/open.c:797
     [<000000001ba9145b>] vfs_open+0x35/0x40 fs/open.c:906
     [<00000000c0275eb4>] do_last fs/namei.c:3416 [inline]
     [<00000000c0275eb4>] path_openat+0x854/0x1cd0 fs/namei.c:3533
     [<00000000156ad8b1>] do_filp_open+0xaa/0x130 fs/namei.c:3563
     [<00000000074d96c0>] do_sys_open+0x253/0x330 fs/open.c:1089
     [<000000009f7fc64a>] __do_sys_openat fs/open.c:1116 [inline]
     [<000000009f7fc64a>] __se_sys_openat fs/open.c:1110 [inline]
     [<000000009f7fc64a>] __x64_sys_openat+0x24/0x30 fs/open.c:1110
     [<000000005ca4479f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000e1f64b0f>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810e639800 (size 1024):
   comm "syz-executor.5", pid 7522, jiffies 4294954305 (age 14.260s)
   hex dump (first 32 bytes):
     01 54 00 00 01 00 00 00 00 00 00 00 00 00 00 00  .T..............
     00 83 fa 19 82 88 ff ff a0 7f 9b 83 ff ff ff ff  ................
   backtrace:
     [<000000003d61da44>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000003d61da44>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000003d61da44>] slab_alloc mm/slab.c:3319 [inline]
     [<000000003d61da44>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<000000001cfffc30>] kmalloc include/linux/slab.h:552 [inline]
     [<000000001cfffc30>] kzalloc include/linux/slab.h:748 [inline]
     [<000000001cfffc30>] alloc_tty_struct+0x3f/0x290  
drivers/tty/tty_io.c:2981
     [<000000001946a70c>] pty_common_install+0xac/0x2b0 drivers/tty/pty.c:399
     [<00000000bd8cb19d>] pty_unix98_install+0x20/0x30 drivers/tty/pty.c:740
     [<000000001b46b5e1>] tty_driver_install_tty drivers/tty/tty_io.c:1227  
[inline]
     [<000000001b46b5e1>] tty_init_dev drivers/tty/tty_io.c:1340 [inline]
     [<000000001b46b5e1>] tty_init_dev+0x86/0x210 drivers/tty/tty_io.c:1317
     [<00000000845ae712>] ptmx_open drivers/tty/pty.c:845 [inline]
     [<00000000845ae712>] ptmx_open+0xba/0x1c0 drivers/tty/pty.c:811
     [<000000007e87d771>] chrdev_open+0xe3/0x290 fs/char_dev.c:414
     [<00000000bd556826>] do_dentry_open+0x199/0x4f0 fs/open.c:797
     [<000000001ba9145b>] vfs_open+0x35/0x40 fs/open.c:906
     [<00000000c0275eb4>] do_last fs/namei.c:3416 [inline]
     [<00000000c0275eb4>] path_openat+0x854/0x1cd0 fs/namei.c:3533
     [<00000000156ad8b1>] do_filp_open+0xaa/0x130 fs/namei.c:3563
     [<00000000074d96c0>] do_sys_open+0x253/0x330 fs/open.c:1089
     [<000000009f7fc64a>] __do_sys_openat fs/open.c:1116 [inline]
     [<000000009f7fc64a>] __se_sys_openat fs/open.c:1110 [inline]
     [<000000009f7fc64a>] __x64_sys_openat+0x24/0x30 fs/open.c:1110
     [<000000005ca4479f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000e1f64b0f>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
