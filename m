Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92015C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7420020665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfHAP2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:28:10 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40196 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfHAP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:28:08 -0400
Received: by mail-io1-f70.google.com with SMTP id v11so79551312iop.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DW2lUrkKlpnFsiGjB760L3h2H47aCTvpqe/PfznUJX0=;
        b=m7YXawZ8p/l0W6N/mLMWQE29gkZP9kZr0/lHAr90P5aaV/A1BiF34uBbcCgedLBz9+
         ud4lnab8rqLKDEEVAL1TQG4etyd1kq9aDjvI2JM9h0uukDwCgr94m8x2qVj8oHHSOj21
         Zuc5l+vl/Pn3LX3L3OtTdG1rgWXOeRZTS3d4BDwLqVkDfFyuMwbbSLp+IkTnSzd8Bv4l
         cg7fYLefgK4U70wzbcnfjAnNzxJbUbwsAeJWS5niyIC1cwzTreldq6bEnUVOAnBXkU4S
         RibysFfj2IfZ2ZY4jGSfAbvN50akWYWVAAc5luaPswpoP6MTqN14yGKWDTV24tJdXcKA
         Je9w==
X-Gm-Message-State: APjAAAX0WmrKuObVNv+ecVpVYTsl2nnHwfw2/3eeuWmVet/vjKSfZxTG
        ktXPvYfJu+iFVTRRwB3Qo+vBW0vPccvFueP8jTRzBAjyS/nm
X-Google-Smtp-Source: APXvYqwOz0QbvEjzbBVYvqNOayfMHpZFhb0KzWBzgq8/z5SYTT3OiLTFS/OleipYO3R+b8I8g2VNcobVLtbwXTlnJP+szQKbweRB
MIME-Version: 1.0
X-Received: by 2002:a6b:f80b:: with SMTP id o11mr4295061ioh.40.1564673287869;
 Thu, 01 Aug 2019 08:28:07 -0700 (PDT)
Date:   Thu, 01 Aug 2019 08:28:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008360bb058f0fe39d@google.com>
Subject: possible deadlock in iowarrior_open
From:   syzbot <syzbot+ca52394faa436d8131df@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17ab6aec600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
dashboard link: https://syzkaller.appspot.com/bug?extid=ca52394faa436d8131df
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ca52394faa436d8131df@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.3.0-rc2+ #23 Not tainted
------------------------------------------------------
syz-executor.0/10062 is trying to acquire lock:
00000000527cb8c7 (iowarrior_open_disc_lock){+.+.}, at:  
iowarrior_open+0x8a/0x2a0 drivers/usb/misc/iowarrior.c:600

but task is already holding lock:
0000000061445bc7 (iowarrior_mutex){+.+.}, at: iowarrior_open+0x23/0x2a0  
drivers/usb/misc/iowarrior.c:589

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (iowarrior_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:930 [inline]
        __mutex_lock+0x158/0x1360 kernel/locking/mutex.c:1077
        iowarrior_open+0x23/0x2a0 drivers/usb/misc/iowarrior.c:589
        usb_open+0x1df/0x270 drivers/usb/core/file.c:48
        chrdev_open+0x219/0x5c0 fs/char_dev.c:414
        do_dentry_open+0x494/0x1120 fs/open.c:797
        do_last fs/namei.c:3416 [inline]
        path_openat+0x1430/0x3f50 fs/namei.c:3533
        do_filp_open+0x1a1/0x280 fs/namei.c:3563
        do_sys_open+0x3c0/0x580 fs/open.c:1089
        do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (minor_rwsem#2){++++}:
        down_write+0x92/0x150 kernel/locking/rwsem.c:1500
        usb_deregister_dev drivers/usb/core/file.c:238 [inline]
        usb_deregister_dev+0x61/0x270 drivers/usb/core/file.c:230
        iowarrior_disconnect+0xa8/0x2c0 drivers/usb/misc/iowarrior.c:873
        usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
        __device_release_driver drivers/base/dd.c:1120 [inline]
        device_release_driver_internal+0x404/0x4c0 drivers/base/dd.c:1151
        bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
        device_del+0x420/0xb10 drivers/base/core.c:2288
        usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
        usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
        hub_port_connect drivers/usb/core/hub.c:4949 [inline]
        hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
        port_event drivers/usb/core/hub.c:5359 [inline]
        hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
        process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
        worker_thread+0x96/0xe20 kernel/workqueue.c:2415
        kthread+0x318/0x420 kernel/kthread.c:255
        ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

-> #0 (iowarrior_open_disc_lock){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2405 [inline]
        check_prevs_add kernel/locking/lockdep.c:2507 [inline]
        validate_chain kernel/locking/lockdep.c:2897 [inline]
        __lock_acquire+0x1f7c/0x3b50 kernel/locking/lockdep.c:3880
        lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
        __mutex_lock_common kernel/locking/mutex.c:930 [inline]
        __mutex_lock+0x158/0x1360 kernel/locking/mutex.c:1077
        iowarrior_open+0x8a/0x2a0 drivers/usb/misc/iowarrior.c:600
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

Chain exists of:
   iowarrior_open_disc_lock --> minor_rwsem#2 --> iowarrior_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(iowarrior_mutex);
                                lock(minor_rwsem#2);
                                lock(iowarrior_mutex);
   lock(iowarrior_open_disc_lock);

  *** DEADLOCK ***

2 locks held by syz-executor.0/10062:
  #0: 000000000fd8903d (minor_rwsem#2){++++}, at: usb_open+0x23/0x270  
drivers/usb/core/file.c:39
  #1: 0000000061445bc7 (iowarrior_mutex){+.+.}, at:  
iowarrior_open+0x23/0x2a0 drivers/usb/misc/iowarrior.c:589

stack backtrace:
CPU: 0 PID: 10062 Comm: syz-executor.0 Not tainted 5.3.0-rc2+ #23
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
  iowarrior_open+0x8a/0x2a0 drivers/usb/misc/iowarrior.c:600
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
RSP: 002b:00007fbd98b927a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 0000000000413711
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fbd98b92850
RBP: 000000000075bf20 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fbd98b936d4
R13: 00000000004c8bee R14: 00000000004dfa68 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
