Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C584C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3190224685
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyap7UXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLTB4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:56:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33870 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfLTB4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:56:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so3503619ljg.1;
        Thu, 19 Dec 2019 17:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCl6o7h5Rkd8bSnSuz0v6K3MPmaJ5qy/xOEbuIrtDgo=;
        b=Eyap7UXAHkl5YWDi8xEz7ykj6urGAbZQvvsIA7mZDjbpYIOR2+A/pb9UhquTKRn1tJ
         QvPxvMFUa+0qfYFXY6WYrjOhXz7TBb4/jXBML76fY1HQRfnIssUgEW01tC5NddqD7gA/
         LuIJ3bmZHoC5catRGr5baOJEPLxite9++Qjqf73pbMDoNbaU/EpZXC+6cc/Rs+8zIpMe
         bJJQaxXy3ryzM4gaEAQsf8FgVJ5X12C/r4lw9z1dmUkH7d9x3S/pLov0PgV0syMaqgK3
         VTir/wt2gyiJAbyNpIPMZx5/0Nqa3pJBx0zBc7JxDH8kxeyj+D4G9qVKVxqBWOCubcxb
         f+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCl6o7h5Rkd8bSnSuz0v6K3MPmaJ5qy/xOEbuIrtDgo=;
        b=tj7FUSEUBDqFRjGJKEgd58zY4nQi91/U7K7oEISLUIIA9QnQzYkzRcT3NlrcUMGPSF
         9+yoD8tbsx6s/DYzNf9GUs8HVo2lHKOozaCPoo6gD7uunnZFIi5LME69UAd4qs03f4/d
         INz/OjCQ+hpWz+usPWc7wrPC2npjwF7EvEQkyOBr8IP7U9RAeVkF2hdZmca4GBGkx38W
         ykN/12UXtrsElcMBg93T1Uj4FaBrX4NfYgl+sts7OO4VPX3qE+VXVZu/TJAsseJSw9P/
         dfiEYAAAO1Ixp0k+MT50/mvEGcE/Dmgf5Y/WjRdhgu45z8LYv/0ykWzAhhj7vy2vrZsZ
         DnQg==
X-Gm-Message-State: APjAAAWteSTn7864T4rOfn7uFVlfQQzkuFliMJ+u0Nd1HmA4CHUXbZOX
        Y8hVuWEkizisHWOHy4J+jig=
X-Google-Smtp-Source: APXvYqz84Hw2xNF06tXP6gA9HN23vKCgrUFj6e1hy6MF4Gq1CENdHhbZyAQAgvraDW7VWVOfssSCQg==
X-Received: by 2002:a2e:7311:: with SMTP id o17mr8216174ljc.197.1576806967652;
        Thu, 19 Dec 2019 17:56:07 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m13sm3270901lfo.40.2019.12.19.17.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 17:56:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] usb: phy: tegra: Perform general clean up of the code
Date:   Fri, 20 Dec 2019 04:52:31 +0300
Message-Id: <20191220015238.9228-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220015238.9228-1-digetx@gmail.com>
References: <20191220015238.9228-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes few dozens of legit checkpatch warnings, adds missed
handling of potential error-cases, fixes ULPI clk-prepare refcounting and
prettifies code where makes sense. All these clean-up changes are quite
minor and do not fix any real problems.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 365 +++++++++++++++++---------------
 1 file changed, 195 insertions(+), 170 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 12d6f6433365..50b9d4574608 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -28,35 +28,35 @@
 #include <linux/usb/tegra_usb_phy.h>
 #include <linux/regulator/consumer.h>
 
-#define ULPI_VIEWPORT		0x170
+#define ULPI_VIEWPORT				0x170
 
 /* PORTSC PTS/PHCD bits, Tegra20 only */
-#define TEGRA_USB_PORTSC1				0x184
-#define TEGRA_USB_PORTSC1_PTS(x)			(((x) & 0x3) << 30)
-#define TEGRA_USB_PORTSC1_PHCD				(1 << 23)
+#define TEGRA_USB_PORTSC1			0x184
+#define TEGRA_USB_PORTSC1_PTS(x)		(((x) & 0x3) << 30)
+#define TEGRA_USB_PORTSC1_PHCD			BIT(23)
 
 /* HOSTPC1 PTS/PHCD bits, Tegra30 and above */
-#define TEGRA_USB_HOSTPC1_DEVLC		0x1b4
-#define TEGRA_USB_HOSTPC1_DEVLC_PTS(x)	(((x) & 0x7) << 29)
-#define TEGRA_USB_HOSTPC1_DEVLC_PHCD	(1 << 22)
+#define TEGRA_USB_HOSTPC1_DEVLC			0x1b4
+#define TEGRA_USB_HOSTPC1_DEVLC_PTS(x)		(((x) & 0x7) << 29)
+#define TEGRA_USB_HOSTPC1_DEVLC_PHCD		BIT(22)
 
 /* Bits of PORTSC1, which will get cleared by writing 1 into them */
 #define TEGRA_PORTSC1_RWC_BITS	(PORT_CSC | PORT_PEC | PORT_OCC)
 
-#define USB_SUSP_CTRL		0x400
-#define   USB_WAKE_ON_CNNT_EN_DEV	(1 << 3)
-#define   USB_WAKE_ON_DISCON_EN_DEV	(1 << 4)
-#define   USB_SUSP_CLR		(1 << 5)
-#define   USB_PHY_CLK_VALID	(1 << 7)
-#define   UTMIP_RESET			(1 << 11)
-#define   UHSIC_RESET			(1 << 11)
-#define   UTMIP_PHY_ENABLE		(1 << 12)
-#define   ULPI_PHY_ENABLE	(1 << 13)
-#define   USB_SUSP_SET		(1 << 14)
-#define   USB_WAKEUP_DEBOUNCE_COUNT(x)	(((x) & 0x7) << 16)
-
-#define USB1_LEGACY_CTRL	0x410
-#define   USB1_NO_LEGACY_MODE			(1 << 0)
+#define USB_SUSP_CTRL				0x400
+#define   USB_WAKE_ON_CNNT_EN_DEV		BIT(3)
+#define   USB_WAKE_ON_DISCON_EN_DEV		BIT(4)
+#define   USB_SUSP_CLR				BIT(5)
+#define   USB_PHY_CLK_VALID			BIT(7)
+#define   UTMIP_RESET				BIT(11)
+#define   UHSIC_RESET				BIT(11)
+#define   UTMIP_PHY_ENABLE			BIT(12)
+#define   ULPI_PHY_ENABLE			BIT(13)
+#define   USB_SUSP_SET				BIT(14)
+#define   USB_WAKEUP_DEBOUNCE_COUNT(x)		(((x) & 0x7) << 16)
+
+#define USB1_LEGACY_CTRL			0x410
+#define   USB1_NO_LEGACY_MODE			BIT(0)
 #define   USB1_VBUS_SENSE_CTL_MASK		(3 << 1)
 #define   USB1_VBUS_SENSE_CTL_VBUS_WAKEUP	(0 << 1)
 #define   USB1_VBUS_SENSE_CTL_AB_SESS_VLD_OR_VBUS_WAKEUP \
@@ -64,88 +64,88 @@
 #define   USB1_VBUS_SENSE_CTL_AB_SESS_VLD	(2 << 1)
 #define   USB1_VBUS_SENSE_CTL_A_SESS_VLD	(3 << 1)
 
-#define ULPI_TIMING_CTRL_0	0x424
-#define   ULPI_OUTPUT_PINMUX_BYP	(1 << 10)
-#define   ULPI_CLKOUT_PINMUX_BYP	(1 << 11)
+#define ULPI_TIMING_CTRL_0			0x424
+#define   ULPI_OUTPUT_PINMUX_BYP		BIT(10)
+#define   ULPI_CLKOUT_PINMUX_BYP		BIT(11)
 
-#define ULPI_TIMING_CTRL_1	0x428
-#define   ULPI_DATA_TRIMMER_LOAD	(1 << 0)
-#define   ULPI_DATA_TRIMMER_SEL(x)	(((x) & 0x7) << 1)
-#define   ULPI_STPDIRNXT_TRIMMER_LOAD	(1 << 16)
-#define   ULPI_STPDIRNXT_TRIMMER_SEL(x)	(((x) & 0x7) << 17)
-#define   ULPI_DIR_TRIMMER_LOAD		(1 << 24)
-#define   ULPI_DIR_TRIMMER_SEL(x)	(((x) & 0x7) << 25)
+#define ULPI_TIMING_CTRL_1			0x428
+#define   ULPI_DATA_TRIMMER_LOAD		BIT(0)
+#define   ULPI_DATA_TRIMMER_SEL(x)		(((x) & 0x7) << 1)
+#define   ULPI_STPDIRNXT_TRIMMER_LOAD		BIT(16)
+#define   ULPI_STPDIRNXT_TRIMMER_SEL(x)		(((x) & 0x7) << 17)
+#define   ULPI_DIR_TRIMMER_LOAD			BIT(24)
+#define   ULPI_DIR_TRIMMER_SEL(x)		(((x) & 0x7) << 25)
 
-#define UTMIP_PLL_CFG1		0x804
+#define UTMIP_PLL_CFG1				0x804
 #define   UTMIP_XTAL_FREQ_COUNT(x)		(((x) & 0xfff) << 0)
 #define   UTMIP_PLLU_ENABLE_DLY_COUNT(x)	(((x) & 0x1f) << 27)
 
-#define UTMIP_XCVR_CFG0		0x808
+#define UTMIP_XCVR_CFG0				0x808
 #define   UTMIP_XCVR_SETUP(x)			(((x) & 0xf) << 0)
 #define   UTMIP_XCVR_SETUP_MSB(x)		((((x) & 0x70) >> 4) << 22)
 #define   UTMIP_XCVR_LSRSLEW(x)			(((x) & 0x3) << 8)
 #define   UTMIP_XCVR_LSFSLEW(x)			(((x) & 0x3) << 10)
-#define   UTMIP_FORCE_PD_POWERDOWN		(1 << 14)
-#define   UTMIP_FORCE_PD2_POWERDOWN		(1 << 16)
-#define   UTMIP_FORCE_PDZI_POWERDOWN		(1 << 18)
-#define   UTMIP_XCVR_LSBIAS_SEL			(1 << 21)
+#define   UTMIP_FORCE_PD_POWERDOWN		BIT(14)
+#define   UTMIP_FORCE_PD2_POWERDOWN		BIT(16)
+#define   UTMIP_FORCE_PDZI_POWERDOWN		BIT(18)
+#define   UTMIP_XCVR_LSBIAS_SEL			BIT(21)
 #define   UTMIP_XCVR_HSSLEW(x)			(((x) & 0x3) << 4)
 #define   UTMIP_XCVR_HSSLEW_MSB(x)		((((x) & 0x1fc) >> 2) << 25)
 
-#define UTMIP_BIAS_CFG0		0x80c
-#define   UTMIP_OTGPD			(1 << 11)
-#define   UTMIP_BIASPD			(1 << 10)
-#define   UTMIP_HSSQUELCH_LEVEL(x)	(((x) & 0x3) << 0)
-#define   UTMIP_HSDISCON_LEVEL(x)	(((x) & 0x3) << 2)
-#define   UTMIP_HSDISCON_LEVEL_MSB(x)	((((x) & 0x4) >> 2) << 24)
+#define UTMIP_BIAS_CFG0				0x80c
+#define   UTMIP_OTGPD				BIT(11)
+#define   UTMIP_BIASPD				BIT(10)
+#define   UTMIP_HSSQUELCH_LEVEL(x)		(((x) & 0x3) << 0)
+#define   UTMIP_HSDISCON_LEVEL(x)		(((x) & 0x3) << 2)
+#define   UTMIP_HSDISCON_LEVEL_MSB(x)		((((x) & 0x4) >> 2) << 24)
 
-#define UTMIP_HSRX_CFG0		0x810
-#define   UTMIP_ELASTIC_LIMIT(x)	(((x) & 0x1f) << 10)
-#define   UTMIP_IDLE_WAIT(x)		(((x) & 0x1f) << 15)
+#define UTMIP_HSRX_CFG0				0x810
+#define   UTMIP_ELASTIC_LIMIT(x)		(((x) & 0x1f) << 10)
+#define   UTMIP_IDLE_WAIT(x)			(((x) & 0x1f) << 15)
 
-#define UTMIP_HSRX_CFG1		0x814
-#define   UTMIP_HS_SYNC_START_DLY(x)	(((x) & 0x1f) << 1)
+#define UTMIP_HSRX_CFG1				0x814
+#define   UTMIP_HS_SYNC_START_DLY(x)		(((x) & 0x1f) << 1)
 
-#define UTMIP_TX_CFG0		0x820
-#define   UTMIP_FS_PREABMLE_J		(1 << 19)
-#define   UTMIP_HS_DISCON_DISABLE	(1 << 8)
+#define UTMIP_TX_CFG0				0x820
+#define   UTMIP_FS_PREABMLE_J			BIT(19)
+#define   UTMIP_HS_DISCON_DISABLE		BIT(8)
 
-#define UTMIP_MISC_CFG0		0x824
-#define   UTMIP_DPDM_OBSERVE		(1 << 26)
-#define   UTMIP_DPDM_OBSERVE_SEL(x)	(((x) & 0xf) << 27)
-#define   UTMIP_DPDM_OBSERVE_SEL_FS_J	UTMIP_DPDM_OBSERVE_SEL(0xf)
-#define   UTMIP_DPDM_OBSERVE_SEL_FS_K	UTMIP_DPDM_OBSERVE_SEL(0xe)
-#define   UTMIP_DPDM_OBSERVE_SEL_FS_SE1 UTMIP_DPDM_OBSERVE_SEL(0xd)
-#define   UTMIP_DPDM_OBSERVE_SEL_FS_SE0 UTMIP_DPDM_OBSERVE_SEL(0xc)
-#define   UTMIP_SUSPEND_EXIT_ON_EDGE	(1 << 22)
+#define UTMIP_MISC_CFG0				0x824
+#define   UTMIP_DPDM_OBSERVE			BIT(26)
+#define   UTMIP_DPDM_OBSERVE_SEL(x)		(((x) & 0xf) << 27)
+#define   UTMIP_DPDM_OBSERVE_SEL_FS_J		UTMIP_DPDM_OBSERVE_SEL(0xf)
+#define   UTMIP_DPDM_OBSERVE_SEL_FS_K		UTMIP_DPDM_OBSERVE_SEL(0xe)
+#define   UTMIP_DPDM_OBSERVE_SEL_FS_SE1		UTMIP_DPDM_OBSERVE_SEL(0xd)
+#define   UTMIP_DPDM_OBSERVE_SEL_FS_SE0		UTMIP_DPDM_OBSERVE_SEL(0xc)
+#define   UTMIP_SUSPEND_EXIT_ON_EDGE		BIT(22)
 
-#define UTMIP_MISC_CFG1		0x828
-#define   UTMIP_PLL_ACTIVE_DLY_COUNT(x)	(((x) & 0x1f) << 18)
-#define   UTMIP_PLLU_STABLE_COUNT(x)	(((x) & 0xfff) << 6)
+#define UTMIP_MISC_CFG1				0x828
+#define   UTMIP_PLL_ACTIVE_DLY_COUNT(x)		(((x) & 0x1f) << 18)
+#define   UTMIP_PLLU_STABLE_COUNT(x)		(((x) & 0xfff) << 6)
 
-#define UTMIP_DEBOUNCE_CFG0	0x82c
-#define   UTMIP_BIAS_DEBOUNCE_A(x)	(((x) & 0xffff) << 0)
+#define UTMIP_DEBOUNCE_CFG0			0x82c
+#define   UTMIP_BIAS_DEBOUNCE_A(x)		(((x) & 0xffff) << 0)
 
-#define UTMIP_BAT_CHRG_CFG0	0x830
-#define   UTMIP_PD_CHRG			(1 << 0)
+#define UTMIP_BAT_CHRG_CFG0			0x830
+#define   UTMIP_PD_CHRG				BIT(0)
 
-#define UTMIP_SPARE_CFG0	0x834
-#define   FUSE_SETUP_SEL		(1 << 3)
+#define UTMIP_SPARE_CFG0			0x834
+#define   FUSE_SETUP_SEL			BIT(3)
 
-#define UTMIP_XCVR_CFG1		0x838
-#define   UTMIP_FORCE_PDDISC_POWERDOWN	(1 << 0)
-#define   UTMIP_FORCE_PDCHRP_POWERDOWN	(1 << 2)
-#define   UTMIP_FORCE_PDDR_POWERDOWN	(1 << 4)
-#define   UTMIP_XCVR_TERM_RANGE_ADJ(x)	(((x) & 0xf) << 18)
+#define UTMIP_XCVR_CFG1				0x838
+#define   UTMIP_FORCE_PDDISC_POWERDOWN		BIT(0)
+#define   UTMIP_FORCE_PDCHRP_POWERDOWN		BIT(2)
+#define   UTMIP_FORCE_PDDR_POWERDOWN		BIT(4)
+#define   UTMIP_XCVR_TERM_RANGE_ADJ(x)		(((x) & 0xf) << 18)
 
-#define UTMIP_BIAS_CFG1		0x83c
-#define   UTMIP_BIAS_PDTRK_COUNT(x)	(((x) & 0x1f) << 3)
+#define UTMIP_BIAS_CFG1				0x83c
+#define   UTMIP_BIAS_PDTRK_COUNT(x)		(((x) & 0x1f) << 3)
 
 /* For Tegra30 and above only, the address is different in Tegra20 */
-#define USB_USBMODE		0x1f8
-#define   USB_USBMODE_MASK		(3 << 0)
-#define   USB_USBMODE_HOST		(3 << 0)
-#define   USB_USBMODE_DEVICE		(2 << 0)
+#define USB_USBMODE				0x1f8
+#define   USB_USBMODE_MASK			(3 << 0)
+#define   USB_USBMODE_HOST			(3 << 0)
+#define   USB_USBMODE_DEVICE			(2 << 0)
 
 static DEFINE_SPINLOCK(utmip_pad_lock);
 static int utmip_pad_count;
@@ -194,6 +194,11 @@ static const struct tegra_xtal_freq tegra_freq_table[] = {
 	},
 };
 
+static inline struct tegra_usb_phy *to_tegra_usb_phy(struct usb_phy *u_phy)
+{
+	return container_of(u_phy, struct tegra_usb_phy, u_phy);
+}
+
 static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
 {
 	void __iomem *base = phy->regs;
@@ -310,13 +315,16 @@ static void ulpi_close(struct tegra_usb_phy *phy)
 	}
 }
 
-static void utmip_pad_power_on(struct tegra_usb_phy *phy)
+static int utmip_pad_power_on(struct tegra_usb_phy *phy)
 {
-	unsigned long val, flags;
-	void __iomem *base = phy->pad_regs;
 	struct tegra_utmip_config *config = phy->config;
+	void __iomem *base = phy->pad_regs;
+	unsigned long val, flags;
+	int err;
 
-	clk_prepare_enable(phy->pad_clk);
+	err = clk_prepare_enable(phy->pad_clk);
+	if (err)
+		return err;
 
 	spin_lock_irqsave(&utmip_pad_lock, flags);
 
@@ -339,19 +347,24 @@ static void utmip_pad_power_on(struct tegra_usb_phy *phy)
 	spin_unlock_irqrestore(&utmip_pad_lock, flags);
 
 	clk_disable_unprepare(phy->pad_clk);
+
+	return 0;
 }
 
 static int utmip_pad_power_off(struct tegra_usb_phy *phy)
 {
-	unsigned long val, flags;
 	void __iomem *base = phy->pad_regs;
+	unsigned long val, flags;
+	int err;
 
 	if (!utmip_pad_count) {
 		dev_err(phy->u_phy.dev, "UTMIP pad already powered off\n");
 		return -EINVAL;
 	}
 
-	clk_prepare_enable(phy->pad_clk);
+	err = clk_prepare_enable(phy->pad_clk);
+	if (err)
+		return err;
 
 	spin_lock_irqsave(&utmip_pad_lock, flags);
 
@@ -378,8 +391,8 @@ static int utmi_wait_register(void __iomem *reg, u32 mask, u32 result)
 
 static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
 {
-	unsigned long val;
 	void __iomem *base = phy->regs;
+	unsigned long val;
 
 	/*
 	 * The USB driver may have already initiated the phy clock
@@ -394,13 +407,14 @@ static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
 		val |= USB_SUSP_SET;
 		writel(val, base + USB_SUSP_CTRL);
 
-		udelay(10);
+		usleep_range(10, 100);
 
 		val = readl(base + USB_SUSP_CTRL);
 		val &= ~USB_SUSP_SET;
 		writel(val, base + USB_SUSP_CTRL);
-	} else
+	} else {
 		set_phcd(phy, true);
+	}
 
 	if (utmi_wait_register(base + USB_SUSP_CTRL, USB_PHY_CLK_VALID, 0) < 0)
 		dev_err(phy->u_phy.dev,
@@ -409,8 +423,8 @@ static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
 
 static void utmi_phy_clk_enable(struct tegra_usb_phy *phy)
 {
-	unsigned long val;
 	void __iomem *base = phy->regs;
+	unsigned long val;
 
 	/*
 	 * The USB driver may have already initiated the phy clock
@@ -426,25 +440,27 @@ static void utmi_phy_clk_enable(struct tegra_usb_phy *phy)
 		val |= USB_SUSP_CLR;
 		writel(val, base + USB_SUSP_CTRL);
 
-		udelay(10);
+		usleep_range(10, 100);
 
 		val = readl(base + USB_SUSP_CTRL);
 		val &= ~USB_SUSP_CLR;
 		writel(val, base + USB_SUSP_CTRL);
-	} else
+	} else {
 		set_phcd(phy, false);
+	}
 
-	if (utmi_wait_register(base + USB_SUSP_CTRL, USB_PHY_CLK_VALID,
-						     USB_PHY_CLK_VALID))
+	if (utmi_wait_register(base + USB_SUSP_CTRL,
+			       USB_PHY_CLK_VALID, USB_PHY_CLK_VALID))
 		dev_err(phy->u_phy.dev,
 			"Timeout waiting for PHY to stabilize on enable\n");
 }
 
 static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 {
-	unsigned long val;
-	void __iomem *base = phy->regs;
 	struct tegra_utmip_config *config = phy->config;
+	void __iomem *base = phy->regs;
+	unsigned long val;
+	int err;
 
 	val = readl(base + USB_SUSP_CTRL);
 	val |= UTMIP_RESET;
@@ -510,7 +526,9 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 		writel(val, base + UTMIP_BAT_CHRG_CFG0);
 	}
 
-	utmip_pad_power_on(phy);
+	err = utmip_pad_power_on(phy);
+	if (err)
+		return err;
 
 	val = readl(base + UTMIP_XCVR_CFG0);
 	val &= ~(UTMIP_FORCE_PD_POWERDOWN | UTMIP_FORCE_PD2_POWERDOWN |
@@ -591,8 +609,8 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 
 static int utmi_phy_power_off(struct tegra_usb_phy *phy)
 {
-	unsigned long val;
 	void __iomem *base = phy->regs;
+	unsigned long val;
 
 	utmi_phy_clk_disable(phy);
 
@@ -626,8 +644,8 @@ static int utmi_phy_power_off(struct tegra_usb_phy *phy)
 
 static void utmi_phy_preresume(struct tegra_usb_phy *phy)
 {
-	unsigned long val;
 	void __iomem *base = phy->regs;
+	unsigned long val;
 
 	val = readl(base + UTMIP_TX_CFG0);
 	val |= UTMIP_HS_DISCON_DISABLE;
@@ -636,8 +654,8 @@ static void utmi_phy_preresume(struct tegra_usb_phy *phy)
 
 static void utmi_phy_postresume(struct tegra_usb_phy *phy)
 {
-	unsigned long val;
 	void __iomem *base = phy->regs;
+	unsigned long val;
 
 	val = readl(base + UTMIP_TX_CFG0);
 	val &= ~UTMIP_HS_DISCON_DISABLE;
@@ -647,8 +665,8 @@ static void utmi_phy_postresume(struct tegra_usb_phy *phy)
 static void utmi_phy_restore_start(struct tegra_usb_phy *phy,
 				   enum tegra_usb_phy_port_speed port_speed)
 {
-	unsigned long val;
 	void __iomem *base = phy->regs;
+	unsigned long val;
 
 	val = readl(base + UTMIP_MISC_CFG0);
 	val &= ~UTMIP_DPDM_OBSERVE_SEL(~0);
@@ -657,47 +675,52 @@ static void utmi_phy_restore_start(struct tegra_usb_phy *phy,
 	else
 		val |= UTMIP_DPDM_OBSERVE_SEL_FS_J;
 	writel(val, base + UTMIP_MISC_CFG0);
-	udelay(1);
+	usleep_range(1, 10);
 
 	val = readl(base + UTMIP_MISC_CFG0);
 	val |= UTMIP_DPDM_OBSERVE;
 	writel(val, base + UTMIP_MISC_CFG0);
-	udelay(10);
+	usleep_range(10, 100);
 }
 
 static void utmi_phy_restore_end(struct tegra_usb_phy *phy)
 {
-	unsigned long val;
 	void __iomem *base = phy->regs;
+	unsigned long val;
 
 	val = readl(base + UTMIP_MISC_CFG0);
 	val &= ~UTMIP_DPDM_OBSERVE;
 	writel(val, base + UTMIP_MISC_CFG0);
-	udelay(10);
+	usleep_range(10, 100);
 }
 
 static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 {
-	int ret;
-	unsigned long val;
 	void __iomem *base = phy->regs;
+	unsigned long val;
+	int err;
 
-	ret = gpio_direction_output(phy->reset_gpio, 0);
-	if (ret < 0) {
+	err = gpio_direction_output(phy->reset_gpio, 0);
+	if (err < 0) {
 		dev_err(phy->u_phy.dev, "GPIO %d not set to 0: %d\n",
-			phy->reset_gpio, ret);
-		return ret;
+			phy->reset_gpio, err);
+		return err;
 	}
-	msleep(5);
-	ret = gpio_direction_output(phy->reset_gpio, 1);
-	if (ret < 0) {
+
+	err = clk_prepare_enable(phy->clk);
+	if (err)
+		return err;
+
+	usleep_range(5000, 10000);
+
+	err = gpio_direction_output(phy->reset_gpio, 1);
+	if (err < 0) {
 		dev_err(phy->u_phy.dev, "GPIO %d not set to 1: %d\n",
-			phy->reset_gpio, ret);
-		return ret;
+			phy->reset_gpio, err);
+		goto disable_clk;
 	}
 
-	clk_prepare_enable(phy->clk);
-	msleep(1);
+	usleep_range(1000, 2000);
 
 	val = readl(base + USB_SUSP_CTRL);
 	val |= UHSIC_RESET;
@@ -718,7 +741,7 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 	val |= ULPI_STPDIRNXT_TRIMMER_SEL(4);
 	val |= ULPI_DIR_TRIMMER_SEL(4);
 	writel(val, base + ULPI_TIMING_CTRL_1);
-	udelay(10);
+	usleep_range(10, 100);
 
 	val |= ULPI_DATA_TRIMMER_LOAD;
 	val |= ULPI_STPDIRNXT_TRIMMER_LOAD;
@@ -726,40 +749,45 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 	writel(val, base + ULPI_TIMING_CTRL_1);
 
 	/* Fix VbusInvalid due to floating VBUS */
-	ret = usb_phy_io_write(phy->ulpi, 0x40, 0x08);
-	if (ret) {
-		dev_err(phy->u_phy.dev, "ULPI write failed: %d\n", ret);
-		return ret;
+	err = usb_phy_io_write(phy->ulpi, 0x40, 0x08);
+	if (err) {
+		dev_err(phy->u_phy.dev, "ULPI write failed: %d\n", err);
+		goto disable_clk;
 	}
 
-	ret = usb_phy_io_write(phy->ulpi, 0x80, 0x0B);
-	if (ret) {
-		dev_err(phy->u_phy.dev, "ULPI write failed: %d\n", ret);
-		return ret;
+	err = usb_phy_io_write(phy->ulpi, 0x80, 0x0B);
+	if (err) {
+		dev_err(phy->u_phy.dev, "ULPI write failed: %d\n", err);
+		goto disable_clk;
 	}
 
 	val = readl(base + USB_SUSP_CTRL);
 	val |= USB_SUSP_CLR;
 	writel(val, base + USB_SUSP_CTRL);
-	udelay(100);
+	usleep_range(100, 1000);
 
 	val = readl(base + USB_SUSP_CTRL);
 	val &= ~USB_SUSP_CLR;
 	writel(val, base + USB_SUSP_CTRL);
 
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(phy->clk);
+
+	return err;
 }
 
 static int ulpi_phy_power_off(struct tegra_usb_phy *phy)
 {
-	clk_disable(phy->clk);
+	clk_disable_unprepare(phy->clk);
+
 	return gpio_direction_output(phy->reset_gpio, 0);
 }
 
 static void tegra_usb_phy_shutdown(struct usb_phy *u_phy)
 {
-	struct tegra_usb_phy *phy = container_of(u_phy, struct tegra_usb_phy,
-						 u_phy);
+	struct tegra_usb_phy *phy = to_tegra_usb_phy(u_phy);
 
 	if (WARN_ON(!phy->freq))
 		return;
@@ -793,9 +821,9 @@ static int tegra_usb_phy_power_off(struct tegra_usb_phy *phy)
 		return utmi_phy_power_off(phy);
 }
 
-static int tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
+static int tegra_usb_phy_suspend(struct usb_phy *u_phy, int suspend)
 {
-	struct tegra_usb_phy *phy = container_of(x, struct tegra_usb_phy, u_phy);
+	struct tegra_usb_phy *phy = to_tegra_usb_phy(u_phy);
 
 	if (WARN_ON(!phy->freq))
 		return -EINVAL;
@@ -823,10 +851,9 @@ static int ulpi_open(struct tegra_usb_phy *phy)
 
 static int tegra_usb_phy_init(struct usb_phy *u_phy)
 {
-	struct tegra_usb_phy *phy = container_of(u_phy, struct tegra_usb_phy,
-						 u_phy);
+	struct tegra_usb_phy *phy = to_tegra_usb_phy(u_phy);
 	unsigned long parent_rate;
-	int i;
+	unsigned int i;
 	int err;
 
 	if (WARN_ON(phy->freq))
@@ -886,37 +913,37 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
 	return err;
 }
 
-void tegra_usb_phy_preresume(struct usb_phy *x)
+void tegra_usb_phy_preresume(struct usb_phy *u_phy)
 {
-	struct tegra_usb_phy *phy = container_of(x, struct tegra_usb_phy, u_phy);
+	struct tegra_usb_phy *phy = to_tegra_usb_phy(u_phy);
 
 	if (!phy->is_ulpi_phy)
 		utmi_phy_preresume(phy);
 }
 EXPORT_SYMBOL_GPL(tegra_usb_phy_preresume);
 
-void tegra_usb_phy_postresume(struct usb_phy *x)
+void tegra_usb_phy_postresume(struct usb_phy *u_phy)
 {
-	struct tegra_usb_phy *phy = container_of(x, struct tegra_usb_phy, u_phy);
+	struct tegra_usb_phy *phy = to_tegra_usb_phy(u_phy);
 
 	if (!phy->is_ulpi_phy)
 		utmi_phy_postresume(phy);
 }
 EXPORT_SYMBOL_GPL(tegra_usb_phy_postresume);
 
-void tegra_ehci_phy_restore_start(struct usb_phy *x,
-				 enum tegra_usb_phy_port_speed port_speed)
+void tegra_ehci_phy_restore_start(struct usb_phy *u_phy,
+				  enum tegra_usb_phy_port_speed port_speed)
 {
-	struct tegra_usb_phy *phy = container_of(x, struct tegra_usb_phy, u_phy);
+	struct tegra_usb_phy *phy = to_tegra_usb_phy(u_phy);
 
 	if (!phy->is_ulpi_phy)
 		utmi_phy_restore_start(phy, port_speed);
 }
 EXPORT_SYMBOL_GPL(tegra_ehci_phy_restore_start);
 
-void tegra_ehci_phy_restore_end(struct usb_phy *x)
+void tegra_ehci_phy_restore_end(struct usb_phy *u_phy)
 {
-	struct tegra_usb_phy *phy = container_of(x, struct tegra_usb_phy, u_phy);
+	struct tegra_usb_phy *phy = to_tegra_usb_phy(u_phy);
 
 	if (!phy->is_ulpi_phy)
 		utmi_phy_restore_end(phy);
@@ -927,21 +954,25 @@ static int read_utmi_param(struct platform_device *pdev, const char *param,
 			   u8 *dest)
 {
 	u32 value;
-	int err = of_property_read_u32(pdev->dev.of_node, param, &value);
-	*dest = (u8)value;
+	int err;
+
+	err = of_property_read_u32(pdev->dev.of_node, param, &value);
 	if (err < 0)
 		dev_err(&pdev->dev,
 			"Failed to read USB UTMI parameter %s: %d\n",
 			param, err);
+	else
+		*dest = (u8)value;
+
 	return err;
 }
 
 static int utmi_phy_probe(struct tegra_usb_phy *tegra_phy,
 			  struct platform_device *pdev)
 {
+	struct tegra_utmip_config *config;
 	struct resource *res;
 	int err;
-	struct tegra_utmip_config *config;
 
 	tegra_phy->is_ulpi_phy = false;
 
@@ -952,7 +983,7 @@ static int utmi_phy_probe(struct tegra_usb_phy *tegra_phy,
 	}
 
 	tegra_phy->pad_regs = devm_ioremap(&pdev->dev, res->start,
-		resource_size(res));
+					   resource_size(res));
 	if (!tegra_phy->pad_regs) {
 		dev_err(&pdev->dev, "Failed to remap UTMI pad regs\n");
 		return -ENOMEM;
@@ -966,48 +997,48 @@ static int utmi_phy_probe(struct tegra_usb_phy *tegra_phy,
 	config = tegra_phy->config;
 
 	err = read_utmi_param(pdev, "nvidia,hssync-start-delay",
-		&config->hssync_start_delay);
+			      &config->hssync_start_delay);
 	if (err < 0)
 		return err;
 
 	err = read_utmi_param(pdev, "nvidia,elastic-limit",
-		&config->elastic_limit);
+			      &config->elastic_limit);
 	if (err < 0)
 		return err;
 
 	err = read_utmi_param(pdev, "nvidia,idle-wait-delay",
-		&config->idle_wait_delay);
+			      &config->idle_wait_delay);
 	if (err < 0)
 		return err;
 
 	err = read_utmi_param(pdev, "nvidia,term-range-adj",
-		&config->term_range_adj);
+			      &config->term_range_adj);
 	if (err < 0)
 		return err;
 
 	err = read_utmi_param(pdev, "nvidia,xcvr-lsfslew",
-		&config->xcvr_lsfslew);
+			      &config->xcvr_lsfslew);
 	if (err < 0)
 		return err;
 
 	err = read_utmi_param(pdev, "nvidia,xcvr-lsrslew",
-		&config->xcvr_lsrslew);
+			      &config->xcvr_lsrslew);
 	if (err < 0)
 		return err;
 
 	if (tegra_phy->soc_config->requires_extra_tuning_parameters) {
 		err = read_utmi_param(pdev, "nvidia,xcvr-hsslew",
-			&config->xcvr_hsslew);
+				      &config->xcvr_hsslew);
 		if (err < 0)
 			return err;
 
 		err = read_utmi_param(pdev, "nvidia,hssquelch-level",
-			&config->hssquelch_level);
+				      &config->hssquelch_level);
 		if (err < 0)
 			return err;
 
 		err = read_utmi_param(pdev, "nvidia,hsdiscon-level",
-			&config->hsdiscon_level);
+				      &config->hsdiscon_level);
 		if (err < 0)
 			return err;
 	}
@@ -1017,7 +1048,7 @@ static int utmi_phy_probe(struct tegra_usb_phy *tegra_phy,
 
 	if (!config->xcvr_setup_use_fuses) {
 		err = read_utmi_param(pdev, "nvidia,xcvr-setup",
-			&config->xcvr_setup);
+				      &config->xcvr_setup);
 		if (err < 0)
 			return err;
 	}
@@ -1048,23 +1079,17 @@ MODULE_DEVICE_TABLE(of, tegra_usb_phy_id_table);
 
 static int tegra_usb_phy_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
-	struct resource *res;
-	struct tegra_usb_phy *tegra_phy = NULL;
 	struct device_node *np = pdev->dev.of_node;
+	struct tegra_usb_phy *tegra_phy;
 	enum usb_phy_interface phy_type;
+	struct resource *res;
 	int err;
 
 	tegra_phy = devm_kzalloc(&pdev->dev, sizeof(*tegra_phy), GFP_KERNEL);
 	if (!tegra_phy)
 		return -ENOMEM;
 
-	match = of_match_device(tegra_usb_phy_id_table, &pdev->dev);
-	if (!match) {
-		dev_err(&pdev->dev, "Error: No device match found\n");
-		return -ENODEV;
-	}
-	tegra_phy->soc_config = match->data;
+	tegra_phy->soc_config = of_device_get_match_data(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -1073,7 +1098,7 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 	}
 
 	tegra_phy->regs = devm_ioremap(&pdev->dev, res->start,
-		resource_size(res));
+				       resource_size(res));
 	if (!tegra_phy->regs) {
 		dev_err(&pdev->dev, "Failed to remap I/O memory\n");
 		return -ENOMEM;
@@ -1095,12 +1120,12 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 
 		tegra_phy->reset_gpio =
 			of_get_named_gpio(np, "nvidia,phy-reset-gpio", 0);
+
 		if (!gpio_is_valid(tegra_phy->reset_gpio)) {
 			dev_err(&pdev->dev,
 				"Invalid GPIO: %d\n", tegra_phy->reset_gpio);
 			return tegra_phy->reset_gpio;
 		}
-		tegra_phy->config = NULL;
 		break;
 
 	default:
@@ -1146,7 +1171,7 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 		}
 
 		err = devm_gpio_request(&pdev->dev, tegra_phy->reset_gpio,
-			"ulpi_phy_reset_b");
+					"ulpi_phy_reset_b");
 		if (err < 0) {
 			dev_err(&pdev->dev, "Request failed for GPIO %d: %d\n",
 				tegra_phy->reset_gpio, err);
-- 
2.24.0

