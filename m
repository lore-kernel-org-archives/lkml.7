Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254B1C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBC12086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SpMlpQid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404018AbfGHTZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:25:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36675 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403969AbfGHTZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:25:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so8783779plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RvgoMdD3Hp5MNxLK+UifXpyN/q0ZxRgeuu9cUaFHqr8=;
        b=SpMlpQid2jj35QITypL4R5jsoWc0eG7EtxUCSVBodyEYgZle89BhBjfYFUQcF2IcgI
         mXOOm3S92C45cfdZOxjxUNPEiD0QpH1HZiyzpYze+Mrg3gwzJZnA0thsvhG+Ajpoyf6/
         6XTwCEWLcN8yOYJBHr+iZ35NTAosHvvbZSfqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RvgoMdD3Hp5MNxLK+UifXpyN/q0ZxRgeuu9cUaFHqr8=;
        b=ZUu4EUnN/iLL6Xi3LbkgI00SOwfQq/+dc4WWbW/HFZRvdoSA5sBleV4Oz+XtRwCBoS
         5rC1NvuQmPXnqMSMz62F6ovwDp9I9w5qAWB+VuIkYDKIAZwwQQaAjCM5Dlz1Y0ThHx4N
         jibxRhfcXNL/Aae0o+KgCFBh344OM4ABRxeFJi/NGLzWXYWwMfYh+/pUin1hgpUSl7QI
         EiClHgSVoSHbQt3ff8sF5phm3k+ooiSHlbpb/TMcN0Log6NiX2k820chlXbFLaG+I4Oe
         NAx12QnI6Ooaud2ld1fmWTqhJDCbBm+S+A3WpxROtuEupW9Dn6pbk7RPIPBaIxFDEyMq
         v/sA==
X-Gm-Message-State: APjAAAUfbmcBcwYNX3PMrnZgaQSx/m5OVH0jXBoCVWUERCxvJSqXwY5I
        TGfDGl223gjyWXJy9oYEP7b8bw==
X-Google-Smtp-Source: APXvYqyYbItR6VGpkLNF5CZeyV8kogEprG74LIry/HE4PBk2qDVJtcyVuPh67bU1HhhmNxBuH27ERw==
X-Received: by 2002:a17:902:fe93:: with SMTP id x19mr25192719plm.77.1562613920330;
        Mon, 08 Jul 2019 12:25:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e13sm14330516pff.45.2019.07.08.12.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:25:19 -0700 (PDT)
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
Subject: [PATCH v3 7/7] net: phy: realtek: configure RTL8211E LEDs
Date:   Mon,  8 Jul 2019 12:24:59 -0700
Message-Id: <20190708192459.187984-8-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708192459.187984-1-mka@chromium.org>
References: <20190708192459.187984-1-mka@chromium.org>
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
TODO: DT validation

Changes in v3:
- sanity check led-modes values
- set LACR bits in a more readable way
- use phydev_err() instead of dev_err()
- log an error if LED configuration fails

Changes in v2:
- patch added to the series
---
 drivers/net/phy/realtek.c | 72 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 5854412403b5..e9fb67654c4e 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -9,10 +9,12 @@
  * Copyright (c) 2004 Freescale Semiconductor, Inc.
  */
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy.h>
+#include <dt-bindings/net/realtek.h>
 
 #define RTL821x_PHYSR				0x11
 #define RTL821x_PHYSR_DUPLEX			BIT(13)
@@ -34,6 +36,15 @@
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
@@ -123,6 +134,62 @@ static void rtl8211e_disable_eee_led_mode(struct phy_device *phydev)
 	phy_restore_page(phydev, oldpage, err);
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
+		if ((val > RTL8211E_LINK_10_100_1000 &&
+		    val < RTL8211E_LINK_ACTIVITY) ||
+		    val > (RTL8211E_LINK_ACTIVITY | RTL8211E_LINK_10_100_1000))
+			return -EINVAL;
+
+		if (val & RTL8211E_LINK_ACTIVITY)
+			lacr_bits |= BIT(RLT8211E_LACR_LEDACTCTRL_SHIFT + i);
+
+		lcr_bits |= (u16)(val & 0xf) << (i * 4);
+	}
+
+	oldpage = rtl8211e_select_ext_page(phydev, 44);
+	if (oldpage < 0) {
+		phydev_err(phydev, "failed to select extended page: %d\n", oldpage);
+		goto err;
+	}
+
+	ret = __phy_modify(phydev, RTL8211E_LACR,
+			   RLT8211E_LACR_LEDACTCTRL_MASK, lacr_bits);
+	if (ret) {
+		phydev_err(phydev, "failed to write LACR reg: %d\n", ret);
+		goto err;
+	}
+
+	ret = __phy_modify(phydev, RTL8211E_LCR,
+			   RTL8211E_LCR_LEDCTRL_MASK, lcr_bits);
+	if (ret)
+		phydev_err(phydev, "failed to write LCR reg: %d\n", ret);
+
+err:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
 static int rtl8201_ack_interrupt(struct phy_device *phydev)
 {
 	int err;
@@ -267,8 +334,9 @@ static int rtl8211e_config_init(struct phy_device *phydev)
 				   ret);
 	}
 
-	if (of_property_read_bool(dev->of_node, "realtek,eee-led-mode-disable"))
-		rtl8211e_disable_eee_led_mode(phydev);
+	ret = rtl8211e_config_leds(phydev);
+	if (ret)
+		phydev_err(phydev, "LED configuration failed: %d\n", ret);
 
 	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
 	switch (phydev->interface) {
-- 
2.22.0.410.gd8fdbe21b5-goog

