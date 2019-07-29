Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25A6C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C86521655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbfG2LsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:48:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46838 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387717AbfG2LsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:48:06 -0400
Received: by mail-io1-f70.google.com with SMTP id s83so67272496iod.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 04:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=10YzApYX/avNXF6ZFt6vid0PEZbfySrLNEEQGc5K4jg=;
        b=tvssJlGIdbcKIc3Sm9Lvh1oqNalszsQ9qSDetn+PeS++sI+3rA0FdWY8fFrOHX2F6U
         jsRj9y/2BLcU8AGgbcTkcD8D8z9CLTQLaXUXkK7/iO+nIyMDR3qffGoFASRLo8KRBFIi
         QgXkIXBIghFrDy7Ao0oDniCTAdZa91VoP7A+6ojoPxKlbPST9KNb7MSZ/MZyOnNUVlDZ
         CEUNW+D5W0UTWHkUnBxXPJYyLlQMMIocOZQNa9OaqaKQcYVFW71SDCBxrLLskipgWn+Q
         FlissBg7kTeZruGFiTD/fGE3yDQfUp5/hv+4aJYr2Xq1jOOedQOuutlw0XVhv3mXY/RP
         0+MA==
X-Gm-Message-State: APjAAAV7iT4SiranbaKaOCuiAD+brISYWmspV48V0Uhatd9SXhg3HIvy
        3fifjrCZ+PQOktsqMJvqN1SGHKFxhZRdEBdwiUgjWNXPsqiT
X-Google-Smtp-Source: APXvYqxxWdOUcOlusGz8LpB0MiCo7q2JuSFiVdDcfXEXlqmNxf928J2k3JEod2y5bBvt8GJWPL8xdfAfdFTuM4CSJdDQpnlXFZlO
MIME-Version: 1.0
X-Received: by 2002:a02:a595:: with SMTP id b21mr19416107jam.28.1564400885829;
 Mon, 29 Jul 2019 04:48:05 -0700 (PDT)
Date:   Mon, 29 Jul 2019 04:48:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000161dc3058ed0777c@google.com>
Subject: WARNING in usbhid_raw_request/usb_submit_urb
From:   syzbot <syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com>
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

HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=12386cb4600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
dashboard link: https://syzkaller.appspot.com/bug?extid=a7a6b9c609b9457c62c6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 2-1: BOGUS urb xfer, pipe 2 != type 2
WARNING: CPU: 0 PID: 3730 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 3730 Comm: syz-executor.1 Not tainted 5.2.0-rc6+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x292/0x6c9 kernel/panic.c:219
  __warn.cold+0x20/0x4b kernel/panic.c:576
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 f8 d3 f4 fd 4c 89 f7 e8 a0 51 1c ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 00 0e f7 85 e8 83 98 ca fd <0f> 0b e9 20 f4  
ff ff e8 cc d3 f4 fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881d4f479d0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000005dfa RSI: ffffffff8127ef3d RDI: ffffed103a9e8f2c
RBP: 0000000000000000 R08: ffff8881af663000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: ffff8881d462ed38 R14: ffff8881d18f9a20 R15: ffff8881d80e1c00
  usb_start_wait_urb+0x108/0x2b0 drivers/usb/core/message.c:57
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:152
  usbhid_set_raw_report drivers/hid/usbhid/hid-core.c:917 [inline]
  usbhid_raw_request+0x21f/0x640 drivers/hid/usbhid/hid-core.c:1265
  hid_hw_raw_request include/linux/hid.h:1079 [inline]
  hidraw_send_report+0x296/0x500 drivers/hid/hidraw.c:151
  hidraw_ioctl+0x5b4/0xaf0 drivers/hid/hidraw.c:421
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xcda/0x12e0 fs/ioctl.c:696
  ksys_ioctl+0x9b/0xc0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:718
  do_syscall_64+0xb7/0x560 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459829
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe142c43c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459829
RDX: 0000000020000000 RSI: 00000000c0404806 RDI: 0000000000000004
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe142c446d4
R13: 00000000004c22ab R14: 00000000004d5630 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
