Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33101C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051DB2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfGXJsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:48:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:35479 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfGXJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:48:06 -0400
Received: by mail-io1-f70.google.com with SMTP id w17so50446974iom.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 02:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=o0dG1ubL2ZUcRk/zh9N4n0goHb/laQk2v/DI7BLceg0=;
        b=EZcI+SCSovO5oxIunwoYk9l68PGrSSIHrhIca3dHE6mSTlZnZUXbcHa3kOjW7E5Tm9
         oBnkGJptgEaLmjCzomZDFzfXVhgW2FYVnaGbRQgoHIfqDBbv+npZ8KbVo91YXpOiob99
         I1sy01uEpiZQGFUpb7vxDik13eydmB5yW0Vm7cJ1OH8XCNw0lbF7pJ3x5JpUGi/gWeM3
         nCcSdgnpLeSaiQZX2B1s9O/onqp0YUxKZ+ACLMnR/lSWIOXeBFHEhBqT3jBilNDBUnut
         tAFW0T+FxZRUyleAK9NM+VrczND82ScxxpmaOgG+R07TTBWhEJFCcdTZ/zXM7hobTBlN
         tY1Q==
X-Gm-Message-State: APjAAAXakEJOd9um5bZa9Afn6e7H4Vzg2qxByOdFfT0gPhr+1FfxBBGA
        ufXPUHcWKobqCkxGV+eYJY3V2uKGit0jcM1oIL8QWVkQ4wrO
X-Google-Smtp-Source: APXvYqxzhDxmXCu2dUR/YZFrg+W8K0nZkLszX2g0brJAb8wwwbzHzWKXDmOmpWpl64suFARwVsgaIAEKqSln52bm/erqyb6CJKPo
MIME-Version: 1.0
X-Received: by 2002:a5d:8447:: with SMTP id w7mr79198813ior.197.1563961685607;
 Wed, 24 Jul 2019 02:48:05 -0700 (PDT)
Date:   Wed, 24 Jul 2019 02:48:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b68e04058e6a3421@google.com>
Subject: memory leak in dma_buf_ioctl
From:   syzbot <syzbot+b2098bc44728a4efb3e9@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    abdfd52a Merge tag 'armsoc-defconfig' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131441d0600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d31de3d88059b7fa
dashboard link: https://syzkaller.appspot.com/bug?extid=b2098bc44728a4efb3e9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12526e58600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161784f0600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b2098bc44728a4efb3e9@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888114034680 (size 32):
   comm "syz-executor110", pid 6894, jiffies 4294947136 (age 13.580s)
   hex dump (first 32 bytes):
     00 64 6d 61 62 75 66 3a 00 00 00 00 00 00 00 00  .dmabuf:........
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000d259834b>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000d259834b>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000d259834b>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000d259834b>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000d259834b>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<00000000ab207ec1>] memdup_user+0x26/0xa0 /mm/util.c:165
     [<00000000c0909d36>] strndup_user+0x62/0x80 /mm/util.c:224
     [<00000000a34a2d25>] dma_buf_set_name /drivers/dma-buf/dma-buf.c:331  
[inline]
     [<00000000a34a2d25>] dma_buf_ioctl+0x60/0x1b0  
/drivers/dma-buf/dma-buf.c:391
     [<00000000d7817662>] vfs_ioctl /fs/ioctl.c:46 [inline]
     [<00000000d7817662>] file_ioctl /fs/ioctl.c:509 [inline]
     [<00000000d7817662>] do_vfs_ioctl+0x62a/0x810 /fs/ioctl.c:696
     [<00000000d24a671a>] ksys_ioctl+0x86/0xb0 /fs/ioctl.c:713
     [<00000000bd810f5d>] __do_sys_ioctl /fs/ioctl.c:720 [inline]
     [<00000000bd810f5d>] __se_sys_ioctl /fs/ioctl.c:718 [inline]
     [<00000000bd810f5d>] __x64_sys_ioctl+0x1e/0x30 /fs/ioctl.c:718
     [<000000005a8e86d5>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000007d83529f>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888113b044a0 (size 32):
   comm "syz-executor110", pid 6895, jiffies 4294947728 (age 7.660s)
   hex dump (first 32 bytes):
     00 64 6d 61 62 75 66 3a 00 00 00 00 00 00 00 00  .dmabuf:........
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000d259834b>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000d259834b>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000d259834b>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000d259834b>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000d259834b>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<00000000ab207ec1>] memdup_user+0x26/0xa0 /mm/util.c:165
     [<00000000c0909d36>] strndup_user+0x62/0x80 /mm/util.c:224
     [<00000000a34a2d25>] dma_buf_set_name /drivers/dma-buf/dma-buf.c:331  
[inline]
     [<00000000a34a2d25>] dma_buf_ioctl+0x60/0x1b0  
/drivers/dma-buf/dma-buf.c:391
     [<00000000d7817662>] vfs_ioctl /fs/ioctl.c:46 [inline]
     [<00000000d7817662>] file_ioctl /fs/ioctl.c:509 [inline]
     [<00000000d7817662>] do_vfs_ioctl+0x62a/0x810 /fs/ioctl.c:696
     [<00000000d24a671a>] ksys_ioctl+0x86/0xb0 /fs/ioctl.c:713
     [<00000000bd810f5d>] __do_sys_ioctl /fs/ioctl.c:720 [inline]
     [<00000000bd810f5d>] __se_sys_ioctl /fs/ioctl.c:718 [inline]
     [<00000000bd810f5d>] __x64_sys_ioctl+0x1e/0x30 /fs/ioctl.c:718
     [<000000005a8e86d5>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000007d83529f>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
