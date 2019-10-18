Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF6CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEC621925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442834AbfJROML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:12:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:45356 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633995AbfJROMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:12:10 -0400
Received: by mail-io1-f71.google.com with SMTP id o11so8550471iop.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 07:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5yCmFFCNwZIVuOXwBYfOHVhttIY56VXt7JCRrc0MY0w=;
        b=FaHBxl6vEfO2USH/uD0ZmbNd+rCyTVpjcHbXOJgiYpxs/k4E/pvD67Klw0BfKdswBb
         2BqgOHMuMldizGq2/rkFE9WiZMRDRTbAQBf27dlbVKG62+M6aflbGxvQ4uAo7xVCvpzb
         +YR1+NjGj2Os6IV3QHU4RKWTwfl1e7WVdq2E2LAvs1D1BPN0TPFNIVOwE4H3D74PXmMi
         WLKjgXdtx6P1IifBpZCJbp8IjixgxCKyzi47oRUuT/XDLwAHt9r2PBewiMCBEAJrqJ75
         1iVwS/a1DRuCEyN+7OuywiyLpfRlEZAoXumX8zqbV2zd+9ZrCsPZcEHqTeCBliZgxLsC
         3nuQ==
X-Gm-Message-State: APjAAAX0//e7xplnPu0vqrKxiV4xbIVAOMN/JRfkZFThFxxWpnw+oO6Q
        6Q+VFjQcAYT5yT3eUDvxUUjQJW+CRd3+7uR5Dxs1GmI6Hge2
X-Google-Smtp-Source: APXvYqwKWDtHFHorcfIAgzNqxIQA27cxz8O8vDgB8Uuye1OLa+CrJpVgd/Hq7HqMal1hrgUZ1yR/B4VNFv8jv2i8s0HifwrgzkBu
MIME-Version: 1.0
X-Received: by 2002:a6b:f90f:: with SMTP id j15mr8844986iog.257.1571407929608;
 Fri, 18 Oct 2019 07:12:09 -0700 (PDT)
Date:   Fri, 18 Oct 2019 07:12:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000710f7405952febe3@google.com>
Subject: WARNING in gtco_input_open/usb_submit_urb
From:   syzbot <syzbot+904b0592f03cbe5fd6cb@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    22be26f7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=17f9f0cf600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
dashboard link: https://syzkaller.appspot.com/bug?extid=904b0592f03cbe5fd6cb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+904b0592f03cbe5fd6cb@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 2-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 15719 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 15719 Comm: syz-executor.0 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x2aa/0x6e1 kernel/panic.c:221
  __warn.cold+0x2f/0x33 kernel/panic.c:582
  report_bug+0x27b/0x2f0 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 48 59 ec fd 4c 89 f7 e8 00 7f 1c ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 20 45 18 86 e8 0d 02 c2 fd <0f> 0b e9 20 f4  
ff ff e8 1c 59 ec fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881cf18f878 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000018cbe RSI: ffffffff8128bcbd RDI: ffffed1039e31f01
RBP: ffff8881d16ef780 R08: ffff8881d16b8000 R09: ffffed103b645d58
R10: ffffed103b645d57 R11: ffff8881db22eabf R12: 0000000000000001
R13: ffff8881cbbacfc0 R14: ffff8881d9b470a0 R15: ffff8881d3c8ef00
  gtco_input_open+0xd5/0x130 drivers/input/tablet/gtco.c:560
  input_open_device+0x16c/0x2c0 drivers/input/input.c:623
  evdev_open_device drivers/input/evdev.c:414 [inline]
  evdev_open+0x3fe/0x510 drivers/input/evdev.c:499
  chrdev_open+0x219/0x5c0 fs/char_dev.c:414
  do_dentry_open+0x494/0x1120 fs/open.c:797
  do_last fs/namei.c:3408 [inline]
  path_openat+0x1430/0x3ff0 fs/namei.c:3525
  do_filp_open+0x1a1/0x280 fs/namei.c:3555
  do_sys_open+0x3c0/0x580 fs/open.c:1097
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x413941
Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48  
83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f01879317a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 0000000000413941
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f0187931850
RBP: 000000000075bfc8 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f01879326d4
R13: 00000000004c90c0 R14: 00000000004e06b8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
