Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C782DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECD42085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfCSQgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:36:36 -0400
Received: from sauhun.de ([88.99.104.3]:46088 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSQgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:36:35 -0400
Received: from localhost (p5486CE21.dip0.t-ipconnect.de [84.134.206.33])
        by pokefinder.org (Postfix) with ESMTPSA id E95C94A1346;
        Tue, 19 Mar 2019 17:36:32 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 1/2] drm/msm: simplify getting .driver_data
Date:   Tue, 19 Mar 2019 17:36:28 +0100
Message-Id: <20190319163629.30660-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/gpu/drm/msm/adreno/adreno_device.c |  6 ++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c    | 13 +++++--------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   |  6 ++----
 drivers/gpu/drm/msm/dsi/dsi_host.c         |  6 ++----
 drivers/gpu/drm/msm/msm_drv.c              |  3 +--
 5 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 714ed6505e47..13802af8294c 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -412,16 +412,14 @@ static const struct of_device_id dt_match[] = {
 #ifdef CONFIG_PM
 static int adreno_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_gpu *gpu = platform_get_drvdata(pdev);
+	struct msm_gpu *gpu = dev_get_drvdata(dev);
 
 	return gpu->funcs->pm_resume(gpu);
 }
 
 static int adreno_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_gpu *gpu = platform_get_drvdata(pdev);
+	struct msm_gpu *gpu = dev_get_drvdata(dev);
 
 	return gpu->funcs->pm_suspend(gpu);
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 885bf88afa3e..0154eb9b343f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1036,16 +1036,15 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 
 static void dpu_unbind(struct device *dev, struct device *master, void *data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dpu_kms *dpu_kms = platform_get_drvdata(pdev);
+	struct dpu_kms *dpu_kms = dev_get_drvdata(dev);
 	struct dss_module_power *mp = &dpu_kms->mp;
 
 	msm_dss_put_clk(mp->clk_config, mp->num_clk);
-	devm_kfree(&pdev->dev, mp->clk_config);
+	devm_kfree(dev, mp->clk_config);
 	mp->num_clk = 0;
 
 	if (dpu_kms->rpm_enabled)
-		pm_runtime_disable(&pdev->dev);
+		pm_runtime_disable(dev);
 }
 
 static const struct component_ops dpu_ops = {
@@ -1067,8 +1066,7 @@ static int dpu_dev_remove(struct platform_device *pdev)
 static int __maybe_unused dpu_runtime_suspend(struct device *dev)
 {
 	int rc = -1;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dpu_kms *dpu_kms = platform_get_drvdata(pdev);
+	struct dpu_kms *dpu_kms = dev_get_drvdata(dev);
 	struct drm_device *ddev;
 	struct dss_module_power *mp = &dpu_kms->mp;
 
@@ -1088,8 +1086,7 @@ static int __maybe_unused dpu_runtime_suspend(struct device *dev)
 static int __maybe_unused dpu_runtime_resume(struct device *dev)
 {
 	int rc = -1;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dpu_kms *dpu_kms = platform_get_drvdata(pdev);
+	struct dpu_kms *dpu_kms = dev_get_drvdata(dev);
 	struct drm_encoder *encoder;
 	struct drm_device *ddev;
 	struct dss_module_power *mp = &dpu_kms->mp;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 97179bec8902..8f7a01d7a663 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -1063,8 +1063,7 @@ static int mdp5_dev_remove(struct platform_device *pdev)
 
 static __maybe_unused int mdp5_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct mdp5_kms *mdp5_kms = platform_get_drvdata(pdev);
+	struct mdp5_kms *mdp5_kms = dev_get_drvdata(dev);
 
 	DBG("");
 
@@ -1073,8 +1072,7 @@ static __maybe_unused int mdp5_runtime_suspend(struct device *dev)
 
 static __maybe_unused int mdp5_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct mdp5_kms *mdp5_kms = platform_get_drvdata(pdev);
+	struct mdp5_kms *mdp5_kms = dev_get_drvdata(dev);
 
 	DBG("");
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 610183db1daf..4a158c41ef30 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -485,8 +485,7 @@ static void dsi_bus_clk_disable(struct msm_dsi_host *msm_host)
 
 int msm_dsi_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_dsi *msm_dsi = platform_get_drvdata(pdev);
+	struct msm_dsi *msm_dsi = dev_get_drvdata(dev);
 	struct mipi_dsi_host *host = msm_dsi->host;
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 
@@ -500,8 +499,7 @@ int msm_dsi_runtime_suspend(struct device *dev)
 
 int msm_dsi_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_dsi *msm_dsi = platform_get_drvdata(pdev);
+	struct msm_dsi *msm_dsi = dev_get_drvdata(dev);
 	struct mipi_dsi_host *host = msm_dsi->host;
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 0bdd93648761..071ad87ce44e 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -251,8 +251,7 @@ static int vblank_ctrl_queue_work(struct msm_drm_private *priv,
 
 static int msm_drm_uninit(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct drm_device *ddev = platform_get_drvdata(pdev);
+	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct msm_drm_private *priv = ddev->dev_private;
 	struct msm_kms *kms = priv->kms;
 	struct msm_mdss *mdss = priv->mdss;
-- 
2.11.0

