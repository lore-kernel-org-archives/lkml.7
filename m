Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9EDC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B33C21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfLSI2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:28:09 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:47111 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:28:08 -0500
Received: by mail-io1-f70.google.com with SMTP id 13so3220958iof.14
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 00:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fqkWL8EI1zyK4tpnX64Dq29CZfgLj03briSrWgZ8kTM=;
        b=ZhFTMqmlvJ0AdQGvg62psxuPdXP95+e03Y7qrUCLZijtrsIzbivvd+szYK8R2Pvqm9
         WCMIZ0vxpekVWIPQUHE9ob6YaaJRRw61YBmA40OxTd8KB2PlX61og58Inkz++vbqQJY0
         oPSKSTSXsVtBvr4mBcmWeoyt39uYitiDejlYEnDvYVjeYc9qhgG0fBTPEzwAqUt776Ar
         XG+kPqXN/r3chmZLsSsS3fIL5nrpkbZRPdyF/1/tKG6a/C/Y7ndiKRKkWpauwV+6Qs0B
         gPC6sj7FV47s2K0fSggyqsPTfuOFp63epzZgIy1zVRgriZayRpIN0kl+04cC3EdN2+vE
         4CrQ==
X-Gm-Message-State: APjAAAVlBiBUamoVVYytON51FRGRaqPawMJtV0uoSiGSl7QaNlB48uQv
        zZQ505kfpi2DWmYQp0jqP77lWrZxmMz4JYW4brS7Vsq5m+MU
X-Google-Smtp-Source: APXvYqz3Aq8yEmiZ1zpwCGmedPUoUrWCCEvlcBilERyTecAgORobcNJG3JXXJmWM4H/TWwlJOYpVovpF14XMKFDeGIkVJgY6XInc
MIME-Version: 1.0
X-Received: by 2002:a02:780f:: with SMTP id p15mr6080406jac.91.1576744088022;
 Thu, 19 Dec 2019 00:28:08 -0800 (PST)
Date:   Thu, 19 Dec 2019 00:28:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044bcb8059a0a577e@google.com>
Subject: KASAN: slab-out-of-bounds Read in vc_do_resize
From:   syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2187f215 Merge tag 'for-5.5-rc2-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b0f2fee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ab2ae0615387ef78
dashboard link: https://syzkaller.appspot.com/bug?extid=c37a14770d51a085a520
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:380 [inline]
BUG: KASAN: slab-out-of-bounds in scr_memcpyw include/linux/vt_buffer.h:49  
[inline]
BUG: KASAN: slab-out-of-bounds in vc_do_resize+0x959/0x1460  
drivers/tty/vt/vt.c:1250
Read of size 2 at addr ffff8880a284cd8c by task syz-executor.0/13609

CPU: 1 PID: 13609 Comm: syz-executor.0 Not tainted 5.5.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memcpy+0x24/0x50 mm/kasan/common.c:125
  memcpy include/linux/string.h:380 [inline]
  scr_memcpyw include/linux/vt_buffer.h:49 [inline]
  vc_do_resize+0x959/0x1460 drivers/tty/vt/vt.c:1250
  vc_resize+0x4d/0x60 drivers/tty/vt/vt.c:1304
  fbcon_modechanged+0x367/0x790 drivers/video/fbdev/core/fbcon.c:2980
  fbcon_update_vcs+0x42/0x50 drivers/video/fbdev/core/fbcon.c:3038
  fb_set_var+0xb32/0xdd0 drivers/video/fbdev/core/fbmem.c:1051
  do_fb_ioctl+0x390/0x7d0 drivers/video/fbdev/core/fbmem.c:1104
  fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a919
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe4a3fd6c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a919
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe4a3fd76d4
R13: 00000000004c310d R14: 00000000004d8478 R15: 00000000ffffffff

Allocated by task 13609:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3665
  kmalloc include/linux/slab.h:561 [inline]
  kzalloc include/linux/slab.h:670 [inline]
  vc_do_resize+0x262/0x1460 drivers/tty/vt/vt.c:1187
  vc_resize+0x4d/0x60 drivers/tty/vt/vt.c:1304
  fbcon_modechanged+0x367/0x790 drivers/video/fbdev/core/fbcon.c:2980
  fbcon_update_vcs+0x42/0x50 drivers/video/fbdev/core/fbcon.c:3038
  fb_set_var+0xb32/0xdd0 drivers/video/fbdev/core/fbmem.c:1051
  fbcon_resize+0x6b1/0x780 drivers/video/fbdev/core/fbcon.c:2222
  resize_screen drivers/tty/vt/vt.c:1126 [inline]
  vc_do_resize+0x440/0x1460 drivers/tty/vt/vt.c:1205
  vc_resize+0x4d/0x60 drivers/tty/vt/vt.c:1304
  fbcon_modechanged+0x367/0x790 drivers/video/fbdev/core/fbcon.c:2980
  fbcon_update_vcs+0x42/0x50 drivers/video/fbdev/core/fbcon.c:3038
  fb_set_var+0xb32/0xdd0 drivers/video/fbdev/core/fbmem.c:1051
  do_fb_ioctl+0x390/0x7d0 drivers/video/fbdev/core/fbmem.c:1104
  fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 13273:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  tomoyo_path_perm+0x389/0x430 security/tomoyo/file.c:840
  tomoyo_path_symlink+0xaa/0xf0 security/tomoyo/tomoyo.c:206
  security_path_symlink+0x10a/0x170 security/security.c:1053
  do_symlinkat+0x137/0x290 fs/namei.c:4156
  __do_sys_symlink fs/namei.c:4177 [inline]
  __se_sys_symlink fs/namei.c:4175 [inline]
  __x64_sys_symlink+0x59/0x80 fs/namei.c:4175
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a284cd80
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 12 bytes inside of
  32-byte region [ffff8880a284cd80, ffff8880a284cda0)
The buggy address belongs to the page:
page:ffffea00028a1300 refcount:1 mapcount:0 mapping:ffff8880aa4001c0  
index:0xffff8880a284cfc1
raw: 00fffe0000000200 ffffea00025a5ac8 ffffea0002a010c8 ffff8880aa4001c0
raw: ffff8880a284cfc1 ffff8880a284c000 0000000100000037 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a284cc80: 06 fc fc fc fc fc fc fc 06 fc fc fc fc fc fc fc
  ffff8880a284cd00: 06 fc fc fc fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8880a284cd80: 00 04 fc fc fc fc fc fc 06 fc fc fc fc fc fc fc
                       ^
  ffff8880a284ce00: 06 fc fc fc fc fc fc fc 06 fc fc fc fc fc fc fc
  ffff8880a284ce80: 06 fc fc fc fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
