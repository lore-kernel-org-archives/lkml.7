Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88690C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5021B20673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwdVWDH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgAIJG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:06:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40613 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgAIJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:06:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so1904705wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7k+Tp+4UTtICC+lCn58vYCXG/ReVDDdw2k8DzM6Ih5o=;
        b=lwdVWDH9iJdTkyL+UybQQ5Rk5NgJZRhgXMyA5NyyOEyiMZRZxKKLEWNgp+ojE1kJq7
         wmBdWeqDMsEG9rWcJZNl2IGcUOIemGIP8KNe8fwfkW/VvyQcRYGIIpZoa8lpnrCl35lS
         /J6wJNiqm7WaSxMn36vc2jufXLGZ+asIqKYMN0XaGDCOa+QVgshIth1y8tzIxOII2OAb
         i9hxqyV8O9GCDxbA4qFfHbTCC8vfAiqmjpQAqrfG4P9RecZLSOlH2+zvsxzrSL8wrJ/F
         kF07Kh0828ZRb3LZSRl4L864SQmvG8Ke4Smj0BF0jDhDJwfyJh+4HyyEigfTxO5GkP4g
         ALpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7k+Tp+4UTtICC+lCn58vYCXG/ReVDDdw2k8DzM6Ih5o=;
        b=r0BI2Wa9LLGSy7CENSivOszABxuM90ehwRkQpeGM6gJJjt0JFlLl+wjqd97H+eVTbm
         a/QdHVesl+aKQFV6OfbckCX9y84T0tRZ0BRZHJc/dc3q06pXF3Yc4lPZHNYaoXwIlQ0a
         EHpK6xvbnpPK34qCIhdYurPPbcnuXuymMHaMAXR0LUy3dNgAzUOCeIuJ2PbVbmf2Lff4
         44qg9EnixgD0xgn1Pllc/8Vg5Jj4y9m1dV0nJlmQ+ueqNhdRFAaG1hL+DhXJMRj6bGmp
         ktEUrhBre/FvUziPUwGaR7Uh0Au12p/dy1D4woOPbx9eWPGC+HjFplVC20Y7QeRKN+y1
         k2IA==
X-Gm-Message-State: APjAAAVN3adZ+tq1g4v6mxW5O/WKOCM5ws53yr8oaGu3hc1+fcfVflrL
        SiSdk9e08NXzE0tjHY85EGPA+3igv1c=
X-Google-Smtp-Source: APXvYqwmtKE9R2Zakz4/sgAkRAoPFL3mtxwfw6xzl1oEAW/bAgV5Z6cMIN/cXpUQ8Xg7sIHEKpj3dA==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr3621266wmb.0.1578560814630;
        Thu, 09 Jan 2020 01:06:54 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i8sm8004734wro.47.2020.01.09.01.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:06:54 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/i915: conversion to new logging macros in i915/i915_vgpu.c
Date:   Thu,  9 Jan 2020 12:06:42 +0300
Message-Id: <45e8bffff8cbffd72ed41901c3db9f7f6dbe79f3.1578560355.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578560355.git.wambui.karugax@gmail.com>
References: <cover.1578560355.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of printk based logging macros with the struct
drm_device based macros in i915/i915_vgpu.c

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/i915_vgpu.c | 41 +++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_vgpu.c b/drivers/gpu/drm/i915/i915_vgpu.c
index 968be26735c5..4afe21662266 100644
--- a/drivers/gpu/drm/i915/i915_vgpu.c
+++ b/drivers/gpu/drm/i915/i915_vgpu.c
@@ -77,7 +77,8 @@ void i915_detect_vgpu(struct drm_i915_private *dev_priv)
 
 	shared_area = pci_iomap_range(pdev, 0, VGT_PVINFO_PAGE, VGT_PVINFO_SIZE);
 	if (!shared_area) {
-		DRM_ERROR("failed to map MMIO bar to check for VGT\n");
+		drm_err(&dev_priv->drm,
+			"failed to map MMIO bar to check for VGT\n");
 		return;
 	}
 
@@ -87,7 +88,7 @@ void i915_detect_vgpu(struct drm_i915_private *dev_priv)
 
 	version_major = readw(shared_area + vgtif_offset(version_major));
 	if (version_major < VGT_VERSION_MAJOR) {
-		DRM_INFO("VGT interface version mismatch!\n");
+		drm_info(&dev_priv->drm, "VGT interface version mismatch!\n");
 		goto out;
 	}
 
@@ -95,7 +96,7 @@ void i915_detect_vgpu(struct drm_i915_private *dev_priv)
 
 	dev_priv->vgpu.active = true;
 	mutex_init(&dev_priv->vgpu.lock);
-	DRM_INFO("Virtual GPU for Intel GVT-g detected.\n");
+	drm_info(&dev_priv->drm, "Virtual GPU for Intel GVT-g detected.\n");
 
 out:
 	pci_iounmap(pdev, shared_area);
@@ -120,13 +121,15 @@ static struct _balloon_info_ bl_info;
 static void vgt_deballoon_space(struct i915_ggtt *ggtt,
 				struct drm_mm_node *node)
 {
+	struct drm_i915_private *dev_priv = ggtt->vm.i915;
 	if (!drm_mm_node_allocated(node))
 		return;
 
-	DRM_DEBUG_DRIVER("deballoon space: range [0x%llx - 0x%llx] %llu KiB.\n",
-			 node->start,
-			 node->start + node->size,
-			 node->size / 1024);
+	drm_dbg(&dev_priv->drm,
+		"deballoon space: range [0x%llx - 0x%llx] %llu KiB.\n",
+		node->start,
+		node->start + node->size,
+		node->size / 1024);
 
 	ggtt->vm.reserved -= node->size;
 	drm_mm_remove_node(node);
@@ -141,12 +144,13 @@ static void vgt_deballoon_space(struct i915_ggtt *ggtt,
  */
 void intel_vgt_deballoon(struct i915_ggtt *ggtt)
 {
+	struct drm_i915_private *dev_priv = ggtt->vm.i915;
 	int i;
 
 	if (!intel_vgpu_active(ggtt->vm.i915))
 		return;
 
-	DRM_DEBUG("VGT deballoon.\n");
+	drm_dbg(&dev_priv->drm, "VGT deballoon.\n");
 
 	for (i = 0; i < 4; i++)
 		vgt_deballoon_space(ggtt, &bl_info.space[i]);
@@ -156,13 +160,15 @@ static int vgt_balloon_space(struct i915_ggtt *ggtt,
 			     struct drm_mm_node *node,
 			     unsigned long start, unsigned long end)
 {
+	struct drm_i915_private *dev_priv = ggtt->vm.i915;
 	unsigned long size = end - start;
 	int ret;
 
 	if (start >= end)
 		return -EINVAL;
 
-	DRM_INFO("balloon space: range [ 0x%lx - 0x%lx ] %lu KiB.\n",
+	drm_info(&dev_priv->drm,
+		 "balloon space: range [ 0x%lx - 0x%lx ] %lu KiB.\n",
 		 start, end, size / 1024);
 	ret = i915_gem_gtt_reserve(&ggtt->vm, node,
 				   size, start, I915_COLOR_UNEVICTABLE,
@@ -219,7 +225,8 @@ static int vgt_balloon_space(struct i915_ggtt *ggtt,
  */
 int intel_vgt_balloon(struct i915_ggtt *ggtt)
 {
-	struct intel_uncore *uncore = &ggtt->vm.i915->uncore;
+	struct drm_i915_private *dev_priv = ggtt->vm.i915;
+	struct intel_uncore *uncore = &dev_priv->uncore;
 	unsigned long ggtt_end = ggtt->vm.total;
 
 	unsigned long mappable_base, mappable_size, mappable_end;
@@ -241,16 +248,18 @@ int intel_vgt_balloon(struct i915_ggtt *ggtt)
 	mappable_end = mappable_base + mappable_size;
 	unmappable_end = unmappable_base + unmappable_size;
 
-	DRM_INFO("VGT ballooning configuration:\n");
-	DRM_INFO("Mappable graphic memory: base 0x%lx size %ldKiB\n",
+	drm_info(&dev_priv->drm, "VGT ballooning configuration:\n");
+	drm_info(&dev_priv->drm,
+		 "Mappable graphic memory: base 0x%lx size %ldKiB\n",
 		 mappable_base, mappable_size / 1024);
-	DRM_INFO("Unmappable graphic memory: base 0x%lx size %ldKiB\n",
+	drm_info(&dev_priv->drm,
+		 "Unmappable graphic memory: base 0x%lx size %ldKiB\n",
 		 unmappable_base, unmappable_size / 1024);
 
 	if (mappable_end > ggtt->mappable_end ||
 	    unmappable_base < ggtt->mappable_end ||
 	    unmappable_end > ggtt_end) {
-		DRM_ERROR("Invalid ballooning configuration!\n");
+		drm_err(&dev_priv->drm, "Invalid ballooning configuration!\n");
 		return -EINVAL;
 	}
 
@@ -287,7 +296,7 @@ int intel_vgt_balloon(struct i915_ggtt *ggtt)
 			goto err_below_mappable;
 	}
 
-	DRM_INFO("VGT balloon successfully\n");
+	drm_info(&dev_priv->drm, "VGT balloon successfully\n");
 	return 0;
 
 err_below_mappable:
@@ -297,6 +306,6 @@ int intel_vgt_balloon(struct i915_ggtt *ggtt)
 err_upon_mappable:
 	vgt_deballoon_space(ggtt, &bl_info.space[2]);
 err:
-	DRM_ERROR("VGT balloon fail\n");
+	drm_err(&dev_priv->drm, "VGT balloon fail\n");
 	return ret;
 }
-- 
2.24.1

