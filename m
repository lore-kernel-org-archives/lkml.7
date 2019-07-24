Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E74C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B43722ADF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfGXK4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:56:42 -0400
Received: from foss.arm.com ([217.140.110.172]:38890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfGXK4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:56:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EA4C337;
        Wed, 24 Jul 2019 03:56:41 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2D283F71F;
        Wed, 24 Jul 2019 03:56:39 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] drm/panfrost: Export all GPU feature registers
Date:   Wed, 24 Jul 2019 11:56:26 +0100
Message-Id: <20190724105626.53552-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Midgard/Bifrost GPUs have a bunch of feature registers providing details
of what the hardware supports. Panfrost already reads these, this patch
exports them all to user space so that the jobs created by the user space
driver can be tuned for the particular hardware implementation.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 38 +++++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_gpu.c    |  2 ++
 include/uapi/drm/panfrost_drm.h            | 39 ++++++++++++++++++++++
 4 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 83cc01cafde1..ea5948ff3647 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -43,6 +43,7 @@ struct panfrost_features {
 	u32 js_features[16];
 
 	u32 nr_core_groups;
+	u32 thread_tls_alloc;
 
 	unsigned long hw_features[64 / BITS_PER_LONG];
 	unsigned long hw_issues[64 / BITS_PER_LONG];
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 85b4b51b6a0d..4b554c8d56da 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -32,10 +32,42 @@ static int panfrost_ioctl_get_param(struct drm_device *ddev, void *data, struct
 	if (param->pad != 0)
 		return -EINVAL;
 
+#define PANFROST_FEATURE(name, member)			\
+	case DRM_PANFROST_PARAM_ ## name:		\
+		param->value = pfdev->features.member;	\
+		break
+#define PANFROST_FEATURE_ARRAY(name, member, max)			\
+	case DRM_PANFROST_PARAM_ ## name ## 0 ...			\
+		DRM_PANFROST_PARAM_ ## name ## max:			\
+		param->value = pfdev->features.member[param->param -	\
+			DRM_PANFROST_PARAM_ ## name ## 0];		\
+		break
+
 	switch (param->param) {
-	case DRM_PANFROST_PARAM_GPU_PROD_ID:
-		param->value = pfdev->features.id;
-		break;
+		PANFROST_FEATURE(GPU_PROD_ID, id);
+		PANFROST_FEATURE(GPU_REVISION, revision);
+		PANFROST_FEATURE(SHADER_PRESENT, shader_present);
+		PANFROST_FEATURE(TILER_PRESENT, tiler_present);
+		PANFROST_FEATURE(L2_PRESENT, l2_present);
+		PANFROST_FEATURE(STACK_PRESENT, stack_present);
+		PANFROST_FEATURE(AS_PRESENT, as_present);
+		PANFROST_FEATURE(JS_PRESENT, js_present);
+		PANFROST_FEATURE(L2_FEATURES, l2_features);
+		PANFROST_FEATURE(CORE_FEATURES, core_features);
+		PANFROST_FEATURE(TILER_FEATURES, tiler_features);
+		PANFROST_FEATURE(MEM_FEATURES, mem_features);
+		PANFROST_FEATURE(MMU_FEATURES, mmu_features);
+		PANFROST_FEATURE(THREAD_FEATURES, thread_features);
+		PANFROST_FEATURE(MAX_THREADS, max_threads);
+		PANFROST_FEATURE(THREAD_MAX_WORKGROUP_SZ,
+				thread_max_workgroup_sz);
+		PANFROST_FEATURE(THREAD_MAX_BARRIER_SZ,
+				thread_max_barrier_sz);
+		PANFROST_FEATURE(COHERENCY_FEATURES, coherency_features);
+		PANFROST_FEATURE_ARRAY(TEXTURE_FEATURES, texture_features, 3);
+		PANFROST_FEATURE_ARRAY(JS_FEATURES, js_features, 15);
+		PANFROST_FEATURE(NR_CORE_GROUPS, nr_core_groups);
+		PANFROST_FEATURE(THREAD_TLS_ALLOC, thread_tls_alloc);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 20ab333fc925..f67ed925c0ef 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -232,6 +232,8 @@ static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
 	pfdev->features.stack_present = gpu_read(pfdev, GPU_STACK_PRESENT_LO);
 	pfdev->features.stack_present |= (u64)gpu_read(pfdev, GPU_STACK_PRESENT_HI) << 32;
 
+	pfdev->features.thread_tls_alloc = gpu_read(pfdev, GPU_THREAD_TLS_ALLOC);
+
 	gpu_id = gpu_read(pfdev, GPU_ID);
 	pfdev->features.revision = gpu_id & 0xffff;
 	pfdev->features.id = gpu_id >> 16;
diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index b5d370638846..cb577fb96b38 100644
--- a/include/uapi/drm/panfrost_drm.h
+++ b/include/uapi/drm/panfrost_drm.h
@@ -127,6 +127,45 @@ struct drm_panfrost_mmap_bo {
 
 enum drm_panfrost_param {
 	DRM_PANFROST_PARAM_GPU_PROD_ID,
+	DRM_PANFROST_PARAM_GPU_REVISION,
+	DRM_PANFROST_PARAM_SHADER_PRESENT,
+	DRM_PANFROST_PARAM_TILER_PRESENT,
+	DRM_PANFROST_PARAM_L2_PRESENT,
+	DRM_PANFROST_PARAM_STACK_PRESENT,
+	DRM_PANFROST_PARAM_AS_PRESENT,
+	DRM_PANFROST_PARAM_JS_PRESENT,
+	DRM_PANFROST_PARAM_L2_FEATURES,
+	DRM_PANFROST_PARAM_CORE_FEATURES,
+	DRM_PANFROST_PARAM_TILER_FEATURES,
+	DRM_PANFROST_PARAM_MEM_FEATURES,
+	DRM_PANFROST_PARAM_MMU_FEATURES,
+	DRM_PANFROST_PARAM_THREAD_FEATURES,
+	DRM_PANFROST_PARAM_MAX_THREADS,
+	DRM_PANFROST_PARAM_THREAD_MAX_WORKGROUP_SZ,
+	DRM_PANFROST_PARAM_THREAD_MAX_BARRIER_SZ,
+	DRM_PANFROST_PARAM_COHERENCY_FEATURES,
+	DRM_PANFROST_PARAM_TEXTURE_FEATURES0,
+	DRM_PANFROST_PARAM_TEXTURE_FEATURES1,
+	DRM_PANFROST_PARAM_TEXTURE_FEATURES2,
+	DRM_PANFROST_PARAM_TEXTURE_FEATURES3,
+	DRM_PANFROST_PARAM_JS_FEATURES0,
+	DRM_PANFROST_PARAM_JS_FEATURES1,
+	DRM_PANFROST_PARAM_JS_FEATURES2,
+	DRM_PANFROST_PARAM_JS_FEATURES3,
+	DRM_PANFROST_PARAM_JS_FEATURES4,
+	DRM_PANFROST_PARAM_JS_FEATURES5,
+	DRM_PANFROST_PARAM_JS_FEATURES6,
+	DRM_PANFROST_PARAM_JS_FEATURES7,
+	DRM_PANFROST_PARAM_JS_FEATURES8,
+	DRM_PANFROST_PARAM_JS_FEATURES9,
+	DRM_PANFROST_PARAM_JS_FEATURES10,
+	DRM_PANFROST_PARAM_JS_FEATURES11,
+	DRM_PANFROST_PARAM_JS_FEATURES12,
+	DRM_PANFROST_PARAM_JS_FEATURES13,
+	DRM_PANFROST_PARAM_JS_FEATURES14,
+	DRM_PANFROST_PARAM_JS_FEATURES15,
+	DRM_PANFROST_PARAM_NR_CORE_GROUPS,
+	DRM_PANFROST_PARAM_THREAD_TLS_ALLOC,
 };
 
 struct drm_panfrost_get_param {
-- 
2.20.1

