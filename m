Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3F1C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9200A21D7E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZO+mnalQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfL1UgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42913 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfL1UgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id y4so15515668ljj.9;
        Sat, 28 Dec 2019 12:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09QqZVe0j7zalGHXPclISoph95GAHOs1aDcqQ5aR3C8=;
        b=ZO+mnalQH++X/KaR1fh3FdJ94dFgjDUdMwHSRbklDcp535yYnnIVmvji/+AeMS3nS5
         f833qm4g06Jza5QSzHqcnF5u/ke02TO4G7FZjpzcXs7avVp/l1yKs4Fq+7b+36CShGgL
         PUYjhqb+Ds9+8WyQE/6ZUPW70wtVfuNEnMzDbiy61NiYlqtU8J3VF/8Idoh3Od6Z36wd
         oZidHnF+qUzkgdxVgm+52m3HDWhb81Rjtp2MjDshgC6f9kiz2uud/Tu1DJCISM9icABL
         kqjEL6nkNVy+kWK5dEJrqv6eNbliytPXrQFGQdpxpz/rpZDgqEHMOqKZBno99TwVkb58
         KxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09QqZVe0j7zalGHXPclISoph95GAHOs1aDcqQ5aR3C8=;
        b=iBSQAbLa5RMlBKLLexPZR4ubx+dzyHvbd15buzrb8OiR1QOkZHggHmdYpNEBNic0+E
         BJmnUtnm8W5qX2aHPiydM4a6sgDEq9TK19UCvI4n/hvRyc1rbD1mTDuNa5i2r2/dcWc6
         Fu8KuF49QE13OcVjOMEwUJ+YRiwWT5W+zyH4pmCp/WnNr7iQGkkMlFRzuj4TUCmWNwtV
         fPHnz9pXmn3WE3nxUQIzyi8Gx/9j0KfA3zDHA13X1H72jEb9MOP2BBcnp+pJSCUF3JUl
         /yvzGBNQeqyuuNViZOheXjwiUizX5ggCDMvTiCggQHU6gh/vbwHCIO8d3dhZ8XYrGxgI
         XE0A==
X-Gm-Message-State: APjAAAVpNUomcNEfL0OEhrZHCcIMgWka72FZGzIBZ/6Gd+e08+zz4WI7
        NDtBf9uHAMX8+tDgKFyF0SA=
X-Google-Smtp-Source: APXvYqxW/oDy9y/qgr17eEmwIMTI6JLjz4RMAp24NA6KMU5dG9WSFcCo/vOUq8DHDZerzqg2heKr5Q==
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr32825246ljq.241.1577565363816;
        Sat, 28 Dec 2019 12:36:03 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:36:03 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/16] usb: phy: tegra: Use generic stub for a missing VBUS regulator
Date:   Sat, 28 Dec 2019 23:33:47 +0300
Message-Id: <20191228203358.23490-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator core provides dummy regulator if device-tree doesn't define VBUS
regulator.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 4d6d586c49cc..0a07efc9de06 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -798,9 +798,7 @@ static void tegra_usb_phy_shutdown(struct usb_phy *u_phy)
 	else
 		utmip_pad_close(phy);
 
-	if (!IS_ERR(phy->vbus))
-		regulator_disable(phy->vbus);
-
+	regulator_disable(phy->vbus);
 	clk_disable_unprepare(phy->pll_u);
 
 	phy->freq = NULL;
@@ -878,14 +876,11 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
 		goto fail;
 	}
 
-	if (!IS_ERR(phy->vbus)) {
-		err = regulator_enable(phy->vbus);
-		if (err) {
-			dev_err(phy->u_phy.dev,
-				"Failed to enable USB VBUS regulator: %d\n",
-				err);
-			goto fail;
-		}
+	err = regulator_enable(phy->vbus);
+	if (err) {
+		dev_err(phy->u_phy.dev,
+			"Failed to enable USB VBUS regulator: %d\n", err);
+		goto fail;
 	}
 
 	if (phy->is_ulpi_phy)
@@ -1120,14 +1115,9 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 	}
 
 	/* On some boards, the VBUS regulator doesn't need to be controlled */
-	if (of_find_property(np, "vbus-supply", NULL)) {
-		tegra_phy->vbus = devm_regulator_get(&pdev->dev, "vbus");
-		if (IS_ERR(tegra_phy->vbus))
-			return PTR_ERR(tegra_phy->vbus);
-	} else {
-		dev_notice(&pdev->dev, "no vbus regulator");
-		tegra_phy->vbus = ERR_PTR(-ENODEV);
-	}
+	tegra_phy->vbus = devm_regulator_get(&pdev->dev, "vbus");
+	if (IS_ERR(tegra_phy->vbus))
+		return PTR_ERR(tegra_phy->vbus);
 
 	tegra_phy->pll_u = devm_clk_get(&pdev->dev, "pll_u");
 	err = PTR_ERR_OR_ZERO(tegra_phy->pll_u);
-- 
2.24.0

