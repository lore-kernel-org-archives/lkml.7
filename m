Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D799C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2216F20704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6QFmdYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKVXQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:16:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51090 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726089AbfKVXQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574464600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y7+pPq2W8n/QnP/QN4TfV1Jv02YEm+xZX8RYtdz5s+Y=;
        b=L6QFmdYZBOKh7BXk0y5tbcjy1gtCuuBd/s0tei/Xrs8vInRhesKTA13Jsu1bClgdVvlhft
        I6S8kDqP947pnuBr4Qium6dipI4Zrttm9iQSrT52CFFSB8Rgw6Wb8rOc0rCSnidPLqvaG+
        h1Ob6oCetrVesbzUyyGCkDq34Z5fnNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-hXZSNByxP1C4M6HXbAiXLA-1; Fri, 22 Nov 2019 18:16:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2948DB60;
        Fri, 22 Nov 2019 23:16:36 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 651C519C4F;
        Fri, 22 Nov 2019 23:16:35 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Furquan Shaikh <furquan@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/i915: Fix eDP DPCD aux max backlight calculations
Date:   Fri, 22 Nov 2019 18:15:59 -0500
Message-Id: <20191122231616.2574-2-lyude@redhat.com>
In-Reply-To: <20191122231616.2574-1-lyude@redhat.com>
References: <20191122231616.2574-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: hXZSNByxP1C4M6HXbAiXLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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

This is based off the original patch series from Furquan Shaikh
<furquan@google.com>:

https://patchwork.freedesktop.org/patch/317255/?series=3D62326&rev=3D3

Changes since original patch:
* Remove unused intel_dp variable in intel_dp_aux_setup_backlight()
* Fix checkpatch issues
* Make sure that we rewrite the pwmgen bit count whenever we bring the
  panel out of D3 mode

Cc: Furquan Shaikh <furquan@google.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../drm/i915/display/intel_display_types.h    |   3 +
 .../drm/i915/display/intel_dp_aux_backlight.c | 139 ++++++++++++------
 2 files changed, 95 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/g=
pu/drm/i915/display/intel_display_types.h
index 83ea04149b77..2a8d8cae638e 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -214,6 +214,9 @@ struct intel_panel {
 =09=09u8 controller;=09=09/* bxt+ only */
 =09=09struct pwm_device *pwm;
=20
+=09=09/* DPCD backlight */
+=09=09u8 pwmgen_bit_count;
+
 =09=09struct backlight_device *device;
=20
 =09=09/* Connector and platform specific backlight functions */
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driver=
s/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 020422da2ae2..fad470553cf9 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -111,61 +111,28 @@ static bool intel_dp_aux_set_pwm_freq(struct intel_co=
nnector *connector)
 {
 =09struct drm_i915_private *dev_priv =3D to_i915(connector->base.dev);
 =09struct intel_dp *intel_dp =3D enc_to_intel_dp(&connector->encoder->base=
);
-=09int freq, fxp, fxp_min, fxp_max, fxp_actual, f =3D 1;
-=09u8 pn, pn_min, pn_max;
+=09const u8 pn =3D connector->panel.backlight.pwmgen_bit_count;
+=09int freq, fxp, f, fxp_actual, fxp_min, fxp_max;
=20
-=09/* Find desired value of (F x P)
-=09 * Note that, if F x P is out of supported range, the maximum value or
-=09 * minimum value will applied automatically. So no need to check that.
-=09 */
 =09freq =3D dev_priv->vbt.backlight.pwm_freq_hz;
-=09DRM_DEBUG_KMS("VBT defined backlight frequency %u Hz\n", freq);
 =09if (!freq) {
 =09=09DRM_DEBUG_KMS("Use panel default backlight frequency\n");
 =09=09return false;
 =09}
=20
 =09fxp =3D DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
+=09f =3D clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
+=09fxp_actual =3D f << pn;
=20
-=09/* Use highest possible value of Pn for more granularity of brightness
-=09 * adjustment while satifying the conditions below.
-=09 * - Pn is in the range of Pn_min and Pn_max
-=09 * - F is in the range of 1 and 255
-=09 * - FxP is within 25% of desired value.
-=09 *   Note: 25% is arbitrary value and may need some tweak.
-=09 */
-=09if (drm_dp_dpcd_readb(&intel_dp->aux,
-=09=09=09       DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min) !=3D 1) {
-=09=09DRM_DEBUG_KMS("Failed to read pwmgen bit count cap min\n");
-=09=09return false;
-=09}
-=09if (drm_dp_dpcd_readb(&intel_dp->aux,
-=09=09=09       DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max) !=3D 1) {
-=09=09DRM_DEBUG_KMS("Failed to read pwmgen bit count cap max\n");
-=09=09return false;
-=09}
-=09pn_min &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
-=09pn_max &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
-
+=09/* Ensure frequency is within 25% of desired value */
 =09fxp_min =3D DIV_ROUND_CLOSEST(fxp * 3, 4);
 =09fxp_max =3D DIV_ROUND_CLOSEST(fxp * 5, 4);
-=09if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
-=09=09DRM_DEBUG_KMS("VBT defined backlight frequency out of range\n");
-=09=09return false;
-=09}
-
-=09for (pn =3D pn_max; pn >=3D pn_min; pn--) {
-=09=09f =3D clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
-=09=09fxp_actual =3D f << pn;
-=09=09if (fxp_min <=3D fxp_actual && fxp_actual <=3D fxp_max)
-=09=09=09break;
-=09}
=20
-=09if (drm_dp_dpcd_writeb(&intel_dp->aux,
-=09=09=09       DP_EDP_PWMGEN_BIT_COUNT, pn) < 0) {
-=09=09DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
+=09if (fxp_min > fxp_actual || fxp_actual > fxp_max) {
+=09=09DRM_DEBUG_KMS("Actual frequency out of range\n");
 =09=09return false;
 =09}
+
 =09if (drm_dp_dpcd_writeb(&intel_dp->aux,
 =09=09=09       DP_EDP_BACKLIGHT_FREQ_SET, (u8) f) < 0) {
 =09=09DRM_DEBUG_KMS("Failed to write aux backlight freq\n");
@@ -178,6 +145,7 @@ static void intel_dp_aux_enable_backlight(const struct =
intel_crtc_state *crtc_st
 =09=09=09=09=09  const struct drm_connector_state *conn_state)
 {
 =09struct intel_connector *connector =3D to_intel_connector(conn_state->co=
nnector);
+=09struct intel_panel *panel =3D &connector->panel;
 =09struct intel_dp *intel_dp =3D enc_to_intel_dp(&connector->encoder->base=
);
 =09u8 dpcd_buf, new_dpcd_buf, edp_backlight_mode;
=20
@@ -197,6 +165,12 @@ static void intel_dp_aux_enable_backlight(const struct=
 intel_crtc_state *crtc_st
 =09case DP_EDP_BACKLIGHT_CONTROL_MODE_PRODUCT:
 =09=09new_dpcd_buf &=3D ~DP_EDP_BACKLIGHT_CONTROL_MODE_MASK;
 =09=09new_dpcd_buf |=3D DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD;
+
+=09=09if (drm_dp_dpcd_writeb(&intel_dp->aux,
+=09=09=09=09       DP_EDP_PWMGEN_BIT_COUNT,
+=09=09=09=09       panel->backlight.pwmgen_bit_count) < 0)
+=09=09=09DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
+
 =09=09break;
=20
 =09/* Do nothing when it is already DPCD mode */
@@ -225,20 +199,91 @@ static void intel_dp_aux_disable_backlight(const stru=
ct drm_connector_state *old
 =09set_aux_backlight_enable(enc_to_intel_dp(old_conn_state->best_encoder),=
 false);
 }
=20
+static u32 intel_dp_aux_calc_max_backlight(struct intel_connector *connect=
or)
+{
+=09struct drm_i915_private *dev_priv =3D to_i915(connector->base.dev);
+=09struct intel_dp *intel_dp =3D enc_to_intel_dp(&connector->encoder->base=
);
+=09struct intel_panel *panel =3D &connector->panel;
+=09u32 max_backlight =3D 0;
+=09int freq, fxp, fxp_min, fxp_max, fxp_actual, f =3D 1;
+=09u8 pn, pn_min, pn_max;
+
+=09if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT, &pn)) {
+=09=09pn &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
+=09=09max_backlight =3D (1 << pn) - 1;
+=09}
+
+=09/* Find desired value of (F x P)
+=09 * Note that, if F x P is out of supported range, the maximum value or
+=09 * minimum value will applied automatically. So no need to check that.
+=09 */
+=09freq =3D dev_priv->vbt.backlight.pwm_freq_hz;
+=09DRM_DEBUG_KMS("VBT defined backlight frequency %u Hz\n", freq);
+=09if (!freq) {
+=09=09DRM_DEBUG_KMS("Use panel default backlight frequency\n");
+=09=09return max_backlight;
+=09}
+
+=09fxp =3D DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
+
+=09/* Use highest possible value of Pn for more granularity of brightness
+=09 * adjustment while satifying the conditions below.
+=09 * - Pn is in the range of Pn_min and Pn_max
+=09 * - F is in the range of 1 and 255
+=09 * - FxP is within 25% of desired value.
+=09 *   Note: 25% is arbitrary value and may need some tweak.
+=09 */
+=09if (drm_dp_dpcd_readb(&intel_dp->aux,
+=09=09=09      DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min) !=3D 1) {
+=09=09DRM_DEBUG_KMS("Failed to read pwmgen bit count cap min\n");
+=09=09return max_backlight;
+=09}
+=09if (drm_dp_dpcd_readb(&intel_dp->aux,
+=09=09=09      DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max) !=3D 1) {
+=09=09DRM_DEBUG_KMS("Failed to read pwmgen bit count cap max\n");
+=09=09return max_backlight;
+=09}
+=09pn_min &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
+=09pn_max &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
+
+=09fxp_min =3D DIV_ROUND_CLOSEST(fxp * 3, 4);
+=09fxp_max =3D DIV_ROUND_CLOSEST(fxp * 5, 4);
+=09if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
+=09=09DRM_DEBUG_KMS("VBT defined backlight frequency out of range\n");
+=09=09return max_backlight;
+=09}
+
+=09for (pn =3D pn_max; pn >=3D pn_min; pn--) {
+=09=09f =3D clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
+=09=09fxp_actual =3D f << pn;
+=09=09if (fxp_min <=3D fxp_actual && fxp_actual <=3D fxp_max)
+=09=09=09break;
+=09}
+
+=09DRM_DEBUG_KMS("Using eDP pwmgen bit count of %d\n", pn);
+=09if (drm_dp_dpcd_writeb(&intel_dp->aux,
+=09=09=09       DP_EDP_PWMGEN_BIT_COUNT, pn) < 0) {
+=09=09DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
+=09=09return max_backlight;
+=09}
+=09panel->backlight.pwmgen_bit_count =3D pn;
+
+=09max_backlight =3D (1 << pn) - 1;
+
+=09return max_backlight;
+}
+
 static int intel_dp_aux_setup_backlight(struct intel_connector *connector,
 =09=09=09=09=09enum pipe pipe)
 {
-=09struct intel_dp *intel_dp =3D enc_to_intel_dp(&connector->encoder->base=
);
 =09struct intel_panel *panel =3D &connector->panel;
=20
-=09if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
-=09=09panel->backlight.max =3D 0xFFFF;
-=09else
-=09=09panel->backlight.max =3D 0xFF;
+=09panel->backlight.max =3D intel_dp_aux_calc_max_backlight(connector);
+=09if (!panel->backlight.max)
+=09=09return -ENODEV;
=20
 =09panel->backlight.min =3D 0;
 =09panel->backlight.level =3D intel_dp_aux_get_backlight(connector);
-
 =09panel->backlight.enabled =3D panel->backlight.level !=3D 0;
=20
 =09return 0;
--=20
2.21.0

