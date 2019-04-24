Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578B8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C33218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfDXOXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:23:47 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:48409 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbfDXOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:23:45 -0400
Received: from localhost.localdomain (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 6A7D4100014;
        Wed, 24 Apr 2019 14:23:39 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     hans.verkuil@cisco.com, acourbot@chromium.org,
        sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     tfiga@chromium.org, posciak@chromium.org,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, ezequiel@collabora.com,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v10 3/4] media: pixfmt: Add H264_SLICE_RAW format documentation
Date:   Wed, 24 Apr 2019 16:22:36 +0200
Message-Id: <20190424142237.4979-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424142237.4979-1-paul.kocialkowski@bootlin.com>
References: <20190424142237.4979-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The H264_SLICE_RAW format introduced before is meant for stateless
decoders that will need the H264 parsed slice data without the start code.

Let's document it.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 .../media/uapi/v4l/pixfmt-compressed.rst      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/media/uapi/v4l/pixfmt-compressed.rst b/Documentation/media/uapi/v4l/pixfmt-compressed.rst
index 6c961cfb74da..4b701fc7653e 100644
--- a/Documentation/media/uapi/v4l/pixfmt-compressed.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-compressed.rst
@@ -52,6 +52,31 @@ Compressed Formats
       - ``V4L2_PIX_FMT_H264_MVC``
       - 'M264'
       - H264 MVC video elementary stream.
+    * .. _V4L2-PIX-FMT-H264-SLICE-RAW:
+
+      - ``V4L2_PIX_FMT_H264_SLICE_RAW``
+      - 'S264'
+      - H264 parsed slice data, without the start code and as
+	extracted from the H264 bitstream.  This format is adapted for
+	stateless video decoders that implement an H264 pipeline
+	(using the :ref:`mem2mem` and :ref:`media-request-api`).
+	Metadata associated with the frame to decode are required to
+	be passed through the ``V4L2_CID_MPEG_VIDEO_H264_SPS``,
+	``V4L2_CID_MPEG_VIDEO_H264_PPS``,
+	``V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX``,
+	``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS`` and
+	``V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS`` controls.  See the
+	:ref:`associated Codec Control IDs <v4l2-mpeg-h264>`.  Exactly
+	one output and one capture buffer must be provided for use
+	with this pixel format. The output buffer must contain the
+	appropriate number of macroblocks to decode a full
+	corresponding frame to the matching capture buffer.
+
+	.. note::
+
+	   This format is not yet part of the public kernel API and it
+	   is expected to change.
+
     * .. _V4L2-PIX-FMT-H263:
 
       - ``V4L2_PIX_FMT_H263``
-- 
2.21.0

