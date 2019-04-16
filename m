Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694A4C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E24020821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfDPVxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:53:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36684 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfDPVxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:53:01 -0400
Received: by mail-io1-f70.google.com with SMTP id a7so18013867ioq.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 14:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Rl5YAuXxdXE8dlgSKJmWdL6YL/Z87eEN8fFR1y/Y0Z8=;
        b=jDExt+gFfPk3HgyGBBOqFuDUkNfP7i5FD4ADuJ53bf2I4GsEJ6Iw6r3mLzbuoVY3iD
         j3sxROoSO5RKHUf1LhwRWZEsSmB8sOzyH12EkSBDoSlR+Bt/gGuEYLCoVZ38NUNZqk/F
         wyvXZdrz5u/BMVroaku6HdEuXWVL+PqFIR1+PzQDsqlmYkdoV3c8cGWALhwmeKaJrLpj
         vopbwtuCD0KUyqhgB6Jd2BTGVC9QPtEB7U4m1VTjCoRQ43Mh+PFs1EC6Q+hV13Mt2AkT
         9o0/+J895bd2u9FSMfyYPLB2R9qtb8FUWqauQwf3RCEv550nDx/SBILw34gP6try8X17
         yEkg==
X-Gm-Message-State: APjAAAUnSYTQMh+q7U4FtYiXxcWHrl7V5C872SonbUXFA1Nn29quvVTm
        wnvOccRJ8C7ct2I0AVVYgfCelo+PQFxUc+PyAb0HbZ0Bu/fn
X-Google-Smtp-Source: APXvYqxKAdRcwuIA9a3u3/y3LcYpI9x90bUjbhk2EXunt+vgHD0f9tJvqP5qXRN0+2SfqIdwPfE7EQk0jxqWdKke31/lVGLfnEQN
MIME-Version: 1.0
X-Received: by 2002:a6b:bc06:: with SMTP id m6mr1132864iof.18.1555451580638;
 Tue, 16 Apr 2019 14:53:00 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:53:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1904161707210.1605-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000edf1630586acca2b@google.com>
Subject: Re: INFO: task hung in usb_kill_urb
From:   syzbot <syzbot+d919b0f29d7b5a4994b9@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
INFO: task hung in usb_kill_urb

usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
dummy_hcd dummy_hcd.0: Unsupported driver max speed 0
usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
dummy_hcd dummy_hcd.0: Unsupported driver max speed 0
usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
INFO: task kworker/1:1:21 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4-g9a33b36-dirty #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:1     D26512    21      2 0x80000000
Workqueue: usb_hub_wq hub_event
Call Trace:
  schedule+0x8f/0x180 kernel/sched/core.c:3562
  usb_kill_urb drivers/usb/core/urb.c:695 [inline]
  usb_kill_urb+0x22a/0x2c0 drivers/usb/core/urb.c:687
dummy_hcd dummy_hcd.0: Unsupported driver max speed 0
usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
  usb_start_wait_urb+0x257/0x4d0 drivers/usb/core/message.c:63
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x321/0x4a0 drivers/usb/core/message.c:152
  hub_port_init+0x81d/0x2d30 drivers/usb/core/hub.c:4655
  hub_port_connect drivers/usb/core/hub.c:5021 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x11b8/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
INFO: task kworker/1:2:533 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4-g9a33b36-dirty #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:2     D25760   533      2 0x80000000
Workqueue: usb_hub_wq hub_event
Call Trace:
  schedule+0x8f/0x180 kernel/sched/core.c:3562
  usb_kill_urb drivers/usb/core/urb.c:695 [inline]
  usb_kill_urb+0x22a/0x2c0 drivers/usb/core/urb.c:687
  usb_start_wait_urb+0x257/0x4d0 drivers/usb/core/message.c:63
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x321/0x4a0 drivers/usb/core/message.c:152
  hub_port_init+0x81d/0x2d30 drivers/usb/core/hub.c:4655
dummy_hcd dummy_hcd.0: Unsupported driver max speed 0
  hub_port_connect drivers/usb/core/hub.c:5021 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x11b8/0x3b00 drivers/usb/core/hub.c:5432
usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
INFO: task kworker/1:3:5711 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4-g9a33b36-dirty #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:3     D26656  5711      2 0x80000000
Workqueue: usb_hub_wq hub_event
Call Trace:
  schedule+0x8f/0x180 kernel/sched/core.c:3562
  usb_kill_urb drivers/usb/core/urb.c:695 [inline]
  usb_kill_urb+0x22a/0x2c0 drivers/usb/core/urb.c:687
  usb_start_wait_urb+0x257/0x4d0 drivers/usb/core/message.c:63
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x321/0x4a0 drivers/usb/core/message.c:152
  hub_port_init+0x81d/0x2d30 drivers/usb/core/hub.c:4655
  hub_port_connect drivers/usb/core/hub.c:5021 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x11b8/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
INFO: task kworker/1:4:5815 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4-g9a33b36-dirty #1
dummy_hcd dummy_hcd.0: Unsupported driver max speed 0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:4     D27416  5815      2 0x80000000
Workqueue: usb_hub_wq hub_event
usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
Call Trace:
  schedule+0x8f/0x180 kernel/sched/core.c:3562
  usb_kill_urb drivers/usb/core/urb.c:695 [inline]
  usb_kill_urb+0x22a/0x2c0 drivers/usb/core/urb.c:687
  usb_start_wait_urb+0x257/0x4d0 drivers/usb/core/message.c:63
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x321/0x4a0 drivers/usb/core/message.c:152
  hub_port_init+0x81d/0x2d30 drivers/usb/core/hub.c:4655
  hub_port_connect drivers/usb/core/hub.c:5021 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x11b8/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
INFO: task kworker/1:5:5854 blocked for more than 144 seconds.
       Not tainted 5.1.0-rc4-g9a33b36-dirty #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:5     D27008  5854      2 0x80000000
Workqueue: usb_hub_wq hub_event
Call Trace:
  schedule+0x8f/0x180 kernel/sched/core.c:3562
  usb_kill_urb drivers/usb/core/urb.c:695 [inline]
  usb_kill_urb+0x22a/0x2c0 drivers/usb/core/urb.c:687
dummy_hcd dummy_hcd.0: Unsupported driver max speed 0
  usb_start_wait_urb+0x257/0x4d0 drivers/usb/core/message.c:63
usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x321/0x4a0 drivers/usb/core/message.c:152
  hub_port_init+0x81d/0x2d30 drivers/usb/core/hub.c:4655
  hub_port_connect drivers/usb/core/hub.c:5021 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x11b8/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
INFO: task kworker/1:6:5953 blocked for more than 144 seconds.
       Not tainted 5.1.0-rc4-g9a33b36-dirty #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:6     D28144  5953      2 0x80000000
Workqueue: usb_hub_wq hub_event
Call Trace:
  schedule+0x8f/0x180 kernel/sched/core.c:3562
  usb_kill_urb drivers/usb/core/urb.c:695 [inline]
  usb_kill_urb+0x22a/0x2c0 drivers/usb/core/urb.c:687
  usb_start_wait_urb+0x257/0x4d0 drivers/usb/core/message.c:63
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x321/0x4a0 drivers/usb/core/message.c:152
  hub_port_init+0x81d/0x2d30 drivers/usb/core/hub.c:4655
  hub_port_connect drivers/usb/core/hub.c:5021 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x11b8/0x3b00 drivers/usb/core/hub.c:5432
dummy_hcd dummy_hcd.0: Unsupported driver max speed 0
usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Showing all locks held in the system:
5 locks held by kworker/1:1/21:
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x81f/0x1580 kernel/workqueue.c:2240
  #1: 0000000066a57f62 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x853/0x1580 kernel/workqueue.c:2244
  #2: 000000008061858c (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1207 [inline]
  #2: 000000008061858c (&dev->mutex){....}, at: hub_event+0x18a/0x3b00  
drivers/usb/core/hub.c:5378
  #3: 00000000e9c2b745 (&port_dev->status_lock){+.+.}, at: usb_lock_port  
drivers/usb/core/hub.c:2994 [inline]
  #3: 00000000e9c2b745 (&port_dev->status_lock){+.+.}, at: hub_port_connect  
drivers/usb/core/hub.c:5020 [inline]
  #3: 00000000e9c2b745 (&port_dev->status_lock){+.+.}, at:  
hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  #3: 00000000e9c2b745 (&port_dev->status_lock){+.+.}, at: port_event  
drivers/usb/core/hub.c:5350 [inline]
  #3: 00000000e9c2b745 (&port_dev->status_lock){+.+.}, at:  
hub_event+0x11a3/0x3b00 drivers/usb/core/hub.c:5432
  #4: 0000000074a9c1da (hcd->address0_mutex){+.+.}, at:  
hub_port_init+0x1bb/0x2d30 drivers/usb/core/hub.c:4529
1 lock held by khungtaskd/23:
  #0: 000000009a7c2fe9 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x53/0x269 kernel/locking/lockdep.c:5059
5 locks held by kworker/1:2/533:
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x81f/0x1580 kernel/workqueue.c:2240
  #1: 0000000086e8eaf1 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x853/0x1580 kernel/workqueue.c:2244
  #2: 000000006469b3a5 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1207 [inline]
  #2: 000000006469b3a5 (&dev->mutex){....}, at: hub_event+0x18a/0x3b00  
drivers/usb/core/hub.c:5378
  #3: 000000007f0b56f7 (&port_dev->status_lock){+.+.}, at: usb_lock_port  
drivers/usb/core/hub.c:2994 [inline]
  #3: 000000007f0b56f7 (&port_dev->status_lock){+.+.}, at: hub_port_connect  
drivers/usb/core/hub.c:5020 [inline]
  #3: 000000007f0b56f7 (&port_dev->status_lock){+.+.}, at:  
hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  #3: 000000007f0b56f7 (&port_dev->status_lock){+.+.}, at: port_event  
drivers/usb/core/hub.c:5350 [inline]
  #3: 000000007f0b56f7 (&port_dev->status_lock){+.+.}, at:  
hub_event+0x11a3/0x3b00 drivers/usb/core/hub.c:5432
  #4: 00000000f92a9577 (hcd->address0_mutex){+.+.}, at:  
hub_port_init+0x1bb/0x2d30 drivers/usb/core/hub.c:4529
1 lock held by rsyslogd/5452:
  #0: 0000000078f4a532 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xe8/0x100  
fs/file.c:801
2 locks held by getty/5542:
  #0: 0000000023afba58 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 00000000bc10d82a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
2 locks held by getty/5543:
  #0: 00000000a6ab1d25 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 00000000d5a44554 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
dummy_hcd dummy_hcd.0: Unsupported driver max speed 0
2 locks held by getty/5544:
usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
  #0: 0000000098fc4771 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 0000000017060772 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
2 locks held by getty/5545:
  #0: 000000005fca8b56 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 000000005a5319f8 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
2 locks held by getty/5546:
  #0: 00000000e590919f (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 000000004775329f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
2 locks held by getty/5547:
  #0: 00000000179d4d0b (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 000000002922a30b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
2 locks held by getty/5548:
  #0: 000000006c2e3908 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 000000009cdeb0bf (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
5 locks held by kworker/1:3/5711:
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x81f/0x1580 kernel/workqueue.c:2240
  #1: 000000008f65d948 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x853/0x1580 kernel/workqueue.c:2244
  #2: 00000000d16a6c1c (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1207 [inline]
  #2: 00000000d16a6c1c (&dev->mutex){....}, at: hub_event+0x18a/0x3b00  
drivers/usb/core/hub.c:5378
  #3: 00000000df89ca19 (&port_dev->status_lock){+.+.}, at: usb_lock_port  
drivers/usb/core/hub.c:2994 [inline]
  #3: 00000000df89ca19 (&port_dev->status_lock){+.+.}, at: hub_port_connect  
drivers/usb/core/hub.c:5020 [inline]
  #3: 00000000df89ca19 (&port_dev->status_lock){+.+.}, at:  
hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  #3: 00000000df89ca19 (&port_dev->status_lock){+.+.}, at: port_event  
drivers/usb/core/hub.c:5350 [inline]
  #3: 00000000df89ca19 (&port_dev->status_lock){+.+.}, at:  
hub_event+0x11a3/0x3b00 drivers/usb/core/hub.c:5432
  #4: 000000007284a231 (hcd->address0_mutex){+.+.}, at:  
hub_port_init+0x1bb/0x2d30 drivers/usb/core/hub.c:4529
5 locks held by kworker/1:4/5815:
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x81f/0x1580 kernel/workqueue.c:2240
  #1: 00000000b6e140d2 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x853/0x1580 kernel/workqueue.c:2244
  #2: 0000000054730851 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1207 [inline]
  #2: 0000000054730851 (&dev->mutex){....}, at: hub_event+0x18a/0x3b00  
drivers/usb/core/hub.c:5378
  #3: 00000000e19c14b6 (&port_dev->status_lock){+.+.}, at: usb_lock_port  
drivers/usb/core/hub.c:2994 [inline]
  #3: 00000000e19c14b6 (&port_dev->status_lock){+.+.}, at: hub_port_connect  
drivers/usb/core/hub.c:5020 [inline]
  #3: 00000000e19c14b6 (&port_dev->status_lock){+.+.}, at:  
hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  #3: 00000000e19c14b6 (&port_dev->status_lock){+.+.}, at: port_event  
drivers/usb/core/hub.c:5350 [inline]
  #3: 00000000e19c14b6 (&port_dev->status_lock){+.+.}, at:  
hub_event+0x11a3/0x3b00 drivers/usb/core/hub.c:5432
  #4: 000000001c7bddbf (hcd->address0_mutex){+.+.}, at:  
hub_port_init+0x1bb/0x2d30 drivers/usb/core/hub.c:4529
5 locks held by kworker/1:5/5854:
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x81f/0x1580 kernel/workqueue.c:2240
dummy_hcd dummy_hcd.0: Unsupported driver max speed 0
  #1: 00000000357ce4fb ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x853/0x1580 kernel/workqueue.c:2244
  #2: 000000009d868e2d (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1207 [inline]
  #2: 000000009d868e2d (&dev->mutex){....}, at: hub_event+0x18a/0x3b00  
drivers/usb/core/hub.c:5378
usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
  #3: 00000000938a6414 (&port_dev->status_lock){+.+.}, at: usb_lock_port  
drivers/usb/core/hub.c:2994 [inline]
  #3: 00000000938a6414 (&port_dev->status_lock){+.+.}, at: hub_port_connect  
drivers/usb/core/hub.c:5020 [inline]
  #3: 00000000938a6414 (&port_dev->status_lock){+.+.}, at:  
hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  #3: 00000000938a6414 (&port_dev->status_lock){+.+.}, at: port_event  
drivers/usb/core/hub.c:5350 [inline]
  #3: 00000000938a6414 (&port_dev->status_lock){+.+.}, at:  
hub_event+0x11a3/0x3b00 drivers/usb/core/hub.c:5432
  #4: 0000000050760949 (hcd->address0_mutex){+.+.}, at:  
hub_port_init+0x1bb/0x2d30 drivers/usb/core/hub.c:4529
5 locks held by kworker/1:6/5953:
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 00000000b3ad1415 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x81f/0x1580 kernel/workqueue.c:2240
  #1: 00000000d3b00b82 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x853/0x1580 kernel/workqueue.c:2244
  #2: 000000008af22eae (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1207 [inline]
  #2: 000000008af22eae (&dev->mutex){....}, at: hub_event+0x18a/0x3b00  
drivers/usb/core/hub.c:5378
  #3: 000000007f7b7ee0 (&port_dev->status_lock){+.+.}, at: usb_lock_port  
drivers/usb/core/hub.c:2994 [inline]
  #3: 000000007f7b7ee0 (&port_dev->status_lock){+.+.}, at: hub_port_connect  
drivers/usb/core/hub.c:5020 [inline]
  #3: 000000007f7b7ee0 (&port_dev->status_lock){+.+.}, at:  
hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  #3: 000000007f7b7ee0 (&port_dev->status_lock){+.+.}, at: port_event  
drivers/usb/core/hub.c:5350 [inline]
  #3: 000000007f7b7ee0 (&port_dev->status_lock){+.+.}, at:  
hub_event+0x11a3/0x3b00 drivers/usb/core/hub.c:5432
  #4: 0000000090909ece (hcd->address0_mutex){+.+.}, at:  
hub_port_init+0x1bb/0x2d30 drivers/usb/core/hub.c:4529

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 23 Comm: khungtaskd Not tainted 5.1.0-rc4-g9a33b36-dirty #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x48/0x87 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1a6/0x1bd lib/nmi_backtrace.c:62
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0x98e/0xe20 kernel/hung_task.c:288
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x2/0x10  
arch/x86/include/asm/irqflags.h:57


Tested on:

commit:         9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=10b5e057200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131dca6b200000

