Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC629C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EA5206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfC1NCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:02:55 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:55950 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbfC1NCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:02:55 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 54E4A15061; Thu, 28 Mar 2019 13:02:53 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sun4i: hdmi: add support for ddc-i2c-bus property
Date:   Thu, 28 Mar 2019 13:02:49 +0000
Message-Id: <20190328130249.19356-1-mans@mansr.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326194907.6lekrewcdiuteomp@flea>
References: <20190326194907.6lekrewcdiuteomp@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes it is desirabled to use a separate i2c controller for ddc
access.  This adds support for the ddc-i2c-bus property of the
hdmi-connector node, using the specified controller if provided.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
Changed in v2:
- Return ERR_PTR(-ENODEV) instead of NULL when property is absent
---
 drivers/gpu/drm/sun4i/sun4i_hdmi.h     |  1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 40 ++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
index b685ee11623d..b08c4453d47c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
@@ -269,6 +269,7 @@ struct sun4i_hdmi {
 	struct clk		*tmds_clk;
 
 	struct i2c_adapter	*i2c;
+	struct i2c_adapter	*ddc_i2c;
 
 	/* Regmap fields for I2C adapter */
 	struct regmap_field	*field_ddc_en;
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 416da5376701..a99523e9651f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -216,7 +216,7 @@ static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 	struct edid *edid;
 	int ret;
 
-	edid = drm_get_edid(connector, hdmi->i2c);
+	edid = drm_get_edid(connector, hdmi->ddc_i2c ?: hdmi->i2c);
 	if (!edid)
 		return 0;
 
@@ -232,6 +232,28 @@ static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
+static struct i2c_adapter *sun4i_hdmi_get_ddc(struct device *dev)
+{
+	struct device_node *phandle, *remote;
+	struct i2c_adapter *ddc;
+
+	remote = of_graph_get_remote_node(dev->of_node, 1, -1);
+	if (!remote)
+		return ERR_PTR(-EINVAL);
+
+	phandle = of_parse_phandle(remote, "ddc-i2c-bus", 0);
+	of_node_put(remote);
+	if (!phandle)
+		return ERR_PTR(-ENODEV);
+
+	ddc = of_get_i2c_adapter_by_node(phandle);
+	of_node_put(phandle);
+	if (!ddc)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return ddc;
+}
+
 static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs = {
 	.get_modes	= sun4i_hdmi_get_modes,
 };
@@ -579,6 +601,15 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_mod_clk;
 	}
 
+	hdmi->ddc_i2c = sun4i_hdmi_get_ddc(dev);
+	if (IS_ERR(hdmi->ddc_i2c)) {
+		ret = PTR_ERR(hdmi->ddc_i2c);
+		if (ret == -ENODEV)
+			hdmi->ddc_i2c = NULL;
+		else
+			goto err_del_i2c_adapter;
+	}
+
 	drm_encoder_helper_add(&hdmi->encoder,
 			       &sun4i_hdmi_helper_funcs);
 	ret = drm_encoder_init(drm,
@@ -588,14 +619,14 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 			       NULL);
 	if (ret) {
 		dev_err(dev, "Couldn't initialise the HDMI encoder\n");
-		goto err_del_i2c_adapter;
+		goto err_put_ddc_i2c;
 	}
 
 	hdmi->encoder.possible_crtcs = drm_of_find_possible_crtcs(drm,
 								  dev->of_node);
 	if (!hdmi->encoder.possible_crtcs) {
 		ret = -EPROBE_DEFER;
-		goto err_del_i2c_adapter;
+		goto err_put_ddc_i2c;
 	}
 
 #ifdef CONFIG_DRM_SUN4I_HDMI_CEC
@@ -634,6 +665,8 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 err_cleanup_connector:
 	cec_delete_adapter(hdmi->cec_adap);
 	drm_encoder_cleanup(&hdmi->encoder);
+err_put_ddc_i2c:
+	i2c_put_adapter(hdmi->ddc_i2c);
 err_del_i2c_adapter:
 	i2c_del_adapter(hdmi->i2c);
 err_disable_mod_clk:
@@ -654,6 +687,7 @@ static void sun4i_hdmi_unbind(struct device *dev, struct device *master,
 	drm_connector_cleanup(&hdmi->connector);
 	drm_encoder_cleanup(&hdmi->encoder);
 	i2c_del_adapter(hdmi->i2c);
+	i2c_put_adapter(hdmi->ddc_i2c);
 	clk_disable_unprepare(hdmi->mod_clk);
 	clk_disable_unprepare(hdmi->bus_clk);
 }
-- 
2.21.0

