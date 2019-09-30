Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16B9C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9787921855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbfI3O5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:57:03 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:43807 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbfI3O5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:57:02 -0400
Received: by mail-io1-f70.google.com with SMTP id i2so30617408ioo.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 07:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=42KUqU1W4OCtfUlQowFihtX9cTfuP2kqz68cgFvvcQ0=;
        b=KNZUIHU8LQiWeC9Qd+vlNPryFO0EpAcREzw0FMio+Hay2HqM0u+sfoMUrj67Et3iFO
         H3nctweeOsu60PTsOFq9QThRsHIVp4RSQyUAyDoqrx+F/fqwbZ8oNQvWW4yxxpYdNMV/
         RECsoJk8521tNlwxYLo8+EhkGDk9SPfhjY81QmqDRRDC301ixorzniiW+9/aI/h5/KG9
         AzhazSx4/RQv05d/hW37wkkXUCc2OSPnM5aExFUP5uhiiQUzMn2TGBY6sMmxv3k+Hjto
         i2WI7wqppzPLCXDah3UCrivdcObHiS8s2ayVhgELJO8jFkuu1/yWT3iD78RaoXL0U5Q0
         CxEw==
X-Gm-Message-State: APjAAAW8HhuQnD8gzSMOolzAowzm5Pzs925/wdcEMyXg4Neip3CdyMPm
        4G6YkA8cwdXcCq7Typre4/CEtk7N0cGD0SxWIMHqa1NRJPTZ
X-Google-Smtp-Source: APXvYqzBP4to3HntwvNqyXnQLctPZQU+tSiV0js82UR7MeDQNQ43qZSgtpNaraT4S6du/RGOwFfybjD1nLfFPDYzFOLuIW+qfZai
MIME-Version: 1.0
X-Received: by 2002:a5d:85cc:: with SMTP id e12mr11781378ios.243.1569855421379;
 Mon, 30 Sep 2019 07:57:01 -0700 (PDT)
Date:   Mon, 30 Sep 2019 07:57:01 -0700
In-Reply-To: <1569853679.2639.4.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd7df40593c672ac@google.com>
Subject: Re: WARNING in _chaoskey_fill/usb_submit_urb
From:   syzbot <syzbot+f5349b421c6213d34ce2@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
INFO: task hung in chaoskey_disconnect

INFO: task kworker/0:0:5 blocked for more than 143 seconds.
       Not tainted 5.3.0+ #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:0     D25832     5      2 0x80004000
Workqueue: usb_hub_wq hub_event
Call Trace:
  schedule+0xca/0x250 kernel/sched/core.c:4123
  schedule_timeout+0x682/0xb20 kernel/time/timer.c:1869
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x26f/0x3c0 kernel/sched/completion.c:136
  kthread_stop+0x10c/0x600 kernel/kthread.c:559
  hwrng_unregister+0x190/0x210 drivers/char/hw_random/core.c:538
  chaoskey_disconnect+0x1b2/0x200 drivers/usb/misc/chaoskey.c:231
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
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
INFO: task kworker/1:1:22 blocked for more than 143 seconds.
       Not tainted 5.3.0+ #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:1     D26096    22      2 0x80004000
Workqueue: usb_hub_wq hub_event
Call Trace:
  schedule+0xca/0x250 kernel/sched/core.c:4123
  schedule_timeout+0x682/0xb20 kernel/time/timer.c:1869
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x26f/0x3c0 kernel/sched/completion.c:136
  kthread_stop+0x10c/0x600 kernel/kthread.c:559
  hwrng_unregister+0x190/0x210 drivers/char/hw_random/core.c:538
  chaoskey_disconnect+0x1b2/0x200 drivers/usb/misc/chaoskey.c:231
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
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
INFO: task kworker/0:3:2851 blocked for more than 143 seconds.
       Not tainted 5.3.0+ #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:3     D25960  2851      2 0x80004000
Workqueue: usb_hub_wq hub_event
Call Trace:
  schedule+0xca/0x250 kernel/sched/core.c:4123
  schedule_timeout+0x682/0xb20 kernel/time/timer.c:1869
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x26f/0x3c0 kernel/sched/completion.c:136
  kthread_stop+0x10c/0x600 kernel/kthread.c:559
  hwrng_unregister+0x190/0x210 drivers/char/hw_random/core.c:538
  chaoskey_disconnect+0x1b2/0x200 drivers/usb/misc/chaoskey.c:231
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
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
INFO: task kworker/1:3:2862 blocked for more than 144 seconds.
       Not tainted 5.3.0+ #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:3     D25680  2862      2 0x80004000
Workqueue: usb_hub_wq hub_event
Call Trace:
  schedule+0xca/0x250 kernel/sched/core.c:4123
  schedule_timeout+0x682/0xb20 kernel/time/timer.c:1869
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x26f/0x3c0 kernel/sched/completion.c:136
  kthread_stop+0x10c/0x600 kernel/kthread.c:559
  hwrng_unregister+0x190/0x210 drivers/char/hw_random/core.c:538
  chaoskey_disconnect+0x1b2/0x200 drivers/usb/misc/chaoskey.c:231
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
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Showing all locks held in the system:
5 locks held by kworker/0:0/5:
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: ffff8881da1c7dd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: ffff8881d5d70200 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #2: ffff8881d5d70200 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: ffff8881d602a400 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #3: ffff8881d602a400 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: ffff8881d602c590 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162
5 locks held by kworker/1:1/22:
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: ffff8881d9697dd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: ffff8881d5cdce80 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #2: ffff8881d5cdce80 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: ffff8881c9fdbd80 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #3: ffff8881c9fdbd80 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: ffff8881d76e6790 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162
1 lock held by khungtaskd/23:
  #0: ffffffff86cff360 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x53/0x269 kernel/locking/lockdep.c:5335
1 lock held by rsyslogd/1596:
  #0: ffff8881d987f9e0 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xe3/0x100  
fs/file.c:801
2 locks held by getty/1686:
  #0: ffff8881d67dd590 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc9000045d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1687:
  #0: ffff8881d9041190 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc9000047d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1688:
  #0: ffff8881d9047790 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc9000044d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1689:
  #0: ffff8881d903d590 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc900004752e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1690:
  #0: ffff8881d903e690 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc9000046d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1691:
  #0: ffff8881d903de10 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc900004712e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1692:
  #0: ffff8881d67de690 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc900004452e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
5 locks held by kworker/0:2/2807:
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: ffff8881c780fdd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: ffff8881d5d08a80 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #2: ffff8881d5d08a80 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: ffff8881d6601300 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #3: ffff8881d6601300 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: ffff8881d602ac10 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162
5 locks held by kworker/0:3/2851:
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: ffff8881d80b7dd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: ffff8881d5cd9300 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #2: ffff8881d5cd9300 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: ffff8881d6000a80 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #3: ffff8881d6000a80 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: ffff8881d6001b10 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162
5 locks held by kworker/1:3/2862:
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: ffff8881c19efdd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: ffff8881d5d0c600 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #2: ffff8881d5d0c600 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: ffff8881d814f080 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #3: ffff8881d814f080 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: ffff8881d814f890 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162
5 locks held by kworker/1:5/2877:
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8881d91f48a8 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: ffff8881d7507dd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: ffff8881d5ca5700 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #2: ffff8881d5ca5700 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: ffff8881c9f08200 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #3: ffff8881c9f08200 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: ffff8881d9035690 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 23 Comm: khungtaskd Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x55/0x96 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1b0/0x1c7 lib/nmi_backtrace.c:62
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0x9a4/0xe50 kernel/hung_task.c:289
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt  
arch/x86/include/asm/irqflags.h:60 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt  
arch/x86/include/asm/irqflags.h:103 [inline]
NMI backtrace for cpu 1 skipped: idling at default_idle+0x28/0x2e0  
arch/x86/kernel/process.c:580


Tested on:

commit:         e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11c486ed600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
dashboard link: https://syzkaller.appspot.com/bug?extid=f5349b421c6213d34ce2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136ea5cb600000

