Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B38C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBCD2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="cAAsIhgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbfHFP57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:57:59 -0400
Received: from vps.xff.cz ([195.181.215.36]:55430 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfHFP5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1565107072; bh=G5d5sfuj/djQCj8wXzjmHf1QSkXVwxxOltCt/6o9g+0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cAAsIhgtY4Ghf/LBWCg1W4HslWJwPfja2unwxuU3w/O9CONbe90r0qNOkJQzdbYPB
         HywJUyrrpzjr6OXAUxhIBbXBt92h7SXJAkGCfkuq8T7Hrf3qfdtTUiSVcCSETjBRqr
         Nu8fjIdbfNBlcARTc6CqmQ7s+KR8nbO5O7Q1bxYA=
From:   megous@megous.com
To:     linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Ondrej Jirman <megous@megous.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v8 3/4] drm: sun4i: Add support for enabling DDC I2C bus to sun8i_dw_hdmi glue
Date:   Tue,  6 Aug 2019 17:57:42 +0200
Message-Id: <20190806155744.10263-4-megous@megous.com>
In-Reply-To: <20190806155744.10263-1-megous@megous.com>
References: <20190806155744.10263-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Orange Pi 3 board requires enabling a voltage shifting circuit via GPIO
for the DDC bus to be usable.

Add support for hdmi-connector node's optional ddc-en-gpios property to
support this use case.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 54 +++++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h |  2 +
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 8ca5af0c912f..a44dca4b0219 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -97,10 +97,34 @@ static u32 sun8i_dw_hdmi_find_possible_crtcs(struct drm_device *drm,
 	return crtcs;
 }
 
+static int sun8i_dw_hdmi_find_connector_pdev(struct device *dev,
+					     struct platform_device **pdev_out)
+{
+	struct platform_device *pdev;
+	struct device_node *remote;
+
+	remote = of_graph_get_remote_node(dev->of_node, 1, -1);
+	if (!remote)
+		return -ENODEV;
+
+	if (!of_device_is_compatible(remote, "hdmi-connector")) {
+		of_node_put(remote);
+		return -ENODEV;
+	}
+
+	pdev = of_find_device_by_node(remote);
+	of_node_put(remote);
+	if (!pdev)
+		return -ENODEV;
+
+	*pdev_out = pdev;
+	return 0;
+}
+
 static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 			      void *data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *pdev = to_platform_device(dev), *connector_pdev;
 	struct dw_hdmi_plat_data *plat_data;
 	struct drm_device *drm = data;
 	struct device_node *phy_node;
@@ -150,16 +174,30 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		return PTR_ERR(hdmi->regulator);
 	}
 
+	ret = sun8i_dw_hdmi_find_connector_pdev(dev, &connector_pdev);
+	if (!ret) {
+		hdmi->ddc_en = gpiod_get_optional(&connector_pdev->dev,
+						  "ddc-en", GPIOD_OUT_HIGH);
+		platform_device_put(connector_pdev);
+
+		if (IS_ERR(hdmi->ddc_en)) {
+			dev_err(dev, "Couldn't get ddc-en gpio\n");
+			return PTR_ERR(hdmi->ddc_en);
+		}
+	}
+
 	ret = regulator_enable(hdmi->regulator);
 	if (ret) {
 		dev_err(dev, "Failed to enable regulator\n");
-		return ret;
+		goto err_unref_ddc_en;
 	}
 
+	gpiod_set_value(hdmi->ddc_en, 1);
+
 	ret = reset_control_deassert(hdmi->rst_ctrl);
 	if (ret) {
 		dev_err(dev, "Could not deassert ctrl reset control\n");
-		goto err_disable_regulator;
+		goto err_disable_ddc_en;
 	}
 
 	ret = clk_prepare_enable(hdmi->clk_tmds);
@@ -212,8 +250,12 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	clk_disable_unprepare(hdmi->clk_tmds);
 err_assert_ctrl_reset:
 	reset_control_assert(hdmi->rst_ctrl);
-err_disable_regulator:
+err_disable_ddc_en:
+	gpiod_set_value(hdmi->ddc_en, 0);
 	regulator_disable(hdmi->regulator);
+err_unref_ddc_en:
+	if (hdmi->ddc_en)
+		gpiod_put(hdmi->ddc_en);
 
 	return ret;
 }
@@ -227,7 +269,11 @@ static void sun8i_dw_hdmi_unbind(struct device *dev, struct device *master,
 	sun8i_hdmi_phy_remove(hdmi);
 	clk_disable_unprepare(hdmi->clk_tmds);
 	reset_control_assert(hdmi->rst_ctrl);
+	gpiod_set_value(hdmi->ddc_en, 0);
 	regulator_disable(hdmi->regulator);
+
+	if (hdmi->ddc_en)
+		gpiod_put(hdmi->ddc_en);
 }
 
 static const struct component_ops sun8i_dw_hdmi_ops = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 720c5aa8adc1..d707c9171824 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -9,6 +9,7 @@
 #include <drm/bridge/dw_hdmi.h>
 #include <drm/drm_encoder.h>
 #include <linux/clk.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -190,6 +191,7 @@ struct sun8i_dw_hdmi {
 	struct regulator		*regulator;
 	const struct sun8i_dw_hdmi_quirks *quirks;
 	struct reset_control		*rst_ctrl;
+	struct gpio_desc		*ddc_en;
 };
 
 static inline struct sun8i_dw_hdmi *
-- 
2.22.0

