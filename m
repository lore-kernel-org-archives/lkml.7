Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F34C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD5F20693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDKJhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:37:18 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47217 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfDKJhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:37:18 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 8AD511BF203;
        Thu, 11 Apr 2019 09:37:13 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     hans.verkuil@cisco.com, acourbot@chromium.org,
        sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     tfiga@chromium.org, posciak@chromium.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, ezequiel@collabora.com,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v9 3/4] media: pixfmt: Add H264_SLICE_RAW format documentation
Date:   Thu, 11 Apr 2019 11:37:02 +0200
Message-Id: <42479a7eb7cd6cecfe437f150060651404265b70.1554975396.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.dec5630d6b289e0a50e1880be436050471a05269.1554975396.git-series.maxime.ripard@bootlin.com>
References: <cover.dec5630d6b289e0a50e1880be436050471a05269.1554975396.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H264_SLICE_RAW format introduced before is meant for stateless
decoders that will need the H264 parsed slice data without the start code.

Let's document it.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/media/uapi/v4l/pixfmt-compressed.rst | 25 +++++++++++++++-
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
git-series 0.9.1
