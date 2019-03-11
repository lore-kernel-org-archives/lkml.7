Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAFAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5174D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfCKNrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:47:20 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:33140 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfCKNrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:47:20 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id D50AC14CEA; Mon, 11 Mar 2019 13:47:18 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sun4i: hdmi: add support for ddc-i2c-bus property
Date:   Mon, 11 Mar 2019 13:47:13 +0000
Message-Id: <20190311134713.25876-1-mans@mansr.com>
X-Mailer: git-send-email 2.21.0
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
 drivers/gpu/drm/sun4i/sun4i_hdmi.h     |  1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 37 +++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

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
index 061d2e0d9011..5b2fac79f5d6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -212,7 +212,7 @@ static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 	struct edid *edid;
 	int ret;
 
-	edid = drm_get_edid(connector, hdmi->i2c);
+	edid = drm_get_edid(connector, hdmi->ddc_i2c ?: hdmi->i2c);
 	if (!edid)
 		return 0;
 
@@ -228,6 +228,28 @@ static int sun4i_hdmi_get_modes(struct drm_connector *connector)
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
+		return NULL;
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
@@ -575,6 +597,12 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_mod_clk;
 	}
 
+	hdmi->ddc_i2c = sun4i_hdmi_get_ddc(dev);
+	if (IS_ERR(hdmi->ddc_i2c)) {
+		ret = PTR_ERR(hdmi->ddc_i2c);
+		goto err_del_i2c_adapter;
+	}
+
 	drm_encoder_helper_add(&hdmi->encoder,
 			       &sun4i_hdmi_helper_funcs);
 	ret = drm_encoder_init(drm,
@@ -584,14 +612,14 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
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
@@ -630,6 +658,8 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 err_cleanup_connector:
 	cec_delete_adapter(hdmi->cec_adap);
 	drm_encoder_cleanup(&hdmi->encoder);
+err_put_ddc_i2c:
+	i2c_put_adapter(hdmi->ddc_i2c);
 err_del_i2c_adapter:
 	i2c_del_adapter(hdmi->i2c);
 err_disable_mod_clk:
@@ -650,6 +680,7 @@ static void sun4i_hdmi_unbind(struct device *dev, struct device *master,
 	drm_connector_cleanup(&hdmi->connector);
 	drm_encoder_cleanup(&hdmi->encoder);
 	i2c_del_adapter(hdmi->i2c);
+	i2c_put_adapter(hdmi->ddc_i2c);
 	clk_disable_unprepare(hdmi->mod_clk);
 	clk_disable_unprepare(hdmi->bus_clk);
 }
-- 
2.21.0

