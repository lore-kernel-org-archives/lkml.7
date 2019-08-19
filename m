Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A8AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D335F2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfHSUBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:01:22 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43886 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728214AbfHSUBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:01:11 -0400
Received: (qmail 7191 invoked by uid 2102); 19 Aug 2019 16:01:10 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Aug 2019 16:01:10 -0400
Date:   Mon, 19 Aug 2019 16:01:10 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+0e7b6b6001ca8ed655f6@syzkaller.appspotmail.com>,
        Felipe Balbi <balbi@kernel.org>, <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in kmem_cache_alloc_trace
In-Reply-To: <CAAeHK+zOQLEcHesUzKHT2U59DpHtR3PnZXdTMv=1PNLD-evqtA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1908191558310.1506-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019, Andrey Konovalov wrote:

> On Mon, Aug 19, 2019 at 6:18 PM syzbot
> <syzbot+0e7b6b6001ca8ed655f6@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    d0847550 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16947fce600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc9c80cc095da19
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0e7b6b6001ca8ed655f6
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1141c5ba600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ed91d2600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+0e7b6b6001ca8ed655f6@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > do not call blocking ops when !TASK_RUNNING; state=1 set at
> > [<000000000453b57c>] prepare_to_wait+0xb1/0x2b0 kernel/sched/wait.c:230
> > WARNING: CPU: 0 PID: 1720 at kernel/sched/core.c:6551
> > __might_sleep+0x135/0x190 kernel/sched/core.c:6551
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 0 PID: 1720 Comm: syz-executor552 Not tainted 5.3.0-rc4+ #26
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   panic+0x2a3/0x6da kernel/panic.c:219
> >   __warn.cold+0x20/0x4a kernel/panic.c:576
> >   report_bug+0x262/0x2a0 lib/bug.c:186
> >   fixup_bug arch/x86/kernel/traps.c:179 [inline]
> >   fixup_bug arch/x86/kernel/traps.c:174 [inline]
> >   do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
> >   do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
> >   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
> > RIP: 0010:__might_sleep+0x135/0x190 kernel/sched/core.c:6551
> > Code: 65 48 8b 1c 25 00 ef 01 00 48 8d 7b 10 48 89 fe 48 c1 ee 03 80 3c 06
> > 00 75 2b 48 8b 73 10 48 c7 c7 e0 55 c6 85 e8 30 21 f6 ff <0f> 0b e9 46 ff
> > ff ff e8 ef ee 46 00 e9 29 ff ff ff e8 e5 ee 46 00
> > RSP: 0018:ffff8881c7df7a30 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: ffff8881d4a49800 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff81288cfd RDI: ffffed1038fbef38
> > RBP: ffffffff86a6a5d1 R08: ffff8881d4a49800 R09: fffffbfff11ad3a1
> > R10: fffffbfff11ad3a0 R11: ffffffff88d69d07 R12: 00000000000001f5
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000cc0
> >   slab_pre_alloc_hook mm/slab.h:501 [inline]
> >   slab_alloc_node mm/slub.c:2690 [inline]
> >   slab_alloc mm/slub.c:2778 [inline]
> >   kmem_cache_alloc_trace+0x233/0x2f0 mm/slub.c:2795
> >   kmalloc include/linux/slab.h:552 [inline]
> >   dummy_urb_enqueue+0x7c/0x890 drivers/usb/gadget/udc/dummy_hcd.c:1249
> >   usb_hcd_submit_urb+0x2aa/0x1ee0 drivers/usb/core/hcd.c:1555
> >   usb_submit_urb+0x6e5/0x13b0 drivers/usb/core/urb.c:569
> >   yurex_write+0x3b2/0x710 drivers/usb/misc/yurex.c:491
> >   __vfs_write+0x76/0x100 fs/read_write.c:494
> >   vfs_write+0x262/0x5c0 fs/read_write.c:558

> Looks like an issue in the yurex driver, despite a generic report title.

Indeed.  The code for waiting on the completion of an URB is very out 
of date.

Alan Stern

#syz test: https://github.com/google/kasan.git d0847550

Index: usb-devel/drivers/usb/misc/yurex.c
===================================================================
--- usb-devel.orig/drivers/usb/misc/yurex.c
+++ usb-devel/drivers/usb/misc/yurex.c
@@ -62,6 +62,7 @@ struct usb_yurex {
 	struct mutex		io_mutex;
 	struct fasync_struct	*async_queue;
 	wait_queue_head_t	waitq;
+	int			command_finished;
 
 	spinlock_t		lock;
 	__s64			bbu;		/* BBU from device */
@@ -80,6 +81,7 @@ static void yurex_control_callback(struc
 	if (status) {
 		dev_err(&urb->dev->dev, "%s - control failed: %d\n",
 			__func__, status);
+		dev->command_finished = 1;
 		wake_up_interruptible(&dev->waitq);
 		return;
 	}
@@ -173,6 +175,7 @@ static void yurex_interrupt(struct urb *
 	case CMD_ACK:
 		dev_dbg(&dev->interface->dev, "%s ack: %c\n",
 			__func__, buf[1]);
+		dev->command_finished = 1;
 		wake_up_interruptible(&dev->waitq);
 		break;
 	}
@@ -321,6 +324,7 @@ static void yurex_disconnect(struct usb_
 
 	/* wakeup waiters */
 	kill_fasync(&dev->async_queue, SIGIO, POLL_IN);
+	dev->command_finished = 1;
 	wake_up_interruptible(&dev->waitq);
 
 	/* decrement our usage count */
@@ -428,8 +432,7 @@ static ssize_t yurex_write(struct file *
 	char buffer[16 + 1];
 	char *data = buffer;
 	unsigned long long c, c2 = 0;
-	signed long timeout = 0;
-	DEFINE_WAIT(wait);
+	signed long time_remaining = 0;
 
 	count = min(sizeof(buffer) - 1, count);
 	dev = file->private_data;
@@ -485,14 +488,16 @@ static ssize_t yurex_write(struct file *
 	}
 
 	/* send the data as the control msg */
-	prepare_to_wait(&dev->waitq, &wait, TASK_INTERRUPTIBLE);
 	dev_dbg(&dev->interface->dev, "%s - submit %c\n", __func__,
 		dev->cntl_buffer[0]);
 	retval = usb_submit_urb(dev->cntl_urb, GFP_KERNEL);
-	if (retval >= 0)
-		timeout = schedule_timeout(YUREX_WRITE_TIMEOUT);
-	finish_wait(&dev->waitq, &wait);
-
+	if (retval >= 0) {
+		dev->command_finished = 0;
+		time_remaining = wait_event_interruptible_timeout(dev->waitq,
+				dev->command_finished, YUREX_WRITE_TIMEOUT);
+		if (time_remaining < 0)
+			retval = -EINTR;
+	}
 	mutex_unlock(&dev->io_mutex);
 
 	if (retval < 0) {
@@ -501,9 +506,9 @@ static ssize_t yurex_write(struct file *
 			__func__, retval);
 		goto error;
 	}
-	if (set && timeout)
+	if (set && time_remaining)
 		dev->bbu = c2;
-	return timeout ? count : -EIO;
+	return time_remaining ? count : -EIO;
 
 error:
 	return retval;

