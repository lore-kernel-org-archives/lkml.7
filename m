Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A4C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D9521882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fChiVLhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfKGUR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:17:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44309 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfKGURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:17:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id f2so4497360wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IfBF8N8O1vGmVN86XMswrU/+wD8KeNGcTXaMDHv5bNc=;
        b=fChiVLhYdW8MmlavzflarIALwM6oQ0oST9a0xpt5JGB0qZEOMP7X0WdzhndbJXFXKD
         6k8LOvZvA/TsBMcho59C3LYvbxjYxz0B/Cy2BlH6plJHiYRj6Q8UZdvSDthBoHwHKpiN
         lYU4B1emlpo79KIN0NkyazFGkzrtsvMP7v8jmv0bJiIGsicKBClB5c0w9mguUu2YQKrv
         IfcsibvoqBXkS96uVqk0slcwOz7Ht0tocUPpxc34eo5loD6TpalowitM3JU1+OYEsyIo
         fkw6xKIKLvF1OZmeSxx5MBOBO2rpemTZADULbrE++JP1JtBSnPL5q5NJuyJ8vihLnp/Y
         gkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IfBF8N8O1vGmVN86XMswrU/+wD8KeNGcTXaMDHv5bNc=;
        b=blQlkxcLih9+7yptZb9FaHptDo5i08+0jJfpqA1xv60Ht0Xv71cIQKLm3MzOB6BnbQ
         fP02M/jZE0XkpjrsKOpWSp7VTxBrYufwXT4Z8Q6EzCuTqzPJbkIhG9+Fzo9wiMJomvFw
         mGVSydYD+cHg4sqJXT4Gp1BxsKXmPVhM71ZqbIG6wfQuJ/Wy0K4KJmZn2COWT+BabcQm
         TO8Bi+VO32ENBnTInP77yQaPuPFkSYc+5Mlwh1qxybZKXq2IdntudqYQJwQmwUOTKU/H
         q0byx9z1UUKPsyP5tXO1D+qz18SxHIlJJrScsReRB+rn+8BBlFuLgFYh0GWqglrMaYol
         QU9A==
X-Gm-Message-State: APjAAAWNJCV6xVESldwNpxCstK13X+L48UfCKdYM2UBTQH9HK8UhKbtV
        lS1PivvBxW/+sMTTbQ+OPIG4hQ==
X-Google-Smtp-Source: APXvYqxLeJVGJOzI2ZwJzDDqNvlQyCV/uNdN9GYB084GYIYZxX5OgQ/rW6PhFKY71ZiiT24Rhit05g==
X-Received: by 2002:adf:b686:: with SMTP id j6mr4742254wre.186.1573157834960;
        Thu, 07 Nov 2019 12:17:14 -0800 (PST)
Received: from localhost.localdomain ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id d11sm3215162wrn.28.2019.11.07.12.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:17:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 10/10] can: mcp251x: add support for mcp25625
Date:   Thu,  7 Nov 2019 20:17:02 +0000
Message-Id: <20191107201702.27023-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107201702.27023-1-lee.jones@linaro.org>
References: <20191107201702.27023-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Nyekjaer <sean@geanix.com>

[ Upstream commit 35b7fa4d07c43ad79b88e6462119e7140eae955c ]

Fully compatible with mcp2515, the mcp25625 have integrated transceiver.

This patch adds support for the mcp25625 to the existing mcp251x driver.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Change-Id: I537254af4e09553f04873e3cf6be36dbbfc29c88
---
 drivers/net/can/spi/Kconfig   |  5 +++--
 drivers/net/can/spi/mcp251x.c | 25 ++++++++++++++++---------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/spi/Kconfig b/drivers/net/can/spi/Kconfig
index 148cae5871a6..249d2db7d600 100644
--- a/drivers/net/can/spi/Kconfig
+++ b/drivers/net/can/spi/Kconfig
@@ -2,9 +2,10 @@ menu "CAN SPI interfaces"
 	depends on SPI
 
 config CAN_MCP251X
-	tristate "Microchip MCP251x SPI CAN controllers"
+	tristate "Microchip MCP251x and MCP25625 SPI CAN controllers"
 	depends on HAS_DMA
 	---help---
-	  Driver for the Microchip MCP251x SPI CAN controllers.
+	  Driver for the Microchip MCP251x and MCP25625 SPI CAN
+	  controllers.
 
 endmenu
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index c66d699640a9..6f86fdf6c9f1 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1,5 +1,5 @@
 /*
- * CAN bus driver for Microchip 251x CAN Controller with SPI Interface
+ * CAN bus driver for Microchip 251x/25625 CAN Controller with SPI Interface
  *
  * MCP2510 support and bug fixes by Christian Pellegrin
  * <chripell@evolware.org>
@@ -41,7 +41,7 @@
  * static struct spi_board_info spi_board_info[] = {
  *         {
  *                 .modalias = "mcp2510",
- *			// or "mcp2515" depending on your controller
+ *			// "mcp2515" or "mcp25625" depending on your controller
  *                 .platform_data = &mcp251x_info,
  *                 .irq = IRQ_EINT13,
  *                 .max_speed_hz = 2*1000*1000,
@@ -237,6 +237,7 @@ static const struct can_bittiming_const mcp251x_bittiming_const = {
 enum mcp251x_model {
 	CAN_MCP251X_MCP2510	= 0x2510,
 	CAN_MCP251X_MCP2515	= 0x2515,
+	CAN_MCP251X_MCP25625	= 0x25625,
 };
 
 struct mcp251x_priv {
@@ -279,7 +280,6 @@ static inline int mcp251x_is_##_model(struct spi_device *spi) \
 }
 
 MCP251X_IS(2510);
-MCP251X_IS(2515);
 
 static void mcp251x_clean(struct net_device *net)
 {
@@ -639,7 +639,7 @@ static int mcp251x_hw_reset(struct spi_device *spi)
 
 	/* Wait for oscillator startup timer after reset */
 	mdelay(MCP251X_OST_DELAY_MS);
-	
+
 	reg = mcp251x_read_reg(spi, CANSTAT);
 	if ((reg & CANCTRL_REQOP_MASK) != CANCTRL_REQOP_CONF)
 		return -ENODEV;
@@ -820,9 +820,8 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 		/* receive buffer 0 */
 		if (intf & CANINTF_RX0IF) {
 			mcp251x_hw_rx(spi, 0);
-			/*
-			 * Free one buffer ASAP
-			 * (The MCP2515 does this automatically.)
+			/* Free one buffer ASAP
+			 * (The MCP2515/25625 does this automatically.)
 			 */
 			if (mcp251x_is_2510(spi))
 				mcp251x_write_bits(spi, CANINTF, CANINTF_RX0IF, 0x00);
@@ -831,7 +830,7 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 		/* receive buffer 1 */
 		if (intf & CANINTF_RX1IF) {
 			mcp251x_hw_rx(spi, 1);
-			/* the MCP2515 does this automatically */
+			/* The MCP2515/25625 does this automatically. */
 			if (mcp251x_is_2510(spi))
 				clear_intf |= CANINTF_RX1IF;
 		}
@@ -1004,6 +1003,10 @@ static const struct of_device_id mcp251x_of_match[] = {
 		.compatible	= "microchip,mcp2515",
 		.data		= (void *)CAN_MCP251X_MCP2515,
 	},
+	{
+		.compatible	= "microchip,mcp25625",
+		.data		= (void *)CAN_MCP251X_MCP25625,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp251x_of_match);
@@ -1017,6 +1020,10 @@ static const struct spi_device_id mcp251x_id_table[] = {
 		.name		= "mcp2515",
 		.driver_data	= (kernel_ulong_t)CAN_MCP251X_MCP2515,
 	},
+	{
+		.name		= "mcp25625",
+		.driver_data	= (kernel_ulong_t)CAN_MCP251X_MCP25625,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, mcp251x_id_table);
@@ -1254,5 +1261,5 @@ module_spi_driver(mcp251x_can_driver);
 
 MODULE_AUTHOR("Chris Elston <celston@katalix.com>, "
 	      "Christian Pellegrin <chripell@evolware.org>");
-MODULE_DESCRIPTION("Microchip 251x CAN driver");
+MODULE_DESCRIPTION("Microchip 251x/25625 CAN driver");
 MODULE_LICENSE("GPL v2");
-- 
2.24.0

