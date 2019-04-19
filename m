Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D49CC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9CF2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfDSUo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:44:29 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33012 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726455AbfDSUo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:44:28 -0400
Received: (qmail 8904 invoked by uid 2102); 19 Apr 2019 16:44:27 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Apr 2019 16:44:27 -0400
Date:   Fri, 19 Apr 2019 16:44:27 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <rafael@kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in __dev_printk
In-Reply-To: <00000000000029431d0586d10813@google.com>
Message-ID: <Pine.LNX.4.44L0.1904191640250.1406-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, syzbot wrote:

> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    d34f9519 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=10adfe6b200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
> dashboard link: https://syzkaller.appspot.com/bug?extid=2eb9121678bdb36e6d57
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145cb7e3200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f8bd2d200000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com
> 
> yurex 1-1:0.150: yurex_interrupt - unknown status received: -71
> usb 1-1: USB disconnect, device number 112
> yurex 1-1:0.150: yurex_interrupt - unknown status received: -71
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN PTI
> CPU: 1 PID: 5402 Comm: udevd Not tainted 5.1.0-rc5-319617-gd34f951 #4
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> RIP: 0010:dev_name include/linux/device.h:1087 [inline]
> RIP: 0010:__dev_printk+0x3f/0x215 drivers/base/core.c:3208
> Code: 89 f5 53 e8 1e 24 1c fc 48 85 ed 0f 84 c9 01 00 00 e8 10 24 1c fc 48  
> 8d 7d 50 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 <80> 3c 02 00 74  
> 05 e8 31 39 53 fc 4c 8b 7d 50 4d 85 ff 75 28 e8 e3
> RSP: 0018:ffff8880ad107930 EFLAGS: 00010002
> RAX: dffffc0000000000 RBX: ffffed1015a20f2d RCX: 00000000ffffffed
> RDX: 0000000000000010 RSI: ffffffff85559bf0 RDI: 0000000000000080
> RBP: 0000000000000030 R08: ffff888091578000 R09: ffffed1015a24fc9
> R10: ffffed1015a24fc8 R11: ffff8880ad127e47 R12: ffffffff8f031a00
> R13: ffff8880ad107988 R14: 0000000000000000 R15: ffff88809b9b1600
> FS:  00007fcff04907a0(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcff0496000 CR3: 0000000097678000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   _dev_err+0xdc/0x10e drivers/base/core.c:3251
>   yurex_interrupt.cold+0x12e/0x13d drivers/usb/misc/yurex.c:183

The problem is that the device can be unregistered before the interrupt
URB is killed.  I don't know if the patch below is the right way to fix 
this, but it ought to do the job.

Alan Stern


#syz test: https://github.com/google/kasan.git usb-fuzzer

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -314,6 +314,7 @@ static void yurex_disconnect(struct usb_
 	usb_deregister_dev(interface, &yurex_class);
 
 	/* prevent more I/O from starting */
+	usb_poison_urb(dev->urb);
 	mutex_lock(&dev->io_mutex);
 	dev->interface = NULL;
 	mutex_unlock(&dev->io_mutex);

