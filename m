Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D08AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460A8206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbfDQTJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:09:45 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:59196 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1732596AbfDQTJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:09:45 -0400
Received: (qmail 4087 invoked by uid 2102); 17 Apr 2019 15:09:44 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Apr 2019 15:09:44 -0400
Date:   Wed, 17 Apr 2019 15:09:44 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+d919b0f29d7b5a4994b9@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <gustavo@embeddedor.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: INFO: task hung in usb_kill_urb
In-Reply-To: <000000000000edf1630586acca2b@google.com>
Message-ID: <Pine.LNX.4.44L0.1904171503410.1400-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered  
> crash:
> INFO: task hung in usb_kill_urb

That's surprising.  This patch was awfully similar to the previous one,
which did prevent the crash earlier.

> Tested on:
> 
> commit:         9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b5e057200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=131dca6b200000

Andrey, is there any way to increase the console output buffer size?  
The link above doesn't go all the way back to the beginning of the test
(it starts at timestamp 486.614697).

Also, here's a slightly revised patch for testing.

Alan Stern


#syz test: https://github.com/google/kasan.git usb-fuzzer

--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -979,8 +979,18 @@ static int dummy_udc_start(struct usb_ga
 	struct dummy_hcd	*dum_hcd = gadget_to_dummy_hcd(g);
 	struct dummy		*dum = dum_hcd->dum;
 
-	if (driver->max_speed == USB_SPEED_UNKNOWN)
+	switch (g->speed) {
+	/* All the speeds we support */
+	case USB_SPEED_LOW:
+	case USB_SPEED_FULL:
+	case USB_SPEED_HIGH:
+	case USB_SPEED_SUPER:
+		break;
+	default:
+		dev_err(dummy_dev(dum_hcd), "Unsupported driver max speed %d\n",
+				driver->max_speed);
 		return -EINVAL;
+	}
 
 	/*
 	 * SLAVE side init ... the layer above hardware, which
@@ -1784,9 +1794,10 @@ static void dummy_timer(struct timer_lis
 		/* Bus speed is 500000 bytes/ms, so use a little less */
 		total = 490000;
 		break;
-	default:
+	default:	/* Can't happen */
 		dev_err(dummy_dev(dum_hcd), "bogus device speed\n");
-		return;
+		total = 0;
+		break;
 	}
 
 	/* FIXME if HZ != 1000 this will probably misbehave ... */
@@ -1828,7 +1839,7 @@ restart:
 
 		/* Used up this frame's bandwidth? */
 		if (total <= 0)
-			break;
+			continue;
 
 		/* find the gadget's ep for this request (if configured) */
 		address = usb_pipeendpoint (urb->pipe);

