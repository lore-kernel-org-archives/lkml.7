Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20431C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3092083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfDLO0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:26:14 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36680 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDLO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:26:11 -0400
Received: by mail-io1-f72.google.com with SMTP id a7so8010533ioq.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=g3RXwxQQ00FGbyuhLMsnTKehFpmuAvdvLcSEXXALj3c=;
        b=WTeB4GQQQWmoGC48bdjSt3lMMfbF/o38a2JeP+1KSbyGaMFSgMLB9oikGInmzS9fR2
         vsTDdPNekel7q3vWBJRCf8zqrGnjWPg0lu/ZYONBrzhnlvTmDDS5ZLTZgPZsr7lM+tv2
         ttMtwTjTdlj8PnU+nHDzMgZG36zqwCsIbvcQc5KpcnopJ/hQ+KHUujFAZGujRjIRh6QD
         u9akvesSvC/GrzE6apYWy7BOCpdLVpehtiC2kEjh5d/x4t0LrGl1jGiuc4SI9T0JXgDb
         nnDTEMTNDli1dtRjYtnU2A9NB2kZ5KUNATjb6W3+c0pfTgk9HUcM+klwbgfSr07ueiDK
         hfmA==
X-Gm-Message-State: APjAAAV7l2IWuyIPyJBseOTUov7Ev/LezTvpMKgNPZEUYxYi7qTaj29r
        QbALVmpoWGUMx+6v0IZazUaIyEwZKfP/Ba/JJ6i5JGSPsQrK
X-Google-Smtp-Source: APXvYqxrLsPKH/+P8c04nIXXCQQUUyoXloeHZyqTgls17FbAxKi5bY7FKKO1dbSyYDp9W0qYI69C7FK9/V+KeNZwAUnI7uybpZ6f
MIME-Version: 1.0
X-Received: by 2002:a02:aa07:: with SMTP id r7mr10399932jam.24.1555079170521;
 Fri, 12 Apr 2019 07:26:10 -0700 (PDT)
Date:   Fri, 12 Apr 2019 07:26:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e825105865615e3@google.com>
Subject: general protection fault in ath6kl_usb_alloc_urb_from_pipe
From:   syzbot <syzbot+ead4037ec793e025e66f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=12405cd3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=ead4037ec793e025e66f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11acc1af200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1344acd3200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ead4037ec793e025e66f@syzkaller.appspotmail.com

usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: string descriptor 0 read error: -71
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:__lock_acquire+0xadc/0x37c0 kernel/locking/lockdep.c:3573
Code: 00 0f 85 c1 1d 00 00 48 81 c4 10 01 00 00 5b 5d 41 5c 41 5d 41 5e 41  
5f c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f  
85 35 1e 00 00 49 81 7d 00 40 39 01 96 0f 84 e8 f5
RSP: 0018:ffff8880a84b6f78 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: ffff8880a849c980 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: ffff8880a849c980 R12: 0000000000000000
R13: 0000000000000018 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c6768 CR3: 000000009b83e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  lock_acquire+0x10d/0x2f0 kernel/locking/lockdep.c:4211
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x44/0x60 kernel/locking/spinlock.c:152
  ath6kl_usb_alloc_urb_from_pipe+0x49/0x2b0  
drivers/net/wireless/ath/ath6kl/usb.c:135
  ath6kl_usb_post_recv_transfers.constprop.0+0x233/0x400  
drivers/net/wireless/ath/ath6kl/usb.c:410
  ath6kl_usb_start_recv_pipes drivers/net/wireless/ath/ath6kl/usb.c:484  
[inline]
  hif_start drivers/net/wireless/ath/ath6kl/usb.c:682 [inline]
  ath6kl_usb_power_on+0x8d/0x120 drivers/net/wireless/ath/ath6kl/usb.c:1041
  ath6kl_hif_power_on drivers/net/wireless/ath/ath6kl/hif-ops.h:136 [inline]
  ath6kl_core_init drivers/net/wireless/ath/ath6kl/core.c:97 [inline]
  ath6kl_core_init+0x1b8/0x1060 drivers/net/wireless/ath/ath6kl/core.c:66
  ath6kl_usb_probe+0xc7f/0x1180 drivers/net/wireless/ath/ath6kl/usb.c:1147
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
  generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
  usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 4efca44223c9b0b0 ]---
RIP: 0010:__lock_acquire+0xadc/0x37c0 kernel/locking/lockdep.c:3573
Code: 00 0f 85 c1 1d 00 00 48 81 c4 10 01 00 00 5b 5d 41 5c 41 5d 41 5e 41  
5f c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f  
85 35 1e 00 00 49 81 7d 00 40 39 01 96 0f 84 e8 f5
RSP: 0018:ffff8880a84b6f78 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: ffff8880a849c980 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: ffff8880a849c980 R12: 0000000000000000
R13: 0000000000000018 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c6768 CR3: 000000009b83e000 CR4: 00000000001406f0
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
