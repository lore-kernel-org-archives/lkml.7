Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC82C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6818E20874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfDVPjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:39:07 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37576 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726260AbfDVPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:39:07 -0400
Received: (qmail 4843 invoked by uid 2102); 22 Apr 2019 11:39:06 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Apr 2019 11:39:06 -0400
Date:   Mon, 22 Apr 2019 11:39:06 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <rafael@kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in __dev_printk
In-Reply-To: <00000000000096874e0586e8b5a6@google.com>
Message-ID: <Pine.LNX.4.44L0.1904221128560.1384-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered  
> crash:
> INFO: rcu detected stall in dummy_timer
> 
> yurex 1-1:0.150: yurex_interrupt - unknown status received: -71
> yurex 2-1:0.150: yurex_interrupt - unknown status received: -71
> yurex 6-1:0.150: yurex_interrupt - unknown status received: -71
> yurex 5-1:0.150: yurex_interrupt - unknown status received: -71
> yurex 3-1:0.150: yurex_interrupt - unknown status received: -71
> rcu: INFO: rcu_sched self-detected stall on CPU
> rcu: 	0-....: (9525 ticks this GP) idle=b9e/1/0x4000000000000002  
> softirq=12303/12303 fqs=3519
> yurex 5-1:0.150: yurex_interrupt - unknown status received: -71
> rcu: 	 (t=10501 jiffies g=8933 q=1449)
> NMI backtrace for cpu 0
> CPU: 0 PID: 5568 Comm: kworker/0:4 Not tainted 5.1.0-rc5-gd34f951-dirty #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xe8/0x16e lib/dump_stack.c:113
>   nmi_cpu_backtrace.cold+0x48/0x87 lib/nmi_backtrace.c:101
>   nmi_trigger_cpumask_backtrace+0x1a6/0x1bd lib/nmi_backtrace.c:62
>   trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
>   rcu_dump_cpu_stacks+0x16e/0x1b8 kernel/rcu/tree.c:1223
>   print_cpu_stall kernel/rcu/tree.c:1360 [inline]
>   check_cpu_stall kernel/rcu/tree.c:1434 [inline]
>   rcu_pending kernel/rcu/tree.c:3103 [inline]
>   rcu_sched_clock_irq.cold+0x4cf/0x7d0 kernel/rcu/tree.c:2544
>   update_process_times+0x2f/0x70 kernel/time/timer.c:1635
>   tick_sched_handle+0xa0/0x180 kernel/time/tick-sched.c:161
>   tick_sched_timer+0x47/0x130 kernel/time/tick-sched.c:1271
>   __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
>   __hrtimer_run_queues+0x2d7/0xbd0 kernel/time/hrtimer.c:1451
>   hrtimer_interrupt+0x2ed/0x740 kernel/time/hrtimer.c:1509
>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
>   smp_apic_timer_interrupt+0xdd/0x4a0 arch/x86/kernel/apic/apic.c:1060
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:767  
> [inline]
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
> [inline]
> RIP: 0010:_raw_spin_unlock_irqrestore+0x50/0x60  
> kernel/locking/spinlock.c:184
> Code: 52 f3 f6 c7 02 75 19 48 89 df 57 9d 0f 1f 44 00 00 e8 04 d0 72 f3 65  
> ff 0d 3d f9 fb 71 5b 5d c3 e8 35 ce 72 f3 48 89 df 57 9d <0f> 1f 44 00 00  
> eb e5 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55
> RSP: 0018:ffff8880ad007b60 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000007 RBX: 0000000000000206 RCX: 1ffff110130a543a
> RDX: 0000000000000000 RSI: ffff88809852a1b0 RDI: 0000000000000206
> RBP: ffff8882165f2100 R08: ffff888098529880 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88809faa1a38
> R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8880a60f5f00
>   spin_unlock_irqrestore include/linux/spinlock.h:384 [inline]
>   dummy_timer+0x146e/0x32c0 drivers/usb/gadget/udc/dummy_hcd.c:1982
>   call_timer_fn+0x161/0x5f0 kernel/time/timer.c:1325
>   expire_timers kernel/time/timer.c:1362 [inline]
>   __run_timers kernel/time/timer.c:1681 [inline]
>   __run_timers kernel/time/timer.c:1649 [inline]
>   run_timer_softirq+0x58b/0x1400 kernel/time/timer.c:1694
>   __do_softirq+0x22a/0x8cd kernel/softirq.c:293
>   do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1027
>   </IRQ>
>   do_softirq.part.0+0x60/0x70 kernel/softirq.c:338
>   do_softirq kernel/softirq.c:330 [inline]
>   __local_bh_enable_ip+0x183/0x1b0 kernel/softirq.c:190
>   spin_unlock_bh include/linux/spinlock.h:374 [inline]
>   peernet2id+0x94/0xc0 net/core/net_namespace.c:266
>   do_one_broadcast net/netlink/af_netlink.c:1471 [inline]
>   netlink_broadcast_filtered+0x51b/0xb70 net/netlink/af_netlink.c:1518
>   netlink_broadcast+0x3a/0x50 net/netlink/af_netlink.c:1542
>   uevent_net_broadcast_untagged lib/kobject_uevent.c:330 [inline]
>   kobject_uevent_net_broadcast lib/kobject_uevent.c:408 [inline]
>   kobject_uevent_env+0x82c/0x13d0 lib/kobject_uevent.c:589
>   driver_bound+0x1b9/0x320 drivers/base/dd.c:355
>   really_probe+0x373/0xb10 drivers/base/dd.c:542
>   driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
>   __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
>   bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x223/0x3a0 drivers/base/dd.c:844
>   bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
>   device_add+0xad2/0x16e0 drivers/base/core.c:2106
>   usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
>   generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
>   usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
>   really_probe+0x2da/0xb10 drivers/base/dd.c:509
>   driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
>   __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
>   bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x223/0x3a0 drivers/base/dd.c:844
>   bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
>   device_add+0xad2/0x16e0 drivers/base/core.c:2106
>   usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
>   hub_port_connect drivers/usb/core/hub.c:5089 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
>   port_event drivers/usb/core/hub.c:5350 [inline]
>   hub_event+0x1398/0x3b00 drivers/usb/core/hub.c:5432
>   process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
>   worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
>   kthread+0x313/0x420 kernel/kthread.c:253
>   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> yurex 1-1:0.150: yurex_interrupt - unknown status received: -71
> yurex 5-1:0.150: yurex_interrupt - unknown status received: -71
> yurex 6-1:0.150: yurex_interrupt - unknown status received: -71
> yurex 2-1:0.150: yurex_interrupt - unknown status received: -71
> yurex 3-1:0.150: yurex_interrupt - unknown status received: -71
> yurex 5-1:0.150: yurex_interrupt - unknown status received: -71

Well, at least it's a different kind of crash from before.  Now the 
question is why isn't yurex_disconnect() doing its job.  More debugging 
is needed.

Alan Stern


#syz test: https://github.com/google/kasan.git usb-fuzzer

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -178,6 +178,10 @@ static void yurex_interrupt(struct urb *
 	}
 
 exit:
+	if (!usb_get_intfdata(dev->interface)) {
+		dev_info(&dev->interface->dev "%s unbound\n", __func__);
+		return;
+	}
 	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
 	if (retval) {
 		dev_err(&dev->interface->dev, "%s - usb_submit_urb failed: %d\n",
@@ -309,11 +313,15 @@ static void yurex_disconnect(struct usb_
 
 	dev = usb_get_intfdata(interface);
 	usb_set_intfdata(interface, NULL);
+	dev_info(&interface->dev, "%s\n", __func__);
 
 	/* give back our minor */
 	usb_deregister_dev(interface, &yurex_class);
 
 	/* prevent more I/O from starting */
+	dev_info(&interface->dev, "Before poison\n");
+	usb_poison_urb(dev->urb);
+	dev_info(&interface->dev, "After poison\n");
 	mutex_lock(&dev->io_mutex);
 	dev->interface = NULL;
 	mutex_unlock(&dev->io_mutex);


