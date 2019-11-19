Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B0DC43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1F92235E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dQUN7Tod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfKSOl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:41:58 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:57760 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728151AbfKSOl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:41:56 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1B414C08FE;
        Tue, 19 Nov 2019 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1574174516; bh=qqXWvfWwuI+nZia268XDs83BGemiBWv1K7uf/sFQhLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQUN7TodesjqoTqzqIvGXhuRpK/NqfzwNPoJlTF5j+TtxfPqT1XjjIpgN3t2BkXXh
         CJpNZwhisEUe68pH6sFmzl9kb9NVMLeQtk4MC+C2vwnDnfh+/B0fwHv1CbL9GSmOfu
         SX0muNWsAbZ19+pY43MywWDEs9RScYqNdgRAdicSkqf9e/fypLgWu+KmUFXvCY6yWl
         xjIEQFRwlGHlKexzICn7aFPoO2YHFcXGYIWiAsxF/AK+wQ3sXfAHrvcf3xASYv6KvH
         gGvmIC6DjzjayJXrd+a0Gxf5poxJkXBEmBIr+cXiaXw3ODfHW0VshFA1eAQ2cS30Vo
         c49T1RpbKitQQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id 62061A0060;
        Tue, 19 Nov 2019 14:41:52 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/4] DRM: ARC: PGU: fix framebuffer format switching
Date:   Tue, 19 Nov 2019 17:41:44 +0300
Message-Id: <20191119144147.8022-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119144147.8022-1-Eugeniy.Paltsev@synopsys.com>
References: <20191119144147.8022-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation don't switch to RGB565 format if BGR888 was
previously used. Fix that.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/gpu/drm/arc/arcpgu_crtc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_crtc.c b/drivers/gpu/drm/arc/arcpgu_crtc.c
index dfaddbb7da0d..31d9824c46cc 100644
--- a/drivers/gpu/drm/arc/arcpgu_crtc.c
+++ b/drivers/gpu/drm/arc/arcpgu_crtc.c
@@ -32,6 +32,7 @@ static void arc_pgu_set_pxl_fmt(struct drm_crtc *crtc)
 	uint32_t pixel_format = fb->format->format;
 	struct simplefb_format *format = NULL;
 	int i;
+	u32 reg_ctrl;
 
 	for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
 		if (supported_formats[i].fourcc == pixel_format)
@@ -41,11 +42,12 @@ static void arc_pgu_set_pxl_fmt(struct drm_crtc *crtc)
 	if (WARN_ON(!format))
 		return;
 
-	if (format->fourcc == DRM_FORMAT_RGB888)
-		arc_pgu_write(arcpgu, ARCPGU_REG_CTRL,
-			      arc_pgu_read(arcpgu, ARCPGU_REG_CTRL) |
-					   ARCPGU_MODE_RGB888_MASK);
-
+	reg_ctrl = arc_pgu_read(arcpgu, ARCPGU_REG_CTRL);
+	if (format->fourcc == DRM_FORMAT_RGB565)
+		reg_ctrl &= ~ARCPGU_MODE_RGB888_MASK;
+	else
+		reg_ctrl |= ARCPGU_MODE_RGB888_MASK;
+	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL, reg_ctrl);
 }
 
 static const struct drm_crtc_funcs arc_pgu_crtc_funcs = {
-- 
2.21.0

