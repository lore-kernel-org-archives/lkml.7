Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED22C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6FC20842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfI3OFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:05:04 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41752 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3OFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:05:03 -0400
Received: by mail-io1-f72.google.com with SMTP id q18so30354163ios.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 07:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IqysUfeEGuQZVRXYUAHyzpeZ0XqvEIek/uVkFFzLfps=;
        b=jTPhsC9WKEGX4LdY+m6hflkhqWQ8QB4Uj7++D2iHh7egHdnZeWLzwHCAwGUC74sdEA
         VVpIuhOo+wJZUfCgD9cWQBqJJw48XcPsuoLjta6R2l7xOeRyCaEhzpMH38T8Rv8150Bt
         l/a7R5mePK2zJyID+pbvI4WQIyzDa1wLh+BeIgNVY96o7sNAMUMufW2ANfBsZOzHytYx
         MtJnvf6LO2K08IP1BibDXb1h2bEzcBODirf76i7Bi4uf9oIRfbnaRzAz9tVl9z0CW6iI
         zNY56Q0cSZWwlvLybi8ZDsVgiL9L0kMmibGUyQhRwj/Xx4D7VjXvO3hOecJoOGci4Nkc
         Bzjw==
X-Gm-Message-State: APjAAAVIEme+QGPzSy+pImtw2JOY4diS8JGt7/hFdThMjKqaO4ejvQww
        vNyg+yP0Y99SX+PHsawjBh/RkY92XZ3y+H2jCvD74Fm4GJP3
X-Google-Smtp-Source: APXvYqwAOviGaXIF5d7egzYyZUIaPq6QI9ZktPGXqjHIOBUwckMOIp9AsdQZs0gOPqYwiaU9q5yQo6rQiXOXDHp0jz5yI9QB+RQO
MIME-Version: 1.0
X-Received: by 2002:a5d:9a17:: with SMTP id s23mr21123078iol.171.1569852301248;
 Mon, 30 Sep 2019 07:05:01 -0700 (PDT)
Date:   Mon, 30 Sep 2019 07:05:01 -0700
In-Reply-To: <1569850516.2639.2.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c419580593c5b8f0@google.com>
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
kworker/0:0     D25976     5      2 0x80004000
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
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: ffff8881da1c7dd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: ffff8881d5c97900 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #2: ffff8881d5c97900 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: ffff8881d9034600 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #3: ffff8881d9034600 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: ffff8881d9037010 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162
5 locks held by kworker/0:1/12:
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: ffff8881da20fdd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: ffff8881d5d06800 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #2: ffff8881d5d06800 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: ffff8881c9c8b500 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #3: ffff8881c9c8b500 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: ffff8881c9c8a390 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162
5 locks held by kworker/1:1/21:
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: ffff8881da2f7dd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: ffff8881d5cd7080 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #2: ffff8881d5cd7080 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: ffff8881d9135f80 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #3: ffff8881d9135f80 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: ffff8881d9040a10 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162
1 lock held by khungtaskd/23:
  #0: ffffffff86cff360 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x53/0x269 kernel/locking/lockdep.c:5335
1 lock held by rsyslogd/1600:
  #0: ffff8881d654d4e0 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xe3/0x100  
fs/file.c:801
2 locks held by getty/1690:
  #0: ffff8881d919ef10 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc900004592e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1691:
  #0: ffff8881d747b390 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc900004752e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1692:
  #0: ffff8881d919bc10 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc9000046d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1693:
  #0: ffff8881d91c8910 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc900004652e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1694:
  #0: ffff8881d7936f10 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc9000047d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1695:
  #0: ffff8881d91ccd10 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc9000045d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1696:
  #0: ffff8881d9228090 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: ffffc9000044d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
5 locks held by kworker/0:3/2834:
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: ffff8881d950fdd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: ffff8881d5d32400 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #2: ffff8881d5d32400 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: ffff8881c9c8f080 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #3: ffff8881c9c8f080 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: ffff8881c9c8f890 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162
5 locks held by kworker/1:4/2867:
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: ffff8881c708fdd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: ffff8881d5cd3500 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #2: ffff8881d5cd3500 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: ffff8881d9042400 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #3: ffff8881d9042400 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: ffff8881d9044590 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1162
5 locks held by kworker/1:5/2904:
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8881d91c0b28 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: ffff8881d4b7fdd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: ffff8881d5d02c80 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #2: ffff8881d5d02c80 (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: ffff8881d9134e80 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1462 [inline]
  #3: ffff8881d9134e80 (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: ffff8881c9eb7890 (&dev->mutex){....}, at:  
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
NMI backtrace for cpu 1
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:mark_usage kernel/locking/lockdep.c:3551 [inline]
RIP: 0010:__lock_acquire+0x401/0x3eb0 kernel/locking/lockdep.c:3909
Code: 38 01 00 00 45 85 c0 41 89 47 24 0f 84 ee 00 00 00 49 8d 7f 21 48 b8  
00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 <48> 89 fa 83 e2  
07 38 d0 7f 08 84 c0 0f 85 d1 2f 00 00 4d 8d 6f 22
RSP: 0018:ffff8881db309b90 EFLAGS: 00000802
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 1ffff1103b43f713 RSI: 0000000000000027 RDI: ffff8881da1fb899
RBP: ffff8881da1fb000 R08: 0000000000000001 R09: 00000000000c4027
R10: 0000000000000000 R11: ffffffff878a4807 R12: 0000000000000027
R13: 0000000000040000 R14: 0000000000000002 R15: ffff8881da1fb878
FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001c06c2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4487
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x27/0x40 kernel/locking/spinlock.c:151
  rq_lock kernel/sched/sched.h:1211 [inline]
  ttwu_queue kernel/sched/core.c:2407 [inline]
  try_to_wake_up+0xaf0/0x15e0 kernel/sched/core.c:2643
  hrtimer_wakeup+0x43/0x60 kernel/time/hrtimer.c:1766
  __run_hrtimer kernel/time/hrtimer.c:1514 [inline]
  __hrtimer_run_queues+0x303/0xc50 kernel/time/hrtimer.c:1576
  hrtimer_interrupt+0x2e8/0x730 kernel/time/hrtimer.c:1638
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
  smp_apic_timer_interrupt+0xf5/0x500 arch/x86/kernel/apic/apic.c:1135
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  </IRQ>
RIP: 0010:default_idle+0x28/0x2e0 arch/x86/kernel/process.c:581
Code: 90 90 41 56 41 55 65 44 8b 2d 94 9d 90 7a 41 54 55 53 0f 1f 44 00 00  
e8 36 71 d2 fb e9 07 00 00 00 0f 00 2d ca 43 51 00 fb f4 <65> 44 8b 2d 70  
9d 90 7a 0f 1f 44 00 00 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffff8881da217dc8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000007 RBX: ffff8881da1fb000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff8881da1fb84c
RBP: ffffed103b43f600 R08: ffff8881da1fb000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x3b6/0x500 kernel/sched/idle.c:264
  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:356
  start_secondary+0x27d/0x330 arch/x86/kernel/smpboot.c:264
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241


Tested on:

commit:         e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=114486ed600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
dashboard link: https://syzkaller.appspot.com/bug?extid=f5349b421c6213d34ce2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16425605600000

