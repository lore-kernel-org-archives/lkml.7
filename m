Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40D6C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BB820732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9ATRsYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKOSnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:43:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42028 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOSni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:43:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so12030180wrf.9;
        Fri, 15 Nov 2019 10:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jJrtiyNSy3kb+yNwZbjKaE7PnY4m0t7haj0Vxh+WdWs=;
        b=C9ATRsYZH/OrMHOZETIezEvXsLqR4T4sS6Frz/FBhKg51pxXHcLd7y4t06fTHG0pnA
         fdTu2HPEvyRbIyXz5qZ7pbDZ1kOV+5kdUkKZ6OLrje7nzpSpGp47BHxAu9eMvNn9jrxJ
         vbfGY4s8dq8+XWvjbUR4HNt9sBo3XhNaMBVhNGrQpWfeNefMClxNO3/gCsyowPL3lUn6
         v752E+gJEBnBS+wdMo/S50QFxOEgzB/MwfHQMVH6A9TbUeVwxYRJa8F8IIUmggjJ6KRR
         QlQQDS73/gDeQm540a5bSwaHjZYs8KN3/zI9kDjO77U92feum41HNH60bixq0aoOUDxb
         j3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jJrtiyNSy3kb+yNwZbjKaE7PnY4m0t7haj0Vxh+WdWs=;
        b=YZ8X/Rn8VmeYNgi/ACN7SxuqzsuvSBdv8QlvkyyKFs3UsuPH/OZ3gYDpX3a3qlwodX
         kE4HW5NEP4DV1wsO+AORG+s9JqQIP2u8ZA3N1DWplm4R8aDoEZH+ZAr8QNlWOzWpVfcR
         QBExMSxuiG4XumgNnl2LN2vNrSbieAk/x1/qlU/Rtq73HPS1p8w8MV8Z918G1e5wElLC
         4HVVSB+8LhZ+x8g1we1CPuXhYmHMubIGWOzlMgt1+jh8uKdnW3l3WTT9mHiJ7JM/u08y
         qnITZ9Ac5RYWRr1WSxlR1zO+Qi+WXMjpJ39hRhynPy9VRJKjE8Fs+gDghL3FpIIphHjr
         64aQ==
X-Gm-Message-State: APjAAAXqm/wK+ebCqN8Uu3bvsx5H8gcLWuMEKK5vHbne3DUoTGklXij2
        QLojMuqI6/zrT3A/3tBD1Wnupg+hSFM=
X-Google-Smtp-Source: APXvYqwxdV+JKop5BR8N2MhmkUjQn0btJGaNIVjC/AU3LC5pxMukp/B1JSfM8g+rzCLnNHjqFXy6EA==
X-Received: by 2002:adf:9527:: with SMTP id 36mr16506548wrs.398.1573843414944;
        Fri, 15 Nov 2019 10:43:34 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id g138sm2620989wmg.11.2019.11.15.10.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 10:43:34 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 02/13] phy: usb: Get all drivers that use USB clks using correct enable/disable
Date:   Fri, 15 Nov 2019 13:42:12 -0500
Message-Id: <20191115184223.41504-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115184223.41504-1-alcooperx@gmail.com>
References: <20191115184223.41504-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BRCM USB Phy, ohci, ehci and xhci drivers all use the USB clocks
but not all drivers use the clk_prepare_enable/clk_disable_unprepare
versions to enable/disable the clocks. This change gets all drivers
using the prepare version.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index f5c1f2983a1d..217e3702ef4e 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -74,8 +74,8 @@ static int brcm_usb_phy_init(struct phy *gphy)
 	 */
 	mutex_lock(&priv->mutex);
 	if (priv->init_count++ == 0) {
-		clk_enable(priv->usb_20_clk);
-		clk_enable(priv->usb_30_clk);
+		clk_prepare_enable(priv->usb_20_clk);
+		clk_prepare_enable(priv->usb_30_clk);
 		brcm_usb_init_common(&priv->ini);
 	}
 	mutex_unlock(&priv->mutex);
@@ -106,8 +106,8 @@ static int brcm_usb_phy_exit(struct phy *gphy)
 	mutex_lock(&priv->mutex);
 	if (--priv->init_count == 0) {
 		brcm_usb_uninit_common(&priv->ini);
-		clk_disable(priv->usb_20_clk);
-		clk_disable(priv->usb_30_clk);
+		clk_disable_unprepare(priv->usb_20_clk);
+		clk_disable_unprepare(priv->usb_30_clk);
 	}
 	mutex_unlock(&priv->mutex);
 	phy->inited = false;
@@ -360,8 +360,8 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	if (priv->has_eohci)
 		brcm_usb_uninit_eohci(&priv->ini);
 	brcm_usb_uninit_common(&priv->ini);
-	clk_disable(priv->usb_20_clk);
-	clk_disable(priv->usb_30_clk);
+	clk_disable_unprepare(priv->usb_20_clk);
+	clk_disable_unprepare(priv->usb_30_clk);
 
 	phy_provider = devm_of_phy_provider_register(dev, brcm_usb_phy_xlate);
 
@@ -381,8 +381,8 @@ static int brcm_usb_phy_suspend(struct device *dev)
 	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
 
 	if (priv->init_count) {
-		clk_disable(priv->usb_20_clk);
-		clk_disable(priv->usb_30_clk);
+		clk_disable_unprepare(priv->usb_20_clk);
+		clk_disable_unprepare(priv->usb_30_clk);
 	}
 	return 0;
 }
@@ -391,8 +391,8 @@ static int brcm_usb_phy_resume(struct device *dev)
 {
 	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
 
-	clk_enable(priv->usb_20_clk);
-	clk_enable(priv->usb_30_clk);
+	clk_prepare_enable(priv->usb_20_clk);
+	clk_prepare_enable(priv->usb_30_clk);
 	brcm_usb_init_ipp(&priv->ini);
 
 	/*
@@ -405,13 +405,13 @@ static int brcm_usb_phy_resume(struct device *dev)
 			brcm_usb_init_eohci(&priv->ini);
 		} else if (priv->has_eohci) {
 			brcm_usb_uninit_eohci(&priv->ini);
-			clk_disable(priv->usb_20_clk);
+			clk_disable_unprepare(priv->usb_20_clk);
 		}
 		if (priv->phys[BRCM_USB_PHY_3_0].inited) {
 			brcm_usb_init_xhci(&priv->ini);
 		} else if (priv->has_xhci) {
 			brcm_usb_uninit_xhci(&priv->ini);
-			clk_disable(priv->usb_30_clk);
+			clk_disable_unprepare(priv->usb_30_clk);
 		}
 	} else {
 		if (priv->has_xhci)
@@ -419,8 +419,8 @@ static int brcm_usb_phy_resume(struct device *dev)
 		if (priv->has_eohci)
 			brcm_usb_uninit_eohci(&priv->ini);
 		brcm_usb_uninit_common(&priv->ini);
-		clk_disable(priv->usb_20_clk);
-		clk_disable(priv->usb_30_clk);
+		clk_disable_unprepare(priv->usb_20_clk);
+		clk_disable_unprepare(priv->usb_30_clk);
 	}
 
 	return 0;
-- 
2.17.1

