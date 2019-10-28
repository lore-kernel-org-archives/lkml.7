Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B08CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76DE214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="mjFa0gJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbfJ1LnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:43:00 -0400
Received: from dougal.metanate.com ([90.155.101.14]:58166 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727225AbfJ1LnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gvMfLh+YRX5h+NeO0cijiJcG+SWNrmorQ1gq6rn2++0=; b=mjFa0gJwbwJ2hNyjVmg6/IdfVu
        59RoUPhgGAffgLln4Aopn65srewCihVIXydpvnMzE4pEckky26bdmw32mFGR0hC3BJVdF65qnILdd
        2nkl3nEGhwjGJkEr9yykQWs0zXucTGBrpOkZIiYthe50XGvooWgGeWGkK4evp7BvUcNaqWhvSPTyo
        VeSvj75d//V9doHG1EPhYXllAv/E/rbFcGmGtDOb4+1Rr7GxaNcfGCbbNRzdWx6yycrkCmJ0zcGhA
        SbLNkiEKXAeXSjdwYk72xoHqE6fOZMJl1L6x2F/QTtDmxOprCmK0f5JVuv8weof1UdIXbzt6DFDkR
        pT+zrPvg==;
Received: from dougal.metanate.com ([192.168.88.1] helo=localhost.localdomain)
        by email.metanate.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <john@metanate.com>)
        id 1iP3QH-00010o-EZ; Mon, 28 Oct 2019 11:42:57 +0000
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH v2 4/6] USB: gadget: f_hid: decouple cdev from f_hidg lifetime
Date:   Mon, 28 Oct 2019 11:42:26 +0000
Message-Id: <20191028114228.3679219-5-john@metanate.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028114228.3679219-1-john@metanate.com>
References: <20191024164538.3161474-1-john@metanate.com>
 <20191028114228.3679219-1-john@metanate.com>
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
v2:
- Updated for changes in patch 1

 drivers/usb/gadget/function/f_hid.c | 42 +++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 6cf3b5b14ded..eda4f24d2790 100644
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
 
@@ -1149,12 +1150,30 @@ static int ghid_setup(void)
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
 	status = usb_function_register(&hidusb_func);
 	if (status)
-		goto fail_unregister;
+		goto fail_cdev_del;
 
+	hidg_cdev = cdev;
 	return 0;
 
+fail_cdev_del:
+	cdev_del(cdev);
+fail_put:
+	kobject_put(&cdev->kobj);
 fail_unregister:
 	unregister_chrdev_region(dev, HIDG_MINORS);
 	class_destroy(hidg_class);
@@ -1165,6 +1184,7 @@ static int ghid_setup(void)
 static void ghid_cleanup(void)
 {
 	usb_function_unregister(&hidusb_func);
+	cdev_del(hidg_cdev);
 
 	if (major) {
 		unregister_chrdev_region(MKDEV(major, 0), minors);
-- 
2.23.0

