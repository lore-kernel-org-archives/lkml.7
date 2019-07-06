Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB60EC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 14:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F9420863
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 14:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfGFOH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 10:07:29 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50807 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfGFOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 10:07:26 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 86858C0009;
        Sat,  6 Jul 2019 14:07:23 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        koji.matsuoka.xm@renesas.com, muroya@ksk.co.jp,
        VenkataRajesh.Kalakodima@in.bosch.com,
        Harsha.ManjulaMallikarjun@in.bosch.com,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/19] drm: rcar-du: crtc: Register GAMMA_LUT properties
Date:   Sat,  6 Jul 2019 16:07:45 +0200
Message-Id: <20190706140746.29132-19-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190706140746.29132-1-jacopo+renesas@jmondi.org>
References: <20190706140746.29132-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the GAMMA_LUT KMS property using the framework helpers to
register the proeprty and the associated gamma table size maximum size.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 3dac605c3a67..222ccc20d6d8 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -1082,6 +1082,7 @@ static const struct drm_crtc_funcs crtc_funcs_gen3 = {
 	.set_crc_source = rcar_du_crtc_set_crc_source,
 	.verify_crc_source = rcar_du_crtc_verify_crc_source,
 	.get_crc_sources = rcar_du_crtc_get_crc_sources,
+	.gamma_set = drm_atomic_helper_legacy_gamma_set,
 };
 
 /* -----------------------------------------------------------------------------
@@ -1205,6 +1206,9 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int swindex,
 	if (rcdu->cmms[swindex]) {
 		rcrtc->cmm = rcdu->cmms[swindex];
 		rgrp->cmms_mask |= BIT(hwindex % 2);
+
+		drm_mode_crtc_set_gamma_size(crtc, CMM_GAMMA_LUT_SIZE);
+		drm_crtc_enable_color_mgmt(crtc, 0, false, CMM_GAMMA_LUT_SIZE);
 	}
 
 	drm_crtc_helper_add(crtc, &crtc_helper_funcs);
-- 
2.21.0

