Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A5BC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDB321882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9JW8wP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389282AbfKGOOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:14:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45206 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389032AbfKGOOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:14:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id h3so3142392wrx.12;
        Thu, 07 Nov 2019 06:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jJrtiyNSy3kb+yNwZbjKaE7PnY4m0t7haj0Vxh+WdWs=;
        b=Y9JW8wP9W+IFZEpWOUhVm/ZPvcRMqX7PvtHXnXU4Bn5ZZ86gl7lPorZ+hmOTjh0A0q
         g+C8SuBIbMaST8Z9VJaEftK7airFcEnG9O80LnF6JmaixVSWpSKUHhITeg2ZYNbuIDfn
         VZ0RLCbreX9R73b5lxtsSIhZhM8S5xUrk1xTzThPc/SGO8Gn+vs7C6nTkwnhOmLdLmwE
         2RJgjPT5kxAaZik2I64PhT+aPplrXjQ7gW71EFBLUwDcgEP21N9oaJ85S9BI9eCC64jn
         eF5zG4GQ1gsfFCNGXHHQc7uswkBuJao+v7ZES5r0NvxgXsb+RWleEOF09FPDtMqcLIWg
         NoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jJrtiyNSy3kb+yNwZbjKaE7PnY4m0t7haj0Vxh+WdWs=;
        b=gZkGscCbUYSS4aVA5pPKmw/cKgjgOBxMOVokWEPZqs9qkpINjprzYLpszdQsXyelrQ
         mt0IjQ1pC1xqaT8FzR0RZu6IgzlhCIWpgs0Ks8kbAKC+O117MZyDs2SAhFsYDEQMHIQ0
         8zuFj6Nv582OPr1hqTafFwdy/nd6yP+hN4uE0rmcQAxvuQCVsaPesLSwMYICxNwdqTzf
         RotbkD7xgGoLi8dXPTPjrNhFKrm4TjLPpuuJ6OfeOWit3tF5ZVDe64GsStySidXTnnVL
         4HxB0m0mL0SBqJ44ZhsNOIf37CjQgaACX0ZzO4zLQ8QuvU3PE8qvUXm41c926DGNaU5r
         d6pw==
X-Gm-Message-State: APjAAAXNebEDCfs4uIcAAcdFiaNafyOoj32n2FE9lqmzipO8BUqVk1v/
        +kMKHQ2RIy2+eC/pzmTilfm8c08Ypss=
X-Google-Smtp-Source: APXvYqwMC+dBjA1Eh7nYkghxI0uwlR/XbvlmAAs3xEneI5YNbsov/hJZ9dYQDcaZ4kIB0WWZDa3v7w==
X-Received: by 2002:adf:a31a:: with SMTP id c26mr2988352wrb.330.1573136072139;
        Thu, 07 Nov 2019 06:14:32 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b1sm2453888wrw.77.2019.11.07.06.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:14:31 -0800 (PST)
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
Subject: [PATCH 02/13] phy: usb: Get all drivers that use USB clks using correct enable/disable
Date:   Thu,  7 Nov 2019 09:13:28 -0500
Message-Id: <20191107141339.6079-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107141339.6079-1-alcooperx@gmail.com>
References: <20191107141339.6079-1-alcooperx@gmail.com>
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

