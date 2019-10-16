Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A614FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FC0207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264034;
	bh=mROoGw3K30hCRnp8qGru45WqsaXtMc1lRQErYgNGCVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oXlCJJ6221iIVmDtJcPaQuAiU4l07dpZbeKwAcKNiJv9rhVFxKO4FlnONaQR9zEKC
	 0PWgTPZ2MMHr4/OfsuEpecwK+vizsrYyGRLI79MnEI5BhSrfwrBNQMqN09hQjeF3zs
	 eIEHH0Kpv06f7qiEIFestr04UtLMzWqJK/4ON/lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393334AbfJPWNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395278AbfJPVzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:44 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9F021925;
        Wed, 16 Oct 2019 21:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262943;
        bh=mROoGw3K30hCRnp8qGru45WqsaXtMc1lRQErYgNGCVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtqpnEiUYxwR/NO3/RdsrsKRnVV/Ru4arIKLPevEZHdIKhywNkf6qsSKIOjWo53kL
         wmbl3nFuoyQ7SrLSqH7ed54e4+4t9kQ/0tnJFKEimyfZCfCuS3mDtX/cNMqZxFHcmc
         UbGucEFO1eOidT+9yJsFHwm67JNLqlOGaIhM+2KE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 14/65] USB: adutux: fix use-after-free on disconnect
Date:   Wed, 16 Oct 2019 14:50:28 -0700
Message-Id: <20191016214806.795994962@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214756.457746573@linuxfoundation.org>
References: <20191016214756.457746573@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 44efc269db7929f6275a1fa927ef082e533ecde0 upstream.

The driver was clearing its struct usb_device pointer, which it used as
an inverted disconnected flag, before deregistering the character device
and without serialising against racing release().

This could lead to a use-after-free if a racing release() callback
observes the cleared pointer and frees the driver data before
disconnect() is finished with it.

This could also lead to NULL-pointer dereferences in a racing open().

Fixes: f08812d5eb8f ("USB: FIx locks and urb->status in adutux (updated)")
Cc: stable <stable@vger.kernel.org>     # 2.6.24
Reported-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
Tested-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20190925092913.8608-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/adutux.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -764,14 +764,15 @@ static void adu_disconnect(struct usb_in
 
 	dev = usb_get_intfdata(interface);
 
-	mutex_lock(&dev->mtx);	/* not interruptible */
-	dev->udev = NULL;	/* poison */
 	usb_deregister_dev(interface, &adu_class);
-	mutex_unlock(&dev->mtx);
 
 	mutex_lock(&adutux_mutex);
 	usb_set_intfdata(interface, NULL);
 
+	mutex_lock(&dev->mtx);	/* not interruptible */
+	dev->udev = NULL;	/* poison */
+	mutex_unlock(&dev->mtx);
+
 	/* if the device is not opened, then we clean up right now */
 	if (!dev->open_count)
 		adu_delete(dev);


