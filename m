Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B87C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF6720854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393608AbfIFNxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:53:48 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34973 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393545AbfIFNxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:53:45 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C06E5FF819;
        Fri,  6 Sep 2019 13:53:41 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org,
        horms@verge.net.au, uli+renesas@fpond.eu,
        VenkataRajesh.Kalakodima@in.bosch.com
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, airlied@linux.ie,
        daniel@ffwll.ch, koji.matsuoka.xm@renesas.com, muroya@ksk.co.jp,
        Harsha.ManjulaMallikarjun@in.bosch.com,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] drm: rcar-du: crtc: Register GAMMA_LUT properties
Date:   Fri,  6 Sep 2019 15:54:34 +0200
Message-Id: <20190906135436.10622-8-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906135436.10622-1-jacopo+renesas@jmondi.org>
References: <20190906135436.10622-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the GAMMA_LUT KMS property using the framework helpers to
register the property and set the associated gamma table maximum size.

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 3dac605c3a67..dc59eeec990c 100644
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
+		drm_mode_crtc_set_gamma_size(crtc, CM2_LUT_SIZE);
+		drm_crtc_enable_color_mgmt(crtc, 0, false, CM2_LUT_SIZE);
 	}
 
 	drm_crtc_helper_add(crtc, &crtc_helper_funcs);
-- 
2.23.0

