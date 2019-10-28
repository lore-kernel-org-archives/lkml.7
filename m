Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32165CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F0B214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="abKHpX5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbfJ1LnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:43:02 -0400
Received: from dougal.metanate.com ([90.155.101.14]:40476 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727385AbfJ1LnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lwODNx/KjIj+Y/Cod9TZnDM+jFNNhhm9mbvUKZSiSdY=; b=abKHpX5LsJ0gM4zh/a3HRf7+Dz
        4Y8eWJJaa/6e+/94YeREhIkRrZFkeKv/YejskVC7f5/x7SiHQGYtztOKOSGpz5cBv5bvQk7HSEzQ9
        45M2hqjGCXMQTeLuss0aOt+3fF+m3OPXbY+RATZKN1lF/tCA/2LKUNhWV+5LhfjQsVxqS350kNk4x
        XLiH0UFgUq/t/LGQDtUbKoqldOdohrQF8aZfVrp5cYYpo/mmSB4udFKeZcb4fxNkXRmDmYy/ytMbO
        2odavFBBkmzCerU1A5woP2lhBkkvGFL/dSPJMeak8jayBO+oVaDuD6cJya4DxhxoIBl+T0xL3S12o
        Pe62aF2A==;
Received: from dougal.metanate.com ([192.168.88.1] helo=localhost.localdomain)
        by email.metanate.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <john@metanate.com>)
        id 1iP3QH-00010o-AE; Mon, 28 Oct 2019 11:42:57 +0000
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH v2 2/6] USB: gadget: f_hid: switch to IDR for tracking minors
Date:   Mon, 28 Oct 2019 11:42:24 +0000
Message-Id: <20191028114228.3679219-3-john@metanate.com>
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

In the following commits, we are going to move the cdev allocation up to
the module initialisation, and will look up the associated f_hidg
structure from the open operation.

Start preparing for this by switching from IDA to IDR.

Signed-off-by: John Keeping <john@metanate.com>
---
v2:
- No changes

 drivers/usb/gadget/function/f_hid.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index e5e18d02b77a..1eb8b545e5b4 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -24,8 +24,8 @@
 
 static int major, minors;
 static struct class *hidg_class;
-static DEFINE_IDA(hidg_ida);
-static DEFINE_MUTEX(hidg_ida_lock); /* protects access to hidg_ida */
+static DEFINE_IDR(hidg_idr);
+static DEFINE_MUTEX(hidg_idr_lock); /* protects access to hidg_idr */
 
 /*-------------------------------------------------------------------------*/
 /*                            HID gadget struct                            */
@@ -851,9 +851,9 @@ static inline int hidg_get_minor(void)
 {
 	int ret;
 
-	ret = ida_simple_get(&hidg_ida, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&hidg_idr, NULL, 0, 0, GFP_KERNEL);
 	if (ret >= HIDG_MINORS) {
-		ida_simple_remove(&hidg_ida, ret);
+		idr_remove(&hidg_idr, ret);
 		ret = -ENODEV;
 	}
 
@@ -996,7 +996,7 @@ static const struct config_item_type hid_func_type = {
 
 static inline void hidg_put_minor(int minor)
 {
-	ida_simple_remove(&hidg_ida, minor);
+	idr_remove(&hidg_idr, minor);
 }
 
 static void hidg_free_inst(struct usb_function_instance *f)
@@ -1005,9 +1005,9 @@ static void hidg_free_inst(struct usb_function_instance *f)
 
 	opts = container_of(f, struct f_hid_opts, func_inst);
 
-	mutex_lock(&hidg_ida_lock);
+	mutex_lock(&hidg_idr_lock);
 	hidg_put_minor(opts->minor);
-	mutex_unlock(&hidg_ida_lock);
+	mutex_unlock(&hidg_idr_lock);
 
 	if (opts->report_desc_alloc)
 		kfree(opts->report_desc);
@@ -1027,7 +1027,7 @@ static struct usb_function_instance *hidg_alloc_inst(void)
 	opts->func_inst.free_func_inst = hidg_free_inst;
 	ret = &opts->func_inst;
 
-	mutex_lock(&hidg_ida_lock);
+	mutex_lock(&hidg_idr_lock);
 
 	opts->minor = hidg_get_minor();
 	if (opts->minor < 0) {
@@ -1038,7 +1038,7 @@ static struct usb_function_instance *hidg_alloc_inst(void)
 	config_group_init_type_name(&opts->func_inst.group, "", &hid_func_type);
 
 unlock:
-	mutex_unlock(&hidg_ida_lock);
+	mutex_unlock(&hidg_idr_lock);
 	return ret;
 }
 
-- 
2.23.0

