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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B793C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9EC20693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uie7vKzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfGVS77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:59:59 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:39659 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfGVS74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:59:56 -0400
Received: by mail-pf1-f177.google.com with SMTP id f17so13822901pfn.6;
        Mon, 22 Jul 2019 11:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RTpdlQyeL6bUmfZxFwZVri3i7nbPBO/dWR0GM1UFauc=;
        b=Uie7vKzMH8rhSaqDU+aMcGpqyxjCAEwwYHOs8Zz8U3B2wZObu/hBnRQpJYvhmIGgDw
         IHk/K6jpfG6wXsMB1qUT1sh/ChhrsYn3LxIcUCmrK6vZRbrVceM3II59gJ3kh+MlrX2x
         1DuHiX4OOmXS/GL5pG5qPgTuSdp7IAnFiZQTc6QW4YS1+Bjmh9K4aQZf6t0rqhuNHfuw
         QTYoUNyzdiW3NvWNC+WPdBiUeQGJU4eWLZBmKDyTCJLNj8TNHpSgKm/m3oO5L/BOzi6X
         OiJd4btOFqQz+abdaTlUTE83JA2iCBDkjFgg1DkkEOhNW/Odd8tjV65+H+egp+j8fJWA
         9F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RTpdlQyeL6bUmfZxFwZVri3i7nbPBO/dWR0GM1UFauc=;
        b=bWXtMcPWQk1VJ/Qa3xyF+qbc5l/dl6JPk7Gecwtb5DAtxxq11qp7OSXYiZLXYm6dBP
         ArzQLE9PI8dBNJ8+nhKvV/Rzy0M7DRNb9KSKjTKj7DwwMvS4McEITK/1D5qp1dDYAze6
         Bp2XoIncgEVC2WvX6+xuZ2idcyyjjRI6e8QkHD+rxJNCF5v1QNki0/6T48zPaujpy2aE
         RzOdY5wbLY1Znl/LRUcCnxxEY7jNpqyCLVDVQSfSXn7ZhS3zuB53sqiewTiBZXz7nB/w
         l/tqRT1ygttVck9ftyV/xiUcuCSmoWBErrWZGSsbLs7Asopbg5LfZ/joVZ4JQWVPEGUs
         pTyA==
X-Gm-Message-State: APjAAAW8oGTBzWX/6sH7FLaHyNZu0EgT8lyi1RBFNbJVo3go8bs28eVK
        j5dLEzn0L66iPX1q41uZh/7iikt5nVE=
X-Google-Smtp-Source: APXvYqztAcyiJIByeuZ9Vv/e8q5WaFPy7KjT+3hxXXN1zGRIHD3y1yeHD3EkCpYt7gjV3RCQsz+iPQ==
X-Received: by 2002:a63:c750:: with SMTP id v16mr56466432pgg.320.1563821995654;
        Mon, 22 Jul 2019 11:59:55 -0700 (PDT)
Received: from localhost.localdomain ([103.51.73.174])
        by smtp.gmail.com with ESMTPSA id h1sm30777675pgv.93.2019.07.22.11.59.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:59:55 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC/RFT 3/5] phy: exynos5-usbdrd: UTMI tune signal
Date:   Tue, 23 Jul 2019 00:29:36 +0530
Message-Id: <20190722185938.9043-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722185938.9043-1-linux.amoon@gmail.com>
References: <20190722185938.9043-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tune USB2.0 (UTMI+) TX signal for high speed data transfer.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 42 +++++++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 135114d51bc1..54a513ca15e4 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -33,6 +33,8 @@
 #define EXYNOS5_FSEL_24MHZ		0x5
 #define EXYNOS5_FSEL_50MHZ		0x7
 
+#define __set(v, a, b)  (((v) << (b)) & GENMASK(a, b))
+
 /* EXYNOS5: USB 3.0 DRD PHY registers */
 #define EXYNOS5_DRD_LINKSYSTEM			0x04
 
@@ -108,8 +110,17 @@
 #define EXYNOS5_DRD_PHYPARAM0			0x1c
 
 #define PHYPARAM0_REF_USE_PAD			BIT(31)
-#define PHYPARAM0_REF_LOSLEVEL_MASK		(0x1f << 26)
-#define PHYPARAM0_REF_LOSLEVEL			(0x9 << 26)
+#define PHYPARAM0_REF_LOSLEVEL(x)		__set(x, 30, 26)
+#define PHYPARAM0_TXVREFTUNE(x)			__set(x, 25, 22)
+#define PHYPARAM0_TXISETUNE(x)			__set(x, 21, 20)
+#define PHYPARAM0_TXRESTUNE(x)			__set(x, 19, 18)
+#define PHYPARAM0_TXPREEMPPULSETUNE		BIT(17)
+#define PHYPARAM0_TXPREEMPAMPTUNE(x)		__set(x, 16, 15)
+#define PHYPARAM0_TXHSXVTUNE(x)			__set(x, 14, 13)
+#define PHYPARAM0_TXFSLSTUNE(x)			__set(x, 12, 9)
+#define PHYPARAM0_SQRXTUNE(x)			__set(x, 8, 6)
+#define PHYPARAM0_OTGTUNE(x)			__set(x, 5, 3)
+#define PHYPARAM0_COMPDISTUNE(x)		__set(x, 2, 0)
 
 #define EXYNOS5_DRD_PHYPARAM1			0x20
 
@@ -365,9 +376,30 @@ static void exynos5_usbdrd_utmi_init(struct exynos5_usbdrd_phy *phy_drd)
 	u32 reg;
 
 	reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM0);
-	/* Set Loss-of-Signal Detector sensitivity */
-	reg &= ~PHYPARAM0_REF_LOSLEVEL_MASK;
-	reg |=	PHYPARAM0_REF_LOSLEVEL;
+		/* Set Loss-of-Signal Detector sensitivity */
+	reg |= (PHYPARAM0_REF_USE_PAD |
+		/* Sets the sensitivity level for the Loss-of-Signal detector */
+		PHYPARAM0_REF_LOSLEVEL(0x9) |
+		/* Adjusts the high-speed DC level voltage */
+		PHYPARAM0_TXVREFTUNE(0x3) |
+		/* Adjust the rise/fal timie of the high-speed waveform */
+		PHYPARAM0_TXISETUNE(0x1) |
+		/* Adjusts the driver source impedance */
+		PHYPARAM0_TXRESTUNE(0x1) |
+		/* HS Transmitter Pre-Emphasis Duration Control */
+		PHYPARAM0_TXPREEMPPULSETUNE |
+		/* HS Transmitter Pre-Emphasis Current Control */
+		PHYPARAM0_TXPREEMPAMPTUNE(0x0) |
+		/* Transmitter High-Speed Crossover Adjustment */
+		PHYPARAM0_TXHSXVTUNE(0x3) |
+		/* FS/LS Source Impedance Adjustment */
+		PHYPARAM0_TXFSLSTUNE(0x3) |
+		/* Squelch Threshold Adjustment */
+		PHYPARAM0_SQRXTUNE(0x3) |
+		/* VBUS Valid Threshold Adjustment */
+		PHYPARAM0_OTGTUNE(0x6) |
+		/* Disconnect Threshold Adjustment */
+		PHYPARAM0_COMPDISTUNE(0x6));
 	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM0);
 
 	reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM1);
-- 
2.22.0

