Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C617AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F2A20700
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfC2Mhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:37:36 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52706 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729384AbfC2Mhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 08:37:35 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TCWl9A004462;
        Fri, 29 Mar 2019 13:36:24 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rddhc4x5u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 29 Mar 2019 13:36:24 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D297A31;
        Fri, 29 Mar 2019 12:36:21 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8B7CB2A3F;
        Fri, 29 Mar 2019 12:36:21 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 29 Mar
 2019 13:36:21 +0100
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Fri, 29 Mar 2019 13:36:21
 +0100
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>
Subject: [PATCH] drm/bridge: sii902x: initialize CEC device
Date:   Fri, 29 Mar 2019 13:35:58 +0100
Message-ID: <1553862958-6454-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the CEC device embedded into sii902x bridge. By default,
the CEC device must be disabled to allow other CEC devices to bypass
the bridge.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 08e12fe..d33c097 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -83,9 +83,15 @@
 
 #define SII902X_I2C_BUS_ACQUISITION_TIMEOUT_MS	500
 
+#define SII902X_CEC_I2C_ADDR_DEFAULT		0x60
+#define SII902X_CEC_SETUP			0x8e
+#define CEC_EN					BIT(4)
+
 struct sii902x {
 	struct i2c_client *i2c;
+	struct i2c_client *i2c_cec;
 	struct regmap *regmap;
+	struct regmap *regmap_cec;
 	struct drm_bridge bridge;
 	struct drm_connector connector;
 	struct gpio_desc *reset_gpio;
@@ -331,6 +337,22 @@ static const struct regmap_config sii902x_regmap_config = {
 	.cache_type = REGCACHE_NONE,
 };
 
+static const struct regmap_range sii902x_cec_volatile_ranges[] = {
+	{ .range_min = 0x84, .range_max = 0xe4 },
+};
+
+static const struct regmap_access_table sii902x_cec_volatile_table = {
+	.yes_ranges = sii902x_cec_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(sii902x_cec_volatile_ranges),
+};
+
+static const struct regmap_config sii902x_cec_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &sii902x_cec_volatile_table,
+	.cache_type = REGCACHE_NONE,
+};
+
 static irqreturn_t sii902x_interrupt(int irq, void *data)
 {
 	struct sii902x *sii902x = data;
@@ -460,6 +482,39 @@ static int sii902x_i2c_bypass_deselect(struct i2c_mux_core *mux, u32 chan_id)
 	return 0;
 }
 
+int sii902x_cec_init(struct device *dev, struct sii902x *sii902x)
+{
+	struct i2c_client *client;
+	int ret;
+
+	client = i2c_new_secondary_device(sii902x->i2c, "cec",
+					  SII902X_CEC_I2C_ADDR_DEFAULT);
+	if (!client)
+		return -EINVAL;
+
+	sii902x->i2c_cec = client;
+
+	i2c_set_clientdata(sii902x->i2c_cec, sii902x);
+
+	sii902x->regmap_cec = devm_regmap_init_i2c(sii902x->i2c_cec,
+						   &sii902x_cec_regmap_config);
+	if (IS_ERR(sii902x->regmap_cec)) {
+		ret = PTR_ERR(sii902x->regmap_cec);
+		goto err;
+	}
+
+	/*
+	 * By default, CEC must be disabled to allow other CEC devives
+	 * to bypass the bridge.
+	 */
+	regmap_update_bits(sii902x->regmap_cec, SII902X_CEC_SETUP, CEC_EN, 0);
+
+	return 0;
+err:
+	i2c_unregister_device(sii902x->i2c_cec);
+	return ret;
+}
+
 static int sii902x_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -542,7 +597,16 @@ static int sii902x_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	sii902x->i2cmux->priv = sii902x;
+
+	ret = sii902x_cec_init(dev, sii902x);
+	if (ret)
+		goto err;
+
 	return i2c_mux_add_adapter(sii902x->i2cmux, 0, 0, 0);
+err:
+	drm_bridge_remove(&sii902x->bridge);
+
+	return ret;
 }
 
 static int sii902x_remove(struct i2c_client *client)
-- 
2.7.4

