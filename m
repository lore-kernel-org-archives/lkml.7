Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7340EC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF6527D9A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="nNdr+wue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfFCIcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:32:17 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51222 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbfFCIcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:32:16 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x538VNLc015409;
        Mon, 3 Jun 2019 10:32:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=K7GP/e9ogP2jWBP7ZWjLuKQJvmA/pqM3oS7ksSoK7qs=;
 b=nNdr+wueRBWTUZDhagWJPW6TbscsGlBcco9fPVS5BS2EoAcdJcsacABT/o4xJd5GlZSt
 IbInJer+QrWd6SKMpXW3spzOmMJSrxYOhgciILDkm741+BSA5FDO/Jf7sUVMuKBWmtUw
 Awld1dqNxys3BOK5te/YyGuBZlyBSSnEIlnBx0CIFoptxhqI2ieno62r55g/waO+c5ka
 myx2MsggyJdWlgYN7kw0sqgApKKGD42mPLkF54TYSwm9ENEQAeZT2336+9Oc1dfYgsTn
 7e2JMLFiK9TRkLWSE839Gq1tnPGLfzz/zsxbdpBfVwt576LsiCevO1t4XHS8SSf4cst9 Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sund0gwsc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 03 Jun 2019 10:32:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1826234;
        Mon,  3 Jun 2019 08:32:05 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DDDDB2514;
        Mon,  3 Jun 2019 08:32:04 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 10:32:04 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019 10:32:04
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/stm: support runtime power management
Date:   Mon, 3 Jun 2019 10:32:02 +0200
Message-ID: <1559550722-14091-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables runtime power management (runtime PM) support for
the display controller. pm_runtime_enable() and pm_runtime_disable()
are added during ltdc load and unload respectively.
pm_runtime_get_sync() and pm_runtime_put_sync() are added for ltdc
register access.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/drv.c  | 43 +++++++++++++++++++++++------
 drivers/gpu/drm/stm/ltdc.c | 67 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 86 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 5834ef5..5659572 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -12,6 +12,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -135,14 +136,15 @@ static __maybe_unused int drv_suspend(struct device *dev)
 	struct ltdc_device *ldev = ddev->dev_private;
 	struct drm_atomic_state *state;
 
-	drm_kms_helper_poll_disable(ddev);
+	if (WARN_ON(!ldev->suspend_state))
+		return -ENOENT;
+
 	state = drm_atomic_helper_suspend(ddev);
-	if (IS_ERR(state)) {
-		drm_kms_helper_poll_enable(ddev);
+	if (IS_ERR(state))
 		return PTR_ERR(state);
-	}
+
 	ldev->suspend_state = state;
-	ltdc_suspend(ddev);
+	pm_runtime_force_suspend(dev);
 
 	return 0;
 }
@@ -151,16 +153,41 @@ static __maybe_unused int drv_resume(struct device *dev)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct ltdc_device *ldev = ddev->dev_private;
+	int ret;
 
-	ltdc_resume(ddev);
-	drm_atomic_helper_resume(ddev, ldev->suspend_state);
-	drm_kms_helper_poll_enable(ddev);
+	pm_runtime_force_resume(dev);
+	ret = drm_atomic_helper_resume(ddev, ldev->suspend_state);
+	if (ret) {
+		pm_runtime_force_suspend(dev);
+		ldev->suspend_state = NULL;
+		return ret;
+	}
 
 	return 0;
 }
 
+static __maybe_unused int drv_runtime_suspend(struct device *dev)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+
+	DRM_DEBUG_DRIVER("\n");
+	ltdc_suspend(ddev);
+
+	return 0;
+}
+
+static __maybe_unused int drv_runtime_resume(struct device *dev)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+
+	DRM_DEBUG_DRIVER("\n");
+	return ltdc_resume(ddev);
+}
+
 static const struct dev_pm_ops drv_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(drv_suspend, drv_resume)
+	SET_RUNTIME_PM_OPS(drv_runtime_suspend,
+			   drv_runtime_resume, NULL)
 };
 
 static int stm_drm_platform_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index ac29890..a40870b 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #include <drm/drm_atomic.h>
@@ -444,6 +445,7 @@ static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
 				     struct drm_crtc_state *old_state)
 {
 	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
+	struct drm_device *ddev = crtc->dev;
 
 	DRM_DEBUG_DRIVER("\n");
 
@@ -457,6 +459,8 @@ static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	/* immediately commit disable of layers before switching off LTDC */
 	reg_set(ldev->regs, LTDC_SRCR, SRCR_IMR);
+
+	pm_runtime_put_sync(ddev->dev);
 }
 
 #define CLK_TOLERANCE_HZ 50
@@ -505,17 +509,31 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc *crtc,
 				 struct drm_display_mode *adjusted_mode)
 {
 	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
+	struct drm_device *ddev = crtc->dev;
 	int rate = mode->clock * 1000;
+	bool runtime_active;
+	int ret;
+
+	runtime_active = pm_runtime_active(ddev->dev);
+
+	if (runtime_active)
+		pm_runtime_put_sync(ddev->dev);
 
-	clk_disable(ldev->pixel_clk);
 	if (clk_set_rate(ldev->pixel_clk, rate) < 0) {
 		DRM_ERROR("Cannot set rate (%dHz) for pixel clk\n", rate);
 		return false;
 	}
-	clk_enable(ldev->pixel_clk);
 
 	adjusted_mode->clock = clk_get_rate(ldev->pixel_clk) / 1000;
 
+	if (runtime_active) {
+		ret = pm_runtime_get_sync(ddev->dev);
+		if (ret) {
+			DRM_ERROR("Failed to fixup mode, cannot get sync\n");
+			return false;
+		}
+	}
+
 	DRM_DEBUG_DRIVER("requested clock %dkHz, adjusted clock %dkHz\n",
 			 mode->clock, adjusted_mode->clock);
 
@@ -525,11 +543,21 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc *crtc,
 static void ltdc_crtc_mode_set_nofb(struct drm_crtc *crtc)
 {
 	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
+	struct drm_device *ddev = crtc->dev;
 	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
 	struct videomode vm;
 	u32 hsync, vsync, accum_hbp, accum_vbp, accum_act_w, accum_act_h;
 	u32 total_width, total_height;
 	u32 val;
+	int ret;
+
+	if (!pm_runtime_active(ddev->dev)) {
+		ret = pm_runtime_get_sync(ddev->dev);
+		if (ret) {
+			DRM_ERROR("Failed to set mode, cannot get sync\n");
+			return;
+		}
+	}
 
 	drm_display_mode_to_videomode(mode, &vm);
 
@@ -590,6 +618,7 @@ static void ltdc_crtc_atomic_flush(struct drm_crtc *crtc,
 				   struct drm_crtc_state *old_crtc_state)
 {
 	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
+	struct drm_device *ddev = crtc->dev;
 	struct drm_pending_vblank_event *event = crtc->state->event;
 
 	DRM_DEBUG_ATOMIC("\n");
@@ -602,12 +631,12 @@ static void ltdc_crtc_atomic_flush(struct drm_crtc *crtc,
 	if (event) {
 		crtc->state->event = NULL;
 
-		spin_lock_irq(&crtc->dev->event_lock);
+		spin_lock_irq(&ddev->event_lock);
 		if (drm_crtc_vblank_get(crtc) == 0)
 			drm_crtc_arm_vblank_event(crtc, event);
 		else
 			drm_crtc_send_vblank_event(crtc, event);
-		spin_unlock_irq(&crtc->dev->event_lock);
+		spin_unlock_irq(&ddev->event_lock);
 	}
 }
 
@@ -663,15 +692,19 @@ bool ltdc_crtc_scanoutpos(struct drm_device *ddev, unsigned int pipe,
 	 * Computation for the two first cases are identical so we can
 	 * simplify the code and only test if line > vactive_end
 	 */
-	line = reg_read(ldev->regs, LTDC_CPSR) & CPSR_CYPOS;
-	vactive_start = reg_read(ldev->regs, LTDC_BPCR) & BPCR_AVBP;
-	vactive_end = reg_read(ldev->regs, LTDC_AWCR) & AWCR_AAH;
-	vtotal = reg_read(ldev->regs, LTDC_TWCR) & TWCR_TOTALH;
-
-	if (line > vactive_end)
-		*vpos = line - vtotal - vactive_start;
-	else
-		*vpos = line - vactive_start;
+	if (pm_runtime_active(ddev->dev)) {
+		line = reg_read(ldev->regs, LTDC_CPSR) & CPSR_CYPOS;
+		vactive_start = reg_read(ldev->regs, LTDC_BPCR) & BPCR_AVBP;
+		vactive_end = reg_read(ldev->regs, LTDC_AWCR) & AWCR_AAH;
+		vtotal = reg_read(ldev->regs, LTDC_TWCR) & TWCR_TOTALH;
+
+		if (line > vactive_end)
+			*vpos = line - vtotal - vactive_start;
+		else
+			*vpos = line - vactive_start;
+	} else {
+		*vpos = 0;
+	}
 
 	*hpos = 0;
 
@@ -1243,8 +1276,11 @@ int ltdc_load(struct drm_device *ddev)
 	/* Allow usage of vblank without having to call drm_irq_install */
 	ddev->irq_enabled = 1;
 
-	return 0;
+	clk_disable_unprepare(ldev->pixel_clk);
+
+	pm_runtime_enable(ddev->dev);
 
+	return 0;
 err:
 	for (i = 0; i < MAX_ENDPOINTS; i++)
 		drm_panel_bridge_remove(bridge[i]);
@@ -1256,7 +1292,6 @@ int ltdc_load(struct drm_device *ddev)
 
 void ltdc_unload(struct drm_device *ddev)
 {
-	struct ltdc_device *ldev = ddev->dev_private;
 	int i;
 
 	DRM_DEBUG_DRIVER("\n");
@@ -1264,7 +1299,7 @@ void ltdc_unload(struct drm_device *ddev)
 	for (i = 0; i < MAX_ENDPOINTS; i++)
 		drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
 
-	clk_disable_unprepare(ldev->pixel_clk);
+	pm_runtime_disable(ddev->dev);
 }
 
 MODULE_AUTHOR("Philippe Cornu <philippe.cornu@st.com>");
-- 
2.7.4

