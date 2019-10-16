Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6544DECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BBD21928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263152;
	bh=axZIwNdfKdDdPLE4tMS6r7yKnYi7SwZ0HbtEFjMZyz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iVOdxOnD2TWdLDvDdCC3jUZcgeWzutvve0ST6C/GgGGaiIkxbdAOKaMmkD5XvImKZ
	 ID8AM79HPDDytqjDGGHBDMKhndgi9NzAe8ggYO1v2lLEPvZ9lLxsuD7gJemTbHuu8i
	 SPPPikDxUcmeSAHYBHTI5C1oecv3Yyp/wUtbG/UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438421AbfJPV7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406710AbfJPV6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:17 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D11821928;
        Wed, 16 Oct 2019 21:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263097;
        bh=axZIwNdfKdDdPLE4tMS6r7yKnYi7SwZ0HbtEFjMZyz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0WKuhvYFOkOZC+fO/7YtO3mhhm7MRcKMIOXeHHzAfY7A0+70ZQQi1skFWpU2+JOr
         SEMWJYVARGWT+I86OTjg8jt/6IOUZQWxwF9FmknKjDNwDZ7+1stHySjaQ5CttYfqwj
         2galNK/9OP7rNbAQmhKM45g/PcilMI9Jbxawco4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.3 019/112] USB: iowarrior: fix use-after-free on release
Date:   Wed, 16 Oct 2019 14:50:11 -0700
Message-Id: <20191016214849.418931324@linuxfoundation.org>
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

commit 80cd5479b525093a56ef768553045741af61b250 upstream.

The driver was accessing its struct usb_interface from its release()
callback without holding a reference. This would lead to a
use-after-free whenever debugging was enabled and the device was
disconnected while its character device was open.

Fixes: 549e83500b80 ("USB: iowarrior: Convert local dbg macro to dev_dbg")
Cc: stable <stable@vger.kernel.org>     # 3.16
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191009104846.5925-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/iowarrior.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -243,6 +243,7 @@ static inline void iowarrior_delete(stru
 	kfree(dev->int_in_buffer);
 	usb_free_urb(dev->int_in_urb);
 	kfree(dev->read_queue);
+	usb_put_intf(dev->interface);
 	kfree(dev);
 }
 
@@ -764,7 +765,7 @@ static int iowarrior_probe(struct usb_in
 	init_waitqueue_head(&dev->write_wait);
 
 	dev->udev = udev;
-	dev->interface = interface;
+	dev->interface = usb_get_intf(interface);
 
 	iface_desc = interface->cur_altsetting;
 	dev->product_id = le16_to_cpu(udev->descriptor.idProduct);


