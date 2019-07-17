Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982A2C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 05:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6558C208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 05:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xfzpfw/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfGQFJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 01:09:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39358 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQFJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:09:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6H59Glh028098;
        Wed, 17 Jul 2019 00:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563340156;
        bh=MXMho54RIQOfVsh8C9psx0LpQ4N7ZoANlBBQTCObflw=;
        h=From:To:CC:Subject:Date;
        b=Xfzpfw/X5LzRUAiFZ2SKz85KroyH6qJqRsSUoTIricRMSrr00/xLLrjGsIJCJ8Sdv
         WdK+8E1bIMkrWOBi1m6bFu7z3nWGpxYll6OoJCsSbETzSUlvglCl2CZh5TGavRMsdH
         7y6LaQl9WepkRBPbEXSiznMWBo0d6aXY22jjV3Ts=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6H59GEG068346
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Jul 2019 00:09:16 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 17
 Jul 2019 00:09:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 17 Jul 2019 00:09:16 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6H59Dtw081819;
        Wed, 17 Jul 2019 00:09:14 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>
CC:     <j-keerthy@ti.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] gpu: drm/tilcdc: Fix switch case fallthrough
Date:   Wed, 17 Jul 2019 10:39:46 +0530
Message-ID: <20190717050946.18488-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the below build warning/Error

drivers/gpu/drm/tilcdc/tilcdc_crtc.c: In function ‘tilcdc_crtc_set_mode’:
drivers/gpu/drm/tilcdc/tilcdc_crtc.c:384:8: error: this statement may fall
through [-Werror=implicit-fallthrough=]
    reg |= LCDC_V2_TFT_24BPP_UNPACK;
    ~~~~^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tilcdc/tilcdc_crtc.c:386:3: note: here
   case DRM_FORMAT_BGR888:
   ^~~~
cc1: all warnings being treated as errors
make[5]: *** [drivers/gpu/drm/tilcdc/tilcdc_crtc.o] Error 1
make[4]: *** [drivers/gpu/drm/tilcdc] Error 2
make[4]: *** Waiting for unfinished jobs....

Fixes: f6382f186d2982750 ("drm/tilcdc: Add tilcdc_crtc_mode_set_nofb()")
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 650d162e374b..c95b0652c6ab 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -382,7 +382,8 @@ static void tilcdc_crtc_set_mode(struct drm_crtc *crtc)
 		case DRM_FORMAT_XBGR8888:
 		case DRM_FORMAT_XRGB8888:
 			reg |= LCDC_V2_TFT_24BPP_UNPACK;
-			/* fallthrough */
+			reg |= LCDC_V2_TFT_24BPP_MODE;
+			break;
 		case DRM_FORMAT_BGR888:
 		case DRM_FORMAT_RGB888:
 			reg |= LCDC_V2_TFT_24BPP_MODE;
-- 
2.17.1

