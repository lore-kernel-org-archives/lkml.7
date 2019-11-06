Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C978CC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825B8206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfKFH6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:58:09 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42150 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfKFH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:58:09 -0500
Received: by mail-io1-f69.google.com with SMTP id w1so17554531ioj.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 23:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GH01jGil49s26mb+NO6lD/MfDtutafn9gDxm3A/0YAY=;
        b=HIFfOL/JwL4Gt0OdjOily3yXhmI1k8Vh64RoBkCX6A25Z0CPzeo0CSgooRx0qaMyoG
         scFO0gYJ8CoNbP4sa1ZXY+KlqDdrWgqqcyN9+got+c2hsWa7FUYu799+8O60lNBUkiOz
         lAYHDeq8copBpRTejIhdTnnFc9BigmHDn+OnMO4t7t3rq437ktthmM6jTOeUT259gdAk
         OkxXbfO5cgEmvwmzgQ0ysbCH1IOluO7tqo7DOJno+6lhQPKGvlhVi2vJ7G+80IhCdUQW
         ZAMCWld00ceBu1trPj1nJyOJkEuBM36SgyyT5YKYDSNFpXDp9YOFL0jlZkTJ+B5CmxGW
         NjRA==
X-Gm-Message-State: APjAAAXc7Q0Xm3GAIZwegfGa6kMIrVGf+16PdUx0jIR4neEPMr++p1Mx
        MxMXbdjLj1sZ4MRFWhyHLZdJbczyLPhhq9sfWIfhlZ2dJJK/
X-Google-Smtp-Source: APXvYqx5rROENQYa8KJJ8xCEkRiebHoASEOaADSjXL/uCXrQk+O8/nZjeF4bla9pmD5TLBK55aGqB6/dzYZ9tvcdyAXdUKKFHYT9
MIME-Version: 1.0
X-Received: by 2002:a92:d484:: with SMTP id p4mr1352967ilg.52.1573027087769;
 Tue, 05 Nov 2019 23:58:07 -0800 (PST)
Date:   Tue, 05 Nov 2019 23:58:07 -0800
In-Reply-To: <0000000000002e4a260576c1589d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9eaf30596a8e8a5@google.com>
Subject: Re: KASAN: use-after-free Read in relay_switch_subbuf
From:   syzbot <syzbot+29093015c21333d1c46d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ebiggers@google.com,
        gregkh@linuxfoundation.org, jannh@google.com, jrdr.linux@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mawilcox@microsoft.com, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    26bc6721 Merge tag 'for-linus-2019-11-05' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b7b7cce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5e2eca3f31f9bf
dashboard link: https://syzkaller.appspot.com/bug?extid=29093015c21333d1c46d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132afbcce00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179a1f8ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+29093015c21333d1c46d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in relay_switch_subbuf+0x8be/0x920  
kernel/relay.c:755
Read of size 8 at addr ffff88808d5054f8 by task kworker/1:3/3760

CPU: 1 PID: 3760 Comm: kworker/1:3 Not tainted 5.4.0-rc6+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events __blk_release_queue
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  relay_switch_subbuf+0x8be/0x920 kernel/relay.c:755
  relay_flush kernel/relay.c:883 [inline]
  relay_flush+0x1c4/0x280 kernel/relay.c:867
  __blk_trace_startstop.isra.0+0x216/0x630 kernel/trace/blktrace.c:662
  blk_trace_shutdown+0x5f/0x90 kernel/trace/blktrace.c:746
  __blk_release_queue+0x219/0x380 block/blk-sysfs.c:904
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 11279:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:518
  slab_post_alloc_hook mm/slab.h:584 [inline]
  slab_alloc mm/slab.c:3319 [inline]
  kmem_cache_alloc+0x121/0x710 mm/slab.c:3483
  __d_alloc+0x2e/0x8c0 fs/dcache.c:1688
  d_alloc+0x4d/0x280 fs/dcache.c:1767
  d_alloc_parallel+0xf4/0x1c30 fs/dcache.c:2519
  __lookup_slow+0x1ab/0x500 fs/namei.c:1646
  lookup_one_len+0x16d/0x1a0 fs/namei.c:2533
  start_creating+0xc5/0x1d0 fs/debugfs/inode.c:339
  __debugfs_create_file+0x65/0x3f0 fs/debugfs/inode.c:384
  debugfs_create_file+0x5a/0x70 fs/debugfs/inode.c:441
  blk_create_buf_file_callback+0x33/0x40 kernel/trace/blktrace.c:444
  relay_create_buf_file+0xf9/0x180 kernel/relay.c:428
  relay_open_buf.part.0+0x76e/0xb60 kernel/relay.c:457
  relay_open_buf kernel/relay.c:449 [inline]
  relay_open kernel/relay.c:599 [inline]
  relay_open+0x523/0x980 kernel/relay.c:563
  do_blk_trace_setup+0x3f0/0xb50 kernel/trace/blktrace.c:526
  __blk_trace_setup+0xe3/0x190 kernel/trace/blktrace.c:571
  blk_trace_ioctl+0x170/0x300 kernel/trace/blktrace.c:710
  blkdev_ioctl+0x126/0x1c20 block/ioctl.c:592
  block_ioctl+0xee/0x130 fs/block_dev.c:1954
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 11303:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3425 [inline]
  kmem_cache_free+0x86/0x320 mm/slab.c:3693
  __d_free+0x20/0x30 fs/dcache.c:271
  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch kernel/rcu/tree.c:2157 [inline]
  rcu_core+0x581/0x1560 kernel/rcu/tree.c:2377
  rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2386
  __do_softirq+0x262/0x98c kernel/softirq.c:292

The buggy address belongs to the object at ffff88808d5054a0
  which belongs to the cache dentry of size 288
The buggy address is located 88 bytes inside of
  288-byte region [ffff88808d5054a0, ffff88808d5055c0)
The buggy address belongs to the page:
page:ffffea0002354140 refcount:1 mapcount:0 mapping:ffff8880aa57b000  
index:0xffff88808d505e40
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea000299b6c8 ffffea0002353f08 ffff8880aa57b000
raw: ffff88808d505e40 ffff88808d505080 0000000100000009 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808d505380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808d505400: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> ffff88808d505480: fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb fb
                                                                 ^
  ffff88808d505500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808d505580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================

