Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B251CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D0521925
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="C/V0R/MU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410124AbfJXRFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:05:17 -0400
Received: from dougal.metanate.com ([90.155.101.14]:53162 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2410088AbfJXRFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WeI3FCFsNE1HtrK6jYQxaZQOHZIpKCcPIjwM0XSj0NI=; b=C/V0R/MUeQdPA/QR4pMfSn+0pG
        EPGql0q8F7wWhh4lkGorFnBQLKOfp4Pkx3helkiEidXsi5walZ1ciGBTRmvqfVvCVNZLNHPIbTXcF
        hvglhk4OHG3AUFinX2f7uRI4LFbGTwSv9Ti9HDMLCawsABwjAAHkhJgu9mYPvA4VwWxhvEefUxX9b
        1+zD2C8tRMSjRdpdXYkaO9SZQOn+wE50lKWByVKPLqWmSt17G7pxtfYw3BK5pDqEkP5RZoj2cBONS
        NUA2lHVAiN0mx4IFs2wmNYtYHN7/X86+2CA4+42i8kN5pqziaEyxucGnPRGGtmFbNq9OjlbjEB/gS
        1nreoq8Q==;
Received: from 188-39-28-98.static.enta.net ([188.39.28.98] helo=donbot.corp.numark.com)
        by email.metanate.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <john@metanate.com>)
        id 1iNgF9-0004oc-DV; Thu, 24 Oct 2019 17:45:47 +0100
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH 1/6] USB: gadget: f_hid: move chardev setup to module init
Date:   Thu, 24 Oct 2019 17:45:33 +0100
Message-Id: <20191024164538.3161474-2-john@metanate.com>
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

Lifetime of the objects in the HID gadget is currently tied to the USB
function, which makes it very easy to trigger a use-after-free by
holding a file descriptor on the HID device after deleting the gadget.

As a first step towards fixing this, move the character device
allocation to module initialisation so that we don't have to worry about
when the allocation can be released after closing all of the open
handles on the device.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/f_hid.c | 27 +++++++--------------------
 drivers/usb/gadget/function/u_hid.h |  3 ---
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index f3816a5c861e..e9e45f9eae80 100644
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
@@ -1133,7 +1117,7 @@ DECLARE_USB_FUNCTION_INIT(hid, hidg_alloc_inst, hidg_alloc);
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
@@ -1153,12 +1137,12 @@ int ghid_setup(struct usb_gadget *g, int count)
 	}
 
 	major = MAJOR(dev);
-	minors = count;
+	minors = HIDG_MINORS;
 
 	return 0;
 }
 
-void ghid_cleanup(void)
+static void ghid_cleanup(void)
 {
 	if (major) {
 		unregister_chrdev_region(MKDEV(major, 0), minors);
@@ -1168,3 +1152,6 @@ void ghid_cleanup(void)
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

