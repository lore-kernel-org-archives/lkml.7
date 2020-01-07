Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E65C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124FE2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgAGWTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:19:02 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:50311 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgAGWTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:19:01 -0500
Received: by mail-io1-f72.google.com with SMTP id e13so778973iob.17
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 14:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EdYBfb9elhNzCS6nVfUUeF91E19TZISwHJvUe8cvhIY=;
        b=oqI3jKax4GQ8BqJ+/oFLeFwP5UYSFIQmVQL2Ub9b+jMjElNd+bKeTSw+70llVRP34H
         vF1GrGoM60abmueU/zNOq/FBgXBu8nffJJKz1QF+0A9xqJJFVpi1TpUpQ18cD9LpaJED
         W8fGohCy+LIF+Nb/PQNkQjRtScd54whdP5+TC/zjbCJ9fBths2/UJ17gO/8tMzfabFrx
         RR9RsudUrFfIx34X4mtHoQwKF98dXBhpAN6aX0UK+iV7tqhFiqt5SNv+tBmbTA/CXzIa
         Py7MK9emeGVMtoNeSXF4SOJ7AGNGPbwg1dDMknt0zzs++2tz9R4t6em28NPSZ+1mSjAB
         G1qQ==
X-Gm-Message-State: APjAAAU4vB1K7s54+lrMxi1fTvV7VvPiaro8w6NFBBVnVB1QMj0S6AKK
        IUZt/jTJB0sp59O3U9WDWV9FcIj1Ol6cBMlCRRSScWWLnccr
X-Google-Smtp-Source: APXvYqw4ziw6b0NOCP0C+XN7LSo85RyAPU0ikCkIYra/xOmqW2R+353h9sekM1tp7raPU7gtiJfNXipkNXEZP28R2uljf4K2iqbm
MIME-Version: 1.0
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr980111iop.144.1578435541031;
 Tue, 07 Jan 2020 14:19:01 -0800 (PST)
Date:   Tue, 07 Jan 2020 14:19:01 -0800
In-Reply-To: <Pine.LNX.4.44L0.2001071624021.1567-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b962af059b9429bd@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (2)
From:   syzbot <syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
WARNING in usbhid_raw_request/usb_submit_urb

------------[ cut here ]------------
usb 4-1: BOGUS urb xfer, pipe 2 != type 2
WARNING: CPU: 0 PID: 4185 at drivers/usb/core/urb.c:478  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 4185 Comm: syz-executor.3 Not tainted 5.5.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xef/0x16e lib/dump_stack.c:118
  panic+0x2aa/0x6e1 kernel/panic.c:221
  __warn.cold+0x2f/0x30 kernel/panic.c:582
  report_bug+0x27b/0x2f0 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:478
Code: 4d 85 ed 74 2c e8 68 90 e7 fd 4c 89 f7 e8 60 2c 1d ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 80 59 15 86 e8 10 ad bc fd <0f> 0b e9 20 f4  
ff ff e8 3c 90 e7 fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881c0017b30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81295dad RDI: ffffed1038002f58
RBP: 0000000000000000 R08: ffff8881cf3b6200 R09: fffffbfff11f1ec0
R10: fffffbfff11f1ebf R11: ffffffff88f8f5ff R12: 0000000000000002
R13: ffff8881d884d0a8 R14: ffff8881da3c70a0 R15: ffff8881ca8f1c00
  usb_start_wait_urb+0x108/0x2b0 drivers/usb/core/message.c:57
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:152
  usbhid_set_raw_report drivers/hid/usbhid/hid-core.c:917 [inline]
  usbhid_raw_request+0x21f/0x640 drivers/hid/usbhid/hid-core.c:1265
  hid_hw_raw_request include/linux/hid.h:1079 [inline]
  hidraw_send_report+0x296/0x500 drivers/hid/hidraw.c:151
  hidraw_write+0x34/0x50 drivers/hid/hidraw.c:164
  __vfs_write+0x76/0x100 fs/read_write.c:494
  vfs_write+0x262/0x5c0 fs/read_write.c:558
  ksys_write+0x127/0x250 fs/read_write.c:611
  do_syscall_64+0xb6/0x5c0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a919
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f996c966c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a919
RDX: 0000000000000002 RSI: 0000000020000040 RDI: 0000000000000007
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f996c9676d4
R13: 00000000004cbe90 R14: 00000000004e5ce0 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         ecdf2214 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12b2e656e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b06a019075333661
dashboard link: https://syzkaller.appspot.com/bug?extid=10e5f68920f13587ab12
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c162aee00000

