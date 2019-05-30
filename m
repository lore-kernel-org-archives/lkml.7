Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB39C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD14C252A6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189949;
	bh=D1WUO/bKEhiRZhw3889DuMCeutgmEahz8bEKLcuAOAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fYrMNJrfY/75GLSVR2fIfWUNAXqUGz+cl0OmRHCad/2VKcPFcEXiiVExTQPliOqti
	 r0iveufihL3YaDViRFZkbQt+PxErcqGMwaiGBPCIvVpwZ2asyvek1RLks3juZY954d
	 0keRVRa+gqEfqm5geufz1VTxvHv+X6YFVZhTEA0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfE3DP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbfE3DMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:49 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C99FD21BE2;
        Thu, 30 May 2019 03:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185968;
        bh=D1WUO/bKEhiRZhw3889DuMCeutgmEahz8bEKLcuAOAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/5imLcBE9vbxcMwFj1MjrvuUcWAeDXTPhY4CKK1LA1xqob0Bdk6ewcOEPFSHAH1Y
         /FMQ/VgM7o7tD3O8du3DCWtdSaroNphf3MXZkvLsqu7fqAIpZsSKIjkvck2DdQd4y1
         rOIAr0/xnJlJzfOb4gieHOtQQYkK9J/5lr2dBqPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 399/405] drm/sun4i: dsi: Change the start delay calculation
Date:   Wed, 29 May 2019 20:06:37 -0700
Message-Id: <20190530030600.752387180@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit da676c6aa6413d59ab0a80c97bbc273025e640b2 ]

The current calculation for the video start delay in the current DSI driver
is that it is the total vertical size, minus the front porch and sync length,
plus 1. This equals to the active vertical size plus the back porch plus 1.

That 1 is coming in the Allwinner BSP from an variable that is set to 1.
However, if we look at the Allwinner BSP more closely, and especially in
the "legacy" code for the display (in drivers/video/sunxi/legacy/), we can
see that this variable is actually computed from the porches and the sync
minus 10, clamped between 8 and 100.

This fixes the start delay symptom we've seen on some panels (vblank
timeouts with vertical white stripes at the bottom of the panel).

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/6e5f72e68f47ca0223877464bf12f0c3f3978de8.1549896081.git-series.maxime.ripard@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 318994cd1b851..25d8cb9f92661 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -358,7 +358,9 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
-	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
+	u16 start = clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
+
+	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
 }
 
 static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
-- 
2.20.1



