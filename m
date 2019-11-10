Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D236C17440
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA8522595
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354213;
	bh=cWDR+bK9eieHFdL6aHLtdxeVnto+yzXb3nykupc4aDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mf3MA4uZu1EDUuk3UYEkPRi2Kxq1y24oOHtYMzP9+3/BxTKXNn8jil3Y0fVHzoEvS
	 QApatJHolruZ6CvXccYq0+FYoSeiu1nrmiKKAGZKrwINbCBWIby/DCPf7BvbHZFNiG
	 wSSJy3T9djIsEC6qvqk432wD8j9pAECX6W8nTE8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfKJCuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbfKJCts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:49:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EC5D22581;
        Sun, 10 Nov 2019 02:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354187;
        bh=cWDR+bK9eieHFdL6aHLtdxeVnto+yzXb3nykupc4aDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vtfKZiAhg9Nbb8LmcI/DPcqnklFj7lyIDrbnhGyUJ0a3MV3+WVLRmWBBkcMYDHnzM
         +J3ElTYHYQuezcj0hWDKhoMMYmrVeHOO/Iw/4Zv2xEcNf870kBCTRS/Ipbb1onP2rx
         VG4ZM/Gul8OQz03y/OeTzJh4bS7rFNz2ynXlm6pM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 36/66] usb: gadget: uvc: Factor out video USB request queueing
Date:   Sat,  9 Nov 2019 21:48:15 -0500
Message-Id: <20191110024846.32598-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024846.32598-1-sashal@kernel.org>
References: <20191110024846.32598-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

