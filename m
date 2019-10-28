Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A5DCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792DF214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="SCyhU9n5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbfJ1LnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:43:24 -0400
Received: from dougal.metanate.com ([90.155.101.14]:65410 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388615AbfJ1LnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SGkZ9L6ksEJoGJ6vp6RGQ8/g+HjRI+7LlWLrCTmofEk=; b=SCyhU9n5+rNKbQmbcRe/RO33Qb
        8U+JwdBdzLvZ7MNTf5vyV3ijael9zi8mjbL1P5VOWum/7CFxQbbtRrvPDW/RO4sqJ5IvOITfy7eec
        xC+3O1k2mHoAL1lr3qX5ArOXc7+uThTDgPs3R9PcKB4Q9Wq31z00BqBUJWv6ltQm2oPZUvLT6eKoO
        dvfpZGHTflO/EfMPI/VmJNYe6Ma5lZuVlyV1t/kBAcY1bJN1bnZRNwxGrXG+zUu9r+WWqUBMkZ5Rs
        GnsHKF/dJnnu6ALNQzAXsgrdSsde01+PM9qJVjOOYJki5AfQjLBo/U5UHS9kSRPSG+D8G8tmkNciq
        5Y1Oni/g==;
Received: from dougal.metanate.com ([192.168.88.1] helo=localhost.localdomain)
        by email.metanate.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <john@metanate.com>)
        id 1iP3QH-00010o-7u; Mon, 28 Oct 2019 11:42:57 +0000
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH v2 1/6] USB: gadget: f_hid: move chardev setup to module init
Date:   Mon, 28 Oct 2019 11:42:23 +0000
Message-Id: <20191028114228.3679219-2-john@metanate.com>
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

Lifetime of the objects in the HID gadget is currently tied to the USB
function, which makes it very easy to trigger a use-after-free by
holding a file descriptor on the HID device after deleting the gadget.

As a first step towards fixing this, move the character device
allocation to module initialisation so that we don't have to worry about
when the allocation can be released after closing all of the open
handles on the device.

Note that we also have to move the USB function registration into the
initialisation function in order to avoid having two module_init()
functions.

Signed-off-by: John Keeping <john@metanate.com>
---
v2:
- Switch to DECLARE_USB_FUNCTION and manual function (de)registration to
  fix compiling as a module

 drivers/usb/gadget/function/f_hid.c | 41 ++++++++++++++---------------
 drivers/usb/gadget/function/u_hid.h |  3 ---
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index f3816a5c861e..e5e18d02b77a 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1006,11 +1006,7 @@ static void hidg_free_inst(struct usb_function_instance *f)
 	opts = container_of(f, struct f_hid_opts, func_inst);
 
 	mutex_lock(&hidg_ida_lock);
-
 	hidg_put_minor(opts->minor);
-	if (ida_is_empty(&hidg_ida))
-		ghid_cleanup();
-
 	mutex_unlock(&hidg_ida_lock);
 
 	if (opts->report_desc_alloc)
@@ -1023,7 +1019,6 @@ static struct usb_function_instance *hidg_alloc_inst(void)
 {
 	struct f_hid_opts *opts;
 	struct usb_function_instance *ret;
-	int status = 0;
 
 	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
@@ -1034,21 +1029,10 @@ static struct usb_function_instance *hidg_alloc_inst(void)
 
 	mutex_lock(&hidg_ida_lock);
 
-	if (ida_is_empty(&hidg_ida)) {
-		status = ghid_setup(NULL, HIDG_MINORS);
-		if (status)  {
-			ret = ERR_PTR(status);
-			kfree(opts);
-			goto unlock;
-		}
-	}
-
 	opts->minor = hidg_get_minor();
 	if (opts->minor < 0) {
 		ret = ERR_PTR(opts->minor);
 		kfree(opts);
-		if (ida_is_empty(&hidg_ida))
-			ghid_cleanup();
 		goto unlock;
 	}
 	config_group_init_type_name(&opts->func_inst.group, "", &hid_func_type);
@@ -1129,11 +1113,11 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	return &hidg->func;
 }
 
-DECLARE_USB_FUNCTION_INIT(hid, hidg_alloc_inst, hidg_alloc);
+DECLARE_USB_FUNCTION(hid, hidg_alloc_inst, hidg_alloc);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Fabien Chouteau");
 
-int ghid_setup(struct usb_gadget *g, int count)
+static int ghid_setup(void)
 {
 	int status;
 	dev_t dev;
@@ -1145,7 +1129,7 @@ int ghid_setup(struct usb_gadget *g, int count)
 		return status;
 	}
 
-	status = alloc_chrdev_region(&dev, 0, count, "hidg");
+	status = alloc_chrdev_region(&dev, 0, HIDG_MINORS, "hidg");
 	if (status) {
 		class_destroy(hidg_class);
 		hidg_class = NULL;
@@ -1153,13 +1137,25 @@ int ghid_setup(struct usb_gadget *g, int count)
 	}
 
 	major = MAJOR(dev);
-	minors = count;
+	minors = HIDG_MINORS;
+
+	status = usb_function_register(&hidusb_func);
+	if (status)
+		goto fail_unregister;
 
 	return 0;
+
+fail_unregister:
+	unregister_chrdev_region(dev, HIDG_MINORS);
+	class_destroy(hidg_class);
+	hidg_class = NULL;
+	return status;
 }
 
-void ghid_cleanup(void)
+static void ghid_cleanup(void)
 {
+	usb_function_unregister(&hidusb_func);
+
 	if (major) {
 		unregister_chrdev_region(MKDEV(major, 0), minors);
 		major = minors = 0;
@@ -1168,3 +1164,6 @@ void ghid_cleanup(void)
 	class_destroy(hidg_class);
 	hidg_class = NULL;
 }
+
+module_init(ghid_setup);
+module_exit(ghid_cleanup);
diff --git a/drivers/usb/gadget/function/u_hid.h b/drivers/usb/gadget/function/u_hid.h
index 1594bfa312eb..d52acc977c7e 100644
--- a/drivers/usb/gadget/function/u_hid.h
+++ b/drivers/usb/gadget/function/u_hid.h
@@ -33,7 +33,4 @@ struct f_hid_opts {
 	 int				refcnt;
 };
 
-int ghid_setup(struct usb_gadget *g, int count);
-void ghid_cleanup(void);
-
 #endif /* U_HID_H */
-- 
2.23.0

