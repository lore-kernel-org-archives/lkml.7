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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABF7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24E220838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfBKqg2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfL1UgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43885 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfL1UgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so29864494ljm.10;
        Sat, 28 Dec 2019 12:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jx7JMSohyFkVm6KDld0640Fsvvb0PRHAf2COPicsQ2M=;
        b=lfBKqg2IwJZ73AH+sRWQOCZJ4oLYYMHE47SvirWG/USKRV1PVr7y3Fl9AsJf0x34JH
         /Wc2fTz8UWGH78JX+DDwEZb1rTXc5libe78VG3Ycbl41uiIOyd/LS8Rul0Zoi8iCLrNP
         zPet4eUNDUvLrwFpEBoiAskiWos1pSGEFxxmBgJydJO51li7LMI4IPXS3y6MQsKpLsRw
         oIY0ly9A9QfQE/nTyiidCUbhciyyJy+MRg4qn/PeXzIQ6yQBV1E1t7RUSlRDYbwe+kbg
         vw+sXCBNDcc+41rA//LJRDp0GK/QGXfBOegmn14ZNtJfGLvEAi77KLCGS3j269kDVIgz
         Ib2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jx7JMSohyFkVm6KDld0640Fsvvb0PRHAf2COPicsQ2M=;
        b=n5W1aihb1SBcCHf8zpQMu8OtXg4NgiakdsF/qFcv8KJUKsM1e8qaGauQqZ16SmXZdB
         AAfLTH5v/pMkfWiYl90OlKOD3mWdfM+Xr8sAebcuAB29PSu0fX06Zazh1JUq5zxTa3Tn
         XQTilSWYCoSBrWtvfvGfqYH6xubdWEevJPPgvshefilDC8gx+lpA27KFbbloxoAJCT9a
         Vy75u8+xdg5b3GoUVHPp/XeaB6G600ChzjrQ6PBrB8l1aEo2msyy4wnXbrt4w3CKmzsC
         W99Oum7eMjYNibWJIP63/G07UWPFjkDF3UNyKa6KQvmss53K1vriZ507jNS1ULqNBINo
         NJLQ==
X-Gm-Message-State: APjAAAWEIqToeKsCRUyrwwTABujsUBoE5t0ESG8i1/0f3LZiDxP/7Pxt
        W5GMbcrisVX9J4PvKW/frao=
X-Google-Smtp-Source: APXvYqwEdQdCed74k+h6NsLaM+av49yIq6BCvb60vLJ2wTG7LUXo2I9XAgQGtzQQ5EgmBnqMBhqVTw==
X-Received: by 2002:a2e:9095:: with SMTP id l21mr31340013ljg.175.1577565360987;
        Sat, 28 Dec 2019 12:36:00 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:36:00 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/16] usb: phy: tegra: Hook up init/shutdown callbacks
Date:   Sat, 28 Dec 2019 23:33:44 +0300
Message-Id: <20191228203358.23490-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic PHY provides init/shutdown callbacks which allow USB-host drivers
to abstract PHY's hardware management in a common way. This change allows
to remove Tegra-specific PHY handling from the ChipIdea driver.

Note that ChipIdea's driver shall be changed at the same time because it
turns PHY ON without the PHY's initialization and this doesn't work now,
resulting in a NULL dereference of phy->freq because it's set during of
the PHY's initialization.

Acked-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 180 +++++++++++++++++++++-----------
 1 file changed, 117 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index ea7ef1dc0b42..d11d217e232b 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -238,23 +238,6 @@ static int utmip_pad_open(struct tegra_usb_phy *phy)
 {
 	int ret;
 
-	phy->pad_clk = devm_clk_get(phy->u_phy.dev, "utmi-pads");
-	if (IS_ERR(phy->pad_clk)) {
-		ret = PTR_ERR(phy->pad_clk);
-		dev_err(phy->u_phy.dev,
-			"Failed to get UTMIP pad clock: %d\n", ret);
-		return ret;
-	}
-
-	phy->pad_rst = devm_reset_control_get_optional_shared(
-						phy->u_phy.dev, "utmi-pads");
-	if (IS_ERR(phy->pad_rst)) {
-		ret = PTR_ERR(phy->pad_rst);
-		dev_err(phy->u_phy.dev,
-			"Failed to get UTMI-pads reset: %d\n", ret);
-		return ret;
-	}
-
 	ret = clk_prepare_enable(phy->pad_clk);
 	if (ret) {
 		dev_err(phy->u_phy.dev,
@@ -315,6 +298,18 @@ static int utmip_pad_close(struct tegra_usb_phy *phy)
 	return ret;
 }
 
+static void ulpi_close(struct tegra_usb_phy *phy)
+{
+	int err;
+
+	err = gpio_direction_output(phy->reset_gpio, 1);
+	if (err < 0) {
+		dev_err(phy->u_phy.dev,
+			"ULPI reset GPIO %d direction not asserted: %d\n",
+			phy->reset_gpio, err);
+	}
+}
+
 static void utmip_pad_power_on(struct tegra_usb_phy *phy)
 {
 	unsigned long val, flags;
@@ -761,15 +756,25 @@ static int ulpi_phy_power_off(struct tegra_usb_phy *phy)
 	return gpio_direction_output(phy->reset_gpio, 0);
 }
 
-static void tegra_usb_phy_close(struct tegra_usb_phy *phy)
+static void tegra_usb_phy_shutdown(struct usb_phy *u_phy)
 {
-	if (!IS_ERR(phy->vbus))
-		regulator_disable(phy->vbus);
+	struct tegra_usb_phy *phy = container_of(u_phy, struct tegra_usb_phy,
+						 u_phy);
 
-	if (!phy->is_ulpi_phy)
+	if (WARN_ON(!phy->freq))
+		return;
+
+	if (phy->is_ulpi_phy)
+		ulpi_close(phy);
+	else
 		utmip_pad_close(phy);
 
+	if (!IS_ERR(phy->vbus))
+		regulator_disable(phy->vbus);
+
 	clk_disable_unprepare(phy->pll_u);
+
+	phy->freq = NULL;
 }
 
 static int tegra_usb_phy_power_on(struct tegra_usb_phy *phy)
@@ -788,9 +793,13 @@ static int tegra_usb_phy_power_off(struct tegra_usb_phy *phy)
 		return utmi_phy_power_off(phy);
 }
 
-static int	tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
+static int tegra_usb_phy_set_suspend(struct usb_phy *x, int suspend)
 {
 	struct tegra_usb_phy *phy = container_of(x, struct tegra_usb_phy, u_phy);
+
+	if (WARN_ON(!phy->freq))
+		return -EINVAL;
+
 	if (suspend)
 		return tegra_usb_phy_power_off(phy);
 	else
@@ -801,53 +810,27 @@ static int ulpi_open(struct tegra_usb_phy *phy)
 {
 	int err;
 
-	phy->clk = devm_clk_get(phy->u_phy.dev, "ulpi-link");
-	if (IS_ERR(phy->clk)) {
-		err = PTR_ERR(phy->clk);
-		dev_err(phy->u_phy.dev, "Failed to get ULPI clock: %d\n", err);
-		return err;
-	}
-
-	err = devm_gpio_request(phy->u_phy.dev, phy->reset_gpio,
-		"ulpi_phy_reset_b");
-	if (err < 0) {
-		dev_err(phy->u_phy.dev, "Request failed for GPIO %d: %d\n",
-			phy->reset_gpio, err);
-		return err;
-	}
-
 	err = gpio_direction_output(phy->reset_gpio, 0);
 	if (err < 0) {
 		dev_err(phy->u_phy.dev,
-			"GPIO %d direction not set to output: %d\n",
+			"ULPI reset GPIO %d direction not deasserted: %d\n",
 			phy->reset_gpio, err);
 		return err;
 	}
 
-	phy->ulpi = otg_ulpi_create(&ulpi_viewport_access_ops, 0);
-	if (!phy->ulpi) {
-		dev_err(phy->u_phy.dev, "Failed to create ULPI OTG\n");
-		err = -ENOMEM;
-		return err;
-	}
-
-	phy->ulpi->io_priv = phy->regs + ULPI_VIEWPORT;
 	return 0;
 }
 
-static int tegra_usb_phy_init(struct tegra_usb_phy *phy)
+static int tegra_usb_phy_init(struct usb_phy *u_phy)
 {
+	struct tegra_usb_phy *phy = container_of(u_phy, struct tegra_usb_phy,
+						 u_phy);
 	unsigned long parent_rate;
 	int i;
 	int err;
 
-	phy->pll_u = devm_clk_get(phy->u_phy.dev, "pll_u");
-	if (IS_ERR(phy->pll_u)) {
-		err = PTR_ERR(phy->pll_u);
-		dev_err(phy->u_phy.dev,
-			"Failed to get pll_u clock: %d\n", err);
-		return err;
-	}
+	if (WARN_ON(phy->freq))
+		return 0;
 
 	err = clk_prepare_enable(phy->pll_u);
 	if (err)
@@ -884,10 +867,22 @@ static int tegra_usb_phy_init(struct tegra_usb_phy *phy)
 	if (err < 0)
 		goto fail;
 
+	err = tegra_usb_phy_power_on(phy);
+	if (err)
+		goto close_phy;
+
 	return 0;
 
+close_phy:
+	if (phy->is_ulpi_phy)
+		ulpi_close(phy);
+	else
+		utmip_pad_close(phy);
 fail:
 	clk_disable_unprepare(phy->pll_u);
+
+	phy->freq = NULL;
+
 	return err;
 }
 
@@ -1134,22 +1129,77 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 		tegra_phy->vbus = ERR_PTR(-ENODEV);
 	}
 
-	tegra_phy->u_phy.dev = &pdev->dev;
-	err = tegra_usb_phy_init(tegra_phy);
-	if (err < 0)
+	tegra_phy->pll_u = devm_clk_get(&pdev->dev, "pll_u");
+	err = PTR_ERR_OR_ZERO(tegra_phy->pll_u);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to get pll_u clock: %d\n", err);
 		return err;
+	}
+
+	if (tegra_phy->is_ulpi_phy) {
+		tegra_phy->clk = devm_clk_get(&pdev->dev, "ulpi-link");
+		err = PTR_ERR_OR_ZERO(tegra_phy->clk);
+		if (err) {
+			dev_err(&pdev->dev,
+				"Failed to get ULPI clock: %d\n", err);
+			return err;
+		}
+
+		err = devm_gpio_request(&pdev->dev, tegra_phy->reset_gpio,
+			"ulpi_phy_reset_b");
+		if (err < 0) {
+			dev_err(&pdev->dev, "Request failed for GPIO %d: %d\n",
+				tegra_phy->reset_gpio, err);
+			return err;
+		}
+
+		tegra_phy->ulpi = otg_ulpi_create(&ulpi_viewport_access_ops, 0);
+		if (!tegra_phy->ulpi) {
+			dev_err(&pdev->dev, "Failed to create ULPI OTG\n");
+			err = -ENOMEM;
+			return err;
+		}
+
+		tegra_phy->ulpi->io_priv = tegra_phy->regs + ULPI_VIEWPORT;
+	} else {
+		tegra_phy->pad_clk = devm_clk_get(&pdev->dev, "utmi-pads");
+		err = PTR_ERR_OR_ZERO(tegra_phy->pad_clk);
+		if (err) {
+			dev_err(&pdev->dev,
+				"Failed to get UTMIP pad clock: %d\n", err);
+			return err;
+		}
+
+		tegra_phy->pad_rst = devm_reset_control_get_optional_shared(
+						&pdev->dev, "utmi-pads");
+		err = PTR_ERR_OR_ZERO(tegra_phy->pad_rst);
+		if (err) {
+			dev_err(&pdev->dev,
+				"Failed to get UTMI-pads reset: %d\n", err);
+			return err;
+		}
+	}
 
-	tegra_phy->u_phy.set_suspend = tegra_usb_phy_suspend;
+	tegra_phy->u_phy.dev = &pdev->dev;
+	tegra_phy->u_phy.init = tegra_usb_phy_init;
+	tegra_phy->u_phy.shutdown = tegra_usb_phy_shutdown;
+	tegra_phy->u_phy.set_suspend = tegra_usb_phy_set_suspend;
 
 	platform_set_drvdata(pdev, tegra_phy);
 
 	err = usb_add_phy_dev(&tegra_phy->u_phy);
-	if (err < 0) {
-		tegra_usb_phy_close(tegra_phy);
-		return err;
-	}
+	if (err < 0)
+		goto free_ulpi;
 
 	return 0;
+
+free_ulpi:
+	if (tegra_phy->ulpi) {
+		kfree(tegra_phy->ulpi->otg);
+		kfree(tegra_phy->ulpi);
+	}
+
+	return err;
 }
 
 static int tegra_usb_phy_remove(struct platform_device *pdev)
@@ -1157,7 +1207,11 @@ static int tegra_usb_phy_remove(struct platform_device *pdev)
 	struct tegra_usb_phy *tegra_phy = platform_get_drvdata(pdev);
 
 	usb_remove_phy(&tegra_phy->u_phy);
-	tegra_usb_phy_close(tegra_phy);
+
+	if (tegra_phy->ulpi) {
+		kfree(tegra_phy->ulpi->otg);
+		kfree(tegra_phy->ulpi);
+	}
 
 	return 0;
 }
-- 
2.24.0

