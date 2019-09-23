Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58142C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CB420835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439616AbfIWMw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:52:27 -0400
Received: from regular1.263xmail.com ([211.150.70.204]:39686 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437050AbfIWMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:52:26 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.128])
        by regular1.263xmail.com (Postfix) with ESMTP id 773B922F;
        Mon, 23 Sep 2019 20:52:22 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P15436T140160991741696S1569243121384240_;
        Mon, 23 Sep 2019 20:52:21 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <100cee606d44a935076a63a8b3b5c1cb>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sandy Huang <hjc@rock-chips.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Eric Anholt <eric@anholt.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/36] drm/cirrus: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:51:46 +0800
Message-Id: <1569243119-183293-3-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569243119-183293-1-git-send-email-hjc@rock-chips.com>
References: <1569243119-183293-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/cirrus/cirrus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index 89d9e6f..ba47fdf 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -121,7 +121,7 @@ static void wreg_hdr(struct cirrus_device *cirrus, u8 val)
 
 static int cirrus_convert_to(struct drm_framebuffer *fb)
 {
-	if (fb->format->cpp[0] == 4 && fb->pitches[0] > CIRRUS_MAX_PITCH) {
+	if (fb->format->bpp[0] == 32 && fb->pitches[0] > CIRRUS_MAX_PITCH) {
 		if (fb->width * 3 <= CIRRUS_MAX_PITCH)
 			/* convert from XR24 to RG24 */
 			return 3;
@@ -138,7 +138,7 @@ static int cirrus_cpp(struct drm_framebuffer *fb)
 
 	if (convert_cpp)
 		return convert_cpp;
-	return fb->format->cpp[0];
+	return fb->format->bpp[0] / 8;
 }
 
 static int cirrus_pitch(struct drm_framebuffer *fb)
@@ -306,16 +306,16 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
 	if (!vmap)
 		return -ENOMEM;
 
-	if (cirrus->cpp == fb->format->cpp[0])
+	if (cirrus->cpp == fb->format->bpp[0] / 8)
 		drm_fb_memcpy_dstclip(cirrus->vram,
 				      vmap, fb, rect);
 
-	else if (fb->format->cpp[0] == 4 && cirrus->cpp == 2)
+	else if (fb->format->bpp[0] == 32 && cirrus->cpp == 2)
 		drm_fb_xrgb8888_to_rgb565_dstclip(cirrus->vram,
 						  cirrus->pitch,
 						  vmap, fb, rect, false);
 
-	else if (fb->format->cpp[0] == 4 && cirrus->cpp == 3)
+	else if (fb->format->bpp[0] == 32 && cirrus->cpp == 3)
 		drm_fb_xrgb8888_to_rgb888_dstclip(cirrus->vram,
 						  cirrus->pitch,
 						  vmap, fb, rect);
-- 
2.7.4



