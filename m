Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134E9C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E581821835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbfJHUda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:33:30 -0400
Received: from sauhun.de ([88.99.104.3]:52996 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbfJHUda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:33:30 -0400
Received: from localhost (p54B3324A.dip0.t-ipconnect.de [84.179.50.74])
        by pokefinder.org (Postfix) with ESMTPSA id 365942C07DC;
        Tue,  8 Oct 2019 22:33:28 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] gpu: drm: bridge: sii9234: convert to devm_i2c_new_dummy_device
Date:   Tue,  8 Oct 2019 22:33:22 +0200
Message-Id: <20191008203322.3238-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from the deprecated i2c_new_dummy() to devm_i2c_new_dummy_device().
We now get an ERRPTR which we use in error handling and we can skip
removal of the created devices.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Rebased to v5.4-rc2 since last time. One of the last two users of the
old API, so please apply soon, so I can remove the old interface. Only
build tested.

 drivers/gpu/drm/bridge/sii9234.c | 36 +++++++++++---------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index 25d4ad8c7ad6..8a6c85693a88 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -841,39 +841,28 @@ static int sii9234_init_resources(struct sii9234 *ctx,
 
 	ctx->client[I2C_MHL] = client;
 
-	ctx->client[I2C_TPI] = i2c_new_dummy(adapter, I2C_TPI_ADDR);
-	if (!ctx->client[I2C_TPI]) {
+	ctx->client[I2C_TPI] = devm_i2c_new_dummy_device(&client->dev, adapter,
+							 I2C_TPI_ADDR);
+	if (IS_ERR(ctx->client[I2C_TPI])) {
 		dev_err(ctx->dev, "failed to create TPI client\n");
-		return -ENODEV;
+		return PTR_ERR(ctx->client[I2C_TPI]);
 	}
 
-	ctx->client[I2C_HDMI] = i2c_new_dummy(adapter, I2C_HDMI_ADDR);
-	if (!ctx->client[I2C_HDMI]) {
+	ctx->client[I2C_HDMI] = devm_i2c_new_dummy_device(&client->dev, adapter,
+							  I2C_HDMI_ADDR);
+	if (IS_ERR(ctx->client[I2C_HDMI])) {
 		dev_err(ctx->dev, "failed to create HDMI RX client\n");
-		goto fail_tpi;
+		return PTR_ERR(ctx->client[I2C_HDMI]);
 	}
 
-	ctx->client[I2C_CBUS] = i2c_new_dummy(adapter, I2C_CBUS_ADDR);
-	if (!ctx->client[I2C_CBUS]) {
+	ctx->client[I2C_CBUS] = devm_i2c_new_dummy_device(&client->dev, adapter,
+							  I2C_CBUS_ADDR);
+	if (IS_ERR(ctx->client[I2C_CBUS])) {
 		dev_err(ctx->dev, "failed to create CBUS client\n");
-		goto fail_hdmi;
+		return PTR_ERR(ctx->client[I2C_CBUS]);
 	}
 
 	return 0;
-
-fail_hdmi:
-	i2c_unregister_device(ctx->client[I2C_HDMI]);
-fail_tpi:
-	i2c_unregister_device(ctx->client[I2C_TPI]);
-
-	return -ENODEV;
-}
-
-static void sii9234_deinit_resources(struct sii9234 *ctx)
-{
-	i2c_unregister_device(ctx->client[I2C_CBUS]);
-	i2c_unregister_device(ctx->client[I2C_HDMI]);
-	i2c_unregister_device(ctx->client[I2C_TPI]);
 }
 
 static inline struct sii9234 *bridge_to_sii9234(struct drm_bridge *bridge)
@@ -950,7 +939,6 @@ static int sii9234_remove(struct i2c_client *client)
 
 	sii9234_cable_out(ctx);
 	drm_bridge_remove(&ctx->bridge);
-	sii9234_deinit_resources(ctx);
 
 	return 0;
 }
-- 
2.20.1

