Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8363C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901A121473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfDCIRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:17:04 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2184 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728625AbfDCIQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:16:59 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3386Kia029692;
        Wed, 3 Apr 2019 10:16:42 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgmx2hdx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Apr 2019 10:16:42 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F23538;
        Wed,  3 Apr 2019 08:16:42 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0767F1477;
        Wed,  3 Apr 2019 08:16:42 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Apr 2019
 10:16:41 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 3 Apr 2019 10:16:41
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/5] drm/stm: dw_mipi_dsi-stm: add support of an optional regulator
Date:   Wed, 3 Apr 2019 10:16:26 +0200
Message-ID: <1554279389-27377-3-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554279389-27377-1-git-send-email-yannick.fertre@st.com>
References: <1554279389-27377-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of an optional regulator for the phy part of the DSI
controller.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index a672b59..84703d0 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <drm/drmP.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/bridge/dw_mipi_dsi.h>
@@ -76,6 +77,7 @@ struct dw_mipi_dsi_stm {
 	u32 hw_version;
 	int lane_min_kbps;
 	int lane_max_kbps;
+	struct regulator *vdd_supply;
 };
 
 static inline void dsi_write(struct dw_mipi_dsi_stm *dsi, u32 reg, u32 val)
@@ -318,16 +320,32 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->base);
 	}
 
+	dsi->vdd_supply = devm_regulator_get_optional(dev, "phy-dsi");
+	if (IS_ERR(dsi->vdd_supply)) {
+		ret = PTR_ERR(dsi->vdd_supply);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to request regulator: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_enable(dsi->vdd_supply);
+	if (ret) {
+		dev_err(dev, "failed to enable regulator: %d\n", ret);
+		return ret;
+	}
+
 	dsi->pllref_clk = devm_clk_get(dev, "ref");
 	if (IS_ERR(dsi->pllref_clk)) {
 		ret = PTR_ERR(dsi->pllref_clk);
 		dev_err(dev, "Unable to get pll reference clock: %d\n", ret);
+		regulator_disable(dsi->vdd_supply);
 		return ret;
 	}
 
 	ret = clk_prepare_enable(dsi->pllref_clk);
 	if (ret) {
 		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
+		regulator_disable(dsi->vdd_supply);
 		return ret;
 	}
 
@@ -339,6 +357,7 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
 	dsi->dsi = dw_mipi_dsi_probe(pdev, &dw_mipi_dsi_stm_plat_data);
 	if (IS_ERR(dsi->dsi)) {
 		DRM_ERROR("Failed to initialize mipi dsi host\n");
+		regulator_disable(dsi->vdd_supply);
 		clk_disable_unprepare(dsi->pllref_clk);
 		return PTR_ERR(dsi->dsi);
 	}
@@ -351,6 +370,7 @@ static int dw_mipi_dsi_stm_remove(struct platform_device *pdev)
 	struct dw_mipi_dsi_stm *dsi = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(dsi->pllref_clk);
+	regulator_disable(dsi->vdd_supply);
 	dw_mipi_dsi_remove(dsi->dsi);
 
 	return 0;
-- 
2.7.4

