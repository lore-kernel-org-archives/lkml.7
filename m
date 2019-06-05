Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E95C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC22D2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfFETIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 15:08:07 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:37416 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfFETIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 15:08:06 -0400
Received: by mail-it1-f200.google.com with SMTP id q20so2631925itq.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 12:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/lyFCA8bw6u/NMl0h/+UfyWf42oW0YOsOpZ+e9v8TQs=;
        b=V5ubGCezIA9ZJd5u/50VJo88l8l9XqOScSLwhDDaPe82KP8giRJ7RicSbRLyG7hGKw
         I5Tp8PpXlUBjRkf3E9k0JcI6L30Y8XYA06e5oov5KSUKWomxDC89kAoSCxTK/wCURWQ8
         MIG74kYOI/0WqXCKea6pYkCxueg9w9gUwtUuDsvwrAtyAriMtnODEJNuVDeXGJAeEAIE
         DICKMjp09RqHUGD6lfAOmiKFGiWXPaWOE5NmPpYCIqpN3LXAu1U7/YsxK+cXRSkG0/Sx
         iW0r1gS8tQFjo4gz7+GQAstAG8pjtQZNoopFjkG8SiHWp044u6mvQ8JBerQrKGCrZaPh
         QzgQ==
X-Gm-Message-State: APjAAAWSrJRxiz43ubyhy0+ZUgB+2uIftR0KqbFh1loilxioLQKckfVe
        43X4c8CwkLT+NFEs5cvS1IFvg8Hw05YCj5wlDSn2GVz4Kg+c
X-Google-Smtp-Source: APXvYqx+Ye8i6H1QLwlttGpWwG7TXvZFfPaEDr5rTHdNAcDr2O9o0P28kEvQF8tauo2riWuFR9pisk9Je0/I8nUrxK7Mtc8Om2zY
MIME-Version: 1.0
X-Received: by 2002:a05:6602:b:: with SMTP id b11mr24307233ioa.274.1559761685662;
 Wed, 05 Jun 2019 12:08:05 -0700 (PDT)
Date:   Wed, 05 Jun 2019 12:08:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035598c058a9851e5@google.com>
Subject: KASAN: use-after-free Read in register_shrinker_prepared
From:   syzbot <syzbot+b8b2e599b6176efeaf51@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, chris@chrisdown.name,
        hannes@cmpxchg.org, ktkhai@virtuozzo.com, laoar.shao@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, mhocko@suse.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, yang.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    56b697c6 Add linux-next specific files for 20190604
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1557b42ea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4248d6bc70076f7d
dashboard link: https://syzkaller.appspot.com/bug?extid=b8b2e599b6176efeaf51
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b8b2e599b6176efeaf51@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x9a/0xa0 lib/list_debug.c:26
Read of size 8 at addr ffff8880897dde68 by task syz-executor.4/26131

CPU: 1 PID: 26131 Comm: syz-executor.4 Not tainted 5.2.0-rc3-next-20190604  
#8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0xd4/0x306 mm/kasan/report.c:351
  __kasan_report.cold+0x1b/0x36 mm/kasan/report.c:482
  kasan_report+0x12/0x20 mm/kasan/common.c:614
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __list_add_valid+0x9a/0xa0 lib/list_debug.c:26
  __list_add include/linux/list.h:60 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  register_shrinker_prepared+0x3d/0x190 mm/vmscan.c:414
  sget_userns+0x42c/0x560 fs/super.c:627
  sget+0x10c/0x150 fs/super.c:660
  mount_bdev+0xff/0x3c0 fs/super.c:1319
  hfs_mount+0x35/0x40 fs/hfs/super.c:457
  legacy_get_tree+0x108/0x220 fs/fs_context.c:661
  vfs_get_tree+0x8e/0x390 fs/super.c:1476
  do_new_mount fs/namespace.c:2790 [inline]
  do_mount+0x138c/0x1c00 fs/namespace.c:3110
  ksys_mount+0xdb/0x150 fs/namespace.c:3319
  __do_sys_mount fs/namespace.c:3333 [inline]
  __se_sys_mount fs/namespace.c:3330 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3330
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45bcca
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 9d 8d fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7a 8d fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f56d13e4a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f56d13e4b40 RCX: 000000000045bcca
RDX: 00007f56d13e4ae0 RSI: 00000000200000c0 RDI: 00007f56d13e4b00
RBP: 0000000000000000 R08: 00007f56d13e4b40 R09: 00007f56d13e4ae0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000004
R13: 00000000004c7f8b R14: 00000000004de500 R15: 00000000ffffffff

Allocated by task 26058:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:462
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:503
  __do_kmalloc mm/slab.c:3654 [inline]
  __kmalloc+0x15c/0x740 mm/slab.c:3663
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  ops_init+0xff/0x410 net/core/net_namespace.c:120
  setup_net+0x2d3/0x740 net/core/net_namespace.c:316
  copy_net_ns+0x1df/0x340 net/core/net_namespace.c:439
  create_new_namespaces+0x400/0x7b0 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:206
  ksys_unshare+0x444/0x980 kernel/fork.c:2718
  __do_sys_unshare kernel/fork.c:2786 [inline]
  __se_sys_unshare kernel/fork.c:2784 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2784
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 26058:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:451
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:459
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x106/0x2a0 mm/slab.c:3753
  ops_init+0xd1/0x410 net/core/net_namespace.c:135
  setup_net+0x2d3/0x740 net/core/net_namespace.c:316
  copy_net_ns+0x1df/0x340 net/core/net_namespace.c:439
  create_new_namespaces+0x400/0x7b0 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:206
  ksys_unshare+0x444/0x980 kernel/fork.c:2718
  __do_sys_unshare kernel/fork.c:2786 [inline]
  __se_sys_unshare kernel/fork.c:2784 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2784
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880897ddb00
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 872 bytes inside of
  1024-byte region [ffff8880897ddb00, ffff8880897ddf00)
The buggy address belongs to the page:
page:ffffea000225f700 refcount:1 mapcount:0 mapping:ffff8880aa400ac0  
index:0x0 compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00020e7288 ffffea00023e1808 ffff8880aa400ac0
raw: 0000000000000000 ffff8880897dc000 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880897ddd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880897ddd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8880897dde00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                           ^
  ffff8880897dde80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880897ddf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
