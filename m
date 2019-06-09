Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4757BC468BE
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBC5205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100046;
	bh=BJMSq/FdsSC36fLCnjyO+TBYo1jhC7DaxPZHyMSWTL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XAbUuter2UzkT1YZN9da7jGvxzxYXuVca/Rwh7wLTUrQbOJGT9c8sjf8+GgTc1osD
	 Pn/npmBuSM68BCyKYg+2su8oJ+9JDhWZbFfZaU0Fg/K6Xj629JVbImfA4CLKvCNEZD
	 XU8zmdGSdEB5mpiIUgdnVwcTBO4of4fTlv5/afUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbfFIRGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389028AbfFIRG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:06:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B38A204EC;
        Sun,  9 Jun 2019 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099989;
        bh=BJMSq/FdsSC36fLCnjyO+TBYo1jhC7DaxPZHyMSWTL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBqkt9YylV3TVspcduF1Bgci26xJRwCLJa3isV/l1HJRfm21hrGTiheZr41Ez3VAi
         4LipMSafQUD5R0EC35Fd9RoJivQVyl3x1Ob8UUq6KACwPEyejil7nYDl+y8cT9MEy+
         pXnCDJl1F4TGP/m+lupx3VYSEQCA7XJi1LgKH4Cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: [PATCH 4.4 239/241] drm/gma500/cdv: Check vbt config bits when detecting lvds panels
Date:   Sun,  9 Jun 2019 18:43:01 +0200
Message-Id: <20190609164155.692325951@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

commit 7c420636860a719049fae9403e2c87804f53bdde upstream.

Some machines have an lvds child device in vbt even though a panel is
not attached. To make detection more reliable we now also check the lvds
config bits available in the vbt.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1665766
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190416114607.1072-1-patrik.r.jakobsson@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/gma500/cdv_intel_lvds.c |    3 +++
 drivers/gpu/drm/gma500/intel_bios.c     |    3 +++
 drivers/gpu/drm/gma500/psb_drv.h        |    1 +
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
@@ -536,6 +536,7 @@ struct drm_psb_private {
 	int lvds_ssc_freq;
 	bool is_lvds_on;
 	bool is_mipi_on;
+	bool lvds_enabled_in_vbt;
 	u32 mipi_ctrl_display;
 
 	unsigned int core_freq;


