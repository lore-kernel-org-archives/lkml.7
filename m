Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4476EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 03:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0702421924
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 03:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392846AbfIJDiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 23:38:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51378 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfIJDiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 23:38:06 -0400
Received: by mail-io1-f71.google.com with SMTP id a13so20929846ioh.18
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 20:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Rd/SAk5CtZwf/BrETHXkyZKKBtvN/8H2VfgfX20+5x4=;
        b=UheMeAIwiK0ANm0ui2AQsqouxmNZZBSlCYbYd9G0IDbLrS1qWw1E8ylfBkVaaeRHx3
         flVnJ4JpxFrWSnmeyKSGgwMBTEeGXCgKpJ+W+LODD5no14f9vJxqK7SHA/BWsXrb9XyE
         9mV7FRsY9R75Y6CTiW28NKZ8jpn5zvRuD2gztpLh5jlDqTsYoqQt2KshJZjr3OcehQ7d
         hQEQUJhPx0MklqVEAdF3X6TEYjEkJkSvKREk+nmUFePn6c6VFapmaem2GWIxwoSPhYdq
         jRbF2t83xBy+vhNF1gJbFWVTJ3LaOK/cmiM5GmPcx+TtNfxS1puuJtE72JJrlZR6mfZw
         di1Q==
X-Gm-Message-State: APjAAAVOe6M3ELi9Z5UWpkaYU5+djxFz4krIxR73iYHYq27RlfjBpw/n
        kdlnAojzu0Sb2Ilx02Ie5hXqY4SdtXszcmv/CThB4Ji3MAvF
X-Google-Smtp-Source: APXvYqy8z5tCABQwtCejIYZLwHFWWUW9p92XwbjPu6406dfxH/DFby8KUmRkDBRPD5enP5epvzyRkTeR+lTpGpeMbwCEDZHEK/4P
MIME-Version: 1.0
X-Received: by 2002:a5d:9b06:: with SMTP id y6mr18645624ion.77.1568086685410;
 Mon, 09 Sep 2019 20:38:05 -0700 (PDT)
Date:   Mon, 09 Sep 2019 20:38:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc762d05922aa177@google.com>
Subject: possible deadlock in shmem_fallocate (3)
From:   syzbot <syzbot+5d04068d02b9da8a0947@syzkaller.appspotmail.com>
To:     hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6d028043 Add linux-next specific files for 20190830
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12359ec6600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82a6bec43ab0cb69
dashboard link: https://syzkaller.appspot.com/bug?extid=5d04068d02b9da8a0947
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5d04068d02b9da8a0947@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.3.0-rc6-next-20190830 #75 Not tainted
------------------------------------------------------
kswapd0/1770 is trying to acquire lock:
ffff8880a0b9b780 (&sb->s_type->i_mutex_key#13){+.+.}, at: inode_lock  
include/linux/fs.h:789 [inline]
ffff8880a0b9b780 (&sb->s_type->i_mutex_key#13){+.+.}, at:  
shmem_fallocate+0x15a/0xc60 mm/shmem.c:2728

but task is already holding lock:
ffffffff89042f80 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x30  
mm/page_alloc.c:4889

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}:
        __fs_reclaim_acquire mm/page_alloc.c:4075 [inline]
        fs_reclaim_acquire.part.0+0x24/0x30 mm/page_alloc.c:4086
        fs_reclaim_acquire mm/page_alloc.c:4662 [inline]
        prepare_alloc_pages mm/page_alloc.c:4659 [inline]
        __alloc_pages_nodemask+0x52f/0x900 mm/page_alloc.c:4711
        alloc_pages_vma+0x1bc/0x3f0 mm/mempolicy.c:2114
        shmem_alloc_page+0xbd/0x180 mm/shmem.c:1496
        shmem_alloc_and_acct_page+0x165/0x990 mm/shmem.c:1521
        shmem_getpage_gfp+0x598/0x2680 mm/shmem.c:1835
        shmem_getpage mm/shmem.c:152 [inline]
        shmem_write_begin+0x105/0x1e0 mm/shmem.c:2480
        generic_perform_write+0x23b/0x540 mm/filemap.c:3304
        __generic_file_write_iter+0x25e/0x630 mm/filemap.c:3433
        generic_file_write_iter+0x420/0x690 mm/filemap.c:3465
        call_write_iter include/linux/fs.h:1890 [inline]
        new_sync_write+0x4d3/0x770 fs/read_write.c:483
        __vfs_write+0xe1/0x110 fs/read_write.c:496
        vfs_write+0x268/0x5d0 fs/read_write.c:558
        ksys_write+0x14f/0x290 fs/read_write.c:611
        __do_sys_write fs/read_write.c:623 [inline]
        __se_sys_write fs/read_write.c:620 [inline]
        __x64_sys_write+0x73/0xb0 fs/read_write.c:620
        do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sb->s_type->i_mutex_key#13){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2476 [inline]
        check_prevs_add kernel/locking/lockdep.c:2581 [inline]
        validate_chain kernel/locking/lockdep.c:2971 [inline]
        __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
        down_write+0x93/0x150 kernel/locking/rwsem.c:1534
        inode_lock include/linux/fs.h:789 [inline]
        shmem_fallocate+0x15a/0xc60 mm/shmem.c:2728
        ashmem_shrink_scan drivers/staging/android/ashmem.c:462 [inline]
        ashmem_shrink_scan+0x370/0x510 drivers/staging/android/ashmem.c:437
        do_shrink_slab+0x40f/0xa30 mm/vmscan.c:560
        shrink_slab mm/vmscan.c:721 [inline]
        shrink_slab+0x19a/0x680 mm/vmscan.c:694
        shrink_node+0x223/0x12e0 mm/vmscan.c:2807
        kswapd_shrink_node mm/vmscan.c:3549 [inline]
        balance_pgdat+0x57c/0xea0 mm/vmscan.c:3707
        kswapd+0x5c3/0xf30 mm/vmscan.c:3958
        kthread+0x361/0x430 kernel/kthread.c:255
        ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(fs_reclaim);
                                lock(&sb->s_type->i_mutex_key#13);
                                lock(fs_reclaim);
   lock(&sb->s_type->i_mutex_key#13);

  *** DEADLOCK ***

2 locks held by kswapd0/1770:
  #0: ffffffff89042f80 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x30  
mm/page_alloc.c:4889
  #1: ffffffff8901ffe8 (shrinker_rwsem){++++}, at: shrink_slab  
mm/vmscan.c:711 [inline]
  #1: ffffffff8901ffe8 (shrinker_rwsem){++++}, at: shrink_slab+0xe6/0x680  
mm/vmscan.c:694

stack backtrace:
CPU: 0 PID: 1770 Comm: kswapd0 Not tainted 5.3.0-rc6-next-20190830 #75
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_circular_bug.isra.0.cold+0x163/0x172 kernel/locking/lockdep.c:1685
  check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1809
  check_prev_add kernel/locking/lockdep.c:2476 [inline]
  check_prevs_add kernel/locking/lockdep.c:2581 [inline]
  validate_chain kernel/locking/lockdep.c:2971 [inline]
  __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
  down_write+0x93/0x150 kernel/locking/rwsem.c:1534
  inode_lock include/linux/fs.h:789 [inline]
  shmem_fallocate+0x15a/0xc60 mm/shmem.c:2728
  ashmem_shrink_scan drivers/staging/android/ashmem.c:462 [inline]
  ashmem_shrink_scan+0x370/0x510 drivers/staging/android/ashmem.c:437
  do_shrink_slab+0x40f/0xa30 mm/vmscan.c:560
  shrink_slab mm/vmscan.c:721 [inline]
  shrink_slab+0x19a/0x680 mm/vmscan.c:694
  shrink_node+0x223/0x12e0 mm/vmscan.c:2807
  kswapd_shrink_node mm/vmscan.c:3549 [inline]
  balance_pgdat+0x57c/0xea0 mm/vmscan.c:3707
  kswapd+0x5c3/0xf30 mm/vmscan.c:3958
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
