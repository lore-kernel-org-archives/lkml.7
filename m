Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AD5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308FA2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfHSPgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:36:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40708 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSPgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:36:01 -0400
Received: by mail-io1-f70.google.com with SMTP id v16so4459799ioh.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=P6L9CDKY22Ubg5tAzqUjQtuvef1EZedLJotiwn6BTdM=;
        b=C91CD9IhFY6iX4o9hXsXE6puVRlJoCEcEQbDarFwRCzmcheDEPgHRg9YdIK6aN/7FE
         pnOgIKPpP1SjYeyDVPnGA5oIqXkG/L2PEtKSmFIk2zVInvDEe7jykizvuzymA8DB0uSl
         MyZuIx6aF1+lLzMSmEZsaqTj5u+hs09t6vdPjBsj8qfKj+haLS5CagnkOA979VNwWjsM
         6xYpACTHqHc+ezyynHE+BPEc7hI/gQzyOPQPnL6jxJjeJRD7LQrL5PzIbP4CSdLPfNXi
         DRXqmpRhovMEAJX2OO1T92A41EIe12aylP9OQhspxzDMBnX/c3xcBfck/vZEWnYLvpbF
         5ZwA==
X-Gm-Message-State: APjAAAVJUPebTIV/x8XJw6qB2R9TSNi06lMsV9kczBUiZ9JWlyrt8ZzP
        oAI7RaP/tJj217CMoY67wmfTr7225L8DCMYo+IaF3Gtol5iM
X-Google-Smtp-Source: APXvYqw9geeThchpUtjczcpAmQ6P4swTTJP/Tv287kuEgsd+q/52erb9M1Hy5Ok89shir669k4i3r4E2rWJ2elT3zhMweAdx8RGF
MIME-Version: 1.0
X-Received: by 2002:a5e:c918:: with SMTP id z24mr6280032iol.234.1566228960824;
 Mon, 19 Aug 2019 08:36:00 -0700 (PDT)
Date:   Mon, 19 Aug 2019 08:36:00 -0700
In-Reply-To: <1566228274.5663.29.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8dffc05907a1825@google.com>
Subject: Re: KASAN: use-after-free Read in iowarrior_disconnect
From:   syzbot <syzbot+cfe6d93e0abab9a0de05@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
possible deadlock in usb_deregister_dev

usb 4-1: USB disconnect, device number 2
======================================================
WARNING: possible circular locking dependency detected
5.3.0-rc4+ #1 Not tainted
------------------------------------------------------
kworker/1:1/21 is trying to acquire lock:
00000000bfac431a (minor_rwsem){++++}, at: usb_deregister_dev  
drivers/usb/core/file.c:238 [inline]
00000000bfac431a (minor_rwsem){++++}, at: usb_deregister_dev+0x61/0x270  
drivers/usb/core/file.c:230

but task is already holding lock:
000000007638fa06 (iowarrior_open_disc_lock){+.+.}, at:  
iowarrior_disconnect+0x45/0x2c0 drivers/usb/misc/iowarrior.c:867

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (iowarrior_open_disc_lock){+.+.}:
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

-> #1 (iowarrior_mutex){+.+.}:
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

-> #0 (minor_rwsem){++++}:
        check_prev_add kernel/locking/lockdep.c:2405 [inline]
        check_prevs_add kernel/locking/lockdep.c:2507 [inline]
        validate_chain kernel/locking/lockdep.c:2897 [inline]
        __lock_acquire+0x1f7c/0x3b50 kernel/locking/lockdep.c:3880
        lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
        down_write+0x92/0x150 kernel/locking/rwsem.c:1500
        usb_deregister_dev drivers/usb/core/file.c:238 [inline]
        usb_deregister_dev+0x61/0x270 drivers/usb/core/file.c:230
        iowarrior_disconnect+0xa8/0x2c0 drivers/usb/misc/iowarrior.c:873
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

Chain exists of:
   minor_rwsem --> iowarrior_mutex --> iowarrior_open_disc_lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(iowarrior_open_disc_lock);
                                lock(iowarrior_mutex);
                                lock(iowarrior_open_disc_lock);
   lock(minor_rwsem);

  *** DEADLOCK ***

6 locks held by kworker/1:1/21:
  #0: 00000000ffafc5b3 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: 00000000ffafc5b3 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000ffafc5b3 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000ffafc5b3 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000ffafc5b3 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: 00000000ffafc5b3 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: 00000000ffafc5b3 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: 000000005bc0df0d ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: 00000000f73a9504 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1223 [inline]
  #2: 00000000f73a9504 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: 000000006fe9ca35 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1223 [inline]
  #3: 000000006fe9ca35 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: 0000000044c331cb (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162
  #5: 000000007638fa06 (iowarrior_open_disc_lock){+.+.}, at:  
iowarrior_disconnect+0x45/0x2c0 drivers/usb/misc/iowarrior.c:867

stack backtrace:
CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.3.0-rc4+ #1
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
  usb_deregister_dev drivers/usb/core/file.c:238 [inline]
  usb_deregister_dev+0x61/0x270 drivers/usb/core/file.c:230
  iowarrior_disconnect+0xa8/0x2c0 drivers/usb/misc/iowarrior.c:873
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
iowarrior 4-1:0.236: I/O-Warror #0 now disconnected
usb 4-1: new low-speed USB device number 3 using dummy_hcd
usb 4-1: device descriptor read/all, error -71
usb 4-1: new low-speed USB device number 4 using dummy_hcd
usb 4-1: config 0 has an invalid interface number: 236 but max is 2
usb 4-1: config 0 has an invalid descriptor of length 99, skipping  
remainder of the config
usb 4-1: config 0 has 1 interface, different from the descriptor's value: 3
usb 4-1: config 0 has no interface number 0
usb 4-1: config 0 interface 236 altsetting 0 endpoint 0x81 is Bulk;  
changing to Interrupt
usb 4-1: New USB device found, idVendor=07c0, idProduct=1501,  
bcdDevice=74.a0
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 4-1: config 0 descriptor??


Tested on:

commit:         d0847550 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=154c4522600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc9c80cc095da19
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11898be2600000

