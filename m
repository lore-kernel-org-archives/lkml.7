Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593A2FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EB2207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264394;
	bh=ChfEVbx/mpk2KVxURUhdYDOF/BWXuLYcX9yTbqacXOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dSSBryeqYyohCGXu0Q6/VUrdVv9vmBARrNFXDWy+U1Xq32uNnR41GaQJBAfzyMLnu
	 fYyjzHg06pU2VxTUpcW8trJCsHq4MX6xwP9LxFygsSvn1OmH4ZBqll4FWiDdmCp0Ek
	 7w5cP3BAuqKrBxDNkZFzAtXA0BpgNgObx9duccIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405694AbfJPWTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437625AbfJPVx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:59 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 043F8222BD;
        Wed, 16 Oct 2019 21:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262839;
        bh=ChfEVbx/mpk2KVxURUhdYDOF/BWXuLYcX9yTbqacXOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwtFIqxNYstUxQXGhdZjfyinj36JpdNjaVRC6ZvlFNUXQ6zWyUnmYkxkvclQ55wzn
         JSr0Li3jKWC0dpH78yHCUhC+YywAh+VTXarEouMjQrDTwQ0BSbqLMX6p13TjxABCAn
         YCGIpAvP6NSTJghA4fuR/35J0SQhsvJ+l+MknOiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 44/79] USB: iowarrior: fix use-after-free after driver unbind
Date:   Wed, 16 Oct 2019 14:50:19 -0700
Message-Id: <20191016214806.597352224@linuxfoundation.org>
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

commit b5f8d46867ca233d773408ffbe691a8062ed718f upstream.

Make sure to stop also the asynchronous write URBs on disconnect() to
avoid use-after-free in the completion handler after driver unbind.

Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
Cc: stable <stable@vger.kernel.org>	# 2.6.21: 51a2f077c44e ("USB: introduce usb_anchor")
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191009104846.5925-4-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/iowarrior.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -89,6 +89,7 @@ struct iowarrior {
 	char chip_serial[9];		/* the serial number string of the chip connected */
 	int report_size;		/* number of bytes in a report */
 	u16 product_id;
+	struct usb_anchor submitted;
 };
 
 /*--------------*/
@@ -437,11 +438,13 @@ static ssize_t iowarrior_write(struct fi
 			retval = -EFAULT;
 			goto error;
 		}
+		usb_anchor_urb(int_out_urb, &dev->submitted);
 		retval = usb_submit_urb(int_out_urb, GFP_KERNEL);
 		if (retval) {
 			dev_dbg(&dev->interface->dev,
 				"submit error %d for urb nr.%d\n",
 				retval, atomic_read(&dev->write_busy));
+			usb_unanchor_urb(int_out_urb);
 			goto error;
 		}
 		/* submit was ok */
@@ -788,6 +791,8 @@ static int iowarrior_probe(struct usb_in
 	iface_desc = interface->cur_altsetting;
 	dev->product_id = le16_to_cpu(udev->descriptor.idProduct);
 
+	init_usb_anchor(&dev->submitted);
+
 	/* set up the endpoint information */
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
@@ -917,6 +922,7 @@ static void iowarrior_disconnect(struct
 		   Deleting the device is postponed until close() was called.
 		 */
 		usb_kill_urb(dev->int_in_urb);
+		usb_kill_anchored_urbs(&dev->submitted);
 		wake_up_interruptible(&dev->read_wait);
 		wake_up_interruptible(&dev->write_wait);
 		mutex_unlock(&dev->mutex);


