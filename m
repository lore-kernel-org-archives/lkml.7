Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20885C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E966920882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="NaEEOLac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438041AbfITKO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:14:57 -0400
Received: from onstation.org ([52.200.56.107]:58730 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438011AbfITKO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:14:56 -0400
Received: from ins7386.corp.homestore.net (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3B4D93E8F9;
        Fri, 20 Sep 2019 10:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1568974495;
        bh=nrATIp838hQ69BazPEwmO/C7VQqxDn0AiW5nC34LWsI=;
        h=From:To:Cc:Subject:Date:From;
        b=NaEEOLacnAbsGhBumDBk7DRzMXMFuL3Kik2cflKAAnz+j5JGFWqtna+K7OU24W1NJ
         9Lg2PpiU8d6jjutj3rjceoRuFepRvQNtukkuO1UpnRZif0joii0QH/52wA09RC3kO1
         PquE9xAISWgkYkuB8OnY+Bb1lPLvcue+4ggmIna4=
From:   Brian Masney <masneyb@onstation.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com
Cc:     jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com
Subject: [PATCH v2] drm/bridge: analogix-anx78xx: add support for 7808 addresses
Date:   Fri, 20 Sep 2019 06:14:38 -0400
Message-Id: <20190920101438.6912-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the downstream Android sources, the anx7808 variants use
address 0x78 for TX_P0 and the anx781x variants use address 0x70. Since
the datasheets aren't available for these devices, and we only have the
downstream kernel sources to look at, let's assume that these addresses
are fixed based on the model, and pass the i2c addresses to the data
pointer in the driver's of_match_table.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
V1 of this patch with some discussion:
https://lore.kernel.org/lkml/20190815004854.19860-6-masneyb@onstation.org/

 drivers/gpu/drm/bridge/analogix-anx78xx.c | 36 +++++++++++++++--------
 drivers/gpu/drm/bridge/analogix-anx78xx.h |  7 -----
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index 48adf010816c..e25fae36dbe1 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -38,12 +38,20 @@
 #define AUX_CH_BUFFER_SIZE	16
 #define AUX_WAIT_TIMEOUT_MS	15
 
-static const u8 anx78xx_i2c_addresses[] = {
-	[I2C_IDX_TX_P0] = TX_P0,
-	[I2C_IDX_TX_P1] = TX_P1,
-	[I2C_IDX_TX_P2] = TX_P2,
-	[I2C_IDX_RX_P0] = RX_P0,
-	[I2C_IDX_RX_P1] = RX_P1,
+static const u8 anx7808_i2c_addresses[] = {
+	[I2C_IDX_TX_P0] = 0x78,
+	[I2C_IDX_TX_P1] = 0x7a,
+	[I2C_IDX_TX_P2] = 0x72,
+	[I2C_IDX_RX_P0] = 0x7e,
+	[I2C_IDX_RX_P1] = 0x80,
+};
+
+static const u8 anx781x_i2c_addresses[] = {
+	[I2C_IDX_TX_P0] = 0x70,
+	[I2C_IDX_TX_P1] = 0x7a,
+	[I2C_IDX_TX_P2] = 0x72,
+	[I2C_IDX_RX_P0] = 0x7e,
+	[I2C_IDX_RX_P1] = 0x80,
 };
 
 struct anx78xx_platform_data {
@@ -1348,6 +1356,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 	struct anx78xx *anx78xx;
 	struct anx78xx_platform_data *pdata;
 	unsigned int i, idl, idh, version;
+	const u8 *i2c_addresses;
 	bool found = false;
 	int err;
 
@@ -1387,15 +1396,16 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 	}
 
 	/* Map slave addresses of ANX7814 */
+	i2c_addresses = device_get_match_data(&client->dev);
 	for (i = 0; i < I2C_NUM_ADDRESSES; i++) {
 		struct i2c_client *i2c_dummy;
 
 		i2c_dummy = i2c_new_dummy_device(client->adapter,
-						 anx78xx_i2c_addresses[i] >> 1);
+						 i2c_addresses[i] >> 1);
 		if (IS_ERR(i2c_dummy)) {
 			err = PTR_ERR(i2c_dummy);
 			DRM_ERROR("Failed to reserve I2C bus %02x: %d\n",
-				  anx78xx_i2c_addresses[i], err);
+				  i2c_addresses[i], err);
 			goto err_unregister_i2c;
 		}
 
@@ -1405,7 +1415,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 		if (IS_ERR(anx78xx->map[i])) {
 			err = PTR_ERR(anx78xx->map[i]);
 			DRM_ERROR("Failed regmap initialization %02x\n",
-				  anx78xx_i2c_addresses[i]);
+				  i2c_addresses[i]);
 			goto err_unregister_i2c;
 		}
 	}
@@ -1504,10 +1514,10 @@ MODULE_DEVICE_TABLE(i2c, anx78xx_id);
 
 #if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id anx78xx_match_table[] = {
-	{ .compatible = "analogix,anx7808", },
-	{ .compatible = "analogix,anx7812", },
-	{ .compatible = "analogix,anx7814", },
-	{ .compatible = "analogix,anx7818", },
+	{ .compatible = "analogix,anx7808", .data = anx7808_i2c_addresses },
+	{ .compatible = "analogix,anx7812", .data = anx781x_i2c_addresses },
+	{ .compatible = "analogix,anx7814", .data = anx781x_i2c_addresses },
+	{ .compatible = "analogix,anx7818", .data = anx781x_i2c_addresses },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, anx78xx_match_table);
diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.h b/drivers/gpu/drm/bridge/analogix-anx78xx.h
index 25e063bcecbc..8697647709f7 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.h
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.h
@@ -6,13 +6,6 @@
 #ifndef __ANX78xx_H
 #define __ANX78xx_H
 
-#define TX_P0				0x70
-#define TX_P1				0x7a
-#define TX_P2				0x72
-
-#define RX_P0				0x7e
-#define RX_P1				0x80
-
 /***************************************************************/
 /* Register definition of device address 0x7e                  */
 /***************************************************************/
-- 
2.21.0

