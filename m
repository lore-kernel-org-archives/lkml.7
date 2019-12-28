Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5009AC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAE521744
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6kKZ00J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfL1Ugq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35469 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfL1UgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so22496126lja.2;
        Sat, 28 Dec 2019 12:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lsHEVOVm6Hgf7CUTYE5k3U45djLZB2dELdAM3vwJ98M=;
        b=a6kKZ00JHZ7dOT42HXD6ynKP10TOxOO3tgUIxmtDwhj08RZkoXijsX16lEXKEY3Nk3
         0vAH8dOUQdC06KH99J1rMqVl7IpJXKuCN8/nHdkR+gHEObcJLo9urckRcgDsESXeHpfK
         eVxh4n5FW1eUxNId+pkmES5t9ro0Hz6cN75dwpiqK72gZd5MwSsAm7a989tOFR532x7a
         g/R9WTHSFeEdZa+2gfqpmRWpJ2Wi5B3H0zSbwbc8NG8Lp5to6pgFUkU2tZ6sF6df6Ads
         SxbmSh4H9s4BKnCFJyE+mtDPsIZI+4bRXzHJvyBn/LUntBd1BLB55M/5SDlCL2ENTCoH
         smKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lsHEVOVm6Hgf7CUTYE5k3U45djLZB2dELdAM3vwJ98M=;
        b=ntP0YUxC4xenRompY3MqaQffvtIteK3H1JP5FZFB2VFeHKfHJWeOskEfC6Rdza53rw
         aqWcl5KvZ0va7KDNGvOwSjTbv0AxO9xmUlnIyMiLfmtdDLkboYhhUBcmo21YmZxhZlKe
         6CtTULZ44x3yNZRd3d8Rminy7VtU8/vcSomgqWsMNlMTwsZDYdLuz9+tGffeAyz7DV0v
         0oiWgZRf+WYmuiJ5VQr2XRCh4Ei3CAc4wYNAVTJaekSG8yzPMwtDVBOePE386e9RDLFa
         xSa8haoFN3TCcfNMea0yFmMCTqph0OxS4n2E5Q9Jrvv45Ko/FXQ9nggkxKS5VURb1Juw
         r2kw==
X-Gm-Message-State: APjAAAVMorfmbuc1cyH2l1/HFa9RtWhj5TKvTpYh3ylWqv+aDdkmY27t
        ReBEnfZmoRoRm29Dx//QWrM=
X-Google-Smtp-Source: APXvYqyq/lho9UxcxMIQZdaLIUaUT+35KUVjrVfC4twVSmOW/HNCeMb4SUjdbQZXZrEqZQvMiGEbLQ==
X-Received: by 2002:a2e:8595:: with SMTP id b21mr12928547lji.219.1577565368311;
        Sat, 28 Dec 2019 12:36:08 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:36:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/16] usb: phy: tegra: Use device-tree notion of reset-GPIO's active-state
Date:   Sat, 28 Dec 2019 23:33:52 +0300
Message-Id: <20191228203358.23490-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
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
 drivers/usb/phy/phy-tegra-usb.c   | 58 ++++++++-----------------------
 include/linux/usb/tegra_usb_phy.h |  3 +-
 2 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 1ecd9f7900af..cc6cca4dcecb 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -306,14 +306,7 @@ static int utmip_pad_close(struct tegra_usb_phy *phy)
 
 static void ulpi_close(struct tegra_usb_phy *phy)
 {
-	int err;
-
-	err = gpio_direction_output(phy->reset_gpio, 0);
-	if (err) {
-		dev_err(phy->u_phy.dev,
-			"ULPI reset GPIO %d direction not asserted: %d\n",
-			phy->reset_gpio, err);
-	}
+	gpiod_set_value_cansleep(phy->reset_gpio, 1);
 }
 
 static int utmip_pad_power_on(struct tegra_usb_phy *phy)
@@ -703,12 +696,7 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
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
@@ -716,12 +704,7 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 
 	usleep_range(5000, 10000);
 
-	err = gpio_direction_output(phy->reset_gpio, 1);
-	if (err) {
-		dev_err(phy->u_phy.dev, "GPIO %d not set to 1: %d\n",
-			phy->reset_gpio, err);
-		goto disable_clk;
-	}
+	gpiod_set_value_cansleep(phy->reset_gpio, 0);
 
 	usleep_range(1000, 2000);
 
@@ -784,8 +767,9 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 static int ulpi_phy_power_off(struct tegra_usb_phy *phy)
 {
 	clk_disable_unprepare(phy->clk);
+	gpiod_set_value_cansleep(phy->reset_gpio, 1);
 
-	return gpio_direction_output(phy->reset_gpio, 0);
+	return 0;
 }
 
 static void tegra_usb_phy_shutdown(struct usb_phy *u_phy)
@@ -837,15 +821,7 @@ static int tegra_usb_phy_set_suspend(struct usb_phy *u_phy, int suspend)
 
 static int ulpi_open(struct tegra_usb_phy *phy)
 {
-	int err;
-
-	err = gpio_direction_output(phy->reset_gpio, 0);
-	if (err) {
-		dev_err(phy->u_phy.dev,
-			"ULPI reset GPIO %d direction not deasserted: %d\n",
-			phy->reset_gpio, err);
-		return err;
-	}
+	gpiod_set_value_cansleep(phy->reset_gpio, 1);
 
 	return 0;
 }
@@ -1081,6 +1057,7 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 	struct tegra_usb_phy *tegra_phy;
 	enum usb_phy_interface phy_type;
 	struct reset_control *reset;
+	struct gpio_desc *gpiod;
 	struct resource *res;
 	struct usb_phy *phy;
 	int err;
@@ -1158,15 +1135,6 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
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
@@ -1175,13 +1143,17 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
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
index 0c5c3ea8b2d7..6b857fe13b35 100644
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
 };
 
-- 
2.24.0

