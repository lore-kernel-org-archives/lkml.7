Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4D3C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D98321874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfH2V2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:28:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48893 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfH2V2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:28:07 -0400
Received: by mail-io1-f72.google.com with SMTP id z23so1866830ioj.15
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0qah2YrmKlYa9CBvGdatqIu3yhFEo3PR9EVpUHYelBs=;
        b=Cdz1zC4hSAo9shTrDkQZMSfjqutOnlSFgBSi71rerdX4oXk15Pa5+dvTA4ElehLR08
         SiTFK9Qgh5QhtSFG/Mibal67OMdMOVooX9isRxBmXRgJWPcw68I4AwaqpnfC6I3CczsZ
         heMXYjgtxp3naTm8Fj6zu7zv5j94rxY9DKdpZrW+OymmUSXbJjG95SzFHOe99iq5dwgU
         wXZ/fFuP8s4vFlqNNU286HKoZdKmIAVQGwQky2heM0U3X04PVj3+ZKBYnZe6A2mskCgI
         3dBOkgf7OMKCT/Ni15sc8ePfG+8rpZp6EC6WclQmesUA1Bcji/yo7oF9WaZtKOh6CTgs
         tUTw==
X-Gm-Message-State: APjAAAWIZXTaKwr8oihwKQ4couEMIiY3hEymSMETTw//XOtGCFMw2rNo
        2PC/ERDHMQj8eNJiSiLI7DF3+ihJk2McYaorjkFro8PEq8tK
X-Google-Smtp-Source: APXvYqwOqa3J6xvglB4U9KppXygvDxAqmsjBMk05NDRlFwul95VDIIaGSOgC4YaiN5l4x9vNHjLXP81VFimCcTVDaehwenhQCgIA
MIME-Version: 1.0
X-Received: by 2002:a6b:6b01:: with SMTP id g1mr3648274ioc.196.1567114086145;
 Thu, 29 Aug 2019 14:28:06 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:28:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d68b60591482e7b@google.com>
Subject: memory leak in tty_init_dev
From:   syzbot <syzbot+f303e045423e617d2cad@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e67095fd Merge tag 'dma-mapping-5.3-5' of git://git.infrad..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c3d12e600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54b8fd94a3dbefa6
dashboard link: https://syzkaller.appspot.com/bug?extid=f303e045423e617d2cad
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1012efac600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c55b5a600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f303e045423e617d2cad@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff88810c784400 (size 1024):
   comm "syz-executor944", pid 6967, jiffies 4294954446 (age 24.290s)
   hex dump (first 32 bytes):
     01 54 00 00 01 00 00 00 00 00 00 00 00 00 00 00  .T..............
     40 0e f4 19 82 88 ff ff c0 80 9b 83 ff ff ff ff  @...............
   backtrace:
     [<000000007df0b09a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000007df0b09a>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000007df0b09a>] slab_alloc mm/slab.c:3319 [inline]
     [<000000007df0b09a>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<000000005f2271b8>] kmalloc include/linux/slab.h:552 [inline]
     [<000000005f2271b8>] kzalloc include/linux/slab.h:748 [inline]
     [<000000005f2271b8>] alloc_tty_struct+0x3f/0x290  
drivers/tty/tty_io.c:2981
     [<000000003fdbcff2>] tty_init_dev drivers/tty/tty_io.c:1333 [inline]
     [<000000003fdbcff2>] tty_init_dev+0x4b/0x210 drivers/tty/tty_io.c:1317
     [<00000000e9e89905>] ptmx_open drivers/tty/pty.c:845 [inline]
     [<00000000e9e89905>] ptmx_open+0xba/0x1c0 drivers/tty/pty.c:811
     [<00000000fb3f1a7b>] chrdev_open+0xe3/0x290 fs/char_dev.c:414
     [<000000008bb452a9>] do_dentry_open+0x199/0x4f0 fs/open.c:797
     [<00000000040a1756>] vfs_open+0x35/0x40 fs/open.c:906
     [<00000000bc82caf4>] do_last fs/namei.c:3416 [inline]
     [<00000000bc82caf4>] path_openat+0x854/0x1cd0 fs/namei.c:3533
     [<00000000451a136c>] do_filp_open+0xaa/0x130 fs/namei.c:3563
     [<00000000dc54a590>] do_sys_open+0x253/0x330 fs/open.c:1089
     [<00000000b9b63e44>] __do_sys_openat fs/open.c:1116 [inline]
     [<00000000b9b63e44>] __se_sys_openat fs/open.c:1110 [inline]
     [<00000000b9b63e44>] __x64_sys_openat+0x24/0x30 fs/open.c:1110
     [<00000000d5a75d56>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000949e5897>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810b349a00 (size 512):
   comm "syz-executor944", pid 6967, jiffies 4294954446 (age 24.290s)
   hex dump (first 32 bytes):
     50 9a 34 0b 81 88 ff ff e0 ff ff ff 0f 00 00 00  P.4.............
     10 9a 34 0b 81 88 ff ff 10 9a 34 0b 81 88 ff ff  ..4.......4.....
   backtrace:
     [<000000007df0b09a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000007df0b09a>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000007df0b09a>] slab_alloc mm/slab.c:3319 [inline]
     [<000000007df0b09a>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<000000000720d4d4>] kmalloc include/linux/slab.h:552 [inline]
     [<000000000720d4d4>] pty_common_install+0x67/0x2b0 drivers/tty/pty.c:392
     [<000000006f2c2dd7>] pty_unix98_install+0x20/0x30 drivers/tty/pty.c:740
     [<000000005420e709>] tty_driver_install_tty drivers/tty/tty_io.c:1227  
[inline]
     [<000000005420e709>] tty_init_dev drivers/tty/tty_io.c:1340 [inline]
     [<000000005420e709>] tty_init_dev+0x86/0x210 drivers/tty/tty_io.c:1317
     [<00000000e9e89905>] ptmx_open drivers/tty/pty.c:845 [inline]
     [<00000000e9e89905>] ptmx_open+0xba/0x1c0 drivers/tty/pty.c:811
     [<00000000fb3f1a7b>] chrdev_open+0xe3/0x290 fs/char_dev.c:414
     [<000000008bb452a9>] do_dentry_open+0x199/0x4f0 fs/open.c:797
     [<00000000040a1756>] vfs_open+0x35/0x40 fs/open.c:906
     [<00000000bc82caf4>] do_last fs/namei.c:3416 [inline]
     [<00000000bc82caf4>] path_openat+0x854/0x1cd0 fs/namei.c:3533
     [<00000000451a136c>] do_filp_open+0xaa/0x130 fs/namei.c:3563
     [<00000000dc54a590>] do_sys_open+0x253/0x330 fs/open.c:1089
     [<00000000b9b63e44>] __do_sys_openat fs/open.c:1116 [inline]
     [<00000000b9b63e44>] __se_sys_openat fs/open.c:1110 [inline]
     [<00000000b9b63e44>] __x64_sys_openat+0x24/0x30 fs/open.c:1110
     [<00000000d5a75d56>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000949e5897>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810c784400 (size 1024):
   comm "syz-executor944", pid 6967, jiffies 4294954446 (age 26.910s)
   hex dump (first 32 bytes):
     01 54 00 00 01 00 00 00 00 00 00 00 00 00 00 00  .T..............
     40 0e f4 19 82 88 ff ff c0 80 9b 83 ff ff ff ff  @...............
   backtrace:
     [<000000007df0b09a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000007df0b09a>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000007df0b09a>] slab_alloc mm/slab.c:3319 [inline]
     [<000000007df0b09a>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<000000005f2271b8>] kmalloc include/linux/slab.h:552 [inline]
     [<000000005f2271b8>] kzalloc include/linux/slab.h:748 [inline]
     [<000000005f2271b8>] alloc_tty_struct+0x3f/0x290  
drivers/tty/tty_io.c:2981
     [<000000003fdbcff2>] tty_init_dev drivers/tty/tty_io.c:1333 [inline]
     [<000000003fdbcff2>] tty_init_dev+0x4b/0x210 drivers/tty/tty_io.c:1317
     [<00000000e9e89905>] ptmx_open drivers/tty/pty.c:845 [inline]
     [<00000000e9e89905>] ptmx_open+0xba/0x1c0 drivers/tty/pty.c:811
     [<00000000fb3f1a7b>] chrdev_open+0xe3/0x290 fs/char_dev.c:414
     [<000000008bb452a9>] do_dentry_open+0x199/0x4f0 fs/open.c:797
     [<00000000040a1756>] vfs_open+0x35/0x40 fs/open.c:906
     [<00000000bc82caf4>] do_last fs/namei.c:3416 [inline]
     [<00000000bc82caf4>] path_openat+0x854/0x1cd0 fs/namei.c:3533
     [<00000000451a136c>] do_filp_open+0xaa/0x130 fs/namei.c:3563
     [<00000000dc54a590>] do_sys_open+0x253/0x330 fs/open.c:1089
     [<00000000b9b63e44>] __do_sys_openat fs/open.c:1116 [inline]
     [<00000000b9b63e44>] __se_sys_openat fs/open.c:1110 [inline]
     [<00000000b9b63e44>] __x64_sys_openat+0x24/0x30 fs/open.c:1110
     [<00000000d5a75d56>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000949e5897>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810b349a00 (size 512):
   comm "syz-executor944", pid 6967, jiffies 4294954446 (age 26.910s)
   hex dump (first 32 bytes):
     50 9a 34 0b 81 88 ff ff e0 ff ff ff 0f 00 00 00  P.4.............
     10 9a 34 0b 81 88 ff ff 10 9a 34 0b 81 88 ff ff  ..4.......4.....
   backtrace:
     [<000000007df0b09a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000007df0b09a>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000007df0b09a>] slab_alloc mm/slab.c:3319 [inline]
     [<000000007df0b09a>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<000000000720d4d4>] kmalloc include/linux/slab.h:552 [inline]
     [<000000000720d4d4>] pty_common_install+0x67/0x2b0 drivers/tty/pty.c:392
     [<000000006f2c2dd7>] pty_unix98_install+0x20/0x30 drivers/tty/pty.c:740
     [<000000005420e709>] tty_driver_install_tty drivers/tty/tty_io.c:1227  
[inline]
     [<000000005420e709>] tty_init_dev drivers/tty/tty_io.c:1340 [inline]
     [<000000005420e709>] tty_init_dev+0x86/0x210 drivers/tty/tty_io.c:1317
     [<00000000e9e89905>] ptmx_open drivers/tty/pty.c:845 [inline]
     [<00000000e9e89905>] ptmx_open+0xba/0x1c0 drivers/tty/pty.c:811
     [<00000000fb3f1a7b>] chrdev_open+0xe3/0x290 fs/char_dev.c:414
     [<000000008bb452a9>] do_dentry_open+0x199/0x4f0 fs/open.c:797
     [<00000000040a1756>] vfs_open+0x35/0x40 fs/open.c:906
     [<00000000bc82caf4>] do_last fs/namei.c:3416 [inline]
     [<00000000bc82caf4>] path_openat+0x854/0x1cd0 fs/namei.c:3533
     [<00000000451a136c>] do_filp_open+0xaa/0x130 fs/namei.c:3563
     [<00000000dc54a590>] do_sys_open+0x253/0x330 fs/open.c:1089
     [<00000000b9b63e44>] __do_sys_openat fs/open.c:1116 [inline]
     [<00000000b9b63e44>] __se_sys_openat fs/open.c:1110 [inline]
     [<00000000b9b63e44>] __x64_sys_openat+0x24/0x30 fs/open.c:1110
     [<00000000d5a75d56>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000949e5897>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810c784400 (size 1024):
   comm "syz-executor944", pid 6967, jiffies 4294954446 (age 29.510s)
   hex dump (first 32 bytes):
     01 54 00 00 01 00 00 00 00 00 00 00 00 00 00 00  .T..............
     40 0e f4 19 82 88 ff ff c0 80 9b 83 ff ff ff ff  @...............
   backtrace:
     [<000000007df0b09a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000007df0b09a>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000007df0b09a>] slab_alloc mm/slab.c:3319 [inline]
     [<000000007df0b09a>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<000000005f2271b8>] kmalloc include/linux/slab.h:552 [inline]
     [<000000005f2271b8>] kzalloc include/linux/slab.h:748 [inline]
     [<000000005f2271b8>] alloc_tty_struct+0x3f/0x290  
drivers/tty/tty_io.c:2981
     [<000000003fdbcff2>] tty_init_dev drivers/tty/tty_io.c:1333 [inline]
     [<000000003fdbcff2>] tty_init_dev+0x4b/0x210 drivers/tty/tty_io.c:1317
     [<00000000e9e89905>] ptmx_open drivers/tty/pty.c:845 [inline]
     [<00000000e9e89905>] ptmx_open+0xba/0x1c0 drivers/tty/pty.c:811
     [<00000000fb3f1a7b>] chrdev_open+0xe3/0x290 fs/char_dev.c:414
     [<000000008bb452a9>] do_dentry_open+0x199/0x4f0 fs/open.c:797
     [<00000000040a1756>] vfs_open+0x35/0x40 fs/open.c:906
     [<00000000bc82caf4>] do_last fs/namei.c:3416 [inline]
     [<00000000bc82caf4>] path_openat+0x854/0x1cd0 fs/namei.c:3533
     [<00000000451a136c>] do_filp_open+0xaa/0x130 fs/namei.c:3563
     [<00000000dc54a590>] do_sys_open+0x253/0x330 fs/open.c:1089
     [<00000000b9b63e44>] __do_sys_openat fs/open.c:1116 [inline]
     [<00000000b9b63e44>] __se_sys_openat fs/open.c:1110 [inline]
     [<00000000b9b63e44>] __x64_sys_openat+0x24/0x30 fs/open.c:1110
     [<00000000d5a75d56>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000949e5897>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810b349a00 (size 512):
   comm "syz-executor944", pid 6967, jiffies 4294954446 (age 29.510s)
   hex dump (first 32 bytes):
     50 9a 34 0b 81 88 ff ff e0 ff ff ff 0f 00 00 00  P.4.............
     10 9a 34 0b 81 88 ff ff 10 9a 34 0b 81 88 ff ff  ..4.......4.....
   backtrace:
     [<000000007df0b09a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000007df0b09a>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000007df0b09a>] slab_alloc mm/slab.c:3319 [inline]
     [<000000007df0b09a>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<000000000720d4d4>] kmalloc include/linux/slab.h:552 [inline]
     [<000000000720d4d4>] pty_common_install+0x67/0x2b0 drivers/tty/pty.c:392
     [<000000006f2c2dd7>] pty_unix98_install+0x20/0x30 drivers/tty/pty.c:740
     [<000000005420e709>] tty_driver_install_tty drivers/tty/tty_io.c:1227  
[inline]
     [<000000005420e709>] tty_init_dev drivers/tty/tty_io.c:1340 [inline]
     [<000000005420e709>] tty_init_dev+0x86/0x210 drivers/tty/tty_io.c:1317
     [<00000000e9e89905>] ptmx_open drivers/tty/pty.c:845 [inline]
     [<00000000e9e89905>] ptmx_open+0xba/0x1c0 drivers/tty/pty.c:811
     [<00000000fb3f1a7b>] chrdev_open+0xe3/0x290 fs/char_dev.c:414
     [<000000008bb452a9>] do_dentry_open+0x199/0x4f0 fs/open.c:797
     [<00000000040a1756>] vfs_open+0x35/0x40 fs/open.c:906
     [<00000000bc82caf4>] do_last fs/namei.c:3416 [inline]
     [<00000000bc82caf4>] path_openat+0x854/0x1cd0 fs/namei.c:3533
     [<00000000451a136c>] do_filp_open+0xaa/0x130 fs/namei.c:3563
     [<00000000dc54a590>] do_sys_open+0x253/0x330 fs/open.c:1089
     [<00000000b9b63e44>] __do_sys_openat fs/open.c:1116 [inline]
     [<00000000b9b63e44>] __se_sys_openat fs/open.c:1110 [inline]
     [<00000000b9b63e44>] __x64_sys_openat+0x24/0x30 fs/open.c:1110
     [<00000000d5a75d56>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000949e5897>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810c784400 (size 1024):
   comm "syz-executor944", pid 6967, jiffies 4294954446 (age 30.840s)
   hex dump (first 32 bytes):
     01 54 00 00 01 00 00 00 00 00 00 00 00 00 00 00  .T..............
     40 0e f4 19 82 88 ff ff c0 80 9b 83 ff ff ff ff  @...............
   backtrace:
     [<000000007df0b09a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000007df0b09a>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000007df0b09a>] slab_alloc mm/slab.c:3319 [inline]
     [<000000007df0b09a>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<000000005f2271b8>] kmalloc include/linux/slab.h:552 [inline]
     [<000000005f2271b8>] kzalloc include/linux/slab.h:748 [inline]
     [<000000005f2271b8>] alloc_tty_struct+0x3f/0x290  
drivers/tty/tty_io.c:2981
     [<000000003fdbcff2>] tty_init_dev drivers/tty/tty_io.c:1333 [inline]
     [<000000003fdbcff2>] tty_init_dev+0x4b/0x210 drivers/tty/tty_io.c:1317
     [<00000000e9e89905>] ptmx_open drivers/tty/pty.c:845 [inline]
     [<00000000e9e89905>] ptmx_open+0xba/0x1c0 drivers/tty/pty.c:811
     [<00000000fb3f1a7b>] chrdev_open+0xe3/0x290 fs/char_dev.c:414
     [<000000008bb452a9>] do_dentry_open+0x199/0x4f0 fs/open.c:797
     [<00000000040a1756>] vfs_open+0x35/0x40 fs/open.c:906
     [<00000000bc82caf4>] do_last fs/namei.c:3416 [inline]
     [<00000000bc82caf4>] path_openat+0x854/0x1cd0 fs/namei.c:3533
     [<00000000451a136c>] do_filp_open+0xaa/0x130 fs/namei.c:3563
     [<00000000dc54a590>] do_sys_open+0x253/0x330 fs/open.c:1089
     [<00000000b9b63e44>] __do_sys_openat fs/open.c:1116 [inline]
     [<00000000b9b63e44>] __se_sys_openat fs/open.c:1110 [inline]
     [<00000000b9b63e44>] __x64_sys_openat+0x24/0x30 fs/open.c:1110
     [<00000000d5a75d56>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000949e5897>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810b349a00 (size 512):
   comm "syz-executor944", pid 6967, jiffies 4294954446 (age 30.840s)
   hex dump (first 32 bytes):
     50 9a 34 0b 81 88 ff ff e0 ff ff ff 0f 00 00 00  P.4.............
     10 9a 34 0b 81 88 ff ff 10 9a 34 0b 81 88 ff ff  ..4.......4.....
   backtrace:
     [<000000007df0b09a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000007df0b09a>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000007df0b09a>] slab_alloc mm/slab.c:3319 [inline]
     [<000000007df0b09a>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<000000000720d4d4>] kmalloc include/linux/slab.h:552 [inline]
     [<000000000720d4d4>] pty_common_install+0x67/0x2b0 drivers/tty/pty.c:392
     [<000000006f2c2dd7>] pty_unix98_install+0x20/0x30 drivers/tty/pty.c:740
     [<000000005420e709>] tty_driver_install_tty drivers/tty/tty_io.c:1227  
[inline]
     [<000000005420e709>] tty_init_dev drivers/tty/tty_io.c:1340 [inline]
     [<000000005420e709>] tty_init_dev+0x86/0x210 drivers/tty/tty_io.c:1317
     [<00000000e9e89905>] ptmx_open drivers/tty/pty.c:845 [inline]
     [<00000000e9e89905>] ptmx_open+0xba/0x1c0 drivers/tty/pty.c:811
     [<00000000fb3f1a7b>] chrdev_open+0xe3/0x290 fs/char_dev.c:414
     [<000000008bb452a9>] do_dentry_open+0x199/0x4f0 fs/open.c:797
     [<00000000040a1756>] vfs_open+0x35/0x40 fs/open.c:906
     [<00000000bc82caf4>] do_last fs/namei.c:3416 [inline]
     [<00000000bc82caf4>] path_openat+0x854/0x1cd0 fs/namei.c:3533
     [<00000000451a136c>] do_filp_open+0xaa/0x130 fs/namei.c:3563
     [<00000000dc54a590>] do_sys_open+0x253/0x330 fs/open.c:1089
     [<00000000b9b63e44>] __do_sys_openat fs/open.c:1116 [inline]
     [<00000000b9b63e44>] __se_sys_openat fs/open.c:1110 [inline]
     [<00000000b9b63e44>] __x64_sys_openat+0x24/0x30 fs/open.c:1110
     [<00000000d5a75d56>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000949e5897>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

executing program
executing program


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
