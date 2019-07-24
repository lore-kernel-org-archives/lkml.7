Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D32C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8231E21850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfGXMII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:08:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:33435 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGXMII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:08:08 -0400
Received: by mail-io1-f70.google.com with SMTP id 132so50794653iou.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 05:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GeBbYoEl2XRk1WWMfBsDtFl9Q+jQEgWZ3xjN/JbGYDo=;
        b=r/D+7pJ5aBM4ylppkWSBH47isJn5PmuXc8pYe51mdeNlO+QCTCXqhyim77JEnK8g0c
         rgo0a8x6AkWkG0bEWPyLW8+BCu6uvMuowwhenV7P2zpqF2Pi9Kr6y4hcc7U41eErw2id
         YlDdkERPwuFOAx0jNZ5lnQEay+6hyUWA8TYwJzqNGHlghlaBEWC3/jBkC1HzfHAAxhLd
         H+qGRChchFPwuXWuKqBcjH6pewWXCr9xe1Vph929rEYN/t/H4KFmcMD6z577qYoMIBLx
         O/TpyULXZFhMvqDph7YKjk6a/ciTfnOW9Lv04t4a9ykQgoZI/vqu9wELEOOk3mTvxrYK
         nXfg==
X-Gm-Message-State: APjAAAUBD6VKq+pDbfsLc7KVVrdW+E6c7Z3Ec1ltOmWTBMHmUqPKDn7d
        Vu9Q5KhQTKVi9IVFn0T5/hbs4+QhtrPr/dgZgG9xKRLYpX9s
X-Google-Smtp-Source: APXvYqz/GJrF72THl8Fsz7WSlSyAKZpb+oS6xDfReHHRblVP3q8sE7AmpIJ6s2oI9Ule9yilcouJDeQ+zZiETentaPR+yhr/BW3b
MIME-Version: 1.0
X-Received: by 2002:a02:1441:: with SMTP id 62mr26135981jag.21.1563970086415;
 Wed, 24 Jul 2019 05:08:06 -0700 (PDT)
Date:   Wed, 24 Jul 2019 05:08:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070c81a058e6c2917@google.com>
Subject: memory leak in v9fs_session_init
From:   syzbot <syzbot+15b759334fd44cd9785a@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=163046afa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d31de3d88059b7fa
dashboard link: https://syzkaller.appspot.com/bug?extid=15b759334fd44cd9785a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1735466c600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117e0cf0600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+15b759334fd44cd9785a@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811181c360 (size 32):
   comm "syz-executor114", pid 7075, jiffies 4294946393 (age 16.360s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 46 04 00 ea ff ff 80 4a 46 04 00 ea ff ff  r.F......JF.....
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881109294a0 (size 32):
   comm "syz-executor114", pid 7076, jiffies 4294946394 (age 16.350s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110929b40 (size 32):
   comm "syz-executor114", pid 7080, jiffies 4294946394 (age 16.350s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881109292a0 (size 32):
   comm "syz-executor114", pid 7081, jiffies 4294946395 (age 16.340s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r.kernel_t:s0...
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811181c360 (size 32):
   comm "syz-executor114", pid 7075, jiffies 4294946393 (age 16.410s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 46 04 00 ea ff ff 80 4a 46 04 00 ea ff ff  r.F......JF.....
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881109294a0 (size 32):
   comm "syz-executor114", pid 7076, jiffies 4294946394 (age 16.400s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110929b40 (size 32):
   comm "syz-executor114", pid 7080, jiffies 4294946394 (age 16.400s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881109292a0 (size 32):
   comm "syz-executor114", pid 7081, jiffies 4294946395 (age 16.390s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r.kernel_t:s0...
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811181c360 (size 32):
   comm "syz-executor114", pid 7075, jiffies 4294946393 (age 17.280s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 46 04 00 ea ff ff 80 4a 46 04 00 ea ff ff  r.F......JF.....
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881109294a0 (size 32):
   comm "syz-executor114", pid 7076, jiffies 4294946394 (age 17.270s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110929b40 (size 32):
   comm "syz-executor114", pid 7080, jiffies 4294946394 (age 17.270s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881109292a0 (size 32):
   comm "syz-executor114", pid 7081, jiffies 4294946395 (age 17.260s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r.kernel_t:s0...
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811181c360 (size 32):
   comm "syz-executor114", pid 7075, jiffies 4294946393 (age 18.150s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 46 04 00 ea ff ff 80 4a 46 04 00 ea ff ff  r.F......JF.....
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881109294a0 (size 32):
   comm "syz-executor114", pid 7076, jiffies 4294946394 (age 18.140s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110929b40 (size 32):
   comm "syz-executor114", pid 7080, jiffies 4294946394 (age 18.140s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881109292a0 (size 32):
   comm "syz-executor114", pid 7081, jiffies 4294946395 (age 18.130s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r.kernel_t:s0...
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811181c360 (size 32):
   comm "syz-executor114", pid 7075, jiffies 4294946393 (age 19.020s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 46 04 00 ea ff ff 80 4a 46 04 00 ea ff ff  r.F......JF.....
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881109294a0 (size 32):
   comm "syz-executor114", pid 7076, jiffies 4294946394 (age 19.010s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110929b40 (size 32):
   comm "syz-executor114", pid 7080, jiffies 4294946394 (age 19.010s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881109292a0 (size 32):
   comm "syz-executor114", pid 7081, jiffies 4294946395 (age 19.000s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r.kernel_t:s0...
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811181c360 (size 32):
   comm "syz-executor114", pid 7075, jiffies 4294946393 (age 19.070s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 46 04 00 ea ff ff 80 4a 46 04 00 ea ff ff  r.F......JF.....
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881109294a0 (size 32):
   comm "syz-executor114", pid 7076, jiffies 4294946394 (age 19.060s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110929b40 (size 32):
   comm "syz-executor114", pid 7080, jiffies 4294946394 (age 19.060s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881109292a0 (size 32):
   comm "syz-executor114", pid 7081, jiffies 4294946395 (age 19.050s)
   hex dump (first 32 bytes):
     77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
     72 00 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r.kernel_t:s0...
   backtrace:
     [<00000000830cd797>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
     [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
     [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
     [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
     [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
     [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
     [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
     [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
     [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
     [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
     [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
     [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
     [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
     [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
     [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
     [<00000000b6179601>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

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
