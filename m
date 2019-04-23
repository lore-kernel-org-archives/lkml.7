Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109D5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FB720645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfDWHkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:40:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfDWHkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C4F419AD94D21A52839F;
        Tue, 23 Apr 2019 15:40:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:05 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>
Subject: [PATCH next 05/25] drm/msm: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:00 +0800
Message-ID: <20190423075020.173734-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_get_drvdata directly.

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c |  6 ++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c    | 13 +++++--------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   |  6 ++----
 drivers/gpu/drm/msm/dsi/dsi_host.c         |  6 ++----
 drivers/gpu/drm/msm/msm_drv.c              |  3 +--
 drivers/gpu/drm/msm/msm_gpu.c              |  6 +++---
 6 files changed, 15 insertions(+), 25 deletions(-)

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
index 4697d854b827..9faa9290421a 100644
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
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 10babd18e286..b8d154d6470f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -35,7 +35,7 @@
 static int msm_devfreq_target(struct device *dev, unsigned long *freq,
 		u32 flags)
 {
-	struct msm_gpu *gpu = platform_get_drvdata(to_platform_device(dev));
+	struct msm_gpu *gpu = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
@@ -56,7 +56,7 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
 static int msm_devfreq_get_dev_status(struct device *dev,
 		struct devfreq_dev_status *status)
 {
-	struct msm_gpu *gpu = platform_get_drvdata(to_platform_device(dev));
+	struct msm_gpu *gpu = dev_get_drvdata(dev);
 	ktime_t time;
 
 	if (gpu->funcs->gpu_get_freq)
@@ -75,7 +75,7 @@ static int msm_devfreq_get_dev_status(struct device *dev,
 
 static int msm_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
 {
-	struct msm_gpu *gpu = platform_get_drvdata(to_platform_device(dev));
+	struct msm_gpu *gpu = dev_get_drvdata(dev);
 
 	if (gpu->funcs->gpu_get_freq)
 		*freq = gpu->funcs->gpu_get_freq(gpu);
-- 
2.20.1

