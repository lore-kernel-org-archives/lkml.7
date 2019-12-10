Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9078AC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD6D206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9wc8jLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfLJSzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:55:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53212 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfLJSzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:55:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so4435726wmc.2;
        Tue, 10 Dec 2019 10:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CRurCQdrocGByZZOTcTs+t52NdkK2rxu325DNj2DL14=;
        b=h9wc8jLDY7ZAr9Ao2dUV23e66wAhTIL9bnacfjjZ5gAes6VnJq+8j5lUOmkqNhtni0
         JjkJr9hwnO7/d5SBxfInvbQCV5V/UQcY8UtwnlnV6BsKlbWPcP9Xtnka9vZ6egqCQeYx
         yY4BLBlluzX5fwaQ6xDrjw6cKk8Z96GKg1CZ23WqU1zCrn/1hQbqcMImnK7uxOm/x9uI
         kGv9zNllpuZy1atLkTg20bs9pfOIhXJja7ytSFeciYlOfgOvGH8ewy9UjVLh4ScY96jZ
         dUsDFEEoBLGe2j6IjWYFB1wWUWbd/XdshnI0nNiG0SB+NrMmwcLXBiquSK/MoRwSxDUb
         S/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CRurCQdrocGByZZOTcTs+t52NdkK2rxu325DNj2DL14=;
        b=K208aQ+IHXq3HIIbaTWPGrRCgA4qxPWDs8wN1Qxcdq+/RLVOPBMhichOF5qL+QhD7U
         7iLZotJzw4emxbyrWNbBAlUP4fF7k9X7u5OqYk+q266v3umIN++97MiFdaVbqMIWGCtU
         bzTLiMHyUaJ0Xj7DWM4Ce1GbMtsitNMj8bQBkvJ+ywAsLWl4SS1wuckhuh2Rf0L5T73/
         lc0JgnWlKj60TFso88T4TBcigF/IHIRC3j6jEtTZSj9sLdSgjnQaiuE5Nl88PW7SDetz
         NigSIR7X9P8/ErmTj2ibKfZwD1xugUitOG7LAtIy37QnqL3Kzz3vy+2RbPVWQV/2e7v+
         /xfQ==
X-Gm-Message-State: APjAAAX/1277E5FxzzDfeg8IeWzII4lberBbta93qVSN3P8Gr0PJgsEm
        N2BzNoaetYW9Ke/Qlfd5GqaGh7Qz
X-Google-Smtp-Source: APXvYqzt4afRTFJniNMXUdIgvGArprtvCwHTScxy032uM1j7UyHEUh5nkHYmBczc5bCFgGJg8D9xyg==
X-Received: by 2002:a05:600c:2144:: with SMTP id v4mr7240215wml.31.1576004116175;
        Tue, 10 Dec 2019 10:55:16 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e6sm4213536wru.44.2019.12.10.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:55:15 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 2/8] ata: ahci_brcm: Fix AHCI resources management
Date:   Tue, 10 Dec 2019 10:53:45 -0800
Message-Id: <20191210185351.14825-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210185351.14825-1-f.fainelli@gmail.com>
References: <20191210185351.14825-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AHCI resources management within ahci_brcm.c is a little
convoluted, largely because it historically had a dedicated clock that
was managed within this file in the downstream tree. Once brough
upstream though, the clock was left to be managed by libahci_platform.c
which is entirely appropriate.

This patch series ensures that the AHCI resources are fetched and
enabled before any register access is done, thus avoiding bus errors on
platforms which clock gate the controller by default.

As a result we need to re-arrange the suspend() and resume() functions
in order to avoid accessing registers after the clocks have been turned
off respectively before the clocks have been turned on. Finally, we can
refactor brcm_ahci_get_portmask() in order to fetch the number of ports
from hpriv->mmio which is now accessible without jumping through hoops
like we used to do.

The commit pointed in the Fixes tag is both old and new enough not to
require major headaches for backporting of this patch.

Fixes: eba68f829794 ("ata: ahci_brcmstb: rename to support across Broadcom SoC's")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 105 +++++++++++++++++++++++++++++-----------
 1 file changed, 76 insertions(+), 29 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index f41744b9b38a..a8b2f3f7bbbc 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -213,19 +213,12 @@ static void brcm_sata_phys_disable(struct brcm_ahci_priv *priv)
 			brcm_sata_phy_disable(priv, i);
 }
 
-static u32 brcm_ahci_get_portmask(struct platform_device *pdev,
+static u32 brcm_ahci_get_portmask(struct ahci_host_priv *hpriv,
 				  struct brcm_ahci_priv *priv)
 {
-	void __iomem *ahci;
-	struct resource *res;
 	u32 impl;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci");
-	ahci = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(ahci))
-		return 0;
-
-	impl = readl(ahci + HOST_PORTS_IMPL);
+	impl = readl(hpriv->mmio + HOST_PORTS_IMPL);
 
 	if (fls(impl) > SATA_TOP_MAX_PHYS)
 		dev_warn(priv->dev, "warning: more ports than PHYs (%#x)\n",
@@ -233,9 +226,6 @@ static u32 brcm_ahci_get_portmask(struct platform_device *pdev,
 	else if (!impl)
 		dev_info(priv->dev, "no ports found\n");
 
-	devm_iounmap(&pdev->dev, ahci);
-	devm_release_mem_region(&pdev->dev, res->start, resource_size(res));
-
 	return impl;
 }
 
@@ -347,11 +337,10 @@ static int brcm_ahci_suspend(struct device *dev)
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
-	int ret;
 
-	ret = ahci_platform_suspend(dev);
 	brcm_sata_phys_disable(priv);
-	return ret;
+
+	return ahci_platform_suspend(dev);
 }
 
 static int brcm_ahci_resume(struct device *dev)
@@ -359,11 +348,44 @@ static int brcm_ahci_resume(struct device *dev)
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
+	int ret;
+
+	/* Make sure clocks are turned on before re-configuration */
+	ret = ahci_platform_enable_clks(hpriv);
+	if (ret)
+		return ret;
 
 	brcm_sata_init(priv);
 	brcm_sata_phys_enable(priv);
 	brcm_sata_alpm_init(hpriv);
-	return ahci_platform_resume(dev);
+
+	/* Since we had to enable clocks earlier on, we cannot use
+	 * ahci_platform_resume() as-is since a second call to
+	 * ahci_platform_enable_resources() would bump up the resources
+	 * (regulators, clocks, PHYs) count artificially so we copy the part
+	 * after ahci_platform_enable_resources().
+	 */
+	ret = ahci_platform_enable_phys(hpriv);
+	if (ret)
+		goto out_disable_phys;
+
+	ret = ahci_platform_resume_host(dev);
+	if (ret)
+		goto out_disable_platform_phys;
+
+	/* We resumed so update PM runtime state */
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+
+out_disable_platform_phys:
+	ahci_platform_disable_phys(hpriv);
+out_disable_phys:
+	brcm_sata_phys_disable(priv);
+	ahci_platform_disable_clks(hpriv);
+	return ret;
 }
 #endif
 
@@ -416,38 +438,63 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		priv->quirks |= BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE;
 	}
 
+	hpriv = ahci_platform_get_resources(pdev, 0);
+	if (IS_ERR(hpriv)) {
+		ret = PTR_ERR(hpriv);
+		goto out_reset;
+	}
+
+	ret = ahci_platform_enable_clks(hpriv);
+	if (ret)
+		goto out_reset;
+
+	/* Must be first so as to configure endianness including that
+	 * of the standard AHCI register space.
+	 */
 	brcm_sata_init(priv);
 
-	priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
-	if (!priv->port_mask)
-		return -ENODEV;
+	/* Initializes priv->port_mask which is used below */
+	priv->port_mask = brcm_ahci_get_portmask(hpriv, priv);
+	if (!priv->port_mask) {
+		ret = -ENODEV;
+		goto out_disable_clks;
+	}
 
+	/* Must be done before ahci_platform_enable_phys() */
 	brcm_sata_phys_enable(priv);
 
-	hpriv = ahci_platform_get_resources(pdev, 0);
-	if (IS_ERR(hpriv))
-		return PTR_ERR(hpriv);
 	hpriv->plat_data = priv;
 	hpriv->flags = AHCI_HFLAG_WAKE_BEFORE_STOP;
 
 	brcm_sata_alpm_init(hpriv);
 
-	ret = ahci_platform_enable_resources(hpriv);
-	if (ret)
-		return ret;
-
 	if (priv->quirks & BRCM_AHCI_QUIRK_NO_NCQ)
 		hpriv->flags |= AHCI_HFLAG_NO_NCQ;
 	hpriv->flags |= AHCI_HFLAG_NO_WRITE_TO_RO;
 
+	ret = ahci_platform_enable_phys(hpriv);
+	if (ret)
+		goto out_disable_phys;
+
 	ret = ahci_platform_init_host(pdev, hpriv, &ahci_brcm_port_info,
 				      &ahci_platform_sht);
 	if (ret)
-		return ret;
+		goto out_disable_platform_phys;
 
 	dev_info(dev, "Broadcom AHCI SATA3 registered\n");
 
 	return 0;
+
+out_disable_platform_phys:
+	ahci_platform_disable_phys(hpriv);
+out_disable_phys:
+	brcm_sata_phys_disable(priv);
+out_disable_clks:
+	ahci_platform_disable_clks(hpriv);
+out_reset:
+	if (!IS_ERR_OR_NULL(priv->rcdev))
+		reset_control_assert(priv->rcdev);
+	return ret;
 }
 
 static int brcm_ahci_remove(struct platform_device *pdev)
@@ -457,12 +504,12 @@ static int brcm_ahci_remove(struct platform_device *pdev)
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
 	int ret;
 
+	brcm_sata_phys_disable(priv);
+
 	ret = ata_platform_remove_one(pdev);
 	if (ret)
 		return ret;
 
-	brcm_sata_phys_disable(priv);
-
 	return 0;
 }
 
-- 
2.17.1

