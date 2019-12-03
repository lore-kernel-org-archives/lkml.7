Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C8C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E32206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLCUPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:15:11 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:43435 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfLCUPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:15:11 -0500
Received: by mail-il1-f198.google.com with SMTP id m67so3861930ill.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 12:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Pue02FOaz9B94iZW14Zm2/cxpNZUlGg6/qt07Z8vp88=;
        b=sgV948d0IUg2McDDYiXYbG4HCeT+vkAtRKkh+iBtQd3z8nCjtjJBAw1PIDdsAQSE+5
         JEuNISHnX+OZBxx3GOaXMOB2rPOuNdidSAiC5IRJR6ZeihjlTfneCwum2NmabajFp+A8
         Hb66kyEZaUrW0HLw/OpY8Mt17GtaxHlWEQ0rgbTsMk8cztDEohl5ugDphMSurpkJsMUa
         +DDrfR/4mWKUecpwBJ649KCRATi2e1Rh2BJe+fGlyepbyzznzq00iu9bgbZVspSyiJcu
         Fkj+E3zjLpbNUfOggJRW9wf0ws/DrlvKGWr5y/Xn+bIzSBg1qQyGPQB1QymHFSdV47bL
         2vlQ==
X-Gm-Message-State: APjAAAVazxEap0GcRcJLir/+Ie03FznIB9IZy0Mc9Xz9N4t0JAiDjfXD
        zsoGofZHpaY3iz8EFiqhMtId+/d8OCpbasQK/J9xlO84EdvV
X-Google-Smtp-Source: APXvYqws6xi2B1+4NCkuEWX6Mfm4KJDXcnVYEFRpf2JbNLt7dl4EO6ZEh7ULW+EexVcyWTKKlU3NVcQ70tzrZu4gGbaQTaFJwy4j
MIME-Version: 1.0
X-Received: by 2002:a6b:5503:: with SMTP id j3mr3745725iob.142.1575404110313;
 Tue, 03 Dec 2019 12:15:10 -0800 (PST)
Date:   Tue, 03 Dec 2019 12:15:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f7f920598d25a5f@google.com>
Subject: KASAN: slab-out-of-bounds Read in vcs_scr_readw
From:   syzbot <syzbot+7d027845265d531ba506@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, dave@mielke.cc, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com, kilobyte@angband.pl,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, nico@linaro.org,
        nicolas.pitre@linaro.org, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de,
        tomli@tomli.me
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    596cf45c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c1d196e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8eb54eee6e6ca4a7
dashboard link: https://syzkaller.appspot.com/bug?extid=7d027845265d531ba506
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c6090ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13821b7ae00000

The bug was bisected to:

commit d21b0be246bf3bbf569e6e239f56abb529c7154e
Author: Nicolas Pitre <nicolas.pitre@linaro.org>
Date:   Wed Jun 27 03:56:41 2018 +0000

     vt: introduce unicode mode for /dev/vcs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1292fbf2e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1192fbf2e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1692fbf2e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7d027845265d531ba506@syzkaller.appspotmail.com
Fixes: d21b0be246bf ("vt: introduce unicode mode for /dev/vcs")

==================================================================
BUG: KASAN: slab-out-of-bounds in vcs_scr_readw+0xc2/0xd0  
drivers/tty/vt/vt.c:4665
Read of size 2 at addr ffff8882192c52c0 by task syz-executor391/9679

CPU: 0 PID: 9679 Comm: syz-executor391 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:638
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/generic_report.c:133
  vcs_scr_readw+0xc2/0xd0 drivers/tty/vt/vt.c:4665
  vcs_write+0x646/0xcf0 drivers/tty/vt/vc_screen.c:545
  __vfs_write+0x8a/0x110 fs/read_write.c:494
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444399
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe50ca6938 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffe50ca6940 RCX: 0000000000444399
RDX: 00000000fffffecb RSI: 0000000020000300 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000400c60
R10: 00007ffe50ca6480 R11: 0000000000000246 R12: 00000000004020a0
R13: 0000000000402130 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 1:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:512 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:485
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:526
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3665
  kmalloc include/linux/slab.h:561 [inline]
  kzalloc include/linux/slab.h:670 [inline]
  vc_do_resize+0x262/0x1460 drivers/tty/vt/vt.c:1187
  vc_resize+0x4d/0x60 drivers/tty/vt/vt.c:1304
  fbcon_init+0x122d/0x1a90 drivers/video/fbdev/core/fbcon.c:1212
  visual_init+0x30a/0x5e0 drivers/tty/vt/vt.c:1051
  do_bind_con_driver+0x54c/0x8b0 drivers/tty/vt/vt.c:3532
  do_take_over_console+0x449/0x5a0 drivers/tty/vt/vt.c:4113
  do_fbcon_takeover+0x116/0x220 drivers/video/fbdev/core/fbcon.c:581
  fbcon_fb_registered+0x275/0x340 drivers/video/fbdev/core/fbcon.c:3252
  do_register_framebuffer drivers/video/fbdev/core/fbmem.c:1652 [inline]
  register_framebuffer+0x5c3/0xa10 drivers/video/fbdev/core/fbmem.c:1821
  vga16fb_probe+0x711/0x825 drivers/video/fbdev/vga16fb.c:1373
  platform_drv_probe+0x8d/0x140 drivers/base/platform.c:725
  really_probe+0x291/0x710 drivers/base/dd.c:548
  driver_probe_device+0x110/0x220 drivers/base/dd.c:721
  __device_attach_driver+0x1c9/0x230 drivers/base/dd.c:828
  bus_for_each_drv+0x172/0x1f0 drivers/base/bus.c:430
  __device_attach+0x237/0x390 drivers/base/dd.c:894
  device_initial_probe+0x1b/0x20 drivers/base/dd.c:941
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:490
  device_add+0x14fe/0x1d00 drivers/base/core.c:2487
  platform_device_add+0x34d/0x6c0 drivers/base/platform.c:562
  vga16fb_init+0x15f/0x1d6 drivers/video/fbdev/vga16fb.c:1431
  do_one_initcall+0x120/0x81a init/main.c:938
  do_initcall_level init/main.c:1006 [inline]
  do_initcalls init/main.c:1014 [inline]
  do_basic_setup init/main.c:1031 [inline]
  kernel_init_freeable+0x4ca/0x5b9 init/main.c:1191
  kernel_init+0x12/0x1bf init/main.c:1109
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8882192c4000
  which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4800 bytes inside of
  8192-byte region [ffff8882192c4000, ffff8882192c6000)
The buggy address belongs to the page:
page:ffffea000864b100 refcount:1 mapcount:0 mapping:ffff8880aa4021c0  
index:0x0 compound_mapcount: 0
raw: 057ffe0000010200 ffffea000864ae08 ffffea000863fe08 ffff8880aa4021c0
raw: 0000000000000000 ffff8882192c4000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8882192c5180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8882192c5200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8882192c5280: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                            ^
  ffff8882192c5300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8882192c5380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
