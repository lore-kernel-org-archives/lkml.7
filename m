Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74538C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5267F21E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbfHGO2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:28:09 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71]:49983 "EHLO
        mail-ot1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfHGO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:28:06 -0400
Received: by mail-ot1-f71.google.com with SMTP id l7so55174224otj.16
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zAWlbgdb3pQmS4BwCPHdIKnI7sWAau7Z6EfGDOBz9uI=;
        b=LjnBl3Vb+P5xZakqPLXKKcXL9a4n+lNUApbnTp87SQW7sOk4mH+wHsOcWbobQ/z7kP
         hZ4niNAHOvFqDh+N2GscKb0VEwdTfH9AvF8bfpRnisHzcxCZWL8fxe8EkyXnxIzMDDHm
         3kAkVl9vh9+AaYcD5efUQlKvRL5KWmwj9721mIM3lXjyUYFC/rsy2w0vVQngqxqXmY5v
         bKlWyVixcfMIM3p/5I0cIMZ4yfYGZkf7ZVOiIqHS81AgEa/DsGR5mt0SnogQIel0seH3
         jZD3W+x+Z47RqFermal/RB/2l6tzk+bGjBI+6xguFd1j1DzH/dO8dtp8gzIB1tOcVPFn
         3FSw==
X-Gm-Message-State: APjAAAUxcqutayC2tSYLXqp6bNblIq6CuvijAHlORvhK2JrvJ0Tst0mW
        B7bXuJhSUXEpZacg84DNiGtSS9cADZFmqVtX9fQdisSWbjlQ
X-Google-Smtp-Source: APXvYqyB0Kjbah0mR1vAE9nXijPlczwkAdoxRyrbWmkLdbcwBVc/hhPNvuGRNS7oIqFPf7BXx+CYjvgXsKaeG/fjhLLVK4Y9iKlb
MIME-Version: 1.0
X-Received: by 2002:a02:7f15:: with SMTP id r21mr6013150jac.120.1565188085671;
 Wed, 07 Aug 2019 07:28:05 -0700 (PDT)
Date:   Wed, 07 Aug 2019 07:28:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da6cf8058f87bfde@google.com>
Subject: WARNING in hiddev_ioctl/usb_submit_urb
From:   syzbot <syzbot+5ef817fc02cd64d038a3@syzkaller.appspotmail.com>
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

HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=14f54e26600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
dashboard link: https://syzkaller.appspot.com/bug?extid=5ef817fc02cd64d038a3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5ef817fc02cd64d038a3@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 4-1: BOGUS urb xfer, pipe 2 != type 2
WARNING: CPU: 0 PID: 7794 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7794 Comm: syz-executor.4 Not tainted 5.3.0-rc2+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x2a3/0x6da kernel/panic.c:219
  __warn.cold+0x20/0x4a kernel/panic.c:576
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1026
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 28 76 ed fd 4c 89 f7 e8 c0 6d 1a ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 60 e7 18 86 e8 3d 47 c3 fd <0f> 0b e9 20 f4  
ff ff e8 fc 75 ed fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881b01178a0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 000000000000549e RSI: ffffffff8128a0fd RDI: ffffed1036022f06
RBP: 0000000000000000 R08: ffff8881cfd11800 R09: fffffbfff11acda9
R10: fffffbfff11acda8 R11: ffffffff88d66d47 R12: 0000000000000002
R13: ffff8881cd771828 R14: ffff8881c87e22a0 R15: ffff8881d3f1ac00
  usb_start_wait_urb+0x108/0x2b0 drivers/usb/core/message.c:57
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:152
  usb_get_string+0xac/0x1a0 drivers/usb/core/message.c:693
  usb_string_sub+0x8b/0x3d0 drivers/usb/core/message.c:737
  usb_string+0x32b/0x480 drivers/usb/core/message.c:836
  hiddev_ioctl_string.isra.0+0xf5/0x1d0 drivers/hid/usbhid/hiddev.c:576
  hiddev_ioctl+0x5b8/0x1550 drivers/hid/usbhid/hiddev.c:682
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd2d/0x1330 fs/ioctl.c:696
  ksys_ioctl+0x9b/0xc0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:718
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459829
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8529fb1c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459829
RDX: 00000000200001c0 RSI: 0000000081044804 RDI: 0000000000000004
RBP: 000000000075c1c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8529fb26d4
R13: 00000000004c2249 R14: 00000000004d55f8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
