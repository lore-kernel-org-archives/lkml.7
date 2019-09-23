Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB82AC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07EA20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501989AbfIWMtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:49:35 -0400
Received: from regular1.263xmail.com ([211.150.70.198]:34992 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfIWMtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:49:35 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.175])
        by regular1.263xmail.com (Postfix) with ESMTP id 78A7F1EB;
        Mon, 23 Sep 2019 20:49:31 +0800 (CST)
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
        Mon, 23 Sep 2019 20:49:31 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <81cc42a836c8ab33cf18b9b9ce045c3e>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Jyri Sarha <jsarha@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/36] drm/tilcdc: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:49:08 +0800
Message-Id: <1569242968-183093-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c  | 2 +-
 drivers/gpu/drm/tilcdc/tilcdc_plane.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index e9dd5e5..78c587d 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -71,7 +71,7 @@ static void set_scanout(struct drm_crtc *crtc, struct drm_framebuffer *fb)
 
 	start = gem->paddr + fb->offsets[0] +
 		crtc->y * fb->pitches[0] +
-		crtc->x * fb->format->cpp[0];
+		crtc->x * fb->format->bpp[0] / 8;
 
 	end = start + (crtc->mode.vdisplay * fb->pitches[0]);
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_plane.c b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
index 3abb964..fca7375 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_plane.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
@@ -55,7 +55,7 @@ static int tilcdc_plane_atomic_check(struct drm_plane *plane,
 	}
 
 	pitch = crtc_state->mode.hdisplay *
-		state->fb->format->cpp[0];
+		state->fb->format->bpp[0] / 8;
 	if (state->fb->pitches[0] != pitch) {
 		dev_err(plane->dev->dev,
 			"Invalid pitch: fb and crtc widths must be the same");
-- 
2.7.4



