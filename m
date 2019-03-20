Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA21C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFEA2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbaco0qG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCTTx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:53:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43018 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfCTTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:53:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so2664136pfd.10;
        Wed, 20 Mar 2019 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qjiUcdSuQ0yeyvsBkhWrdUBSr194Se00ge6/qb6O7sc=;
        b=mbaco0qGD1dyaixitOvgcy2IcGyw96Ghs2uofUYIV8lpl3CV3jej4aEVZtX0FACg7A
         P62WbLy95ucq29OUY4cD0ChfzF3mpu0uYibyEQg/6uaqSJWwCH+G7c/M7/zz4QjerkBJ
         UJsCEXuViD5TjDdikEWvlH1ihvZWIRJ3GSiM5qpBS0b/GWMzUcZRIC/b/8qOAwMCOCLO
         o+9GG4Y2wIQTakdPVk6v63bH/2rw5yHBqMBgPhJlznGguH2SgN+AnyZ4P8coCTkNT+KP
         jrYEOGYEoTcOwGrQkUJwtk5MB+YMxzY8o1TVtLA21YLiHbtjmXqEDFP3Kfi5K6f5Gdgr
         US8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qjiUcdSuQ0yeyvsBkhWrdUBSr194Se00ge6/qb6O7sc=;
        b=eQlQSGt4D2cbKI4ylTBwHOSuiZOSwHsP1BHsIc2kCM+mF747caipBbqyq65/NyfHF/
         IhXMJ9ifGF3RtR0huR+e5rnk/eeelfZNU5W89nZt4GJat5R4mfAmpo9rqZfTunPNjMon
         AzINCTesXZg96vGOdM0gHxlYgAqLQyq+Lv9HvkWArIuK3sKa2iGg3OuGsriRu7QiFWER
         diaxurBvhKlycwePRchI3oiInAyOHcaQLzaajThmMsxB6vGvISgQjah3lnmzfwKSbZps
         1fy95iD14F0ANQp2jWuNuZSFXKp7FZji4/olktsTBAWwXhgVkeTHcYSfMeP+kOFfC6ZG
         b4FQ==
X-Gm-Message-State: APjAAAU9EgexlimRj/8TurJb4iUIDDlOsCDf0LbiZewERLm5FhvxYI3G
        Z8v7Iu7+lURVyBjbYlfkz5DaBu6a
X-Google-Smtp-Source: APXvYqw11tJO1e8H2xTCpywKPjMemkKRyHYpS8s4i0QVLxLMAN0c01dUHCd4quSQrE99GdbTQRJNyQ==
X-Received: by 2002:a17:902:2ba7:: with SMTP id l36mr9864758plb.237.1553111601478;
        Wed, 20 Mar 2019 12:53:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id y37sm3805933pgk.78.2019.03.20.12.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:53:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list), hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        murali.policharla@broadcom.com, arun.parameswaran@broadcom.com
Subject: [PATCH net-next 1/2] net: phy: Prepare for moving Omega out of bcm7xxx
Date:   Wed, 20 Mar 2019 12:53:12 -0700
Message-Id: <20190320195313.15658-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190320195313.15658-1-f.fainelli@gmail.com>
References: <20190320195313.15658-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Omega PHY entry was added to bcm7xxx.c out of convenience and this
breaks the one driver per product line paradigm that was applied up
until now. Since the AFE initialization is shared between Omega and
BCM7xxx move the relevant functions to bcm-phy-lib.[ch]. No functional
changes introduced.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/bcm-phy-lib.c | 52 ++++++++++++++++++++++++
 drivers/net/phy/bcm-phy-lib.h | 20 ++++++++++
 drivers/net/phy/bcm7xxx.c     | 75 ++---------------------------------
 3 files changed, 76 insertions(+), 71 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index a75642051b8b..e0d3310957ff 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -371,6 +371,58 @@ void bcm_phy_get_stats(struct phy_device *phydev, u64 *shadow,
 }
 EXPORT_SYMBOL_GPL(bcm_phy_get_stats);
 
+void bcm_phy_r_rc_cal_reset(struct phy_device *phydev)
+{
+	/* Reset R_CAL/RC_CAL Engine */
+	bcm_phy_write_exp_sel(phydev, 0x00b0, 0x0010);
+
+	/* Disable Reset R_AL/RC_CAL Engine */
+	bcm_phy_write_exp_sel(phydev, 0x00b0, 0x0000);
+}
+EXPORT_SYMBOL_GPL(bcm_phy_r_rc_cal_reset);
+
+int bcm_phy_28nm_a0b0_afe_config_init(struct phy_device *phydev)
+{
+	/* Increase VCO range to prevent unlocking problem of PLL at low
+	 * temp
+	 */
+	bcm_phy_write_misc(phydev, PLL_PLLCTRL_1, 0x0048);
+
+	/* Change Ki to 011 */
+	bcm_phy_write_misc(phydev, PLL_PLLCTRL_2, 0x021b);
+
+	/* Disable loading of TVCO buffer to bandgap, set bandgap trim
+	 * to 111
+	 */
+	bcm_phy_write_misc(phydev, PLL_PLLCTRL_4, 0x0e20);
+
+	/* Adjust bias current trim by -3 */
+	bcm_phy_write_misc(phydev, DSP_TAP10, 0x690b);
+
+	/* Switch to CORE_BASE1E */
+	phy_write(phydev, MII_BRCM_CORE_BASE1E, 0xd);
+
+	bcm_phy_r_rc_cal_reset(phydev);
+
+	/* write AFE_RXCONFIG_0 */
+	bcm_phy_write_misc(phydev, AFE_RXCONFIG_0, 0xeb19);
+
+	/* write AFE_RXCONFIG_1 */
+	bcm_phy_write_misc(phydev, AFE_RXCONFIG_1, 0x9a3f);
+
+	/* write AFE_RX_LP_COUNTER */
+	bcm_phy_write_misc(phydev, AFE_RX_LP_COUNTER, 0x7fc0);
+
+	/* write AFE_HPF_TRIM_OTHERS */
+	bcm_phy_write_misc(phydev, AFE_HPF_TRIM_OTHERS, 0x000b);
+
+	/* write AFTE_TX_CONFIG */
+	bcm_phy_write_misc(phydev, AFE_TX_CONFIG, 0x0800);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bcm_phy_28nm_a0b0_afe_config_init);
+
 MODULE_DESCRIPTION("Broadcom PHY Library");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Broadcom Corporation");
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index 17faaefcfd60..5ecacb4e64f0 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -9,6 +9,24 @@
 #include <linux/brcmphy.h>
 #include <linux/phy.h>
 
+/* 28nm only register definitions */
+#define MISC_ADDR(base, channel)	base, channel
+
+#define DSP_TAP10			MISC_ADDR(0x0a, 0)
+#define PLL_PLLCTRL_1			MISC_ADDR(0x32, 1)
+#define PLL_PLLCTRL_2			MISC_ADDR(0x32, 2)
+#define PLL_PLLCTRL_4			MISC_ADDR(0x33, 0)
+
+#define AFE_RXCONFIG_0			MISC_ADDR(0x38, 0)
+#define AFE_RXCONFIG_1			MISC_ADDR(0x38, 1)
+#define AFE_RXCONFIG_2			MISC_ADDR(0x38, 2)
+#define AFE_RX_LP_COUNTER		MISC_ADDR(0x38, 3)
+#define AFE_TX_CONFIG			MISC_ADDR(0x39, 0)
+#define AFE_VDCA_ICTRL_0		MISC_ADDR(0x39, 1)
+#define AFE_VDAC_OTHERS_0		MISC_ADDR(0x39, 3)
+#define AFE_HPF_TRIM_OTHERS		MISC_ADDR(0x3a, 0)
+
+
 int bcm_phy_write_exp(struct phy_device *phydev, u16 reg, u16 val);
 int bcm_phy_read_exp(struct phy_device *phydev, u16 reg);
 
@@ -45,5 +63,7 @@ int bcm_phy_get_sset_count(struct phy_device *phydev);
 void bcm_phy_get_strings(struct phy_device *phydev, u8 *data);
 void bcm_phy_get_stats(struct phy_device *phydev, u64 *shadow,
 		       struct ethtool_stats *stats, u64 *data);
+void bcm_phy_r_rc_cal_reset(struct phy_device *phydev);
+int bcm_phy_28nm_a0b0_afe_config_init(struct phy_device *phydev);
 
 #endif /* _LINUX_BCM_PHY_LIB_H */
diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index b8415f8fae14..dddeffa23aa1 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -37,77 +37,10 @@
 #define MII_BCM7XXX_SHD_3_TL4		0x23
 #define  MII_BCM7XXX_TL4_RST_MSK	(BIT(2) | BIT(1))
 
-/* 28nm only register definitions */
-#define MISC_ADDR(base, channel)	base, channel
-
-#define DSP_TAP10			MISC_ADDR(0x0a, 0)
-#define PLL_PLLCTRL_1			MISC_ADDR(0x32, 1)
-#define PLL_PLLCTRL_2			MISC_ADDR(0x32, 2)
-#define PLL_PLLCTRL_4			MISC_ADDR(0x33, 0)
-
-#define AFE_RXCONFIG_0			MISC_ADDR(0x38, 0)
-#define AFE_RXCONFIG_1			MISC_ADDR(0x38, 1)
-#define AFE_RXCONFIG_2			MISC_ADDR(0x38, 2)
-#define AFE_RX_LP_COUNTER		MISC_ADDR(0x38, 3)
-#define AFE_TX_CONFIG			MISC_ADDR(0x39, 0)
-#define AFE_VDCA_ICTRL_0		MISC_ADDR(0x39, 1)
-#define AFE_VDAC_OTHERS_0		MISC_ADDR(0x39, 3)
-#define AFE_HPF_TRIM_OTHERS		MISC_ADDR(0x3a, 0)
-
 struct bcm7xxx_phy_priv {
 	u64	*stats;
 };
 
-static void r_rc_cal_reset(struct phy_device *phydev)
-{
-	/* Reset R_CAL/RC_CAL Engine */
-	bcm_phy_write_exp_sel(phydev, 0x00b0, 0x0010);
-
-	/* Disable Reset R_AL/RC_CAL Engine */
-	bcm_phy_write_exp_sel(phydev, 0x00b0, 0x0000);
-}
-
-static int bcm7xxx_28nm_b0_afe_config_init(struct phy_device *phydev)
-{
-	/* Increase VCO range to prevent unlocking problem of PLL at low
-	 * temp
-	 */
-	bcm_phy_write_misc(phydev, PLL_PLLCTRL_1, 0x0048);
-
-	/* Change Ki to 011 */
-	bcm_phy_write_misc(phydev, PLL_PLLCTRL_2, 0x021b);
-
-	/* Disable loading of TVCO buffer to bandgap, set bandgap trim
-	 * to 111
-	 */
-	bcm_phy_write_misc(phydev, PLL_PLLCTRL_4, 0x0e20);
-
-	/* Adjust bias current trim by -3 */
-	bcm_phy_write_misc(phydev, DSP_TAP10, 0x690b);
-
-	/* Switch to CORE_BASE1E */
-	phy_write(phydev, MII_BRCM_CORE_BASE1E, 0xd);
-
-	r_rc_cal_reset(phydev);
-
-	/* write AFE_RXCONFIG_0 */
-	bcm_phy_write_misc(phydev, AFE_RXCONFIG_0, 0xeb19);
-
-	/* write AFE_RXCONFIG_1 */
-	bcm_phy_write_misc(phydev, AFE_RXCONFIG_1, 0x9a3f);
-
-	/* write AFE_RX_LP_COUNTER */
-	bcm_phy_write_misc(phydev, AFE_RX_LP_COUNTER, 0x7fc0);
-
-	/* write AFE_HPF_TRIM_OTHERS */
-	bcm_phy_write_misc(phydev, AFE_HPF_TRIM_OTHERS, 0x000b);
-
-	/* write AFTE_TX_CONFIG */
-	bcm_phy_write_misc(phydev, AFE_TX_CONFIG, 0x0800);
-
-	return 0;
-}
-
 static int bcm7xxx_28nm_d0_afe_config_init(struct phy_device *phydev)
 {
 	/* AFE_RXCONFIG_0 */
@@ -143,7 +76,7 @@ static int bcm7xxx_28nm_d0_afe_config_init(struct phy_device *phydev)
 	bcm_phy_write_misc(phydev, DSP_TAP10, 0x011b);
 
 	/* Reset R_CAL/RC_CAL engine */
-	r_rc_cal_reset(phydev);
+	bcm_phy_r_rc_cal_reset(phydev);
 
 	return 0;
 }
@@ -171,7 +104,7 @@ static int bcm7xxx_28nm_e0_plus_afe_config_init(struct phy_device *phydev)
 	bcm_phy_write_misc(phydev, DSP_TAP10, 0x011b);
 
 	/* Reset R_CAL/RC_CAL engine */
-	r_rc_cal_reset(phydev);
+	bcm_phy_r_rc_cal_reset(phydev);
 
 	return 0;
 }
@@ -196,7 +129,7 @@ static int bcm7xxx_28nm_a0_patch_afe_config_init(struct phy_device *phydev)
 	/* Enable ffe zero detection for Vitesse interoperability */
 	bcm_phy_write_misc(phydev, 0x26, 0x2, 0x0015);
 
-	r_rc_cal_reset(phydev);
+	bcm_phy_r_rc_cal_reset(phydev);
 
 	return 0;
 }
@@ -227,7 +160,7 @@ static int bcm7xxx_28nm_config_init(struct phy_device *phydev)
 	switch (rev) {
 	case 0xa0:
 	case 0xb0:
-		ret = bcm7xxx_28nm_b0_afe_config_init(phydev);
+		ret = bcm_phy_28nm_a0b0_afe_config_init(phydev);
 		break;
 	case 0xd0:
 		ret = bcm7xxx_28nm_d0_afe_config_init(phydev);
-- 
2.17.1

