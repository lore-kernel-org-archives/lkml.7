Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763C7C4CED1
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEB7207FF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfJBTOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:14:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35232 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728997AbfJBTII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:08:08 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iFjyn-00035I-De; Wed, 02 Oct 2019 20:08:05 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iFjyn-0003aa-2x; Wed, 02 Oct 2019 20:08:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Patrik Jakobsson" <patrik.r.jakobsson@gmail.com>
Date:   Wed, 02 Oct 2019 20:06:51 +0100
Message-ID: <lsq.1570043211.29533281@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 10/87] drm/gma500/cdv: Check vbt config bits when
 detecting lvds panels
In-Reply-To: <lsq.1570043210.379046399@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.75-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

commit 7c420636860a719049fae9403e2c87804f53bdde upstream.

Some machines have an lvds child device in vbt even though a panel is
not attached. To make detection more reliable we now also check the lvds
config bits available in the vbt.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1665766
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190416114607.1072-1-patrik.r.jakobsson@gmail.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/gma500/cdv_intel_lvds.c | 3 +++
 drivers/gpu/drm/gma500/intel_bios.c     | 3 +++
 drivers/gpu/drm/gma500/psb_drv.h        | 1 +
 3 files changed, 7 insertions(+)

--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -620,6 +620,9 @@ void cdv_intel_lvds_init(struct drm_devi
 	int pipe;
 	u8 pin;
 
+	if (!dev_priv->lvds_enabled_in_vbt)
+		return;
+
 	pin = GMBUS_PORT_PANEL;
 	if (!lvds_is_present_in_vbt(dev, &pin)) {
 		DRM_DEBUG_KMS("LVDS is not present in VBT\n");
--- a/drivers/gpu/drm/gma500/intel_bios.c
+++ b/drivers/gpu/drm/gma500/intel_bios.c
@@ -436,6 +436,9 @@ parse_driver_features(struct drm_psb_pri
 	if (driver->lvds_config == BDB_DRIVER_FEATURE_EDP)
 		dev_priv->edp.support = 1;
 
+	dev_priv->lvds_enabled_in_vbt = driver->lvds_config != 0;
+	DRM_DEBUG_KMS("LVDS VBT config bits: 0x%x\n", driver->lvds_config);
+
 	/* This bit means to use 96Mhz for DPLL_A or not */
 	if (driver->primary_lfp_id)
 		dev_priv->dplla_96mhz = true;
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -533,6 +533,7 @@ struct drm_psb_private {
 	int lvds_ssc_freq;
 	bool is_lvds_on;
 	bool is_mipi_on;
+	bool lvds_enabled_in_vbt;
 	u32 mipi_ctrl_display;
 
 	unsigned int core_freq;

