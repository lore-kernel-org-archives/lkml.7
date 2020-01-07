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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5C0C33CA2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7A820656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yafxffao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgAGSbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:31:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32820 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgAGSbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:31:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so14782951wmd.0;
        Tue, 07 Jan 2020 10:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0F4Kd5Ywhqg4TZ9Cg5D+47SboN/4h4Ft84pZMAsNlKo=;
        b=YafxffaoqkeQGIPgQKSLZv7Ponlme3Bk0WVdm20udVQUIgs0xAsxF0mmMa7fZd4G5K
         Uhb0TxGXUnj4YS5k5vnpcqgKb9J3R5CIDOG4pS6bxXNa8guBkL7GqiluFnnuOI4epULH
         VU5cW5Cnk0UL8VtrLN3KQaQQU3um2nv3/K/ZfwbvUnIMGSg7Hb8MMyc4lFU9ekUO/wUE
         2o3lkceF2HTYw3oBjPZjqDjeXpd9BRPrZhTCf6Sm3oox7oCLbI9Kcx+ROSjdGHQLtNSi
         EHH8UYd4qf+w1JYsZabXeRDAa4AsDjSF+syE3hs/pR0XOT5LXhWFJ9rHHcDqrLS/cswu
         GcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0F4Kd5Ywhqg4TZ9Cg5D+47SboN/4h4Ft84pZMAsNlKo=;
        b=F4OM55/02TCqr1CWQ8h2n03IpiULDmxLJZEZDfuykWFHwUnPPcLNpFBtlO5T4PPiBE
         snBEis+PF/YYtWiZ/0FWWo5Pn4CDTCiMUOhC5p22WlJB2uhZLa1c7MCV7P8UjIZtMymO
         Hjx4k0AWTiexwBH08jQRPMfOMf8OsknlgVz3Bkvl+g39GCaGu2ESj96I8y85oHkJoWqQ
         QDvOiXzVuLfD8iEi0IqV9XlF9FVt/MCOYJDAq22VGvFCNKRnLNqGx46roTtNWHC/iKpZ
         1mX0FOXXrb9mHSjdLf4eE1hM8Da+tGd4BnVp+eyvIVu4JTZDnfePBcZhw/SUuJb9a9Lq
         ZFKA==
X-Gm-Message-State: APjAAAWcx+YIlSLxLwN65/rM+R1fgGXvTf/8HBORjKFmMNU/xZm0t0fr
        TP8vazfxU0rNI+h1N8IHvRerMBgU
X-Google-Smtp-Source: APXvYqxGPnpDm3ovMwAlFLSA5Y2lqNnDLtsjmBX4mk+5yIqPHrHdUCu55+wEtDsvnBpPB5ovF5GVXw==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr382380wmb.76.1578421871534;
        Tue, 07 Jan 2020 10:31:11 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r6sm842764wrq.92.2020.01.07.10.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:31:10 -0800 (PST)
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
Subject: [PATCH v3 3/3] ata: ahci_brcm: BCM7216 reset is self de-asserting
Date:   Tue,  7 Jan 2020 10:30:22 -0800
Message-Id: <20200107183022.26224-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107183022.26224-1-f.fainelli@gmail.com>
References: <20200107183022.26224-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM7216 reset controller line is self-deasserting, unlike other
platforms, so make use of reset_control_reset() instead of
reset_control_deassert().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index c229fea39a47..62c948e56beb 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -352,7 +352,10 @@ static int brcm_ahci_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	return reset_control_assert(priv->rcdev);
+	if (priv->version != BRCM_SATA_BCM7216)
+		ret = reset_control_assert(priv->rcdev);
+
+	return ret;
 }
 
 static int brcm_ahci_resume(struct device *dev)
@@ -362,7 +365,10 @@ static int brcm_ahci_resume(struct device *dev)
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
 	int ret = 0;
 
-	ret = reset_control_deassert(priv->rcdev);
+	if (priv->version == BRCM_SATA_BCM7216)
+		ret = reset_control_reset(priv->rcdev);
+	else
+		ret = reset_control_deassert(priv->rcdev);
 	if (ret)
 		return ret;
 
@@ -475,7 +481,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		break;
 	}
 
-	ret = reset_control_deassert(priv->rcdev);
+	if (priv->version == BRCM_SATA_BCM7216)
+		ret = reset_control_reset(priv->rcdev);
+	else
+		ret = reset_control_deassert(priv->rcdev);
 	if (ret)
 		return ret;
 
@@ -520,7 +529,8 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 out_disable_clks:
 	ahci_platform_disable_clks(hpriv);
 out_reset:
-	reset_control_assert(priv->rcdev);
+	if (priv->version != BRCM_SATA_BCM7216)
+		reset_control_assert(priv->rcdev);
 	return ret;
 }
 
-- 
2.17.1

