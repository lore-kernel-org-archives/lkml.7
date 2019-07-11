Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7D2C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9C420872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TmWHzKr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfGKNwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 09:52:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48358 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfGKNwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:52:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6BDqM4a075829;
        Thu, 11 Jul 2019 08:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562853142;
        bh=ymiH0R8rGaXDGNyGzJJpstHEYruHajGcyfFDcx1Wm6g=;
        h=From:To:CC:Subject:Date;
        b=TmWHzKr3gYv/E+qbSn51IClf3DxICIMrHAlKMNjzBf+TT33876fhvOH7Fg96lEZwp
         g9TWJtzKJTtQSj5VB7mWw7LVAuHsriTmHyIaNZCB8wm2e1h3+ACnnkWTefuNjo/xpy
         NfpPBr0MOw4H4qC7bc0fPIpJI3WXxO6cPCeqEGII=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6BDqM3F106776
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jul 2019 08:52:22 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Jul 2019 08:52:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Jul 2019 08:52:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6BDqLfw019590;
        Thu, 11 Jul 2019 08:52:21 -0500
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
To:     <tomi.valkeinen@ti.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH] drm/omap: Add 'alpha' and 'pixel blend mode' plane properties
Date:   Thu, 11 Jul 2019 15:52:19 +0200
Message-ID: <20190711135219.23402-1-jjhiblot@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following properties for planes:
* alpha
* pixel blend mode. Only "Pre-multiplied" and "Coverage" are supported

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_plane.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
index 84e1be981cfe..73ec99819a3d 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.c
+++ b/drivers/gpu/drm/omapdrm/omap_plane.c
@@ -53,8 +53,12 @@ static void omap_plane_atomic_update(struct drm_plane *plane,
 	memset(&info, 0, sizeof(info));
 	info.rotation_type = OMAP_DSS_ROT_NONE;
 	info.rotation = DRM_MODE_ROTATE_0;
-	info.global_alpha = 0xff;
+	info.global_alpha = state->alpha >> 8;
 	info.zorder = state->normalized_zpos;
+	if (state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI)
+		info.pre_mult_alpha = 1;
+	else
+		info.pre_mult_alpha = 0;
 
 	/* update scanout: */
 	omap_framebuffer_update_scanout(state->fb, state, &info);
@@ -285,6 +289,9 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 
 	omap_plane_install_properties(plane, &plane->base);
 	drm_plane_create_zpos_property(plane, 0, 0, num_planes - 1);
+	drm_plane_create_alpha_property(plane);
+	drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PREMULTI) |
+					     BIT(DRM_MODE_BLEND_COVERAGE));
 
 	return plane;
 
-- 
2.17.1

