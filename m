Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE86DC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0200205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgAHITG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:19:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51934 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbgAHITG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:19:06 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 28DD080D2392C2F66047;
        Wed,  8 Jan 2020 16:19:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 8 Jan 2020 16:18:55 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] drm/hisilicon: add the mode_valid function
Date:   Wed, 8 Jan 2020 16:19:00 +0800
Message-ID: <1578471540-43322-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add mode_valid function, and we can also use it to make suse the resolution
is valid.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Gong junjie <gongjunjie2@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 843d784..6cb7a79 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -242,6 +242,25 @@ static void hibmc_crtc_atomic_disable(struct drm_crtc *crtc,
 	hibmc_set_current_gate(priv, reg);
 }
 
+enum drm_mode_status hibmc_crtc_mode_valid(struct drm_crtc *crtc,
+					const struct drm_display_mode *mode)
+{
+	int i = 0;
+	int vrefresh = drm_mode_vrefresh(mode);
+
+	if (vrefresh < 59 || vrefresh > 61)
+		return MODE_NOMODE;
+
+	for (i = 0; i < ARRAY_SIZE(hibmc_pll_table); i++) {
+		if (hibmc_pll_table[i].hdisplay == mode->hdisplay &&
+			hibmc_pll_table[i].vdisplay == mode->vdisplay)
+			return MODE_OK;
+	}
+
+	return MODE_NOMODE;
+}
+
+
 static unsigned int format_pll_reg(void)
 {
 	unsigned int pllreg = 0;
@@ -510,6 +529,7 @@ static const struct drm_crtc_helper_funcs hibmc_crtc_helper_funcs = {
 	.atomic_flush	= hibmc_crtc_atomic_flush,
 	.atomic_enable	= hibmc_crtc_atomic_enable,
 	.atomic_disable	= hibmc_crtc_atomic_disable,
+	.mode_valid = hibmc_crtc_mode_valid,
 };
 
 int hibmc_de_init(struct hibmc_drm_private *priv)
-- 
2.7.4

