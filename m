Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FC5CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C808321783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfJVOyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:54:09 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:41298 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbfJVOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:54:08 -0400
Received: by mail-io1-f69.google.com with SMTP id m25so20202731ioo.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RRF7y07m28ls3yMteBlL0HRFtYLjs4BCBJAeQ09g2TE=;
        b=ESINaMWBlEWgCpNTDKQ0iNhPwaQXzGBhN7V8RPvkEWo50dSuRjWxewjAKrK9GWf309
         LqrIwuulM+jFds7OzJ4P/VasUT5eAaWwNrSj5gG5g7qs2hc7nAInKD9qTN8TznX4SQ95
         MTK8kAP0PT3Ua/PUWP0yNxD60/k/4muOF6CvY6qm4jp7g8IotkRv0EFaVx2aT1NqH3b4
         R6S2vA0ctuaO+FuahVYs3qyjPesV0KUhypl+PXHKBkN6DXTtecGlhSqcGc4Tw96iNrkI
         nRfZr3i23H3HG0coo7gWd4PS9w0a34RCEqxs5+vPeBmaoaCejP4BHx/Qr1E7qia6zyi+
         eLIA==
X-Gm-Message-State: APjAAAVezQIfnsZScdaaKtfkdultZYWuDLb0edFICFGFEW56dl25q0wO
        3T2cbuD5QRq1sq8AitTWXIDBKAv1kYBFGjVSdo+fakI0xMIa
X-Google-Smtp-Source: APXvYqwGfHpGiEOeUwK6zKmhm9/xTVjBM04PsRWWsnN5y9h+6Py5BkK6kUn+dPgQ2R14bovLaxtyKjN9frFpGca61GxdmaSyYRwf
MIME-Version: 1.0
X-Received: by 2002:a92:8404:: with SMTP id l4mr12346342ild.15.1571756047915;
 Tue, 22 Oct 2019 07:54:07 -0700 (PDT)
Date:   Tue, 22 Oct 2019 07:54:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e906be059580f8cd@google.com>
Subject: WARNING in usbhid_raw_request/usb_submit_urb (2)
From:   syzbot <syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17f794c4e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
dashboard link: https://syzkaller.appspot.com/bug?extid=10e5f68920f13587ab12
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 5-1: BOGUS urb xfer, pipe 2 != type 2
WARNING: CPU: 0 PID: 12230 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12230 Comm: syz-executor.4 Not tainted 5.4.0-rc3+ #0
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
RSP: 0018:ffff8881c1f27b30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 000000000000432b RSI: ffffffff8128bcbd RDI: ffffed10383e4f58
RBP: 0000000000000000 R08: ffff8881d02a3000 R09: fffffbfff11b23b7
R10: fffffbfff11b23b6 R11: ffffffff88d91db7 R12: 0000000000000002
R13: ffff8881d18b54b0 R14: ffff8881b02230a0 R15: ffff8881c9354800
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
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459cd9
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4bf97b0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459cd9
RDX: 0000000000000085 RSI: 0000000020000200 RDI: 0000000000000007
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4bf97b16d4
R13: 00000000004ca1e5 R14: 00000000004e20b0 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
