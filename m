Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C630EC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD1D21823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfLEQqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:46:10 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:39007 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLEQqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:46:09 -0500
Received: by mail-il1-f200.google.com with SMTP id v11so2946996ilg.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 08:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6XRIMuzgh02Ovw3rxeyz54ijBjPe2X9NHJTkVKkX31c=;
        b=AYYemlZi/S4VbE3aySCcX5tnqj9GnUwl/nlpfn3kOqlYaaqOww70GqMAYWvsnlUVar
         NNOacVMufXalEO/JURlR7sXCHszxIFW8Pph3uCXz773BQCnqNAIx7hIebPoJwfD1QPTm
         VZnemHICEr/yn8f11p05Q3QMgQsz7UPsOm33B7/wYJ2VtzE2gTAJwxpIW7ic25ase8lR
         cavPG3C9S4rgTSGlzOcejqkWFLJY/e2c6oSO1FoqP5cFkgygdTcc/Uea5T/JbfYbMneg
         bEzyLiEWJCLmZZpsx3J8anSXdQi5h+J5JS6FA3ZBrpxsK6xdzpo43SIXSn4FP1YmYNXw
         SUqg==
X-Gm-Message-State: APjAAAXh35/04v0ufYVgJzY4dNghWb0WfEcw0b+QakFO+PfKKbiyDyGg
        jppCI93JhSEz1ULz+altiqim4Ltw5heFK5RAgUuVdqsv25Rc
X-Google-Smtp-Source: APXvYqxQVnQDUVP2INDpxyPnyG5PtM7v1M6Mm6zZiDrpKRt8Oj8xWWXGWPnM0NftkIPnk0Nc6bZSd6+4j6uheUrk7UGEGl/O9jKS
MIME-Version: 1.0
X-Received: by 2002:a02:9f09:: with SMTP id z9mr8888680jal.119.1575564368341;
 Thu, 05 Dec 2019 08:46:08 -0800 (PST)
Date:   Thu, 05 Dec 2019 08:46:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f075c0598f7aa38@google.com>
Subject: KASAN: slab-out-of-bounds Read in bit_putcs
From:   syzbot <syzbot+998dec6452146bd7a90c@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    282ffdf3 Add linux-next specific files for 20191205
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=165627f2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29372c0243b4b980
dashboard link: https://syzkaller.appspot.com/bug?extid=998dec6452146bd7a90c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+998dec6452146bd7a90c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __fb_pad_aligned_buffer  
include/linux/fb.h:655 [inline]
BUG: KASAN: slab-out-of-bounds in bit_putcs_aligned  
drivers/video/fbdev/core/bitblit.c:96 [inline]
BUG: KASAN: slab-out-of-bounds in bit_putcs+0xd5d/0xf10  
drivers/video/fbdev/core/bitblit.c:185
Read of size 1 at addr ffff88809f4ed8fe by task syz-executor.1/22264

CPU: 0 PID: 22264 Comm: syz-executor.1 Not tainted  
5.4.0-next-20191205-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __fb_pad_aligned_buffer include/linux/fb.h:655 [inline]
  bit_putcs_aligned drivers/video/fbdev/core/bitblit.c:96 [inline]
  bit_putcs+0xd5d/0xf10 drivers/video/fbdev/core/bitblit.c:185
  fbcon_putcs+0x33c/0x3e0 drivers/video/fbdev/core/fbcon.c:1353
  do_update_region+0x42b/0x6f0 drivers/tty/vt/vt.c:677
  redraw_screen+0x676/0x7d0 drivers/tty/vt/vt.c:1011
  vc_do_resize+0x10c9/0x1460 drivers/tty/vt/vt.c:1284
  vc_resize+0x4d/0x60 drivers/tty/vt/vt.c:1304
  vt_ioctl+0x2076/0x26d0 drivers/tty/vt/vt_ioctl.c:887
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a679
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fce593a0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
RDX: 00000000200002c0 RSI: 000000000000560a RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fce593a16d4
R13: 00000000004c6ce2 R14: 00000000004dd2d0 R15: 00000000ffffffff

Allocated by task 18936:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3665
  kmalloc include/linux/slab.h:561 [inline]
  fbcon_set_font+0x32d/0x860 drivers/video/fbdev/core/fbcon.c:2663
  con_font_set drivers/tty/vt/vt.c:4538 [inline]
  con_font_op+0xe30/0x1270 drivers/tty/vt/vt.c:4603
  vt_ioctl+0xd2e/0x26d0 drivers/tty/vt/vt_ioctl.c:913
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 18502:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  free_event_rcu+0x5e/0x70 kernel/events/core.c:4372
  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch kernel/rcu/tree.c:2183 [inline]
  rcu_core+0x570/0x1540 kernel/rcu/tree.c:2408
  rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2417
  __do_softirq+0x262/0x98c kernel/softirq.c:292

The buggy address belongs to the object at ffff88809f4ed000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 254 bytes to the right of
  2048-byte region [ffff88809f4ed000, ffff88809f4ed800)
The buggy address belongs to the page:
page:ffffea00027d3b40 refcount:1 mapcount:0 mapping:ffff8880aa400e00  
index:0x0
raw: 00fffe0000000200 ffffea00029bc9c8 ffffea00024ae408 ffff8880aa400e00
raw: 0000000000000000 ffff88809f4ed000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809f4ed780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88809f4ed800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88809f4ed880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                                 ^
  ffff88809f4ed900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88809f4ed980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
