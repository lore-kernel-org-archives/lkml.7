Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FC5C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1532245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLFKzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:55:09 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:48713 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfLFKzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:55:09 -0500
Received: by mail-il1-f200.google.com with SMTP id 4so4957452ill.15
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nXY04AypAT9QNd9gnJ37xr4TWPWyQ5hCznE63GlSNbI=;
        b=mP+5FK6ilnq65iLUhUkWi4rLxW8WNjvs3DDD+zAMTUvbXVmdgohnhA9IJ23SoO2WR4
         N9SBs3+jOvoYNfMm6jPCuJVx43k9+nKoxcWmJloZ3ufY/qPP9kZG5FlkV5I+Mm8saKMa
         oEQ2clp11hP9fOjZV4FViIRGBuDeuiZ8GXC7GHPiWIdKl9PZayRO7QpMBayUEi1JaDEi
         gNuSWM9PtGJBYSMNJA7olXbiV3YF3B30Y7VPVWoUsAoOafIRFGrmZCq7ZwPKgbtO5jiO
         w4rZciX7TkhpHfgP+zQ3Qw1XTqBxAxgukB1gKCysU1WuB2r+ZTDa7tzlE0HHIzpoGC7v
         rdOA==
X-Gm-Message-State: APjAAAX1x7+KCZFI3LCcZfz68L7Nn6cCViiay7tIlCE07FWi7nPDBY8E
        8uAyrmyFj5IVuEuZoabn2xEqqp7yEqHHvmK4gQhUsGfM9IVZ
X-Google-Smtp-Source: APXvYqyWKy5SqXwI8eyIgsIImBkTo33gyuUB0lJurkZoGveshhGWsVVfz9mCw/RQmL+CkP2lM41lV+NWKhZGzneFJfKAzYza81ZE
MIME-Version: 1.0
X-Received: by 2002:a6b:fd10:: with SMTP id c16mr9994492ioi.76.1575629708008;
 Fri, 06 Dec 2019 02:55:08 -0800 (PST)
Date:   Fri, 06 Dec 2019 02:55:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b284d059906e13e@google.com>
Subject: KASAN: use-after-free Read in n_tty_receive_buf_common
From:   syzbot <syzbot+59997e8d5cbdc486e6f6@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b0d4beaa Merge branch 'next.autofs' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12712861e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f07a23020fd7d21a
dashboard link: https://syzkaller.appspot.com/bug?extid=59997e8d5cbdc486e6f6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1662542ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+59997e8d5cbdc486e6f6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in n_tty_check_throttle drivers/tty/n_tty.c:266  
[inline]
BUG: KASAN: use-after-free in n_tty_receive_buf_common+0x270f/0x2b70  
drivers/tty/n_tty.c:1761
Read of size 1 at addr ffff8880812c801c by task syz-executor.2/9011

CPU: 1 PID: 9011 Comm: syz-executor.2 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  n_tty_check_throttle drivers/tty/n_tty.c:266 [inline]
  n_tty_receive_buf_common+0x270f/0x2b70 drivers/tty/n_tty.c:1761
  n_tty_receive_buf2+0x34/0x40 drivers/tty/n_tty.c:1777
  tty_ldisc_receive_buf+0xad/0x1c0 drivers/tty/tty_buffer.c:461
  paste_selection+0x1ff/0x460 drivers/tty/vt/selection.c:372
  tioclinux+0x133/0x480 drivers/tty/vt/vt.c:3044
  vt_ioctl+0x1a41/0x26d0 drivers/tty/vt/vt_ioctl.c:364
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
RSP: 002b:00007fd3ebea6c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
RDX: 0000000020000180 RSI: 000000000000541c RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd3ebea76d4
R13: 00000000004c5951 R14: 00000000004dbb60 R15: 00000000ffffffff

Allocated by task 8983:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3665
  kmalloc_array include/linux/slab.h:598 [inline]
  set_selection_kernel+0x872/0x13b0 drivers/tty/vt/selection.c:305
  set_selection_user+0x95/0xd9 drivers/tty/vt/selection.c:177
  tioclinux+0x11c/0x480 drivers/tty/vt/vt.c:3039
  vt_ioctl+0x1a41/0x26d0 drivers/tty/vt/vt_ioctl.c:364
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

Freed by task 9007:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  set_selection_kernel+0x88f/0x13b0 drivers/tty/vt/selection.c:312
  set_selection_user+0x95/0xd9 drivers/tty/vt/selection.c:177
  tioclinux+0x11c/0x480 drivers/tty/vt/vt.c:3039
  vt_ioctl+0x1a41/0x26d0 drivers/tty/vt/vt_ioctl.c:364
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

The buggy address belongs to the object at ffff8880812c8000
  which belongs to the cache kmalloc-16k of size 16384
The buggy address is located 28 bytes inside of
  16384-byte region [ffff8880812c8000, ffff8880812cc000)
The buggy address belongs to the page:
page:ffffea000204b200 refcount:1 mapcount:0 mapping:ffff8880aa402380  
index:0x0 compound_mapcount: 0
raw: 00fffe0000010200 ffffea0002046808 ffffea000204e208 ffff8880aa402380
raw: 0000000000000000 ffff8880812c8000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880812c7f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880812c7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8880812c8000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff8880812c8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880812c8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
