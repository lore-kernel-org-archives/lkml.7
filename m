Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25805C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F056C20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDCJZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:25:29 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43750 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbfDCJZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:25:29 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x339LXDn029080;
        Wed, 3 Apr 2019 11:25:20 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rmh5yaw3r-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Apr 2019 11:25:20 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8BE4D34;
        Wed,  3 Apr 2019 09:25:19 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5328A1752;
        Wed,  3 Apr 2019 09:25:19 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Apr 2019
 11:25:19 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 3 Apr 2019 11:25:16
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/stm: ltdc: add modifier support
Date:   Wed, 3 Apr 2019 11:25:14 +0200
Message-ID: <1554283514-2960-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mickael Reulier <mickael.reulier@st.com>
Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index b1741a9..6fa8fbc 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -232,6 +232,11 @@ static const enum ltdc_pix_fmt ltdc_pix_fmt_a1[NB_PF] = {
 	PF_ARGB4444		/* 0x07 */
 };
 
+static const u64 ltdc_format_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_INVALID
+};
+
 static inline u32 reg_read(void __iomem *base, u32 reg)
 {
 	return readl_relaxed(base + reg);
@@ -864,6 +869,16 @@ static void ltdc_plane_atomic_print_state(struct drm_printer *p,
 	fpsi->counter = 0;
 }
 
+static bool ltdc_plane_format_mod_supported(struct drm_plane *plane,
+					    u32 format,
+					    u64 modifier)
+{
+	if (modifier == DRM_FORMAT_MOD_LINEAR)
+		return true;
+
+	return false;
+}
+
 static const struct drm_plane_funcs ltdc_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
@@ -872,6 +887,7 @@ static const struct drm_plane_funcs ltdc_plane_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 	.atomic_print_state = ltdc_plane_atomic_print_state,
+	.format_mod_supported = ltdc_plane_format_mod_supported,
 };
 
 static const struct drm_plane_helper_funcs ltdc_plane_helper_funcs = {
@@ -890,6 +906,7 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 	unsigned int i, nb_fmt = 0;
 	u32 formats[NB_PF * 2];
 	u32 drm_fmt, drm_fmt_no_alpha;
+	const u64 *modifiers = ltdc_format_modifiers;
 	int ret;
 
 	/* Get supported pixel formats */
@@ -918,7 +935,7 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 
 	ret = drm_universal_plane_init(ddev, plane, possible_crtcs,
 				       &ltdc_plane_funcs, formats, nb_fmt,
-				       NULL, type, NULL);
+				       modifiers, type, NULL);
 	if (ret < 0)
 		return NULL;
 
@@ -1179,6 +1196,8 @@ int ltdc_load(struct drm_device *ddev)
 		goto err;
 	}
 
+	ddev->mode_config.allow_fb_modifiers = true;
+
 	ret = ltdc_crtc_init(ddev, crtc);
 	if (ret) {
 		DRM_ERROR("Failed to init crtc\n");
-- 
2.7.4

