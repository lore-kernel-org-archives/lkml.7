Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC77C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1BA216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="1iDvh+Rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfEJOZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 10:25:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11580 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727790AbfEJOZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:25:45 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AE1s09030708;
        Fri, 10 May 2019 16:20:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version : content-type
 : content-transfer-encoding; s=STMicroelectronics;
 bh=98w/OussyxuOrcLWSMqRtFhnLM+xTLnhKVGbTHyMH+g=;
 b=1iDvh+RspI3I9R7djaQ6BAUvhMdBdC/10L5C4kP699I2iYf98qBnOS8hsWQp8VD8nTvS
 h9CdTHpg/QIxJG0IRtNr+tMWs+tk61GoNmus7in9fKUTQwFboYHuDXBj/mgqsySIMMDf
 fQvjFItf2PHJCmjiPAfxfEjDxdFMuZv4z+nUeuK4MzKwIwu1H/PluAb58ByvJIaiTWYL
 Kqj5xlCaADMMKtztF+qwhwbzLBf7I7JSRnOAZx0KK0sFW3YQcberQ9ck2QvWmOQtq7t6
 idnAu6e7qco9PGJASJhH5DiK82my9XTgqlRNPwn9SebDspe1KoZDevMPxjRIpuIztH7T qQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sc9s4jwnw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 16:20:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB84E31;
        Fri, 10 May 2019 14:20:31 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E2C5113A;
        Fri, 10 May 2019 14:20:31 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 10 May
 2019 16:20:31 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May 2019 16:20:30
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
Subject: [PATCH v2 2/3] drm/stm: dsi: add support of an optional regulator
Date:   Fri, 10 May 2019 16:20:20 +0200
Message-ID: <1557498023-10766-3-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557498023-10766-1-git-send-email-yannick.fertre@st.com>
References: <1557498023-10766-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of an optional regulator for the phy part of the DSI
controller.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 45 ++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index 1bef73e..22bd095 100644
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
@@ -318,17 +320,31 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->base);
 	}
 
+	dsi->vdd_supply = devm_regulator_get_optional(dev, "phy-dsi");
+	if (IS_ERR(dsi->vdd_supply)) {
+		ret = PTR_ERR(dsi->vdd_supply);
+		if (ret != -EPROBE_DEFER)
+			DRM_ERROR("failed to request regulator: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_enable(dsi->vdd_supply);
+	if (ret) {
+		DRM_ERROR("failed to enable regulator: %d\n", ret);
+		return ret;
+	}
+
 	dsi->pllref_clk = devm_clk_get(dev, "ref");
 	if (IS_ERR(dsi->pllref_clk)) {
 		ret = PTR_ERR(dsi->pllref_clk);
-		dev_err(dev, "Unable to get pll reference clock: %d\n", ret);
-		return ret;
+		DRM_ERROR("Unable to get pll reference clock: %d\n", ret);
+		goto err_clk_get;
 	}
 
 	ret = clk_prepare_enable(dsi->pllref_clk);
 	if (ret) {
-		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
-		return ret;
+		DRM_ERROR("%s: Failed to enable pllref_clk\n", __func__);
+		goto err_clk_get;
 	}
 
 	dw_mipi_dsi_stm_plat_data.base = dsi->base;
@@ -339,11 +355,19 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
 	dsi->dsi = dw_mipi_dsi_probe(pdev, &dw_mipi_dsi_stm_plat_data);
 	if (IS_ERR(dsi->dsi)) {
 		DRM_ERROR("Failed to initialize mipi dsi host\n");
-		clk_disable_unprepare(dsi->pllref_clk);
-		return PTR_ERR(dsi->dsi);
+		ret = PTR_ERR(dsi->dsi);
+		goto err_dsi_probe;
 	}
 
 	return 0;
+
+err_dsi_probe:
+	clk_disable_unprepare(dsi->pllref_clk);
+err_clk_get:
+	regulator_disable(dsi->vdd_supply);
+
+	return ret;
+
 }
 
 static int dw_mipi_dsi_stm_remove(struct platform_device *pdev)
@@ -351,6 +375,7 @@ static int dw_mipi_dsi_stm_remove(struct platform_device *pdev)
 	struct dw_mipi_dsi_stm *dsi = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(dsi->pllref_clk);
+	regulator_disable(dsi->vdd_supply);
 	dw_mipi_dsi_remove(dsi->dsi);
 
 	return 0;
@@ -363,6 +388,7 @@ static int __maybe_unused dw_mipi_dsi_stm_suspend(struct device *dev)
 	DRM_DEBUG_DRIVER("\n");
 
 	clk_disable_unprepare(dsi->pllref_clk);
+	regulator_disable(dsi->vdd_supply);
 
 	return 0;
 }
@@ -370,9 +396,16 @@ static int __maybe_unused dw_mipi_dsi_stm_suspend(struct device *dev)
 static int __maybe_unused dw_mipi_dsi_stm_resume(struct device *dev)
 {
 	struct dw_mipi_dsi_stm *dsi = dw_mipi_dsi_stm_plat_data.priv_data;
+	int ret;
 
 	DRM_DEBUG_DRIVER("\n");
 
+	ret = regulator_enable(dsi->vdd_supply);
+	if (ret) {
+		DRM_ERROR("failed to enable regulator: %d\n", ret);
+		return ret;
+	}
+
 	clk_prepare_enable(dsi->pllref_clk);
 
 	return 0;
-- 
2.7.4

