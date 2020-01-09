Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C052C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A852067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgAIItR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:49:17 -0500
Received: from mail.manjaro.org ([176.9.38.148]:46416 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbgAIItQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:49:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 9069F36E4E55;
        Thu,  9 Jan 2020 09:49:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BYu5Us4bT7v6; Thu,  9 Jan 2020 09:49:13 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 1/1] drm/bridge: anx78xx: fix integer type used for storing dp link rate
Date:   Thu,  9 Jan 2020 09:48:01 +0100
Message-Id: <20200109084801.3117-2-t.schramm@manjaro.org>
In-Reply-To: <20200109084801.3117-1-t.schramm@manjaro.org>
References: <20200109084801.3117-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ff1e8fb68ea0 ("drm/bridge: analogix-anx78xx: Avoid drm_dp_link helpers")
changed the link training logic to remove use of drm_dp_link helpers. However
the new logic stores the maximum link rate in a u8, overflowing it.
This commit changes the logic to store the max link rate in a unsigned int
instead.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/gpu/drm/bridge/analogix-anx78xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index 274989f96a91..0f38b8c40dff 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -748,6 +748,7 @@ static int anx78xx_init_pdata(struct anx78xx *anx78xx)
 static int anx78xx_dp_link_training(struct anx78xx *anx78xx)
 {
 	u8 dp_bw, dpcd[2];
+	unsigned int max_link_rate;
 	int err;
 
 	err = regmap_write(anx78xx->map[I2C_IDX_RX_P0], SP_HDMI_MUTE_CTRL_REG,
@@ -866,8 +867,8 @@ static int anx78xx_dp_link_training(struct anx78xx *anx78xx)
 	if (err)
 		return err;
 
-	dpcd[0] = drm_dp_max_link_rate(anx78xx->dpcd);
-	dpcd[0] = drm_dp_link_rate_to_bw_code(dpcd[0]);
+	max_link_rate = drm_dp_max_link_rate(anx78xx->dpcd);
+	dpcd[0] = drm_dp_link_rate_to_bw_code(max_link_rate);
 	err = regmap_write(anx78xx->map[I2C_IDX_TX_P0],
 			   SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
 	if (err)
-- 
2.24.1

