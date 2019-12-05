Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DA1C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E4920707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfLEGcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 01:32:09 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:43799 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfLEGcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:32:08 -0500
Received: by mail-io1-f72.google.com with SMTP id b17so1714985ioh.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 22:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gFm1gwUBe3aCgV86v6LWZ9hjXuYSquYhbKNTONEAZTg=;
        b=NTPiBACMwecK1ualrfg6u25icux7fzoqpIKc0ZjXZtpeBRDTNcKR/wCAbrUGCil7tn
         E42ENxbxOe4aTROs3vbnXQ6kEBjnoXySbGpd2G7nZ5P/WaX1oeF5Zo6ie9xA/n1FvLJH
         G8G3nv1GLYNTtH7mt0EtyO/hkAuDV1mFWuxLAVf+fHYXDgsXjtRbunxv5pECx0EJ1qWk
         0XT3GIzWtW0cTplntLagH9vyalyaefEDu6dJ8VTGeoazLF1jqTtk1FvSgMIVb4j6QeBq
         P+zjhlQoa6Ntpwe0Po28C+KKuac4Lla/8XsjZsHaKCszy/pd6PwAnRglY+EFC97FJ+LJ
         4QfA==
X-Gm-Message-State: APjAAAU4ADfiaZ86WrgsxwuklJdaDJ4MN4hzWYax/yG9Euve5mghSOOs
        waevNyXZdyUg09PnJC0qEzWRsSZDMOT2ILV7PC/SffLjN+Po
X-Google-Smtp-Source: APXvYqxQQwL/9K+MlUOghBiyJ/HODZZ+EZ24A0kMBBi2MlWWUzTliZxJ8mnm6quXBgQishvvvlTIOO/1XfndCqccGX1zpuvagG+2
MIME-Version: 1.0
X-Received: by 2002:a92:ca8b:: with SMTP id t11mr7760516ilo.227.1575527528013;
 Wed, 04 Dec 2019 22:32:08 -0800 (PST)
Date:   Wed, 04 Dec 2019 22:32:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4293f0598ef165e@google.com>
Subject: KASAN: vmalloc-out-of-bounds Write in bitfill_aligned
From:   syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1040fc41e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d189d07c6717979
dashboard link: https://syzkaller.appspot.com/bug?extid=e5fd3e65515b48c02a30
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in bitfill_aligned  
drivers/video/fbdev/core/sysfillrect.c:54 [inline]
BUG: KASAN: vmalloc-out-of-bounds in bitfill_aligned+0x356/0x410  
drivers/video/fbdev/core/sysfillrect.c:25
Write of size 8 at addr ffffc90008b11000 by task syz-executor.2/9476

CPU: 2 PID: 9476 Comm: syz-executor.2 Not tainted 5.4.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS  
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:638
  __asan_report_store8_noabort+0x17/0x20 mm/kasan/generic_report.c:140
  bitfill_aligned drivers/video/fbdev/core/sysfillrect.c:54 [inline]
  bitfill_aligned+0x356/0x410 drivers/video/fbdev/core/sysfillrect.c:25
  sys_fillrect+0x421/0x7c0 drivers/video/fbdev/core/sysfillrect.c:291
  drm_fb_helper_sys_fillrect+0x21/0x190 drivers/gpu/drm/drm_fb_helper.c:736
  bit_clear_margins+0x30b/0x530 drivers/video/fbdev/core/bitblit.c:232
  fbcon_clear_margins+0x1e9/0x250 drivers/video/fbdev/core/fbcon.c:1372
  fbcon_switch+0xd7f/0x17f0 drivers/video/fbdev/core/fbcon.c:2354
  redraw_screen+0x2b6/0x7d0 drivers/tty/vt/vt.c:997
  fbcon_modechanged+0x5c3/0x790 drivers/video/fbdev/core/fbcon.c:2991
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
RIP: 0033:0x45a759
Code: bd b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8280324c88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000072bf00 RCX: 000000000045a759
RDX: 0000000020000040 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f82803256d4
R13: 00000000004a9e78 R14: 00000000006ec2d8 R15: 00000000ffffffff


Memory state around the buggy address:
  ffffc90008b10f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffc90008b10f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffffc90008b11000: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                    ^
  ffffc90008b11080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc90008b11100: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
