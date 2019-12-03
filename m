Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B33C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9078A206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfLCXZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:25:11 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:54979 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfLCXZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 18:25:11 -0500
Received: by mail-il1-f198.google.com with SMTP id t4so4304263ili.21
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 15:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=y788Z+dqTMX2HdMXLCwbCEb/a5TFvF+sXEt39lqKnH4=;
        b=XeF6f1G/eyHf2VZ9dw2D13/xtZiBDGeh0aXOrnPaIjyE4GOBTokvWSLAZYeN0hTmi8
         /gb6NTTCNKPslRwqZqw2GGq23IfHg28FDgFy88pmVeIl5eypdl1FxwDEEiv9DmVBDL7h
         zmEXVSXwN9nPzrIi2ShOkK3DrhptxQ0I9FlyvOYGL1+SVBr6XBGpZH6YXfEGPOZC8SUN
         LGlDk8pOPSi2ifUnPky99iKIX33NOE/nMeNUfTsaR7TTCZOjOezQ7JyqwiWh+Gz0gDT+
         8ICRIEfo6TVwXd9hVTJyOZpeFrMU3O6w5x047pdWYJcYY3dmWbvpDMlr5BqzVxPNonWC
         g/IA==
X-Gm-Message-State: APjAAAXMtr71ohaxRGQHtZCW6xpab3U9Tz+rO3PjXG+2ud2JERFpvFr8
        F8JJOVbNwBWTiCLmZFo+mBfb5AP8hx8PgKPzWCVWrHL2+HQt
X-Google-Smtp-Source: APXvYqwT/rFCoeOp3wr2Plum0wD0QWnJMl+TjgLhLl+N2UFuSIWreDAdfzCEDVh01M4DdnDpN2Twk8Ia+yyY2NxhDfzLpbXsmr+l
MIME-Version: 1.0
X-Received: by 2002:a92:3984:: with SMTP id h4mr772167ilf.36.1575415510268;
 Tue, 03 Dec 2019 15:25:10 -0800 (PST)
Date:   Tue, 03 Dec 2019 15:25:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd04830598d50133@google.com>
Subject: KASAN: use-after-free Read in tty_open
From:   syzbot <syzbot+9af6d43c1beabec8fd05@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125c7c82e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
dashboard link: https://syzkaller.appspot.com/bug?extid=9af6d43c1beabec8fd05
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d15061e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b69aeae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9af6d43c1beabec8fd05@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in test_bit  
include/asm-generic/bitops-instrumented.h:237 [inline]
BUG: KASAN: use-after-free in tty_port_kopened include/linux/tty.h:673  
[inline]
BUG: KASAN: use-after-free in tty_open_by_driver drivers/tty/tty_io.c:1964  
[inline]
BUG: KASAN: use-after-free in tty_open+0x6f8/0xbb0 drivers/tty/tty_io.c:2033
Read of size 8 at addr ffff8880a2b11200 by task syz-executor362/19631

CPU: 1 PID: 19631 Comm: syz-executor362 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:638
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  __kasan_check_read+0x11/0x20 mm/kasan/common.c:94
  test_bit include/asm-generic/bitops-instrumented.h:237 [inline]
  tty_port_kopened include/linux/tty.h:673 [inline]
  tty_open_by_driver drivers/tty/tty_io.c:1964 [inline]
  tty_open+0x6f8/0xbb0 drivers/tty/tty_io.c:2033
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3412 [inline]
  path_openat+0x10e4/0x4710 fs/namei.c:3529
  do_filp_open+0x1a1/0x280 fs/namei.c:3559
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1110
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x405721
Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 a4 18 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f4718c29980 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 0000000000405721
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00007f4718c299a0
RBP: 00000000006dbc20 R08: 000000000000000f R09: 00007f4718c2a700
R10: 00007f4718c2a9d0 R11: 0000000000000293 R12: 00000000006dbc2c
R13: 00007ffd5b35591f R14: 00007f4718c2a9c0 R15: 000000000000002d

Allocated by task 9774:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:512 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:485
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:526
  kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:670 [inline]
  vc_allocate drivers/tty/vt/vt.c:1085 [inline]
  vc_allocate+0x1fc/0x760 drivers/tty/vt/vt.c:1066
  con_install+0x52/0x410 drivers/tty/vt/vt.c:3229
  tty_driver_install_tty drivers/tty/tty_io.c:1228 [inline]
  tty_init_dev drivers/tty/tty_io.c:1341 [inline]
  tty_init_dev+0xf7/0x460 drivers/tty/tty_io.c:1318
  tty_open_by_driver drivers/tty/tty_io.c:1985 [inline]
  tty_open+0x4a5/0xbb0 drivers/tty/tty_io.c:2033
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3412 [inline]
  path_openat+0x10e4/0x4710 fs/namei.c:3529
  do_filp_open+0x1a1/0x280 fs/namei.c:3559
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1110
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 19636:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  kasan_set_free_info mm/kasan/common.c:334 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:473
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:482
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  vt_disallocate_all+0x2bd/0x3e0 drivers/tty/vt/vt_ioctl.c:323
  vt_ioctl+0xc38/0x26d0 drivers/tty/vt/vt_ioctl.c:816
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2658
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a2b11000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 512 bytes inside of
  2048-byte region [ffff8880a2b11000, ffff8880a2b11800)
The buggy address belongs to the page:
page:ffffea00028ac440 refcount:1 mapcount:0 mapping:ffff8880aa400e00  
index:0x0
raw: 00fffe0000000200 ffffea000288c048 ffffea0002574e48 ffff8880aa400e00
raw: 0000000000000000 ffff8880a2b11000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a2b11100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a2b11180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8880a2b11200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff8880a2b11280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a2b11300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
