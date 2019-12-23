Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BC1C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB89A208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfLWJ4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 04:56:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57146 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfLWJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 04:56:19 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ijKRd-0000gm-2L; Mon, 23 Dec 2019 09:56:09 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     ville.syrjala@linux.intel.com, swati2.sharma@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] drm/i915: Re-init lspcon after HPD if lspcon probe failed
Date:   Mon, 23 Dec 2019 17:56:04 +0800
Message-Id: <20191223095604.17453-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On HP 800 G4 DM, if HDMI cable isn't plugged before boot, the HDMI port
becomes useless and never responds to cable hotplugging:
[    3.031904] [drm:lspcon_init [i915]] *ERROR* Failed to probe lspcon
[    3.031945] [drm:intel_ddi_init [i915]] *ERROR* LSPCON init failed on port D

Seems like the lspcon chip on the system in question only gets powered
after the cable is plugged.

So let's call lspcon_init() dynamically to properly initialize the
lspcon chip and make HDMI port work.

Closes: https://gitlab.freedesktop.org/drm/intel/issues/203
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_hotplug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
index fc29046d48ea..e2862e36d0bf 100644
--- a/drivers/gpu/drm/i915/display/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
@@ -28,6 +28,7 @@
 #include "i915_drv.h"
 #include "intel_display_types.h"
 #include "intel_hotplug.h"
+#include "intel_lspcon.h"
 
 /**
  * DOC: Hotplug
@@ -336,6 +337,8 @@ static void i915_digport_work_func(struct work_struct *work)
 			continue;
 
 		dig_port = enc_to_dig_port(&encoder->base);
+		if (HAS_LSPCON(dev_priv) && !dig_port->lspcon.active)
+			lspcon_init(dig_port);
 
 		ret = dig_port->hpd_pulse(dig_port, long_hpd);
 		if (ret == IRQ_NONE) {
-- 
2.17.1

