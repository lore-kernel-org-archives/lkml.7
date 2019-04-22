Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F02EC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591A620B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfDVQHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:07:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37696 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726801AbfDVQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:07:20 -0400
Received: (qmail 5353 invoked by uid 2102); 22 Apr 2019 12:07:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Apr 2019 12:07:19 -0400
Date:   Mon, 22 Apr 2019 12:07:19 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <rafael@kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in __dev_printk
In-Reply-To: <000000000000b3f4390587207d78@google.com>
Message-ID: <Pine.LNX.4.44L0.1904221206170.1384-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019, syzbot wrote:

> Hello,
> 
> syzbot tried to test the proposed patch but build/boot failed:

Typo in the patch (missing comma).  Let's try again.

Alan Stern


#syz test: https://github.com/google/kasan.git usb-fuzzer

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -178,6 +178,10 @@ static void yurex_interrupt(struct urb *
 	}
 
 exit:
+	if (!usb_get_intfdata(dev->interface)) {
+		dev_info(&dev->interface->dev, "%s unbound\n", __func__);
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

