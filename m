Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED775C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C191420842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfI3WjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:39:19 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51456 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfI3WjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:39:16 -0400
Received: by mail-io1-f69.google.com with SMTP id x13so33146764ioa.18
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 15:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jaFCCY9SApT65fw+A8gRWIZhb3sNt6GoxN/vYzgT0g8=;
        b=Q7FvQb3hUs6rXcYKsDvb4e5mvf+cEVRK/dUxZMHLXcmOFhRYVILiWMqaHmlLzF6642
         QSV9SFjMDArjtF9Z3ffuWGxx0hLqLvCFHY1jQTftwxmKs9fWMPn0Qr5kS/KQTpMAJF48
         TP9frMt/6XvOzdBji97ZIepbGq3jIzZJfGaN2YbIpuK51ycS35HnNp7LV4/FsPNVY44H
         NNpYobTH8awbNYJFi6fK/SF8JZNy8wPdeVAfR357lZ99FwCgKXXSHafuOLPl3ZVdwEcv
         Aw0qnJaPTZwdJ1/gWC3DaR8bahpFRz+wD8uZEHPv8WFzf36+banybuxC3WLjElheM0cR
         7jtw==
X-Gm-Message-State: APjAAAXqrX3f4k6iJO6fVS3ZjHr3nFb40MBBFRhdpJNjxEzAtFc5/xuF
        xqfAeZfEdKKoblodmWp+b6uXtSkYnScWet0yFWAEBX1egJS5
X-Google-Smtp-Source: APXvYqyuf1UIFb3O8/pIRhIbL8RCDZ6MpHi6vZGy2aplkvcDjKjqU4KYIcNFWabGhm4SaYFHtDoCLy0P3JlnMNgjxIOxX2MYCJVB
MIME-Version: 1.0
X-Received: by 2002:a5e:8f01:: with SMTP id c1mr14332039iok.148.1569883155650;
 Mon, 30 Sep 2019 15:39:15 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:39:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4e4900593cce75d@google.com>
Subject: KASAN: use-after-free Read in mcba_usb_disconnect
From:   syzbot <syzbot+e29b17e5042bbc56fae9@syzkaller.appspotmail.com>
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

HEAD commit:    2994c077 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=173b5acd600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69ddefac6929256a
dashboard link: https://syzkaller.appspot.com/bug?extid=e29b17e5042bbc56fae9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ec8e19600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107ad813600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e29b17e5042bbc56fae9@syzkaller.appspotmail.com

mcba_usb 1-1:0.180 can1: Failed to send cmd (169)
mcba_usb 1-1:0.180: Microchip CAN BUS Analyzer connected
usb 1-1: USB disconnect, device number 2
mcba_usb 1-1:0.95 can0: device disconnected
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3377/0x3eb0  
kernel/locking/lockdep.c:3828
Read of size 8 at addr ffff8881d2e98f48 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
  kasan_report+0xe/0x12 mm/kasan/common.c:634
  __lock_acquire+0x3377/0x3eb0 kernel/locking/lockdep.c:3828
  lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4487
  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
  _raw_spin_lock_irq+0x2d/0x40 kernel/locking/spinlock.c:167
  spin_lock_irq include/linux/spinlock.h:363 [inline]
  usb_kill_anchored_urbs+0x1e/0x110 drivers/usb/core/urb.c:787
  mcba_urb_unlink drivers/net/can/usb/mcba_usb.c:711 [inline]
  mcba_usb_disconnect+0xd6/0xe4 drivers/net/can/usb/mcba_usb.c:881
  usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1134 [inline]
  device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1165
  bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:532
  device_del+0x420/0xb10 drivers/base/core.c:2375
  usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
  usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
  hub_port_connect drivers/usb/core/hub.c:4949 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the page:
page:ffffea00074ba600 refcount:0 mapcount:-128 mapping:0000000000000000  
index:0x0
flags: 0x200000000000000()
raw: 0200000000000000 ffffea0007479208 ffff88821fffac18 0000000000000000
raw: 0000000000000000 0000000000000003 00000000ffffff7f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d2e98e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8881d2e98e80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff8881d2e98f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                               ^
  ffff8881d2e98f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8881d2e99000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
