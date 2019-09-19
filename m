Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46DFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDEC21929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfISUnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:43:09 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48544 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730741AbfISUnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:43:09 -0400
Received: (qmail 8976 invoked by uid 2102); 19 Sep 2019 16:43:08 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Sep 2019 16:43:08 -0400
Date:   Thu, 19 Sep 2019 16:43:08 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+745b0dff8028f9488eba@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <miquel@df.uba.ar>, <rio500-users@lists.sourceforge.net>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: invalid-free in disconnect_rio (2)
In-Reply-To: <0000000000004349550592ebfd2d@google.com>
Message-ID: <Pine.LNX.4.44L0.1909191639240.6904-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=17d6f31d600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
> dashboard link: https://syzkaller.appspot.com/bug?extid=745b0dff8028f9488eba
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1009f769600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b1d4b1600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+745b0dff8028f9488eba@syzkaller.appspotmail.com
> 
> usb 5-1: New USB device found, idVendor=0841, idProduct=0001,  
> bcdDevice=c5.d0
> usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 5-1: config 0 descriptor??
> rio500 5-1:0.133: Second USB Rio at address 2 refused
> rio500: probe of 5-1:0.133 failed with error -16
> usb 3-1: USB disconnect, device number 2
> ==================================================================
> BUG: KASAN: double-free or invalid-free in disconnect_rio+0x12b/0x1b0  
> drivers/usb/misc/rio500.c:525

All right, that was a pretty dumb mistake on my part.  Checking for 
whether a device has already been registered needs to be part of the 
critical section.

Alan Stern

#syz test: https://github.com/google/kasan.git e0bd8d79

 drivers/usb/misc/rio500.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

Index: usb-devel/drivers/usb/misc/rio500.c
===================================================================
--- usb-devel.orig/drivers/usb/misc/rio500.c
+++ usb-devel/drivers/usb/misc/rio500.c
@@ -454,36 +454,35 @@ static int probe_rio(struct usb_interfac
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct rio_usb_data *rio = &rio_instance;
-	int retval = -ENOMEM;
-	char *ibuf, *obuf;
+	int retval;
 
+	mutex_lock(&rio500_mutex);
 	if (rio->present) {
 		dev_info(&intf->dev, "Second USB Rio at address %d refused\n", dev->devnum);
-		return -EBUSY;
+		retval = -EBUSY;
+		goto err_present;
 	}
 	dev_info(&intf->dev, "USB Rio found at address %d\n", dev->devnum);
+	rio->present = 1;
 
-	obuf = kmalloc(OBUF_SIZE, GFP_KERNEL);
-	if (!obuf) {
+	retval = -ENOMEM;
+	rio->obuf = kmalloc(OBUF_SIZE, GFP_KERNEL);
+	if (!rio->obuf) {
 		dev_err(&dev->dev,
 			"probe_rio: Not enough memory for the output buffer\n");
 		goto err_obuf;
 	}
-	dev_dbg(&intf->dev, "obuf address: %p\n", obuf);
+	dev_dbg(&intf->dev, "obuf address: %p\n", rio->obuf);
 
-	ibuf = kmalloc(IBUF_SIZE, GFP_KERNEL);
-	if (!ibuf) {
+	rio->ibuf = kmalloc(IBUF_SIZE, GFP_KERNEL);
+	if (!rio->ibuf) {
 		dev_err(&dev->dev,
 			"probe_rio: Not enough memory for the input buffer\n");
 		goto err_ibuf;
 	}
-	dev_dbg(&intf->dev, "ibuf address: %p\n", ibuf);
+	dev_dbg(&intf->dev, "ibuf address: %p\n", rio->ibuf);
 
-	mutex_lock(&rio500_mutex);
 	rio->rio_dev = dev;
-	rio->ibuf = ibuf;
-	rio->obuf = obuf;
-	rio->present = 1;
 	mutex_unlock(&rio500_mutex);
 
 	retval = usb_register_dev(intf, &usb_rio_class);
@@ -498,11 +497,14 @@ static int probe_rio(struct usb_interfac
 
  err_register:
 	mutex_lock(&rio500_mutex);
-	rio->present = 0;
-	mutex_unlock(&rio500_mutex);
+	rio->rio_dev = NULL;
+	kfree(rio->ibuf);
  err_ibuf:
-	kfree(obuf);
+	kfree(rio->obuf);
  err_obuf:
+	rio->present = 0;
+ err_present:
+	mutex_unlock(&rio500_mutex);
 	return retval;
 }
 

