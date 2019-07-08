Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA90FC606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30322086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iNpeBQQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391690AbfGHTZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:25:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39209 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391669AbfGHTZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:25:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so8072174pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4uAWO2xmu252LdOM6iPnY9UopRO1Fi//IgaHZgpov0=;
        b=iNpeBQQtfqQ1TJgqESjgV+5IBBSVIreasZT6U7MhxHRWjaW9uKqclQb0B2/IdiMbRL
         O8n2L57pWVTNk6rXEkNDCaQ9bTUt1wgOqlFMrh/tLfuWRw9VDeYy8b979ZJcQQhnwvh2
         0coB/WG9kysdaS0v8smC8q682OH+v+ZBADAJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4uAWO2xmu252LdOM6iPnY9UopRO1Fi//IgaHZgpov0=;
        b=rCGbyBgJni8uR+aeY1bpnndTII2bYIUrcVASbpoDMAp4lSEuq+7Vdz73nV7kqT/Vk0
         dZGVdqQmx3JcOJWkiCt75GLCLvIB9rNoklGms4RleIr9Aj5vHQb8IGH/TYOQKoqE3CMJ
         3ZbPJPKwgFZalasJyO70scKC6lo32cHbyVuUc/wmwJvC1ijaXZPG4mohaoAuJkKnUMCt
         zKpYso3cCsKedA3tJPP+mf/VuZT4i67dVvF+IT9yR1ycX0dpD24vJWtWF4gn43DBD0EP
         FtMMAK/Hj2gNXo6c+dr6JUBgWQl1K5gvzpMmEfQer2ls5jJATedLGS5VICSUgQLl13JL
         WUBQ==
X-Gm-Message-State: APjAAAVDpwEI+u9pfCUjStBd4m3Epdp0uZBNnwRLfsCVhur57wpi1/Ei
        dZ8x7qYby4QGDJKnWfQ7Qd+0sQ==
X-Google-Smtp-Source: APXvYqxeCVlZXRSm30fM1wf1daKaYzqjidYa7WK1HTymDcqUGGTSmv1xpCiMrgFjDK0wArf5QNMt7A==
X-Received: by 2002:a17:90a:d996:: with SMTP id d22mr27797320pjv.86.1562613913084;
        Mon, 08 Jul 2019 12:25:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t17sm20193715pgg.48.2019.07.08.12.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:25:12 -0700 (PDT)
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
Subject: [PATCH v3 2/7] net: phy: realtek: Allow disabling RTL8211E EEE LED mode
Date:   Mon,  8 Jul 2019 12:24:54 -0700
Message-Id: <20190708192459.187984-3-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708192459.187984-1-mka@chromium.org>
References: <20190708192459.187984-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EEE LED mode is enabled by default on the RTL8211E. Disable it when
the device tree property 'realtek,eee-led-mode-disable' exists.

The magic values to disable EEE LED mode were taken from the RTL8211E
datasheet, unfortunately they are not further documented.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
TODO: DT validation

Changes in v3:
- don't have two versions of rtl8211e_config_init()
  (was due to my dev kernel being 4.19, which doesn't have
   this function yet)
- changed return type of rtl8211e_disable_eee_led_mode() to void
- added empty line after rtl8211e_config_init()

Changes in v2:
- patch added to the series
---
 drivers/net/phy/realtek.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index a669945eb829..827ea7ed080d 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -9,8 +9,9 @@
  * Copyright (c) 2004 Freescale Semiconductor, Inc.
  */
 #include <linux/bitops.h>
-#include <linux/phy.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
 
 #define RTL821x_PHYSR				0x11
 #define RTL821x_PHYSR_DUPLEX			BIT(13)
@@ -26,6 +27,10 @@
 #define RTL821x_EXT_PAGE_SELECT			0x1e
 #define RTL821x_PAGE_SELECT			0x1f
 
+/* RTL8211E page 5 */
+#define RTL8211E_EEE_LED_MODE1			0x05
+#define RTL8211E_EEE_LED_MODE2			0x06
+
 #define RTL8211F_INSR				0x1d
 
 #define RTL8211F_TX_DELAY			BIT(8)
@@ -53,6 +58,26 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
 }
 
+static void rtl8211e_disable_eee_led_mode(struct phy_device *phydev)
+{
+	int oldpage;
+	int err = 0;
+
+	oldpage = phy_select_page(phydev, 5);
+	if (oldpage < 0)
+		goto out;
+
+	/* write magic values to disable EEE LED mode */
+	err = __phy_write(phydev, RTL8211E_EEE_LED_MODE1, 0x8b82);
+	if (err)
+		goto out;
+
+	err = __phy_write(phydev, RTL8211E_EEE_LED_MODE2, 0x052b);
+
+out:
+	phy_restore_page(phydev, oldpage, err);
+}
+
 static int rtl8201_ack_interrupt(struct phy_device *phydev)
 {
 	int err;
@@ -184,9 +209,13 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
+	struct device *dev = &phydev->mdio.dev;
 	int ret = 0, oldpage;
 	u16 val;
 
+	if (of_property_read_bool(dev->of_node, "realtek,eee-led-mode-disable"))
+		rtl8211e_disable_eee_led_mode(phydev);
+
 	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
 	switch (phydev->interface) {
 	case PHY_INTERFACE_MODE_RGMII:
-- 
2.22.0.410.gd8fdbe21b5-goog

