Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5280C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B7424679
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQhH2Gl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLRRxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:53:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35998 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfLRRxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:53:40 -0500
Received: by mail-lf1-f67.google.com with SMTP id n12so2341459lfe.3;
        Wed, 18 Dec 2019 09:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7b8roJ82IFAJ1grL8xuxaJUQE2f5JTyocRu5NlzTyc=;
        b=LQhH2Gl3NE3p92NSX1B0mbSiGRKhRvgyzGaWdXylL2j1CmMyZUEHkmGZp8KqcYqWqF
         yli8WtfyWglGKDjw+9JQwcXdnqnfyWI2DW1rgtnxGryTgoA2NmiLq4w9E7l9Oix55bMT
         m6jSnGxpMcTUmRWeTGuW0bHxDikE3aPUwUBoFWmRbjv2LA7blUSg68ACtkovxjO4Ci/m
         rjikZkL9uzJSxbUNprWcc7mBCm1Vs7Bx+xsGwR9PqwOTzGCpc0Guqgy5bJSXVRFRrHbN
         Sd4tyDrdPCUMk8GaPaSIfiwI/q3DBl/UkTlyQP1+Z1mEF6QkiLAy6N0r8cjtyN8KHldy
         BFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7b8roJ82IFAJ1grL8xuxaJUQE2f5JTyocRu5NlzTyc=;
        b=srFSyWThseKFGi6TYBiZda4y2aOTVp2E5lTjRt/EGJlkbgAbUV8Wh2rfwtwRw7sAXl
         eI06MSZ/47mcZaNG2KbyvvbQKopM/1FZk27iLGgrTjvyaGceBCKq41UlSa9t3bjuOO3g
         M4YgMJ1jKw04ZVPI0bQyhy/Mjk6zUtc+3S5ivhOR1L+7VFC3SpRNr2nu3tk5iuyfh3zZ
         vAykdHuTpBSFoL7llYPkoeX7uFcRptGNBb1VQ8F/Eyix+wyqhyNL6T6SwQ5xtIUPt0JM
         aub7Hh4aTDOrBU+fUd0CSE19jbGNcmoVsnJP7HAqZMhT5dPgXXxa+heyQ7T4V17WV/UZ
         /3CA==
X-Gm-Message-State: APjAAAUIahoYnfXZN1AS6QwZs3Wldjja5HklQ5uhdCF1TjBlLyvyjF/u
        gLdLlpjNpe9G+w+v2Jm8xgU=
X-Google-Smtp-Source: APXvYqwT9XFlcZ2IDFnxoZjsvNK2FmfBjE7yod3K2Bji7EidoHYwGcyPNPlBu1xhnzWemp4rqJ2hVw==
X-Received: by 2002:ac2:5549:: with SMTP id l9mr2548863lfk.53.1576691617987;
        Wed, 18 Dec 2019 09:53:37 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id n14sm1530480lfe.5.2019.12.18.09.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:53:37 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] usb: phy: tegra: Hook up init/shutdown callbacks
Date:   Wed, 18 Dec 2019 20:53:11 +0300
Message-Id: <20191218175313.16235-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218175313.16235-1-digetx@gmail.com>
References: <20191218175313.16235-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_tegra.c |   9 --
 drivers/usb/phy/phy-tegra-usb.c      | 165 +++++++++++++++++----------
 2 files changed, 102 insertions(+), 72 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 0c9911d44ee5..7455df0ede49 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -83,13 +83,6 @@ static int tegra_udc_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	/*
-	 * Tegra's USB PHY driver doesn't implement optional phy_init()
-	 * hook, so we have to power on UDC controller before ChipIdea
-	 * driver initialization kicks in.
-	 */
-	usb_phy_set_suspend(udc->phy, 0);
-
 	/* setup and register ChipIdea HDRC device */
 	udc->data.name = "tegra-udc";
 	udc->data.flags = soc->flags;
@@ -109,7 +102,6 @@ static int tegra_udc_probe(struct platform_device *pdev)
 	return 0;
 
 fail_power_off:
-	usb_phy_set_suspend(udc->phy, 1);
 	clk_disable_unprepare(udc->clk);
 	return err;
 }
@@ -119,7 +111,6 @@ static int tegra_udc_remove(struct platform_device *pdev)
 	struct tegra_udc *udc = platform_get_drvdata(pdev);
 
 	ci_hdrc_remove_device(udc->dev);
-	usb_phy_set_suspend(udc->phy, 1);
 	clk_disable_unprepare(udc->clk);
 
 	return 0;
diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index ea7ef1dc0b42..15bd253d53c9 100644
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
@@ -761,14 +756,19 @@ static int ulpi_phy_power_off(struct tegra_usb_phy *phy)
 	return gpio_direction_output(phy->reset_gpio, 0);
 }
 
-static void tegra_usb_phy_close(struct tegra_usb_phy *phy)
+static void tegra_usb_phy_close(struct usb_phy *u_phy)
 {
-	if (!IS_ERR(phy->vbus))
-		regulator_disable(phy->vbus);
+	struct tegra_usb_phy *phy = container_of(u_phy, struct tegra_usb_phy,
+						 u_phy);
 
-	if (!phy->is_ulpi_phy)
+	if (phy->is_ulpi_phy)
+		ulpi_close(phy);
+	else
 		utmip_pad_close(phy);
 
+	if (!IS_ERR(phy->vbus))
+		regulator_disable(phy->vbus);
+
 	clk_disable_unprepare(phy->pll_u);
 }
 
@@ -788,7 +788,7 @@ static int tegra_usb_phy_power_off(struct tegra_usb_phy *phy)
 		return utmi_phy_power_off(phy);
 }
 
-static int	tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
+static int tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
 {
 	struct tegra_usb_phy *phy = container_of(x, struct tegra_usb_phy, u_phy);
 	if (suspend)
@@ -801,54 +801,25 @@ static int ulpi_open(struct tegra_usb_phy *phy)
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
-
 	err = clk_prepare_enable(phy->pll_u);
 	if (err)
 		return err;
@@ -884,8 +855,17 @@ static int tegra_usb_phy_init(struct tegra_usb_phy *phy)
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
 	return err;
@@ -1134,22 +1114,77 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 		tegra_phy->vbus = ERR_PTR(-ENODEV);
 	}
 
-	tegra_phy->u_phy.dev = &pdev->dev;
-	err = tegra_usb_phy_init(tegra_phy);
-	if (err < 0)
+	tegra_phy->pll_u = devm_clk_get(&pdev->dev, "pll_u");
+	err = PTR_ERR_OR_ZERO(tegra_phy);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to get pll_u clock: %d\n", err);
 		return err;
+	}
 
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
+
+	tegra_phy->u_phy.dev = &pdev->dev;
+	tegra_phy->u_phy.init = tegra_usb_phy_init;
+	tegra_phy->u_phy.shutdown = tegra_usb_phy_close;
 	tegra_phy->u_phy.set_suspend = tegra_usb_phy_suspend;
 
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
@@ -1157,7 +1192,11 @@ static int tegra_usb_phy_remove(struct platform_device *pdev)
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

