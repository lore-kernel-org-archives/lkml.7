Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA54C32753
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2B320B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739742;
	bh=AheveygCk3NLRuq5nuFyvZqnsaEBbuW4UtWleZNUYkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eiCsLpbSeFO0eWHb3w06/zwk7VvwzCsBMws/dPdv8ypT6YVTZLUZzetemA3G2MXNP
	 4/Dl0l4y9wIc/8QAYVJGze4xkhWy6t7fTdYQljN4c5EG90p86x6GYq9taiMU+m4V+g
	 hkcmaw7+ZTQHqAmEhWYCHrWvXtPMBtlq28JSrRuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406595AbfHBJzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406583AbfHBJzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:55:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 725B32064A;
        Fri,  2 Aug 2019 09:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739735;
        bh=AheveygCk3NLRuq5nuFyvZqnsaEBbuW4UtWleZNUYkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oj+eoCfeVkd4Tbxuo2Vror+K3llvsDaMlNAOZNtKryap/qsO/6qBppF2rdUfiAO7a
         BrkrnpRoKIHdfpr23L7cVextHIjgGxX1+ijaTl9nJemFYtINjVAZT6W6SxY7FcHLBL
         b1Az6d15USxMlZe+/GXwEI9+vqjEDF+ZCGtyUJbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        syzbot+0c90fc937c84f97d0aa6@syzkaller.appspotmail.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 13/32] media: cpia2_usb: first wake up, then free in disconnect
Date:   Fri,  2 Aug 2019 11:39:47 +0200
Message-Id: <20190802092105.851008120@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092101.913646560@linuxfoundation.org>
References: <20190802092101.913646560@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit eff73de2b1600ad8230692f00bc0ab49b166512a upstream.

Kasan reported a use after free in cpia2_usb_disconnect()
It first freed everything and then woke up those waiting.
The reverse order is correct.

Fixes: 6c493f8b28c67 ("[media] cpia2: major overhaul to get it in a working state again")

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-by: syzbot+0c90fc937c84f97d0aa6@syzkaller.appspotmail.com
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/cpia2/cpia2_usb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/usb/cpia2/cpia2_usb.c
+++ b/drivers/media/usb/cpia2/cpia2_usb.c
@@ -902,7 +902,6 @@ static void cpia2_usb_disconnect(struct
 	cpia2_unregister_camera(cam);
 	v4l2_device_disconnect(&cam->v4l2_dev);
 	mutex_unlock(&cam->v4l2_lock);
-	v4l2_device_put(&cam->v4l2_dev);
 
 	if(cam->buffers) {
 		DBG("Wakeup waiting processes\n");
@@ -911,6 +910,8 @@ static void cpia2_usb_disconnect(struct
 		wake_up_interruptible(&cam->wq_stream);
 	}
 
+	v4l2_device_put(&cam->v4l2_dev);
+
 	LOG("CPiA2 camera disconnected.\n");
 }
 


