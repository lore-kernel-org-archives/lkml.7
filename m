Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CABC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C166821721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="md3MkgWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfGATwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:52:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45199 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfGATwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:52:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so7056723pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAYVgFrVyDEWW2kNMp3bRnTvQ9QblfVV1v8XIkrYm00=;
        b=md3MkgWYd9QIP3p2MmWnvrUvBzm99KGfssPqgfPa6k4JMEh9NKrI6Nk9yhJaYtunNJ
         VKLTVCTBAkGA6DAB0gtRI6byTewFkDnwSJEJXy4ftSVw5uPtJ2hx6zlz2xnwlDlVxK9l
         Yve3yGn9fvm/tLGAblJm3gVchSbYM57oi8mdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAYVgFrVyDEWW2kNMp3bRnTvQ9QblfVV1v8XIkrYm00=;
        b=Vx509wlvMT6GYooCqvTCK7d5UMgxhbezFu2/4qkMbdL0kg5ARk0qZqU4xNsD+p2YOV
         hAR7CSmj//ZpgO7OCBL3sJsx/AwjLqoztYmdTX2kj8WZN+RZav3jwouaXAmgZqk1304S
         4BCZGfMYpx7SqdTR3ydkfkFnfR0bSyPh2gDYO/ek7GKmszI96xuxlISv8b5wijGFZMQY
         IsAJaS/vOn7cu2DYnlnQ2N7xU5skH/KSujwyDskG1k+rEX1inknqjHIF+2OrlBcvXes7
         5gFfi+bE2uHddlfGAGXtaq34+b5gZ+WVtgi9rZbT9EngricbHPDAyURNbrX/HZTIjstY
         HnxA==
X-Gm-Message-State: APjAAAVZvPzw73EGK0RIUyunkBKCgPhvYn7u0QFdmAXbJh70QcFQdDNX
        SYjwxSi9ubndJtM+RQPp0YQQbig3AVM=
X-Google-Smtp-Source: APXvYqw31m0prNXo5zqWrfyoNPVVsfqH9E3kf7BjlmUv7dGnkfIM1MGNRGL73hYzPIggSDT1kBD7og==
X-Received: by 2002:a17:90a:206a:: with SMTP id n97mr1147365pjc.10.1562010753344;
        Mon, 01 Jul 2019 12:52:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p68sm13020863pfb.80.2019.07.01.12.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 12:52:32 -0700 (PDT)
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
Subject: [PATCH 3/3] net: phy: realtek: Support SSC for the RTL8211E
Date:   Mon,  1 Jul 2019 12:52:25 -0700
Message-Id: <20190701195225.120808-3-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190701195225.120808-1-mka@chromium.org>
References: <20190701195225.120808-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default Spread-Spectrum Clocking (SSC) is disabled on the RTL8211E.
Enable it if the device tree property 'realtek,enable-ssc' exists.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/net/phy/realtek.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index dfc2e20ef335..b617169ccc8c 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -9,8 +9,10 @@
  * Copyright (c) 2004 Freescale Semiconductor, Inc.
  */
 #include <linux/bitops.h>
-#include <linux/phy.h>
+#include <linux/device.h>
+#include <linux/of.h>
 #include <linux/module.h>
+#include <linux/phy.h>
 
 #define RTL821x_PHYSR				0x11
 #define RTL821x_PHYSR_DUPLEX			BIT(13)
@@ -28,6 +30,8 @@
 
 #define RTL8211E_EXT_PAGE			7
 #define RTL8211E_EPAGSR				0x1e
+#define RTL8211E_SCR				0x1a
+#define RTL8211E_SCR_DISABLE_RXC_SSC		BIT(2)
 
 #define RTL8211F_INSR				0x1d
 
@@ -87,8 +91,8 @@ static int rtl821e_restore_page(struct phy_device *phydev, int oldpage, int ret)
 	return ret;
 }
 
-static int __maybe_unused rtl8211e_modify_ext_paged(struct phy_device *phydev,
-				    int page, u32 regnum, u16 mask, u16 set)
+static int rtl8211e_modify_ext_paged(struct phy_device *phydev, int page,
+				     u32 regnum, u16 mask, u16 set)
 {
 	int ret = 0;
 	int oldpage;
@@ -114,6 +118,22 @@ static int __maybe_unused rtl8211e_modify_ext_paged(struct phy_device *phydev,
 	return rtl821e_restore_page(phydev, oldpage, ret);
 }
 
+static int rtl8211e_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	int err;
+
+	if (of_property_read_bool(dev->of_node, "realtek,enable-ssc")) {
+		err = rtl8211e_modify_ext_paged(phydev, 0xa0, RTL8211E_SCR,
+						RTL8211E_SCR_DISABLE_RXC_SSC,
+						0);
+		if (err)
+			dev_err(dev, "failed to enable SSC on RXC: %d\n", err);
+	}
+
+	return 0;
+}
+
 static int rtl8201_ack_interrupt(struct phy_device *phydev)
 {
 	int err;
@@ -372,6 +392,7 @@ static struct phy_driver realtek_drvs[] = {
 		.config_init	= &rtl8211e_config_init,
 		.ack_interrupt	= &rtl821x_ack_interrupt,
 		.config_intr	= &rtl8211e_config_intr,
+		.probe          = rtl8211e_probe,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
-- 
2.22.0.410.gd8fdbe21b5-goog

