Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15291C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0159208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfDYIib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:38:31 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55497 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfDYIi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:38:27 -0400
X-Originating-IP: 90.88.147.33
Received: from localhost.localdomain (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B71C92001D;
        Thu, 25 Apr 2019 08:38:22 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: [PATCH v4 2/4] media: pixfmt: Add HEVC slice pixel format
Date:   Thu, 25 Apr 2019 10:37:50 +0200
Message-Id: <20190425083752.4973-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425083752.4973-1-paul.kocialkowski@bootlin.com>
References: <20190425083752.4973-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the V4L2_PIX_FMT_HEVC_SLICE pixel format, which currently
describes an output buffer with enough appended slice data for
producing one decoded frame with a stateless video decoder.

This will need to be reworked (along with the controls and the core) to
allow passing slice data individually, as it is the natural decoding
unit in HEVC.

We also need to figure out the description of the possible source data:
* Compressed slice data only, with slice controls attached;
* Slice data in Annex-B format (with raw slice header), without slice
  controls attached;
* Slice data in Annex-B format (with raw slice header), with slice
  controls attached.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 include/media/hevc-ctrls.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index 9ea013c88afc..2de83d9f6d47 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -11,6 +11,9 @@
 #ifndef _HEVC_CTRLS_H_
 #define _HEVC_CTRLS_H_
 
+/* The pixel format isn't stable at the moment and will likely be renamed. */
+#define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
+
 #define V4L2_CID_MPEG_VIDEO_HEVC_SPS		(V4L2_CID_MPEG_BASE + 1008)
 #define V4L2_CID_MPEG_VIDEO_HEVC_PPS		(V4L2_CID_MPEG_BASE + 1009)
 #define V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS	(V4L2_CID_MPEG_BASE + 1010)
-- 
2.21.0

