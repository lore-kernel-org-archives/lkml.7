Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C2DC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15642082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WKa7XA8o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jYE1mzJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfDJQ6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:58:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58304 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDJQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:58:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5D2FA61132; Wed, 10 Apr 2019 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554915510;
        bh=itdu6CaScWjWSfyfpgyIhARnIydebF5zEcZ54GQbLpE=;
        h=From:To:Cc:Subject:Date:From;
        b=WKa7XA8ohegUMxDMS8hDlBXF/Sim9UJ66YWTpCwtzpv8NKyBEUDsZfdi0mKG88N4d
         zsfnIzYa1qz0TYhsZktSEpAEWVhdG76HFWb4YWzQW3p8DQdI4RLlny4ewErNzShL0e
         ngSp4/AFghV9aP2iXOHdMR/3Sw01mzqrWPJYEmYI=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4ED286030E;
        Wed, 10 Apr 2019 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554915509;
        bh=itdu6CaScWjWSfyfpgyIhARnIydebF5zEcZ54GQbLpE=;
        h=From:To:Cc:Subject:Date:From;
        b=jYE1mzJybUgGbn/FnT9Be+Fh8aDQpUV+QC0ixNQLphCZDq3quyPp4AHSFHPHdwib/
         KhAi2u/jt1nDZEmLqKpv7fOGGy9GmFS2mVn5mMz8ZEvyVM7yIyIp9R/qbTo7KE35Q5
         YAcAXNoeGI6Q3XKXBRVv7ZGCObDUGVO15Nc23Rww=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4ED286030E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/msm/a6xx: Don't enable GPU state code if dependencies are missing
Date:   Wed, 10 Apr 2019 10:58:16 -0600
Message-Id: <1554915496-5876-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG_DRM_MSM_GPU_STATE to conditionally compile Adreno GPU state
code depending on the availability of the dependencies.

Reported-by: Hulk Robot <hulkci@huawei.com>
Reported-by: YueHaibing <yuehaibing@huawei.com>
Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/Kconfig           | 5 +++++
 drivers/gpu/drm/msm/Makefile          | 3 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 +++-
 drivers/gpu/drm/msm/msm_debugfs.c     | 2 +-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index cf549f1..cf14b2b 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -20,6 +20,11 @@ config DRM_MSM
 	help
 	  DRM/KMS driver for MSM/snapdragon.
 
+config DRM_MSM_GPU_STATE
+	bool
+	depends on DRM_MSM && (DEBUG_FS || DEV_COREDUMP)
+	default y
+
 config DRM_MSM_REGISTER_LOGGING
 	bool "MSM DRM register logging"
 	depends on DRM_MSM
diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 56a70c7..72d1bfc 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -15,7 +15,6 @@ msm-y := \
 	adreno/a6xx_gpu.o \
 	adreno/a6xx_gmu.o \
 	adreno/a6xx_hfi.o \
-	adreno/a6xx_gpu_state.o \
 	hdmi/hdmi.o \
 	hdmi/hdmi_audio.o \
 	hdmi/hdmi_bridge.o \
@@ -96,6 +95,8 @@ msm-y := \
 
 msm-$(CONFIG_DEBUG_FS) += adreno/a5xx_debugfs.o
 
+msm-$(CONFIG_DRM_MSM_GPU_STATE)	+= adreno/a6xx_gpu_state.o
+
 msm-$(CONFIG_DRM_FBDEV_EMULATION) += msm_fbdev.o
 msm-$(CONFIG_COMMON_CLK) += disp/mdp4/mdp4_lvds_pll.o
 msm-$(CONFIG_COMMON_CLK) += hdmi/hdmi_pll_8960.o
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index fefe773..ddbaba1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -781,14 +781,16 @@ static const struct adreno_gpu_funcs funcs = {
 		.active_ring = a6xx_active_ring,
 		.irq = a6xx_irq,
 		.destroy = a6xx_destroy,
-#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
+#if defined(CONFIG_DRM_MSM_GPU_STATE)
 		.show = a6xx_show,
 #endif
 		.gpu_busy = a6xx_gpu_busy,
 		.gpu_get_freq = a6xx_gmu_get_freq,
 		.gpu_set_freq = a6xx_gmu_set_freq,
+#if defined(CONFIG_DRM_MSM_GPU_STATE)
 		.gpu_state_get = a6xx_gpu_state_get,
 		.gpu_state_put = a6xx_gpu_state_put,
+#endif
 	},
 	.get_timestamp = a6xx_get_timestamp,
 };
diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index fb423d3..bcfb7a4 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -75,7 +75,7 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 	struct msm_gpu_show_priv *show_priv;
 	int ret;
 
-	if (!gpu)
+	if (!gpu || !gpu->funcs->gpu-state_get)
 		return -ENODEV;
 
 	show_priv = kmalloc(sizeof(*show_priv), GFP_KERNEL);
-- 
2.7.4

