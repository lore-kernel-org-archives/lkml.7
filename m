Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ACBC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 21:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52729206DB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 21:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLGV6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 16:58:10 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:46089 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLGV6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 16:58:09 -0500
Received: by mail-io1-f72.google.com with SMTP id b186so7690557iof.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 13:58:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RCo5XRoCAvBV6cPjpzOdV+7ot6a52yZxOPlkjd6r1r8=;
        b=msKCI8sqdCBI25tBx8Uf+XH7nDZWQqn1J2mVc0mW3Kxg6s3nrZPujgQ0q/JAotR/pe
         b5ReBRDauRL1vWl+D4tP2zHrKqu2GpKCZ2jx+oycmyDEOKanmaQu7p0jClEKvUzelESq
         phXn+wGztx1q5IXglYgHW/ePkweSW189dE04T6nRPGao7HA23PHQ2dHI67iV52iuvjrq
         m9cEe7S9bx+ErG5fKsYFKeCdyHVVyp3uUQutACwRTcMjz6TRDG4NNWr1nfyEM/MlkfDl
         O3oqK3Yk+N2/gofisqp8MWT/t2oeIcJplRxD0UNfxrxanZxeEeOlBhRFjBDUFFEnBE96
         0XQg==
X-Gm-Message-State: APjAAAWd2yb/XQ/ogED1hYkM2gWCXzGD5fyCtvtetWH5ZX+a5ujAq1zi
        nMY9hZAz2hYieSwacOCyBEjQDBDHeMUZzwY6+sEOIyaMJC79
X-Google-Smtp-Source: APXvYqzTwC6BLVBe4iTeHffJKTyH9oDf+MyHBg8QuyYn+xCyOSKtEjf1AGFDNZQheGt1vN2BFejbB3j2pO+wKL+5Ob4hO04t1IV3
MIME-Version: 1.0
X-Received: by 2002:a6b:5a13:: with SMTP id o19mr15354365iob.120.1575755888785;
 Sat, 07 Dec 2019 13:58:08 -0800 (PST)
Date:   Sat, 07 Dec 2019 13:58:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000ffab05992442a7@google.com>
Subject: KASAN: global-out-of-bounds Read in fb_pad_aligned_buffer
From:   syzbot <syzbot+0568d05e486eee0a1ba2@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, kraxel@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, peda@axentia.se,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ad910e36 pipe: fix poll/select race introduced by the pipe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15483196e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=318fa2bff8166d0d
dashboard link: https://syzkaller.appspot.com/bug?extid=0568d05e486eee0a1ba2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0568d05e486eee0a1ba2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in __fb_pad_aligned_buffer  
include/linux/fb.h:655 [inline]
BUG: KASAN: global-out-of-bounds in fb_pad_aligned_buffer+0x138/0x160  
drivers/video/fbdev/core/fbmem.c:115
Read of size 1 at addr ffffffff887274d4 by task syz-executor.2/19900

CPU: 1 PID: 19900 Comm: syz-executor.2 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __fb_pad_aligned_buffer include/linux/fb.h:655 [inline]
  fb_pad_aligned_buffer+0x138/0x160 drivers/video/fbdev/core/fbmem.c:115
  bit_putcs_aligned drivers/video/fbdev/core/bitblit.c:99 [inline]
  bit_putcs+0xd14/0xf10 drivers/video/fbdev/core/bitblit.c:185
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
RIP: 0033:0x45a6f9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe2b58b1c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a6f9
RDX: 0000000020000000 RSI: 0000000000004b72 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe2b58b26d4
R13: 00000000004c382b R14: 00000000004d8d78 R15: 00000000ffffffff

The buggy address belongs to the variable:
  fontdata_8x16+0x1054/0x1120

Memory state around the buggy address:
  ffffffff88727380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffffff88727400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffffffff88727480: fa fa fa fa 06 fa fa fa fa fa fa fa 05 fa fa fa
                                                  ^
  ffffffff88727500: fa fa fa fa 06 fa fa fa fa fa fa fa 00 00 03 fa
  ffffffff88727580: fa fa fa fa 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
