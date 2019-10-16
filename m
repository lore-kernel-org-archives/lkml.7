Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8438DECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DAB21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263167;
	bh=E2zSj+5l3fEHkyKOKlJHqKi0v60aNokAkhOX6t/Y5CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WzEWnE7OFIlTbkghSewwFYJoDNLrbUPQb8R0LXU1YfXufCn7L2qsWrqkRiBA1AX+f
	 /2f1e4AFg39EwQzNeZ7iyn1WJhN7yJn1LrOmcxGQqVT4/iaHHViBKg1/62spA4TvTl
	 FMD9TPaoNbM+H59RV5xGy65YZem1lAv0N/Lj83Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438507AbfJPV70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395490AbfJPV61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:27 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E398521928;
        Wed, 16 Oct 2019 21:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263107;
        bh=E2zSj+5l3fEHkyKOKlJHqKi0v60aNokAkhOX6t/Y5CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmqSYgHawF6aYHWT/qa0YRLk4BSAhddbMqIROvCfhovXc5A9wkpVMLGSuhIuG80wl
         x/8/Prve/eagStGzBQqrcy7rmSztGPIfgwnsrA7h7nA1n+QBnLvZlQw68GGu3ywVuQ
         L2vPpVbXhk+NKc6E2AVUyWbriwGoxOHmRZHyX4fg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.3 022/112] USB: chaoskey: fix use-after-free on release
Date:   Wed, 16 Oct 2019 14:50:14 -0700
Message-Id: <20191016214850.841829463@linuxfoundation.org>
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

commit 93ddb1f56ae102f14f9e46a9a9c8017faa970003 upstream.

The driver was accessing its struct usb_interface in its release()
callback without holding a reference. This would lead to a
use-after-free whenever the device was disconnected while the character
device was still open.

Fixes: 66e3e591891d ("usb: Add driver for Altus Metrum ChaosKey device (v2)")
Cc: stable <stable@vger.kernel.org>     # 4.1
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191009153848.8664-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/chaoskey.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -98,6 +98,7 @@ static void chaoskey_free(struct chaoske
 		usb_free_urb(dev->urb);
 		kfree(dev->name);
 		kfree(dev->buf);
+		usb_put_intf(dev->interface);
 		kfree(dev);
 	}
 }
@@ -145,6 +146,8 @@ static int chaoskey_probe(struct usb_int
 	if (dev == NULL)
 		goto out;
 
+	dev->interface = usb_get_intf(interface);
+
 	dev->buf = kmalloc(size, GFP_KERNEL);
 
 	if (dev->buf == NULL)
@@ -174,8 +177,6 @@ static int chaoskey_probe(struct usb_int
 			goto out;
 	}
 
-	dev->interface = interface;
-
 	dev->in_ep = in_ep;
 
 	if (le16_to_cpu(udev->descriptor.idVendor) != ALEA_VENDOR_ID)


