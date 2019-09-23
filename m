Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86310C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6436520835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439687AbfIWMyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:54:09 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:38152 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394127AbfIWMyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:54:08 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.236])
        by regular1.263xmail.com (Postfix) with ESMTP id 6B03D474;
        Mon, 23 Sep 2019 20:53:59 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P17988T139868132738816S1569243231409431_;
        Mon, 23 Sep 2019 20:53:59 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <262127d4a0e95fd588c6e29b5f0fe5b5>
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
        Neil Armstrong <narmstrong@baylibre.com>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 33/36] drm/mgag200: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:53:47 +0800
Message-Id: <1569243230-183568-3-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569243230-183568-1-git-send-email-hjc@rock-chips.com>
References: <1569243230-183568-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 6822655..5aff652 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -41,7 +41,7 @@ static void mga_crtc_load_lut(struct drm_crtc *crtc)
 
 	WREG8(DAC_INDEX + MGA1064_INDEX, 0);
 
-	if (fb && fb->format->cpp[0] * 8 == 16) {
+	if (fb && fb->format->bpp[0] == 16) {
 		int inc = (fb->format->depth == 15) ? 8 : 4;
 		u8 r, b;
 		for (i = 0; i < MGAG200_LUT_SIZE; i += inc) {
@@ -925,7 +925,7 @@ static int mga_crtc_mode_set(struct drm_crtc *crtc,
 		/* 0x48: */        0,    0,    0,    0,    0,    0,    0,    0
 	};
 
-	bppshift = mdev->bpp_shifts[fb->format->cpp[0] - 1];
+	bppshift = mdev->bpp_shifts[fb->format->bpp[0] / 8 - 1];
 
 	switch (mdev->type) {
 	case G200_SE_A:
@@ -965,7 +965,7 @@ static int mga_crtc_mode_set(struct drm_crtc *crtc,
 		break;
 	}
 
-	switch (fb->format->cpp[0] * 8) {
+	switch (fb->format->bpp[0]) {
 	case 8:
 		dacvalue[MGA1064_MUL_CTL] = MGA1064_MUL_CTL_8bits;
 		break;
@@ -1022,8 +1022,8 @@ static int mga_crtc_mode_set(struct drm_crtc *crtc,
 	WREG_SEQ(3, 0);
 	WREG_SEQ(4, 0xe);
 
-	pitch = fb->pitches[0] / fb->format->cpp[0];
-	if (fb->format->cpp[0] * 8 == 24)
+	pitch = fb->pitches[0] / fb->format->bpp[0] / 8;
+	if (fb->format->bpp[0] == 24)
 		pitch = (pitch * 3) >> (4 - bppshift);
 	else
 		pitch = pitch >> (4 - bppshift);
@@ -1100,7 +1100,7 @@ static int mga_crtc_mode_set(struct drm_crtc *crtc,
 		((vdisplay & 0xc00) >> 7) |
 		((vsyncstart & 0xc00) >> 5) |
 		((vdisplay & 0x400) >> 3);
-	if (fb->format->cpp[0] * 8 == 24)
+	if (fb->format->bpp[0] == 24)
 		ext_vga[3] = (((1 << bppshift) * 3) - 1) | 0x80;
 	else
 		ext_vga[3] = ((1 << bppshift) - 1) | 0x80;
@@ -1166,9 +1166,9 @@ static int mga_crtc_mode_set(struct drm_crtc *crtc,
 			u32 bpp;
 			u32 mb;
 
-			if (fb->format->cpp[0] * 8 > 16)
+			if (fb->format->bpp[0] > 16)
 				bpp = 32;
-			else if (fb->format->cpp[0] * 8 > 8)
+			else if (fb->format->bpp[0] > 8)
 				bpp = 16;
 			else
 				bpp = 8;
-- 
2.7.4



