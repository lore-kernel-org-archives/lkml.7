Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7123C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8765520665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KKbpnEI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfFRGzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:55:14 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:39709 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfFRGzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:55:13 -0400
Received: by mail-ua1-f74.google.com with SMTP id k28so1226497uag.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 23:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=vA+kgCBJcMIEMYkHeCd3wqGKPPi8vvElInzRHbJTvB8=;
        b=KKbpnEI4yIX74RaM9/bLJx/4xoN0lCr2LwXQdZSyNKKoxZwHE9094lHB1FJuZ0sB88
         rfVznJ3DZfGHrFixDzS3bns4EvPzlA55o0O/HHO+iSApv36ZRuzNVoeOb/CKzLSTL4oq
         L/E36UYXuG/XnBuJqDPBFAWfjIs9iOXsK4tCb/dTwcO50aHYja/3U2V82oil/qy0IIbZ
         ctRkBK7qkI208VxZZ4PDuel+qhQ6B92PqmPAllouqyvEVxssCXOFnzLUnbpOMBcCEs4C
         gz2/Rkk2S4VN1Ak3HlvFCw3tdPhL6q+GpXPdmyIa9WWsh2Hev6KUFIpqp+byhJY6mrfh
         mVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=vA+kgCBJcMIEMYkHeCd3wqGKPPi8vvElInzRHbJTvB8=;
        b=TcrfcipWRLZ/yQMutcDHhVsgPA/NJdeRKyVA7ZmRKVl3woAtOJNpZE0EMH4ljBLhVw
         lpVRXQcb2jRRMJaE/S94WwVMpwWNkChyKCURBQqYzehaLwPrkPcZB7EYMoR/m+RWHfNl
         M5t+BSqnkhLrkGG24xKqAMlnmcbSPTsxE50WsJEFBzIVclCS4XirByLszuiAkhYdG7W2
         +E4jjJ7JDaeRS+DMPXo0umFNkPFvzDPR6J9fHk/jv8eHVmiLVTkUgQAKwblJNdoMsylr
         tRRpXAEfuco0ODlOiEj4iYtwIrhnQWDJRYzDFlrnz4H18jkwrqyNy9X0qYEbNQYKBfGs
         6kVQ==
X-Gm-Message-State: APjAAAV1FtxCTDCAEJxwxMAKesgb3opKHDghq7UqO/OgVeKNhelRXvRb
        Ul15jjPq+rvOnHVnO9TCPU9nujlkd1zF
X-Google-Smtp-Source: APXvYqztqsR7/hW+HB8I3Jt9HcdxWJb0qnTU6I7OKnX1Lx6wf5OkmafqQcJvDEyb/dWNc+rvsxnTIag5+CGR
X-Received: by 2002:a63:f00a:: with SMTP id k10mr1116669pgh.193.1560839192358;
 Mon, 17 Jun 2019 23:26:32 -0700 (PDT)
Date:   Mon, 17 Jun 2019 23:26:28 -0700
Message-Id: <20190618062628.133783-1-furquan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] i915: intel_dp_aux_backlight: Fix max backlight calculations
From:   Furquan Shaikh <furquan@google.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, rajatja@google.com,
        marcheu@chromium.org, Furquan Shaikh <furquan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max backlight value for the panel was being calculated using byte
count i.e. 0xffff if 2 bytes are supported for backlight brightness
and 0xff if 1 byte is supported. However, EDP_PWMGEN_BIT_COUNT
determines the number of active control bits used for the brightness
setting. Thus, even if the panel uses 2 byte setting, it might not use
all the control bits. Thus, max backlight should be set based on the
value of EDP_PWMGEN_BIT_COUNT instead of assuming 65535 or 255.

Additionally, EDP_PWMGEN_BIT_COUNT was being updated based on the VBT
frequency which results in a different max backlight value. Thus,
setting of EDP_PWMGEN_BIT_COUNT is moved to setup phase instead of
enable so that max backlight can be calculated correctly. Only the
frequency divider is set during the enable phase using the value of
EDP_PWMGEN_BIT_COUNT.

Signed-off-by: Furquan Shaikh <furquan@google.com>
Reviewed-by: St=C3=A9phane Marchesin <marcheu@chromium.org>
---
 drivers/gpu/drm/i915/intel_dp_aux_backlight.c | 132 ++++++++++++------
 1 file changed, 88 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp_aux_backlight.c b/drivers/gpu/dr=
m/i915/intel_dp_aux_backlight.c
index 357136f17f85..4636c8e8ae8a 100644
--- a/drivers/gpu/drm/i915/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/intel_dp_aux_backlight.c
@@ -110,61 +110,34 @@ static bool intel_dp_aux_set_pwm_freq(struct intel_co=
nnector *connector)
 {
 	struct drm_i915_private *dev_priv =3D to_i915(connector->base.dev);
 	struct intel_dp *intel_dp =3D enc_to_intel_dp(&connector->encoder->base);
-	int freq, fxp, fxp_min, fxp_max, fxp_actual, f =3D 1;
-	u8 pn, pn_min, pn_max;
+	int freq, fxp, f, fxp_actual, fxp_min, fxp_max;
+	u8 pn;
=20
-	/* Find desired value of (F x P)
-	 * Note that, if F x P is out of supported range, the maximum value or
-	 * minimum value will applied automatically. So no need to check that.
-	 */
 	freq =3D dev_priv->vbt.backlight.pwm_freq_hz;
-	DRM_DEBUG_KMS("VBT defined backlight frequency %u Hz\n", freq);
 	if (!freq) {
 		DRM_DEBUG_KMS("Use panel default backlight frequency\n");
 		return false;
 	}
=20
-	fxp =3D DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
-
-	/* Use highest possible value of Pn for more granularity of brightness
-	 * adjustment while satifying the conditions below.
-	 * - Pn is in the range of Pn_min and Pn_max
-	 * - F is in the range of 1 and 255
-	 * - FxP is within 25% of desired value.
-	 *   Note: 25% is arbitrary value and may need some tweak.
-	 */
-	if (drm_dp_dpcd_readb(&intel_dp->aux,
-			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min) !=3D 1) {
-		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap min\n");
+	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT,
+			      &pn) < 0) {
+		DRM_DEBUG_KMS("Failed to read aux pwmgen bit count\n");
 		return false;
 	}
-	if (drm_dp_dpcd_readb(&intel_dp->aux,
-			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max) !=3D 1) {
-		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap max\n");
-		return false;
-	}
-	pn_min &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
-	pn_max &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
=20
+	fxp =3D DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
+	f =3D clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
+	fxp_actual =3D f << pn;
+
+	/* Ensure frequency is within 25% of desired value */
 	fxp_min =3D DIV_ROUND_CLOSEST(fxp * 3, 4);
 	fxp_max =3D DIV_ROUND_CLOSEST(fxp * 5, 4);
-	if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
-		DRM_DEBUG_KMS("VBT defined backlight frequency out of range\n");
-		return false;
-	}
=20
-	for (pn =3D pn_max; pn >=3D pn_min; pn--) {
-		f =3D clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
-		fxp_actual =3D f << pn;
-		if (fxp_min <=3D fxp_actual && fxp_actual <=3D fxp_max)
-			break;
-	}
-
-	if (drm_dp_dpcd_writeb(&intel_dp->aux,
-			       DP_EDP_PWMGEN_BIT_COUNT, pn) < 0) {
-		DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
+	if (fxp_min > fxp_actual || fxp_actual > fxp_max) {
+		DRM_DEBUG_KMS("Actual frequency out of range\n");
 		return false;
 	}
+
 	if (drm_dp_dpcd_writeb(&intel_dp->aux,
 			       DP_EDP_BACKLIGHT_FREQ_SET, (u8) f) < 0) {
 		DRM_DEBUG_KMS("Failed to write aux backlight freq\n");
@@ -224,16 +197,87 @@ static void intel_dp_aux_disable_backlight(const stru=
ct drm_connector_state *old
 	set_aux_backlight_enable(enc_to_intel_dp(old_conn_state->best_encoder), f=
alse);
 }
=20
+static u32 intel_dp_aux_calc_max_backlight(struct intel_connector *connect=
or)
+{
+	struct drm_i915_private *dev_priv =3D to_i915(connector->base.dev);
+	struct intel_dp *intel_dp =3D enc_to_intel_dp(&connector->encoder->base);
+	u32 max_backlight =3D 0;
+	int freq, fxp, fxp_min, fxp_max, fxp_actual, f =3D 1;
+	u8 pn, pn_min, pn_max;
+
+	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT, &pn)) {
+		pn &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
+		max_backlight =3D (1 << pn) - 1;
+	}
+
+	/* Find desired value of (F x P)
+	 * Note that, if F x P is out of supported range, the maximum value or
+	 * minimum value will applied automatically. So no need to check that.
+	 */
+	freq =3D dev_priv->vbt.backlight.pwm_freq_hz;
+	DRM_DEBUG_KMS("VBT defined backlight frequency %u Hz\n", freq);
+	if (!freq) {
+		DRM_DEBUG_KMS("Use panel default backlight frequency\n");
+		return max_backlight;
+	}
+
+	fxp =3D DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
+
+	/* Use highest possible value of Pn for more granularity of brightness
+	 * adjustment while satifying the conditions below.
+	 * - Pn is in the range of Pn_min and Pn_max
+	 * - F is in the range of 1 and 255
+	 * - FxP is within 25% of desired value.
+	 *   Note: 25% is arbitrary value and may need some tweak.
+	 */
+	if (drm_dp_dpcd_readb(&intel_dp->aux,
+			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min) !=3D 1) {
+		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap min\n");
+		return max_backlight;
+	}
+	if (drm_dp_dpcd_readb(&intel_dp->aux,
+			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max) !=3D 1) {
+		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap max\n");
+		return max_backlight;
+	}
+	pn_min &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
+	pn_max &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
+
+	fxp_min =3D DIV_ROUND_CLOSEST(fxp * 3, 4);
+	fxp_max =3D DIV_ROUND_CLOSEST(fxp * 5, 4);
+	if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
+		DRM_DEBUG_KMS("VBT defined backlight frequency out of range\n");
+		return max_backlight;
+	}
+
+	for (pn =3D pn_max; pn >=3D pn_min; pn--) {
+		f =3D clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
+		fxp_actual =3D f << pn;
+		if (fxp_min <=3D fxp_actual && fxp_actual <=3D fxp_max)
+			break;
+	}
+
+	if (drm_dp_dpcd_writeb(&intel_dp->aux,
+			       DP_EDP_PWMGEN_BIT_COUNT, pn) < 0) {
+		DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
+		return max_backlight;
+	}
+
+	max_backlight =3D (1 << pn) - 1;
+
+	return max_backlight;
+}
+
 static int intel_dp_aux_setup_backlight(struct intel_connector *connector,
 					enum pipe pipe)
 {
 	struct intel_dp *intel_dp =3D enc_to_intel_dp(&connector->encoder->base);
 	struct intel_panel *panel =3D &connector->panel;
=20
-	if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
-		panel->backlight.max =3D 0xFFFF;
-	else
-		panel->backlight.max =3D 0xFF;
+	panel->backlight.max =3D intel_dp_aux_calc_max_backlight(connector);
+
+	if (!panel->backlight.max)
+		return -ENODEV;
=20
 	panel->backlight.min =3D 0;
 	panel->backlight.level =3D intel_dp_aux_get_backlight(connector);
--=20
2.22.0.410.gd8fdbe21b5-goog

