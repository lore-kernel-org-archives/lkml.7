Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87518CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B85C2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="mcsf8BDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410137AbfJXRFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:05:19 -0400
Received: from dougal.metanate.com ([90.155.101.14]:26826 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2410113AbfJXRFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lt/emEqve1MDsXN2KXFtvpLb9DsysvYyUGYvLNkp2YY=; b=mcsf8BDUrZsbXUMnw8/VOODNpt
        cKd7svVlnEuCbh1IkBi2vkuJhAKYTezDTzplQft0sq4awiEHsbCQzQG/lw/yPszE8Y3QiLV5146dN
        FUPk1F50HBsC5S28wRz8Z8H/RfuCAkjrAGYJZ+eDNwCIDXg64gDCgq4z8NIAx3acqeKvlskIfKBhN
        qkoE3ubX7p9JdHwLGIB+u8m6c1qgfXYo4chzpwF+qTnxE8OTkffIEaUqIisQChua2pX+AIpmIPO1Y
        0AmRd/gNFGGoecM0X5yx2wPH/HES0VGso1juuTVnBX0KbllrzzwNKNLJNc/u6gtptNY+hAfJirl8g
        x15XgrFQ==;
Received: from 188-39-28-98.static.enta.net ([188.39.28.98] helo=donbot.corp.numark.com)
        by email.metanate.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <john@metanate.com>)
        id 1iNgFA-0004oc-GA; Thu, 24 Oct 2019 17:45:48 +0100
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH 5/6] USB: gadget: f_hid: refcount f_hidg structure
Date:   Thu, 24 Oct 2019 17:45:37 +0100
Message-Id: <20191024164538.3161474-6-john@metanate.com>
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

f_hidg is referenced by file descriptors opened on /dev/hidgN as well as
being the USB gadget function.  Since these file descriptors can be kept
alive after the gadget function has been deleted, we need to decouple
the lifetime of the f_hidg structure from the function.

Make f_hidg reference counted so that it remains alive after the gadget
function has been deleted if necessary.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/f_hid.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index ee94348b85ef..2c3e835962a5 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -58,6 +58,7 @@ struct f_hidg {
 	wait_queue_head_t		write_queue;
 	struct usb_request		*req;
 
+	struct kref			kref;
 	int				minor;
 	struct usb_function		func;
 
@@ -70,6 +71,14 @@ static inline struct f_hidg *func_to_hidg(struct usb_function *f)
 	return container_of(f, struct f_hidg, func);
 }
 
+static void hidg_release(struct kref *kref)
+{
+	struct f_hidg *hidg = container_of(kref, struct f_hidg, kref);
+
+	kfree(hidg->report_desc);
+	kfree(hidg);
+}
+
 /*-------------------------------------------------------------------------*/
 /*                           Static descriptors                            */
 
@@ -435,6 +444,9 @@ static __poll_t f_hidg_poll(struct file *file, poll_table *wait)
 
 static int f_hidg_release(struct inode *inode, struct file *fd)
 {
+	struct f_hidg *hidg = fd->private_data;
+
+	kref_put(&hidg->kref, hidg_release);
 	fd->private_data = NULL;
 	return 0;
 }
@@ -445,6 +457,8 @@ static int f_hidg_open(struct inode *inode, struct file *fd)
 
 	mutex_lock(&hidg_idr_lock);
 	hidg = idr_find(&hidg_idr, iminor(inode));
+	if (hidg)
+		kref_get(&hidg->kref);
 	mutex_unlock(&hidg_idr_lock);
 
 	if (!hidg)
@@ -1056,8 +1070,7 @@ static void hidg_free(struct usb_function *f)
 
 	hidg = func_to_hidg(f);
 	opts = container_of(f->fi, struct f_hid_opts, func_inst);
-	kfree(hidg->report_desc);
-	kfree(hidg);
+	kref_put(&hidg->kref, hidg_release);
 	mutex_lock(&opts->lock);
 	--opts->refcnt;
 	mutex_unlock(&opts->lock);
@@ -1109,6 +1122,8 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 
 	mutex_unlock(&opts->lock);
 
+	kref_init(&hidg->kref);
+
 	hidg->func.name    = "hid";
 	hidg->func.bind    = hidg_bind;
 	hidg->func.unbind  = hidg_unbind;
-- 
2.23.0

