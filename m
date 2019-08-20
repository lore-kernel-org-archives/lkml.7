Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A07C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E332054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfHTNHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:07:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:51348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728595AbfHTNHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:07:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58808AFBE;
        Tue, 20 Aug 2019 13:07:51 +0000 (UTC)
Message-ID: <1566306470.11678.16.camel@suse.com>
Subject: Re: WARNING in kmem_cache_alloc_trace
From:   Oliver Neukum <oneukum@suse.com>
To:     Andrey Konovalov <andreyknvl@google.com>,
        syzbot <syzbot+0e7b6b6001ca8ed655f6@syzkaller.appspotmail.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        chunfeng.yun@mediatek.com, Alan Stern <stern@rowland.harvard.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date:   Tue, 20 Aug 2019 15:07:50 +0200
In-Reply-To: <CAAeHK+zOQLEcHesUzKHT2U59DpHtR3PnZXdTMv=1PNLD-evqtA@mail.gmail.com>
References: <000000000000621bc305907aaf02@google.com>
         <CAAeHK+zOQLEcHesUzKHT2U59DpHtR3PnZXdTMv=1PNLD-evqtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 19.08.2019, 18:59 +0200 schrieb Andrey Konovalov:
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

#syz test: https://github.com/google/kasan.git d0847550

From eeb920819e1d98e631fb78fe849649dc8dd6eb1b Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Tue, 20 Aug 2019 15:04:00 +0200
Subject: [PATCH] USB: yurex: fix failure to wait for control message

Using usb_submit_urb() after prepare_to_wait() won't work, because
it may reset the task state to TASK_RUNNING. Replacing it with
a completion.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/misc/yurex.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 6715a128e6c8..519bb53993aa 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -62,6 +62,7 @@ struct usb_yurex {
 	struct mutex		io_mutex;
 	struct fasync_struct	*async_queue;
 	wait_queue_head_t	waitq;
+	struct completion	cntl_cpl;
 
 	spinlock_t		lock;
 	__s64			bbu;		/* BBU from device */
@@ -80,7 +81,7 @@ static void yurex_control_callback(struct urb *urb)
 	if (status) {
 		dev_err(&urb->dev->dev, "%s - control failed: %d\n",
 			__func__, status);
-		wake_up_interruptible(&dev->waitq);
+		complete(&dev->cntl_cpl);
 		return;
 	}
 	/* on success, sender woken up by CMD_ACK int in, or timeout */
@@ -202,6 +203,7 @@ static int yurex_probe(struct usb_interface *interface, const struct usb_device_
 	mutex_init(&dev->io_mutex);
 	spin_lock_init(&dev->lock);
 	init_waitqueue_head(&dev->waitq);
+	init_completion(&dev->cntl_cpl);
 
 	dev->udev = usb_get_dev(interface_to_usbdev(interface));
 	dev->interface = interface;
@@ -322,6 +324,7 @@ static void yurex_disconnect(struct usb_interface *interface)
 	/* wakeup waiters */
 	kill_fasync(&dev->async_queue, SIGIO, POLL_IN);
 	wake_up_interruptible(&dev->waitq);
+	complete(&dev->cntl_cpl);
 
 	/* decrement our usage count */
 	kref_put(&dev->kref, yurex_delete);
@@ -485,13 +488,10 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
 	}
 
 	/* send the data as the control msg */
-	prepare_to_wait(&dev->waitq, &wait, TASK_INTERRUPTIBLE);
 	dev_dbg(&dev->interface->dev, "%s - submit %c\n", __func__,
 		dev->cntl_buffer[0]);
 	retval = usb_submit_urb(dev->cntl_urb, GFP_KERNEL);
-	if (retval >= 0)
-		timeout = schedule_timeout(YUREX_WRITE_TIMEOUT);
-	finish_wait(&dev->waitq, &wait);
+	timeout = wait_for_completion_interruptible__timeout(&dev->cntl_cpl, YUREX_WRITE_TIMEOUT);
 
 	mutex_unlock(&dev->io_mutex);
 
-- 
2.16.4

