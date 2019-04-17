Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7DDC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D4F206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbfDQL0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:26:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36486 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbfDQL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:26:06 -0400
Received: by mail-io1-f72.google.com with SMTP id a7so19254285ioq.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 04:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CiNG3QcYd2NaOcGlrHf/53lOaTBmL2Vq16/ZLUz4bHg=;
        b=tXjAxgJHbJyoYEINHy14CWew1hkesbf0FByk7U1vk4PiddQ8uCXBUkVUp2r0P5Y3Q0
         Lpt6+Zd7Ifu5PMT901WqHyOX0EbQEa7EJy+qECpIGVKUX9jtlm8nrVwmK3H2olbSPqrR
         giEX+ExNz8mv2qibtzzI+KmtyudalS+HQR1AqCJPPS3/o78OXsftGFuDwukEoFYyM8yx
         tXA3EecIsFm9sNGHQ9z2bC1Nwoaj+daB95WCWRBrMrJLiTKtF87vVRSHOqUwU01SLk0a
         aGSAefJkBiXebInt5wHBPzihugAafmXhl4IgB5+7e6Rk4/mdwBRxmwyl84O3CHF14/W9
         OaVw==
X-Gm-Message-State: APjAAAW298lD2ZizSKY5wmCBLho26/tMWFA3iFZpSDDU3XxU+jShZTG3
        Tykju2LbJYwexmAsmHBbf3UD2KhP6fvBeumu1gyPE7ebjU24
X-Google-Smtp-Source: APXvYqwshny4lDrmH4Yoj2Jx1K+sZTS6wXUGCZSYE6AunHkP8YCKV9WxbBEiclmalkZtrUhDm7PNQ3DlIrinjfmtAPGz7OhJLpjW
MIME-Version: 1.0
X-Received: by 2002:a24:68c2:: with SMTP id v185mr35037535itb.94.1555500365626;
 Wed, 17 Apr 2019 04:26:05 -0700 (PDT)
Date:   Wed, 17 Apr 2019 04:26:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bdc2e30586b826ce@google.com>
Subject: general protection fault in __dev_printk
From:   syzbot <syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1014aacb200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=2eb9121678bdb36e6d57
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1339c81d200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com

usb 2-1: USB disconnect, device number 5
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
yurex 2-1:0.150: yurex_interrupt - unknown status received: -71
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 1 PID: 5497 Comm: kworker/u4:7 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:dev_name include/linux/device.h:1087 [inline]
RIP: 0010:__dev_printk+0x3f/0x215 drivers/base/core.c:3208
Code: 89 f5 53 e8 6e fe 1b fc 48 85 ed 0f 84 c9 01 00 00 e8 60 fe 1b fc 48  
8d 7d 50 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 <80> 3c 02 00 74  
05 e8 11 0f 53 fc 4c 8b 7d 50 4d 85 ff 75 28 e8 33
RSP: 0018:ffff8880ad107970 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffffed1015a20f35 RCX: 00000000ffffffed
RDX: 0000000000000010 RSI: ffffffff8555c710 RDI: 0000000000000080
RBP: 0000000000000030 R08: ffff8880997ae200 R09: ffffed1015a24fc9
R10: ffffed1015a24fc8 R11: ffff8880ad127e47 R12: ffffffff8f031080
R13: ffff8880ad1079c8 R14: 0000000000000000 R15: ffff88809b373700
FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3b5b78b000 CR3: 00000000a496c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  _dev_err+0xdc/0x10e drivers/base/core.c:3251
  yurex_interrupt.cold+0x12e/0x13d drivers/usb/misc/yurex.c:183
  __usb_hcd_giveback_urb+0x1f4/0x470 drivers/usb/core/hcd.c:1758
  usb_hcd_giveback_urb+0x346/0x400 drivers/usb/core/hcd.c:1823
  dummy_timer+0x100b/0x32c0 drivers/usb/gadget/udc/dummy_hcd.c:1968
  call_timer_fn+0x161/0x5f0 kernel/time/timer.c:1325
  expire_timers kernel/time/timer.c:1362 [inline]
  __run_timers kernel/time/timer.c:1681 [inline]
  __run_timers kernel/time/timer.c:1649 [inline]
  run_timer_softirq+0x58b/0x1400 kernel/time/timer.c:1694
  __do_softirq+0x22a/0x8cd kernel/softirq.c:293
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1027
  </IRQ>
  do_softirq.part.0+0x60/0x70 kernel/softirq.c:338
  do_softirq kernel/softirq.c:330 [inline]
  __local_bh_enable_ip+0x183/0x1b0 kernel/softirq.c:190
  spin_unlock_bh include/linux/spinlock.h:374 [inline]
  batadv_nc_purge_paths+0x26b/0x380 net/batman-adv/network-coding.c:482
  batadv_nc_worker+0x2d4/0x770 net/batman-adv/network-coding.c:733
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 0f952022fa10fc7b ]---
RIP: 0010:dev_name include/linux/device.h:1087 [inline]
RIP: 0010:__dev_printk+0x3f/0x215 drivers/base/core.c:3208
Code: 89 f5 53 e8 6e fe 1b fc 48 85 ed 0f 84 c9 01 00 00 e8 60 fe 1b fc 48  
8d 7d 50 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 <80> 3c 02 00 74  
05 e8 11 0f 53 fc 4c 8b 7d 50 4d 85 ff 75 28 e8 33
RSP: 0018:ffff8880ad107970 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffffed1015a20f35 RCX: 00000000ffffffed
RDX: 0000000000000010 RSI: ffffffff8555c710 RDI: 0000000000000080
RBP: 0000000000000030 R08: ffff8880997ae200 R09: ffffed1015a24fc9
R10: ffffed1015a24fc8 R11: ffff8880ad127e47 R12: ffffffff8f031080
R13: ffff8880ad1079c8 R14: 0000000000000000 R15: ffff88809b373700
FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3b5b78b000 CR3: 00000000a496c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
