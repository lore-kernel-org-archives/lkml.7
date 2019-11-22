Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EFCC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DD520704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoFYNfpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKVXQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:16:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49821 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbfKVXQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574464610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PpG336iXGmBIaokNTk61GcAbpsZ3/UFehOeJXzLEeZc=;
        b=EoFYNfpmOzgntzougSG2HczW06PsbdErrYwyvz62/WFBr8gSPEQ+SAKiwdUNpW/R3BSy47
        4q99iEXCPEv0eZ0v+xz+weCDtq59+xgl3FweG6A+phT/B4l/czuXn3M71vBCN5+v7WBule
        YVleAkwAKhSlbdaYb9IfNWzeOgtIEpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-BFQ1WrXwPQ-4qQnXUx7qFA-1; Fri, 22 Nov 2019 18:16:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16297DB60;
        Fri, 22 Nov 2019 23:16:47 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99C7319C4F;
        Fri, 22 Nov 2019 23:16:43 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/i915: Fix DPCD register order in intel_dp_aux_enable_backlight()
Date:   Fri, 22 Nov 2019 18:16:01 -0500
Message-Id: <20191122231616.2574-4-lyude@redhat.com>
In-Reply-To: <20191122231616.2574-1-lyude@redhat.com>
References: <20191122231616.2574-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: BFQ1WrXwPQ-4qQnXUx7qFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For eDP panels, it appears it's expected that so long as the panel is in
DPCD control mode that the brightness value is never set to 0. Instead,
if the desired effect is to set the panel's backlight to 0 we're
expected to simply turn off the backlight through the
DP_EDP_DISPLAY_CONTROL_REGISTER.

We already do the latter correctly in intel_dp_aux_disable_backlight().
But, we make the mistake of writing the DPCD registers in the wrong
order when enabling the backlight in intel_dp_aux_enable_backlight()
since we currently enable the backlight through
DP_EDP_DISPLAY_CONTROL_REGISTER before writing the brightness level. On
the X1 Extreme 2nd Generation, this appears to have the potential of
confusing the panel in such a way that further attempts to set the
brightness don't actually change the backlight as expected and leave it
off. Presumably, this happens because the incorrect register writing
order briefly leaves the panel with DPCD mode enabled and a 0 brightness
level set.

So, reverse the order we write the DPCD registers when enabling the
panel backlight so that we write the brightness value first, and enable
the backlight second. This fix appears to be the final bit needed to get
the backlight on the ThinkPad X1 Extreme 2nd Generation's AMOLED screen
working.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driver=
s/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 0bf8772bc7bb..87b59db9ffe3 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -205,8 +205,9 @@ static void intel_dp_aux_enable_backlight(const struct =
intel_crtc_state *crtc_st
 =09=09}
 =09}
=20
+=09intel_dp_aux_set_backlight(conn_state,
+=09=09=09=09   connector->panel.backlight.level);
 =09set_aux_backlight_enable(intel_dp, true);
-=09intel_dp_aux_set_backlight(conn_state, connector->panel.backlight.level=
);
 }
=20
 static void intel_dp_aux_disable_backlight(const struct drm_connector_stat=
e *old_conn_state)
--=20
2.21.0

