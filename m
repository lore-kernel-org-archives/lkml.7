Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D485BC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC18205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfLEQqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:46:09 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:45149 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:46:08 -0500
Received: by mail-io1-f69.google.com with SMTP id m18so2740121ioj.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 08:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=el9xpIdcMptmZt2OnW4Sxl4sCoF0ajfl1irtKsZuX1M=;
        b=CSYqNRac9dDrR/8TEMc6LFXKaPeyEGaoLqpcjou8Us0+RPt9Z+hCODCfvhxnZ/Al4P
         7feqRlH9cLio2YpyWnadH7pFe4sKV0fs3lVKTCjjcn720CwmedEkakXcUMjiGkrfgmOy
         9fftmkAf6+UknUYjx0i2WjwpEoeS69vDssqua+61RyTwdbPOcJSe/7BSsVdBxGW9VZXS
         hRnWI98OKHjlhT8AbeXdKgKt/a8IjP6icGHjMf4/SiDHncxR+opDldsRjN4No3QNE5MT
         4N6LcTnRvCNg6ROss98/C71EtH6gn/6JfG28D5N1FNq5yDDaXnIfySkE5pEXiUh5Wd8W
         bb+w==
X-Gm-Message-State: APjAAAV/6WSqv9KLgpasRK4T2wVs3TnfbVsaIMNHxZ0WbvUlcLhTZmbu
        zvoAu6G9JUFS5KFCg0CxBT0Gq9294+MGZRNPy6ZYZQDrW9N2
X-Google-Smtp-Source: APXvYqxTkm9duM6qH7I6yKJ1pgvfZ/bkTv1Xng92UviG67uspy4Vq5S7O7iFUYcs2lvpl7G4PKKu3yrt2jhx2KcHCjrCr0TR5JGS
MIME-Version: 1.0
X-Received: by 2002:a92:45d2:: with SMTP id z79mr9738056ilj.76.1575564368088;
 Thu, 05 Dec 2019 08:46:08 -0800 (PST)
Date:   Thu, 05 Dec 2019 08:46:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b17010598f7aa1f@google.com>
Subject: KASAN: global-out-of-bounds Read in bit_putcs
From:   syzbot <syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com>
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

HEAD commit:    2f13437b Merge tag 'trace-v5.5-2' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104fcc2ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=608557e57ce07817
dashboard link: https://syzkaller.appspot.com/bug?extid=38a3699c7eaf165b97a6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in __fb_pad_aligned_buffer  
include/linux/fb.h:655 [inline]
BUG: KASAN: global-out-of-bounds in bit_putcs_aligned  
drivers/video/fbdev/core/bitblit.c:96 [inline]
BUG: KASAN: global-out-of-bounds in bit_putcs+0xd5d/0xf10  
drivers/video/fbdev/core/bitblit.c:185
Read of size 1 at addr ffffffff88725b0f by task syz-executor.3/14961

CPU: 0 PID: 14961 Comm: syz-executor.3 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:638
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __fb_pad_aligned_buffer include/linux/fb.h:655 [inline]
  bit_putcs_aligned drivers/video/fbdev/core/bitblit.c:96 [inline]
  bit_putcs+0xd5d/0xf10 drivers/video/fbdev/core/bitblit.c:185
  fbcon_putcs+0x33c/0x3e0 drivers/video/fbdev/core/fbcon.c:1353
  do_update_region+0x328/0x6f0 drivers/tty/vt/vt.c:667
  redraw_screen+0x676/0x7d0 drivers/tty/vt/vt.c:1011
  fbcon_do_set_font+0x829/0x960 drivers/video/fbdev/core/fbcon.c:2605
  fbcon_copy_font+0x12c/0x190 drivers/video/fbdev/core/fbcon.c:2620
  con_font_copy drivers/tty/vt/vt.c:4594 [inline]
  con_font_op+0x69a/0x1250 drivers/tty/vt/vt.c:4609
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
RIP: 0033:0x45a679
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8bdf6cfc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
RDX: 0000000020000400 RSI: 0000000000004b72 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8bdf6d06d4
R13: 00000000004c37ab R14: 00000000004d8c38 R15: 00000000ffffffff

The buggy address belongs to the variable:
  oid_index+0x3cf/0xb80

Memory state around the buggy address:
  ffffffff88725a00: 03 fa fa fa fa fa fa fa 03 fa fa fa fa fa fa fa
  ffffffff88725a80: 03 fa fa fa fa fa fa fa 00 07 fa fa fa fa fa fa
> ffffffff88725b00: 00 07 fa fa fa fa fa fa 00 06 fa fa fa fa fa fa
                       ^
  ffffffff88725b80: 06 fa fa fa fa fa fa fa 00 00 00 04 fa fa fa fa
  ffffffff88725c00: 00 00 fa fa fa fa fa fa 00 00 06 fa fa fa fa fa
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
