Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE35C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A0A218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfLRTVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:21:11 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:34647 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfLRTVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:21:10 -0500
Received: by mail-il1-f200.google.com with SMTP id l13so2616276ils.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=n2kmFkrO2Fl4Mt9INtammdTbVZKbvsHZ8UEpxG9JSV0=;
        b=hrEq5yx4peeOK3kRfTsatWq9MTLwzA1tIJY/oVA6eDMlORQrluksHBDjQImFrmMXih
         R+97tLHEn20elMYSGfaK9DkxroSVRybXeRkS220MB/dkgUEoyadGhW0w0YiPhxIeOSrc
         BsgTANfMt1dJ73MAW+UKnKKYeI+ow7McthW3O8RDAFJt0/LO0/kM1UCi0wyOPPctsEma
         5URW89qUOHcVmG919+0v1/xqQxq3whRqDGvnuNAdCUDTMrfctU5kMfPpzBrXLgDx3AAW
         t9ITzygy2tB0NGWbjsV8iXNFeE7TW4ZCfwpgFlkowFXlNKuR407hPsM+MBbn+Ju41G8L
         4qdA==
X-Gm-Message-State: APjAAAUsQ/fnOCic8N3xKXI6Nuvu0Qr5n7AJR8MTtI+C8k/RyEGjPaqR
        NcRYUMLsSnUYxS/180nFgJlfZX9MQ8Q2KjAYxcaQRMn31OfC
X-Google-Smtp-Source: APXvYqwv37kieSEY1XpJzRAVlB2SXGA7ZNj/oy/PIK34ClIBHpiiyf2GGtVUZWeEjNO1B0eIs1ZlFyfOv/kY6kr48JiZAQYQiX7r
MIME-Version: 1.0
X-Received: by 2002:a02:13c2:: with SMTP id 185mr3876431jaz.0.1576696869784;
 Wed, 18 Dec 2019 11:21:09 -0800 (PST)
Date:   Wed, 18 Dec 2019 11:21:09 -0800
In-Reply-To: <0000000000007b17010598f7aa1f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d794080599ff586a@google.com>
Subject: Re: KASAN: global-out-of-bounds Read in bit_putcs
From:   syzbot <syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    b9c5ef25 Add linux-next specific files for 20191218
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17d57b46e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2eb13492323f151f
dashboard link: https://syzkaller.appspot.com/bug?extid=38a3699c7eaf165b97a6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ce1f2ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125727dee00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12caa5b6e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11caa5b6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16caa5b6e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in __fb_pad_aligned_buffer  
include/linux/fb.h:654 [inline]
BUG: KASAN: global-out-of-bounds in bit_putcs_aligned  
drivers/video/fbdev/core/bitblit.c:96 [inline]
BUG: KASAN: global-out-of-bounds in bit_putcs+0xd5d/0xf10  
drivers/video/fbdev/core/bitblit.c:185
Read of size 1 at addr ffffffff8872bb44 by task syz-executor093/14101

CPU: 1 PID: 14101 Comm: syz-executor093 Not tainted  
5.5.0-rc2-next-20191218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __fb_pad_aligned_buffer include/linux/fb.h:654 [inline]
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
RIP: 0033:0x449c49
Code: e8 7c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b 05 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa99f42ace8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006e6a38 RCX: 0000000000449c49
RDX: 0000000020000000 RSI: 0000000000004b72 RDI: 0000000000000004
RBP: 00000000006e6a30 R08: 00007fa99f42b700 R09: 0000000000000000
R10: 00007fa99f42b700 R11: 0000000000000246 R12: 00000000006e6a3c
R13: 00007ffe46ffe5df R14: 00007fa99f42b9c0 R15: 20c49ba5e353f7cf

The buggy address belongs to the variable:
  __func__.44397+0x104/0x1c0

Memory state around the buggy address:
  ffffffff8872ba00: 00 00 00 00 fa fa fa fa 00 03 fa fa fa fa fa fa
  ffffffff8872ba80: 00 01 fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
> ffffffff8872bb00: 04 fa fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
                                            ^
  ffffffff8872bb80: 04 fa fa fa fa fa fa fa 07 fa fa fa fa fa fa fa
  ffffffff8872bc00: 04 fa fa fa fa fa fa fa 00 00 01 fa fa fa fa fa
==================================================================

