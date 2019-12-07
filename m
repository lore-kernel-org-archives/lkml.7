Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDCFC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 10:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEB324670
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 10:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfLGKFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 05:05:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:50417 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfLGKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 05:05:09 -0500
Received: by mail-io1-f71.google.com with SMTP id t193so6686680iof.17
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 02:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JpYQV+AWM+mnMWgwQ0nH4DdPd34Sic4MN/MkWFQj1ok=;
        b=O9G2WChemwWe+S8XvX7HjJE/BQFoDu2QWEK9QOMlfnSLPH92v+IYx+RhQfjH7W7hzd
         WClA4NBS/JR8CFkSaunELNLCa7EkM0dbvO3jUPwCAzoq4sECM4tLes5oRSLv236YcRe4
         FlZPm9JEgPUuyP8OcZ94kfynUlpP5noY7TIMz7q6HDzpv3IMjkfwSBEMx4S+9fYBi60y
         w3xHmOlr3lHMhMxwjKfGnwHsF6RnnnhdTR6UTv8OzxzE+nTKAfQMXo9oEIWIAYGvH3Dj
         rdEDrQUadLIWpQZN3+LxTKG7tom9tIraysjf1WVvAFU9l3rmDZ4v4IAriAhSdDVyufTE
         Dc5w==
X-Gm-Message-State: APjAAAVoaIy4JS+3/vMmQPLZXx4yTqebXFj+6nWmWsYAnAbrF2HoblZ+
        VKvwcyS/PpIHncIDhfR0fLkOJmb7mjnwxZoTR5D1mUzl5G91
X-Google-Smtp-Source: APXvYqzeipCOGfynVdwRuYHS6CTvxr6M3Ja8bZMTy9Vq6/49j8ukhkZLP3HZ6Ggn5Cp+1VYLq4VkY96VIrax3nB3P+iXJjEPkjMx
MIME-Version: 1.0
X-Received: by 2002:a5d:8cda:: with SMTP id k26mr14417470iot.26.1575713108600;
 Sat, 07 Dec 2019 02:05:08 -0800 (PST)
Date:   Sat, 07 Dec 2019 02:05:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b2f4605991a4cc0@google.com>
Subject: KASAN: use-after-free Read in fb_mode_is_equal
From:   syzbot <syzbot+f11cda116c57db68c227@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mojha@codeaurora.org,
        shile.zhang@linux.alibaba.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ada90eb Merge tag 'drm-next-2019-12-06' of git://anongit...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16997c82e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f07a23020fd7d21a
dashboard link: https://syzkaller.appspot.com/bug?extid=f11cda116c57db68c227
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f11cda116c57db68c227@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in fb_mode_is_equal+0x297/0x300  
drivers/video/fbdev/core/modedb.c:924
Read of size 4 at addr ffff8880992d5d9c by task syz-executor.0/32283

CPU: 0 PID: 32283 Comm: syz-executor.0 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:134
  fb_mode_is_equal+0x297/0x300 drivers/video/fbdev/core/modedb.c:924
  fbcon_mode_deleted+0x12c/0x190 drivers/video/fbdev/core/fbcon.c:3060
  fb_set_var+0xab9/0xdd0 drivers/video/fbdev/core/fbmem.c:971
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
RIP: 0033:0x45a6f9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7aefd54c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a6f9
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7aefd556d4
R13: 00000000004c2ef7 R14: 00000000004d8138 R15: 00000000ffffffff

Allocated by task 9205:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
  kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
  kmalloc include/linux/slab.h:556 [inline]
  fb_add_videomode drivers/video/fbdev/core/modedb.c:1073 [inline]
  fb_add_videomode+0x2fb/0x610 drivers/video/fbdev/core/modedb.c:1057
  fb_set_var+0x5ef/0xdd0 drivers/video/fbdev/core/fbmem.c:1041
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

Freed by task 32276:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  fb_delete_videomode+0x3fa/0x540 drivers/video/fbdev/core/modedb.c:1104
  fb_set_var+0xac8/0xdd0 drivers/video/fbdev/core/fbmem.c:974
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

The buggy address belongs to the object at ffff8880992d5d80
  which belongs to the cache kmalloc-96 of size 96
The buggy address is located 28 bytes inside of
  96-byte region [ffff8880992d5d80, ffff8880992d5de0)
The buggy address belongs to the page:
page:ffffea000264b540 refcount:1 mapcount:0 mapping:ffff8880aa400540  
index:0x0
raw: 00fffe0000000200 ffffea00025470c8 ffffea0002992508 ffff8880aa400540
raw: 0000000000000000 ffff8880992d5000 0000000100000020 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880992d5c80: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
  ffff8880992d5d00: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
> ffff8880992d5d80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                             ^
  ffff8880992d5e00: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
  ffff8880992d5e80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
