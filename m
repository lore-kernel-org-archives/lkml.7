Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E512ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DB72168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264188;
	bh=bU4CuMd2VNYjjpDGrnKUfxlztZgEPyz8hEzwiyxPeGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xKhKzMuLDHeINHu5uIY12bfSTEz/Knmt0GIXPB0P5QPOGHh0qEmmWWH4ZJVxWMi6E
	 jlmLvsAcxL4M1lUbCEw2GGHwv0AilN/U9gpVEq8g4cTRZGZvcYpmG21ps7VvdGgZBI
	 kQVznxIXJrg942KLSIadtteAaNgdjb/0BbhaIw2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437720AbfJPWQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388653AbfJPVzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:10 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3014218DE;
        Wed, 16 Oct 2019 21:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262909;
        bh=bU4CuMd2VNYjjpDGrnKUfxlztZgEPyz8hEzwiyxPeGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7hVxwcLp3oza5FPfK7M2OOnZyzaFJYAjZRqMTaue+GKpVxniYmku2HzoCJ46pqfP
         oshSnHWh4Sajmi+ldQzXbxI+aLouXVXpYHpOBOy+3StoTE+UXNz/C9iHNGrtbEyQSF
         +LT4M+Ci4Ncf0cqGWayMLVCN2jMrP09K6tG6SR8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 52/92] USB: iowarrior: fix use-after-free on release
Date:   Wed, 16 Oct 2019 14:50:25 -0700
Message-Id: <20191016214837.207999160@linuxfoundation.org>
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
@@ -248,6 +248,7 @@ static inline void iowarrior_delete(stru
 	kfree(dev->int_in_buffer);
 	usb_free_urb(dev->int_in_urb);
 	kfree(dev->read_queue);
+	usb_put_intf(dev->interface);
 	kfree(dev);
 }
 
@@ -776,7 +777,7 @@ static int iowarrior_probe(struct usb_in
 	init_waitqueue_head(&dev->write_wait);
 
 	dev->udev = udev;
-	dev->interface = interface;
+	dev->interface = usb_get_intf(interface);
 
 	iface_desc = interface->cur_altsetting;
 	dev->product_id = le16_to_cpu(udev->descriptor.idProduct);


