Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7835C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 16:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5D8206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556467456;
	bh=U90sCAlcC31l7cgGrINVA1CTicRU/z7LNWxAhUu/UGA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=AhH61i1jdZmySxrgYUe6W6ZfYGi52y2Wryd1tN90LqDHyzcsJTaf9tt2Np1sI6Ca2
	 Nu0U1FksvZghUMqf/O/9XR48dkixI6ak7io7vYtaVuifwpReOMSPS5NCZNGGNwPBis
	 Ftcw6CFnvnCFBYzbI+7a9YpfQD1gGedcTP81EOuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfD1QEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 12:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfD1QEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 12:04:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 996DD2067D;
        Sun, 28 Apr 2019 16:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556467454;
        bh=U90sCAlcC31l7cgGrINVA1CTicRU/z7LNWxAhUu/UGA=;
        h=Date:From:To:Cc:Subject:From;
        b=07MkXF9M2Yy1Y6VGTeDtoVx0hvsQojMLHnjFDc9TTGeTP1EX5YhUzITHJFg0gpqSg
         lVp0zBa/HHE7ITc/ObZ8yOtJnHKCrlkfiOCXrV6mkQEt7PPHQM8P/2p3dzR6BiBYuB
         Nifq322BBGov+eyI1w0jKJ19l5bK//1xeAGqCHIg=
Date:   Sun, 28 Apr 2019 18:04:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: USB: line6: use dynamic buffers
Message-ID: <20190428160411.GA12815@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The line6 driver uses a lot of USB buffers off of the stack, which is
not allowed on many systems, causing the driver to crash on some of
them.  Fix this up by dynamically allocating the buffers with kmalloc()
which allows for proper DMA-able memory.

Reported-by: Christo Gouws <gouws.christo@gmail.com>
Reported-by: Alan Stern <stern@rowland.harvard.edu>
Tested-by: Christo Gouws <gouws.christo@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/line6/driver.c   |   60 ++++++++++++++++++++++++++-------------------
 sound/usb/line6/podhd.c    |   21 +++++++++------
 sound/usb/line6/toneport.c |   23 ++++++++++++-----
 3 files changed, 64 insertions(+), 40 deletions(-)

--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -351,12 +351,16 @@ int line6_read_data(struct usb_line6 *li
 {
 	struct usb_device *usbdev = line6->usbdev;
 	int ret;
-	unsigned char len;
+	unsigned char *len;
 	unsigned count;
 
 	if (address > 0xffff || datalen > 0xff)
 		return -EINVAL;
 
+	len = kmalloc(sizeof(*len), GFP_KERNEL);
+	if (!len)
+		return -ENOMEM;
+
 	/* query the serial number: */
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
@@ -365,7 +369,7 @@ int line6_read_data(struct usb_line6 *li
 
 	if (ret < 0) {
 		dev_err(line6->ifcdev, "read request failed (error %d)\n", ret);
-		return ret;
+		goto exit;
 	}
 
 	/* Wait for data length. We'll get 0xff until length arrives. */
@@ -375,28 +379,29 @@ int line6_read_data(struct usb_line6 *li
 		ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0), 0x67,
 				      USB_TYPE_VENDOR | USB_RECIP_DEVICE |
 				      USB_DIR_IN,
-				      0x0012, 0x0000, &len, 1,
+				      0x0012, 0x0000, len, 1,
 				      LINE6_TIMEOUT * HZ);
 		if (ret < 0) {
 			dev_err(line6->ifcdev,
 				"receive length failed (error %d)\n", ret);
-			return ret;
+			goto exit;
 		}
 
-		if (len != 0xff)
+		if (*len != 0xff)
 			break;
 	}
 
-	if (len == 0xff) {
+	ret = -EIO;
+	if (*len == 0xff) {
 		dev_err(line6->ifcdev, "read failed after %d retries\n",
 			count);
-		return -EIO;
-	} else if (len != datalen) {
+		goto exit;
+	} else if (*len != datalen) {
 		/* should be equal or something went wrong */
 		dev_err(line6->ifcdev,
 			"length mismatch (expected %d, got %d)\n",
-			(int)datalen, (int)len);
-		return -EIO;
+			(int)datalen, (int)*len);
+		goto exit;
 	}
 
 	/* receive the result: */
@@ -405,12 +410,12 @@ int line6_read_data(struct usb_line6 *li
 			      0x0013, 0x0000, data, datalen,
 			      LINE6_TIMEOUT * HZ);
 
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(line6->ifcdev, "read failed (error %d)\n", ret);
-		return ret;
-	}
 
-	return 0;
+exit:
+	kfree(len);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(line6_read_data);
 
@@ -422,12 +427,16 @@ int line6_write_data(struct usb_line6 *l
 {
 	struct usb_device *usbdev = line6->usbdev;
 	int ret;
-	unsigned char status;
+	unsigned char *status;
 	int count;
 
 	if (address > 0xffff || datalen > 0xffff)
 		return -EINVAL;
 
+	status = kmalloc(sizeof(*status), GFP_KERNEL);
+	if (!status)
+		return -ENOMEM;
+
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
 			      0x0022, address, data, datalen,
@@ -436,7 +445,7 @@ int line6_write_data(struct usb_line6 *l
 	if (ret < 0) {
 		dev_err(line6->ifcdev,
 			"write request failed (error %d)\n", ret);
-		return ret;
+		goto exit;
 	}
 
 	for (count = 0; count < LINE6_READ_WRITE_MAX_RETRIES; count++) {
@@ -447,28 +456,29 @@ int line6_write_data(struct usb_line6 *l
 				      USB_TYPE_VENDOR | USB_RECIP_DEVICE |
 				      USB_DIR_IN,
 				      0x0012, 0x0000,
-				      &status, 1, LINE6_TIMEOUT * HZ);
+				      status, 1, LINE6_TIMEOUT * HZ);
 
 		if (ret < 0) {
 			dev_err(line6->ifcdev,
 				"receiving status failed (error %d)\n", ret);
-			return ret;
+			goto exit;
 		}
 
-		if (status != 0xff)
+		if (*status != 0xff)
 			break;
 	}
 
-	if (status == 0xff) {
+	if (*status == 0xff) {
 		dev_err(line6->ifcdev, "write failed after %d retries\n",
 			count);
-		return -EIO;
-	} else if (status != 0) {
+		ret = -EIO;
+	} else if (*status != 0) {
 		dev_err(line6->ifcdev, "write failed (error %d)\n", ret);
-		return -EIO;
+		ret = -EIO;
 	}
-
-	return 0;
+exit:
+	kfree(status);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(line6_write_data);
 
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -225,28 +225,32 @@ static void podhd_startup_start_workqueu
 static int podhd_dev_start(struct usb_line6_podhd *pod)
 {
 	int ret;
-	u8 init_bytes[8];
+	u8 *init_bytes;
 	int i;
 	struct usb_device *usbdev = pod->line6.usbdev;
 
+	init_bytes = kmalloc(8, GFP_KERNEL);
+	if (!init_bytes)
+		return -ENOMEM;
+
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0),
 					0x67, USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
 					0x11, 0,
 					NULL, 0, LINE6_TIMEOUT * HZ);
 	if (ret < 0) {
 		dev_err(pod->line6.ifcdev, "read request failed (error %d)\n", ret);
-		return ret;
+		goto exit;
 	}
 
 	/* NOTE: looks like some kind of ping message */
 	ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0), 0x67,
 					USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
 					0x11, 0x0,
-					&init_bytes, 3, LINE6_TIMEOUT * HZ);
+					init_bytes, 3, LINE6_TIMEOUT * HZ);
 	if (ret < 0) {
 		dev_err(pod->line6.ifcdev,
 			"receive length failed (error %d)\n", ret);
-		return ret;
+		goto exit;
 	}
 
 	pod->firmware_version =
@@ -255,7 +259,7 @@ static int podhd_dev_start(struct usb_li
 	for (i = 0; i <= 16; i++) {
 		ret = line6_read_data(&pod->line6, 0xf000 + 0x08 * i, init_bytes, 8);
 		if (ret < 0)
-			return ret;
+			goto exit;
 	}
 
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0),
@@ -263,10 +267,9 @@ static int podhd_dev_start(struct usb_li
 					USB_TYPE_STANDARD | USB_RECIP_DEVICE | USB_DIR_OUT,
 					1, 0,
 					NULL, 0, LINE6_TIMEOUT * HZ);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+exit:
+	kfree(init_bytes);
+	return ret;
 }
 
 static void podhd_startup_workqueue(struct work_struct *work)
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -365,16 +365,21 @@ static bool toneport_has_source_select(s
 /*
 	Setup Toneport device.
 */
-static void toneport_setup(struct usb_line6_toneport *toneport)
+static int toneport_setup(struct usb_line6_toneport *toneport)
 {
-	u32 ticks;
+	u32 *ticks;
 	struct usb_line6 *line6 = &toneport->line6;
 	struct usb_device *usbdev = line6->usbdev;
 
+	ticks = kmalloc(sizeof(*ticks), GFP_KERNEL);
+	if (!ticks)
+		return -ENOMEM;
+
 	/* sync time on device with host: */
 	/* note: 32-bit timestamps overflow in year 2106 */
-	ticks = (u32)ktime_get_real_seconds();
-	line6_write_data(line6, 0x80c6, &ticks, 4);
+	*ticks = (u32)ktime_get_real_seconds();
+	line6_write_data(line6, 0x80c6, ticks, 4);
+	kfree(ticks);
 
 	/* enable device: */
 	toneport_send_cmd(usbdev, 0x0301, 0x0000);
@@ -451,7 +456,9 @@ static int toneport_init(struct usb_line
 			return err;
 	}
 
-	toneport_setup(toneport);
+	err = toneport_setup(toneport);
+	if (err)
+		return err;
 
 	/* register audio system: */
 	return snd_card_register(line6->card);
@@ -463,7 +470,11 @@ static int toneport_init(struct usb_line
 */
 static int toneport_reset_resume(struct usb_interface *interface)
 {
-	toneport_setup(usb_get_intfdata(interface));
+	int err;
+
+	err = toneport_setup(usb_get_intfdata(interface));
+	if (err)
+		return err;
 	return line6_resume(interface);
 }
 #endif
