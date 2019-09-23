Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEB9C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1D220820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502033AbfIWMtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:49:47 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:41510 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501986AbfIWMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:49:46 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.175])
        by regular1.263xmail.com (Postfix) with ESMTP id E437338F;
        Mon, 23 Sep 2019 20:49:40 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P28975T139999806740224S1569242970112868_;
        Mon, 23 Sep 2019 20:49:40 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8fdb7c89ba2b5939547ac04f09273619>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Y.C. Chen" <yc_chen@aspeedtech.com>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/36] drm/ast: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:49:12 +0800
Message-Id: <1569242968-183093-5-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569242968-183093-1-git-send-email-hjc@rock-chips.com>
References: <1569242968-183093-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/ast/ast_mode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index c191e8e..439d0b3 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -93,7 +93,7 @@ static bool ast_get_vbios_mode_info(struct drm_crtc *crtc, struct drm_display_mo
 	u32 hborder, vborder;
 	bool check_sync;
 
-	switch (fb->format->cpp[0] * 8) {
+	switch (fb->format->bpp[0]) {
 	case 8:
 		vbios_mode->std_table = &vbios_stdtable[VGAModeIndex];
 		color_index = VGAModeIndex - 1;
@@ -217,7 +217,7 @@ static bool ast_get_vbios_mode_info(struct drm_crtc *crtc, struct drm_display_mo
 		if (vbios_mode->enh_table->flags & NewModeInfo) {
 			ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0x91, 0xa8);
 			ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0x92,
-					  fb->format->cpp[0] * 8);
+					  fb->format->bpp[0]);
 			ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0x93, adjusted_mode->clock / 1000);
 			ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0x94, adjusted_mode->crtc_hdisplay);
 			ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0x95, adjusted_mode->crtc_hdisplay >> 8);
@@ -422,7 +422,7 @@ static void ast_set_ext_reg(struct drm_crtc *crtc, struct drm_display_mode *mode
 	const struct drm_framebuffer *fb = crtc->primary->fb;
 	u8 jregA0 = 0, jregA3 = 0, jregA8 = 0;
 
-	switch (fb->format->cpp[0] * 8) {
+	switch (fb->format->bpp[0]) {
 	case 8:
 		jregA0 = 0x70;
 		jregA3 = 0x01;
@@ -480,7 +480,7 @@ static bool ast_set_dac_reg(struct drm_crtc *crtc, struct drm_display_mode *mode
 {
 	const struct drm_framebuffer *fb = crtc->primary->fb;
 
-	switch (fb->format->cpp[0] * 8) {
+	switch (fb->format->bpp[0]) {
 	case 8:
 		break;
 	default:
-- 
2.7.4



