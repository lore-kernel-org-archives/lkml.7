Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA65AC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A235C2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfDMOPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 10:15:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57566 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbfDMOPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 10:15:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CDBB2AB3431B83E31328;
        Sat, 13 Apr 2019 22:15:11 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Sat, 13 Apr 2019
 22:15:05 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <narmstrong@baylibre.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <khilman@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/meson: Make some functions static
Date:   Sat, 13 Apr 2019 22:14:55 +0800
Message-ID: <20190413141455.34020-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

drivers/gpu/drm/meson/meson_viu.c:93:6: warning: symbol 'meson_viu_set_g12a_osd1_matrix' was not declared. Should it be static?
drivers/gpu/drm/meson/meson_viu.c:121:6: warning: symbol 'meson_viu_set_osd_matrix' was not declared. Should it be static?
drivers/gpu/drm/meson/meson_viu.c:190:6: warning: symbol 'meson_viu_set_osd_lut' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/meson/meson_viu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
index 0169c98..b590723 100644
--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -90,8 +90,8 @@ static int eotf_bypass_coeff[EOTF_COEFF_SIZE] = {
 	EOTF_COEFF_RIGHTSHIFT /* right shift */
 };
 
-void meson_viu_set_g12a_osd1_matrix(struct meson_drm *priv, int *m,
-				   bool csc_on)
+static void meson_viu_set_g12a_osd1_matrix(struct meson_drm *priv,
+					   int *m, bool csc_on)
 {
 	/* VPP WRAP OSD1 matrix */
 	writel(((m[0] & 0xfff) << 16) | (m[1] & 0xfff),
@@ -118,8 +118,8 @@ void meson_viu_set_g12a_osd1_matrix(struct meson_drm *priv, int *m,
 		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_EN_CTRL));
 }
 
-void meson_viu_set_osd_matrix(struct meson_drm *priv,
-			      enum viu_matrix_sel_e m_select,
+static void meson_viu_set_osd_matrix(struct meson_drm *priv,
+				     enum viu_matrix_sel_e m_select,
 			      int *m, bool csc_on)
 {
 	if (m_select == VIU_MATRIX_OSD) {
@@ -187,10 +187,10 @@ void meson_viu_set_osd_matrix(struct meson_drm *priv,
 #define OSD_EOTF_LUT_SIZE 33
 #define OSD_OETF_LUT_SIZE 41
 
-void meson_viu_set_osd_lut(struct meson_drm *priv, enum viu_lut_sel_e lut_sel,
-			   unsigned int *r_map, unsigned int *g_map,
-			   unsigned int *b_map,
-			   bool csc_on)
+static void
+meson_viu_set_osd_lut(struct meson_drm *priv, enum viu_lut_sel_e lut_sel,
+		      unsigned int *r_map, unsigned int *g_map,
+		      unsigned int *b_map, bool csc_on)
 {
 	unsigned int addr_port;
 	unsigned int data_port;
-- 
2.7.4


