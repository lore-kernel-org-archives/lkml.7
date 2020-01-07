Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91849C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB2A20656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpgMidaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgAGSbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:31:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51827 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgAGSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:31:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so601467wmd.1;
        Tue, 07 Jan 2020 10:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0GZ/2btd9WbdeIHkXR9dqHVEEQVXHUGyMIYqGnC+II0=;
        b=VpgMidaYw8KNPWqbVfr/rT1197l8lSncVLRnCyqu0HB25M7EWRDP2y2wQk4B9l9hUN
         fHQBgGk4S4f7zSNc4G1qyqnwSy64wT8RKxmfI9qh6lAgEcpSEHq8MeTKevHr4/i3Mlw3
         fhqZfrKIwH5LjhD8svpQ6jcbbf08CFPGpCOPLqoIAxDp/T2FmaKZ3rx9I3+pa4RiHyHy
         tLNlVBtSycqe6/o1NkN/nX9T86WmiyoAYVjIX8znpBpXuYue8diWzrE7gzONKZU6Mqh4
         VnfMd2SesgPeSoJZswi/Q1X5JSoikQ5hTQqzm42I6k4igv6z6geNqHovx/sasbPJiZvK
         B3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0GZ/2btd9WbdeIHkXR9dqHVEEQVXHUGyMIYqGnC+II0=;
        b=JppY2tl/JGC08FDMNeLyOh1hPaOEDddXbwFblUeHyIdnHyS+XwT0PPaTMh0smg8bAO
         rr15CmQafJ18a1xY9ks05pC8sUva3zFXuMGnIsDQJsV8GJtjPPF4B/avG2Ky2eVBdKk8
         KCQV9EzrdiUFFX9tDwVj/QpMJf7xBNH3/gsiaxHmO5UvsAzoTyP5HNDrkmVaUqdwLn4u
         Fzg8Y+0cDl3VXNrusSGrMqp6vKtT7FWGh0DeDuukSm4xI0MF9EzveVTxoDFrVyUsdnMz
         LBHlfZva4eimOHxhEayMDpXfIQrY/KdOQYd0aKfaDBEli597pRVn3oNfsc26Mp4aYmqs
         p4Tw==
X-Gm-Message-State: APjAAAX8GLDLSwSFM6Jpko+e2+eKCipduxPkoTOaZ6C5YIU3hsSBsPMO
        F2cuMhrL0qMalNfIKAFCT7FWSE0y
X-Google-Smtp-Source: APXvYqzoRxm80vAgRUmtbZLOf/MZFA5ymUw5SZagpuUO7roaHGmZ71GirKkDje3/A2iDVa0Gbf9YMQ==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr439532wmb.42.1578421865537;
        Tue, 07 Jan 2020 10:31:05 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r6sm842764wrq.92.2020.01.07.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:31:04 -0800 (PST)
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
Subject: [PATCH v3 1/3] ata: ahci_brcm: Correct reset control API usage
Date:   Tue,  7 Jan 2020 10:30:20 -0800
Message-Id: <20200107183022.26224-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107183022.26224-1-f.fainelli@gmail.com>
References: <20200107183022.26224-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp provided suggestions on using the
devm_reset_control_get_optional_*() API such that checks against a NULL
or error reset control resource could be eliminated. In the process,
make sure that we also grab the BCM7216 reset control line using the
shared semantics, since the "rescal" reset fits that model.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 13ceca687104..718516fe6997 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -349,11 +349,10 @@ static int brcm_ahci_suspend(struct device *dev)
 	brcm_sata_phys_disable(priv);
 
 	ret = ahci_platform_suspend(dev);
+	if (ret)
+		return ret;
 
-	if (!IS_ERR_OR_NULL(priv->rcdev))
-		reset_control_assert(priv->rcdev);
-
-	return ret;
+	return reset_control_assert(priv->rcdev);
 }
 
 static int brcm_ahci_resume(struct device *dev)
@@ -363,8 +362,7 @@ static int brcm_ahci_resume(struct device *dev)
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
 	int ret = 0;
 
-	if (!IS_ERR_OR_NULL(priv->rcdev))
-		ret = reset_control_deassert(priv->rcdev);
+	ret = reset_control_deassert(priv->rcdev);
 	if (ret)
 		return ret;
 
@@ -425,7 +423,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
-	const char *reset_name = NULL;
 	struct brcm_ahci_priv *priv;
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
@@ -447,15 +444,21 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
-	/* Reset is optional depending on platform and named differently */
+	/* Reset is optional depending on platform and named differently
+	 * and of different kind (shared vs. exclusive)
+	 */
 	if (priv->version == BRCM_SATA_BCM7216)
-		reset_name = "rescal";
+		priv->rcdev = devm_reset_control_get_optional_shared(dev,
+								     "rescal");
 	else
-		reset_name = "ahci";
+		priv->rcdev = devm_reset_control_get_optional_exclusive(dev,
+									"ahci");
+	if (IS_ERR(priv->rcdev))
+		return PTR_ERR(priv->rcdev);
 
-	priv->rcdev = devm_reset_control_get(&pdev->dev, reset_name);
-	if (!IS_ERR_OR_NULL(priv->rcdev))
-		reset_control_deassert(priv->rcdev);
+	ret = reset_control_deassert(priv->rcdev);
+	if (ret)
+		return ret;
 
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv)) {
@@ -519,8 +522,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 out_disable_clks:
 	ahci_platform_disable_clks(hpriv);
 out_reset:
-	if (!IS_ERR_OR_NULL(priv->rcdev))
-		reset_control_assert(priv->rcdev);
+	reset_control_assert(priv->rcdev);
 	return ret;
 }
 
-- 
2.17.1

