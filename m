Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08556C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A34208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfEUNjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:39:09 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:44651 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfEUNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:39:09 -0400
Received: by mail-it1-f199.google.com with SMTP id o83so2584842itc.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 06:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HIpEwMoRUIhtPEOiJfYRhBBuiY1rMmkmSvNweC5cqNc=;
        b=XVJ5ll0txs/qBufjzroLdf7u/wqoNejmtafmU7amjat58yr9JFdFCvEpq1oQ8SrKdZ
         tA875foazT5LwE42tvHo5t4K7BfGa85Bo22CgPo9J2TQzrFzxfAT/psaSkYmG85GgsTr
         SW7vYevi+cHvdxVuoasA51hg/LPlQb6LPF0M7SHKEksr/5AewYVGFta61YEmPP9B5as0
         A7IkbhNGKkddNYTdeVf647BJqMp+XivxEBWxGp2hXcSVL5mHkn1u5Sxx+r8Uz/T1Pqyo
         nVWrNERdby5nC+gzW+AAuPMdDM+zqKordYsvyD9QZALhhwX3dbaXjvzdfGQV57q17C8u
         VtUQ==
X-Gm-Message-State: APjAAAUJmodNvyq1We5P06mrRSSdCKAOHsLvkse1h7kBRQVSmSCadIe9
        ewrvIOZhH5E3xU93VpXpIvb+THqa0eBYskrXMjovhja5Ncx/
X-Google-Smtp-Source: APXvYqwugDzlSoELxSyOrmccgvIrUMkmFvZPH/4JEypFx8l0ZwEAwrhnWDJeusMA1pSAoJwZ7mlrOYKK9M2tLlL+FcNiN/rbOBVd
MIME-Version: 1.0
X-Received: by 2002:a24:9412:: with SMTP id j18mr3731596ite.124.1558445947553;
 Tue, 21 May 2019 06:39:07 -0700 (PDT)
Date:   Tue, 21 May 2019 06:39:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b266f058965f9a7@google.com>
Subject: memory leak in v9fs_cache_session_get_cookie
From:   syzbot <syzbot+3a030a73b6c1e9833815@syzkaller.appspotmail.com>
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

HEAD commit:    f49aa1de Merge tag 'for-5.2-rc1-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1224e228a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61dd9e15a761691d
dashboard link: https://syzkaller.appspot.com/bug?extid=3a030a73b6c1e9833815
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ffe1f8a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151e66bca00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3a030a73b6c1e9833815@syzkaller.appspotmail.com

  fl=222 nc=0 na=1]
BUG: memory leak
unreferenced object 0xffff88811d5b7ce0 (size 32):
   comm "syz-executor234", pid 7220, jiffies 4294945629 (age 16.870s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 32 39 00 00 00 00 00 00  4294945629......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114735700 (size 32):
   comm "syz-executor234", pid 7227, jiffies 4294945629 (age 16.870s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 32 39 00 00 00 00 00 00  4294945629......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811d5b7860 (size 32):
   comm "syz-executor234", pid 7225, jiffies 4294945634 (age 16.820s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 33 34 00 00 00 00 00 00  4294945634......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811d5b7ce0 (size 32):
   comm "syz-executor234", pid 7220, jiffies 4294945629 (age 17.810s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 32 39 00 00 00 00 00 00  4294945629......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114735700 (size 32):
   comm "syz-executor234", pid 7227, jiffies 4294945629 (age 17.810s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 32 39 00 00 00 00 00 00  4294945629......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811d5b7860 (size 32):
   comm "syz-executor234", pid 7225, jiffies 4294945634 (age 17.760s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 33 34 00 00 00 00 00 00  4294945634......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811d5b7ce0 (size 32):
   comm "syz-executor234", pid 7220, jiffies 4294945629 (age 18.730s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 32 39 00 00 00 00 00 00  4294945629......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114735700 (size 32):
   comm "syz-executor234", pid 7227, jiffies 4294945629 (age 18.730s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 32 39 00 00 00 00 00 00  4294945629......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811d5b7860 (size 32):
   comm "syz-executor234", pid 7225, jiffies 4294945634 (age 18.680s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 33 34 00 00 00 00 00 00  4294945634......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811d5b7ce0 (size 32):
   comm "syz-executor234", pid 7220, jiffies 4294945629 (age 20.550s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 32 39 00 00 00 00 00 00  4294945629......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114735700 (size 32):
   comm "syz-executor234", pid 7227, jiffies 4294945629 (age 20.550s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 32 39 00 00 00 00 00 00  4294945629......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811d5b7860 (size 32):
   comm "syz-executor234", pid 7225, jiffies 4294945634 (age 20.510s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 33 34 00 00 00 00 00 00  4294945634......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811d5b7ce0 (size 32):
   comm "syz-executor234", pid 7220, jiffies 4294945629 (age 21.520s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 32 39 00 00 00 00 00 00  4294945629......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114735700 (size 32):
   comm "syz-executor234", pid 7227, jiffies 4294945629 (age 21.520s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 32 39 00 00 00 00 00 00  4294945629......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811d5b7860 (size 32):
   comm "syz-executor234", pid 7225, jiffies 4294945634 (age 21.470s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 33 34 00 00 00 00 00 00  4294945634......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811d5b7ce0 (size 32):
   comm "syz-executor234", pid 7220, jiffies 4294945629 (age 23.430s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 32 39 00 00 00 00 00 00  4294945629......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114735700 (size 32):
   comm "syz-executor234", pid 7227, jiffies 4294945629 (age 23.430s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 32 39 00 00 00 00 00 00  4294945629......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811d5b7860 (size 32):
   comm "syz-executor234", pid 7225, jiffies 4294945634 (age 23.380s)
   hex dump (first 32 bytes):
     34 32 39 34 39 34 35 36 33 34 00 00 00 00 00 00  4294945634......
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002cabdadb>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002cabdadb>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002cabdadb>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002cabdadb>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000c9696bd2>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000c9696bd2>] v9fs_random_cachetag fs/9p/cache.c:51 [inline]
     [<00000000c9696bd2>] v9fs_cache_session_get_cookie+0xa6/0x100  
fs/9p/cache.c:67
     [<000000009f2e3d4c>] v9fs_session_init+0x5c3/0x880 fs/9p/v9fs.c:485
     [<000000003e76ac4c>] v9fs_mount+0x5e/0x3a0 fs/9p/vfs_super.c:135
     [<00000000de1b2937>] legacy_get_tree+0x27/0x80 fs/fs_context.c:665
     [<000000009d8e25aa>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<0000000012e90ac4>] do_new_mount fs/namespace.c:2790 [inline]
     [<0000000012e90ac4>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<0000000055e18c39>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<000000003fbb869f>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<000000003fbb869f>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<000000003fbb869f>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<000000005a440e8e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000091465610>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

executing program
executing program
executing program
executing program
executing program
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
