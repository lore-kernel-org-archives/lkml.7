Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32368C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010C724A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186691;
	bh=HlqsrYSyKxnRC0lH59ph0ZTOGikuu4WjthtcOBJPZ1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xOnJzGrGMPu7MliXm0uPX5OBRp/uRnj1oGa2zdeE0/kzMKyqre1EZID01IsyMhQLE
	 H8gwBTdvXIq9874ouZB2PgJMn24ZkXBPTwbgMtTTshl/lxgslnp+Pe7M954bHLqCAn
	 N5Bf2GUVgPqgjOC+kRqdodYa+tEyJ5JY9hCDMq1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbfE3DYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbfE3DSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:18:16 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DECD624797;
        Thu, 30 May 2019 03:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186296;
        bh=HlqsrYSyKxnRC0lH59ph0ZTOGikuu4WjthtcOBJPZ1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t9NfTeQ/54mOte8RUTFP7uyOh83EemTXw5j6+vfV3zd+8pjYfKG9Pr9gI5WYFBGHF
         WRfNike8/J90Z8WElRG/VvF5RZD8AoNAwrN3tNTWCoSAqgNNw4IpH7XOUe9miRIn2k
         pYdYYWAAqj9AarlnktLjgq7AEiR++eMeSpHUa4RI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 257/276] media: gspca: do not resubmit URBs when streaming has stopped
Date:   Wed, 29 May 2019 20:06:55 -0700
Message-Id: <20190530030541.254790523@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e6f8bd59c28f758feea403a70d6c3ef28c50959f ]

When streaming is stopped all URBs are killed, but in fill_frame and in
bulk_irq this results in an attempt to resubmit the killed URB. That is
not what you want and causes spurious kernel messages.

So check if streaming has stopped before resubmitting.

Also check against gspca_dev->streaming rather than vb2_start_streaming_called()
since vb2_start_streaming_called() will return true when in stop_streaming,
but gspca_dev->streaming is set to false when stop_streaming is called.

Fixes: 6992effe5344 ("gspca: Kill all URBs before releasing any of them")

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/gspca/gspca.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
index fd4a1456b6ca2..b12356c533a65 100644
--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -314,6 +314,8 @@ static void fill_frame(struct gspca_dev *gspca_dev,
 	}
 
 resubmit:
+	if (!gspca_dev->streaming)
+		return;
 	/* resubmit the URB */
 	st = usb_submit_urb(urb, GFP_ATOMIC);
 	if (st < 0)
@@ -330,7 +332,7 @@ static void isoc_irq(struct urb *urb)
 	struct gspca_dev *gspca_dev = (struct gspca_dev *) urb->context;
 
 	gspca_dbg(gspca_dev, D_PACK, "isoc irq\n");
-	if (!vb2_start_streaming_called(&gspca_dev->queue))
+	if (!gspca_dev->streaming)
 		return;
 	fill_frame(gspca_dev, urb);
 }
@@ -344,7 +346,7 @@ static void bulk_irq(struct urb *urb)
 	int st;
 
 	gspca_dbg(gspca_dev, D_PACK, "bulk irq\n");
-	if (!vb2_start_streaming_called(&gspca_dev->queue))
+	if (!gspca_dev->streaming)
 		return;
 	switch (urb->status) {
 	case 0:
@@ -367,6 +369,8 @@ static void bulk_irq(struct urb *urb)
 				urb->actual_length);
 
 resubmit:
+	if (!gspca_dev->streaming)
+		return;
 	/* resubmit the URB */
 	if (gspca_dev->cam.bulk_nurbs != 0) {
 		st = usb_submit_urb(urb, GFP_ATOMIC);
-- 
2.20.1



