Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C87C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CAD216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfG3Q6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:58:09 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:40258 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbfG3Q6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:06 -0400
Received: by mail-io1-f72.google.com with SMTP id v11so72072908iop.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 09:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mSxvpAdL6N4fH/Hu5gQqP4xurABkshFnMu5lEyO1QyQ=;
        b=pm2JsL+VIox33R/CUyTvYc7v01K/0ifweLujGAthvb/ik+2QWgN1h2DO7K9AJeUFFH
         zoIghpri4x9eKBPNA7jLE+2QKbVWPtbaSzMjf2EMagNwj9fag7y0CjqsZ5LOjSKheXlq
         ytqCvCW3rnObgYJt3Hmm1RC6nKEZ6FXdrgybE009Glrk2eFXCpdyB/fj/FO178SK3pc+
         lmxsXDH5+eplmLdGm7RAoaBubrIcW0GFMCTYP41l0Hu8AePPVmLyz79gL80xz/6SdpLh
         XPTKad3UM7nHEiVb5+qn787RWbW+73b4oaUBPtkqAvq8ayMd/CjXQ/1VjiUxQMsE0YxS
         ptyw==
X-Gm-Message-State: APjAAAW2arffzrLzEhuyuSeuOux6gRSMJIdFLa7gjcfcM/fkEB1nUd/N
        5uX7jDKeIBCF2LoSeTOt8MycPyzqj56rBYZ0yOuAUd8xcgqp
X-Google-Smtp-Source: APXvYqxXG/IlT4HYMEvfo7WVTd5GOs1Vz/yiR1XopLuL+fw5tEIeYsJjbyfDleGdhO2NdW9dOeI5rsKKxAAKnzI+bU3dgFtKwST4
MIME-Version: 1.0
X-Received: by 2002:a5e:9e03:: with SMTP id i3mr37411748ioq.66.1564505885712;
 Tue, 30 Jul 2019 09:58:05 -0700 (PDT)
Date:   Tue, 30 Jul 2019 09:58:05 -0700
In-Reply-To: <000000000000161dc3058ed0777c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000912b79058ee8e939@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb
From:   syzbot <syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    7f7867ff usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=10619cec600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
dashboard link: https://syzkaller.appspot.com/bug?extid=a7a6b9c609b9457c62c6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10606c42600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 2-1: BOGUS urb xfer, pipe 2 != type 2
WARNING: CPU: 1 PID: 7429 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7429 Comm: syz-executor.1 Not tainted 5.3.0-rc2+ #23
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
Code: 4d 85 ed 74 2c e8 38 e8 ed fd 4c 89 f7 e8 70 dc 1a ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 60 cc f8 85 e8 4d b9 c3 fd <0f> 0b e9 20 f4  
ff ff e8 0c e8 ed fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881cef0f9d0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812830fd RDI: ffffed1039de1f2c
RBP: 0000000000000000 R08: ffff8881c853e000 R09: fffffbfff115e1a2
R10: fffffbfff115e1a1 R11: ffffffff88af0d0f R12: 0000000000000002
R13: ffff8881d976b0a8 R14: ffff8881d0e02b20 R15: ffff8881d1720600
  usb_start_wait_urb+0x108/0x2b0 drivers/usb/core/message.c:57
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:152
  usbhid_set_raw_report drivers/hid/usbhid/hid-core.c:917 [inline]
  usbhid_raw_request+0x21f/0x640 drivers/hid/usbhid/hid-core.c:1265
  hid_hw_raw_request include/linux/hid.h:1079 [inline]
  hidraw_send_report+0x296/0x500 drivers/hid/hidraw.c:151
  hidraw_ioctl+0x5b4/0xae0 drivers/hid/hidraw.c:421
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
RSP: 002b:00007f6a91f44c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459829
RDX: 0000000020000240 RSI: 00000000c0404806 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6a91f456d4
R13: 00000000004c22c3 R14: 00000000004d5688 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..

