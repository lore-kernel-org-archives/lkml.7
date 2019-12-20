Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74C5C2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A7524682
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqLaGf2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfLTB4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:56:13 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33867 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLTB4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:56:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id z22so3503576ljg.1;
        Thu, 19 Dec 2019 17:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CyOBgUyBQTadUiHrJMdJoMu32DJe9pSrz674dm+emxo=;
        b=QqLaGf2Si+9KDx/et3p3DINTbMus4Z45Br0i9p7tpAyr8fLuSZwfPInFkXScd6X40q
         IS1OqrgRReTbF1khbDXrga0ogmAiApmJ3thOp0IPg0rAflDHxY28W4rkJ2rynsmlFUjH
         h/vAG3jPliyTIc7KGYuMcvODSE6h1dILIVfKWQU166HYbgiJHDkAPEpZ9etxmMqjTUS8
         v0rb/EbB+27WxRNzSm2vNJc5aTA8PMwt3ZBgub1UDoFUuznHkOOTglLDMHl9/08a3MbP
         v1l90/VbocnQ5zJtZkW6gc4MdQzxG5ffdqTMg9zOzf/5JBRtq8/OE5XW1Uhq7S0EfqPC
         XHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyOBgUyBQTadUiHrJMdJoMu32DJe9pSrz674dm+emxo=;
        b=Tl2IK0RsMQWz9Rtxi1Q2SPo0yXG5cb4C7YTjQ1PmY2Oa0EN6TOZ2FdetkPGITqOXKx
         uobq9YdgKnAjTJHsAi247345z35PAkBXL77j8O9au7WEof6BSoLWYpE+MKrPklklS7Mr
         gLDDPYf+sR7miTZzyxQfkiFr+akVfXJJa6QYC+CcZ7oiOmjXr9LwFf+XlJ5ThTLofi+E
         HTM+jEhDAsumzaRs60sxMSMqcc0lketn28zPuCBdyamV/ouCSiI1QpkqlQ3/UGfPQbzW
         63d/cunwfuHidwna0Cb5D5fW0udgWcLe5oFoPFKMiomPj8VTIYuEnfBNtUzeqERGObGL
         MCEQ==
X-Gm-Message-State: APjAAAUMbCCXXfvp3LcDY8uMG0juo75+N9jgCYklD6Bl0XveXlKxN0dH
        +I/Q6T3ievGokE+eQBhp4oY=
X-Google-Smtp-Source: APXvYqxRQjpy9P9Sr3BTsYV4M0AD3Jkj8yRNshXjndM+dFHBrq6O4pJQoAn0nJ2UTzsqZjx3pAJHIw==
X-Received: by 2002:a2e:9708:: with SMTP id r8mr8159606lji.92.1576806966561;
        Thu, 19 Dec 2019 17:56:06 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m13sm3270901lfo.40.2019.12.19.17.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 17:56:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] usb: phy: tegra: Hook up init/shutdown callbacks
Date:   Fri, 20 Dec 2019 04:52:30 +0300
Message-Id: <20191220015238.9228-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220015238.9228-1-digetx@gmail.com>
References: <20191220015238.9228-1-digetx@gmail.com>
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
 drivers/usb/phy/phy-tegra-usb.c | 178 +++++++++++++++++++++-----------
 1 file changed, 116 insertions(+), 62 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index ea7ef1dc0b42..12d6f6433365 100644
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
+static int tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
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
+	err = PTR_ERR_OR_ZERO(tegra_phy);
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
 
+	tegra_phy->u_phy.dev = &pdev->dev;
+	tegra_phy->u_phy.init = tegra_usb_phy_init;
+	tegra_phy->u_phy.shutdown = tegra_usb_phy_shutdown;
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

