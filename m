Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A480C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74FE2171F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfDATPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:15:36 -0400
Received: from mailoutvs49.siol.net ([185.57.226.240]:37863 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbfDATPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:15:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id BF5D252065A;
        Mon,  1 Apr 2019 21:15:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jt11YcywMIke; Mon,  1 Apr 2019 21:15:32 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 31E2B520746;
        Mon,  1 Apr 2019 21:15:32 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id BD97E520886;
        Mon,  1 Apr 2019 21:15:28 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, wens@csie.org,
        narmstrong@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] drm/sun4i: dw-hdmi: Bit bang CEC on some SoCs
Date:   Mon,  1 Apr 2019 21:15:13 +0200
Message-Id: <20190401191513.23159-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401191513.23159-1-jernej.skrabec@siol.net>
References: <20190401191513.23159-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All DW HDMI controllers used by Allwinner SoCs include CEC controller.
However, due to additional logic put between CEC controller and pins,
CEC communication doesn't work well on some of them.

Based on observations, it seems that only outgoing messages are
properly transmitted. It's possible that it would still work correctly
if pins are switched between input and output mode manually in right
moment. But that's very error prone. It's better and easier just to bit
bang protocol.

Enable bit banging just for controller and phy combination found in H3
and other 40nm SoCs. Other combinations work (H6) or the status is
unknown (A83T).

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/Kconfig          | 10 ++++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  | 11 ++++
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 83 +++++++++++++++++++++++++-
 3 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfi=
g
index 1dbbc3a1b763..7149c72e44c8 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -60,6 +60,16 @@ config DRM_SUN8I_DW_HDMI
 	  DesignWare HDMI controller with custom HDMI PHY. If M is
 	  selected the module will be called sun8i_dw_hdmi.
=20
+config DRM_SUN8I_DW_HDMI_CEC
+       bool "Allwinner DesignWare HDMI CEC Support for 40nm SoCs"
+       depends on DRM_SUN8I_DW_HDMI
+       select CEC_CORE
+       select CEC_PIN
+       help
+	  Choose this option if you have an 40nm Allwinner SoC with
+	  the DesignWare HDMI controller with custom HDMI PHY and
+	  you want to use CEC.
+
 config DRM_SUN8I_MIXER
 	tristate "Support for Allwinner Display Engine 2.0 Mixer"
 	default MACH_SUN8I
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.h
index 720c5aa8adc1..49ca001923e3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -12,6 +12,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <media/cec-pin.h>
=20
 #define SUN8I_HDMI_PHY_DBG_CTRL_REG	0x0000
 #define SUN8I_HDMI_PHY_DBG_CTRL_PX_LOCK		BIT(0)
@@ -144,6 +145,13 @@
 #define SUN8I_HDMI_PHY_ANA_STS_RCAL_MASK	GENMASK(5, 0)
=20
 #define SUN8I_HDMI_PHY_CEC_REG		0x003c
+#define SUN8I_HDMI_PHY_CEC_PIN_CTRL		BIT(7)
+/*
+ * Documentation says that this bit is output enable. However,
+ * it seems that this bit is actually output disable.
+ */
+#define SUN8I_HDMI_PHY_CEC_OUT_DIS		BIT(2)
+#define SUN8I_HDMI_PHY_CEC_IN_DATA		BIT(1)
=20
 struct sun8i_hdmi_phy;
=20
@@ -151,6 +159,7 @@ struct sun8i_hdmi_phy_variant {
 	bool has_phy_clk;
 	bool has_second_pll;
 	unsigned int is_custom_phy : 1;
+	unsigned int bit_bang_cec : 1;
 	const struct dw_hdmi_curr_ctrl *cur_ctr;
 	const struct dw_hdmi_mpll_config *mpll_cfg;
 	const struct dw_hdmi_phy_config *phy_cfg;
@@ -163,6 +172,8 @@ struct sun8i_hdmi_phy_variant {
 };
=20
 struct sun8i_hdmi_phy {
+	struct cec_adapter		*cec_adapter;
+	struct cec_notifier		*cec_notifier;
 	struct clk			*clk_bus;
 	struct clk			*clk_mod;
 	struct clk			*clk_phy;
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun=
4i/sun8i_hdmi_phy.c
index 66ea3a902e36..8fd6bf91714e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -503,8 +503,9 @@ static void sun8i_hdmi_phy_init_h3(struct sun8i_hdmi_=
phy *phy)
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
 			   SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK, 0);
=20
-	/* set HW control of CEC pins */
-	regmap_write(phy->regs, SUN8I_HDMI_PHY_CEC_REG, 0);
+	/* manual control of CEC pins */
+	regmap_write(phy->regs, SUN8I_HDMI_PHY_CEC_REG,
+		     SUN8I_HDMI_PHY_CEC_PIN_CTRL);
=20
 	/* read calibration data */
 	regmap_read(phy->regs, SUN8I_HDMI_PHY_ANA_STS_REG, &val);
@@ -530,8 +531,49 @@ void sun8i_hdmi_phy_set_ops(struct sun8i_hdmi_phy *p=
hy,
 		plat_data->cur_ctr =3D variant->cur_ctr;
 		plat_data->phy_config =3D variant->phy_cfg;
 	}
+	plat_data->disable_cec =3D phy->variant->bit_bang_cec;
 }
=20
+#ifdef CONFIG_DRM_SUN8I_DW_HDMI_CEC
+static bool sun8i_hdmi_phy_cec_pin_read(struct cec_adapter *adap)
+{
+	struct sun8i_hdmi_phy *phy =3D cec_get_drvdata(adap);
+	unsigned int val;
+
+	regmap_read(phy->regs, SUN8I_HDMI_PHY_CEC_REG, &val);
+
+	return val & SUN8I_HDMI_PHY_CEC_IN_DATA;
+}
+
+static void sun8i_hdmi_phy_cec_pin_low(struct cec_adapter *adap)
+{
+	struct sun8i_hdmi_phy *phy =3D cec_get_drvdata(adap);
+
+	/* Start driving the CEC pin low */
+	regmap_write(phy->regs, SUN8I_HDMI_PHY_CEC_REG,
+		     SUN8I_HDMI_PHY_CEC_PIN_CTRL);
+}
+
+static void sun8i_hdmi_phy_cec_pin_high(struct cec_adapter *adap)
+{
+	struct sun8i_hdmi_phy *phy =3D cec_get_drvdata(adap);
+
+	/*
+	 * Stop driving the CEC pin, the pull up will take over
+	 * unless another CEC device is driving the pin low.
+	 */
+	regmap_write(phy->regs, SUN8I_HDMI_PHY_CEC_REG,
+		     SUN8I_HDMI_PHY_CEC_PIN_CTRL |
+		     SUN8I_HDMI_PHY_CEC_OUT_DIS);
+}
+
+static const struct cec_pin_ops sun8i_hdmi_phy_cec_pin_ops =3D {
+	.read =3D sun8i_hdmi_phy_cec_pin_read,
+	.low =3D sun8i_hdmi_phy_cec_pin_low,
+	.high =3D sun8i_hdmi_phy_cec_pin_high,
+};
+#endif
+
 static struct regmap_config sun8i_hdmi_phy_regmap_config =3D {
 	.reg_bits	=3D 32,
 	.val_bits	=3D 32,
@@ -548,6 +590,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_a83t=
_hdmi_phy =3D {
 };
=20
 static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy =3D {
+	.bit_bang_cec =3D true,
 	.has_phy_clk =3D true,
 	.is_custom_phy =3D true,
 	.phy_init =3D &sun8i_hdmi_phy_init_h3,
@@ -556,6 +599,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_h3_h=
dmi_phy =3D {
 };
=20
 static const struct sun8i_hdmi_phy_variant sun8i_r40_hdmi_phy =3D {
+	.bit_bang_cec =3D true,
 	.has_phy_clk =3D true,
 	.has_second_pll =3D true,
 	.is_custom_phy =3D true,
@@ -565,6 +609,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_r40_=
hdmi_phy =3D {
 };
=20
 static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy =3D {
+	.bit_bang_cec =3D true,
 	.has_phy_clk =3D true,
 	.is_custom_phy =3D true,
 	.phy_init =3D &sun8i_hdmi_phy_init_h3,
@@ -708,10 +753,40 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi=
, struct device_node *node)
 		goto err_disable_clk_bus;
 	}
=20
+#ifdef CONFIG_DRM_SUN8I_DW_HDMI_CEC
+	if (phy->variant->bit_bang_cec) {
+		phy->cec_notifier =3D cec_notifier_get(dev);
+		if (!phy->cec_notifier) {
+			ret =3D -ENOMEM;
+			goto err_disable_clk_mod;
+		}
+
+		phy->cec_adapter =3D
+			cec_pin_allocate_adapter(&sun8i_hdmi_phy_cec_pin_ops,
+						 phy, "sun8i-cec",
+						 CEC_CAP_DEFAULTS);
+		ret =3D PTR_ERR_OR_ZERO(phy->cec_adapter);
+		if (ret < 0)
+			goto err_put_cec_notifier;
+
+		ret =3D cec_register_adapter(phy->cec_adapter, dev);
+		if (ret < 0)
+			goto err_delete_cec_adapter;
+
+		cec_register_cec_notifier(phy->cec_adapter, phy->cec_notifier);
+	}
+#endif
+
 	hdmi->phy =3D phy;
=20
 	return 0;
=20
+err_delete_cec_adapter:
+	cec_delete_adapter(phy->cec_adapter);
+err_put_cec_notifier:
+	cec_notifier_put(phy->cec_notifier);
+err_disable_clk_mod:
+	clk_disable_unprepare(phy->clk_mod);
 err_disable_clk_bus:
 	clk_disable_unprepare(phy->clk_bus);
 err_deassert_rst_phy:
@@ -736,6 +811,10 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdm=
i)
 {
 	struct sun8i_hdmi_phy *phy =3D hdmi->phy;
=20
+	cec_unregister_adapter(phy->cec_adapter);
+	if (phy->cec_notifier)
+		cec_notifier_put(phy->cec_notifier);
+
 	clk_disable_unprepare(phy->clk_mod);
 	clk_disable_unprepare(phy->clk_bus);
 	clk_disable_unprepare(phy->clk_phy);
--=20
2.21.0

