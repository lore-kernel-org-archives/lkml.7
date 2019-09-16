Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ADDC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1347214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfIPVmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:42:10 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:51229 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfIPVmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:42:09 -0400
Received: by mail-io1-f70.google.com with SMTP id a13so2092184ioh.18
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vrP9JOoIMT13BIvgmwLENBjY554tFga0cUi/Ijgj+9M=;
        b=kpAGu6FLVPDoLSm0BNo0adkiKm8CHy7camIT11MYerQsVi94k/OB1EHSZd7pz9jfKR
         w6Cb3y2rE+cgNljzlFuy1dgN79I97TZKcejCgtKTdfD1jXPplXq//jjnMLEYu8yFxVOx
         RyMUMbqW4CICwu7ybtaxOj+sn4FxWXjF1kSZ+uwjICZI/dvFKMdEyQUcCbSY/xGdfR6q
         KbC9yAoCEs+wZnnUl+45bYWTrkIhzyNpe+RoZgic2otLoC7fLAUZCUf7Z2uzY5fAU178
         Q4V9QqiWAxM+lXxdbYCyCBugxnZl38pyxfCB8y/hdb5WBZCYl5j7s3ycc1r12b8NBgYZ
         6S8w==
X-Gm-Message-State: APjAAAXvFm94bcD8B4lc5g3aSbWNPvEmXWk9KzsxpHG26KLb0BOjAvSw
        VBCMOwVORF8dtFE9CvF4/zW6vucsPQsV+hg9/yap75Pn6oXM
X-Google-Smtp-Source: APXvYqzHIwIsc5EjDKA7E6FN3wLOt9JNE5mEIX56p4Aicet6bUdgt0oSY/XyIlACVrO2+FaKHulgQhbmWfVSHT32MmYZtO78Msaq
MIME-Version: 1.0
X-Received: by 2002:a02:698d:: with SMTP id e135mr184654jac.128.1568670126972;
 Mon, 16 Sep 2019 14:42:06 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:42:06 -0700
In-Reply-To: <000000000000d58eb90592add24e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b02ae30592b279e4@google.com>
Subject: Re: possible deadlock in usb_deregister_dev (2)
From:   syzbot <syzbot+f9549f5ee8a5416f0b95@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=175cdb95600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=f9549f5ee8a5416f0b95
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13961369600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139c811d600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f9549f5ee8a5416f0b95@syzkaller.appspotmail.com

usb 1-1: config 0 descriptor??
legousbtower 1-1:0.219: LEGO USB Tower firmware version is 129.136 build  
65535
legousbtower 1-1:0.219: LEGO USB Tower #-160 now attached to major 180  
minor 0
usb 1-1: USB disconnect, device number 2
======================================================
WARNING: possible circular locking dependency detected
5.3.0-rc7+ #0 Not tainted
------------------------------------------------------
kworker/0:1/12 is trying to acquire lock:
0000000098630ee4 (minor_rwsem){++++}, at: usb_deregister_dev+0x95/0x230  
drivers/usb/core/file.c:239

but task is already holding lock:
00000000d9ad5b6f (open_disc_mutex){+.+.}, at: tower_disconnect+0x45/0x300  
drivers/usb/misc/legousbtower.c:945

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (open_disc_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:930 [inline]
        __mutex_lock+0x158/0x1360 kernel/locking/mutex.c:1077
        tower_open+0xce/0x9b0 drivers/usb/misc/legousbtower.c:335
        usb_open+0x1df/0x270 drivers/usb/core/file.c:48
        chrdev_open+0x219/0x5c0 fs/char_dev.c:414
        do_dentry_open+0x494/0x1120 fs/open.c:797
        do_last fs/namei.c:3416 [inline]
        path_openat+0x1430/0x3f50 fs/namei.c:3533
        do_filp_open+0x1a1/0x280 fs/namei.c:3563
        do_sys_open+0x3c0/0x580 fs/open.c:1089
        do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (minor_rwsem){++++}:
        check_prev_add kernel/locking/lockdep.c:2405 [inline]
        check_prevs_add kernel/locking/lockdep.c:2507 [inline]
        validate_chain kernel/locking/lockdep.c:2897 [inline]
        __lock_acquire+0x1f7c/0x3b50 kernel/locking/lockdep.c:3880
        lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
        down_write+0x92/0x150 kernel/locking/rwsem.c:1500
        usb_deregister_dev+0x95/0x230 drivers/usb/core/file.c:239
        tower_disconnect+0xa8/0x300 drivers/usb/misc/legousbtower.c:951
        usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
        __device_release_driver drivers/base/dd.c:1134 [inline]
        device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1165
        bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
        device_del+0x420/0xb10 drivers/base/core.c:2339
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

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(open_disc_mutex);
                                lock(minor_rwsem);
                                lock(open_disc_mutex);
   lock(minor_rwsem);

  *** DEADLOCK ***

6 locks held by kworker/0:1/12:
  #0: 00000000b8e7e1e7 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: 00000000b8e7e1e7 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000b8e7e1e7 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000b8e7e1e7 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000b8e7e1e7 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: 00000000b8e7e1e7 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: 00000000b8e7e1e7 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: 0000000054d9228f ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: 00000000f97c245e (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1223 [inline]
  #2: 00000000f97c245e (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: 0000000035f038d2 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1223 [inline]
  #3: 0000000035f038d2 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: 00000000accb22e6 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162
  #5: 00000000d9ad5b6f (open_disc_mutex){+.+.}, at:  
tower_disconnect+0x45/0x300 drivers/usb/misc/legousbtower.c:945

stack backtrace:
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  check_noncircular+0x345/0x3e0 kernel/locking/lockdep.c:1741
  check_prev_add kernel/locking/lockdep.c:2405 [inline]
  check_prevs_add kernel/locking/lockdep.c:2507 [inline]
  validate_chain kernel/locking/lockdep.c:2897 [inline]
  __lock_acquire+0x1f7c/0x3b50 kernel/locking/lockdep.c:3880
  lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
  down_write+0x92/0x150 kernel/locking/rwsem.c:1500
  usb_deregister_dev+0x95/0x230 drivers/usb/core/file.c:239
  tower_disconnect+0xa8/0x300 drivers/usb/misc/legousbtower.c:951
  usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1134 [inline]
  device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1165
  bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
  device_del+0x420/0xb10 drivers/base/core.c:2339
  usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
  usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
  hub_port_connect drivers/usb/core/hub.c:4949 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  ? pwq_dec

