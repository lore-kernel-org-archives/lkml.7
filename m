Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8835DFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602C5207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263636;
	bh=j2Kea0bE5YPfSD8GDG5IM2lKTZbtNSzqMUTMAlbqafQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AY+lqRZe7dkT1foGXuis1z4jTYQD+n7gW677LWRhpWKHZJ2W57a5HIzDlF8Mkhyq/
	 xLDFwrdTltBiN83yGIq0PAVm+BzfeQ2Mo5jxa8IwD+b5Y7PpCo03oKX9ETJClC12+D
	 WtZRvNqODJ7nNIRYEci4BYF7bdw3jSqWgAD6tu/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438289AbfJPWHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390386AbfJPV6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:15 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5753021D7C;
        Wed, 16 Oct 2019 21:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263094;
        bh=j2Kea0bE5YPfSD8GDG5IM2lKTZbtNSzqMUTMAlbqafQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbxHUAujFcwoBKqdM+jtITDwjRaARiA+NpwxqXtuY53qBBNm6Lop1nTq0tPlmlDAj
         KRHFS/7J9oCxa86EAvc/nXvAW2Lz3zjmJ+qm1cXYyX2YcBS/+mlmH41ZyEM2uY37Hi
         355DhyeDv58O1APh9j+yvXceWAZJfOZG9MtsKKa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.3 016/112] USB: adutux: fix NULL-derefs on disconnect
Date:   Wed, 16 Oct 2019 14:50:08 -0700
Message-Id: <20191016214848.429300497@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit b2fa7baee744fde746c17bc1860b9c6f5c2eebb7 upstream.

The driver was using its struct usb_device pointer as an inverted
disconnected flag, but was setting it to NULL before making sure all
completion handlers had run. This could lead to a NULL-pointer
dereference in a number of dev_dbg statements in the completion handlers
which relies on said pointer.

The pointer was also dereferenced unconditionally in a dev_dbg statement
release() something which would lead to a NULL-deref whenever a device
was disconnected before the final character-device close if debugging
was enabled.

Fix this by unconditionally stopping all I/O and preventing
resubmissions by poisoning the interrupt URBs at disconnect and using a
dedicated disconnected flag.

This also makes sure that all I/O has completed by the time the
disconnect callback returns.

Fixes: 1ef37c6047fe ("USB: adutux: remove custom debug macro and module parameter")
Fixes: 66d4bc30d128 ("USB: adutux: remove custom debug macro")
Cc: stable <stable@vger.kernel.org>     # 3.12
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20190925092913.8608-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/adutux.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -75,6 +75,7 @@ struct adu_device {
 	char			serial_number[8];
 
 	int			open_count; /* number of times this port has been opened */
+	unsigned long		disconnected:1;
 
 	char		*read_buffer_primary;
 	int			read_buffer_length;
@@ -116,7 +117,7 @@ static void adu_abort_transfers(struct a
 {
 	unsigned long flags;
 
-	if (dev->udev == NULL)
+	if (dev->disconnected)
 		return;
 
 	/* shutdown transfer */
@@ -243,7 +244,7 @@ static int adu_open(struct inode *inode,
 	}
 
 	dev = usb_get_intfdata(interface);
-	if (!dev || !dev->udev) {
+	if (!dev) {
 		retval = -ENODEV;
 		goto exit_no_device;
 	}
@@ -326,7 +327,7 @@ static int adu_release(struct inode *ino
 	}
 
 	adu_release_internal(dev);
-	if (dev->udev == NULL) {
+	if (dev->disconnected) {
 		/* the device was unplugged before the file was released */
 		if (!dev->open_count)	/* ... and we're the last user */
 			adu_delete(dev);
@@ -354,7 +355,7 @@ static ssize_t adu_read(struct file *fil
 		return -ERESTARTSYS;
 
 	/* verify that the device wasn't unplugged */
-	if (dev->udev == NULL) {
+	if (dev->disconnected) {
 		retval = -ENODEV;
 		pr_err("No device or device unplugged %d\n", retval);
 		goto exit;
@@ -518,7 +519,7 @@ static ssize_t adu_write(struct file *fi
 		goto exit_nolock;
 
 	/* verify that the device wasn't unplugged */
-	if (dev->udev == NULL) {
+	if (dev->disconnected) {
 		retval = -ENODEV;
 		pr_err("No device or device unplugged %d\n", retval);
 		goto exit;
@@ -764,11 +765,14 @@ static void adu_disconnect(struct usb_in
 
 	usb_deregister_dev(interface, &adu_class);
 
+	usb_poison_urb(dev->interrupt_in_urb);
+	usb_poison_urb(dev->interrupt_out_urb);
+
 	mutex_lock(&adutux_mutex);
 	usb_set_intfdata(interface, NULL);
 
 	mutex_lock(&dev->mtx);	/* not interruptible */
-	dev->udev = NULL;	/* poison */
+	dev->disconnected = 1;
 	mutex_unlock(&dev->mtx);
 
 	/* if the device is not opened, then we clean up right now */


