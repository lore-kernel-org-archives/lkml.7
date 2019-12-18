Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A141BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DA02064B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p68mxFRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLRRxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:53:51 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38221 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfLRRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:53:44 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so2334381lfm.5;
        Wed, 18 Dec 2019 09:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZPBF58VvI6I4a5OITU9GU7Lw7N/ABPaJ/fXpShSCc0=;
        b=p68mxFRM01KUv75cGw/tUKR5Nlv9NTIVnihYva+RDcZE0dV+Tkd5pbH+7yncxLZWjg
         4LlSm8cGRBL49hRAcpmssIrRV+z3KkjVNXPdpDWQ3fa5Ja3mVd2CD9JQM42mD27CzWWH
         iDCWw9VJVdPaQ+lYC7and0yQZNRhI2baAk3zMpHDlh82xLsdzXNhvMa/fapO+Fmk+1zP
         vhvSftuJ1xoQ4GL/sbbpkAijLovI5i/rQOotNQUUJl2Wi7UHqnQj4FHzC48Jn+DKUBXu
         VdHSVoIsGwWLlw0C/uYto+IUzVKrgGNCpikpMdaAy7vKX6Wcevd24Y/XmoJND+z0x8c2
         9rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZPBF58VvI6I4a5OITU9GU7Lw7N/ABPaJ/fXpShSCc0=;
        b=FvqN5kXUjNRW9GGUVZgne2DdQjb0FuQi199tk1TAHldm1dpJ0/aPgCUJhVfWKiuic1
         awEBHf8lyF1nHRXtu76GqWHxK18s1s8os5R8UtflLvjbP4NuTV8GydWqNGejfKbbRJdN
         qaCE6QfB5sffDQOShci498ZyIjcTjAv6FCjHfbh+Nw7QVB0FjUeuS9z2q7bw2o+KqWEW
         CulVzs9q3vt2K02PfTqEJ8f3VJrQegphmgDxhTOol1CN75L7XUCpFHWvyPigClykivdf
         WPmHBqc0J/GGDTtw/DA0j2V2s7pyEaKsL0Fsxlc/oOr3JLIP/1Y1uCvOVS4Xb/FDDzd+
         RqiQ==
X-Gm-Message-State: APjAAAWBDi5YBceGatxqmKGKLYLiA3e01mW5Uua2ivHY+ta3CawH7fSt
        gpwpprq8LO05nRCnRGd0gcVndBsY
X-Google-Smtp-Source: APXvYqzVCtKJTJ2V4axs4bIU9PPvS5I+R4ruq8ay2muWadnMIh6ZW8LTFAUllFIXwgTC2DVgPmymdg==
X-Received: by 2002:a19:c3cc:: with SMTP id t195mr2653271lff.144.1576691621185;
        Wed, 18 Dec 2019 09:53:41 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id n14sm1530480lfe.5.2019.12.18.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:53:40 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] usb: phy: tegra: Use relaxed versions of readl/writel
Date:   Wed, 18 Dec 2019 20:53:13 +0300
Message-Id: <20191218175313.16235-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218175313.16235-1-digetx@gmail.com>
References: <20191218175313.16235-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing to synchronize in regards to memory stores, thus all
readl/writel occurrences in the code could be replaced with a relaxed
versions, for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 195 ++++++++++++++++----------------
 1 file changed, 98 insertions(+), 97 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 76949dbbbdc2..a1cc09c29695 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -205,15 +205,16 @@ static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
 	unsigned long val;
 
 	if (phy->soc_config->has_hostpc) {
-		val = readl(base + TEGRA_USB_HOSTPC1_DEVLC);
+		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
 		val &= ~TEGRA_USB_HOSTPC1_DEVLC_PTS(~0);
 		val |= TEGRA_USB_HOSTPC1_DEVLC_PTS(pts_val);
-		writel(val, base + TEGRA_USB_HOSTPC1_DEVLC);
+		writel_relaxed(val, base + TEGRA_USB_HOSTPC1_DEVLC);
 	} else {
-		val = readl(base + TEGRA_USB_PORTSC1) & ~TEGRA_PORTSC1_RWC_BITS;
+		val = readl_relaxed(base + TEGRA_USB_PORTSC1);
+		val &= ~TEGRA_PORTSC1_RWC_BITS;
 		val &= ~TEGRA_USB_PORTSC1_PTS(~0);
 		val |= TEGRA_USB_PORTSC1_PTS(pts_val);
-		writel(val, base + TEGRA_USB_PORTSC1);
+		writel_relaxed(val, base + TEGRA_USB_PORTSC1);
 	}
 }
 
@@ -223,19 +224,19 @@ static void set_phcd(struct tegra_usb_phy *phy, bool enable)
 	unsigned long val;
 
 	if (phy->soc_config->has_hostpc) {
-		val = readl(base + TEGRA_USB_HOSTPC1_DEVLC);
+		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
 		if (enable)
 			val |= TEGRA_USB_HOSTPC1_DEVLC_PHCD;
 		else
 			val &= ~TEGRA_USB_HOSTPC1_DEVLC_PHCD;
-		writel(val, base + TEGRA_USB_HOSTPC1_DEVLC);
+		writel_relaxed(val, base + TEGRA_USB_HOSTPC1_DEVLC);
 	} else {
-		val = readl(base + TEGRA_USB_PORTSC1) & ~PORT_RWC_BITS;
+		val = readl_relaxed(base + TEGRA_USB_PORTSC1) & ~PORT_RWC_BITS;
 		if (enable)
 			val |= TEGRA_USB_PORTSC1_PHCD;
 		else
 			val &= ~TEGRA_USB_PORTSC1_PHCD;
-		writel(val, base + TEGRA_USB_PORTSC1);
+		writel_relaxed(val, base + TEGRA_USB_PORTSC1);
 	}
 }
 
@@ -329,7 +330,7 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
 	spin_lock_irqsave(&utmip_pad_lock, flags);
 
 	if (utmip_pad_count++ == 0) {
-		val = readl(base + UTMIP_BIAS_CFG0);
+		val = readl_relaxed(base + UTMIP_BIAS_CFG0);
 		val &= ~(UTMIP_OTGPD | UTMIP_BIASPD);
 
 		if (phy->soc_config->requires_extra_tuning_parameters) {
@@ -341,7 +342,7 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
 			val |= UTMIP_HSDISCON_LEVEL(config->hsdiscon_level);
 			val |= UTMIP_HSDISCON_LEVEL_MSB(config->hsdiscon_level);
 		}
-		writel(val, base + UTMIP_BIAS_CFG0);
+		writel_relaxed(val, base + UTMIP_BIAS_CFG0);
 	}
 
 	spin_unlock_irqrestore(&utmip_pad_lock, flags);
@@ -369,9 +370,9 @@ static int utmip_pad_power_off(struct tegra_usb_phy *phy)
 	spin_lock_irqsave(&utmip_pad_lock, flags);
 
 	if (--utmip_pad_count == 0) {
-		val = readl(base + UTMIP_BIAS_CFG0);
+		val = readl_relaxed(base + UTMIP_BIAS_CFG0);
 		val |= UTMIP_OTGPD | UTMIP_BIASPD;
-		writel(val, base + UTMIP_BIAS_CFG0);
+		writel_relaxed(val, base + UTMIP_BIAS_CFG0);
 	}
 
 	spin_unlock_irqrestore(&utmip_pad_lock, flags);
@@ -385,8 +386,8 @@ static int utmi_wait_register(void __iomem *reg, u32 mask, u32 result)
 {
 	u32 tmp;
 
-	return readl_poll_timeout(reg, tmp, (tmp & mask) == result,
-				  2000, 6000);
+	return readl_relaxed_poll_timeout(reg, tmp, (tmp & mask) == result,
+					  2000, 6000);
 }
 
 static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
@@ -403,15 +404,15 @@ static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
 		return;
 
 	if (phy->is_legacy_phy) {
-		val = readl(base + USB_SUSP_CTRL);
+		val = readl_relaxed(base + USB_SUSP_CTRL);
 		val |= USB_SUSP_SET;
-		writel(val, base + USB_SUSP_CTRL);
+		writel_relaxed(val, base + USB_SUSP_CTRL);
 
 		usleep_range(10, 100);
 
-		val = readl(base + USB_SUSP_CTRL);
+		val = readl_relaxed(base + USB_SUSP_CTRL);
 		val &= ~USB_SUSP_SET;
-		writel(val, base + USB_SUSP_CTRL);
+		writel_relaxed(val, base + USB_SUSP_CTRL);
 	} else {
 		set_phcd(phy, true);
 	}
@@ -436,15 +437,15 @@ static void utmi_phy_clk_enable(struct tegra_usb_phy *phy)
 		return;
 
 	if (phy->is_legacy_phy) {
-		val = readl(base + USB_SUSP_CTRL);
+		val = readl_relaxed(base + USB_SUSP_CTRL);
 		val |= USB_SUSP_CLR;
-		writel(val, base + USB_SUSP_CTRL);
+		writel_relaxed(val, base + USB_SUSP_CTRL);
 
 		usleep_range(10, 100);
 
-		val = readl(base + USB_SUSP_CTRL);
+		val = readl_relaxed(base + USB_SUSP_CTRL);
 		val &= ~USB_SUSP_CLR;
-		writel(val, base + USB_SUSP_CTRL);
+		writel_relaxed(val, base + USB_SUSP_CTRL);
 	} else {
 		set_phcd(phy, false);
 	}
@@ -462,75 +463,75 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 	unsigned long val;
 	int err;
 
-	val = readl(base + USB_SUSP_CTRL);
+	val = readl_relaxed(base + USB_SUSP_CTRL);
 	val |= UTMIP_RESET;
-	writel(val, base + USB_SUSP_CTRL);
+	writel_relaxed(val, base + USB_SUSP_CTRL);
 
 	if (phy->is_legacy_phy) {
-		val = readl(base + USB1_LEGACY_CTRL);
+		val = readl_relaxed(base + USB1_LEGACY_CTRL);
 		val |= USB1_NO_LEGACY_MODE;
-		writel(val, base + USB1_LEGACY_CTRL);
+		writel_relaxed(val, base + USB1_LEGACY_CTRL);
 	}
 
-	val = readl(base + UTMIP_TX_CFG0);
+	val = readl_relaxed(base + UTMIP_TX_CFG0);
 	val |= UTMIP_FS_PREABMLE_J;
-	writel(val, base + UTMIP_TX_CFG0);
+	writel_relaxed(val, base + UTMIP_TX_CFG0);
 
-	val = readl(base + UTMIP_HSRX_CFG0);
+	val = readl_relaxed(base + UTMIP_HSRX_CFG0);
 	val &= ~(UTMIP_IDLE_WAIT(~0) | UTMIP_ELASTIC_LIMIT(~0));
 	val |= UTMIP_IDLE_WAIT(config->idle_wait_delay);
 	val |= UTMIP_ELASTIC_LIMIT(config->elastic_limit);
-	writel(val, base + UTMIP_HSRX_CFG0);
+	writel_relaxed(val, base + UTMIP_HSRX_CFG0);
 
-	val = readl(base + UTMIP_HSRX_CFG1);
+	val = readl_relaxed(base + UTMIP_HSRX_CFG1);
 	val &= ~UTMIP_HS_SYNC_START_DLY(~0);
 	val |= UTMIP_HS_SYNC_START_DLY(config->hssync_start_delay);
-	writel(val, base + UTMIP_HSRX_CFG1);
+	writel_relaxed(val, base + UTMIP_HSRX_CFG1);
 
-	val = readl(base + UTMIP_DEBOUNCE_CFG0);
+	val = readl_relaxed(base + UTMIP_DEBOUNCE_CFG0);
 	val &= ~UTMIP_BIAS_DEBOUNCE_A(~0);
 	val |= UTMIP_BIAS_DEBOUNCE_A(phy->freq->debounce);
-	writel(val, base + UTMIP_DEBOUNCE_CFG0);
+	writel_relaxed(val, base + UTMIP_DEBOUNCE_CFG0);
 
-	val = readl(base + UTMIP_MISC_CFG0);
+	val = readl_relaxed(base + UTMIP_MISC_CFG0);
 	val &= ~UTMIP_SUSPEND_EXIT_ON_EDGE;
-	writel(val, base + UTMIP_MISC_CFG0);
+	writel_relaxed(val, base + UTMIP_MISC_CFG0);
 
 	if (!phy->soc_config->utmi_pll_config_in_car_module) {
-		val = readl(base + UTMIP_MISC_CFG1);
+		val = readl_relaxed(base + UTMIP_MISC_CFG1);
 		val &= ~(UTMIP_PLL_ACTIVE_DLY_COUNT(~0) |
 			UTMIP_PLLU_STABLE_COUNT(~0));
 		val |= UTMIP_PLL_ACTIVE_DLY_COUNT(phy->freq->active_delay) |
 			UTMIP_PLLU_STABLE_COUNT(phy->freq->stable_count);
-		writel(val, base + UTMIP_MISC_CFG1);
+		writel_relaxed(val, base + UTMIP_MISC_CFG1);
 
-		val = readl(base + UTMIP_PLL_CFG1);
+		val = readl_relaxed(base + UTMIP_PLL_CFG1);
 		val &= ~(UTMIP_XTAL_FREQ_COUNT(~0) |
 			UTMIP_PLLU_ENABLE_DLY_COUNT(~0));
 		val |= UTMIP_XTAL_FREQ_COUNT(phy->freq->xtal_freq_count) |
 			UTMIP_PLLU_ENABLE_DLY_COUNT(phy->freq->enable_delay);
-		writel(val, base + UTMIP_PLL_CFG1);
+		writel_relaxed(val, base + UTMIP_PLL_CFG1);
 	}
 
 	if (phy->mode == USB_DR_MODE_PERIPHERAL) {
-		val = readl(base + USB_SUSP_CTRL);
+		val = readl_relaxed(base + USB_SUSP_CTRL);
 		val &= ~(USB_WAKE_ON_CNNT_EN_DEV | USB_WAKE_ON_DISCON_EN_DEV);
-		writel(val, base + USB_SUSP_CTRL);
+		writel_relaxed(val, base + USB_SUSP_CTRL);
 
-		val = readl(base + UTMIP_BAT_CHRG_CFG0);
+		val = readl_relaxed(base + UTMIP_BAT_CHRG_CFG0);
 		val &= ~UTMIP_PD_CHRG;
-		writel(val, base + UTMIP_BAT_CHRG_CFG0);
+		writel_relaxed(val, base + UTMIP_BAT_CHRG_CFG0);
 	} else {
-		val = readl(base + UTMIP_BAT_CHRG_CFG0);
+		val = readl_relaxed(base + UTMIP_BAT_CHRG_CFG0);
 		val |= UTMIP_PD_CHRG;
-		writel(val, base + UTMIP_BAT_CHRG_CFG0);
+		writel_relaxed(val, base + UTMIP_BAT_CHRG_CFG0);
 	}
 
 	err = utmip_pad_power_on(phy);
 	if (err)
 		return err;
 
-	val = readl(base + UTMIP_XCVR_CFG0);
+	val = readl_relaxed(base + UTMIP_XCVR_CFG0);
 	val &= ~(UTMIP_FORCE_PD_POWERDOWN | UTMIP_FORCE_PD2_POWERDOWN |
 		 UTMIP_FORCE_PDZI_POWERDOWN | UTMIP_XCVR_LSBIAS_SEL |
 		 UTMIP_XCVR_SETUP(~0) | UTMIP_XCVR_SETUP_MSB(~0) |
@@ -548,57 +549,57 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 		val |= UTMIP_XCVR_HSSLEW(config->xcvr_hsslew);
 		val |= UTMIP_XCVR_HSSLEW_MSB(config->xcvr_hsslew);
 	}
-	writel(val, base + UTMIP_XCVR_CFG0);
+	writel_relaxed(val, base + UTMIP_XCVR_CFG0);
 
-	val = readl(base + UTMIP_XCVR_CFG1);
+	val = readl_relaxed(base + UTMIP_XCVR_CFG1);
 	val &= ~(UTMIP_FORCE_PDDISC_POWERDOWN | UTMIP_FORCE_PDCHRP_POWERDOWN |
 		 UTMIP_FORCE_PDDR_POWERDOWN | UTMIP_XCVR_TERM_RANGE_ADJ(~0));
 	val |= UTMIP_XCVR_TERM_RANGE_ADJ(config->term_range_adj);
-	writel(val, base + UTMIP_XCVR_CFG1);
+	writel_relaxed(val, base + UTMIP_XCVR_CFG1);
 
-	val = readl(base + UTMIP_BIAS_CFG1);
+	val = readl_relaxed(base + UTMIP_BIAS_CFG1);
 	val &= ~UTMIP_BIAS_PDTRK_COUNT(~0);
 	val |= UTMIP_BIAS_PDTRK_COUNT(0x5);
-	writel(val, base + UTMIP_BIAS_CFG1);
+	writel_relaxed(val, base + UTMIP_BIAS_CFG1);
 
-	val = readl(base + UTMIP_SPARE_CFG0);
+	val = readl_relaxed(base + UTMIP_SPARE_CFG0);
 	if (config->xcvr_setup_use_fuses)
 		val |= FUSE_SETUP_SEL;
 	else
 		val &= ~FUSE_SETUP_SEL;
-	writel(val, base + UTMIP_SPARE_CFG0);
+	writel_relaxed(val, base + UTMIP_SPARE_CFG0);
 
 	if (!phy->is_legacy_phy) {
-		val = readl(base + USB_SUSP_CTRL);
+		val = readl_relaxed(base + USB_SUSP_CTRL);
 		val |= UTMIP_PHY_ENABLE;
-		writel(val, base + USB_SUSP_CTRL);
+		writel_relaxed(val, base + USB_SUSP_CTRL);
 	}
 
-	val = readl(base + USB_SUSP_CTRL);
+	val = readl_relaxed(base + USB_SUSP_CTRL);
 	val &= ~UTMIP_RESET;
-	writel(val, base + USB_SUSP_CTRL);
+	writel_relaxed(val, base + USB_SUSP_CTRL);
 
 	if (phy->is_legacy_phy) {
-		val = readl(base + USB1_LEGACY_CTRL);
+		val = readl_relaxed(base + USB1_LEGACY_CTRL);
 		val &= ~USB1_VBUS_SENSE_CTL_MASK;
 		val |= USB1_VBUS_SENSE_CTL_A_SESS_VLD;
-		writel(val, base + USB1_LEGACY_CTRL);
+		writel_relaxed(val, base + USB1_LEGACY_CTRL);
 
-		val = readl(base + USB_SUSP_CTRL);
+		val = readl_relaxed(base + USB_SUSP_CTRL);
 		val &= ~USB_SUSP_SET;
-		writel(val, base + USB_SUSP_CTRL);
+		writel_relaxed(val, base + USB_SUSP_CTRL);
 	}
 
 	utmi_phy_clk_enable(phy);
 
 	if (phy->soc_config->requires_usbmode_setup) {
-		val = readl(base + USB_USBMODE);
+		val = readl_relaxed(base + USB_USBMODE);
 		val &= ~USB_USBMODE_MASK;
 		if (phy->mode == USB_DR_MODE_HOST)
 			val |= USB_USBMODE_HOST;
 		else
 			val |= USB_USBMODE_DEVICE;
-		writel(val, base + USB_USBMODE);
+		writel_relaxed(val, base + USB_USBMODE);
 	}
 
 	if (!phy->is_legacy_phy)
@@ -615,29 +616,29 @@ static int utmi_phy_power_off(struct tegra_usb_phy *phy)
 	utmi_phy_clk_disable(phy);
 
 	if (phy->mode == USB_DR_MODE_PERIPHERAL) {
-		val = readl(base + USB_SUSP_CTRL);
+		val = readl_relaxed(base + USB_SUSP_CTRL);
 		val &= ~USB_WAKEUP_DEBOUNCE_COUNT(~0);
 		val |= USB_WAKE_ON_CNNT_EN_DEV | USB_WAKEUP_DEBOUNCE_COUNT(5);
-		writel(val, base + USB_SUSP_CTRL);
+		writel_relaxed(val, base + USB_SUSP_CTRL);
 	}
 
-	val = readl(base + USB_SUSP_CTRL);
+	val = readl_relaxed(base + USB_SUSP_CTRL);
 	val |= UTMIP_RESET;
-	writel(val, base + USB_SUSP_CTRL);
+	writel_relaxed(val, base + USB_SUSP_CTRL);
 
-	val = readl(base + UTMIP_BAT_CHRG_CFG0);
+	val = readl_relaxed(base + UTMIP_BAT_CHRG_CFG0);
 	val |= UTMIP_PD_CHRG;
-	writel(val, base + UTMIP_BAT_CHRG_CFG0);
+	writel_relaxed(val, base + UTMIP_BAT_CHRG_CFG0);
 
-	val = readl(base + UTMIP_XCVR_CFG0);
+	val = readl_relaxed(base + UTMIP_XCVR_CFG0);
 	val |= UTMIP_FORCE_PD_POWERDOWN | UTMIP_FORCE_PD2_POWERDOWN |
 	       UTMIP_FORCE_PDZI_POWERDOWN;
-	writel(val, base + UTMIP_XCVR_CFG0);
+	writel_relaxed(val, base + UTMIP_XCVR_CFG0);
 
-	val = readl(base + UTMIP_XCVR_CFG1);
+	val = readl_relaxed(base + UTMIP_XCVR_CFG1);
 	val |= UTMIP_FORCE_PDDISC_POWERDOWN | UTMIP_FORCE_PDCHRP_POWERDOWN |
 	       UTMIP_FORCE_PDDR_POWERDOWN;
-	writel(val, base + UTMIP_XCVR_CFG1);
+	writel_relaxed(val, base + UTMIP_XCVR_CFG1);
 
 	return utmip_pad_power_off(phy);
 }
@@ -647,9 +648,9 @@ static void utmi_phy_preresume(struct tegra_usb_phy *phy)
 	void __iomem *base = phy->regs;
 	unsigned long val;
 
-	val = readl(base + UTMIP_TX_CFG0);
+	val = readl_relaxed(base + UTMIP_TX_CFG0);
 	val |= UTMIP_HS_DISCON_DISABLE;
-	writel(val, base + UTMIP_TX_CFG0);
+	writel_relaxed(val, base + UTMIP_TX_CFG0);
 }
 
 static void utmi_phy_postresume(struct tegra_usb_phy *phy)
@@ -657,9 +658,9 @@ static void utmi_phy_postresume(struct tegra_usb_phy *phy)
 	void __iomem *base = phy->regs;
 	unsigned long val;
 
-	val = readl(base + UTMIP_TX_CFG0);
+	val = readl_relaxed(base + UTMIP_TX_CFG0);
 	val &= ~UTMIP_HS_DISCON_DISABLE;
-	writel(val, base + UTMIP_TX_CFG0);
+	writel_relaxed(val, base + UTMIP_TX_CFG0);
 }
 
 static void utmi_phy_restore_start(struct tegra_usb_phy *phy,
@@ -668,18 +669,18 @@ static void utmi_phy_restore_start(struct tegra_usb_phy *phy,
 	void __iomem *base = phy->regs;
 	unsigned long val;
 
-	val = readl(base + UTMIP_MISC_CFG0);
+	val = readl_relaxed(base + UTMIP_MISC_CFG0);
 	val &= ~UTMIP_DPDM_OBSERVE_SEL(~0);
 	if (port_speed == TEGRA_USB_PHY_PORT_SPEED_LOW)
 		val |= UTMIP_DPDM_OBSERVE_SEL_FS_K;
 	else
 		val |= UTMIP_DPDM_OBSERVE_SEL_FS_J;
-	writel(val, base + UTMIP_MISC_CFG0);
+	writel_relaxed(val, base + UTMIP_MISC_CFG0);
 	usleep_range(1, 10);
 
-	val = readl(base + UTMIP_MISC_CFG0);
+	val = readl_relaxed(base + UTMIP_MISC_CFG0);
 	val |= UTMIP_DPDM_OBSERVE;
-	writel(val, base + UTMIP_MISC_CFG0);
+	writel_relaxed(val, base + UTMIP_MISC_CFG0);
 	usleep_range(10, 100);
 }
 
@@ -688,9 +689,9 @@ static void utmi_phy_restore_end(struct tegra_usb_phy *phy)
 	void __iomem *base = phy->regs;
 	unsigned long val;
 
-	val = readl(base + UTMIP_MISC_CFG0);
+	val = readl_relaxed(base + UTMIP_MISC_CFG0);
 	val &= ~UTMIP_DPDM_OBSERVE;
-	writel(val, base + UTMIP_MISC_CFG0);
+	writel_relaxed(val, base + UTMIP_MISC_CFG0);
 	usleep_range(10, 100);
 }
 
@@ -722,31 +723,31 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 
 	usleep_range(1000, 2000);
 
-	val = readl(base + USB_SUSP_CTRL);
+	val = readl_relaxed(base + USB_SUSP_CTRL);
 	val |= UHSIC_RESET;
-	writel(val, base + USB_SUSP_CTRL);
+	writel_relaxed(val, base + USB_SUSP_CTRL);
 
-	val = readl(base + ULPI_TIMING_CTRL_0);
+	val = readl_relaxed(base + ULPI_TIMING_CTRL_0);
 	val |= ULPI_OUTPUT_PINMUX_BYP | ULPI_CLKOUT_PINMUX_BYP;
-	writel(val, base + ULPI_TIMING_CTRL_0);
+	writel_relaxed(val, base + ULPI_TIMING_CTRL_0);
 
-	val = readl(base + USB_SUSP_CTRL);
+	val = readl_relaxed(base + USB_SUSP_CTRL);
 	val |= ULPI_PHY_ENABLE;
-	writel(val, base + USB_SUSP_CTRL);
+	writel_relaxed(val, base + USB_SUSP_CTRL);
 
 	val = 0;
-	writel(val, base + ULPI_TIMING_CTRL_1);
+	writel_relaxed(val, base + ULPI_TIMING_CTRL_1);
 
 	val |= ULPI_DATA_TRIMMER_SEL(4);
 	val |= ULPI_STPDIRNXT_TRIMMER_SEL(4);
 	val |= ULPI_DIR_TRIMMER_SEL(4);
-	writel(val, base + ULPI_TIMING_CTRL_1);
+	writel_relaxed(val, base + ULPI_TIMING_CTRL_1);
 	usleep_range(10, 100);
 
 	val |= ULPI_DATA_TRIMMER_LOAD;
 	val |= ULPI_STPDIRNXT_TRIMMER_LOAD;
 	val |= ULPI_DIR_TRIMMER_LOAD;
-	writel(val, base + ULPI_TIMING_CTRL_1);
+	writel_relaxed(val, base + ULPI_TIMING_CTRL_1);
 
 	/* Fix VbusInvalid due to floating VBUS */
 	err = usb_phy_io_write(phy->ulpi, 0x40, 0x08);
@@ -761,14 +762,14 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 		goto disable_clk;
 	}
 
-	val = readl(base + USB_SUSP_CTRL);
+	val = readl_relaxed(base + USB_SUSP_CTRL);
 	val |= USB_SUSP_CLR;
-	writel(val, base + USB_SUSP_CTRL);
+	writel_relaxed(val, base + USB_SUSP_CTRL);
 	usleep_range(100, 1000);
 
-	val = readl(base + USB_SUSP_CTRL);
+	val = readl_relaxed(base + USB_SUSP_CTRL);
 	val &= ~USB_SUSP_CLR;
-	writel(val, base + USB_SUSP_CTRL);
+	writel_relaxed(val, base + USB_SUSP_CTRL);
 
 	return 0;
 
-- 
2.24.0

