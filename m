Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1E0C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3A3218CD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfDWQqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:46:49 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:58380 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727656AbfDWQqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:46:49 -0400
Received: (qmail 5734 invoked by uid 2102); 23 Apr 2019 12:46:48 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Apr 2019 12:46:48 -0400
Date:   Tue, 23 Apr 2019 12:46:48 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <dvyukov@google.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <rafael@kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in __dev_printk
In-Reply-To: <000000000000dca2f3058734c255@google.com>
Message-ID: <Pine.LNX.4.44L0.1904231240270.1461-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger  
> crash:
> 
> Reported-and-tested-by:  
> syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         d34f9519 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=15909780a00000
> 
> Note: testing is done by a robot and is best-effort only.

Okay, here's the original patch again, with the error message #if-ed
out.  Maybe those messages are slowing down dummy-hcd enough that the
yurex_disconnect() routine never gets a chance to run.  Although to
tell the truth, I don't see how that could happen.

Alan Stern


#syz test: https://github.com/google/kasan.git usb-fuzzer

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -143,8 +143,10 @@ static void yurex_interrupt(struct urb *
 		/* The device is terminated, clean up */
 		return;
 	default:
+#if 0
 		dev_err(&dev->interface->dev,
 			"%s - unknown status received: %d\n", __func__, status);
+#endif
 		goto exit;
 	}
 
@@ -314,6 +316,7 @@ static void yurex_disconnect(struct usb_
 	usb_deregister_dev(interface, &yurex_class);
 
 	/* prevent more I/O from starting */
+	usb_poison_urb(dev->urb);
 	mutex_lock(&dev->io_mutex);
 	dev->interface = NULL;
 	mutex_unlock(&dev->io_mutex);

