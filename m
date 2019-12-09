Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D65C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E15220726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLIE1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 23:27:11 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:40809 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLIE1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:27:10 -0500
Received: by mail-io1-f72.google.com with SMTP id d1so9859970ioe.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 20:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hx1YQCXRjoFEb2pqqCvEj+3QepedTCJ9H4Wrwh4zGQk=;
        b=YplNk+z3p8PVrLF1pyAsYYUeMUE3eCu8VPkIqT4i2D+VvVDll0d8xpmvNarGCjo3p1
         0C80dp5wEEWcg2jk5IiPHLOgbL/Titvgceo5lpgUCV2t5LQfmuRB8AgNjvnaQyXQD72p
         jWIt/0dysBBZrTeqefNLqK7F2GXhvo5PT6xM4Frj7427krD13jOC6WdIU42yZvB/fdKe
         J1vH5wrsHZmK+WGBSr2c4HOUFnH1YZ//VKF8HpkQWejG/qcZbq04NUFhYsYLiH4hu7l8
         TNX7bJHHAx+IZVu6iU/xkh35aHIv+SwVuxpcXsfr+gV0SZHmBTs+zEqwIOVOJtVrjtS2
         JZKg==
X-Gm-Message-State: APjAAAWzD6iXOp+zoSYa9vQd51kN1oud6VSJuBQrxTAq/kI2sCC/irQU
        m1gY/CxA6f1IGA8EBaNl/1WlSPjwsWw82r4VzZJk6U5/+ss7
X-Google-Smtp-Source: APXvYqzijTECTU43qgJSvG2P/wVuvnS2ksHah2Im6nAFln5YkfudkojtJQytrRAY5hPCsA/BTpxbuMYNPpx4vX1WgJTOjBlviwIM
MIME-Version: 1.0
X-Received: by 2002:a6b:7310:: with SMTP id e16mr19924283ioh.107.1575865629997;
 Sun, 08 Dec 2019 20:27:09 -0800 (PST)
Date:   Sun, 08 Dec 2019 20:27:09 -0800
In-Reply-To: <00000000000000ffab05992442a7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017046a05993dcf90@google.com>
Subject: Re: KASAN: global-out-of-bounds Read in fb_pad_aligned_buffer
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

syzbot has found a reproducer for the following crash on:

HEAD commit:    9455d25f Merge tag 'ntb-5.5' of git://github.com/jonmason/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171e09dae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3b8f5088d4043a
dashboard link: https://syzkaller.appspot.com/bug?extid=0568d05e486eee0a1ba2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ddeca6e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16df9e41e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0568d05e486eee0a1ba2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in __fb_pad_aligned_buffer  
include/linux/fb.h:655 [inline]
BUG: KASAN: global-out-of-bounds in fb_pad_aligned_buffer+0x138/0x160  
drivers/video/fbdev/core/fbmem.c:115
Read of size 1 at addr ffffffff8872a77c by task syz-executor208/9953

CPU: 1 PID: 9953 Comm: syz-executor208 Not tainted 5.4.0-syzkaller #0
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
RIP: 0033:0x440269
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff65832458 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440269
RDX: 0000000020000000 RSI: 0000000000004b72 RDI: 0000000000000004
RBP: 00000000006cb018 R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401b50
R13: 0000000000401be0 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the variable:
  oid_index+0x93c/0xb80

Memory state around the buggy address:
  ffffffff8872a600: 04 fa fa fa fa fa fa fa 00 01 fa fa fa fa fa fa
  ffffffff8872a680: 04 fa fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
> ffffffff8872a700: 07 fa fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
                                                                 ^
  ffffffff8872a780: 05 fa fa fa fa fa fa fa 01 fa fa fa fa fa fa fa
  ffffffff8872a800: 00 00 02 fa fa fa fa fa 00 00 00 05 fa fa fa fa
==================================================================

