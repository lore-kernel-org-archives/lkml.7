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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E45C00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D2F215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUD7jClG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgAFBgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:36:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33008 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgAFBes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:48 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so41290950lji.0;
        Sun, 05 Jan 2020 17:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=42H5eN8aWJh5DHzggTgG8y5oMLx4033Tu59SdMlqJBs=;
        b=eUD7jClGBRRkc7ghzaysDaprEcnXC275+awcQm/u4B+6d1cVJ5OZ0YgFer1ITESmLF
         8eb5f3xky9aX3DxDJpsOTOMvD7KDm1E8Vr4vc1z1DnBHe3dT/nKtUEa9BPPwllWJbbNV
         G8E6G3BNqC7t7WPbXwmaTgzX6+UNN+V134hn73C9APTZOBkDLjy7kt60mReiweuiQF50
         UgocCB1TTrkMpDWWTzM+eHl4rxsB5UZgoiMc7RKTd1LZQMAcgMRpt6ybrqD69j8zPB8D
         qJz71M9kcmYYlPQgwIk9znIP8aIBVrxqROW0/+2839j9jtm/gdOKI8K3P47nYWaVA9OP
         6Tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=42H5eN8aWJh5DHzggTgG8y5oMLx4033Tu59SdMlqJBs=;
        b=mI7ChXs/Iu8Wk/ayAt6QN7xlt8xdfskDBpbnTTuxdj2mLePAaX2z8YoJFjMLaDW79a
         RvaatMQW63nt+QB1U05LyesRbNpqTDTkhLyGCAdzZUyla0rJx1hAFkyyXEzuDXDVwutQ
         p1KWx5jeBTe3Q266HqjZjpDJEjBNMAU95Aa1U3s1vGAz7ewrf4jUFkYnUVHLiUMoQUIC
         oVqPAYkorIMCrXfby0aBCCLVDCIdFrdpJVmRorsouAYLpsFiavR+5qbDHidHslMH6MJy
         xcI27oRhUDVVakjqugCz/pWr7iUdkKP5QnvzhZShiiaGlm4GJBPNOgoCfwPohzqp0jSR
         Hsag==
X-Gm-Message-State: APjAAAVYsYobcSocsaVTyVuEFpL5cJ9vYJysfnc6b31NlbmZcMrXXI08
        KOVnOiyGKCH9opPTPIWFInl6X+Rl
X-Google-Smtp-Source: APXvYqynss6RaFMvXCpVZtJSV0khbhiEEW1YlZYTgyAvU+oMFclc8NPmCxOSCoeK/RClVs+rVYceOA==
X-Received: by 2002:a2e:9243:: with SMTP id v3mr50807373ljg.73.1578274485223;
        Sun, 05 Jan 2020 17:34:45 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:44 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/20] usb: phy: tegra: Hook up init/shutdown callbacks
Date:   Mon,  6 Jan 2020 04:34:01 +0300
Message-Id: <20200106013416.9604-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
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
 drivers/usb/phy/phy-tegra-usb.c | 180 +++++++++++++++++++-------------
 1 file changed, 110 insertions(+), 70 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 88466c7f13e6..664259d74658 100644
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
@@ -772,17 +755,6 @@ static int ulpi_phy_power_off(struct tegra_usb_phy *phy)
 	return 0;
 }
 
-static void tegra_usb_phy_close(struct tegra_usb_phy *phy)
-{
-	if (!IS_ERR(phy->vbus))
-		regulator_disable(phy->vbus);
-
-	if (!phy->is_ulpi_phy)
-		utmip_pad_close(phy);
-
-	clk_disable_unprepare(phy->pll_u);
-}
-
 static int tegra_usb_phy_power_on(struct tegra_usb_phy *phy)
 {
 	int err;
@@ -821,9 +793,34 @@ static int tegra_usb_phy_power_off(struct tegra_usb_phy *phy)
 	return 0;
 }
 
-static int	tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
+static void tegra_usb_phy_shutdown(struct usb_phy *u_phy)
+{
+	struct tegra_usb_phy *phy = container_of(u_phy, struct tegra_usb_phy,
+						 u_phy);
+
+	if (WARN_ON(!phy->freq))
+		return;
+
+	tegra_usb_phy_power_off(phy);
+
+	if (!phy->is_ulpi_phy)
+		utmip_pad_close(phy);
+
+	if (!IS_ERR(phy->vbus))
+		regulator_disable(phy->vbus);
+
+	clk_disable_unprepare(phy->pll_u);
+
+	phy->freq = NULL;
+}
+
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
@@ -834,53 +831,27 @@ static int ulpi_open(struct tegra_usb_phy *phy)
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
+			"ULPI reset GPIO %d direction not asserted: %d\n",
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
@@ -917,10 +888,20 @@ static int tegra_usb_phy_init(struct tegra_usb_phy *phy)
 	if (err < 0)
 		goto fail;
 
+	err = tegra_usb_phy_power_on(phy);
+	if (err)
+		goto close_phy;
+
 	return 0;
 
+close_phy:
+	if (!phy->is_ulpi_phy)
+		utmip_pad_close(phy);
 fail:
 	clk_disable_unprepare(phy->pll_u);
+
+	phy->freq = NULL;
+
 	return err;
 }
 
@@ -1167,22 +1148,77 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
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
 
-	tegra_phy->u_phy.set_suspend = tegra_usb_phy_suspend;
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
@@ -1190,7 +1226,11 @@ static int tegra_usb_phy_remove(struct platform_device *pdev)
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

