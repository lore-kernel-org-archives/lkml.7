Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8D3C41514
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9540F20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbfHASrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:47:07 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46572 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729195AbfHASrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:47:07 -0400
Received: (qmail 3931 invoked by uid 2102); 1 Aug 2019 14:47:06 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Aug 2019 14:47:06 -0400
Date:   Thu, 1 Aug 2019 14:47:06 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>,
        Oliver Neukum <oneukum@suse.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
In-Reply-To: <CAAeHK+w4e=+qXOaas_Vmm0xnxLFkocN9uRJVxuYmvHhT0hSn1w@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1908011359580.1305-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2019, Andrey Konovalov wrote:

> On Tue, Jul 23, 2019 at 4:28 PM syzbot
> <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13f640cc600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1b2449b7b5dc240d107a
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116ce31fa00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1022f694600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com
> >
> > usb 1-1: USB disconnect, device number 2
> > ==================================================================
> > BUG: KASAN: use-after-free in __lock_acquire+0x3a5d/0x5340
> > /kernel/locking/lockdep.c:3665
> > Read of size 8 at addr ffff8881cfc4ef90 by task kworker/0:2/108
> >
> > CPU: 0 PID: 108 Comm: kworker/0:2 Not tainted 5.2.0-rc6+ #15
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >   __dump_stack /lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e /lib/dump_stack.c:113
> >   print_address_description+0x67/0x231 /mm/kasan/report.c:188
> >   __kasan_report.cold+0x1a/0x32 /mm/kasan/report.c:317
> >   kasan_report+0xe/0x20 /mm/kasan/common.c:614
> >   __lock_acquire+0x3a5d/0x5340 /kernel/locking/lockdep.c:3665
> >   lock_acquire+0x100/0x2b0 /kernel/locking/lockdep.c:4303
> >   __mutex_lock_common /kernel/locking/mutex.c:926 [inline]
> >   __mutex_lock+0xf9/0x12b0 /kernel/locking/mutex.c:1073
> >   device_release_driver_internal+0x23/0x4c0 /drivers/base/dd.c:1109
> >   bus_remove_device+0x2dc/0x4a0 /drivers/base/bus.c:556
> >   device_del+0x460/0xb80 /drivers/base/core.c:2274
> >   usb_disable_device+0x211/0x690 /drivers/usb/core/message.c:1237
> >   usb_disconnect+0x284/0x830 /drivers/usb/core/hub.c:2199
> >   hub_port_connect /drivers/usb/core/hub.c:4949 [inline]
> >   hub_port_connect_change /drivers/usb/core/hub.c:5213 [inline]
> >   port_event /drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x13bd/0x3550 /drivers/usb/core/hub.c:5441
> >   process_one_work+0x905/0x1570 /kernel/workqueue.c:2269
> >   worker_thread+0x96/0xe20 /kernel/workqueue.c:2415
> >   kthread+0x30b/0x410 /kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352
> >
> > Allocated by task 88:
> >   save_stack+0x1b/0x80 /mm/kasan/common.c:71
> >   set_track /mm/kasan/common.c:79 [inline]
> >   __kasan_kmalloc /mm/kasan/common.c:489 [inline]
> >   __kasan_kmalloc.constprop.0+0xbf/0xd0 /mm/kasan/common.c:462
> >   kmalloc /./include/linux/slab.h:547 [inline]
> >   kzalloc /./include/linux/slab.h:742 [inline]
> >   usb_set_configuration+0x2c4/0x1670 /drivers/usb/core/message.c:1846
> >   generic_probe+0x9d/0xd5 /drivers/usb/core/generic.c:210
> >   usb_probe_device+0x99/0x100 /drivers/usb/core/driver.c:266
> >   really_probe+0x281/0x660 /drivers/base/dd.c:509
> >   driver_probe_device+0x104/0x210 /drivers/base/dd.c:670
> >   __device_attach_driver+0x1c2/0x220 /drivers/base/dd.c:777
> >   bus_for_each_drv+0x15c/0x1e0 /drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 /drivers/base/dd.c:843
> >   bus_probe_device+0x1e4/0x290 /drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 /drivers/base/core.c:2111
> >   usb_new_device.cold+0x6a4/0xe61 /drivers/usb/core/hub.c:2536
> >   hub_port_connect /drivers/usb/core/hub.c:5098 [inline]
> >   hub_port_connect_change /drivers/usb/core/hub.c:5213 [inline]
> >   port_event /drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x1abd/0x3550 /drivers/usb/core/hub.c:5441
> >   process_one_work+0x905/0x1570 /kernel/workqueue.c:2269
> >   worker_thread+0x96/0xe20 /kernel/workqueue.c:2415
> >   kthread+0x30b/0x410 /kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352
> >
> > Freed by task 108:
> >   save_stack+0x1b/0x80 /mm/kasan/common.c:71
> >   set_track /mm/kasan/common.c:79 [inline]
> >   __kasan_slab_free+0x130/0x180 /mm/kasan/common.c:451
> >   slab_free_hook /mm/slub.c:1421 [inline]
> >   slab_free_freelist_hook /mm/slub.c:1448 [inline]
> >   slab_free /mm/slub.c:2994 [inline]
> >   kfree+0xd7/0x280 /mm/slub.c:3949
> >   device_release+0x71/0x200 /drivers/base/core.c:1064
> >   kobject_cleanup /lib/kobject.c:691 [inline]
> >   kobject_release /lib/kobject.c:720 [inline]
> >   kref_put /./include/linux/kref.h:65 [inline]
> >   kobject_put+0x171/0x280 /lib/kobject.c:737
> >   put_device+0x1b/0x30 /drivers/base/core.c:2210
> >   klist_put+0xce/0x170 /lib/klist.c:221
> >   bus_remove_device+0x3a4/0x4a0 /drivers/base/bus.c:552
> >   device_del+0x460/0xb80 /drivers/base/core.c:2274
> >   usb_disable_device+0x211/0x690 /drivers/usb/core/message.c:1237
> >   usb_disconnect+0x284/0x830 /drivers/usb/core/hub.c:2199
> >   hub_port_connect /drivers/usb/core/hub.c:4949 [inline]
> >   hub_port_connect_change /drivers/usb/core/hub.c:5213 [inline]
> >   port_event /drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x13bd/0x3550 /drivers/usb/core/hub.c:5441
> >   process_one_work+0x905/0x1570 /kernel/workqueue.c:2269
> >   worker_thread+0x96/0xe20 /kernel/workqueue.c:2415
> >   kthread+0x30b/0x410 /kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352
> >
> > The buggy address belongs to the object at ffff8881cfc4ee80
> >   which belongs to the cache kmalloc-2k of size 2048
> > The buggy address is located 272 bytes inside of
> >   2048-byte region [ffff8881cfc4ee80, ffff8881cfc4f680)
> > The buggy address belongs to the page:
> > page:ffffea00073f1200 refcount:1 mapcount:0 mapping:ffff8881dac02800
> > index:0x0 compound_mapcount: 0
> > flags: 0x200000000010200(slab|head)
> > raw: 0200000000010200 dead000000000100 dead000000000200 ffff8881dac02800
> > raw: 0000000000000000 00000000000f000f 00000001ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >   ffff8881cfc4ee80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff8881cfc4ef00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > ffff8881cfc4ef80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                           ^
> >   ffff8881cfc4f000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff8881cfc4f080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> 
> Hi Alan,
> 
> Could you take a look at this report? This looks like some kind of bug
> in USB core code, but I can't really figure out what's going on here.

I think this must be caused by an unbalanced refcount.  That is,
something must drop one more reference to the device than it takes.
That would explain why the invalid access occurs inside a single
bus_remove_device() call, between the klist_del() and
device_release_driver().

The kernel log indicates that the device was probed by rndis_wlan,
rndis_host, and cdc_acm, all of which got errors because of the
device's bogus descriptors.  Probably one of them is messing up the
refcount.

Hard to say which or where, though.

Alan Stern

