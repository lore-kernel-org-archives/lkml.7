Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184D9C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE98F20704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAGEpBKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKVXQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:16:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39540 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVXQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574464604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=da6B5wryqdm0pwrGQUg8GuLhSMwcGO0NU0zcKvLukpU=;
        b=gAGEpBKWF50HkReA/gloCJf98AJcDhMHs03rEuY461BNC+aHHRoLwe4zttqcCXtPiI9XVd
        QGIAZEw8H8RWdwsYnPYWrOWo+U5RPyfQphFPXLbupQhs+WlHU+7QveGpH0nA4zWuQy5h+R
        FC++Z92/AdgjK+/DhgsvbuNc24gBX9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-gx-aRPNWOvqCwVNXY1ysdA-1; Fri, 22 Nov 2019 18:16:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C97EB80268F;
        Fri, 22 Nov 2019 23:16:41 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B52F819C4F;
        Fri, 22 Nov 2019 23:16:38 +0000 (UTC)
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
Subject: [PATCH 2/5] drm/i915: Assume 100% brightness when not in DPCD control mode
Date:   Fri, 22 Nov 2019 18:16:00 -0500
Message-Id: <20191122231616.2574-3-lyude@redhat.com>
In-Reply-To: <20191122231616.2574-1-lyude@redhat.com>
References: <20191122231616.2574-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gx-aRPNWOvqCwVNXY1ysdA-1
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

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driver=
s/gpu/drm/i915/display/intel_dp_aux_backlight.c
index fad470553cf9..0bf8772bc7bb 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -59,8 +59,23 @@ static u32 intel_dp_aux_get_backlight(struct intel_conne=
ctor *connector)
 {
 =09struct intel_dp *intel_dp =3D enc_to_intel_dp(&connector->encoder->base=
);
 =09u8 read_val[2] =3D { 0x0 };
+=09u8 control_reg;
 =09u16 level =3D 0;
=20
+=09if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_DISPLAY_CONTROL_REGISTER,
+=09=09=09      &control_reg) !=3D 1) {
+=09=09DRM_DEBUG_KMS("Failed to read the DPCD register 0x%x\n",
+=09=09=09      DP_EDP_DISPLAY_CONTROL_REGISTER);
+=09=09return 0;
+=09}
+
+=09/*
+=09 * If we're not in DPCD control mode yet, the programmed brightness
+=09 * value is meaningless and we should assume max brightness
+=09 */
+=09if (!(control_reg & DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD))
+=09=09return connector->panel.backlight.max;
+
 =09if (drm_dp_dpcd_read(&intel_dp->aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB,
 =09=09=09     &read_val, sizeof(read_val)) < 0) {
 =09=09DRM_DEBUG_KMS("Failed to read DPCD register 0x%x\n",
--=20
2.21.0

