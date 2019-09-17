Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE5BC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F92C2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfIQSbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:31:31 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:39308 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726505AbfIQSbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:31:31 -0400
Received: (qmail 7234 invoked by uid 2102); 17 Sep 2019 14:31:30 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Sep 2019 14:31:30 -0400
Date:   Tue, 17 Sep 2019 14:31:30 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <kai.heng.feng@canonical.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mans@mansr.com>, <oneukum@suse.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in usb_set_interface
In-Reply-To: <000000000000e08e490592c3b2c4@google.com>
Message-ID: <Pine.LNX.4.44L0.1909171428160.1590-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019, syzbot wrote:

> Hello,
> 
> syzbot tried to test the proposed patch but build/boot failed:

Oops.  Typo.

#syz test: https://github.com/google/kasan.git f0df5c1b

 drivers/media/usb/usbvision/usbvision-video.c |   27 ++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

Index: usb-devel/drivers/media/usb/usbvision/usbvision-video.c
===================================================================
--- usb-devel.orig/drivers/media/usb/usbvision/usbvision-video.c
+++ usb-devel/drivers/media/usb/usbvision/usbvision-video.c
@@ -314,6 +314,10 @@ static int usbvision_v4l2_open(struct fi
 	if (mutex_lock_interruptible(&usbvision->v4l2_lock))
 		return -ERESTARTSYS;
 
+	if (usbvision->remove_pending) {
+		err_code = -ENODEV;
+		goto unlock;
+	}
 	if (usbvision->user) {
 		err_code = -EBUSY;
 	} else {
@@ -377,6 +381,7 @@ unlock:
 static int usbvision_v4l2_close(struct file *file)
 {
 	struct usb_usbvision *usbvision = video_drvdata(file);
+	int r;
 
 	PDEBUG(DBG_IO, "close");
 
@@ -391,9 +396,10 @@ static int usbvision_v4l2_close(struct f
 	usbvision_scratch_free(usbvision);
 
 	usbvision->user--;
+	r = usbvision->remove_pending;
 	mutex_unlock(&usbvision->v4l2_lock);
 
-	if (usbvision->remove_pending) {
+	if (r) {
 		printk(KERN_INFO "%s: Final disconnect\n", __func__);
 		usbvision_release(usbvision);
 		return 0;
@@ -453,6 +459,9 @@ static int vidioc_querycap(struct file *
 {
 	struct usb_usbvision *usbvision = video_drvdata(file);
 
+	if (!usbvision->dev)
+		return -ENODEV;
+
 	strscpy(vc->driver, "USBVision", sizeof(vc->driver));
 	strscpy(vc->card,
 		usbvision_device_data[usbvision->dev_model].model_string,
@@ -1073,6 +1082,11 @@ static int usbvision_radio_open(struct f
 
 	if (mutex_lock_interruptible(&usbvision->v4l2_lock))
 		return -ERESTARTSYS;
+
+	if (usbvision->remove_pending) {
+		err_code = -ENODEV;
+		goto out;
+	}
 	err_code = v4l2_fh_open(file);
 	if (err_code)
 		goto out;
@@ -1105,21 +1119,24 @@ out:
 static int usbvision_radio_close(struct file *file)
 {
 	struct usb_usbvision *usbvision = video_drvdata(file);
+	int r;
 
 	PDEBUG(DBG_IO, "");
 
 	mutex_lock(&usbvision->v4l2_lock);
 	/* Set packet size to 0 */
 	usbvision->iface_alt = 0;
-	usb_set_interface(usbvision->dev, usbvision->iface,
+	if (usbvision->dev)
+		usb_set_interface(usbvision->dev, usbvision->iface,
 				    usbvision->iface_alt);
 
 	usbvision_audio_off(usbvision);
 	usbvision->radio = 0;
 	usbvision->user--;
+	r = usbvision->remove_pending;
 	mutex_unlock(&usbvision->v4l2_lock);
 
-	if (usbvision->remove_pending) {
+	if (r) {
 		printk(KERN_INFO "%s: Final disconnect\n", __func__);
 		v4l2_fh_release(file);
 		usbvision_release(usbvision);
@@ -1551,6 +1568,7 @@ err_usb:
 static void usbvision_disconnect(struct usb_interface *intf)
 {
 	struct usb_usbvision *usbvision = to_usbvision(usb_get_intfdata(intf));
+	int u;
 
 	PDEBUG(DBG_PROBE, "");
 
@@ -1567,13 +1585,14 @@ static void usbvision_disconnect(struct
 	v4l2_device_disconnect(&usbvision->v4l2_dev);
 	usbvision_i2c_unregister(usbvision);
 	usbvision->remove_pending = 1;	/* Now all ISO data will be ignored */
+	u = usbvision->user;
 
 	usb_put_dev(usbvision->dev);
 	usbvision->dev = NULL;	/* USB device is no more */
 
 	mutex_unlock(&usbvision->v4l2_lock);
 
-	if (usbvision->user) {
+	if (u) {
 		printk(KERN_INFO "%s: In use, disconnect pending\n",
 		       __func__);
 		wake_up_interruptible(&usbvision->wait_frame);


