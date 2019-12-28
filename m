Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E41C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 01:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A20420882
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 01:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfL1BCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 20:02:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49094 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbfL1BCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 20:02:40 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A5A5C5BDA18D09E142B;
        Sat, 28 Dec 2019 09:02:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Sat, 28 Dec 2019 09:02:20 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] drm/hisilicon: Checked the resolution is valid before connector
Date:   Sat, 28 Dec 2019 09:02:31 +0800
Message-ID: <1577494951-28435-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous version, the callback function mode_valid of
drm_connector_helper_funcs directly returned MODE_OK. Now we will
ensure that the resolution is correct and return MODE_OK, otherwise
return MODE_NOMODE.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Gong junjie <gongjunjie2@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 41 ++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index 6d98fdc..3d08210 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -11,22 +11,59 @@
  *	Jianhua Li <lijianhua@huawei.com>
  */
 
+#include <drm/drm_gem_vram_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_print.h>
 
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
 
+static const struct hibmc_resolution {
+	int w;
+	int h;
+} hibmc_modetables[] = {
+	{640, 480}, {800, 600}, {1024, 768}, {1152, 864}, {1280, 768},
+	{1280, 720}, {1280, 960}, {1280, 1024}, {1440, 900}, {1600, 900},
+	{1600, 1200}, {1920, 1080}, {1920, 1200}
+};
+
+static int hibmc_valid_mode(int w, int h)
+{
+	int size = sizeof(hibmc_modetables) / sizeof(struct hibmc_resolution);
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (hibmc_modetables[i].w == w && hibmc_modetables[i].h == h)
+			return 0;
+	}
+
+	return -1;
+}
+
 static int hibmc_connector_get_modes(struct drm_connector *connector)
 {
-	return drm_add_modes_noedid(connector, 800, 600);
+	int count;
+
+	drm_connector_update_edid_property(connector, NULL);
+	count = drm_add_modes_noedid(connector, 1920, 1200);
+	drm_set_preferred_mode(connector, 1024, 768);
+
+	return count;
 }
 
 static enum drm_mode_status hibmc_connector_mode_valid(struct drm_connector *connector,
 				      struct drm_display_mode *mode)
 {
-	return MODE_OK;
+	int vrefresh = drm_mode_vrefresh(mode);
+
+	if (vrefresh < 59 || vrefresh > 61)
+		return MODE_NOMODE;
+	else if (hibmc_valid_mode(mode->hdisplay, mode->vdisplay) != 0)
+		return MODE_NOMODE;
+	else
+		return MODE_OK;
 }
 
 static const struct drm_connector_helper_funcs
-- 
2.7.4

