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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9799CC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675C020673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTrUtVuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgAIJHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:07:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43442 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbgAIJHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:07:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so6460415wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZjGs6UaTVRsqD7bMcmmmmdB5ZvGFZd3+9egdXlSicM=;
        b=mTrUtVuUIgMGMeKiU3qViZO4W1gDjq0b1y5RuoDM/aFt4XoqNTHLGJQVabcB1LrKIQ
         iwC6NKhxaZQbazMlWOJ/Ng3mHn7vj29OSM0Vqor+RkQiWPTI8pVMCCcYEJcc7GqItlkL
         jOXRR1Jjn7htMPtWKITbvLNrboggGbVRebPzRg9ZfR73/heOcRifuOIjp6m+4RgM3qSK
         rNBmkYt2Wsr39XhhMLkTcWBYMSySDDdVOlVHa/l+Vh14E5HOhnJ5hsy/KlCqDCP2xHDT
         dkvr65sEz90V4v7jR/SUITLIkCcGpX7+GcEm/fwwcmCPdGl4HiHF37+YVNXxHcEfGv5A
         sGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZjGs6UaTVRsqD7bMcmmmmdB5ZvGFZd3+9egdXlSicM=;
        b=kOnpRc4J6ZDgO1VV9yBr6BKeoRmDbZhsk1K7ncJL9ALefWtS76pxKLZdq5fYutrJD0
         gfjiCAHoWkbqw4C2OGaHJi1642P9ATNq92qWcT550nXv4RBtMJHNDov9hCoIu6g0uHJU
         uW5qjyUCUd1BCqX1465ahOASsLBuhJDdOAxCiKhs2zhI39FU6KwIZyjauMLkiXVav3vb
         uLBNdFSAz6twELPYoBzzo9goEN9VkB4YntKYlpo0gzt3i6ibkjjORvH+/MMkbzX1IyeB
         tZGWpl8nysx5FIFcVkUALDKyCVJCR5StZO0YePYZ7goyUGB6VXafsFHB6UjccO/6Lq60
         0ipQ==
X-Gm-Message-State: APjAAAXbrZW0eeXGO2UVLKj6xIPnge5rS1bWvBW3Llao1JL2aM6IOyxy
        Wf2aGK0Hcv+KDvpI43d+SW0=
X-Google-Smtp-Source: APXvYqyy6dELvru4OOP3T6y3Yj7E8EV8t3vnuNoSlszG4R1U2avG9l79QFwVBUUis2bzJ3P8u3dXpA==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr9518982wru.65.1578560823717;
        Thu, 09 Jan 2020 01:07:03 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i8sm8004734wro.47.2020.01.09.01.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:07:03 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/i915: convert to new logging macros in i915/intel_gvt.c
Date:   Thu,  9 Jan 2020 12:06:45 +0300
Message-Id: <44f3839820a32ed03d73dc56a6ef3581994802c9.1578560355.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578560355.git.wambui.karugax@gmail.com>
References: <cover.1578560355.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the use of printk based logging macros in i915/intel_gvt.c
with the new struct drm_device based logging macros.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/intel_gvt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_gvt.c b/drivers/gpu/drm/i915/intel_gvt.c
index 2b6c016387c2..38ebd5562c7c 100644
--- a/drivers/gpu/drm/i915/intel_gvt.c
+++ b/drivers/gpu/drm/i915/intel_gvt.c
@@ -67,12 +67,13 @@ void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv)
 		return;
 
 	if (intel_vgpu_active(dev_priv)) {
-		DRM_INFO("GVT-g is disabled for guest\n");
+		drm_info(&dev_priv->drm, "GVT-g is disabled for guest\n");
 		goto bail;
 	}
 
 	if (!is_supported_device(dev_priv)) {
-		DRM_INFO("Unsupported device. GVT-g is disabled\n");
+		drm_info(&dev_priv->drm,
+			 "Unsupported device. GVT-g is disabled\n");
 		goto bail;
 	}
 
@@ -99,18 +100,20 @@ int intel_gvt_init(struct drm_i915_private *dev_priv)
 		return -ENODEV;
 
 	if (!i915_modparams.enable_gvt) {
-		DRM_DEBUG_DRIVER("GVT-g is disabled by kernel params\n");
+		drm_dbg(&dev_priv->drm,
+			"GVT-g is disabled by kernel params\n");
 		return 0;
 	}
 
 	if (USES_GUC_SUBMISSION(dev_priv)) {
-		DRM_ERROR("i915 GVT-g loading failed due to Graphics virtualization is not yet supported with GuC submission\n");
+		drm_err(&dev_priv->drm,
+			"i915 GVT-g loading failed due to Graphics virtualization is not yet supported with GuC submission\n");
 		return -EIO;
 	}
 
 	ret = intel_gvt_init_device(dev_priv);
 	if (ret) {
-		DRM_DEBUG_DRIVER("Fail to init GVT device\n");
+		drm_dbg(&dev_priv->drm, "Fail to init GVT device\n");
 		goto bail;
 	}
 
-- 
2.24.1

