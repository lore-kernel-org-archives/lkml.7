Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107A3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CCF20679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="ZgRkNkVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410099AbfJXRFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:05:13 -0400
Received: from dougal.metanate.com ([90.155.101.14]:61211 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405819AbfJXRFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sCKa65N8pDZk/BvuYm93WNP3he5hb1vXX9CJBcDMFMo=; b=ZgRkNkVxdM6qxsaIjJ7G34YwPa
        X5OQB5CdqUqQ17bmonlNjvYGrT1POGv9XnxFRtDdeuU+El3xSfRoQtD6wwh3vnqST12cL+VnqkSac
        yQhfQY+uJhJoURnimGgjl4Tu9Yq89KDM8kpKHyvrMLah+3SEWasRTlAxulNqE2LoyVwtCXeFQkpMX
        b9zePA3As8lliLb/bIWzlbJr7/Q/dXVrSY8a8ZpRB9+WPwceO5DY6oEqLHhdzdpSxAVwSnPjg5+Io
        n+3oCSIcs49FIwnJEBLmrigzDkgtWpt3FjezMXoWiK+DLiHhA8OnrdIrCIuW/4X91IjO4vPMmkn7y
        D//dEcxw==;
Received: from 188-39-28-98.static.enta.net ([188.39.28.98] helo=donbot.corp.numark.com)
        by email.metanate.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <john@metanate.com>)
        id 1iNgFA-0004oc-O1; Thu, 24 Oct 2019 17:45:48 +0100
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH 6/6] USB: gadget: f_hid: return ENODEV from read/write after deletion
Date:   Thu, 24 Oct 2019 17:45:38 +0100
Message-Id: <20191024164538.3161474-7-john@metanate.com>
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

If a file descriptor to /dev/hidgN is kept open after the gadget
function has been deleted, reading or writing will block indefinitely
since no requests will ever be processed.

Add a flag to note that the function has been deleted and check this in
read & write if there is no other action to take.  When setting this
flag, also wake up any readers/writers so that they get ENODEV
immediately.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/f_hid.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 2c3e835962a5..fdb8356e334b 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -59,6 +59,7 @@ struct f_hidg {
 	struct usb_request		*req;
 
 	struct kref			kref;
+	bool				deleted;
 	int				minor;
 	struct usb_function		func;
 
@@ -271,10 +272,14 @@ static ssize_t f_hidg_read(struct file *file, char __user *buffer,
 	/* wait for at least one buffer to complete */
 	while (!READ_COND) {
 		spin_unlock_irqrestore(&hidg->read_spinlock, flags);
+		if (READ_ONCE(hidg->deleted))
+			return -ENODEV;
+
 		if (file->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
-		if (wait_event_interruptible(hidg->read_queue, READ_COND))
+		if (wait_event_interruptible(hidg->read_queue,
+				READ_COND || READ_ONCE(hidg->deleted)))
 			return -ERESTARTSYS;
 
 		spin_lock_irqsave(&hidg->read_spinlock, flags);
@@ -358,11 +363,14 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
 	/* write queue */
 	while (!WRITE_COND) {
 		spin_unlock_irqrestore(&hidg->write_spinlock, flags);
+		if (READ_ONCE(hidg->deleted))
+			return -ENODEV;
+
 		if (file->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
-		if (wait_event_interruptible_exclusive(
-				hidg->write_queue, WRITE_COND))
+		if (wait_event_interruptible_exclusive(hidg->write_queue,
+				WRITE_COND || READ_ONCE(hidg->deleted)))
 			return -ERESTARTSYS;
 
 		spin_lock_irqsave(&hidg->write_spinlock, flags);
@@ -1070,6 +1078,10 @@ static void hidg_free(struct usb_function *f)
 
 	hidg = func_to_hidg(f);
 	opts = container_of(f->fi, struct f_hid_opts, func_inst);
+	WRITE_ONCE(hidg->deleted, true);
+	wake_up(&hidg->read_queue);
+	wake_up(&hidg->write_queue);
+
 	kref_put(&hidg->kref, hidg_release);
 	mutex_lock(&opts->lock);
 	--opts->refcnt;
-- 
2.23.0

