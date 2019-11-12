Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D82C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9627A20650
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfKLJdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:33:39 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47403 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfKLJdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:33:38 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1iUSYJ-0008Gs-D8; Tue, 12 Nov 2019 10:33:35 +0100
Received: from mol by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1iUSYJ-0003NS-2z; Tue, 12 Nov 2019 10:33:35 +0100
From:   Michael Olbrich <m.olbrich@pengutronix.de>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Michael Olbrich <m.olbrich@pengutronix.de>
Subject: [PATCH] usb: gadget: composite: split spinlock to avoid recursion
Date:   Tue, 12 Nov 2019 10:33:18 +0100
Message-Id: <20191112093318.12936-1-m.olbrich@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'delayed_status' and 'deactivations' are used completely independent but
they share the same spinlock. This can result in spinlock recursion:

BUG: spinlock recursion on CPU#1, uvc-gadget/322
 lock: 0xffffffc0570364e0, .magic: dead4ead, .owner: uvc-gadget/322, .owner_cpu: 1
CPU: 1 PID: 322 Comm: uvc-gadget Tainted: G         C O      5.3.0-20190916-1+ #55
Hardware name: XXXXX (DT)
Call trace:
 dump_backtrace+0x0/0x178
 show_stack+0x24/0x30
 dump_stack+0xc0/0x104
 spin_dump+0x90/0xa0
 do_raw_spin_lock+0xd8/0x108
 _raw_spin_lock_irqsave+0x40/0x50
 composite_disconnect+0x2c/0x80
 usb_gadget_disconnect+0x84/0x150
 usb_gadget_deactivate+0x64/0x120
 usb_function_deactivate+0x70/0x80
 uvc_function_disconnect+0x20/0x58
 uvc_v4l2_release+0x34/0x90
 v4l2_release+0xbc/0xf0
 __fput+0xb0/0x218
 ____fput+0x20/0x30
 task_work_run+0xa0/0xd0
 do_notify_resume+0x2f4/0x340
 work_pending+0x8/0x14

Fix this by using separate spinlocks.

Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
---
 drivers/usb/gadget/composite.c | 9 +++++----
 drivers/usb/gadget/configfs.c  | 1 +
 include/linux/usb/composite.h  | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 76883ff4f5bb..35c792e5b408 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -346,14 +346,14 @@ int usb_function_deactivate(struct usb_function *function)
 	unsigned long			flags;
 	int				status = 0;
 
-	spin_lock_irqsave(&cdev->lock, flags);
+	spin_lock_irqsave(&cdev->deactivations_lock, flags);
 
 	if (cdev->deactivations == 0)
 		status = usb_gadget_deactivate(cdev->gadget);
 	if (status == 0)
 		cdev->deactivations++;
 
-	spin_unlock_irqrestore(&cdev->lock, flags);
+	spin_unlock_irqrestore(&cdev->deactivations_lock, flags);
 	return status;
 }
 EXPORT_SYMBOL_GPL(usb_function_deactivate);
@@ -374,7 +374,7 @@ int usb_function_activate(struct usb_function *function)
 	unsigned long			flags;
 	int				status = 0;
 
-	spin_lock_irqsave(&cdev->lock, flags);
+	spin_lock_irqsave(&cdev->deactivations_lock, flags);
 
 	if (WARN_ON(cdev->deactivations == 0))
 		status = -EINVAL;
@@ -384,7 +384,7 @@ int usb_function_activate(struct usb_function *function)
 			status = usb_gadget_activate(cdev->gadget);
 	}
 
-	spin_unlock_irqrestore(&cdev->lock, flags);
+	spin_unlock_irqrestore(&cdev->deactivations_lock, flags);
 	return status;
 }
 EXPORT_SYMBOL_GPL(usb_function_activate);
@@ -2196,6 +2196,7 @@ static int composite_bind(struct usb_gadget *gadget,
 		return status;
 
 	spin_lock_init(&cdev->lock);
+	spin_lock_init(&cdev->deactivations_lock);
 	cdev->gadget = gadget;
 	set_gadget_data(gadget, cdev);
 	INIT_LIST_HEAD(&cdev->configs);
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 025129942894..45f717fcdb89 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -521,6 +521,7 @@ static const struct config_item_type gadget_root_type = {
 static void composite_init_dev(struct usb_composite_dev *cdev)
 {
 	spin_lock_init(&cdev->lock);
+	spin_lock_init(&cdev->deactivations_lock);
 	INIT_LIST_HEAD(&cdev->configs);
 	INIT_LIST_HEAD(&cdev->gstrings);
 }
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 8675e145ea8b..86eb6f2c03ac 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -505,8 +505,10 @@ struct usb_composite_dev {
 	 */
 	int				delayed_status;
 
-	/* protects deactivations and delayed_status counts*/
+	/* protects delayed_status counts*/
 	spinlock_t			lock;
+	/* protects deactivations counts*/
+	spinlock_t			deactivations_lock;
 
 	/* public: */
 	unsigned int			setup_pending:1;
-- 
2.20.1

