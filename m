Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED00ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437CB21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571262926;
	bh=91dLTxL1+yZrbkADc3p44ZP+AXwaxgJkAIS8hUcNT8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Au+xXnZrNA9BLNk5mgOuvjnQChANdtZAc4GLTXEbSleep2puFr+XJBYpO4zK8d+uP
	 KDaBH55geeQXVSYkgNpaatjWHtWbtJgto39vVZ4pdLyEdTe97E1IHdjJxFADa0buFu
	 WFrceVfK6HOFdIqd8PKzUQ9AOboixJCUtsTFNj40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437816AbfJPVzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437772AbfJPVzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:20 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0010121D7D;
        Wed, 16 Oct 2019 21:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262920;
        bh=91dLTxL1+yZrbkADc3p44ZP+AXwaxgJkAIS8hUcNT8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNvDpF3/I82xcVe/we1KLBCXLLUgwf8FCMDpAL2jUtPvwPSwrtYnh0iltBrrh31lZ
         KztgoaM8xrvk6laTx9PxSoHUNbj3YgVZ6lGlYWgZEGWDMGFIW25gXUauH/Dzle6fl1
         GoS987ZfCcf7YL65wa0c9gK9MvKcDBKONUTHr17E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 53/92] USB: iowarrior: fix use-after-free after driver unbind
Date:   Wed, 16 Oct 2019 14:50:26 -0700
Message-Id: <20191016214837.632917418@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
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
@@ -435,11 +436,13 @@ static ssize_t iowarrior_write(struct fi
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
@@ -782,6 +785,8 @@ static int iowarrior_probe(struct usb_in
 	iface_desc = interface->cur_altsetting;
 	dev->product_id = le16_to_cpu(udev->descriptor.idProduct);
 
+	init_usb_anchor(&dev->submitted);
+
 	/* set up the endpoint information */
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
@@ -905,6 +910,7 @@ static void iowarrior_disconnect(struct
 		   Deleting the device is postponed until close() was called.
 		 */
 		usb_kill_urb(dev->int_in_urb);
+		usb_kill_anchored_urbs(&dev->submitted);
 		wake_up_interruptible(&dev->read_wait);
 		wake_up_interruptible(&dev->write_wait);
 		mutex_unlock(&dev->mutex);


