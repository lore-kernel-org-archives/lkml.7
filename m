Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB97C00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E82215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5G0Tryz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgAFBf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:35:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40815 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgAFBez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id u1so49285578ljk.7;
        Sun, 05 Jan 2020 17:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vINXXjWj7NDH/p3sklu8i0G1Rq05HWbY0415CgCPEc=;
        b=R5G0TryzU/+cs7ZEJ29tjY0EFW2INSPUkDnGinDwSbTDO+u83iUxyxYgS4fSjHCirO
         iP/zuvVpSxKaXAIrFq9bCFMH2qTyuab0PV/2IkiGxzb3hYb7CyrKzs39qOtkZSnLLcg2
         XY+gPWEgUHxIqxxiPcvSGSY2n9VqQUM97/AeK1ZDy6v0O4okGZ5/uYshGMqiGrPQvMmR
         MBJVxUKM9GS7sv4ioEhffoxkFIrqHpr5tURyUDz9lob72Kdm7x4Onu9jfsAc6QTZchAF
         rC/mwOMJqhOm2c6O3RNK6Y3ZPdg15FO3EjnoidOkZEc9s84RCvrVOiQ+AX/RTIJwV09l
         lLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vINXXjWj7NDH/p3sklu8i0G1Rq05HWbY0415CgCPEc=;
        b=Mc1pPuxoyUt8UR6SIM4JeBF/jE824Y6Ug5DJ9CxQNKiDJuz/JSNGsyTty1jYBTc1IM
         zLjylVOSoFW4gCURZrCmrNzlKSt39Mmmvs8zanWYHN45WvGH1JBN72Ox32+vfI2dqCJ0
         C6649pXa/zc8CgN6C9SHw3f4iV5SdMQ1GGiShk/G8eLczjNYtbtYHUD5TN1zLeKSeOYi
         69gW2Q8BLSjKWfhXz8QjMsxS38Knxj9VQlrmuqyDXQ3i97ORI43yPGsE4+qEd9J8Jf8t
         QYh0lCiyO73rC07FeLSS3d3GdSl+48TiY6uIMrbMkCq0bSUeTCi+HiaEXKhw00u+e5NA
         oeRw==
X-Gm-Message-State: APjAAAVnZAbOHp970KKl3EjaAT8hK8hj4EAp8EX5hkSVTAAlhVJrYPnN
        sBbgPrwZYsjzDQnWw4Gp2Uc=
X-Google-Smtp-Source: APXvYqwdSZIwm8TSvkW0m2RaBego/zmETAbmMkPC01MdQE2lbM+O+/eulZ11xyGubnYjURNETfTetA==
X-Received: by 2002:a2e:804c:: with SMTP id p12mr57138112ljg.31.1578274492423;
        Sun, 05 Jan 2020 17:34:52 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:52 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/20] usb: phy: tegra: Use device-tree notion of reset-GPIO's active-state
Date:   Mon,  6 Jan 2020 04:34:09 +0300
Message-Id: <20200106013416.9604-14-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is much more intuitive if reset is treated as asserted when GPIO value
is set to 1. All NVIDIA Tegra device-trees are properly specifying active
state of the reset-GPIO since 2013, let's clean up that part of the code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c   | 70 +++++++------------------------
 include/linux/usb/tegra_usb_phy.h |  3 +-
 2 files changed, 18 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index f9acbab477cf..c431968d0433 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -693,12 +693,7 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 	u32 val;
 	int err;
 
-	err = gpio_direction_output(phy->reset_gpio, 0);
-	if (err) {
-		dev_err(phy->u_phy.dev, "GPIO %d not set to 0: %d\n",
-			phy->reset_gpio, err);
-		return err;
-	}
+	gpiod_set_value_cansleep(phy->reset_gpio, 1);
 
 	err = clk_prepare_enable(phy->clk);
 	if (err)
@@ -706,12 +701,7 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 
 	usleep_range(5000, 6000);
 
-	err = gpio_direction_output(phy->reset_gpio, 1);
-	if (err) {
-		dev_err(phy->u_phy.dev, "GPIO %d not set to 1: %d\n",
-			phy->reset_gpio, err);
-		goto disable_clk;
-	}
+	gpiod_set_value_cansleep(phy->reset_gpio, 0);
 
 	usleep_range(1000, 2000);
 
@@ -773,16 +763,8 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 
 static int ulpi_phy_power_off(struct tegra_usb_phy *phy)
 {
-	int err;
-
-	err = gpio_direction_output(phy->reset_gpio, 0);
-	if (err) {
-		dev_err(phy->u_phy.dev, "reset GPIO not asserted: %d\n", err);
-		return err;
-	}
-
+	gpiod_set_value_cansleep(phy->reset_gpio, 1);
 	usleep_range(5000, 6000);
-
 	clk_disable_unprepare(phy->clk);
 
 	return 0;
@@ -857,21 +839,6 @@ static int tegra_usb_phy_set_suspend(struct usb_phy *u_phy, int suspend)
 		return tegra_usb_phy_power_on(phy);
 }
 
-static int ulpi_open(struct tegra_usb_phy *phy)
-{
-	int err;
-
-	err = gpio_direction_output(phy->reset_gpio, 0);
-	if (err) {
-		dev_err(phy->u_phy.dev,
-			"ULPI reset GPIO %d direction not asserted: %d\n",
-			phy->reset_gpio, err);
-		return err;
-	}
-
-	return 0;
-}
-
 static int tegra_usb_phy_init(struct usb_phy *u_phy)
 {
 	struct tegra_usb_phy *phy = to_tegra_usb_phy(u_phy);
@@ -907,12 +874,11 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
 		goto fail;
 	}
 
-	if (phy->is_ulpi_phy)
-		err = ulpi_open(phy);
-	else
+	if (!phy->is_ulpi_phy) {
 		err = utmip_pad_open(phy);
-	if (err)
-		goto fail;
+		if (err)
+			goto fail;
+	}
 
 	err = tegra_usb_phy_power_on(phy);
 	if (err)
@@ -1101,6 +1067,7 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 	struct tegra_usb_phy *tegra_phy;
 	enum usb_phy_interface phy_type;
 	struct reset_control *reset;
+	struct gpio_desc *gpiod;
 	struct resource *res;
 	struct usb_phy *phy;
 	int err;
@@ -1178,15 +1145,6 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 	case USBPHY_INTERFACE_MODE_ULPI:
 		tegra_phy->is_ulpi_phy = true;
 
-		tegra_phy->reset_gpio =
-			of_get_named_gpio(np, "nvidia,phy-reset-gpio", 0);
-
-		if (!gpio_is_valid(tegra_phy->reset_gpio)) {
-			dev_err(&pdev->dev,
-				"Invalid GPIO: %d\n", tegra_phy->reset_gpio);
-			return tegra_phy->reset_gpio;
-		}
-
 		tegra_phy->clk = devm_clk_get(&pdev->dev, "ulpi-link");
 		err = PTR_ERR_OR_ZERO(tegra_phy->clk);
 		if (err) {
@@ -1195,13 +1153,17 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 			return err;
 		}
 
-		err = devm_gpio_request(&pdev->dev, tegra_phy->reset_gpio,
-					"ulpi_phy_reset_b");
+		gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
+						    "nvidia,phy-reset-gpio",
+						    0, GPIOD_OUT_HIGH,
+						    "ulpi_phy_reset_b");
+		err = PTR_ERR_OR_ZERO(gpiod);
 		if (err) {
-			dev_err(&pdev->dev, "Request failed for GPIO %d: %d\n",
-				tegra_phy->reset_gpio, err);
+			dev_err(&pdev->dev,
+				"Request failed for reset GPIO: %d\n", err);
 			return err;
 		}
+		tegra_phy->reset_gpio = gpiod;
 
 		phy = devm_otg_ulpi_create(&pdev->dev,
 					   &ulpi_viewport_access_ops, 0);
diff --git a/include/linux/usb/tegra_usb_phy.h b/include/linux/usb/tegra_usb_phy.h
index 3ae73bdc6245..c29d1b4c9381 100644
--- a/include/linux/usb/tegra_usb_phy.h
+++ b/include/linux/usb/tegra_usb_phy.h
@@ -17,6 +17,7 @@
 #define __TEGRA_USB_PHY_H
 
 #include <linux/clk.h>
+#include <linux/gpio.h>
 #include <linux/reset.h>
 #include <linux/usb/otg.h>
 
@@ -76,7 +77,7 @@ struct tegra_usb_phy {
 	struct usb_phy u_phy;
 	bool is_legacy_phy;
 	bool is_ulpi_phy;
-	int reset_gpio;
+	struct gpio_desc *reset_gpio;
 	struct reset_control *pad_rst;
 	bool powered_on;
 };
-- 
2.24.0

