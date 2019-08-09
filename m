Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74569C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556A42086D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfHIT0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:26:12 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55428 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726022AbfHIT0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:26:11 -0400
Received: (qmail 5219 invoked by uid 2102); 9 Aug 2019 15:26:10 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2019 15:26:10 -0400
Date:   Fri, 9 Aug 2019 15:26:10 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <gustavo@embeddedor.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in usb_kill_urb
In-Reply-To: <000000000000e3e6d7058fb2c624@google.com>
Message-ID: <Pine.LNX.4.44L0.1908091524250.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1799392c600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> dashboard link: https://syzkaller.appspot.com/bug?extid=22ae4e3b9fcc8a5c153a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1134c802600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13278c4a600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in atomic_read  
> include/asm-generic/atomic-instrumented.h:26 [inline]
> BUG: KASAN: use-after-free in usb_kill_urb drivers/usb/core/urb.c:695  
> [inline]
> BUG: KASAN: use-after-free in usb_kill_urb+0x24b/0x2c0  
> drivers/usb/core/urb.c:687
> Read of size 4 at addr ffff8881d635b110 by task syz-executor672/1999
> 
> CPU: 1 PID: 1999 Comm: syz-executor672 Not tainted 5.3.0-rc2+ #25
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x6a/0x32c mm/kasan/report.c:351
>   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
>   kasan_report+0xe/0x12 mm/kasan/common.c:612
>   check_memory_region_inline mm/kasan/generic.c:185 [inline]
>   check_memory_region+0x128/0x190 mm/kasan/generic.c:192
>   atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
>   usb_kill_urb drivers/usb/core/urb.c:695 [inline]
>   usb_kill_urb+0x24b/0x2c0 drivers/usb/core/urb.c:687
>   ld_usb_abort_transfers+0xb7/0x1d0 drivers/usb/misc/ldusb.c:196
>   ld_usb_release+0x19f/0x400 drivers/usb/misc/ldusb.c:406

Since this also involves ldusb.c, maybe it will be fixed by the same 
patch as the other bug.

Alan Stern


#syz test: https://github.com/google/kasan.git e96407b4

Index: usb-devel/drivers/usb/core/file.c
===================================================================
--- usb-devel.orig/drivers/usb/core/file.c
+++ usb-devel/drivers/usb/core/file.c
@@ -193,9 +193,10 @@ int usb_register_dev(struct usb_interfac
 		intf->minor = minor;
 		break;
 	}
-	up_write(&minor_rwsem);
-	if (intf->minor < 0)
+	if (intf->minor < 0) {
+		up_write(&minor_rwsem);
 		return -EXFULL;
+	}
 
 	/* create a usb class device for this usb interface */
 	snprintf(name, sizeof(name), class_driver->name, minor - minor_base);
@@ -203,12 +204,11 @@ int usb_register_dev(struct usb_interfac
 				      MKDEV(USB_MAJOR, minor), class_driver,
 				      "%s", kbasename(name));
 	if (IS_ERR(intf->usb_dev)) {
-		down_write(&minor_rwsem);
 		usb_minors[minor] = NULL;
 		intf->minor = -1;
-		up_write(&minor_rwsem);
 		retval = PTR_ERR(intf->usb_dev);
 	}
+	up_write(&minor_rwsem);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(usb_register_dev);
@@ -234,12 +234,12 @@ void usb_deregister_dev(struct usb_inter
 		return;
 
 	dev_dbg(&intf->dev, "removing %d minor\n", intf->minor);
+	device_destroy(usb_class->class, MKDEV(USB_MAJOR, intf->minor));
 
 	down_write(&minor_rwsem);
 	usb_minors[intf->minor] = NULL;
 	up_write(&minor_rwsem);
 
-	device_destroy(usb_class->class, MKDEV(USB_MAJOR, intf->minor));
 	intf->usb_dev = NULL;
 	intf->minor = -1;
 	destroy_usb_class();

