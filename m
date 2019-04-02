Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C041C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B2920856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfDBNti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:49:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47951 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfDBNtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:49:35 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mgr@pengutronix.de>)
        id 1hBJmn-0007VQ-Js; Tue, 02 Apr 2019 15:49:09 +0200
Received: from mgr by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <mgr@pengutronix.de>)
        id 1hBJmm-0001Dn-QZ; Tue, 02 Apr 2019 15:49:08 +0200
From:   Michael Grzeschik <m.grzeschik@pengutronix.de>
To:     p.zabel@pengutronix.de, airlied@linux.ie,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, rafael@kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/3] ipuv3-ldb: add init list head on bind
Date:   Tue,  2 Apr 2019 15:49:03 +0200
Message-Id: <20190402134904.588-3-m.grzeschik@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402134904.588-1-m.grzeschik@pengutronix.de>
References: <0687f68004b28ed3a364b06a9eb64e2e@agner.ch>
 <20190402134904.588-1-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list head is not initialised after imx_ldb_bind
allocates the imx_ldb object. Ensure it will be valid
before anyone uses it.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/gpu/drm/imx/imx-ldb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
index 3837333022804..a11f8758da70e 100644
--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -581,6 +581,20 @@ static int imx_ldb_panel_ddc(struct device *dev,
 	return 0;
 }
 
+static void ipu_ldb_init_encoder_head(struct imx_ldb *imx_ldb)
+{
+	struct imx_ldb_channel *imx_ldb_ch;
+	struct drm_encoder *encoder;
+
+	imx_ldb_ch = &imx_ldb->channel[0];
+	encoder = &imx_ldb_ch->encoder;
+	INIT_LIST_HEAD(&encoder->head);
+
+	imx_ldb_ch = &imx_ldb->channel[1];
+	encoder = &imx_ldb_ch->encoder;
+	INIT_LIST_HEAD(&encoder->head);
+}
+
 static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 {
 	struct drm_device *drm = data;
@@ -597,6 +611,8 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 	if (!imx_ldb)
 		return -ENOMEM;
 
+	ipu_ldb_init_encoder_head(imx_ldb);
+
 	imx_ldb->regmap = syscon_regmap_lookup_by_phandle(np, "gpr");
 	if (IS_ERR(imx_ldb->regmap)) {
 		dev_err(dev, "failed to get parent regmap\n");
-- 
2.20.1

