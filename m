Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA127C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D902087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfDPQTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:19:03 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:34249 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfDPQTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:19:02 -0400
Received: by mail-io1-f72.google.com with SMTP id y13so17153643iol.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ztS70Oh1RnCMIr2pF0j3Y68eKrfInzGtiHiQwDvxXZU=;
        b=OPxz50DkCQYI75FZhGnfNDmc6Y7WjDKrGzqvISvu4x6pMj+GddAjCT96zsO9BHNJhb
         D+n8aFZI5lNixXkpyk2/8Q58MDgn2n4zUgV5jZYNoMd0e6mQmwJ5VwDhWFJ8RxDKyr4r
         NiEH95wlOn4um1wbHcOQgQ4/S17TKTt13DmQbu1whNEJ6o0dPAsHd6WISLCaxfl8WGkb
         URUM5ZomhyseWxNBVBxttzOQTd4q1mJ8k33UEvkeH9EZnQ29bR6hM0RwzrUdjA+tKA/H
         AvWGFh8If0Hq8r5F1jJAOGP735DggH8Sb86JUhjSTNMGamD/xk/CZ6lCNe131D0rFUkY
         nI/Q==
X-Gm-Message-State: APjAAAUPGGStwZJ7Q1AyzTUEfIONLsTcUN48RFtSkwyua3xDIv+cbOH3
        wSkP+1wLJ3FFu8woehGAAT4xVagAEPk6YxYI/wRAQx793o0i
X-Google-Smtp-Source: APXvYqyPeIRPwDDbPmxo91ABHc32TGFLHhWCfxAyIGv/kmYrinqfqycQTENjOSifrEZlF4kl9GBM1feDA83PUOq9Gepk15uABi17
MIME-Version: 1.0
X-Received: by 2002:a24:5508:: with SMTP id e8mr2303403itb.1.1555431540617;
 Tue, 16 Apr 2019 09:19:00 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:19:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1904161132370.1605-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007380f90586a82005@google.com>
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

usb-fuzzer-gadget dummy_udc.4: failed to start USB fuzzer: -22
dummy_udc dummy_udc.4: dummy_udc_start
dummy_udc dummy_udc.3: dummy_udc_stop
usb-fuzzer-gadget dummy_udc.3: failed to start USB fuzzer: -22
dummy_udc dummy_udc.3: dummy_udc_start
INFO: task kworker/1:1:21 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4-g9a33b36-dirty #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:1     D26616    21      2 0x80000000
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
  hub_port_connect drivers/usb/core/hub.c:5021 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x11b8/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
dummy_udc dummy_udc.2: dummy_udc_stop
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
INFO: task kworker/0:4:6014 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4-g9a33b36-dirty #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:4     D27752  6014      2 0x80000000
Workqueue: usb_hub_wq hub_event
Call Trace:
usb-fuzzer-gadget dummy_udc.2: failed to start USB fuzzer: -22
  schedule+0x8f/0x180 kernel/sched/core.c:3562
  usb_kill_urb drivers/usb/core/urb.c:695 [inline]
  usb_kill_urb+0x22a/0x2c0 drivers/usb/core/urb.c:687
  usb_start_wait_urb+0x257/0x4d0 drivers/usb/core/message.c:63
dummy_udc dummy_udc.5: dummy_udc_stop
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x321/0x4a0 drivers/usb/core/message.c:152
  hub_port_init+0x81d/0x2d30 drivers/usb/core/hub.c:4655
  hub_port_connect drivers/usb/core/hub.c:5021 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x11b8/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
usb-fuzzer-gadget dummy_udc.5: failed to start USB fuzzer: -22
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
dummy_udc dummy_udc.1: dummy_udc_stop
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
dummy_udc dummy_udc.2: dummy_udc_start
INFO: task kworker/0:5:6019 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4-g9a33b36-dirty #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
usb-fuzzer-gadget dummy_udc.1: failed to start USB fuzzer: -22
kworker/0:5     D27752  6019      2 0x80000000
Workqueue: usb_hub_wq hub_event
Call Trace:
  schedule+0x8f/0x180 kernel/sched/core.c:3562
  usb_kill_urb drivers/usb/core/urb.c:695 [inline]
  usb_kill_urb+0x22a/0x2c0 drivers/usb/core/urb.c:687
dummy_udc dummy_udc.5: dummy_udc_start
dummy_udc dummy_udc.1: dummy_udc_start
  usb_start_wait_urb+0x257/0x4d0 drivers/usb/core/message.c:63
dummy_udc dummy_udc.0: dummy_udc_stop
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x321/0x4a0 drivers/usb/core/message.c:152
  hub_port_init+0x81d/0x2d30 drivers/usb/core/hub.c:4655
  hub_port_connect drivers/usb/core/hub.c:5021 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x11b8/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
INFO: task kworker/1:4:6060 blocked for more than 144 seconds.
       Not tainted 5.1.0-rc4-g9a33b36-dirty #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:4     D27752  6060      2 0x80000000
dummy_udc dummy_udc.0: dummy_udc_start
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

Showing all locks held in the system:
5 locks held by kworker/1:1/21:
dummy_udc dummy_udc.4: dummy_udc_stop
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x81f/0x1580 kernel/workqueue.c:2240
  #1: 00000000bef12525 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x853/0x1580 kernel/workqueue.c:2244
  #2: 000000009a337b20 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1207 [inline]
  #2: 000000009a337b20 (&dev->mutex){....}, at: hub_event+0x18a/0x3b00  
drivers/usb/core/hub.c:5378
  #3: 00000000449599d5 (&port_dev->status_lock){+.+.}, at: usb_lock_port  
drivers/usb/core/hub.c:2994 [inline]
  #3: 00000000449599d5 (&port_dev->status_lock){+.+.}, at: hub_port_connect  
drivers/usb/core/hub.c:5020 [inline]
  #3: 00000000449599d5 (&port_dev->status_lock){+.+.}, at:  
hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  #3: 00000000449599d5 (&port_dev->status_lock){+.+.}, at: port_event  
drivers/usb/core/hub.c:5350 [inline]
  #3: 00000000449599d5 (&port_dev->status_lock){+.+.}, at:  
hub_event+0x11a3/0x3b00 drivers/usb/core/hub.c:5432
usb-fuzzer-gadget dummy_udc.4: failed to start USB fuzzer: -22
  #4: 00000000bd693e6d (hcd->address0_mutex){+.+.}, at:  
hub_port_init+0x1bb/0x2d30 drivers/usb/core/hub.c:4529
1 lock held by khungtaskd/23:
  #0: 00000000c249679f (rcu_read_lock){....}, at:  
debug_show_all_locks+0x53/0x269 kernel/locking/lockdep.c:5059
5 locks held by kworker/1:2/533:
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x81f/0x1580 kernel/workqueue.c:2240
dummy_udc dummy_udc.3: dummy_udc_stop
  #1: 000000000b2c3268 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x853/0x1580 kernel/workqueue.c:2244
  #2: 000000005e422e33 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1207 [inline]
  #2: 000000005e422e33 (&dev->mutex){....}, at: hub_event+0x18a/0x3b00  
drivers/usb/core/hub.c:5378
dummy_udc dummy_udc.4: dummy_udc_start
  #3: 00000000a7ffda5b (&port_dev->status_lock){+.+.}, at: usb_lock_port  
drivers/usb/core/hub.c:2994 [inline]
  #3: 00000000a7ffda5b (&port_dev->status_lock){+.+.}, at: hub_port_connect  
drivers/usb/core/hub.c:5020 [inline]
  #3: 00000000a7ffda5b (&port_dev->status_lock){+.+.}, at:  
hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  #3: 00000000a7ffda5b (&port_dev->status_lock){+.+.}, at: port_event  
drivers/usb/core/hub.c:5350 [inline]
  #3: 00000000a7ffda5b (&port_dev->status_lock){+.+.}, at:  
hub_event+0x11a3/0x3b00 drivers/usb/core/hub.c:5432
  #4: 0000000040171de2 (hcd->address0_mutex){+.+.}, at:  
hub_port_init+0x1bb/0x2d30 drivers/usb/core/hub.c:4529
1 lock held by rsyslogd/5663:
  #0: 00000000eb497534 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xe8/0x100  
fs/file.c:801
2 locks held by getty/5753:
usb-fuzzer-gadget dummy_udc.3: failed to start USB fuzzer: -22
  #0: 0000000060cabbb9 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 00000000c554441b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
2 locks held by getty/5754:
  #0: 00000000bc2e3243 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 00000000c105aa12 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
2 locks held by getty/5755:
  #0: 00000000e6d82cc9 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 000000007478c77a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
dummy_udc dummy_udc.3: dummy_udc_start
2 locks held by getty/5756:
  #0: 00000000bdf7f201 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 0000000027b0060b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
2 locks held by getty/5757:
  #0: 00000000ea25225e (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 0000000033c7c6b0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
2 locks held by getty/5758:
  #0: 0000000026e22b8e (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 00000000cc9d99b6 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
2 locks held by getty/5759:
  #0: 000000000c56f37f (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:272
  #1: 0000000096b5ec30 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x21c/0x1a60 drivers/tty/n_tty.c:2156
5 locks held by kworker/0:4/6014:
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x81f/0x1580 kernel/workqueue.c:2240
  #1: 000000008858d04f ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x853/0x1580 kernel/workqueue.c:2244
  #2: 0000000035fa4a95 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1207 [inline]
  #2: 0000000035fa4a95 (&dev->mutex){....}, at: hub_event+0x18a/0x3b00  
drivers/usb/core/hub.c:5378
  #3: 00000000b9e8bc7b (&port_dev->status_lock){+.+.}, at: usb_lock_port  
drivers/usb/core/hub.c:2994 [inline]
  #3: 00000000b9e8bc7b (&port_dev->status_lock){+.+.}, at: hub_port_connect  
drivers/usb/core/hub.c:5020 [inline]
  #3: 00000000b9e8bc7b (&port_dev->status_lock){+.+.}, at:  
hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  #3: 00000000b9e8bc7b (&port_dev->status_lock){+.+.}, at: port_event  
drivers/usb/core/hub.c:5350 [inline]
  #3: 00000000b9e8bc7b (&port_dev->status_lock){+.+.}, at:  
hub_event+0x11a3/0x3b00 drivers/usb/core/hub.c:5432
  #4: 0000000029c7e38f (hcd->address0_mutex){+.+.}, at:  
hub_port_init+0x1bb/0x2d30 drivers/usb/core/hub.c:4529
5 locks held by kworker/0:5/6019:
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x81f/0x1580 kernel/workqueue.c:2240
  #1: 00000000406d5ccc ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x853/0x1580 kernel/workqueue.c:2244
  #2: 00000000a0e74d96 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1207 [inline]
  #2: 00000000a0e74d96 (&dev->mutex){....}, at: hub_event+0x18a/0x3b00  
drivers/usb/core/hub.c:5378
  #3: 00000000f7d2af58 (&port_dev->status_lock){+.+.}, at: usb_lock_port  
drivers/usb/core/hub.c:2994 [inline]
  #3: 00000000f7d2af58 (&port_dev->status_lock){+.+.}, at: hub_port_connect  
drivers/usb/core/hub.c:5020 [inline]
  #3: 00000000f7d2af58 (&port_dev->status_lock){+.+.}, at:  
hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  #3: 00000000f7d2af58 (&port_dev->status_lock){+.+.}, at: port_event  
drivers/usb/core/hub.c:5350 [inline]
  #3: 00000000f7d2af58 (&port_dev->status_lock){+.+.}, at:  
hub_event+0x11a3/0x3b00 drivers/usb/core/hub.c:5432
  #4: 00000000f0b5cba1 (hcd->address0_mutex){+.+.}, at:  
hub_port_init+0x1bb/0x2d30 drivers/usb/core/hub.c:4529
5 locks held by kworker/0:6/6023:
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x81f/0x1580 kernel/workqueue.c:2240
  #1: 00000000f6fcfe1c ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x853/0x1580 kernel/workqueue.c:2244
  #2: 00000000c3342998 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1207 [inline]
  #2: 00000000c3342998 (&dev->mutex){....}, at: hub_event+0x18a/0x3b00  
drivers/usb/core/hub.c:5378
  #3: 000000004d7e0c6e (&port_dev->status_lock){+.+.}, at: usb_lock_port  
drivers/usb/core/hub.c:2994 [inline]
  #3: 000000004d7e0c6e (&port_dev->status_lock){+.+.}, at: hub_port_connect  
drivers/usb/core/hub.c:5020 [inline]
  #3: 000000004d7e0c6e (&port_dev->status_lock){+.+.}, at:  
hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  #3: 000000004d7e0c6e (&port_dev->status_lock){+.+.}, at: port_event  
drivers/usb/core/hub.c:5350 [inline]
  #3: 000000004d7e0c6e (&port_dev->status_lock){+.+.}, at:  
hub_event+0x11a3/0x3b00 drivers/usb/core/hub.c:5432
  #4: 00000000f25b0237 (hcd->address0_mutex){+.+.}, at:  
hub_port_init+0x1bb/0x2d30 drivers/usb/core/hub.c:4529
5 locks held by kworker/1:4/6060:
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 00000000469d4ddc ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x81f/0x1580 kernel/workqueue.c:2240
  #1: 00000000a61f1995 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x853/0x1580 kernel/workqueue.c:2244
  #2: 00000000fd9214fe (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1207 [inline]
  #2: 00000000fd9214fe (&dev->mutex){....}, at: hub_event+0x18a/0x3b00  
drivers/usb/core/hub.c:5378
  #3: 000000000baf27f8 (&port_dev->status_lock){+.+.}, at: usb_lock_port  
drivers/usb/core/hub.c:2994 [inline]
  #3: 000000000baf27f8 (&port_dev->status_lock){+.+.}, at: hub_port_connect  
drivers/usb/core/hub.c:5020 [inline]
  #3: 000000000baf27f8 (&port_dev->status_lock){+.+.}, at:  
hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  #3: 000000000baf27f8 (&port_dev->status_lock){+.+.}, at: port_event  
drivers/usb/core/hub.c:5350 [inline]
  #3: 000000000baf27f8 (&port_dev->status_lock){+.+.}, at:  
hub_event+0x11a3/0x3b00 drivers/usb/core/hub.c:5432
  #4: 000000006e962192 (hcd->address0_mutex){+.+.}, at:  
hub_port_init+0x1bb/0x2d30 drivers/usb/core/hub.c:4529

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 23 Comm: khungtaskd Not tainted 5.1.0-rc4-g9a33b36-dirty #1
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5881 Comm: syz-executor.0 Not tainted 5.1.0-rc4-g9a33b36-dirty  
#1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:193 [inline]
RIP: 0010:lookup_chain_cache kernel/locking/lockdep.c:2612 [inline]
RIP: 0010:lookup_chain_cache_add kernel/locking/lockdep.c:2631 [inline]
RIP: 0010:validate_chain kernel/locking/lockdep.c:2685 [inline]
RIP: 0010:__lock_acquire+0xfb0/0x37c0 kernel/locking/lockdep.c:3701
Code: 5d 4c 8b 64 24 20 4d 89 cd 48 bd 00 00 00 00 00 fc ff df eb 06 48 83  
eb 08 74 40 48 8d 7b 18 48 89 f8 48 c1 e8 03 80 3c 28 00 <0f> 85 f1 18 00  
00 48 8b 43 18 49 39 c4 0f 84 73 f9 ff ff 48 8d 7b
RSP: 0018:ffff88809908fa50 EFLAGS: 00000046
RAX: 1ffffffff2c188b3 RBX: ffffffff960c4580 RCX: 0000000000001872
RDX: 1ffffffff2cd93fa RSI: ffff88808be80840 RDI: ffffffff960c4598
RBP: dffffc0000000000 R08: 00000000d4b587bd R09: ffffffff966c9fd0
R10: ffff88808be80840 R11: ffff88808be80000 R12: e085ce875e243443
R13: ffffffff966c9fd0 R14: ffffffff93cb0714 R15: 0000000000000001
FS:  0000000000a57940(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbda8a77000 CR3: 0000000095e60000 CR4: 00000000001406f0
Call Trace:
  lock_acquire+0x10d/0x2f0 kernel/locking/lockdep.c:4211
  __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
  _raw_read_lock+0x2f/0x40 kernel/locking/spinlock.c:216
  do_wait+0x38b/0x940 kernel/exit.c:1523
  kernel_wait4+0x151/0x260 kernel/exit.c:1668
  __do_sys_wait4+0x147/0x160 kernel/exit.c:1680
  do_syscall_64+0xcf/0x4f0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x412c6a
Code: 0f 83 6a 18 00 00 c3 66 0f 1f 84 00 00 00 00 00 8b 05 2e 36 64 00 85  
c0 75 36 45 31 d2 48 63 d2 48 63 ff b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff  
ff 77 06 c3 0f 1f 44 00 00 48 c7 c2 d4 ff ff ff f7
RSP: 002b:00007fff92403508 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 000000000003d770 RCX: 0000000000412c6a
RDX: 0000000040000001 RSI: 00007fff92403540 RDI: ffffffffffffffff
RBP: 00000000000000ad R08: 0000000000000001 R09: 0000000000a57940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff92403540 R14: 000000000003d752 R15: 00007fff92403550


Tested on:

commit:         9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=111e62cb200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1207901d200000

