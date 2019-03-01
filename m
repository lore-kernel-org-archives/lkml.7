Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E16C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BD92084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BiXLIVB1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V1OV815Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfCATjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:39:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfCATjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:39:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 48C1261A73; Fri,  1 Mar 2019 19:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469191;
        bh=VEbPbYm/qdcD3mba/AFbaTWNwPNd6uxUeYOD8sLO36k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BiXLIVB1RVQ1Iy6Q5bers2rFyHugwjApYhOj8lXcrOD46GBkOd053NxvVTk0QCfov
         DWYinc3fYc54M54HgX/akSsDP2+ST9CxtgSnP7MUiK3NallHGWZQyavvfRQcrSfw/a
         4miS7FJiq4cz9gmkrq5EFi7eGbCjAfKHsqwB/Ar0=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD87E618E9;
        Fri,  1 Mar 2019 19:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469145;
        bh=VEbPbYm/qdcD3mba/AFbaTWNwPNd6uxUeYOD8sLO36k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1OV815Y7JlXPAEFGbGAa/SjuWzH7MIyECwlWYVlLKryaOS8hVFTiP1HY07hB32mb
         BZJ/4o4S/jMszAfwAAKW7Jnz6me6Ijue9rFslRa7tijx2wTZ5NJJUFGMsMJlPHQeB9
         Th3+tvmrzZ9cwQECEh/iNWY8GeqrZqKhBb+jLEXc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD87E618E9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        dianders@chromimum.org, hoegsberg@google.com,
        baolu.lu@linux.intel.com, Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [RFC PATCH v1 14/15] drm/msm/a6xx: Support per-instance pagetables
Date:   Fri,  1 Mar 2019 12:38:36 -0700
Message-Id: <1551469117-3404-15-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for per-instance pagetables for a6xx targets. Add support
to handle split pagetables and create a new instance if the needed
IOMMU support exists and insert the necessary PM4 commands to trigger
a pagetable switch at the beginning of a user command.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 124 ++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |   1 +
 2 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index f2e0800..57d1909 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -10,6 +10,63 @@
 
 #include <linux/devfreq.h>
 
+static void a6xx_set_pagetable(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
+	struct msm_file_private *ctx)
+{
+	u64 ttbr;
+	u32 asid;
+
+	if (!msm_iommu_get_ptinfo(ctx->aspace->mmu, &ttbr, &asid))
+		return;
+
+	ttbr = ttbr | ((u64) asid) << 48;
+
+	/* Turn off protected mode */
+	OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
+	OUT_RING(ring, 0);
+
+	/* Turn on APIV mode to access critical regions */
+	OUT_PKT4(ring, REG_A6XX_CP_MISC_CNTL, 1);
+	OUT_RING(ring, 1);
+
+	/* Make sure the ME is synchronized before staring the update */
+	OUT_PKT7(ring, CP_WAIT_FOR_ME, 0);
+
+	/* Execute the table update */
+	OUT_PKT7(ring, CP_SMMU_TABLE_UPDATE, 4);
+	OUT_RING(ring, lower_32_bits(ttbr));
+	OUT_RING(ring, upper_32_bits(ttbr));
+	/* CONTEXTIDR is currently unused */
+	OUT_RING(ring, 0);
+	/* CONTEXTBANK is currently unused */
+	OUT_RING(ring, 0);
+
+	/*
+	 * Write the new TTBR0 to the preemption records - this will be used to
+	 * reload the pagetable if the current ring gets preempted out.
+	 */
+	OUT_PKT7(ring, CP_MEM_WRITE, 4);
+	OUT_RING(ring, lower_32_bits(rbmemptr(ring, ttbr0)));
+	OUT_RING(ring, upper_32_bits(rbmemptr(ring, ttbr0)));
+	OUT_RING(ring, lower_32_bits(ttbr));
+	OUT_RING(ring, upper_32_bits(ttbr));
+
+	/* Invalidate the draw state so we start off fresh */
+	OUT_PKT7(ring, CP_SET_DRAW_STATE, 3);
+	OUT_RING(ring, 0x40000);
+	OUT_RING(ring, 1);
+	OUT_RING(ring, 0);
+
+	/* Turn off APRIV */
+	OUT_PKT4(ring, REG_A6XX_CP_MISC_CNTL, 1);
+	OUT_RING(ring, 0);
+
+	/* Turn off protected mode */
+	OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
+	OUT_RING(ring, 1);
+}
+
+
 static inline bool _a6xx_check_idle(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -87,6 +144,8 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned int i;
 
+	a6xx_set_pagetable(gpu, ring, ctx);
+
 	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP_0_LO,
 		rbmemptr_stats(ring, index, cpcycles_start));
 
@@ -783,21 +842,77 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
 	return (unsigned long)busy_time;
 }
 
+static struct msm_gem_address_space *a6xx_new_address_space(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct msm_gem_address_space *aspace;
+	int ret;
+
+	/* Return the default pagetable if per instance tables don't work */
+	if (!a6xx_gpu->per_instance_tables)
+		return gpu->aspace;
+
+	aspace = msm_gem_address_space_create_instance(&gpu->pdev->dev, "gpu",
+		0x100000000ULL, 0x1ffffffffULL);
+	if (IS_ERR(aspace))
+		return aspace;
+
+	ret = aspace->mmu->funcs->attach(aspace->mmu, NULL, 0);
+	if (ret) {
+		/* -ENODEV means that aux domains aren't supported */
+		if (ret == -ENODEV)
+			return gpu->aspace;
+
+		return ERR_PTR(ret);
+	}
+
+	return aspace;
+}
+
 static struct msm_gem_address_space *
 a6xx_create_address_space(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct device *dev = &gpu->pdev->dev;
 	struct msm_gem_address_space *aspace;
 	struct iommu_domain *iommu;
-	int ret;
+	int ret, val = 1;
+
+	a6xx_gpu->per_instance_tables = false;
 
 	iommu = iommu_domain_alloc(&platform_bus_type);
 	if (!iommu)
 		return NULL;
 
-	iommu->geometry.aperture_start = 0x100000000ULL;
-	iommu->geometry.aperture_end = 0x1ffffffffULL;
+	/* Try to enable split pagetables */
+	if (iommu_domain_set_attr(iommu, DOMAIN_ATTR_SPLIT_TABLES, &val)) {
+		/*
+		 * If split pagetables aren't available we won't be able to do
+		 * per-instance pagetables so set up the global va space at our
+		 * susual location
+		 */
+		iommu->geometry.aperture_start = 0x100000000ULL;
+		iommu->geometry.aperture_end = 0x1ffffffffULL;
+	} else {
+		/*
+		 * If split pagetables are available then we might be able to do
+		 * per-instance pagetables. Put the default va-space in TTBR1 to
+		 * prepare
+		 */
+		iommu->geometry.aperture_start = 0xfffffff100000000ULL;
+		iommu->geometry.aperture_end = 0xffffff1ffffffffULL;
+
+		/*
+		 * If both split pagetables and aux domains are supported we can
+		 * do per_instance pagetables
+		 */
+		a6xx_gpu->per_instance_tables =
+			iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX);
+	}
 
-	aspace = msm_gem_address_space_create(&gpu->pdev->dev, iommu, "gpu");
+	aspace = msm_gem_address_space_create(dev, iommu, "gpu");
 	if (IS_ERR(aspace)) {
 		iommu_domain_free(iommu);
 		DRM_DEV_ERROR(gpu->dev->dev, "failed to init mmu: %ld\n",
@@ -836,6 +951,7 @@ static const struct adreno_gpu_funcs funcs = {
 		.gpu_state_get = a6xx_gpu_state_get,
 		.gpu_state_put = a6xx_gpu_state_put,
 		.create_address_space = a6xx_create_address_space,
+		.new_address_space = a6xx_new_address_space,
 	},
 	.get_timestamp = a6xx_get_timestamp,
 };
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 528a4cf..4e9ce1c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -21,6 +21,7 @@ struct a6xx_gpu {
 	struct msm_ringbuffer *cur_ring;
 
 	struct a6xx_gmu gmu;
+	bool per_instance_tables;
 };
 
 #define to_a6xx_gpu(x) container_of(x, struct a6xx_gpu, base)
-- 
2.7.4

