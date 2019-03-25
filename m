Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F394C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6CE208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OFqIC1Y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfCYOS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:18:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37010 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfCYOSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:18:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so10375471wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xcdm9ZTeRXNoWCh0Hhn00ZWpgun6M+QvG7+vRxYYJwk=;
        b=OFqIC1Y+rksd9if7aDonbPfN3Yy0JQLsUzPsui/0aOOG9bJv1H1M8QyNXMFC4bMhMF
         lQnlTk54BetvnyN4ncoGkpfmsBKagAj7h/DMH3NJfe5dxKOOfCikXCDlbwne72wkxBMq
         HXvgEA0qXmqhLwS1mN90JkZBFoWIC54LhrbJYpoNjhWTwRSjPW6dXdGiGlmT56/5vEjp
         Mf++nsWOtojMBTKUvG2C8wOEJGyEt30MXh2EeprjYL93zyx4rmsqykt6V8gOJqBTBg3z
         A4SyvP2JVCXlsZQz4JgEVNg+TFvy5tzEZdnjZ3vRKCk7ICWDRl1JZs5/UEpZ6I5YIqSy
         ORBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xcdm9ZTeRXNoWCh0Hhn00ZWpgun6M+QvG7+vRxYYJwk=;
        b=QoHS5dDv+/+eidBqKzfbZUKD2+uMvec4O+3h1u13bEdOa9ActHbOzU5YSETQ5RaTqo
         9vHYSZPDliQz7lpVMimoejewIdkqr8CPYN6DgQj7oCeh7BW3OR95LOl2jO7W9GUDUVZ5
         um7kUAPaPCnLGvcjlX+TGWwJZBJY1ESEj5BYu8GWxNgNcsoO6uT14Pey7ALCdig3IuBz
         tPZ5iXpwat+dd5euVr18+tt9WCvug/bfO4MKvREvwh4y+GMVF5cwRNwf9NrKmFpv5xZz
         BDHSUhOeCfr0EYXdW+NJGE/SH95qcaUslTYkoWku24Hf80N7zWbdkRrwGK8yq+dApcIg
         b4/g==
X-Gm-Message-State: APjAAAUHglfBinp2KemCuwGHzwSGEnYrbKZknLLebolLV6V5YXIOWA7A
        hIetIFo86WhNcB6UkxcCgahrlg==
X-Google-Smtp-Source: APXvYqzLI8BOW3Z7tm61fDnXMJ7V9hA41HtN/cC5ncgd1HA+uYsktSCNXHLa9lwJTRWz+hfAt619ng==
X-Received: by 2002:adf:ef91:: with SMTP id d17mr16780373wro.78.1553523518370;
        Mon, 25 Mar 2019 07:18:38 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 132sm26976794wmd.30.2019.03.25.07.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:18:37 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] drm/meson: Add G12A Video Clock setup
Date:   Mon, 25 Mar 2019 15:18:22 +0100
Message-Id: <20190325141824.21259-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325141824.21259-1-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While switching to the Common Clock Framework is still Work In Progress,
this patch adds the corresponding G12A HDMI PLL setup to be on-par
with the other SoCs support.

The G12A has only a single tweak about the high frequency setup,
where the HDMI PLL needs a specific setup to handle correctly the
5.94GHz DCO frequency.

Apart that, it handle correctly all the other HDMI frequencies
and can achieve even better DMT clock frequency precision with
the larger fractional dividier width.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_vclk.c | 119 ++++++++++++++++++++++++++---
 1 file changed, 108 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index c15a5a5df633..b39034745444 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -113,9 +113,12 @@
 #define HHI_HDMI_PLL_CNTL4	0x32C /* 0xcb offset in data sheet */
 #define HHI_HDMI_PLL_CNTL5	0x330 /* 0xcc offset in data sheet */
 #define HHI_HDMI_PLL_CNTL6	0x334 /* 0xcd offset in data sheet */
+#define HHI_HDMI_PLL_CNTL7	0x338 /* 0xce offset in data sheet */
 
 #define HDMI_PLL_RESET		BIT(28)
+#define HDMI_PLL_RESET_G12A	BIT(29)
 #define HDMI_PLL_LOCK		BIT(31)
+#define HDMI_PLL_LOCK_G12A	(3 << 30)
 
 #define FREQ_1000_1001(_freq)	DIV_ROUND_CLOSEST(_freq * 1000, 1001)
 
@@ -257,6 +260,10 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
 		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x71486980);
 		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x00000e55);
 		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x4800023d);
+
+		/* Poll for lock bit */
+		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
+					 (val & HDMI_PLL_LOCK), 10, 0);
 	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
 		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
 		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x4000027b);
@@ -271,11 +278,26 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
 					HDMI_PLL_RESET, HDMI_PLL_RESET);
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
 					HDMI_PLL_RESET, 0);
-	}
 
-	/* Poll for lock bit */
-	regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
-				 (val & HDMI_PLL_LOCK), 10, 0);
+		/* Poll for lock bit */
+		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
+					 (val & HDMI_PLL_LOCK), 10, 0);
+	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x1a0504f7);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x00010000);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x00000000);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x6a28dc00);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x65771290);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x39272000);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL7, 0x56540000);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x3a0504f7);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x1a0504f7);
+
+		/* Poll for lock bit */
+		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
+			((val & HDMI_PLL_LOCK_G12A) == HDMI_PLL_LOCK_G12A),
+			10, 0);
+	}
 
 	/* Disable VCLK2 */
 	regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL, VCLK2_EN, 0);
@@ -288,8 +310,13 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
 				VCLK2_DIV_MASK, (55 - 1));
 
 	/* select vid_pll for vclk2 */
-	regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
-				VCLK2_SEL_MASK, (4 << VCLK2_SEL_SHIFT));
+	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
+		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
+					VCLK2_SEL_MASK, (0 << VCLK2_SEL_SHIFT));
+	else
+		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
+					VCLK2_SEL_MASK, (4 << VCLK2_SEL_SHIFT));
+
 	/* enable vclk2 gate */
 	regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL, VCLK2_EN, VCLK2_EN);
 
@@ -476,32 +503,80 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
 		/* Poll for lock bit */
 		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
 				(val & HDMI_PLL_LOCK), 10, 0);
+	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x0b3a0400 | m);
+
+		/* Enable and reset */
+		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
+				   0x3 << 28, 0x3 << 28);
+
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, frac);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x00000000);
+
+		/* G12A HDMI PLL Needs specific parameters for 5.4GHz */
+		if (m >= 0xf7) {
+			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0xea68dc00);
+			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x65771290);
+			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x39272000);
+			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL7, 0x55540000);
+		} else {
+			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x0a691c00);
+			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x33771290);
+			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x39270000);
+			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL7, 0x50540000);
+		}
+
+		do {
+			/* Reset PLL */
+			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
+					HDMI_PLL_RESET_G12A, HDMI_PLL_RESET_G12A);
+
+			/* UN-Reset PLL */
+			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
+					HDMI_PLL_RESET_G12A, 0);
+
+			/* Poll for lock bits */
+			if (!regmap_read_poll_timeout(priv->hhi,
+						      HHI_HDMI_PLL_CNTL, val,
+						      ((val & HDMI_PLL_LOCK_G12A)
+						        == HDMI_PLL_LOCK_G12A),
+						      10, 100))
+				break;
+		} while(1);
 	}
 
 	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
 				3 << 16, pll_od_to_reg(od1) << 16);
 	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
-			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
+		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
 				3 << 21, pll_od_to_reg(od1) << 21);
+	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
+		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
+				3 << 16, pll_od_to_reg(od1) << 16);
 
 	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
 				3 << 22, pll_od_to_reg(od2) << 22);
 	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
-			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
+		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
 				3 << 23, pll_od_to_reg(od2) << 23);
+	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
+		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
+				3 << 18, pll_od_to_reg(od2) << 18);
 
 	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
 				3 << 18, pll_od_to_reg(od3) << 18);
 	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
-			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
+		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
 				3 << 19, pll_od_to_reg(od3) << 19);
-
+	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
+		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
+				3 << 20, pll_od_to_reg(od3) << 20);
 }
 
 #define XTAL_FREQ 24000
@@ -518,6 +593,7 @@ static unsigned int meson_hdmi_pll_get_m(struct meson_drm *priv,
 
 #define HDMI_FRAC_MAX_GXBB	4096
 #define HDMI_FRAC_MAX_GXL	1024
+#define HDMI_FRAC_MAX_G12A	131072
 
 static unsigned int meson_hdmi_pll_get_frac(struct meson_drm *priv,
 					    unsigned int m,
@@ -534,6 +610,9 @@ static unsigned int meson_hdmi_pll_get_frac(struct meson_drm *priv,
 		parent_freq *= 2;
 	}
 
+	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
+		frac_max = HDMI_FRAC_MAX_G12A;
+
 	/* We can have a perfect match !*/
 	if (pll_freq / m == parent_freq &&
 	    pll_freq % m == 0)
@@ -559,7 +638,8 @@ static bool meson_hdmi_pll_validate_params(struct meson_drm *priv,
 		if (frac >= HDMI_FRAC_MAX_GXBB)
 			return false;
 	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
-		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
+		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu") ||
+		   meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
 		/* Empiric supported min/max dividers */
 		if (m < 106 || m > 247)
 			return false;
@@ -713,6 +793,23 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
 			break;
 		}
 
+		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
+	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
+		switch (pll_base_freq) {
+		case 2970000:
+			m = 0x7b;
+			frac = vic_alternate_clock ? 0x140b4 : 0x18000;
+			break;
+		case 4320000:
+			m = vic_alternate_clock ? 0xb3 : 0xb4;
+			frac = vic_alternate_clock ? 0x1a3ee : 0;
+			break;
+		case 5940000:
+			m = 0xf7;
+			frac = vic_alternate_clock ? 0x8148 : 0x10000;
+			break;
+		}
+
 		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
 	}
 
-- 
2.21.0

