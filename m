Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D96C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A732071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqiJd8gC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKVXQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:16:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42756 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726895AbfKVXQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574464615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7312nuaCf2oM+T3c7efGgGdfgGSQaSpW7hnjMJf3528=;
        b=BqiJd8gCqfa7QzHSjgG9AhNMlpYx3LuJ7HHyl4A1rTqy3jl13WNZzIXmg5d2fm6Tih4IbU
        hnLfuixm1FT0w4JraWZeBZtBgp8FCeE0YLIIUPuU8XD7TjlJVYkf40cImLX7mGxLSXAiVI
        iC3+5FgVcpznoqDkmqR6SwmxLLunXIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-PaXPggKFOBmZIAzBidVXRw-1; Fri, 22 Nov 2019 18:16:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EC31100726A;
        Fri, 22 Nov 2019 23:16:51 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30FEC19C4F;
        Fri, 22 Nov 2019 23:16:50 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/i915: Force DPCD backlight mode on X1 Extreme 2nd Gen 4K AMOLED panel
Date:   Fri, 22 Nov 2019 18:16:03 -0500
Message-Id: <20191122231616.2574-6-lyude@redhat.com>
In-Reply-To: <20191122231616.2574-1-lyude@redhat.com>
References: <20191122231616.2574-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: PaXPggKFOBmZIAzBidVXRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annoyingly, the VBT on the ThinkPad X1 Extreme 2nd Gen indicates that
the system uses plain PWM based backlight controls, when in reality the
only backlight controls that work are the standard VESA eDP DPCD
backlight controls.

Honestly, this makes me wonder how many other systems have these issues
or lie about this in their VBT. Not sure we have any good way of finding
out until panels like this become more common place in the laptop
market. For now, just add a DRM DP quirk to indicate that this panel is
telling the truth and is being a good LCD.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D112376
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_helper.c                       |  4 ++++
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 10 ++++++++--
 include/drm/drm_dp_helper.h                           |  8 ++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helpe=
r.c
index 2c7870aef469..ec7061e3a99b 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1155,6 +1155,10 @@ static const struct dpcd_quirk dpcd_quirk_list[] =3D=
 {
 =09{ OUI(0x00, 0x10, 0xfa), DEVICE_ID_ANY, false, BIT(DP_DPCD_QUIRK_NO_PSR=
) },
 =09/* CH7511 seems to leave SINK_COUNT zeroed */
 =09{ OUI(0x00, 0x00, 0x00), DEVICE_ID('C', 'H', '7', '5', '1', '1'), false=
, BIT(DP_DPCD_QUIRK_NO_SINK_COUNT) },
+=09/* Optional 4K AMOLED panel in the ThinkPad X1 Extreme 2nd Generation
+=09 * only supports DPCD backlight controls, despite advertising otherwise
+=09 */
+=09{ OUI(0xba, 0x41, 0x59), DEVICE_ID_ANY, false, BIT(DP_DPCD_QUIRK_FORCE_=
DPCD_BACKLIGHT) },
 };
=20
 #undef OUI
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driver=
s/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 87b59db9ffe3..3d61260b08ad 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -325,11 +325,17 @@ intel_dp_aux_display_control_capable(struct intel_con=
nector *connector)
 int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_connec=
tor)
 {
 =09struct intel_panel *panel =3D &intel_connector->panel;
-=09struct drm_i915_private *dev_priv =3D to_i915(intel_connector->base.dev=
);
+=09struct intel_dp *intel_dp =3D
+=09=09enc_to_intel_dp(&intel_connector->encoder->base);
+=09struct drm_i915_private *dev_priv =3D
+=09=09to_i915(intel_connector->base.dev);
=20
 =09if (i915_modparams.enable_dpcd_backlight =3D=3D 0 ||
 =09    (i915_modparams.enable_dpcd_backlight =3D=3D -1 &&
-=09    dev_priv->vbt.backlight.type !=3D INTEL_BACKLIGHT_VESA_EDP_AUX_INTE=
RFACE))
+=09     dev_priv->vbt.backlight.type !=3D
+=09=09     INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE &&
+=09     !drm_dp_has_quirk(&intel_dp->desc,
+=09=09=09       DP_DPCD_QUIRK_FORCE_DPCD_BACKLIGHT)))
 =09=09return -ENODEV;
=20
 =09if (!intel_dp_aux_display_control_capable(intel_connector))
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 51ecb5112ef8..a444209cd54b 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1520,6 +1520,14 @@ enum drm_dp_quirk {
 =09 * The driver should ignore SINK_COUNT during detection.
 =09 */
 =09DP_DPCD_QUIRK_NO_SINK_COUNT,
+=09/**
+=09 * @DP_DPCD_QUIRK_FORCE_DPCD_BACKLIGHT:
+=09 *
+=09 * The device is telling the truth when it says that it uses DPCD
+=09 * backlight controls, even if the system's firmware disagrees.
+=09 * The driver should honor the DPCD backlight capabilities advertised.
+=09 */
+=09DP_DPCD_QUIRK_FORCE_DPCD_BACKLIGHT,
 };
=20
 /**
--=20
2.21.0

