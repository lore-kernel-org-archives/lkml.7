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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8B4C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EF620693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6MMjgcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfGVTAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:00:02 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:46260 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfGVS77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:59:59 -0400
Received: by mail-pl1-f175.google.com with SMTP id c2so19537648plz.13;
        Mon, 22 Jul 2019 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zz5vAjKnwObHWdgiR69vnrMUFdCw0YpjqKvOUe5J6MQ=;
        b=d6MMjgcgq7A5Ok7sC1mvq8Y7Wf/C/AbAtJI0wx9bGY4LJJDTTd0vQVHuitO2plMEyq
         s651WhX3usFjBAenymrYvEPR3lbhKenTx0jmJU6miKE7/atUIiKfrBoNG2ef4g9tLLVE
         LheTn+WTo/fecBYSmVujWJvETdofqQuuS9X6FH2EzkWgzBV5HCJ7zylD6lSW8IO5VgUr
         nha9fg8eP8GlVrc3Fw6sjREvttunn9yPpGeTarp9+jV48N58mLUDgtUXRvotX5TGYvOS
         vSXYtNoIDim5DoM834ci3JXYBNtu0sOWTuYlom0yBD34s/1T3PNVEIu+63qEV0ddOA+j
         Khew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zz5vAjKnwObHWdgiR69vnrMUFdCw0YpjqKvOUe5J6MQ=;
        b=KBztWVrTzfUYukMK7e/OT72/i+b7g0bDtGUcOSQMo5tYVm+AdWOXlebOO1jmt3rui9
         p1w32jNA3l9EECIVCg4QL5DYjKG0OGVenry1iPPTfNGcudh7DeZ1sg2w7/xa0qAYsIl4
         wnwByiFekF0jUFNTXCv9GnYNn9jEvBPIv+BOt6yZtjsiIuyoqcHwmC49HJIydskQRBtt
         sVVq26aA2g4rv4niMzsETxvMBU94hN1yDDKxz+1sLUg7xLOzzSrnaQyr5LLpa2gYbBVY
         9IPcbhOOIgNI7G9BbzYjkMAwCYkU3E26a2d3axKl12Khuo7Q1UUlImjhuUo/2f2wuxap
         g14A==
X-Gm-Message-State: APjAAAXt52RwmfMOwaPs3T/jsVNDmAqeAYJMcFiVObqp5HHIU0aNZony
        cyIlPApCXQQdzT14CGMZN0nrCJvrr/Y=
X-Google-Smtp-Source: APXvYqzWw+Rq9/ABGsPQPWP/BkeiCKWfr3/1wKZdxsrMxEEqcLGp5JqqrkgZS13L+ODsPeeJYwBo9w==
X-Received: by 2002:a17:902:2865:: with SMTP id e92mr37369159plb.264.1563821998707;
        Mon, 22 Jul 2019 11:59:58 -0700 (PDT)
Received: from localhost.localdomain ([103.51.73.174])
        by smtp.gmail.com with ESMTPSA id h1sm30777675pgv.93.2019.07.22.11.59.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:59:58 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC/RFT 4/5] phy: exynos5-usbdrd: PIPE3 tune signal
Date:   Tue, 23 Jul 2019 00:29:37 +0530
Message-Id: <20190722185938.9043-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722185938.9043-1-linux.amoon@gmail.com>
References: <20190722185938.9043-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tune USB3.0 (PIPE3) PHY TX signal for high and supper
speed data transfer.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 54a513ca15e4..4f16c4f82ae5 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -124,8 +124,10 @@
 
 #define EXYNOS5_DRD_PHYPARAM1			0x20
 
-#define PHYPARAM1_PCS_TXDEEMPH_MASK		(0x1f << 0)
-#define PHYPARAM1_PCS_TXDEEMPH			(0x1c)
+#define PHYPARAM1_TX0_TERM_OFFSET(x)		__set(x, 30, 26)
+#define PHYPARAM1_TX_SWING_FULL(x)		__set(x, 18, 12)
+#define PHYPRAAM1_PCS_TX_DEEMPH_6DB(x)		__set(x, 11, 6)
+#define PHYPRAAM1_PCS_TX_DEEMPH_3P5DB(x)	__set(x, 5, 0)
 
 #define EXYNOS5_DRD_PHYTERM			0x24
 
@@ -360,10 +362,16 @@ static void exynos5_usbdrd_pipe3_init(struct exynos5_usbdrd_phy *phy_drd)
 {
 	u32 reg;
 
-	reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM1);
 	/* Set Tx De-Emphasis level */
-	reg &= ~PHYPARAM1_PCS_TXDEEMPH_MASK;
-	reg |=	PHYPARAM1_PCS_TXDEEMPH;
+	reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM1);
+		/* Transmitter Termination Offset */
+	reg |=  PHYPARAM1_TX0_TERM_OFFSET(0x5) |
+		/* Tx Amplitude (Full Swing mode) */
+		PHYPARAM1_TX_SWING_FULL(0x3F) |
+		/* Tx De-Emphasis at 6 dB */
+		PHYPRAAM1_PCS_TX_DEEMPH_6DB(0x20) |
+		/* Tx De-Emphasis at 3.5 dB */
+		PHYPRAAM1_PCS_TX_DEEMPH_3P5DB(0x15);
 	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM1);
 
 	reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYTEST);
-- 
2.22.0

