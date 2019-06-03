Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E16C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06FF27A7C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfFCOVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:21:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54005 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfFCOVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:21:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hXnpe-0002aE-GG; Mon, 03 Jun 2019 14:21:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jyri Sarha <jsarha@ti.com>, Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/bridge: sii902x: fix comparision of u32 with less than zero
Date:   Mon,  3 Jun 2019 15:21:02 +0100
Message-Id: <20190603142102.27191-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The less than check for the variable num_lanes is always going to be
false because the variable is a u32.  Fix this by making num_lanes an
int and also make loop index i an int too.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: ff5781634c41 ("drm/bridge: sii902x: Implement HDMI audio support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index d6f98d388ac2..21a947603c88 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -719,7 +719,7 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 		.max_i2s_channels = 0,
 	};
 	u8 lanes[4];
-	u32 num_lanes, i;
+	int num_lanes, i;
 
 	if (!of_property_read_bool(dev->of_node, "#sound-dai-cells")) {
 		dev_dbg(dev, "%s: No \"#sound-dai-cells\", no audio\n",
-- 
2.20.1

