Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D9FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCAD2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJjV5yjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfGVS74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:59:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42931 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfGVS7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:59:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so17807021pff.9;
        Mon, 22 Jul 2019 11:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gER2LLimplLra53LgK/rnRcfXZIC+CQ7D3TqLh+KSw=;
        b=pJjV5yjMe02NhQ3bEXBOGJ6gbi/w396J1CJqb/pC8BkzUjSnxK0ShHcCjRDGUnMGwD
         zJuAwDy++CHBprRUYbUjeZFMvsBpV++VRfjlvTbihaoWDqxGBWT9ah8WfraLzFa/X+H5
         y75ii/JdnvxE7UY4/FCUrPJqfPyRW/JIzE0IFx/lhjGforNYO9T3JQTCroJD4n6MlqOC
         hZV4nmFTHdaBmM2cHRMm6yr2Gcl/6KmPw92h7BNdI649e8AowRhsrzh/akHYkdQy1kwa
         Hliwuq9C5dOx1EoV2MfFPt65vvxU9tTlYLQXQ+E7bSN8IxfO5bxLtPfDh00Ww+fDcHba
         9NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gER2LLimplLra53LgK/rnRcfXZIC+CQ7D3TqLh+KSw=;
        b=XrlZrQ6OQkPPkqSkWscp1iB6XhRVmhPQrDOkNiwX2vq/4su6B0FOnBXgAiA5kCCsq9
         zWbUQCw6U2p1dpEPBZkjllJ2DR0zwL9IWkZh06P43qQgj6yvU3Si9dyHgLTdSjMCfJ5U
         SNfksR/rRGcRDLVJKOzLyCjHUNz0bI7Eoccqe4+KJU4b/zvGeS/jqLAbIg9A143Wxw/y
         efTduIBKvDj+WRNfZqKde72XwVZKXUlPdkyRVCfu0at3eswbccGsFg+zOS3FEaxd5frB
         YwirAqiDSoiYZ68z24zodGfkrc3+XL6iGWTCGrqwrkYUw0q8VMVIYAbH1yVPCwMh56Cs
         Tbgg==
X-Gm-Message-State: APjAAAUWjN4bngxat3eB5UX91vmeFMjdG9OZn3svyuWdJcMMZe9A2GxB
        N3Mg1LQwX0Ucn7BoQzd3IV2d0JlOa/w=
X-Google-Smtp-Source: APXvYqz+z95RCeo9mRoNfWnHGolQodU0RqnIuj6kGs1oNVW/IeXDDkxoMFwG1vGy/N2WBXyK9jW2ww==
X-Received: by 2002:a63:7a06:: with SMTP id v6mr73572823pgc.115.1563821992488;
        Mon, 22 Jul 2019 11:59:52 -0700 (PDT)
Received: from localhost.localdomain ([103.51.73.174])
        by smtp.gmail.com with ESMTPSA id h1sm30777675pgv.93.2019.07.22.11.59.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:59:52 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC/RFT 2/5] phy: exynos5-usbdrd: add missing tuning of the phyutmi signal
Date:   Tue, 23 Jul 2019 00:29:35 +0530
Message-Id: <20190722185938.9043-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722185938.9043-1-linux.amoon@gmail.com>
References: <20190722185938.9043-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing tuning of phyutmi controls to enter suspend and
resume state.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 32 ++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 3c14bf7718c1..135114d51bc1 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -42,7 +42,13 @@
 
 #define EXYNOS5_DRD_PHYUTMI			0x08
 
+#define PHYUTMI_TXBITSTUFFENH			BIT(8)
+#define PHYUTMI_TXBITSTUFFEN			BIT(7)
 #define PHYUTMI_OTGDISABLE			BIT(6)
+#define PHYUTMI_IDPULLUP			BIT(5)
+#define PHYUTMI_DRVVBUS				BIT(4)
+#define PHYUTMI_DPPULLDOWN                      BIT(3)
+#define PHYUTMI_DMPULLDOWN                      BIT(2)
 #define PHYUTMI_FORCESUSPEND			BIT(1)
 #define PHYUTMI_FORCESLEEP			BIT(0)
 
@@ -402,6 +408,23 @@ static int exynos5_usbdrd_phy_init(struct phy *phy)
 		LINKSYSTEM_FLADJ(0x20);
 	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_LINKSYSTEM);
 
+	reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYUTMI);
+	/* High-Byte Transmit Bit-Stuffing Enable */
+	reg |= PHYUTMI_TXBITSTUFFENH;
+	/* Low-Byte Transmit Bit-Stuffing Enable */
+	reg |= PHYUTMI_TXBITSTUFFEN;
+	/* release force_sleep & force_suspend */
+	reg &= ~(PHYUTMI_FORCESLEEP | PHYUTMI_FORCESUSPEND);
+	/* DP/DM Pull Down Disable */
+	reg &= ~(PHYUTMI_DMPULLDOWN | PHYUTMI_DPPULLDOWN);
+	/* drvvbus controller signal controls the VBUS valid comparator */
+	reg &= ~PHYUTMI_OTGDISABLE;
+	/* controller signal controls the VBUS Valid comparator */
+	reg |= PHYUTMI_DRVVBUS;
+	/* Enable ID Sampling */
+	reg |= PHYUTMI_IDPULLUP;
+	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYUTMI);
+
 	reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM0);
 	/* Select PHY CLK source */
 	reg &= ~PHYPARAM0_REF_USE_PAD;
@@ -452,9 +475,14 @@ static int exynos5_usbdrd_phy_exit(struct phy *phy)
 	if (ret)
 		return ret;
 
-	reg =	PHYUTMI_OTGDISABLE |
+	reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYUTMI);
+	reg |=	PHYUTMI_OTGDISABLE |
 		PHYUTMI_FORCESUSPEND |
-		PHYUTMI_FORCESLEEP;
+		PHYUTMI_FORCESLEEP |
+		PHYUTMI_DMPULLDOWN |
+		PHYUTMI_DPPULLDOWN;
+	reg &= ~(PHYUTMI_DRVVBUS | PHYUTMI_IDPULLUP |
+		PHYUTMI_TXBITSTUFFENH | PHYUTMI_TXBITSTUFFEN);
 	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYUTMI);
 
 	/* Resetting the PHYCLKRST enable bits to reduce leakage current */
-- 
2.22.0

