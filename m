Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32625ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A98206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfJGRrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:47:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60856 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfJGRrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:47:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id D87EB28D41F
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        fbuergisser@chromium.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 for 5.4 4/4] media: hantro: Fix picture order count table enable
Date:   Mon,  7 Oct 2019 14:45:05 -0300
Message-Id: <20191007174505.10681-5-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191007174505.10681-1-ezequiel@collabora.com>
References: <20191007174505.10681-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francois Buergisser <fbuergisser@chromium.org>

The picture order count table only makes sense for profiles
higher than Baseline. This is confirmed by the H.264 specification
(See 8.2.1 Decoding process for picture order count), which
clarifies how POC are used for features not present in Baseline.

"""
Picture order counts are used to determine initial picture orderings
for reference pictures in the decoding of B slices, to represent picture
order differences between frames or fields for motion vector derivation
in temporal direct mode, for implicit mode weighted prediction in B slices,
and for decoder conformance checking.
"""

As a side note, this change matches various vendors downstream codebases,
including ChromiumOS and IMX VPU libraries.

Fixes: dea0a82f3d22 ("media: hantro: Add support for H264 decoding on G1")
Signed-off-by: Francois Buergisser <fbuergisser@chromium.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
v2:
* New patch.

 drivers/staging/media/hantro/hantro_g1_h264_dec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_g1_h264_dec.c b/drivers/staging/media/hantro/hantro_g1_h264_dec.c
index c92460407613..05576dbd39e2 100644
--- a/drivers/staging/media/hantro/hantro_g1_h264_dec.c
+++ b/drivers/staging/media/hantro/hantro_g1_h264_dec.c
@@ -34,9 +34,9 @@ static void set_params(struct hantro_ctx *ctx)
 	reg = G1_REG_DEC_CTRL0_DEC_AXI_WR_ID(0x0);
 	if (sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD)
 		reg |= G1_REG_DEC_CTRL0_SEQ_MBAFF_E;
-	reg |= G1_REG_DEC_CTRL0_PICORD_COUNT_E;
 	if (sps->profile_idc > 66)
-		reg |= G1_REG_DEC_CTRL0_WRITE_MVS_E;
+		reg = G1_REG_DEC_CTRL0_PICORD_COUNT_E |
+		      G1_REG_DEC_CTRL0_WRITE_MVS_E;
 
 	if (!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY) &&
 	    (sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD ||
-- 
2.22.0

