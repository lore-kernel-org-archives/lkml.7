Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA92FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A882173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504294;
	bh=kheTHIygLSt5QDraeXk6hJ+3u9RmmtJxD/+jReERaOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GP4wlP7HmzAhJTPIhX4Fqqm27jT7auqRcl3dky2m/aDZizUkc2iAEe7dTDyMSzMFN
	 qqkDYe0rfjwuB6mgvHcIhnGxfu7pZCeWJArjOOa4lUfDj9PvsZHdnoVQ5YyayJa6qy
	 lKUjokMVjmfcmjKKHyWR/scz6Hz6di5Aaxh18fp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfCMTLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfCMTL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD8B5213A2;
        Wed, 13 Mar 2019 19:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504289;
        bh=kheTHIygLSt5QDraeXk6hJ+3u9RmmtJxD/+jReERaOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPe3Raxc6+s2GI6yPMJaWazT6lqfQCGoudYh+V+VCcs8JoYlLoxzunEmbDyQ5qvAF
         SBrxA/cr/cbzusrvIbTHGt+AGMT/nKGW/qgU61Bdl+fFH7EWxFNpC42duOZXTb639h
         n6K4ZHi7EggQSAPy3mnpls5nNcAP9b+/niwiTGVk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 32/60] drm/amd/display: Fix negative cursor pos programming
Date:   Wed, 13 Mar 2019 15:09:53 -0400
Message-Id: <20190313191021.158171-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 0921c41e19028314830b33daa681e46b46477c5e ]

[Why]
If the cursor pos passed from DM is less than the plane_state->dst_rect
top left corner then the unsigned cursor pos wraps around to a large
positive number since cursor pos is a u32.

There was an attempt to guard against this in hubp1_cursor_set_position
by checking the src_x_offset and src_y_offset and offseting the
cursor hotspot within hubp1_cursor_set_position.

However, the cursor position itself is still being programmed
incorrectly as a large value.

This manifests itself visually as the cursor disappearing or containing
strange artifacts near the middle of the screen on raven.

[How]
Don't subtract the destination rect top left corner from the pos but
add it to the hotspot instead. This happens before the pos gets
passed into hubp1_cursor_set_position.

This achieves the same result but avoids the subtraction wrap around.
With this fix the original cursor programming logic can be used again.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Acked-by: Murton Liu <Murton.Liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 220ba828748d..5bc214ce5227 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2654,8 +2654,8 @@ static void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		.mirror = pipe_ctx->plane_state->horizontal_mirror
 	};
 
-	pos_cpy.x -= pipe_ctx->plane_state->dst_rect.x;
-	pos_cpy.y -= pipe_ctx->plane_state->dst_rect.y;
+	pos_cpy.x_hotspot += pipe_ctx->plane_state->dst_rect.x;
+	pos_cpy.y_hotspot += pipe_ctx->plane_state->dst_rect.y;
 
 	if (pipe_ctx->plane_state->address.type
 			== PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
-- 
2.19.1

