Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABFCC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCD92082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442693AbfIYIHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:07:21 -0400
Received: from regular1.263xmail.com ([211.150.70.198]:55076 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404849AbfIYIHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:07:19 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.42])
        by regular1.263xmail.com (Postfix) with ESMTP id EA12B305;
        Wed, 25 Sep 2019 16:07:05 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2645T139744972404480S1569398812082049_;
        Wed, 25 Sep 2019 16:07:05 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b7eb8ce1b1359ea5bd932d20f67e4313>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, heiko@sntech.de, Ayan.Halder@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
Date:   Wed, 25 Sep 2019 16:06:38 +0800
Message-Id: <1569398801-92201-2-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569398801-92201-1-git-send-email-hjc@rock-chips.com>
References: <1569398801-92201-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These new format is supported by some rockchip socs:

DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
 include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index c630064..f25fa81 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -274,6 +274,24 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_YUV420_10BIT,    .depth = 0,
 		  .num_planes = 1, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
 		  .is_yuv = true },
+		{ .format = DRM_FORMAT_NV12_10,		.depth = 0,
+		  .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
+		  .is_yuv = true },
+		{ .format = DRM_FORMAT_NV21_10,		.depth = 0,
+		  .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
+		  .is_yuv = true },
+		{ .format = DRM_FORMAT_NV16_10,		.depth = 0,
+		  .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 1,
+		  .is_yuv = true },
+		{ .format = DRM_FORMAT_NV61_10,		.depth = 0,
+		  .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 1,
+		  .is_yuv = true },
+		{ .format = DRM_FORMAT_NV24_10,		.depth = 0,
+		  .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 1, .vsub = 1,
+		  .is_yuv = true },
+		{ .format = DRM_FORMAT_NV42_10,		.depth = 0,
+		  .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 1, .vsub = 1,
+		  .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 3feeaa3..0479f47 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -238,6 +238,20 @@ extern "C" {
 #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
 
 /*
+ * 2 plane YCbCr 10bit
+ * index 0 = Y plane, [9:0] Y
+ * index 1 = Cr:Cb plane, [19:0]
+ * or
+ * index 1 = Cb:Cr plane, [19:0]
+ */
+#define DRM_FORMAT_NV12_10	fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
+#define DRM_FORMAT_NV21_10	fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
+#define DRM_FORMAT_NV16_10	fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
+#define DRM_FORMAT_NV61_10	fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
+#define DRM_FORMAT_NV24_10	fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
+#define DRM_FORMAT_NV42_10	fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
+
+/*
  * 2 plane YCbCr MSB aligned
  * index 0 = Y plane, [15:0] Y:x [10:6] little endian
  * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
-- 
2.7.4



