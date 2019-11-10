Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B859C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10E8208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355513;
	bh=iBBMe15K4+HA3kN/vHerQ3O7nBFoxK4BcXZ0KO4hoCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KjHpSoaOiUoe0rum4VbYy3Bf9WSV2t1CE9+GwRD4NE6dTa4ufybbW0vJgtiYihlvs
	 igrTY5A3kY8zfKiYVVYk0UJE8HpYj30WpgAjnppdwOqOF08kEZmV9j1x2oRX1tCXK8
	 wmZ+8j21TT6/m2DueDIMMN3GHfZs2Pt/pKamWZR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfKJDLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:11:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbfKJCne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:43:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC11E21019;
        Sun, 10 Nov 2019 02:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353813;
        bh=iBBMe15K4+HA3kN/vHerQ3O7nBFoxK4BcXZ0KO4hoCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sa9G+lFCbLf3OPg30ZWdDaOwRt9R216SJXgZf7OFUDCX5zCeHxRvNBQqlEsiVVytg
         oxbtv/5wJkB7tIBZzNu7yixfxwzcz/U8g9E4cE2Yd2c9yIFBzmcu5emh/VhdVRViGP
         7pT/3pGFQbQzdmcyP4ttAzaEwyOmAaPmP2e41jd8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 109/191] usb: gadget: uvc: Only halt video streaming endpoint in bulk mode
Date:   Sat,  9 Nov 2019 21:38:51 -0500
Message-Id: <20191110024013.29782-109-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 8dbf9c7abefd5c1434a956d5c6b25e11183061a3 ]

When USB requests for video data fail to be submitted, the driver
signals a problem to the host by halting the video streaming endpoint.
This is only valid in bulk mode, as isochronous transfers have no
handshake phase and can't thus report a stall. The usb_ep_set_halt()
call returns an error when using isochronous endpoints, which we happily
ignore, but some UDCs complain in the kernel log. Fix this by only
trying to halt the endpoint in bulk mode.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>
Tested-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/uvc_video.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index a95c8e2364edc..2c9821ec836e7 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -132,7 +132,9 @@ static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
 	ret = usb_ep_queue(video->ep, req, GFP_ATOMIC);
 	if (ret < 0) {
 		printk(KERN_INFO "Failed to queue request (%d).\n", ret);
-		usb_ep_set_halt(video->ep);
+		/* Isochronous endpoints can't be halted. */
+		if (usb_endpoint_xfer_bulk(video->ep->desc))
+			usb_ep_set_halt(video->ep);
 	}
 
 	return ret;
-- 
2.20.1

