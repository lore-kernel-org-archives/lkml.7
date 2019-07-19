Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21464C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04E021851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508988;
	bh=X4vd8OK4yXQ0AbEdR++MYAR4NsXHtv+u2lPVXgjJSTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bs/dcSolBC1Q2cQkokioyla1ZAJ3QmvudXEorjSNXpSJpzLhvz71IEn8Inb7laT1t
	 DysMh9ShbVgcKiWbLHZIotJmdASe50sCHA5yOLbkX4dhIcvVJqW5AnA5w/5VkSHuyM
	 DzxVgjQVk3b9PhJ4M9DYE6IBoZX+FyGrpv63ySBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfGSEDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730195AbfGSEDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:03:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 234E521850;
        Fri, 19 Jul 2019 04:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508978;
        bh=X4vd8OK4yXQ0AbEdR++MYAR4NsXHtv+u2lPVXgjJSTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gfn9YEiGHhWx+//lC6mrIWYeSc0w6cW7nPkYfAs6N/lh9dLIGlmh6WycYgzRdPJXf
         0bBSZfobDME0TPKcYvKeUDZJcn0AfTvYBzxUslM3QSX6aMT8/POQTbIujbWI/blCxJ
         6KUIvXEKULz6F9M3iKeUZwzGRaf0NHMEa3o+nJq4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.1 006/141] staging: vt6656: use meaningful error code during buffer allocation
Date:   Fri, 19 Jul 2019 00:00:31 -0400
Message-Id: <20190719040246.15945-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Deslandes <quentin.deslandes@itdev.co.uk>

[ Upstream commit d8c2869300ab5f7a19bf6f5a04fe473c5c9887e3 ]

Check on called function's returned value for error and return 0 on
success or a negative errno value on error instead of a boolean value.

Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/vt6656/main_usb.c | 42 ++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index ccafcc2c87ac..70433f756d8e 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -402,16 +402,19 @@ static void vnt_free_int_bufs(struct vnt_private *priv)
 	kfree(priv->int_buf.data_buf);
 }
 
-static bool vnt_alloc_bufs(struct vnt_private *priv)
+static int vnt_alloc_bufs(struct vnt_private *priv)
 {
+	int ret = 0;
 	struct vnt_usb_send_context *tx_context;
 	struct vnt_rcb *rcb;
 	int ii;
 
 	for (ii = 0; ii < priv->num_tx_context; ii++) {
 		tx_context = kmalloc(sizeof(*tx_context), GFP_KERNEL);
-		if (!tx_context)
+		if (!tx_context) {
+			ret = -ENOMEM;
 			goto free_tx;
+		}
 
 		priv->tx_context[ii] = tx_context;
 		tx_context->priv = priv;
@@ -419,16 +422,20 @@ static bool vnt_alloc_bufs(struct vnt_private *priv)
 
 		/* allocate URBs */
 		tx_context->urb = usb_alloc_urb(0, GFP_KERNEL);
-		if (!tx_context->urb)
+		if (!tx_context->urb) {
+			ret = -ENOMEM;
 			goto free_tx;
+		}
 
 		tx_context->in_use = false;
 	}
 
 	for (ii = 0; ii < priv->num_rcb; ii++) {
 		priv->rcb[ii] = kzalloc(sizeof(*priv->rcb[ii]), GFP_KERNEL);
-		if (!priv->rcb[ii])
+		if (!priv->rcb[ii]) {
+			ret = -ENOMEM;
 			goto free_rx_tx;
+		}
 
 		rcb = priv->rcb[ii];
 
@@ -436,39 +443,46 @@ static bool vnt_alloc_bufs(struct vnt_private *priv)
 
 		/* allocate URBs */
 		rcb->urb = usb_alloc_urb(0, GFP_KERNEL);
-		if (!rcb->urb)
+		if (!rcb->urb) {
+			ret = -ENOMEM;
 			goto free_rx_tx;
+		}
 
 		rcb->skb = dev_alloc_skb(priv->rx_buf_sz);
-		if (!rcb->skb)
+		if (!rcb->skb) {
+			ret = -ENOMEM;
 			goto free_rx_tx;
+		}
 
 		rcb->in_use = false;
 
 		/* submit rx urb */
-		if (vnt_submit_rx_urb(priv, rcb))
+		ret = vnt_submit_rx_urb(priv, rcb);
+		if (ret)
 			goto free_rx_tx;
 	}
 
 	priv->interrupt_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!priv->interrupt_urb)
+	if (!priv->interrupt_urb) {
+		ret = -ENOMEM;
 		goto free_rx_tx;
+	}
 
 	priv->int_buf.data_buf = kmalloc(MAX_INTERRUPT_SIZE, GFP_KERNEL);
 	if (!priv->int_buf.data_buf) {
-		usb_free_urb(priv->interrupt_urb);
-		goto free_rx_tx;
+		ret = -ENOMEM;
+		goto free_rx_tx_urb;
 	}
 
-	return true;
+	return 0;
 
+free_rx_tx_urb:
+	usb_free_urb(priv->interrupt_urb);
 free_rx_tx:
 	vnt_free_rx_bufs(priv);
-
 free_tx:
 	vnt_free_tx_bufs(priv);
-
-	return false;
+	return ret;
 }
 
 static void vnt_tx_80211(struct ieee80211_hw *hw,
-- 
2.20.1

