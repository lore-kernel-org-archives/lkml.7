Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE1AC3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA31C21881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567444955;
	bh=YjO1uTJm2Cze6wF4H+o+shlYdgkYcUd6ReFeG/yso/U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pQo+WKWPGa+rHHAICrmqWqEYW/CGolFPWvxS5YE1vckdIsPk+QM1E2sU3MfQqukSM
	 Z4UgjjBY/TIoRJni10/SBDoJ92PSedJtwWaLCksI/Vr1NvfImQbxzxtMx4KJmhTL74
	 4nrIw2v6nqm5/xafI+EH4ttOPQLAGodlP3V5rO00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfIBRWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 13:22:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42456 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfIBRWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ge4iDkVXLJAE0tqMDUvKSuDj6sip/kNFFFYp4OhwDS4=; b=i0CMNhgrLirnfNGlywpG5eJSA
        RQdtBob8zHVzDgM5/+ggJ6fkWt+1KC1FVc0g7K5V7iVEJ0/LDsvtOiKbTl8ZKU491Of/Z2BUe67s0
        1a6nYD1guVqtOY3V4GqtyMD53SdfkjTJwZSOWxOhFNhoIBWmQT0zhGpVatc3dkRvg2F8U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i4q29-0003rT-P9; Mon, 02 Sep 2019 17:22:29 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 047D92742CB7; Mon,  2 Sep 2019 18:22:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] ata: libahci_platform: Fix regulator_get_optional() misuse
Date:   Mon,  2 Sep 2019 18:22:24 +0100
Message-Id: <20190902172224.49989-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is using regulator_get_optional() to handle all the supplies
that it handles, and only ever enables and disables all supplies en masse
without ever doing any other configuration of the device to handle missing
power. These are clear signs that the API is being misused - it should only
be used for supplies that may be physically absent from the system and in
these cases the hardware usually needs different configuration if the
supply is missing. Instead use normal regualtor_get(), if the supply is
not described in DT then the framework will substitute a dummy regulator in
so no special handling is needed by the consumer driver.

In the case of the PHY regulator the handling in the driver is a hack to
deal with integrated PHYs; the supplies are only optional in the sense
that that there's some confusion in the code about where they're bound to.
From a code point of view they function exactly as normal supplies so can
be treated as such. It'd probably be better to model this by instantiating
a PHY object for integrated PHYs.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/ata/libahci_platform.c | 38 +++++++++++++---------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 9e9583a6bba9..57882b3e46eb 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -153,17 +153,13 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 {
 	int rc, i;
 
-	if (hpriv->ahci_regulator) {
-		rc = regulator_enable(hpriv->ahci_regulator);
-		if (rc)
-			return rc;
-	}
+	rc = regulator_enable(hpriv->ahci_regulator);
+	if (rc)
+		return rc;
 
-	if (hpriv->phy_regulator) {
-		rc = regulator_enable(hpriv->phy_regulator);
-		if (rc)
-			goto disable_ahci_pwrs;
-	}
+	rc = regulator_enable(hpriv->phy_regulator);
+	if (rc)
+		goto disable_ahci_pwrs;
 
 	for (i = 0; i < hpriv->nports; i++) {
 		if (!hpriv->target_pwrs[i])
@@ -181,11 +177,9 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 		if (hpriv->target_pwrs[i])
 			regulator_disable(hpriv->target_pwrs[i]);
 
-	if (hpriv->phy_regulator)
-		regulator_disable(hpriv->phy_regulator);
+	regulator_disable(hpriv->phy_regulator);
 disable_ahci_pwrs:
-	if (hpriv->ahci_regulator)
-		regulator_disable(hpriv->ahci_regulator);
+	regulator_disable(hpriv->ahci_regulator);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_platform_enable_regulators);
@@ -207,10 +201,8 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 		regulator_disable(hpriv->target_pwrs[i]);
 	}
 
-	if (hpriv->ahci_regulator)
-		regulator_disable(hpriv->ahci_regulator);
-	if (hpriv->phy_regulator)
-		regulator_disable(hpriv->phy_regulator);
+	regulator_disable(hpriv->ahci_regulator);
+	regulator_disable(hpriv->phy_regulator);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
 /**
@@ -359,7 +351,7 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
 	struct regulator *target_pwr;
 	int rc = 0;
 
-	target_pwr = regulator_get_optional(dev, "target");
+	target_pwr = regulator_get(dev, "target");
 
 	if (!IS_ERR(target_pwr))
 		hpriv->target_pwrs[port] = target_pwr;
@@ -436,16 +428,14 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		hpriv->clks[i] = clk;
 	}
 
-	hpriv->ahci_regulator = devm_regulator_get_optional(dev, "ahci");
+	hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
 	if (IS_ERR(hpriv->ahci_regulator)) {
 		rc = PTR_ERR(hpriv->ahci_regulator);
-		if (rc == -EPROBE_DEFER)
+		if (rc != 0)
 			goto err_out;
-		rc = 0;
-		hpriv->ahci_regulator = NULL;
 	}
 
-	hpriv->phy_regulator = devm_regulator_get_optional(dev, "phy");
+	hpriv->phy_regulator = devm_regulator_get(dev, "phy");
 	if (IS_ERR(hpriv->phy_regulator)) {
 		rc = PTR_ERR(hpriv->phy_regulator);
 		if (rc == -EPROBE_DEFER)
-- 
2.20.1

