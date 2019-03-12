Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B466FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E862087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Blx8KfFo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k+KLN5/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCLSOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:14:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfCLSOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:14:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BD95F619CF; Tue, 12 Mar 2019 18:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552414455;
        bh=aNzkhEBdMH/+RdBcUjDsck1i/+rqLAmasAElAo9C2u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Blx8KfFocf3V/7A5gw807gfysqQHTwtoGbz9dputmh4aN8TWgNT4M4cZ0iBmybH6E
         iRygIfL7Km4tYZEiBAf1VSxSaW8VTQYDTywITFc6W2E/1xbAj3BvIt5tvxx/dhtaQm
         dKVKqEVSMW+Pj+yDP/HHLVD2IM74bkJ47Ql9mCn8=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1446619AE;
        Tue, 12 Mar 2019 18:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552414449;
        bh=aNzkhEBdMH/+RdBcUjDsck1i/+rqLAmasAElAo9C2u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+KLN5/2+BUIH2KHS4mIDzgUdvXg0v7ee7k+IYMts+b1lGDKFbohWH6nsCNutdcUP
         7h2FQgw191I11skwcjlpskwLdQUrjkTteW19dppOrsQIaY3T4f38j/ilhraBTS4+3j
         TRokdOoF8arO9ODO7dw1AHLE0gGo3yio+YVZ4tEg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1446619AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 1/4] drm/msm/gpu: Move zap shader loading to adreno
Date:   Tue, 12 Mar 2019 12:13:39 -0600
Message-Id: <1552414422-9568-2-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552414422-9568-1-git-send-email-jcrouse@codeaurora.org>
References: <1552414422-9568-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a5xx and a6xx both share (mostly) the same code to load the zap shader and
bring the GPU out of secure mode. Move the formerly 5xx specific code to
adreno to make it available for a6xx too.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 109 +-----------------------------
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 113 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |   6 ++
 3 files changed, 120 insertions(+), 108 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index d5f5e56..e5fcefa 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -15,9 +15,6 @@
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <linux/qcom_scm.h>
-#include <linux/dma-mapping.h>
-#include <linux/of_address.h>
-#include <linux/soc/qcom/mdt_loader.h>
 #include <linux/pm_opp.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/slab.h>
@@ -30,94 +27,6 @@ static void a5xx_dump(struct msm_gpu *gpu);
 
 #define GPU_PAS_ID 13
 
-static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname)
-{
-	struct device *dev = &gpu->pdev->dev;
-	const struct firmware *fw;
-	struct device_node *np;
-	struct resource r;
-	phys_addr_t mem_phys;
-	ssize_t mem_size;
-	void *mem_region = NULL;
-	int ret;
-
-	if (!IS_ENABLED(CONFIG_ARCH_QCOM))
-		return -EINVAL;
-
-	np = of_get_child_by_name(dev->of_node, "zap-shader");
-	if (!np)
-		return -ENODEV;
-
-	np = of_parse_phandle(np, "memory-region", 0);
-	if (!np)
-		return -EINVAL;
-
-	ret = of_address_to_resource(np, 0, &r);
-	if (ret)
-		return ret;
-
-	mem_phys = r.start;
-	mem_size = resource_size(&r);
-
-	/* Request the MDT file for the firmware */
-	fw = adreno_request_fw(to_adreno_gpu(gpu), fwname);
-	if (IS_ERR(fw)) {
-		DRM_DEV_ERROR(dev, "Unable to load %s\n", fwname);
-		return PTR_ERR(fw);
-	}
-
-	/* Figure out how much memory we need */
-	mem_size = qcom_mdt_get_size(fw);
-	if (mem_size < 0) {
-		ret = mem_size;
-		goto out;
-	}
-
-	/* Allocate memory for the firmware image */
-	mem_region = memremap(mem_phys, mem_size,  MEMREMAP_WC);
-	if (!mem_region) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	/*
-	 * Load the rest of the MDT
-	 *
-	 * Note that we could be dealing with two different paths, since
-	 * with upstream linux-firmware it would be in a qcom/ subdir..
-	 * adreno_request_fw() handles this, but qcom_mdt_load() does
-	 * not.  But since we've already gotten thru adreno_request_fw()
-	 * we know which of the two cases it is:
-	 */
-	if (to_adreno_gpu(gpu)->fwloc == FW_LOCATION_LEGACY) {
-		ret = qcom_mdt_load(dev, fw, fwname, GPU_PAS_ID,
-				mem_region, mem_phys, mem_size, NULL);
-	} else {
-		char *newname;
-
-		newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
-
-		ret = qcom_mdt_load(dev, fw, newname, GPU_PAS_ID,
-				mem_region, mem_phys, mem_size, NULL);
-		kfree(newname);
-	}
-	if (ret)
-		goto out;
-
-	/* Send the image to the secure world */
-	ret = qcom_scm_pas_auth_and_reset(GPU_PAS_ID);
-	if (ret)
-		DRM_DEV_ERROR(dev, "Unable to authorize the image\n");
-
-out:
-	if (mem_region)
-		memunmap(mem_region);
-
-	release_firmware(fw);
-
-	return ret;
-}
-
 static void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -563,8 +472,6 @@ static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
 static int a5xx_zap_shader_init(struct msm_gpu *gpu)
 {
 	static bool loaded;
-	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
-	struct platform_device *pdev = gpu->pdev;
 	int ret;
 
 	/*
@@ -574,23 +481,9 @@ static int a5xx_zap_shader_init(struct msm_gpu *gpu)
 	if (loaded)
 		return a5xx_zap_shader_resume(gpu);
 
-	/* We need SCM to be able to load the firmware */
-	if (!qcom_scm_is_available()) {
-		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
-		return -EPROBE_DEFER;
-	}
-
-	/* Each GPU has a target specific zap shader firmware name to use */
-	if (!adreno_gpu->info->zapfw) {
-		DRM_DEV_ERROR(&pdev->dev,
-			"Zap shader firmware file not specified for this target\n");
-		return -ENODEV;
-	}
-
-	ret = zap_shader_load_mdt(gpu, adreno_gpu->info->zapfw);
+	ret = adreno_zap_shader_load(gpu, GPU_PAS_ID);
 
 	loaded = !ret;
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 2789847..a9eb58c 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -19,13 +19,126 @@
 
 #include <linux/ascii85.h>
 #include <linux/interconnect.h>
+#include <linux/qcom_scm.h>
 #include <linux/kernel.h>
+#include <linux/of_address.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
+#include <linux/soc/qcom/mdt_loader.h>
 #include "adreno_gpu.h"
 #include "msm_gem.h"
 #include "msm_mmu.h"
 
+static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
+		u32 pasid)
+{
+	struct device *dev = &gpu->pdev->dev;
+	const struct firmware *fw;
+	struct device_node *np;
+	struct resource r;
+	phys_addr_t mem_phys;
+	ssize_t mem_size;
+	void *mem_region = NULL;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_ARCH_QCOM))
+		return -EINVAL;
+
+	np = of_get_child_by_name(dev->of_node, "zap-shader");
+	if (!np)
+		return -ENODEV;
+
+	np = of_parse_phandle(np, "memory-region", 0);
+	if (!np)
+		return -EINVAL;
+
+	ret = of_address_to_resource(np, 0, &r);
+	if (ret)
+		return ret;
+
+	mem_phys = r.start;
+	mem_size = resource_size(&r);
+
+	/* Request the MDT file for the firmware */
+	fw = adreno_request_fw(to_adreno_gpu(gpu), fwname);
+	if (IS_ERR(fw)) {
+		DRM_DEV_ERROR(dev, "Unable to load %s\n", fwname);
+		return PTR_ERR(fw);
+	}
+
+	/* Figure out how much memory we need */
+	mem_size = qcom_mdt_get_size(fw);
+	if (mem_size < 0) {
+		ret = mem_size;
+		goto out;
+	}
+
+	/* Allocate memory for the firmware image */
+	mem_region = memremap(mem_phys, mem_size,  MEMREMAP_WC);
+	if (!mem_region) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Load the rest of the MDT
+	 *
+	 * Note that we could be dealing with two different paths, since
+	 * with upstream linux-firmware it would be in a qcom/ subdir..
+	 * adreno_request_fw() handles this, but qcom_mdt_load() does
+	 * not.  But since we've already gotten through adreno_request_fw()
+	 * we know which of the two cases it is:
+	 */
+	if (to_adreno_gpu(gpu)->fwloc == FW_LOCATION_LEGACY) {
+		ret = qcom_mdt_load(dev, fw, fwname, pasid,
+				mem_region, mem_phys, mem_size, NULL);
+	} else {
+		char *newname;
+
+		newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
+
+		ret = qcom_mdt_load(dev, fw, newname, pasid,
+				mem_region, mem_phys, mem_size, NULL);
+		kfree(newname);
+	}
+	if (ret)
+		goto out;
+
+	/* Send the image to the secure world */
+	ret = qcom_scm_pas_auth_and_reset(pasid);
+	if (ret)
+		DRM_DEV_ERROR(dev, "Unable to authorize the image\n");
+
+out:
+	if (mem_region)
+		memunmap(mem_region);
+
+	release_firmware(fw);
+
+	return ret;
+}
+
+int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct platform_device *pdev = gpu->pdev;
+
+	/* We need SCM to be able to load the firmware */
+	if (!qcom_scm_is_available()) {
+		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
+		return -EPROBE_DEFER;
+	}
+
+	/* Each GPU has a target specific zap shader firmware name to use */
+	if (!adreno_gpu->info->zapfw) {
+		DRM_DEV_ERROR(&pdev->dev,
+			"Zap shader firmware file not specified for this target\n");
+		return -ENODEV;
+	}
+
+	return zap_shader_load_mdt(gpu, adreno_gpu->info->zapfw, pasid);
+}
+
 int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 5db459b..0925606e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -252,6 +252,12 @@ void adreno_gpu_state_destroy(struct msm_gpu_state *state);
 int adreno_gpu_state_get(struct msm_gpu *gpu, struct msm_gpu_state *state);
 int adreno_gpu_state_put(struct msm_gpu_state *state);
 
+/*
+ * For a5xx and a6xx targets load the zap shader that is used to pull the GPU
+ * out of secure mode
+ */
+int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid);
+
 /* ringbuffer helpers (the parts that are adreno specific) */
 
 static inline void
-- 
2.7.4

