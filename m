Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AE7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A562235E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="i5vTu8yZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfKSOmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:42:09 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:57742 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728015AbfKSOl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:41:56 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B80EFC2ECC;
        Tue, 19 Nov 2019 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1574174515; bh=UxM7GkeegeLhnO6SHHYpc+n30A4Lz5lkq5h2P2p9FQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5vTu8yZfQa4+mw1sqUYNzugmQthZjEJt3/ZT1uYV2Y+D2JGXbhwxh40P6yGqqfDe
         3aZHMPa15xx9fBL9E8Teuz/z4Ztwrv+Xv9tNdEz8QjHWKtAn87l9RCwKJ4E4LbZRCa
         DPe6biz0gtzfH2ZDJ0pAKAiuGTc/mJxKlZzakiZTcc+/YZN0goEYxdu4xuAtiPTG+e
         NKgjzjCvzaiH+muaNqiYX/7lCfXwoBtabxNAlxdPNo1r7Svpmk6PiiBm1khv4iiufZ
         W60qCJ+qKmruGJkXg8DPx7SR7+EaeNBKLZQrU8hWQKSMWfPrnwQgzaBMoDvRyUfSZ3
         onwIolGHwO9jQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id 096C6A0066;
        Tue, 19 Nov 2019 14:41:52 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/4] DRM: ARC: PGU: cleanup supported format list code
Date:   Tue, 19 Nov 2019 17:41:45 +0300
Message-Id: <20191119144147.8022-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119144147.8022-1-Eugeniy.Paltsev@synopsys.com>
References: <20191119144147.8022-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of 'simplefb_format' structure usage as we only use its
'fourcc' field.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/gpu/drm/arc/arcpgu_crtc.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_crtc.c b/drivers/gpu/drm/arc/arcpgu_crtc.c
index 31d9824c46cc..5473b19a52ee 100644
--- a/drivers/gpu/drm/arc/arcpgu_crtc.c
+++ b/drivers/gpu/drm/arc/arcpgu_crtc.c
@@ -20,9 +20,9 @@
 
 #define ENCODE_PGU_XY(x, y)	((((x) - 1) << 16) | ((y) - 1))
 
-static struct simplefb_format supported_formats[] = {
-	{ "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0}, DRM_FORMAT_RGB565 },
-	{ "r8g8b8", 24, {16, 8}, {8, 8}, {0, 8}, {0, 0}, DRM_FORMAT_RGB888 },
+static const u32 arc_pgu_supported_formats[] = {
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
 };
 
 static void arc_pgu_set_pxl_fmt(struct drm_crtc *crtc)
@@ -30,20 +30,20 @@ static void arc_pgu_set_pxl_fmt(struct drm_crtc *crtc)
 	struct arcpgu_drm_private *arcpgu = crtc_to_arcpgu_priv(crtc);
 	const struct drm_framebuffer *fb = crtc->primary->state->fb;
 	uint32_t pixel_format = fb->format->format;
-	struct simplefb_format *format = NULL;
+	u32 format = DRM_FORMAT_INVALID;
 	int i;
 	u32 reg_ctrl;
 
-	for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
-		if (supported_formats[i].fourcc == pixel_format)
-			format = &supported_formats[i];
+	for (i = 0; i < ARRAY_SIZE(arc_pgu_supported_formats); i++) {
+		if (arc_pgu_supported_formats[i] == pixel_format)
+			format = arc_pgu_supported_formats[i];
 	}
 
-	if (WARN_ON(!format))
+	if (WARN_ON(format == DRM_FORMAT_INVALID))
 		return;
 
 	reg_ctrl = arc_pgu_read(arcpgu, ARCPGU_REG_CTRL);
-	if (format->fourcc == DRM_FORMAT_RGB565)
+	if (format == DRM_FORMAT_RGB565)
 		reg_ctrl &= ~ARCPGU_MODE_RGB888_MASK;
 	else
 		reg_ctrl |= ARCPGU_MODE_RGB888_MASK;
@@ -195,18 +195,15 @@ static struct drm_plane *arc_pgu_plane_init(struct drm_device *drm)
 {
 	struct arcpgu_drm_private *arcpgu = drm->dev_private;
 	struct drm_plane *plane = NULL;
-	u32 formats[ARRAY_SIZE(supported_formats)], i;
 	int ret;
 
 	plane = devm_kzalloc(drm->dev, sizeof(*plane), GFP_KERNEL);
 	if (!plane)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = 0; i < ARRAY_SIZE(supported_formats); i++)
-		formats[i] = supported_formats[i].fourcc;
-
 	ret = drm_universal_plane_init(drm, plane, 0xff, &arc_pgu_plane_funcs,
-				       formats, ARRAY_SIZE(formats),
+				       arc_pgu_supported_formats,
+				       ARRAY_SIZE(arc_pgu_supported_formats),
 				       NULL,
 				       DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret)
-- 
2.21.0

