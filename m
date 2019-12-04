Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264D1C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71EF2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfLDQcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:32:08 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:44653 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbfLDQcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:32:08 -0500
Received: by mail-il1-f200.google.com with SMTP id h87so115241ild.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:32:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=attlcnJZfQz5huvDfutvGGLNdSlinmCfWkUddLr0dFw=;
        b=W0ZCQgDM+BQ2hR99PSgIdzlULU9cgvhUuDGDHaNFACorif8YTBANzSYsqKN4Gz6ecK
         Mtgcdah+f/TdtU27y1MdLlsIjo3FFmziIwqc2Ei/JYonz1ZZ6G7P2VtscHjwIG3R1EiW
         6kLxL+Zlv9jG1jbvgrk54JZaUWZfeZ/yku7jiCw2rAhOeioJN11+0ugrFHucty9fMdnd
         aYv4vnB2dlsUP41bwaW7QA2cyb7JadbdDPeu417L2mR37YPxN7/PpVf7DuquC6Ufa/Oh
         wwSVcMxgSh9WOtgcoHhpY4HoHiN/hTyzc3xrVs6TMo0hAC4qfTge0CVfez+AmOLDLwmQ
         ybAA==
X-Gm-Message-State: APjAAAWpuXAjhrQiRJ7UWtdjicAI1G0PEa/yZWaepSbK4t9EEufX5XWM
        yqh7N3fwToEfE72B8/+4HHqJpgtRmNQTtYSQpuqrNqxBn/1d
X-Google-Smtp-Source: APXvYqxip4RWhBwkubn43oGa4ibqwnhMglAFnXQJ0wOOlSsHVvMUqC6/dCNIz3eDmFRU4I+wHBCdfgS2TgFbEHtJhvJ83UwvMqXu
MIME-Version: 1.0
X-Received: by 2002:a92:5bdd:: with SMTP id c90mr4547173ilg.78.1575477127358;
 Wed, 04 Dec 2019 08:32:07 -0800 (PST)
Date:   Wed, 04 Dec 2019 08:32:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008731130598e35a2e@google.com>
Subject: KASAN: slab-out-of-bounds Read in soft_cursor
From:   syzbot <syzbot+16469b5e8e5a72e9131e@syzkaller.appspotmail.com>
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

HEAD commit:    63de3747 Merge tag 'tag-chrome-platform-for-v5.5' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14819aeae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d189d07c6717979
dashboard link: https://syzkaller.appspot.com/bug?extid=16469b5e8e5a72e9131e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+16469b5e8e5a72e9131e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:380 [inline]
BUG: KASAN: slab-out-of-bounds in soft_cursor+0x439/0xa30  
drivers/video/fbdev/core/softcursor.c:70
Read of size 9 at addr ffff888094efeaf2 by task syz-executor.2/30416

CPU: 0 PID: 30416 Comm: syz-executor.2 Not tainted 5.4.0-syzkaller #0
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
  memcpy+0x24/0x50 mm/kasan/common.c:124
  memcpy include/linux/string.h:380 [inline]
  soft_cursor+0x439/0xa30 drivers/video/fbdev/core/softcursor.c:70
  bit_cursor+0x12fc/0x1a60 drivers/video/fbdev/core/bitblit.c:386
  fbcon_cursor+0x487/0x660 drivers/video/fbdev/core/fbcon.c:1402
  hide_cursor+0x9d/0x2b0 drivers/tty/vt/vt.c:895
  redraw_screen+0x60b/0x7d0 drivers/tty/vt/vt.c:988
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
RSP: 002b:00007f25945c0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
RDX: 00000000200002c0 RSI: 000000000000560a RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25945c16d4
R13: 00000000004c6ce2 R14: 00000000004dd2d0 R15: 00000000ffffffff

Allocated by task 18150:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:512 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:485
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:526
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3665
  kmalloc include/linux/slab.h:561 [inline]
  fbcon_set_font+0x32d/0x860 drivers/video/fbdev/core/fbcon.c:2663
  con_font_set drivers/tty/vt/vt.c:4538 [inline]
  con_font_op+0xe18/0x1250 drivers/tty/vt/vt.c:4603
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

Freed by task 17018:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  kasan_set_free_info mm/kasan/common.c:334 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:473
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:482
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  free_bprm+0x198/0x200 fs/exec.c:1433
  __do_execve_file.isra.0+0x1abd/0x22b0 fs/exec.c:1831
  do_execveat_common fs/exec.c:1867 [inline]
  do_execve fs/exec.c:1884 [inline]
  __do_sys_execve fs/exec.c:1960 [inline]
  __se_sys_execve fs/exec.c:1955 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1955
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888094efe800
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 242 bytes to the right of
  512-byte region [ffff888094efe800, ffff888094efea00)
The buggy address belongs to the page:
page:ffffea000253bf80 refcount:1 mapcount:0 mapping:ffff8880aa400a80  
index:0xffff888094efe400
raw: 00fffe0000000200 ffffea0002634fc8 ffffea000287f088 ffff8880aa400a80
raw: ffff888094efe400 ffff888094efe000 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888094efe980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888094efea00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff888094efea80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                              ^
  ffff888094efeb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888094efeb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
