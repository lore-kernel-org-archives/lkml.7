Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97967C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7177625207
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189686;
	bh=PUMGySMOvqViDwthjrKLycmSFSgpXE5ZVGTIsv2lKDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mp8Mhpe4fPltE1gKQ16wfqQCY3JFFQs1oBtbkZlxB95ZXrfRl8QULyacHdB1pobr6
	 5LSyWc0Y6yZr6RkU8jkTpYh0h9iZzlQnRApfT8/F8VuGC9hD1kGZX/bbSQx2qTmZdo
	 Uw9eNzrrhLEi58DyRZo/d1Aong/siEdtKqa7mQog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbfE3EOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730607AbfE3DQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:10 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94CBE245C1;
        Thu, 30 May 2019 03:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186169;
        bh=PUMGySMOvqViDwthjrKLycmSFSgpXE5ZVGTIsv2lKDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEI1Mlfk17nZBAQdNfCtU4vqReHciVNvT73jrasZWIL69OZIVqtQwNaFgv56k7Z8R
         O0hmOD6/QF6mzp6ZQYuR0uDnBjEgdoUNKSuyYwIXN40T8QJtuqRyxyN2lxJrlDRyS0
         FY+eyUjsrP6ir00hD67RKjt3XgcuyUfucxmA8qgE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Bernie Thompson <bernie@plugable.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Colin Ian King <colin.king@canonical.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.19 023/276] udlfb: fix some inconsistent NULL checking
Date:   Wed, 29 May 2019 20:03:01 -0700
Message-Id: <20190530030525.612759499@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit c143a559b073aeea688b9bb7c5b46f3cf322d569 upstream.

In the current kernel, then kzalloc() can't fail for small allocations,
but if it did fail then we would have a NULL dereference in the error
handling.  Also in dlfb_usb_disconnect() if "info" were NULL then it
would cause an Oops inside the unregister_framebuffer() function but it
can't be NULL so let's remove that check.

Fixes: 68a958a915ca ("udlfb: handle unplug properly")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Bernie Thompson <bernie@plugable.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Wen Yang <wen.yang99@zte.com.cn>
[b.zolnierkie: added "Fixes:" tag]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/udlfb.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1659,7 +1659,7 @@ static int dlfb_usb_probe(struct usb_int
 	dlfb = kzalloc(sizeof(*dlfb), GFP_KERNEL);
 	if (!dlfb) {
 		dev_err(&intf->dev, "%s: failed to allocate dlfb\n", __func__);
-		goto error;
+		return -ENOMEM;
 	}
 
 	INIT_LIST_HEAD(&dlfb->deferred_free);
@@ -1769,7 +1769,7 @@ static int dlfb_usb_probe(struct usb_int
 error:
 	if (dlfb->info) {
 		dlfb_ops_destroy(dlfb->info);
-	} else if (dlfb) {
+	} else {
 		usb_put_dev(dlfb->udev);
 		kfree(dlfb);
 	}
@@ -1796,12 +1796,10 @@ static void dlfb_usb_disconnect(struct u
 	/* this function will wait for all in-flight urbs to complete */
 	dlfb_free_urb_list(dlfb);
 
-	if (info) {
-		/* remove udlfb's sysfs interfaces */
-		for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++)
-			device_remove_file(info->dev, &fb_device_attrs[i]);
-		device_remove_bin_file(info->dev, &edid_attr);
-	}
+	/* remove udlfb's sysfs interfaces */
+	for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++)
+		device_remove_file(info->dev, &fb_device_attrs[i]);
+	device_remove_bin_file(info->dev, &edid_attr);
 
 	unregister_framebuffer(info);
 }


