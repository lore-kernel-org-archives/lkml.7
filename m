Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6041C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F842087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC87yx9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgAGPNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:13:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37797 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGPNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:13:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so19813873wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dUC/fsfwwgbxjgLgWHravnHWgOXA+EYPU9iBkkWyBGM=;
        b=UC87yx9THmfIPYx9+ugAuCyFYPHlwAFtQzEgRXhkkX/68aX1qv3nDxkwL+sq0GsCby
         cKFSv5PoNl7hWqcBIP51e7mgRKnm0koOM9iXi1Ys/YkcfjeNaBLtvAdIUzEcV/Ctl2n2
         abNEhABTc0bKvHI4vor1SxGhOxB6/ugFnfAjBCKztxT6VYNP/VOcpHHATm+CCp9EUZxg
         bSwAAOtdK/Ae69PEO6FWfLwipEHUNpkfPE/Y7uv9e1zHeSGSirgNWxlVlmjLBPXW675f
         TGtOffMrVC8ya/muEqywnEpz910lm+FuwMHojyQabxC/UUPE5QZSf00GI7ZCOAR9eyEq
         dFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dUC/fsfwwgbxjgLgWHravnHWgOXA+EYPU9iBkkWyBGM=;
        b=Z+IQJ/gjKkcH2fJkQAU+R+NfQeQTNUQQDLn75Pel8jkbsRZXx1aGtl2yO5mzq41KAT
         xE5hhVcHN0mKlHAK1UwfFam+Llm037Uk82L8ne80pgQy4HrhpI3C5hbtGs31LG+eedmP
         QOpVUZxELOM1ffcDvfqpi4oLz2mK96wD2AMqgazzSWa383KqFKhkFOCMtySniWt5kINk
         xnkv+sClGNZ5wfnmXmBG8VsH9ajSirhpVsquy4wSuKiCnu09JwqOX1wiesRSdSUL9kwm
         wkEMstMTiF1KjsjH1ijeuvP38khqmwUxNSVtd5CzXT/luTapfgH9d9wOJfehJwGbMOpU
         m+4g==
X-Gm-Message-State: APjAAAWSijGM9Yf9ULqNkJZfCaGbDi6hrHtTVZqlP37OOgPDwGNqjZPt
        QwGkH4y0HVMeaxlGeLRhnyk=
X-Google-Smtp-Source: APXvYqzXZ/xcJ/Cn17qh3k/3m9+klThM8BzVIdAL7VD5pePoozt8LSwrksWjppjGIhe8KiwvfiqKUQ==
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr40768119wmq.65.1578410021725;
        Tue, 07 Jan 2020 07:13:41 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id c4sm27076664wml.7.2020.01.07.07.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 07:13:41 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     seanpaul@chromium.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/i915: convert to using the drm_dbg_kms() macro.
Date:   Tue,  7 Jan 2020 18:13:29 +0300
Message-Id: <b79ee0f6efbf8358cbb4f2e163fa6b5bb04db794.1578409433.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578409433.git.wambui.karugax@gmail.com>
References: <cover.1578409433.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the use of the DRM_DEBUG_KMS() logging macro to the new struct
drm_device based drm_dbg_kms() logging macro in i915/intel_pch.c.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/intel_pch.c | 46 +++++++++++++++++---------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_pch.c b/drivers/gpu/drm/i915/intel_pch.c
index 43b68b5fc562..4ed60e1f01db 100644
--- a/drivers/gpu/drm/i915/intel_pch.c
+++ b/drivers/gpu/drm/i915/intel_pch.c
@@ -12,90 +12,91 @@ intel_pch_type(const struct drm_i915_private *dev_priv, unsigned short id)
 {
 	switch (id) {
 	case INTEL_PCH_IBX_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found Ibex Peak PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found Ibex Peak PCH\n");
 		WARN_ON(!IS_GEN(dev_priv, 5));
 		return PCH_IBX;
 	case INTEL_PCH_CPT_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found CougarPoint PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found CougarPoint PCH\n");
 		WARN_ON(!IS_GEN(dev_priv, 6) && !IS_IVYBRIDGE(dev_priv));
 		return PCH_CPT;
 	case INTEL_PCH_PPT_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found PantherPoint PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found PantherPoint PCH\n");
 		WARN_ON(!IS_GEN(dev_priv, 6) && !IS_IVYBRIDGE(dev_priv));
 		/* PantherPoint is CPT compatible */
 		return PCH_CPT;
 	case INTEL_PCH_LPT_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found LynxPoint PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found LynxPoint PCH\n");
 		WARN_ON(!IS_HASWELL(dev_priv) && !IS_BROADWELL(dev_priv));
 		WARN_ON(IS_HSW_ULT(dev_priv) || IS_BDW_ULT(dev_priv));
 		return PCH_LPT;
 	case INTEL_PCH_LPT_LP_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found LynxPoint LP PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found LynxPoint LP PCH\n");
 		WARN_ON(!IS_HASWELL(dev_priv) && !IS_BROADWELL(dev_priv));
 		WARN_ON(!IS_HSW_ULT(dev_priv) && !IS_BDW_ULT(dev_priv));
 		return PCH_LPT;
 	case INTEL_PCH_WPT_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found WildcatPoint PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found WildcatPoint PCH\n");
 		WARN_ON(!IS_HASWELL(dev_priv) && !IS_BROADWELL(dev_priv));
 		WARN_ON(IS_HSW_ULT(dev_priv) || IS_BDW_ULT(dev_priv));
 		/* WildcatPoint is LPT compatible */
 		return PCH_LPT;
 	case INTEL_PCH_WPT_LP_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found WildcatPoint LP PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found WildcatPoint LP PCH\n");
 		WARN_ON(!IS_HASWELL(dev_priv) && !IS_BROADWELL(dev_priv));
 		WARN_ON(!IS_HSW_ULT(dev_priv) && !IS_BDW_ULT(dev_priv));
 		/* WildcatPoint is LPT compatible */
 		return PCH_LPT;
 	case INTEL_PCH_SPT_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found SunrisePoint PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found SunrisePoint PCH\n");
 		WARN_ON(!IS_SKYLAKE(dev_priv) && !IS_KABYLAKE(dev_priv));
 		return PCH_SPT;
 	case INTEL_PCH_SPT_LP_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found SunrisePoint LP PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found SunrisePoint LP PCH\n");
 		WARN_ON(!IS_SKYLAKE(dev_priv) && !IS_KABYLAKE(dev_priv) &&
 			!IS_COFFEELAKE(dev_priv));
 		return PCH_SPT;
 	case INTEL_PCH_KBP_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found Kaby Lake PCH (KBP)\n");
+		drm_dbg_kms(&dev_priv->drm, "Found Kaby Lake PCH (KBP)\n");
 		WARN_ON(!IS_SKYLAKE(dev_priv) && !IS_KABYLAKE(dev_priv) &&
 			!IS_COFFEELAKE(dev_priv));
 		/* KBP is SPT compatible */
 		return PCH_SPT;
 	case INTEL_PCH_CNP_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found Cannon Lake PCH (CNP)\n");
+		drm_dbg_kms(&dev_priv->drm, "Found Cannon Lake PCH (CNP)\n");
 		WARN_ON(!IS_CANNONLAKE(dev_priv) && !IS_COFFEELAKE(dev_priv));
 		return PCH_CNP;
 	case INTEL_PCH_CNP_LP_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found Cannon Lake LP PCH (CNP-LP)\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Found Cannon Lake LP PCH (CNP-LP)\n");
 		WARN_ON(!IS_CANNONLAKE(dev_priv) && !IS_COFFEELAKE(dev_priv));
 		return PCH_CNP;
 	case INTEL_PCH_CMP_DEVICE_ID_TYPE:
 	case INTEL_PCH_CMP2_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found Comet Lake PCH (CMP)\n");
+		drm_dbg_kms(&dev_priv->drm, "Found Comet Lake PCH (CMP)\n");
 		WARN_ON(!IS_COFFEELAKE(dev_priv));
 		/* CometPoint is CNP Compatible */
 		return PCH_CNP;
 	case INTEL_PCH_CMP_V_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found Comet Lake V PCH (CMP-V)\n");
+		drm_dbg_kms(&dev_priv->drm, "Found Comet Lake V PCH (CMP-V)\n");
 		WARN_ON(!IS_COFFEELAKE(dev_priv));
 		/* Comet Lake V PCH is based on KBP, which is SPT compatible */
 		return PCH_SPT;
 	case INTEL_PCH_ICP_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found Ice Lake PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found Ice Lake PCH\n");
 		WARN_ON(!IS_ICELAKE(dev_priv));
 		return PCH_ICP;
 	case INTEL_PCH_MCC_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found Mule Creek Canyon PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found Mule Creek Canyon PCH\n");
 		WARN_ON(!IS_ELKHARTLAKE(dev_priv));
 		return PCH_MCC;
 	case INTEL_PCH_TGP_DEVICE_ID_TYPE:
 	case INTEL_PCH_TGP2_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found Tiger Lake LP PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found Tiger Lake LP PCH\n");
 		WARN_ON(!IS_TIGERLAKE(dev_priv));
 		return PCH_TGP;
 	case INTEL_PCH_JSP_DEVICE_ID_TYPE:
 	case INTEL_PCH_JSP2_DEVICE_ID_TYPE:
-		DRM_DEBUG_KMS("Found Jasper Lake PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Found Jasper Lake PCH\n");
 		WARN_ON(!IS_ELKHARTLAKE(dev_priv));
 		return PCH_JSP;
 	default:
@@ -145,9 +146,9 @@ intel_virt_detect_pch(const struct drm_i915_private *dev_priv)
 		id = INTEL_PCH_IBX_DEVICE_ID_TYPE;
 
 	if (id)
-		DRM_DEBUG_KMS("Assuming PCH ID %04x\n", id);
+		drm_dbg_kms(&dev_priv->drm, "Assuming PCH ID %04x\n", id);
 	else
-		DRM_DEBUG_KMS("Assuming no PCH\n");
+		drm_dbg_kms(&dev_priv->drm, "Assuming no PCH\n");
 
 	return id;
 }
@@ -201,13 +202,14 @@ void intel_detect_pch(struct drm_i915_private *dev_priv)
 	 * display.
 	 */
 	if (pch && !HAS_DISPLAY(dev_priv)) {
-		DRM_DEBUG_KMS("Display disabled, reverting to NOP PCH\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Display disabled, reverting to NOP PCH\n");
 		dev_priv->pch_type = PCH_NOP;
 		dev_priv->pch_id = 0;
 	}
 
 	if (!pch)
-		DRM_DEBUG_KMS("No PCH found.\n");
+		drm_dbg_kms(&dev_priv->drm, "No PCH found.\n");
 
 	pci_dev_put(pch);
 }
-- 
2.24.1

