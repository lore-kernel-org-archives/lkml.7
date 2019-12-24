Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0252C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 08:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DEB2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 08:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfLXInE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 03:43:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55645 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLXInE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 03:43:04 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ijfmL-0001uj-7b; Tue, 24 Dec 2019 08:42:58 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     ville.syrjala@linux.intel.com, swati2.sharma@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v3] drm/i915: Re-init lspcon after HPD if lspcon probe failed
Date:   Tue, 24 Dec 2019 16:42:51 +0800
Message-Id: <20191224084251.28414-1-kai.heng.feng@canonical.com>
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
v3:
 - Make sure it's handled under long HPD case.

v2: 
 - Move lspcon_init() inside of intel_dp_hpd_pulse().

 drivers/gpu/drm/i915/display/intel_dp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index fe31bbfd6c62..a72c9c041c60 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6573,6 +6573,7 @@ enum irqreturn
 intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
 {
 	struct intel_dp *intel_dp = &intel_dig_port->dp;
+	struct drm_i915_private *dev_priv = dp_to_i915(intel_dp);
 
 	if (long_hpd && intel_dig_port->base.type == INTEL_OUTPUT_EDP) {
 		/*
@@ -6593,7 +6594,12 @@ intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
 		      long_hpd ? "long" : "short");
 
 	if (long_hpd) {
-		intel_dp->reset_link_params = true;
+		if (intel_dig_port->base.type == INTEL_OUTPUT_DDI &&
+		    HAS_LSPCON(dev_priv) && !intel_dig_port->lspcon.active)
+			lspcon_init(intel_dig_port);
+		else
+			intel_dp->reset_link_params = true;
+
 		return IRQ_NONE;
 	}
 
-- 
2.17.1

