Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A317C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27228205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100545;
	bh=89GpvrFgzcN4Wj9MAnyH0h18e4NiL3Ko+h4Lw6xvsNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xhS1OGV8w8EJXTh6ejk1e2RtIXDLzgN4/t4xJjqu0NFwzqy223W2LffXR+aANI8xe
	 B+Vl9CEItu6sHzTd2ZAXGbGd2lKjsgANTawZB22sFKHgLEev0Eri5UKC9NtPtgWlBQ
	 m8G2SwQ1bWc9TRqf4DmipFkNbMOyEHQW300U8UK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbfFIQyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732163AbfFIQyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:54:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17683206BB;
        Sun,  9 Jun 2019 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099253;
        bh=89GpvrFgzcN4Wj9MAnyH0h18e4NiL3Ko+h4Lw6xvsNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xxbFPUFMBCKh5FZZnXV5xW1aXhOp+lIcGSU/LRhbLqoyUxdkvUvpHrHtTSJo2vm8+
         MKpXdB15fimpEMnLncXy+iOtnJPq4DVgi9nnW+8ViJa5ceFyusfkGATrj8MAR2paOk
         fpGm48XMqDkeLv3lIU04dkPuVKqnSV6LeQxPV0Ew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.9 30/83] USB: rio500: fix memory leak in close after disconnect
Date:   Sun,  9 Jun 2019 18:42:00 +0200
Message-Id: <20190609164130.215498292@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit e0feb73428b69322dd5caae90b0207de369b5575 upstream.

If a disconnected device is closed, rio_close() must free
the buffers.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/rio500.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/usb/misc/rio500.c
+++ b/drivers/usb/misc/rio500.c
@@ -103,9 +103,22 @@ static int close_rio(struct inode *inode
 {
 	struct rio_usb_data *rio = &rio_instance;
 
-	rio->isopen = 0;
+	/* against disconnect() */
+	mutex_lock(&rio500_mutex);
+	mutex_lock(&(rio->lock));
 
-	dev_info(&rio->rio_dev->dev, "Rio closed.\n");
+	rio->isopen = 0;
+	if (!rio->present) {
+		/* cleanup has been delayed */
+		kfree(rio->ibuf);
+		kfree(rio->obuf);
+		rio->ibuf = NULL;
+		rio->obuf = NULL;
+	} else {
+		dev_info(&rio->rio_dev->dev, "Rio closed.\n");
+	}
+	mutex_unlock(&(rio->lock));
+	mutex_unlock(&rio500_mutex);
 	return 0;
 }
 


