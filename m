Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C7CC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65DB218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S9JgP9iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfGCThx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:37:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39761 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfGCThk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:37:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so1244729pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 12:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=92MMMWQ7DnIvwLqCz1ZLToZjaHseBvhkT/Mp2Z/Tv9k=;
        b=S9JgP9iyGcwTSuU5Ibit1VXMos7cpzyQTnSn13mK3rBRD5RmlHy8K8BGo9PpVDpicm
         z91XR7hdWMinwUYnD2j3tir2SgCHM4vtnDYaVlLMAUV5GkU+GNApM3Xp/yKgxkOF5bl2
         euIrKxgCx3A5x3TnLLAMLZAbwp/QuaMWGLyyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92MMMWQ7DnIvwLqCz1ZLToZjaHseBvhkT/Mp2Z/Tv9k=;
        b=Qtn1k7AjzL/9I2oj6aVwi98K6Yju+ak9YgqX1oyLTvBs7JuUm8sDMPaKXraaYCLD6W
         gby1EgQ9UOtah8D1AZj+Hvu951edxVCC+7+L4eqA6DCPeFyV8Fw6B4ydh8VGJHSgfYcz
         EwIdJguj81ugKikPv4Yz1gltu6nU6F3RiyPN0BNKCy9SqABEQU/YQsXrdui+PS4hjl2x
         0Yy8yBRRyPKffplBfEdxgvKD56R4ncKfq5vth/2puQ01hM+/M9JdwHLEBRwX4ybMt4MP
         pme3u4aIzE7FFB1h+fG56C/R0kK96kmdI9vkzfazioDJn9w5OMLv583MCStV5hege/tV
         gKmQ==
X-Gm-Message-State: APjAAAWADCeq+fy8i8Jy/cFdlRzQsuBmRKToUeQM9gBYw0axkIEafD+3
        QTxb3t1UYIPKLRZqwW3lm1IIwQ==
X-Google-Smtp-Source: APXvYqz+i2vxmI1brUUWvEihoY3pc7PssJnkoB8NUdEDOglIhqwlU4hxiv0B0CGnk5evw/zLyeO/uA==
X-Received: by 2002:a63:2a83:: with SMTP id q125mr38238567pgq.102.1562182659699;
        Wed, 03 Jul 2019 12:37:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p23sm4448964pfn.10.2019.07.03.12.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 12:37:39 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 7/7] net: phy: realtek: configure RTL8211E LEDs
Date:   Wed,  3 Jul 2019 12:37:24 -0700
Message-Id: <20190703193724.246854-7-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190703193724.246854-1-mka@chromium.org>
References: <20190703193724.246854-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the RTL8211E LEDs behavior when the device tree property
'realtek,led-modes' is specified.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- patch added to the series
---
 drivers/net/phy/realtek.c | 63 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 45fee4612031..559aec547738 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -9,6 +9,7 @@
  * Copyright (c) 2004 Freescale Semiconductor, Inc.
  */
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -35,6 +36,15 @@
 #define RTL8211E_EEE_LED_MODE1			0x05
 #define RTL8211E_EEE_LED_MODE2			0x06
 
+/* RTL8211E extension page 44 */
+#define RTL8211E_LACR				0x1a
+#define RLT8211E_LACR_LEDACTCTRL_SHIFT		4
+#define RLT8211E_LACR_LEDACTCTRL_MASK		GENMASK(6, 4)
+#define RTL8211E_LCR				0x1c
+#define RTL8211E_LCR_LEDCTRL_MASK		(GENMASK(2, 0) | \
+						 GENMASK(6, 4) | \
+						 GENMASK(10, 8))
+
 /* RTL8211E extension page 160 */
 #define RTL8211E_SCR				0x1a
 #define RTL8211E_SCR_DISABLE_RXC_SSC		BIT(2)
@@ -124,6 +134,56 @@ static int rtl8211e_disable_eee_led_mode(struct phy_device *phydev)
 	return phy_restore_page(phydev, oldpage, ret);
 }
 
+static int rtl8211e_config_leds(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	int count, i, oldpage, ret;
+	u16 lacr_bits = 0, lcr_bits = 0;
+
+	if (!dev->of_node)
+		return 0;
+
+	if (of_property_read_bool(dev->of_node, "realtek,eee-led-mode-disable"))
+		rtl8211e_disable_eee_led_mode(phydev);
+
+	count = of_property_count_elems_of_size(dev->of_node,
+						"realtek,led-modes",
+						sizeof(u32));
+	if (count < 0 || count > 3)
+		return -EINVAL;
+
+	for (i = 0; i < count; i++) {
+		u32 val;
+
+		of_property_read_u32_index(dev->of_node,
+					   "realtek,led-modes", i, &val);
+		lacr_bits |= (u16)(val >> 16) <<
+			(RLT8211E_LACR_LEDACTCTRL_SHIFT + i);
+		lcr_bits |= (u16)(val & 0xf) << (i * 4);
+	}
+
+	oldpage = rtl8211e_select_ext_page(phydev, 44);
+	if (oldpage < 0) {
+		dev_err(dev, "failed to select extended page: %d\n", oldpage);
+		goto err;
+	}
+
+	ret = __phy_modify(phydev, RTL8211E_LACR,
+			   RLT8211E_LACR_LEDACTCTRL_MASK, lacr_bits);
+	if (ret) {
+		dev_err(dev, "failed to write LACR reg: %d\n", ret);
+		goto err;
+	}
+
+	ret = __phy_modify(phydev, RTL8211E_LCR,
+			   RTL8211E_LCR_LEDCTRL_MASK, lcr_bits);
+	if (ret)
+		dev_err(dev, "failed to write LCR reg: %d\n", ret);
+
+err:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -137,8 +197,7 @@ static int rtl8211e_config_init(struct phy_device *phydev)
 			dev_err(dev, "failed to enable SSC on RXC: %d\n", ret);
 	}
 
-	if (of_property_read_bool(dev->of_node, "realtek,eee-led-mode-disable"))
-		rtl8211e_disable_eee_led_mode(phydev);
+	rtl8211e_config_leds(phydev);
 
 	return 0;
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

