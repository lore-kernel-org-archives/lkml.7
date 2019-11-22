Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3AFC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B932072D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gd0eDiIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfKVXQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:16:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60096 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726895AbfKVXQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574464611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ty3XICBrVCjAb5qRaafGfNUSOlZQn/VM+rmDiTgZPxQ=;
        b=gd0eDiIpU3NLL2AYCPyyogi1cg/LrDSkdlxPdSV28gqNMis354G7hHOuAPwYf5DiNMyU87
        h+5i0mUBzMi4WkAYSgZeA0/U4J7N9I6PNzzATNG/uXcEJz+bxborPtsCwvlmG15uc+M8rc
        Ool1LgwxLOpjWFFRrRdpksw4DUf8Jvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-kNzxvEwmPZqBbyVJqFmDYw-1; Fri, 22 Nov 2019 18:16:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C35F802693;
        Fri, 22 Nov 2019 23:16:48 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6657D19C4F;
        Fri, 22 Nov 2019 23:16:47 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/i915: Auto detect DPCD backlight support by default
Date:   Fri, 22 Nov 2019 18:16:02 -0500
Message-Id: <20191122231616.2574-5-lyude@redhat.com>
In-Reply-To: <20191122231616.2574-1-lyude@redhat.com>
References: <20191122231616.2574-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: kNzxvEwmPZqBbyVJqFmDYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out we actually already have some companies, such as Lenovo,
shipping machines with AMOLED screens that don't allow controlling the
backlight through the usual PWM interface and only allow controlling it
through the standard EDP DPCD interface. One example of one of these
laptops is the X1 Extreme 2nd Generation.

Since we've got systems that need this turned on by default now to have
backlight controls working out of the box, let's start auto-detecting it
for systems by default based on what the VBT tells us. We do this by
changing the default value for the enable_dpcd_backlight module param
from 0 to -1.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/i915_params.c | 2 +-
 drivers/gpu/drm/i915/i915_params.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915=
_params.c
index 1dd1f3652795..31eed60c167e 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -172,7 +172,7 @@ i915_param_named_unsafe(inject_probe_failure, uint, 040=
0,
=20
 i915_param_named(enable_dpcd_backlight, int, 0600,
 =09"Enable support for DPCD backlight control"
-=09"(-1=3Duse per-VBT LFP backlight type setting, 0=3Ddisabled [default], =
1=3Denabled)");
+=09"(-1=3Duse per-VBT LFP backlight type setting [default], 0=3Ddisabled, =
1=3Denabled)");
=20
 #if IS_ENABLED(CONFIG_DRM_I915_GVT)
 i915_param_named(enable_gvt, bool, 0400,
diff --git a/drivers/gpu/drm/i915/i915_params.h b/drivers/gpu/drm/i915/i915=
_params.h
index 31b88f297fbc..a79d0867f77a 100644
--- a/drivers/gpu/drm/i915/i915_params.h
+++ b/drivers/gpu/drm/i915/i915_params.h
@@ -64,7 +64,7 @@ struct drm_printer;
 =09param(int, reset, 3) \
 =09param(unsigned int, inject_probe_failure, 0) \
 =09param(int, fastboot, -1) \
-=09param(int, enable_dpcd_backlight, 0) \
+=09param(int, enable_dpcd_backlight, -1) \
 =09param(char *, force_probe, CONFIG_DRM_I915_FORCE_PROBE) \
 =09param(unsigned long, fake_lmem_start, 0) \
 =09/* leave bools at the end to not create holes */ \
--=20
2.21.0

