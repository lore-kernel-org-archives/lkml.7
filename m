Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10330C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76F4218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfCUIQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:16:04 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33376 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfCUIQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:16:03 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2L8BZLE019244;
        Thu, 21 Mar 2019 09:15:49 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r8qsxv3uj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Mar 2019 09:15:49 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 57FB338;
        Thu, 21 Mar 2019 08:15:48 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2CB3524F5;
        Thu, 21 Mar 2019 08:15:48 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Mar
 2019 09:15:48 +0100
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Thu, 21 Mar 2019 09:15:47
 +0100
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/stm: add sleep power management
Date:   Thu, 21 Mar 2019 09:15:20 +0100
Message-ID: <1553156120-13851-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements system sleep power management ops.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/drv.c  | 35 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/stm/ltdc.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/stm/ltdc.h |  3 +++
 3 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 0a7f933..5834ef5 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -129,6 +129,40 @@ static void drv_unload(struct drm_device *ddev)
 	drm_mode_config_cleanup(ddev);
 }
 
+static __maybe_unused int drv_suspend(struct device *dev)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct ltdc_device *ldev = ddev->dev_private;
+	struct drm_atomic_state *state;
+
+	drm_kms_helper_poll_disable(ddev);
+	state = drm_atomic_helper_suspend(ddev);
+	if (IS_ERR(state)) {
+		drm_kms_helper_poll_enable(ddev);
+		return PTR_ERR(state);
+	}
+	ldev->suspend_state = state;
+	ltdc_suspend(ddev);
+
+	return 0;
+}
+
+static __maybe_unused int drv_resume(struct device *dev)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct ltdc_device *ldev = ddev->dev_private;
+
+	ltdc_resume(ddev);
+	drm_atomic_helper_resume(ddev, ldev->suspend_state);
+	drm_kms_helper_poll_enable(ddev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops drv_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(drv_suspend, drv_resume)
+};
+
 static int stm_drm_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -186,6 +220,7 @@ static struct platform_driver stm_drm_platform_driver = {
 	.driver = {
 		.name = "stm32-display",
 		.of_match_table = drv_dt_ids,
+		.pm = &drv_pm_ops,
 	},
 };
 
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index b1741a9..32fd6a3 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1062,6 +1062,30 @@ static int ltdc_get_caps(struct drm_device *ddev)
 	return 0;
 }
 
+void ltdc_suspend(struct drm_device *ddev)
+{
+	struct ltdc_device *ldev = ddev->dev_private;
+
+	DRM_DEBUG_DRIVER("\n");
+	clk_disable_unprepare(ldev->pixel_clk);
+}
+
+int ltdc_resume(struct drm_device *ddev)
+{
+	struct ltdc_device *ldev = ddev->dev_private;
+	int ret;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	ret = clk_prepare_enable(ldev->pixel_clk);
+	if (ret) {
+		DRM_ERROR("failed to enable pixel clock (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 int ltdc_load(struct drm_device *ddev)
 {
 	struct platform_device *pdev = to_platform_device(ddev->dev);
diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
index e46f477..a1ad0ae 100644
--- a/drivers/gpu/drm/stm/ltdc.h
+++ b/drivers/gpu/drm/stm/ltdc.h
@@ -36,6 +36,7 @@ struct ltdc_device {
 	u32 error_status;
 	u32 irq_status;
 	struct fps_info plane_fpsi[LTDC_MAX_LAYER];
+	struct drm_atomic_state *suspend_state;
 };
 
 bool ltdc_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
@@ -45,5 +46,7 @@ bool ltdc_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
 
 int ltdc_load(struct drm_device *ddev);
 void ltdc_unload(struct drm_device *ddev);
+void ltdc_suspend(struct drm_device *ddev);
+int ltdc_resume(struct drm_device *ddev);
 
 #endif
-- 
2.7.4

