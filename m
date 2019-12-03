Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BDDC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEDD20803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+aA1rBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfLCWnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:43:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43421 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728707AbfLCWmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575412970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+sDgbMqjO9PDnPDuImNP6HXuoqamT1anUKE/7ClETRA=;
        b=X+aA1rBTY+q2Jy+07ak2Fz1rKtZA7h/F/ulyQxVdO2wXNEoS/gv2WFTau2n2tlu0s4dOuK
        6GUzweMwmDHRC62i64oM9BQncJzVe55dlqE+bTJwZE1IJm+WFNCJGJ2mAwtpVZO80sG8o6
        N4QumWRd+pcvxp+jcCIukrDOOwjnGbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-4k8qimMGOBeQPasm2opFyw-1; Tue, 03 Dec 2019 17:42:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 411EA800D54;
        Tue,  3 Dec 2019 22:42:47 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6637F5DA32;
        Tue,  3 Dec 2019 22:42:43 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915: Assume 100% brightness when not in DPCD control mode
Date:   Tue,  3 Dec 2019 17:42:35 -0500
Message-Id: <20191203224236.230930-1-lyude@redhat.com>
In-Reply-To: <87tv6hinv1.fsf@intel.com>
References: <87tv6hinv1.fsf@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 4k8qimMGOBeQPasm2opFyw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we always determine the initial panel brightness level by
simply reading the value from DP_EDP_BACKLIGHT_BRIGHTNESS_MSB/LSB. This
seems wrong though, because if the panel is not currently in DPCD
control mode there's not really any reason why there would be any
brightness value programmed in the first place.

This appears to be the case on the Lenovo ThinkPad X1 Extreme 2nd
Generation, where the default value in these registers is always 0 on
boot despite the fact the panel runs at max brightness by default.
Getting the initial brightness value correct here is important as well,
since the panel on this laptop doesn't behave well if it's ever put into
DPCD control mode while the brightness level is programmed to 0.

So, let's fix this by checking what the current backlight control mode
is before reading the brightness level. If it's in DPCD control mode, we
return the programmed brightness level. Otherwise we assume 100%
brightness and return the highest possible brightness level. This also
prevents us from accidentally programming a brightness level of 0.

This is one of the many fixes that gets backlight controls working on
the ThinkPad X1 Extreme 2nd Generation with optional 4K AMOLED screen.

Changes since v1:
* s/DP_EDP_DISPLAY_CONTROL_REGISTER/DP_EDP_BACKLIGHT_MODE_SET_REGISTER/
  - Jani

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../drm/i915/display/intel_dp_aux_backlight.c   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driver=
s/gpu/drm/i915/display/intel_dp_aux_backlight.c
index fad470553cf9..4d467e7d29eb 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -59,8 +59,25 @@ static u32 intel_dp_aux_get_backlight(struct intel_conne=
ctor *connector)
 {
 =09struct intel_dp *intel_dp =3D enc_to_intel_dp(&connector->encoder->base=
);
 =09u8 read_val[2] =3D { 0x0 };
+=09u8 mode_reg;
 =09u16 level =3D 0;
=20
+=09if (drm_dp_dpcd_readb(&intel_dp->aux,
+=09=09=09      DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
+=09=09=09      &mode_reg) !=3D 1) {
+=09=09DRM_DEBUG_KMS("Failed to read the DPCD register 0x%x\n",
+=09=09=09      DP_EDP_BACKLIGHT_MODE_SET_REGISTER);
+=09=09return 0;
+=09}
+
+=09/*
+=09 * If we're not in DPCD control mode yet, the programmed brightness
+=09 * value is meaningless and we should assume max brightness
+=09 */
+=09if ((mode_reg & DP_EDP_BACKLIGHT_CONTROL_MODE_MASK) !=3D
+=09    DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD)
+=09=09return connector->panel.backlight.max;
+
 =09if (drm_dp_dpcd_read(&intel_dp->aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB,
 =09=09=09     &read_val, sizeof(read_val)) < 0) {
 =09=09DRM_DEBUG_KMS("Failed to read DPCD register 0x%x\n",
--=20
2.23.0

