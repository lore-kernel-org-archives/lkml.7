Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ECCC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB03620715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419459;
	bh=cWDR+bK9eieHFdL6aHLtdxeVnto+yzXb3nykupc4aDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pI+fc8WuluKHPJMnMIztrjZJGIRfyX8NUHEwHt/Nm1liNEiRuyZRC5aNkkqpNWvj9
	 qrvXfIWoK3Mu9I9/DsPOS87Gt+8EQzXRFR3LEbQMsblRwGOeQsAIJLmL2//0hTT2X9
	 jJm9h3dnRtLlA+VNgGCq9bn9NeD53SYjFVhT5eks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfKVKoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:44:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbfKVKoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:44:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 600E220715;
        Fri, 22 Nov 2019 10:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419453;
        bh=cWDR+bK9eieHFdL6aHLtdxeVnto+yzXb3nykupc4aDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkDpaUykg1hqdzcIOPWfL3bcKPahOzHcx1Zy9F9yOgs1yPBxSRhy0pI8CAZ2LATZi
         D22wsxX1xGYeqpoW6tRU8DbWJ1WxsyVHxOvtQ1iIsZnCWtqJumXiyzVktr3WYuie5L
         +y+sgisqBT7fdrhqAGRgBaOjAz2ywBdm6QW9h9fU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 115/222] usb: gadget: uvc: Factor out video USB request queueing
Date:   Fri, 22 Nov 2019 11:27:35 +0100
Message-Id: <20191122100911.493792795@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 9d1ff5dcb3cd3390b1e56f1c24ae42c72257c4a3 ]

USB requests for video data are queued from two different locations in
the driver, with the same code block occurring twice. Factor it out to a
function.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>
Tested-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/uvc_video.c | 30 ++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 0f01c04d7cbd8..540917f54506a 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -129,6 +129,19 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
  * Request handling
  */
 
+static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
+{
+	int ret;
+
+	ret = usb_ep_queue(video->ep, req, GFP_ATOMIC);
+	if (ret < 0) {
+		printk(KERN_INFO "Failed to queue request (%d).\n", ret);
+		usb_ep_set_halt(video->ep);
+	}
+
+	return ret;
+}
+
 /*
  * I somehow feel that synchronisation won't be easy to achieve here. We have
  * three events that control USB requests submission:
@@ -193,14 +206,13 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 
 	video->encode(req, video, buf);
 
-	if ((ret = usb_ep_queue(ep, req, GFP_ATOMIC)) < 0) {
-		printk(KERN_INFO "Failed to queue request (%d).\n", ret);
-		usb_ep_set_halt(ep);
-		spin_unlock_irqrestore(&video->queue.irqlock, flags);
+	ret = uvcg_video_ep_queue(video, req);
+	spin_unlock_irqrestore(&video->queue.irqlock, flags);
+
+	if (ret < 0) {
 		uvcg_queue_cancel(queue, 0);
 		goto requeue;
 	}
-	spin_unlock_irqrestore(&video->queue.irqlock, flags);
 
 	return;
 
@@ -320,15 +332,13 @@ int uvcg_video_pump(struct uvc_video *video)
 		video->encode(req, video, buf);
 
 		/* Queue the USB request */
-		ret = usb_ep_queue(video->ep, req, GFP_ATOMIC);
+		ret = uvcg_video_ep_queue(video, req);
+		spin_unlock_irqrestore(&queue->irqlock, flags);
+
 		if (ret < 0) {
-			printk(KERN_INFO "Failed to queue request (%d)\n", ret);
-			usb_ep_set_halt(video->ep);
-			spin_unlock_irqrestore(&queue->irqlock, flags);
 			uvcg_queue_cancel(queue, 0);
 			break;
 		}
-		spin_unlock_irqrestore(&queue->irqlock, flags);
 	}
 
 	spin_lock_irqsave(&video->req_lock, flags);
-- 
2.20.1



