Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A322BC2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8620E20715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLWRNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:13:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37007 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLWRNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:13:22 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ijRGc-0005S4-W4; Mon, 23 Dec 2019 17:13:15 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     ville.syrjala@linux.intel.com, swati2.sharma@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] drm/i915: Re-init lspcon after HPD if lspcon probe failed
Date:   Tue, 24 Dec 2019 01:13:10 +0800
Message-Id: <20191223171310.21192-1-kai.heng.feng@canonical.com>
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

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2: 
  - Move lspcon_init() inside of intel_dp_hpd_pulse().

 drivers/gpu/drm/i915/display/intel_dp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index fe31bbfd6c62..eb395b45527e 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6573,6 +6573,7 @@ enum irqreturn
 intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
 {
 	struct intel_dp *intel_dp = &intel_dig_port->dp;
+	struct drm_i915_private *dev_priv = dp_to_i915(intel_dp);
 
 	if (long_hpd && intel_dig_port->base.type == INTEL_OUTPUT_EDP) {
 		/*
@@ -6592,11 +6593,14 @@ intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
 		      intel_dig_port->base.base.name,
 		      long_hpd ? "long" : "short");
 
-	if (long_hpd) {
+	if (long_hpd && intel_dig_port->base.type != INTEL_OUTPUT_DDI) {
 		intel_dp->reset_link_params = true;
 		return IRQ_NONE;
 	}
 
+	if (long_hpd && HAS_LSPCON(dev_priv) && !intel_dig_port->lspcon.active)
+		lspcon_init(intel_dig_port);
+
 	if (intel_dp->is_mst) {
 		if (intel_dp_check_mst_status(intel_dp) == -EINVAL) {
 			/*
-- 
2.17.1

