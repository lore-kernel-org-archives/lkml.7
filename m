Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55499C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB6E20835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501955AbfIWMqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:46:34 -0400
Received: from regular1.263xmail.com ([211.150.70.204]:38764 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501944AbfIWMqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:46:33 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.177])
        by regular1.263xmail.com (Postfix) with ESMTP id 62F4E20C;
        Mon, 23 Sep 2019 20:46:30 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31562T139824700114688S1569242788771874_;
        Mon, 23 Sep 2019 20:46:29 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <63b6f95d940d4daec52631830833bb85>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, linux-kernel@vger.kernel.org
Subject: [PATCH 10/36] drm/arm: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:46:23 +0800
Message-Id: <1569242784-182780-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c | 2 +-
 drivers/gpu/drm/arm/malidp_hw.c                         | 2 +-
 drivers/gpu/drm/arm/malidp_planes.c                     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
index 3b0a70e..d02dfc6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
@@ -89,7 +89,7 @@ komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *file,
 				    alignment_header);
 
 	kfb->afbc_size = kfb->offset_payload + n_blocks *
-			 ALIGN(info->cpp[0] * AFBC_SUPERBLK_PIXELS,
+			 ALIGN(info->bpp[0] / 8 * AFBC_SUPERBLK_PIXELS,
 			       AFBC_SUPERBLK_ALIGNMENT);
 	min_size = kfb->afbc_size + fb->offsets[0];
 	if (min_size > obj->size) {
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index bd8265f..54be8d1 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -384,7 +384,7 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
 int malidp_format_get_bpp(u32 fmt)
 {
 	const struct drm_format_info *info = drm_format_info(fmt);
-	int bpp = info->cpp[0] * 8;
+	int bpp = info->bpp[0];
 
 	if (bpp == 0) {
 		switch (fmt) {
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 3c70a53..628f325 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -225,7 +225,7 @@ bool malidp_format_mod_supported(struct drm_device *drm,
 
 	if (modifier & AFBC_SPLIT) {
 		if (!info->is_yuv) {
-			if (info->cpp[0] <= 2) {
+			if (info->bpp[0] <= 16) {
 				DRM_DEBUG_KMS("RGB formats <= 16bpp are not supported with SPLIT\n");
 				return false;
 			}
-- 
2.7.4



