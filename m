Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D889FCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93FA20873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="JFJJkAY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbfJ1LnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:43:01 -0400
Received: from dougal.metanate.com ([90.155.101.14]:46592 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388603AbfJ1LnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3yHp3hDaqlC9sVsaUEOh4hHDVX97afo481OX9Wv/28o=; b=JFJJkAY0J7hR+kY0KnpsFW0Rk9
        Sq3llvjAUA+tuAY0LLX35UJmclE0S1q9ht/dntPdOxOQqip+NTg3/n/UTvXoK2JENJjLhBCg2JXTd
        W0eaBplcq/gcEJyu2dGF74zmCMdVPOSHlNUtWVywKgMUfE744jr6k06cjoX9GgAk7z1pEH/7k0AK+
        QRSXgX5f8+RXsa0zBXcZnz235T17UcIu5GTnzLuRCSa3heJGxokM1SLQWUver77S+mpClWnyZzfE/
        6ACk3pV9GEnO/fZAN69RJxCJyjYUCTSee3AjvCq8dsR/Es9AzcxBhOCDmvc8vw33ghF9YewbdwF8y
        IvJVjrIQ==;
Received: from dougal.metanate.com ([192.168.88.1] helo=localhost.localdomain)
        by email.metanate.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <john@metanate.com>)
        id 1iP3QH-00010o-CL; Mon, 28 Oct 2019 11:42:57 +0000
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH v2 3/6] USB: gadget: f_hid: find f_hidg by IDR lookup on open
Date:   Mon, 28 Oct 2019 11:42:25 +0000
Message-Id: <20191028114228.3679219-4-john@metanate.com>
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

As a step towards decoupling the cdev lifetime from f_hidg, lookup the
f_hidg structure by minor number from IDR when opening the device.

Signed-off-by: John Keeping <john@metanate.com>
---
v2:
- No changes

 drivers/usb/gadget/function/f_hid.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 1eb8b545e5b4..6cf3b5b14ded 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -441,8 +441,14 @@ static int f_hidg_release(struct inode *inode, struct file *fd)
 
 static int f_hidg_open(struct inode *inode, struct file *fd)
 {
-	struct f_hidg *hidg =
-		container_of(inode->i_cdev, struct f_hidg, cdev);
+	struct f_hidg *hidg;
+
+	mutex_lock(&hidg_idr_lock);
+	hidg = idr_find(&hidg_idr, iminor(inode));
+	mutex_unlock(&hidg_idr_lock);
+
+	if (!hidg)
+		return -ENODEV;
 
 	fd->private_data = hidg;
 
@@ -827,6 +833,10 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	if (status)
 		goto fail_free_descs;
 
+	mutex_lock(&hidg_idr_lock);
+	idr_replace(&hidg_idr, hidg, hidg->minor);
+	mutex_unlock(&hidg_idr_lock);
+
 	device = device_create(hidg_class, NULL, dev, NULL,
 			       "%s%d", "hidg", hidg->minor);
 	if (IS_ERR(device)) {
-- 
2.23.0

