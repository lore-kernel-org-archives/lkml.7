Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48A5C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A13216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbfHAP2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:28:20 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:38303 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbfHAP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:28:09 -0400
Received: by mail-io1-f72.google.com with SMTP id h4so79707547iol.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LKdqcLI3ZWV2WbybaexRWkKxH7T8RBsMDh3IvpK5R4o=;
        b=bP7/9tur0LpIbmmFE8YN5xSTSWqJvPlshQDKN30psjvtSbiR/1eWtz2OihOjDcL2a9
         pjvWdlY8gFoqRVUrq8nRXhW/nC5CN1xIazQhhgkOSjBxYJ6IfI8eMnTds8HugjNtH050
         veCUcScFOjUJZB4nMHS2ZvnrC/WE38M0Cezwl6PbqKm9jGbZ7RRtMWlB6qCnX/qzvLNr
         i2lR78geIYjxnBFEYUQRT1nF9LEOXD7XkFQTtkC5bvkd+UOGbxy/WrhrLNcRXndn/RqO
         5ScLQHal87P8R/+SkFXJ+SX2Ztmdgf13x+whBfPjMx8I50agMn29s/kBTbOWoj0G6SKM
         UaIw==
X-Gm-Message-State: APjAAAWnAaKl27qAE+FG/NVd/kYaXo2tZoWKS8BfY8/imczxRlqyolda
        w5sgnYjzqz8yKx8xEZyF2GqzDdqOXqko5KDHbIgjXXnSU10f
X-Google-Smtp-Source: APXvYqzZ5okl5xPOnwnEr5GCuQJbkig7iG9FuU2Qm8wa4cLPR7IhBnH69KUoMR+rcZeo5LNS7qkqw+MJbbGkSSS3/Q8emXeOZkRp
MIME-Version: 1.0
X-Received: by 2002:a02:b78a:: with SMTP id f10mr137235322jam.5.1564673288213;
 Thu, 01 Aug 2019 08:28:08 -0700 (PDT)
Date:   Thu, 01 Aug 2019 08:28:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088af91058f0fe377@google.com>
Subject: possible deadlock in open_rio
From:   syzbot <syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        miquel@df.uba.ar, rio500-users@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7f7867ff usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=136b6aec600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
dashboard link: https://syzkaller.appspot.com/bug?extid=7bbcbe9c9ff0cd49592a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.3.0-rc2+ #23 Not tainted
------------------------------------------------------
syz-executor.2/20386 is trying to acquire lock:
00000000772249c6 (rio500_mutex){+.+.}, at: open_rio+0x16/0xc0  
drivers/usb/misc/rio500.c:64

but task is already holding lock:
00000000d3e8f4b9 (minor_rwsem){++++}, at: usb_open+0x23/0x270  
drivers/usb/core/file.c:39

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (minor_rwsem){++++}:
        down_write+0x92/0x150 kernel/locking/rwsem.c:1500
        usb_register_dev drivers/usb/core/file.c:187 [inline]
        usb_register_dev+0x131/0x6a0 drivers/usb/core/file.c:156
        probe_rio.cold+0x53/0x21d drivers/usb/misc/rio500.c:468
        usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
        really_probe+0x281/0x650 drivers/base/dd.c:548
        driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
        __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
        bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
        __device_attach+0x217/0x360 drivers/base/dd.c:882
        bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
        device_add+0xae6/0x16f0 drivers/base/core.c:2114
        usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
        generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
        usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
        really_probe+0x281/0x650 drivers/base/dd.c:548
        driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
        __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
        bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
        __device_attach+0x217/0x360 drivers/base/dd.c:882
        bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
        device_add+0xae6/0x16f0 drivers/base/core.c:2114
        usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
        hub_port_connect drivers/usb/core/hub.c:5098 [inline]
        hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
        port_event drivers/usb/core/hub.c:5359 [inline]
        hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
        process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
        worker_thread+0x96/0xe20 kernel/workqueue.c:2415
        kthread+0x318/0x420 kernel/kthread.c:255
        ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

-> #0 (rio500_mutex){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2405 [inline]
        check_prevs_add kernel/locking/lockdep.c:2507 [inline]
        validate_chain kernel/locking/lockdep.c:2897 [inline]
        __lock_acquire+0x1f7c/0x3b50 kernel/locking/lockdep.c:3880
        lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
        __mutex_lock_common kernel/locking/mutex.c:930 [inline]
        __mutex_lock+0x158/0x1360 kernel/locking/mutex.c:1077
        open_rio+0x16/0xc0 drivers/usb/misc/rio500.c:64
        usb_open+0x1df/0x270 drivers/usb/core/file.c:48
        chrdev_open+0x219/0x5c0 fs/char_dev.c:414
        do_dentry_open+0x494/0x1120 fs/open.c:797
        do_last fs/namei.c:3416 [inline]
        path_openat+0x1430/0x3f50 fs/namei.c:3533
        do_filp_open+0x1a1/0x280 fs/namei.c:3563
        do_sys_open+0x3c0/0x580 fs/open.c:1089
        do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(minor_rwsem);
                                lock(rio500_mutex);
                                lock(minor_rwsem);
   lock(rio500_mutex);

  *** DEADLOCK ***

1 lock held by syz-executor.2/20386:
  #0: 00000000d3e8f4b9 (minor_rwsem){++++}, at: usb_open+0x23/0x270  
drivers/usb/core/file.c:39

stack backtrace:
CPU: 1 PID: 20386 Comm: syz-executor.2 Not tainted 5.3.0-rc2+ #23
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  check_noncircular+0x345/0x3e0 kernel/locking/lockdep.c:1741
  check_prev_add kernel/locking/lockdep.c:2405 [inline]
  check_prevs_add kernel/locking/lockdep.c:2507 [inline]
  validate_chain kernel/locking/lockdep.c:2897 [inline]
  __lock_acquire+0x1f7c/0x3b50 kernel/locking/lockdep.c:3880
  lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
  __mutex_lock_common kernel/locking/mutex.c:930 [inline]
  __mutex_lock+0x158/0x1360 kernel/locking/mutex.c:1077
  open_rio+0x16/0xc0 drivers/usb/misc/rio500.c:64
  usb_open+0x1df/0x270 drivers/usb/core/file.c:48
  chrdev_open+0x219/0x5c0 fs/char_dev.c:414
  do_dentry_open+0x494/0x1120 fs/open.c:797
  do_last fs/namei.c:3416 [inline]
  path_openat+0x1430/0x3f50 fs/namei.c:3533
  do_filp_open+0x1a1/0x280 fs/namei.c:3563
  do_sys_open+0x3c0/0x580 fs/open.c:1089
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x413711
Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48  
83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f26383357a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 0000000000413711
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f2638335850
RBP: 000000000075bf20 R08: 000000000000000f R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000293 R12: 00007f26383366d4
R13: 00000000004c8bee R14: 00000000004dfa68 R15: 00000000ffffffff
usb 5-1: Rio opened.


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
