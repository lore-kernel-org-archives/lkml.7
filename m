Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E106C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE42520637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfLIFZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 00:25:10 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:37726 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfLIFZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 00:25:09 -0500
Received: by mail-il1-f198.google.com with SMTP id t19so10852662ila.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 21:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FUR5HH5qJErdY2JqpOki/U8tKZp98W2ZoPj1kOrVy7U=;
        b=rCSGPDxrMlo3V/1dV0iLCyMnpLkNIVkmvrw121Qz4yZ+JUVTA6QhOnvGc+QCPM7xwM
         c2a5xxw42kuLHIGrEPWde/7M9z/ejr01XP7S6JO6SbOOW99r3bsuI99H2r3KIvUFWNTr
         eMii9AGNWxqMC6VRt8aF0DCW4ItUFntXg5fZXZzSTtVlopasuH6n2mKEnBZLb/ZKKXK0
         G+FXMsRnjAtCfFIUW8rXQOZsqA61PCOMrU+zeDqgqTvXQxPE2XTTtciW6BV0ZtWPUMD1
         kuFq+ahxw9A2zCCaylfde2LTPxSHBQbTb8k3sChO8X1V+nur5qDbdsBKJ3c4f9EY60cU
         v4Pw==
X-Gm-Message-State: APjAAAUl9YUqcdwrgIu+nrzAobyR0djKUWb6WC/pqy69BQGUaGIrpzFW
        3TMGrrlwXZ039/UrOtwPxAu8euYXA18ZSQ4lSSP0bVEy0VeY
X-Google-Smtp-Source: APXvYqxbTYgS+UzTWkNlPOh3ufIFqWK1gmZ+gqCKv92ZZKxxyuhbiWeFyYbbA6FIl1xI6HkVG/4jh0arIvL8KxaHAcPOSWwG4FVq
MIME-Version: 1.0
X-Received: by 2002:a92:9f9c:: with SMTP id z28mr26764436ilk.239.1575869109062;
 Sun, 08 Dec 2019 21:25:09 -0800 (PST)
Date:   Sun, 08 Dec 2019 21:25:09 -0800
In-Reply-To: <0000000000007f075c0598f7aa38@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075564805993e9eeb@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bit_putcs
From:   syzbot <syzbot+998dec6452146bd7a90c@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    9455d25f Merge tag 'ntb-5.5' of git://github.com/jonmason/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b1d1bce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3b8f5088d4043a
dashboard link: https://syzkaller.appspot.com/bug?extid=998dec6452146bd7a90c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fa5c2ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e327f2e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+998dec6452146bd7a90c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __fb_pad_aligned_buffer  
include/linux/fb.h:655 [inline]
BUG: KASAN: slab-out-of-bounds in bit_putcs_aligned  
drivers/video/fbdev/core/bitblit.c:96 [inline]
BUG: KASAN: slab-out-of-bounds in bit_putcs+0xd5d/0xf10  
drivers/video/fbdev/core/bitblit.c:185
Read of size 1 at addr ffff8880a66ec808 by task syz-executor523/8819

CPU: 1 PID: 8819 Comm: syz-executor523 Not tainted 5.4.0-syzkaller #0
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
  fbcon_do_set_font+0x829/0x960 drivers/video/fbdev/core/fbcon.c:2605
  fbcon_copy_font+0x12c/0x190 drivers/video/fbdev/core/fbcon.c:2620
  con_font_copy drivers/tty/vt/vt.c:4594 [inline]
  con_font_op+0x6b2/0x1270 drivers/tty/vt/vt.c:4609
  vt_ioctl+0x181a/0x26d0 drivers/tty/vt/vt_ioctl.c:965
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
RIP: 0033:0x446a79
Code: e8 ec e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f451fcd2d08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc58 RCX: 0000000000446a79
RDX: 0000000020000180 RSI: 0000000000004b72 RDI: 0000000000000003
RBP: 00000000006dbc50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc5c
R13: 0000000000000000 R14: 00000000f72a8fce R15: 0000000000000000

Allocated by task 8802:
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

Freed by task 8528:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  kvfree+0x61/0x70 mm/util.c:603
  __free_fdtable+0x34/0x80 fs/file.c:31
  put_files_struct fs/file.c:420 [inline]
  put_files_struct+0x253/0x2f0 fs/file.c:413
  exit_files+0x83/0xb0 fs/file.c:445
  do_exit+0x8b5/0x2ef0 kernel/exit.c:792
  do_group_exit+0x135/0x360 kernel/exit.c:895
  __do_sys_exit_group kernel/exit.c:906 [inline]
  __se_sys_exit_group kernel/exit.c:904 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:904
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a66ec000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 8 bytes to the right of
  2048-byte region [ffff8880a66ec000, ffff8880a66ec800)
The buggy address belongs to the page:
page:ffffea000299bb00 refcount:1 mapcount:0 mapping:ffff8880aa400e00  
index:0x0
raw: 00fffe0000000200 ffffea000299bac8 ffffea000299bb48 ffff8880aa400e00
raw: 0000000000000000 ffff8880a66ec000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a66ec700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a66ec780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8880a66ec800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                       ^
  ffff8880a66ec880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a66ec900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

