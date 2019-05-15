Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499C6C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8B220657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922300;
	bh=fm6GQRc1mphsOT9eaOHM8qZQmSt9Khu9kqnua4gfwM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gJI4gUKRG37qCbyEA3hdKt9bcll5QzWHKvaLJUvNSuY+AWvpKvLLmo9MiDljaX0lk
	 AHdBAsadVae3Cq+qajEy+2EFrAeqmiMbX5eo01qDd7ygZXh/AvtmlKtd7I58YDRbHO
	 QVD+j6wtZ7almb6AjSeACBD5Xb9idY4lRkDDT/Rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfEOMLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbfEOLGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:06:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72E5921743;
        Wed, 15 May 2019 11:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918388;
        bh=fm6GQRc1mphsOT9eaOHM8qZQmSt9Khu9kqnua4gfwM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QGEtCsKBP/yk9NUErwBIHCAr93MGRRazVsI4JPOqrOmwqTZOueOofj8OsslMS4MgI
         g7AZcTgssKP4RSL4Zr+X789KTBZB0iKKA2sHutd3xnxZSDy9MSk5BabUhipj2btRdy
         AWSKmvwPa3BXPjRqJvk4Jm/Wzyv1HQd7TjFa9Ihk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christo Gouws <gouws.christo@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 110/266] ALSA: line6: use dynamic buffers
Date:   Wed, 15 May 2019 12:53:37 +0200
Message-Id: <20190515090726.178339038@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit e5c812e84f0dece3400d5caf42522287e6ef139f upstream.

The line6 driver uses a lot of USB buffers off of the stack, which is
not allowed on many systems, causing the driver to crash on some of
them.  Fix this up by dynamically allocating the buffers with kmalloc()
which allows for proper DMA-able memory.

Reported-by: Christo Gouws <gouws.christo@gmail.com>
Reported-by: Alan Stern <stern@rowland.harvard.edu>
Tested-by: Christo Gouws <gouws.christo@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/line6/driver.c   |   60 ++++++++++++++++++++++++++-------------------
 sound/usb/line6/toneport.c |   24 +++++++++++++-----
 2 files changed, 53 insertions(+), 31 deletions(-)

--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -307,12 +307,16 @@ int line6_read_data(struct usb_line6 *li
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
@@ -321,7 +325,7 @@ int line6_read_data(struct usb_line6 *li
 
 	if (ret < 0) {
 		dev_err(line6->ifcdev, "read request failed (error %d)\n", ret);
-		return ret;
+		goto exit;
 	}
 
 	/* Wait for data length. We'll get 0xff until length arrives. */
@@ -331,28 +335,29 @@ int line6_read_data(struct usb_line6 *li
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
@@ -361,12 +366,12 @@ int line6_read_data(struct usb_line6 *li
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
 
@@ -378,12 +383,16 @@ int line6_write_data(struct usb_line6 *l
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
@@ -392,7 +401,7 @@ int line6_write_data(struct usb_line6 *l
 	if (ret < 0) {
 		dev_err(line6->ifcdev,
 			"write request failed (error %d)\n", ret);
-		return ret;
+		goto exit;
 	}
 
 	for (count = 0; count < LINE6_READ_WRITE_MAX_RETRIES; count++) {
@@ -403,28 +412,29 @@ int line6_write_data(struct usb_line6 *l
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
 
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -365,15 +365,20 @@ static bool toneport_has_source_select(s
 /*
 	Setup Toneport device.
 */
-static void toneport_setup(struct usb_line6_toneport *toneport)
+static int toneport_setup(struct usb_line6_toneport *toneport)
 {
-	int ticks;
+	int *ticks;
 	struct usb_line6 *line6 = &toneport->line6;
 	struct usb_device *usbdev = line6->usbdev;
 
+	ticks = kmalloc(sizeof(*ticks), GFP_KERNEL);
+	if (!ticks)
+		return -ENOMEM;
+
 	/* sync time on device with host: */
-	ticks = (int)get_seconds();
-	line6_write_data(line6, 0x80c6, &ticks, 4);
+	*ticks = (int)get_seconds();
+	line6_write_data(line6, 0x80c6, ticks, 4);
+	kfree(ticks);
 
 	/* enable device: */
 	toneport_send_cmd(usbdev, 0x0301, 0x0000);
@@ -388,6 +393,7 @@ static void toneport_setup(struct usb_li
 		toneport_update_led(toneport);
 
 	mod_timer(&toneport->timer, jiffies + TONEPORT_PCM_DELAY * HZ);
+	return 0;
 }
 
 /*
@@ -451,7 +457,9 @@ static int toneport_init(struct usb_line
 			return err;
 	}
 
-	toneport_setup(toneport);
+	err = toneport_setup(toneport);
+	if (err)
+		return err;
 
 	/* register audio system: */
 	return snd_card_register(line6->card);
@@ -463,7 +471,11 @@ static int toneport_init(struct usb_line
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


