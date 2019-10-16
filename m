Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE69FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F01207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264475;
	bh=eOzkQT98W/IYT6PiIG82ruPFZC0IMUbth5LIzdiklUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hQROrU0Ltw8gS5hPN9Gjz6MYHjxUbiT/A1IZd5vaYx+VSXB7wft3Kl1zy7MR9iDgX
	 QhRaOhEnBA+2Q0NmfmAgamV8c7T9iRXYKykUzhH8lHZBdeluw8cJsq+KWnx0ope3F0
	 /W/TZeLxWElNPDRLJ1vgMwEnqDPbK5xqZ/kx/IIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407554AbfJPWVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437558AbfJPVxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:38 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5E6121925;
        Wed, 16 Oct 2019 21:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262818;
        bh=eOzkQT98W/IYT6PiIG82ruPFZC0IMUbth5LIzdiklUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgWsxYPVNTvD9c3PqMfad/ObtuuvC5bKRAhnTWVFF+UEXp8sqIJxQcqUx1fcxxEWU
         F4oAEfWNnQ9ROnbKvUIhOJlgNK5gS7YD6qH6tSGG+tBCAuA8uUJOW9XNhRpClk4SYU
         t4YXgQc8FvGEUxnRVol9a5vigxxXsw7CILfKqrCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f9549f5ee8a5416f0b95@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 60/79] USB: legousbtower: fix deadlock on disconnect
Date:   Wed, 16 Oct 2019 14:50:35 -0700
Message-Id: <20191016214822.646985725@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 33a7813219f208f4952ece60ee255fd983272dec upstream.

Fix a potential deadlock if disconnect races with open.

Since commit d4ead16f50f9 ("USB: prevent char device open/deregister
race") core holds an rw-semaphore while open is called and when
releasing the minor number during deregistration. This can lead to an
ABBA deadlock if a driver takes a lock in open which it also holds
during deregistration.

This effectively reverts commit 78663ecc344b ("USB: disconnect open race
in legousbtower") which needlessly introduced this issue after a generic
fix for this race had been added to core by commit d4ead16f50f9 ("USB:
prevent char device open/deregister race").

Fixes: 78663ecc344b ("USB: disconnect open race in legousbtower")
Cc: stable <stable@vger.kernel.org>	# 2.6.24
Reported-by: syzbot+f9549f5ee8a5416f0b95@syzkaller.appspotmail.com
Tested-by: syzbot+f9549f5ee8a5416f0b95@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20190919083039.30898-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/legousbtower.c |   19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -185,7 +185,6 @@ static const struct usb_device_id tower_
 };
 
 MODULE_DEVICE_TABLE (usb, tower_table);
-static DEFINE_MUTEX(open_disc_mutex);
 
 #define LEGO_USB_TOWER_MINOR_BASE	160
 
@@ -338,18 +337,14 @@ static int tower_open (struct inode *ino
 		goto exit;
 	}
 
-	mutex_lock(&open_disc_mutex);
 	dev = usb_get_intfdata(interface);
-
 	if (!dev) {
-		mutex_unlock(&open_disc_mutex);
 		retval = -ENODEV;
 		goto exit;
 	}
 
 	/* lock this device */
 	if (mutex_lock_interruptible(&dev->lock)) {
-		mutex_unlock(&open_disc_mutex);
 	        retval = -ERESTARTSYS;
 		goto exit;
 	}
@@ -357,12 +352,10 @@ static int tower_open (struct inode *ino
 
 	/* allow opening only once */
 	if (dev->open_count) {
-		mutex_unlock(&open_disc_mutex);
 		retval = -EBUSY;
 		goto unlock_exit;
 	}
 	dev->open_count = 1;
-	mutex_unlock(&open_disc_mutex);
 
 	/* reset the tower */
 	result = usb_control_msg (dev->udev,
@@ -429,10 +422,9 @@ static int tower_release (struct inode *
 
 	if (dev == NULL) {
 		retval = -ENODEV;
-		goto exit_nolock;
+		goto exit;
 	}
 
-	mutex_lock(&open_disc_mutex);
 	if (mutex_lock_interruptible(&dev->lock)) {
 	        retval = -ERESTARTSYS;
 		goto exit;
@@ -462,10 +454,7 @@ static int tower_release (struct inode *
 
 unlock_exit:
 	mutex_unlock(&dev->lock);
-
 exit:
-	mutex_unlock(&open_disc_mutex);
-exit_nolock:
 	return retval;
 }
 
@@ -944,7 +933,6 @@ static int tower_probe (struct usb_inter
 	if (retval) {
 		/* something prevented us from registering this driver */
 		dev_err(idev, "Not able to get a minor for this device.\n");
-		usb_set_intfdata (interface, NULL);
 		goto error;
 	}
 	dev->minor = interface->minor;
@@ -976,16 +964,13 @@ static void tower_disconnect (struct usb
 	int minor;
 
 	dev = usb_get_intfdata (interface);
-	mutex_lock(&open_disc_mutex);
-	usb_set_intfdata (interface, NULL);
 
 	minor = dev->minor;
 
-	/* give back our minor */
+	/* give back our minor and prevent further open() */
 	usb_deregister_dev (interface, &tower_class);
 
 	mutex_lock(&dev->lock);
-	mutex_unlock(&open_disc_mutex);
 
 	/* if the device is not opened, then we clean up right now */
 	if (!dev->open_count) {


