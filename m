Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C0CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2207E2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J99n2bWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfLJNXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:23:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46312 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJNXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:23:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so19982090wrl.13;
        Tue, 10 Dec 2019 05:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jJrtiyNSy3kb+yNwZbjKaE7PnY4m0t7haj0Vxh+WdWs=;
        b=J99n2bWznpxOP6+vsSZXrEr6p/rw1T5xKdv3U2W6e9//RNmPZtPXfD62u24G8E+C/7
         XtwiqCDRNhXLmsDBiHVkU4zNSkopGxxHRzkWHwqzVKWhux6HNd5FHIAgUjenIZeY0JEI
         TEVAlO4ktkiqYCmQDqZWXC0pDNAxCtdluBOXIMlXO8nr/QZXaYHKZgUCAF5qKF6kxAdD
         W+ocHC6CEtPkTlYlFIIkMX9ehfWN4VmWo8PKArMUcj9fYSlTTU7E7BgbBk0wmP885JT4
         00t12Pn0vbf8l+ToQpMqZAE9ZZt9OdQw6PnhCP0gcwxlHchMrexSZ/445YuFgG/f1qQP
         CP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jJrtiyNSy3kb+yNwZbjKaE7PnY4m0t7haj0Vxh+WdWs=;
        b=auTeupwX/67CQ0tGq7yTjQ2wCOcmtSA/3DpcKjrvXPq0QIsPg6v+zUw/bz264XVEp8
         eIBTc4tfPs+gMV3GU9dGWbv86cTIaFFqiN1LKvwM0COhag3K7PaTPd5igp2jMaEL81Pd
         TpJ6x+gxJK2tYiO37AwREWP3RxGN8rysst4QoFAiHrCPTIBsJc6sF/lE0Ep3p9kqwLUo
         tFgA0uN159DuT2O6il6M9g1JvA3U3TOnqvAzSyP8xboVh7xqqnCvIr8sbH7TfSs0vl0b
         Z+8w6saP5zqYIzcvtBB9vHQzdK42/myAS+W9XHrDNPYAVrtdTqZLiD2tUTSeQITtfcpD
         psvw==
X-Gm-Message-State: APjAAAUBawExN1dnjvWrLNaTZWuXYt8U9O2WSSz5kSRnNUHP4m2c8cec
        kWcGiC5IHq9SSE6SY1lsyG9+7sa9RRc=
X-Google-Smtp-Source: APXvYqzCXFiEb3ot8a+PusJOfCQFFN49/7xqDziU6xgfwuaj+jEQc3h7lpRtk7Dxa6zdush/Y6vt4g==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr190439wrv.364.1575984211923;
        Tue, 10 Dec 2019 05:23:31 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s82sm3101680wms.28.2019.12.10.05.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:23:31 -0800 (PST)
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
Subject: [PATCH v3 02/13] phy: usb: Get all drivers that use USB clks using correct enable/disable
Date:   Tue, 10 Dec 2019 08:21:21 -0500
Message-Id: <20191210132132.41509-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210132132.41509-1-alcooperx@gmail.com>
References: <20191210132132.41509-1-alcooperx@gmail.com>
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

