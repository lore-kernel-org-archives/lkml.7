Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8314DC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510A420848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLCUPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:15:23 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:48860 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfLCUPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:15:11 -0500
Received: by mail-io1-f70.google.com with SMTP id e15so3277423ioh.15
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 12:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zCevZTeVVE7Cy63ey9hWglAJ5kSDUzxdLF7IbPjh2y8=;
        b=djXOELJcSSD04GPrG5e6e+nkiRNOzIxk/FRXP072GkomaXiwtSZ+WEt88D6TQG+20N
         n1Z1tSSazvqGqBvC0+0xk4/DVcsbBmRxoCc+4BVu90YzKTDkrfoyipMyi1Bb6ZCQ6vgL
         ntlg1hXws2y+mKfrELP85JoT9jD7OevBtZysVX3NwBvKajtOS9NcmT0SqRh9w2mHZN9L
         xGtCLtF3hXctqo2v++ltOKZr+GPJ2BWmZ++r375QcT0FNgce/EFejCgnF7xdnWQYIyFG
         MoJEdvOAPmd4lFLs2zm9anpHCFvIA7MxqA2ZJi+5VBemDDLDYLCa/kGr3SlgaFslySak
         zqGg==
X-Gm-Message-State: APjAAAXlPVAWfIQxa1Oktmi1UiLvUbWVCZWS3rrQogfBV3G3igqtl0QP
        ESvt4/1ZR2sr/R3MHmZUl+1L6MgmKhmjcboliU+IKIbmQIMB
X-Google-Smtp-Source: APXvYqxN+bBuDU/USTyVLv0bcHB2UvQ80YaHgDncQqblb0lQIWTRquPkiW+oDqN8K3f4SW1iLcZ0gAD6/BYQgBdRDA8pt9q69Ts9
MIME-Version: 1.0
X-Received: by 2002:a92:d38e:: with SMTP id o14mr6759808ilo.238.1575404110517;
 Tue, 03 Dec 2019 12:15:10 -0800 (PST)
Date:   Tue, 03 Dec 2019 12:15:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000629fe20598d25a64@google.com>
Subject: KASAN: global-out-of-bounds Read in vga16fb_imageblit
From:   syzbot <syzbot+69fbd3e01470f169c8c4@syzkaller.appspotmail.com>
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

HEAD commit:    596cf45c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17be842ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8ab2e0e09c2a82
dashboard link: https://syzkaller.appspot.com/bug?extid=69fbd3e01470f169c8c4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159c2861e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b5d59ce00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161f2cdee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=111f2cdee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+69fbd3e01470f169c8c4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in vga_8planes_imageblit  
drivers/video/fbdev/vga16fb.c:1140 [inline]
BUG: KASAN: global-out-of-bounds in vga_imageblit_expand  
drivers/video/fbdev/vga16fb.c:1203 [inline]
BUG: KASAN: global-out-of-bounds in vga16fb_imageblit+0x1c8b/0x2200  
drivers/video/fbdev/vga16fb.c:1260
Read of size 2 at addr ffffffff8874be58 by task syz-executor421/8988

CPU: 0 PID: 8988 Comm: syz-executor421 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:638
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/generic_report.c:133
  vga_8planes_imageblit drivers/video/fbdev/vga16fb.c:1140 [inline]
  vga_imageblit_expand drivers/video/fbdev/vga16fb.c:1203 [inline]
  vga16fb_imageblit+0x1c8b/0x2200 drivers/video/fbdev/vga16fb.c:1260
  soft_cursor+0x4fb/0xa30 drivers/video/fbdev/core/softcursor.c:74
  bit_cursor+0x12fc/0x1a60 drivers/video/fbdev/core/bitblit.c:386
  fbcon_cursor+0x487/0x660 drivers/video/fbdev/core/fbcon.c:1402
  hide_cursor+0x9d/0x2b0 drivers/tty/vt/vt.c:895
  redraw_screen+0x60b/0x7d0 drivers/tty/vt/vt.c:988
  vc_do_resize+0x10c9/0x1460 drivers/tty/vt/vt.c:1284
  vc_resize+0x4d/0x60 drivers/tty/vt/vt.c:1304
  fbcon_modechanged+0x367/0x790 drivers/video/fbdev/core/fbcon.c:2980
  fbcon_update_vcs+0x42/0x50 drivers/video/fbdev/core/fbcon.c:3038
  fb_set_var+0xb32/0xdd0 drivers/video/fbdev/core/fbmem.c:1051
  do_fb_ioctl+0x390/0x7d0 drivers/video/fbdev/core/fbmem.c:1104
  fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:539 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:726
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:743
  __do_sys_ioctl fs/ioctl.c:750 [inline]
  __se_sys_ioctl fs/ioctl.c:748 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:748
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440309
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe5b970878 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440309
RDX: 0000000020000100 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401b90
R13: 0000000000401c20 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the variable:
  transl_h+0x38/0x40

Memory state around the buggy address:
  ffffffff8874bd00: 00 00 00 00 fa fa fa fa 00 00 00 00 fa fa fa fa
  ffffffff8874bd80: 00 00 00 00 00 fa fa fa fa fa fa fa 04 fa fa fa
> ffffffff8874be00: fa fa fa fa 00 00 00 00 fa fa fa fa 00 00 00 00
                                                     ^
  ffffffff8874be80: fa fa fa fa 00 01 fa fa fa fa fa fa 00 00 00 04
  ffffffff8874bf00: fa fa fa fa 00 00 04 fa fa fa fa fa 00 00 00 00
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
