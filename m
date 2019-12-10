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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295B2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001DA20836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZysT5SpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfLJSzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:55:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37931 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfLJSzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:55:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so21339577wrh.5;
        Tue, 10 Dec 2019 10:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ussfTu+qKekY3R6LJaAGiwDCkgbbShyh4zMKrgN/Il4=;
        b=ZysT5SpUotNYb5GYyIEszS8bGySuyYzY701iBr/aCI9ZdADa1AhiIuRlR6qlBY7joC
         DF9KGVC2KRnmx8lum6fNXSWjD6AuSGXvfJ4H3Vx5ueWtWXsikx3SG8TKmZZajTmQ3jrB
         SugBoxSgvsEtcNySPIT6hwq7NbMgzJE2bzym/YJFJ41ZKM6M7gyQzbK3iTxmgjkzjRwJ
         38ykf8C6RFUB1PMF7asZPrAoK/83I+gfi7Z+ZQFKUqUpEYtfSBLy8KUfbXhaHXmOEMxL
         bXfremNGmyq2gPv2EJiHBsRPGYkmfrVmKvY0TZ9bPy1CuhPZRYT6MWRMNy3jxYu9MH0+
         29qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ussfTu+qKekY3R6LJaAGiwDCkgbbShyh4zMKrgN/Il4=;
        b=fl/3PNerx/hOT48mXLgUxKHQ6o6wyItMV6OGp5ruTo+3qq2kDbcTq/39rF0HbDeoVy
         1B4crKt1uVAvCAB9a7FbY+evQiIWCaogxnoZUu5PEKR2EsYhxbdszKNifpcnHUi1X6oD
         LwYtlZr8dbdLk5m2Ca2Wfkq35uYMK8OeHzUyofn1oH9+c4x+PRdLB10Wjj/Xewc2Fdyx
         2MTp6k1MChBrvgzOMwGXSemmh8blnO0g60vB6KzpsTkN8LmecSGIxGqrMuccL/vkOymc
         pphreDFS/p8mfpq1vGn/hKl2Un9gUSk6it+Lwv5T3HcoOoXmO8bFRHOo0Jm6aT46kaDq
         8ARA==
X-Gm-Message-State: APjAAAW+eyjxhPikcv2VTs/YFDEYdcUl3MlKjcalJugZXGYMbWK7lfP3
        n5Dre5laz09qb4P8nr2Vv+18MSwp
X-Google-Smtp-Source: APXvYqzp9OKkCMvVkNYUpQHqFNRAz4mVpSPT9zH+WehxDqqalY+Oqd9MwOyTQX92PLdQymbuneaCEQ==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr4767236wrm.324.1576004119205;
        Tue, 10 Dec 2019 10:55:19 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e6sm4213536wru.44.2019.12.10.10.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:55:18 -0800 (PST)
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
Subject: [PATCH 3/8] ata: ahci_brcm: BCM7425 AHCI requires AHCI_HFLAG_DELAY_ENGINE
Date:   Tue, 10 Dec 2019 10:53:46 -0800
Message-Id: <20191210185351.14825-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210185351.14825-1-f.fainelli@gmail.com>
References: <20191210185351.14825-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set AHCI_HFLAG_DELAY_ENGINE for the BCM7425 AHCI controller thus making
it conforming to the 'strict' AHCI implementation which this controller
is based on.

This solves long link establishment with specific hard drives (e.g.:
Seagate ST1000VM002-9ZL1 SC12) that would otherwise have to complete the
error recovery handling before finally establishing a succesful SATA
link at the desired speed.

We re-order the hpriv->flags assignment to also remove the NONCQ quirk
since we can set the flag directly.

Fixes: 9586114cf1e9 ("ata: ahci_brcmstb: add support MIPS-based platforms")
Fixes: 423be77daabe ("ata: ahci_brcmstb: add quirk for broken ncq")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index a8b2f3f7bbbc..58f8fd7bb8b8 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -76,8 +76,7 @@ enum brcm_ahci_version {
 };
 
 enum brcm_ahci_quirks {
-	BRCM_AHCI_QUIRK_NO_NCQ		= BIT(0),
-	BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE	= BIT(1),
+	BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE	= BIT(0),
 };
 
 struct brcm_ahci_priv {
@@ -432,18 +431,27 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (!IS_ERR_OR_NULL(priv->rcdev))
 		reset_control_deassert(priv->rcdev);
 
-	if ((priv->version == BRCM_SATA_BCM7425) ||
-		(priv->version == BRCM_SATA_NSP)) {
-		priv->quirks |= BRCM_AHCI_QUIRK_NO_NCQ;
-		priv->quirks |= BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE;
-	}
-
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv)) {
 		ret = PTR_ERR(hpriv);
 		goto out_reset;
 	}
 
+	hpriv->plat_data = priv;
+	hpriv->flags = AHCI_HFLAG_WAKE_BEFORE_STOP | AHCI_HFLAG_NO_WRITE_TO_RO;
+
+	switch (priv->version) {
+	case BRCM_SATA_BCM7425:
+		hpriv->flags |= AHCI_HFLAG_DELAY_ENGINE;
+		/* fall through */
+	case BRCM_SATA_NSP:
+		hpriv->flags |= AHCI_HFLAG_NO_NCQ;
+		priv->quirks |= BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE;
+		break;
+	default:
+		break;
+	}
+
 	ret = ahci_platform_enable_clks(hpriv);
 	if (ret)
 		goto out_reset;
@@ -463,15 +471,8 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	/* Must be done before ahci_platform_enable_phys() */
 	brcm_sata_phys_enable(priv);
 
-	hpriv->plat_data = priv;
-	hpriv->flags = AHCI_HFLAG_WAKE_BEFORE_STOP;
-
 	brcm_sata_alpm_init(hpriv);
 
-	if (priv->quirks & BRCM_AHCI_QUIRK_NO_NCQ)
-		hpriv->flags |= AHCI_HFLAG_NO_NCQ;
-	hpriv->flags |= AHCI_HFLAG_NO_WRITE_TO_RO;
-
 	ret = ahci_platform_enable_phys(hpriv);
 	if (ret)
 		goto out_disable_phys;
-- 
2.17.1

