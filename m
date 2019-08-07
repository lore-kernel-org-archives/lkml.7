Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B42DC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F8922305
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbfHGSFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:05:43 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42962 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388669AbfHGSFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:05:43 -0400
Received: (qmail 22349 invoked by uid 2102); 7 Aug 2019 14:05:42 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Aug 2019 14:05:42 -0400
Date:   Wed, 7 Aug 2019 14:05:42 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <oneukum@suse.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
In-Reply-To: <00000000000085d6b4058f8a957a@google.com>
Message-ID: <Pine.LNX.4.44L0.1908071402160.1514-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered  
> crash:
> KASAN: use-after-free Read in device_release_driver_internal

> Tested on:
> 
> commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=142eec8c600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d95bf6600000

The kernel log is pretty definite here:

[   40.270346][   T89] cdc_acm 5-1:0.234: Refcount before probe: 3
[   40.284514][   T89] cdc_acm 5-1:0.234: invalid descriptor buffer length
[   40.284523][   T89] cdc_acm 5-1:0.234: No union descriptor, testing for castrated device
[   40.285322][   T89] cdc_acm 5-1:0.234: Refcount after probe: 2

2 < 3.  So let's combine the diagnostic patch with Oliver's proposed 
solution.

Alan Stern

#syz test: https://github.com/google/kasan.git 6a3599ce

Index: usb-devel/drivers/usb/core/driver.c
===================================================================
--- usb-devel.orig/drivers/usb/core/driver.c
+++ usb-devel/drivers/usb/core/driver.c
@@ -358,7 +358,11 @@ static int usb_probe_interface(struct de
 		intf->needs_altsetting0 = 0;
 	}
 
+	dev_info(&intf->dev, "Refcount before probe: %d\n",
+			refcount_read(&intf->dev.kobj.kref.refcount));
 	error = driver->probe(intf, id);
+	dev_info(&intf->dev, "Refcount after probe: %d\n",
+			refcount_read(&intf->dev.kobj.kref.refcount));
 	if (error)
 		goto err;
 
Index: usb-devel/drivers/usb/class/cdc-acm.c
===================================================================
--- usb-devel.orig/drivers/usb/class/cdc-acm.c
+++ usb-devel/drivers/usb/class/cdc-acm.c
@@ -1301,10 +1301,6 @@ made_compressed_probe:
 	tty_port_init(&acm->port);
 	acm->port.ops = &acm_port_ops;
 
-	minor = acm_alloc_minor(acm);
-	if (minor < 0)
-		goto alloc_fail1;
-
 	ctrlsize = usb_endpoint_maxp(epctrl);
 	readsize = usb_endpoint_maxp(epread) *
 				(quirks == SINGLE_RX_URB ? 1 : 2);
@@ -1312,6 +1308,13 @@ made_compressed_probe:
 	acm->writesize = usb_endpoint_maxp(epwrite) * 20;
 	acm->control = control_interface;
 	acm->data = data_interface;
+
+	usb_get_intf(acm->control); /* undone in destroy() */
+
+	minor = acm_alloc_minor(acm);
+	if (minor < 0)
+		goto alloc_fail1;
+
 	acm->minor = minor;
 	acm->dev = usb_dev;
 	if (h.usb_cdc_acm_descriptor)
@@ -1458,7 +1461,6 @@ skip_countries:
 	usb_driver_claim_interface(&acm_driver, data_interface, acm);
 	usb_set_intfdata(data_interface, acm);
 
-	usb_get_intf(control_interface);
 	tty_dev = tty_port_register_device(&acm->port, acm_tty_driver, minor,
 			&control_interface->dev);
 	if (IS_ERR(tty_dev)) {

