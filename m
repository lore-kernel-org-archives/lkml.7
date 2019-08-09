Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F05BC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A4021743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407064AbfHINSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:18:14 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70]:41537 "EHLO
        mail-ot1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406983AbfHINSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:18:09 -0400
Received: by mail-ot1-f70.google.com with SMTP id a8so68644606oti.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 06:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PtjYP2dvCVpfxoaWoUHNWDGwSVoxGAUAlsa4Z7xjykY=;
        b=XPZzFriodfKxPM2m3GrM4rCmY4jKqBLjZiBiD4lmnov2DxL1NcwyK1qKVlMWqNOvHN
         5O5UwPIN4NAMlTEi63ToVQP8GOFu1YKaggshHrrVT7z7cw9i+HDYMPKQiNNuAocxxS08
         DNMXbfIQ5l2ZsKaTmKEJgo2EoBrEb04XJspdEjH8SEmQLgqkEbOwFrnaadqLAy337iU2
         bLrEEbXmXZ2lOLioITKV5ETbYsgF+tTYzKeg/wERU1vsDCu+1CMP7W2SqTabzg4moxV0
         o0VjlQIrrottcrB7WVRqiDBlFLwQp4aGPzYjt9pJBLoJExukbp9omzkRN1Y24SDEarfr
         Jjzg==
X-Gm-Message-State: APjAAAWqNnTWinHj8PDPiuROsTjYjX92VKR3B+7bi5k+tug0VrlnEgJA
        MNT6Z0gSj+V58cmwo+VKW8KoSvzzcFxTuhpHzvxNHdQ5FIQ3
X-Google-Smtp-Source: APXvYqzobcLgY0YacTTzSlUVKUQ24FY06ILWFief5uoUJpVxA0zMT9fIzbFzT6q8ct10gwajYo1TQWzi9OGxexXslZCQJNCCDAje
MIME-Version: 1.0
X-Received: by 2002:a02:4005:: with SMTP id n5mr23165765jaa.73.1565356687886;
 Fri, 09 Aug 2019 06:18:07 -0700 (PDT)
Date:   Fri, 09 Aug 2019 06:18:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000542276058faf0117@google.com>
Subject: INFO: rcu detected stall in dummy_timer
From:   syzbot <syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=102b8c4a600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
dashboard link: https://syzkaller.appspot.com/bug?extid=b24d736f18a1541ad550
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12edd636600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com

imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
rcu: INFO: rcu_sched self-detected stall on CPU
rcu: 	0-...!: (1 GPs behind) idle=36e/1/0x4000000000000004  
softirq=16230/16230 fqs=0
	(t=10500 jiffies g=22005 q=99)
rcu: rcu_sched kthread starved for 10500 jiffies! g22005 f0x0  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_sched       R  running task    29424    10      2 0x80004000
Call Trace:
  schedule+0x9a/0x250 kernel/sched/core.c:3944
  schedule_timeout+0x440/0xb20 kernel/time/timer.c:1807
  rcu_gp_fqs_loop kernel/rcu/tree.c:1611 [inline]
  rcu_gp_kthread+0xb01/0x27f0 kernel/rcu/tree.c:1768
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
NMI backtrace for cpu 0
CPU: 0 PID: 2795 Comm: kworker/0:4 Not tainted 5.3.0-rc2+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x55/0x96 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1b0/0x1c7 lib/nmi_backtrace.c:62
  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x169/0x1b3 kernel/rcu/tree_stall.h:254
  print_cpu_stall kernel/rcu/tree_stall.h:455 [inline]
  check_cpu_stall kernel/rcu/tree_stall.h:529 [inline]
  rcu_pending kernel/rcu/tree.c:2736 [inline]
  rcu_sched_clock_irq.cold+0x4a4/0x8d8 kernel/rcu/tree.c:2183
  update_process_times+0x2a/0x70 kernel/time/timer.c:1639
  tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:167
  tick_sched_timer+0x42/0x130 kernel/time/tick-sched.c:1296
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x303/0xc50 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x2e8/0x730 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1068 [inline]
  smp_apic_timer_interrupt+0xf5/0x500 arch/x86/kernel/apic/apic.c:1093
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:828
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/irqflags.h:85 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
[inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x40/0x50  
kernel/locking/spinlock.c:191
Code: e8 a5 d6 b7 fb 48 89 ef e8 4d b7 b8 fb f6 c7 02 75 11 53 9d e8 21 6b  
d5 fb 65 ff 0d 82 3f 94 7a 5b 5d c3 e8 32 69 d5 fb 53 9d <eb> ed 0f 1f 40  
00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 fd 65 ff
RSP: 0018:ffff8881db209b08 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000007 RBX: 0000000000000206 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8881c7023844
RBP: ffff8881da16c200 R08: ffff8881c7023000 R09: fffffbfff11acda2
R10: fffffbfff11acda1 R11: ffffffff88d66d0f R12: 0000000000000080
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8881c9263d00
  spin_unlock_irqrestore include/linux/spinlock.h:393 [inline]
  dummy_timer+0x131b/0x2fa2 drivers/usb/gadget/udc/dummy_hcd.c:1979
  call_timer_fn+0x179/0x650 kernel/time/timer.c:1322
  expire_timers kernel/time/timer.c:1366 [inline]
  __run_timers kernel/time/timer.c:1685 [inline]
  __run_timers kernel/time/timer.c:1653 [inline]
  run_timer_softirq+0x5cc/0x14b0 kernel/time/timer.c:1698
  __do_softirq+0x221/0x912 kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x178/0x1a0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:537 [inline]
  smp_apic_timer_interrupt+0x12f/0x500 arch/x86/kernel/apic/apic.c:1095
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:828
  </IRQ>
RIP: 0010:__kernfs_new_node+0x164/0x640 fs/kernfs/dir.c:639
Code: 00 00 00 4c 89 e6 4c 89 ff 89 44 24 08 e8 a4 fd df 03 31 ff 89 c5 89  
c6 e8 a9 30 b6 ff 85 ed 0f 88 5a 03 00 00 e8 2c 2f b6 ff <49> 8d 7d 60 48  
b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f
RSP: 0018:ffff8881c169ede8 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8881c7023000 RBX: 1ffff110382d3dc0 RCX: ffffffff8187bf97
RDX: 0000000000000000 RSI: ffffffff8187bfa4 RDI: 0000000000000005
RBP: 00000000000151f1 R08: ffff8881c7023000 R09: ffffed10380019fe
R10: ffffed10380019fd R11: ffff8881c000cfef R12: ffff8881d2066460
R13: ffff8881da0d7000 R14: ffffffff85f26980 R15: ffff8881da0d7010
  kernfs_new_node+0x93/0x120 fs/kernfs/dir.c:697
  kernfs_create_link+0xcb/0x230 fs/kernfs/symlink.c:39
  sysfs_do_create_link_sd.isra.0+0x8b/0x130 fs/sysfs/symlink.c:44
  sysfs_do_create_link fs/sysfs/symlink.c:80 [inline]
  sysfs_create_link+0x61/0xc0 fs/sysfs/symlink.c:92
  device_add_class_symlinks drivers/base/core.c:1859 [inline]
  device_add+0x6ec/0x16f0 drivers/base/core.c:2080
  device_create_groups_vargs+0x203/0x280 drivers/base/core.c:2758
  device_create_vargs drivers/base/core.c:2798 [inline]
  device_create+0xdf/0x120 drivers/base/core.c:2834
  usb_register_dev drivers/usb/core/file.c:202 [inline]
  usb_register_dev+0x279/0x6a0 drivers/usb/core/file.c:156
  imon_init_display drivers/media/rc/imon.c:2343 [inline]
  imon_probe+0x244d/0x2af0 drivers/media/rc/imon.c:2426
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
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
