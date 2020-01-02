Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0366DC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E202085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4HlM1/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgABJt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:49:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37054 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgABJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:49:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so5122482wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 01:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=8CFwwBAmgqgcgGzucLPpxl2tYfKM/hG3OYkRoe8WYPU=;
        b=d4HlM1/TBFOTa6XiDaYcMZwGiUc51p4Pv0bBSbInlqbpvi1cIco9U5kLvaLBYdgLZW
         VaS9zaAFFO6S9Oc1lQKYNjDjrW4NCYPPoAu2ovrM6Ubd7GXc1PE5pL1VJO/hxapXCaGs
         67jqWjWasTK8FQwLLx1skppJitsfvMVOrZj0VmXyeKVyh4z0Vra7l/Crr3ECYLm6CykX
         oxqwJsl5db2DHXHUXn4sDy40dp9gi9B2akAWlnOMkfkFUIyx1HfMAiBGefzkP+r6Oiff
         jVKJPkTI+/VZiHFbipEqUL+f80TtVzegY+kexQHhFwwRwokXHzqlk2187GJ7o2Ay5dIP
         aa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=8CFwwBAmgqgcgGzucLPpxl2tYfKM/hG3OYkRoe8WYPU=;
        b=iZOh+JjMk3omTBZ8N0Y/99/VnjtugMX2mJeVexc6UHKwd3gDG7n5xBI5ak4DAp+P+I
         kzxoDsewmOLfjfJAH7cDUPr3Vn4yDsOdBHnsV0YLFkzm19F7R+tRiYFcoLoeaaTLFOgC
         N+86UgDobaRgzt+pjmzFDldKjwziH6AlMcotkAr6dsNi2cHwMfLz0Ud0rTXwmBuD60YS
         KBm+BhIkzw3dFcNsCGqdo1JuuvYn1UBNIkeVRLWhR+cMGWdu+PmGv7DY5bq9gGOdIxZw
         WZ8+nGJTQeNo3ZQpNxQR2njkxkS0Bt4LBNeC0r/kdpIvV7QXdsVSCqAcF/qB8N3r91qt
         zD5w==
X-Gm-Message-State: APjAAAWjSNUKBoNOru2OTdOs4Jm65bFz0gZNo3RPKkT1T0rpm++iiKYr
        YMvdHDDXnFGUtDgWjTZgtkw=
X-Google-Smtp-Source: APXvYqzO9axMTRGskzMsGwa8ngIZWcBBu4BvMO32lxcz//RnPJJwDLNpK5ESv5nCEsFizWXHbDucgw==
X-Received: by 2002:a1c:964f:: with SMTP id y76mr13491283wmd.62.1577958565901;
        Thu, 02 Jan 2020 01:49:25 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id h66sm8383963wme.41.2020.01.02.01.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 01:49:25 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: remove boolean comparisons in conditionals.
Date:   Thu,  2 Jan 2020 12:49:21 +0300
Message-Id: <20200102094921.6274-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary comparisons to true/false in if statements.
Issues found by coccinelle.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c  | 2 +-
 drivers/gpu/drm/i915/display/intel_dp.c   | 2 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 9ba794cb9b4f..c065078b3be2 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -1812,7 +1812,7 @@ void intel_ddi_set_vc_payload_alloc(const struct intel_crtc_state *crtc_state,
 	u32 temp;
 
 	temp = I915_READ(TRANS_DDI_FUNC_CTL(cpu_transcoder));
-	if (state == true)
+	if (state)
 		temp |= TRANS_DDI_DP_VC_PAYLOAD_ALLOC;
 	else
 		temp &= ~TRANS_DDI_DP_VC_PAYLOAD_ALLOC;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index aa515261cb9f..93140c75386a 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4958,7 +4958,7 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
 		WARN_ON_ONCE(intel_dp->active_mst_links < 0);
 		bret = intel_dp_get_sink_irq_esi(intel_dp, esi);
 go_again:
-		if (bret == true) {
+		if (bret) {
 
 			/* check link status - esi[10] = 0x200c */
 			if (intel_dp->active_mst_links > 0 &&
diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
index 47f5d87a938a..cff254c52f5e 100644
--- a/drivers/gpu/drm/i915/display/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
@@ -3292,8 +3292,8 @@ bool intel_sdvo_init(struct drm_i915_private *dev_priv,
 	if (!intel_sdvo_get_capabilities(intel_sdvo, &intel_sdvo->caps))
 		goto err;
 
-	if (intel_sdvo_output_setup(intel_sdvo,
-				    intel_sdvo->caps.output_flags) != true) {
+	if (!intel_sdvo_output_setup(intel_sdvo,
+				     intel_sdvo->caps.output_flags)) {
 		DRM_DEBUG_KMS("SDVO output failed to setup on %s\n",
 			      SDVO_NAME(intel_sdvo));
 		/* Output_setup can leave behind connectors! */
-- 
2.17.1

