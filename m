Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC55ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915D820854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394587AbfJPTwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:52:09 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42598 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfJPTwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 15:52:09 -0400
Received: by mail-io1-f71.google.com with SMTP id w1so39596065ioj.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 12:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=f4oQKRVyB5V9r7vvnjpTlqVdZAeIBiIp24JG7gzMIZ8=;
        b=ER9Dl/9xhWEJTBLM0jGSIlGSulZqlEig6AaV7WZLJdAKbWHeFEp7dg1DHWQzj6GFaj
         Wl3v0gHVtntZhEqXXO1XIuDO9VIcjXRRPUqq1PhfgUtEMdRcm5YYa7nK1focUd2DTCeN
         NT8jmBBpv9XTo9MO/6JasBTYcaW2ygSODYumnUCjV3MTioYenfP+AVllh2pBYwHdOrdx
         3oGxMP3ccXk4N8Ki23omy31TugYocj2lFHg9rWs4R1IyPgEMjf1ZD3IrmU53CQJCV65C
         1276h9bmHNV6jrfhhY4ouRemUi1FAGietVeTYlvB5NQOSmaUVdmXBTIEtBhhjM0Ci/s/
         nOAg==
X-Gm-Message-State: APjAAAVk5M3tqsiJyiSBS88WpPSK/nCjg6nvaTDoLcoJwE2KX1WCH7+8
        ozSnOM5vvNML4PH05t99agg9aH2BYVmOK1Yt9mvGPkjqhyxH
X-Google-Smtp-Source: APXvYqw5ECSMsW/AC1VYOzYcfrUWhTBf1KYLus65zc2Ju9Tnazcc0hL19yoT4BJhXXN4DDwaZioUopsbD6a3eB8vUYEa6wSqRNQS
MIME-Version: 1.0
X-Received: by 2002:a02:a199:: with SMTP id n25mr43419354jah.92.1571255527153;
 Wed, 16 Oct 2019 12:52:07 -0700 (PDT)
Date:   Wed, 16 Oct 2019 12:52:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c395405950c6f7c@google.com>
Subject: memory leak in v9fs_cache_session_get_cookie (2)
From:   syzbot <syzbot+f577fd1dae1f5b0fd8c7@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3b1f00ac Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a95fe7600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd7f8e43c7bdf83a
dashboard link: https://syzkaller.appspot.com/bug?extid=f577fd1dae1f5b0fd8c7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13602173600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1700584b600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f577fd1dae1f5b0fd8c7@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888122c0b620 (size 32):
   comm "syz-executor002", pid 7059, jiffies 4294945363 (age 18.760s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 00 00 00 00 00  4294945363......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811819ce80 (size 32):
   comm "syz-executor002", pid 7062, jiffies 4294945363 (age 18.760s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 00 00 00 00 00  4294945363......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811819c2c0 (size 32):
   comm "syz-executor002", pid 7067, jiffies 4294945363 (age 18.760s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 73 74 65 6d 5f  4294945363.stem_
     72 3a 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r:kernel_t:s0...
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888117fc1c80 (size 32):
   comm "syz-executor002", pid 7080, jiffies 4294945384 (age 18.550s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 38 34 00 00 00 00 00 00  4294945384......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888122c0b620 (size 32):
   comm "syz-executor002", pid 7059, jiffies 4294945363 (age 19.840s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 00 00 00 00 00  4294945363......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811819ce80 (size 32):
   comm "syz-executor002", pid 7062, jiffies 4294945363 (age 19.840s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 00 00 00 00 00  4294945363......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811819c2c0 (size 32):
   comm "syz-executor002", pid 7067, jiffies 4294945363 (age 19.840s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 73 74 65 6d 5f  4294945363.stem_
     72 3a 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r:kernel_t:s0...
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888117fc1c80 (size 32):
   comm "syz-executor002", pid 7080, jiffies 4294945384 (age 19.630s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 38 34 00 00 00 00 00 00  4294945384......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888122c0b620 (size 32):
   comm "syz-executor002", pid 7059, jiffies 4294945363 (age 20.910s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 00 00 00 00 00  4294945363......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811819ce80 (size 32):
   comm "syz-executor002", pid 7062, jiffies 4294945363 (age 20.910s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 00 00 00 00 00  4294945363......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811819c2c0 (size 32):
   comm "syz-executor002", pid 7067, jiffies 4294945363 (age 20.910s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 73 74 65 6d 5f  4294945363.stem_
     72 3a 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r:kernel_t:s0...
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888117fc1c80 (size 32):
   comm "syz-executor002", pid 7080, jiffies 4294945384 (age 20.700s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 38 34 00 00 00 00 00 00  4294945384......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888122c0b620 (size 32):
   comm "syz-executor002", pid 7059, jiffies 4294945363 (age 22.950s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 00 00 00 00 00  4294945363......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811819ce80 (size 32):
   comm "syz-executor002", pid 7062, jiffies 4294945363 (age 22.950s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 00 00 00 00 00  4294945363......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811819c2c0 (size 32):
   comm "syz-executor002", pid 7067, jiffies 4294945363 (age 22.950s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 73 74 65 6d 5f  4294945363.stem_
     72 3a 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r:kernel_t:s0...
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888117fc1c80 (size 32):
   comm "syz-executor002", pid 7080, jiffies 4294945384 (age 22.740s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 38 34 00 00 00 00 00 00  4294945384......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888122c0b620 (size 32):
   comm "syz-executor002", pid 7059, jiffies 4294945363 (age 25.030s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 00 00 00 00 00  4294945363......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811819ce80 (size 32):
   comm "syz-executor002", pid 7062, jiffies 4294945363 (age 25.030s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 00 00 00 00 00  4294945363......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811819c2c0 (size 32):
   comm "syz-executor002", pid 7067, jiffies 4294945363 (age 25.030s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 73 74 65 6d 5f  4294945363.stem_
     72 3a 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r:kernel_t:s0...
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888117fc1c80 (size 32):
   comm "syz-executor002", pid 7080, jiffies 4294945384 (age 24.820s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 38 34 00 00 00 00 00 00  4294945384......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888122c0b620 (size 32):
   comm "syz-executor002", pid 7059, jiffies 4294945363 (age 26.110s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 00 00 00 00 00  4294945363......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811819ce80 (size 32):
   comm "syz-executor002", pid 7062, jiffies 4294945363 (age 26.110s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 00 00 00 00 00  4294945363......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811819c2c0 (size 32):
   comm "syz-executor002", pid 7067, jiffies 4294945363 (age 26.110s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 36 33 00 73 74 65 6d 5f  4294945363.stem_
     72 3a 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r:kernel_t:s0...
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888117fc1c80 (size 32):
   comm "syz-executor002", pid 7080, jiffies 4294945384 (age 25.900s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 33 38 34 00 00 00 00 00 00  4294945384......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000914ad539>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000914ad539>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000914ad539>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000914ad539>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000d7aea07a>] kmalloc include/linux/slab.h:556 [inline]
     [<00000000d7aea07a>] v9fs_random_cachetag fs/9p/cache.c:36 [inline]
     [<00000000d7aea07a>] v9fs_cache_session_get_cookie+0xa6/0x110  
fs/9p/cache.c:52
     [<00000000fdcf7df2>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:470
     [<000000001a42c839>] v9fs_mount+0x5e/0x3c0 fs/9p/vfs_super.c:124
     [<00000000a90ee9c2>] legacy_get_tree+0x27/0x80 fs/fs_context.c:647
     [<000000009bc32b08>] vfs_get_tree+0x2d/0xe0 fs/super.c:1545
     [<000000005bc96ae8>] do_new_mount fs/namespace.c:2823 [inline]
     [<000000005bc96ae8>] do_mount+0x95f/0xc60 fs/namespace.c:3143
     [<000000002301e20b>] ksys_mount+0xab/0x120 fs/namespace.c:3352
     [<000000001a409208>] __do_sys_mount fs/namespace.c:3366 [inline]
     [<000000001a409208>] __se_sys_mount fs/namespace.c:3363 [inline]
     [<000000001a409208>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3363
     [<0000000033193570>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000b1f42f27>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

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
