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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C06C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641F020673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC+bfD98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgAIJHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:07:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35228 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgAIJHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:07:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so6522229wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8+nW7WUiZHp/JTJe3ieEHrqcqpq+rbcRaXX3uhxHvs=;
        b=OC+bfD98D0zbY38YLn1j6UUzuvzFCsCffoXx6rd75N/l27A6rInDg3eqrAq7JhZSfe
         DG5TH/0OgKZMoNsKVCR/F/6ZHsSuZdI8h7T1WnTUa2RarMO3IpiAncNvcQT5KgsrIXWj
         ThXdo7sidBhOB/wY6g5Dk7DOGKxzxCzzHPz1qfbfghYVMB46sLHofTAzlAxFm403evhO
         iUHPp/RTMP1zLjtRwtLJT7ZGYZcFaL31inuCWL38jRxnOD+isDXRSYD/HTysAgCHNrsS
         z8SlhxOv8pI4DC6jGm5x6ju+zg14BuRzJu1vYod4KgYc0QrnolfPoEpGQdoLItjjWRSj
         HTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8+nW7WUiZHp/JTJe3ieEHrqcqpq+rbcRaXX3uhxHvs=;
        b=H/AWiVxRia6wh4XC6GVteZaOSv4vwqjACjEJadl0RWSGxsLusDwQm5fHdMq89VapIP
         o5PYPy6wAWKOuVYVdipmkEmkK4GxZOStjDNsX7QGARftNdaNojXwdB1WuzTkDzvvZyZw
         3SoKUJhzwXDfnMqX/TWMk5jxBDDrSNKl5FuueKtgGOs4LDe9XavChCyOerlKVGcs6tCj
         lzn2A2CZH6kz1JOgDBZT6aXjcQXGWydiobXnL3whwr4DhgRInpZsBKn4B/3/Ir0RLUo2
         JLuTX8aDg/SztUpfkEcdniGj9NwDWXjH7l782Om2N2n9gn5x1CEGeWOenkKDhiPnW05f
         kmlg==
X-Gm-Message-State: APjAAAWu1eC7uCeMlzi2HdxX1jgX5qii3WV9Z1bZ/I0l2ve2RqU1nfge
        hpiFJTSPt4F4wtjuHyjPecc=
X-Google-Smtp-Source: APXvYqzCEUpEv+edqK9ll9+pCMUADVtECHnGemRB5PnQJQWZIgbIFRMja/Fq8jnHGZy/6Mx18My0Mw==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr9357843wrr.172.1578560821062;
        Thu, 09 Jan 2020 01:07:01 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i8sm8004734wro.47.2020.01.09.01.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:07:00 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/i915: conversion to new logging macros in i915/intel_device_info.c
Date:   Thu,  9 Jan 2020 12:06:44 +0300
Message-Id: <e404429ff2a5e5080867f577beccd7b578a671cd.1578560355.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578560355.git.wambui.karugax@gmail.com>
References: <cover.1578560355.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces the printk and struct device based logging macros with the
new struct drm_device style based logging macros i915/intel_device_info.c.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/intel_device_info.c | 25 +++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
index 6670a0763be2..fcdacd6d4aa5 100644
--- a/drivers/gpu/drm/i915/intel_device_info.c
+++ b/drivers/gpu/drm/i915/intel_device_info.c
@@ -974,10 +974,11 @@ void intel_device_info_runtime_init(struct drm_i915_private *dev_priv)
 		    sfuse_strap & SFUSE_STRAP_DISPLAY_DISABLED ||
 		    (HAS_PCH_CPT(dev_priv) &&
 		     !(sfuse_strap & SFUSE_STRAP_FUSE_LOCK))) {
-			DRM_INFO("Display fused off, disabling\n");
+			drm_info(&dev_priv->drm,
+				 "Display fused off, disabling\n");
 			info->pipe_mask = 0;
 		} else if (fuse_strap & IVB_PIPE_C_DISABLE) {
-			DRM_INFO("PipeC fused off\n");
+			drm_info(&dev_priv->drm, "PipeC fused off\n");
 			info->pipe_mask &= ~BIT(PIPE_C);
 		}
 	} else if (HAS_DISPLAY(dev_priv) && INTEL_GEN(dev_priv) >= 9) {
@@ -1000,8 +1001,9 @@ void intel_device_info_runtime_init(struct drm_i915_private *dev_priv)
 		 * in the mask.
 		 */
 		if (enabled_mask == 0 || !is_power_of_2(enabled_mask + 1))
-			DRM_ERROR("invalid pipe fuse configuration: enabled_mask=0x%x\n",
-				  enabled_mask);
+			drm_err(&dev_priv->drm,
+				"invalid pipe fuse configuration: enabled_mask=0x%x\n",
+				enabled_mask);
 		else
 			info->pipe_mask = enabled_mask;
 
@@ -1036,7 +1038,8 @@ void intel_device_info_runtime_init(struct drm_i915_private *dev_priv)
 		gen12_sseu_info_init(dev_priv);
 
 	if (IS_GEN(dev_priv, 6) && intel_vtd_active()) {
-		DRM_INFO("Disabling ppGTT for VT-d support\n");
+		drm_info(&dev_priv->drm,
+			 "Disabling ppGTT for VT-d support\n");
 		info->ppgtt_type = INTEL_PPGTT_NONE;
 	}
 
@@ -1084,7 +1087,7 @@ void intel_device_info_init_mmio(struct drm_i915_private *dev_priv)
 
 		if (!(BIT(i) & vdbox_mask)) {
 			info->engine_mask &= ~BIT(_VCS(i));
-			DRM_DEBUG_DRIVER("vcs%u fused off\n", i);
+			drm_dbg(&dev_priv->drm, "vcs%u fused off\n", i);
 			continue;
 		}
 
@@ -1096,8 +1099,8 @@ void intel_device_info_init_mmio(struct drm_i915_private *dev_priv)
 		if (INTEL_GEN(dev_priv) >= 12 || logical_vdbox++ % 2 == 0)
 			RUNTIME_INFO(dev_priv)->vdbox_sfc_access |= BIT(i);
 	}
-	DRM_DEBUG_DRIVER("vdbox enable: %04x, instances: %04lx\n",
-			 vdbox_mask, VDBOX_MASK(dev_priv));
+	drm_dbg(&dev_priv->drm, "vdbox enable: %04x, instances: %04lx\n",
+		vdbox_mask, VDBOX_MASK(dev_priv));
 	GEM_BUG_ON(vdbox_mask != VDBOX_MASK(dev_priv));
 
 	for (i = 0; i < I915_MAX_VECS; i++) {
@@ -1108,10 +1111,10 @@ void intel_device_info_init_mmio(struct drm_i915_private *dev_priv)
 
 		if (!(BIT(i) & vebox_mask)) {
 			info->engine_mask &= ~BIT(_VECS(i));
-			DRM_DEBUG_DRIVER("vecs%u fused off\n", i);
+			drm_dbg(&dev_priv->drm, "vecs%u fused off\n", i);
 		}
 	}
-	DRM_DEBUG_DRIVER("vebox enable: %04x, instances: %04lx\n",
-			 vebox_mask, VEBOX_MASK(dev_priv));
+	drm_dbg(&dev_priv->drm, "vebox enable: %04x, instances: %04lx\n",
+		vebox_mask, VEBOX_MASK(dev_priv));
 	GEM_BUG_ON(vebox_mask != VEBOX_MASK(dev_priv));
 }
-- 
2.24.1

