Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B9ECA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D662166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="NwULFx1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410111AbfJXRFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:05:14 -0400
Received: from dougal.metanate.com ([90.155.101.14]:13807 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2410088AbfJXRFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gqqO7kvxln6um6tt7UgRTKE7dTS/mPaPHkT0N4qUVrk=; b=NwULFx1eh65Q3mZp0N2VCuJ2hd
        WlMAjH0Gs7tsvg5RW7FOomoyIw2owTkcoOlycgwJymu9EtCO+h9BBJoFi4GOpSb6ULGbN2C3UUW/c
        Ei++xzSj5hKzNDH1ZTFMkiXiwk7ejkAF1I5Ukr6/mVaI/f4nAK1DUSVaM+prX/z4zUkBV1C/rqPyL
        +7m2oaNShmP2Y7QgU1eNqfRl83mwL/t5aOCDtiZhwmASPiAsK4Z1rEjMU/OihXY3SlGu3z+8i+y1w
        EYtiMAUm23r9QKmTWdAhbPQKX4Zafj3yvnVLR8vJYYbtJxQuWViThB4etwBkIh+VyuGCJZoE540AP
        iwVrXMKQ==;
Received: from 188-39-28-98.static.enta.net ([188.39.28.98] helo=donbot.corp.numark.com)
        by email.metanate.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <john@metanate.com>)
        id 1iNgFA-0004oc-8O; Thu, 24 Oct 2019 17:45:48 +0100
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH 4/6] USB: gadget: f_hid: decouple cdev from f_hidg lifetime
Date:   Thu, 24 Oct 2019 17:45:36 +0100
Message-Id: <20191024164538.3161474-5-john@metanate.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024164538.3161474-1-john@metanate.com>
References: <20191024164538.3161474-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The character device needs to live until the last file descriptor has
been closed (and until after ->release() is called in that case).
Change the lifetime of our character devices to match the module, so as
to avoid a use-after-free when closing a file descriptor after the
gadget function has been deleted.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/f_hid.c | 45 ++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 4d20347fe908..ee94348b85ef 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -24,6 +24,7 @@
 
 static int major, minors;
 static struct class *hidg_class;
+static struct cdev *hidg_cdev;
 static DEFINE_IDR(hidg_idr);
 static DEFINE_MUTEX(hidg_idr_lock); /* protects access to hidg_idr */
 
@@ -58,7 +59,6 @@ struct f_hidg {
 	struct usb_request		*req;
 
 	int				minor;
-	struct cdev			cdev;
 	struct usb_function		func;
 
 	struct usb_ep			*in_ep;
@@ -827,11 +827,7 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	INIT_LIST_HEAD(&hidg->completed_out_req);
 
 	/* create char device */
-	cdev_init(&hidg->cdev, &f_hidg_fops);
 	dev = MKDEV(major, hidg->minor);
-	status = cdev_add(&hidg->cdev, dev, 1);
-	if (status)
-		goto fail_free_descs;
 
 	mutex_lock(&hidg_idr_lock);
 	idr_replace(&hidg_idr, hidg, hidg->minor);
@@ -841,13 +837,14 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 			       "%s%d", "hidg", hidg->minor);
 	if (IS_ERR(device)) {
 		status = PTR_ERR(device);
-		goto del;
+		goto fail_idr_remove;
 	}
 
 	return 0;
-del:
-	cdev_del(&hidg->cdev);
-fail_free_descs:
+fail_idr_remove:
+	mutex_lock(&hidg_idr_lock);
+	idr_replace(&hidg_idr, NULL, hidg->minor);
+	mutex_unlock(&hidg_idr_lock);
 	usb_free_all_descriptors(f);
 fail:
 	ERROR(f->config->cdev, "hidg_bind FAILED\n");
@@ -1071,7 +1068,10 @@ static void hidg_unbind(struct usb_configuration *c, struct usb_function *f)
 	struct f_hidg *hidg = func_to_hidg(f);
 
 	device_destroy(hidg_class, MKDEV(major, hidg->minor));
-	cdev_del(&hidg->cdev);
+
+	mutex_lock(&hidg_idr_lock);
+	idr_replace(&hidg_idr, NULL, hidg->minor);
+	mutex_unlock(&hidg_idr_lock);
 
 	usb_free_all_descriptors(f);
 }
@@ -1129,6 +1129,7 @@ MODULE_AUTHOR("Fabien Chouteau");
 
 static int ghid_setup(void)
 {
+	struct cdev *cdev = NULL;
 	int status;
 	dev_t dev;
 
@@ -1149,11 +1150,35 @@ static int ghid_setup(void)
 	major = MAJOR(dev);
 	minors = HIDG_MINORS;
 
+	status = -ENOMEM;
+	cdev = cdev_alloc();
+	if (!cdev)
+		goto fail_unregister;
+
+	cdev->owner = THIS_MODULE;
+	cdev->ops = &f_hidg_fops;
+	kobject_set_name(&cdev->kobj, "hidg");
+
+	status = cdev_add(cdev, dev, HIDG_MINORS);
+	if (status)
+		goto fail_put;
+
+	hidg_cdev = cdev;
 	return 0;
+
+fail_put:
+	kobject_put(&cdev->kobj);
+fail_unregister:
+	unregister_chrdev_region(dev, HIDG_MINORS);
+	class_destroy(hidg_class);
+	hidg_class = NULL;
+	return status;
 }
 
 static void ghid_cleanup(void)
 {
+	cdev_del(hidg_cdev);
+
 	if (major) {
 		unregister_chrdev_region(MKDEV(major, 0), minors);
 		major = minors = 0;
-- 
2.23.0

