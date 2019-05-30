Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D337C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E664025374
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190210;
	bh=T4dd8ApveJOaVaQZYHfqP1ICixbz55uiW5XkeUbLFtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kbDBfEzpKz5fVjcy0ZpKWfIZL6HcS96Y2aYqKXG7d5Pq2wpwTqjbOQGfzPgyBXbB4
	 59HFHXOt9gD+dY/xr9kpZhLQMfexma5EFz8ieVJ2pq3Eu9J3o5OP/fiNxbm+JatR8j
	 eiIkZYir7zR+7ZveANRyT1nEInwzfRfLnHcF6ozY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbfE3EX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbfE3DPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:01 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50B2424586;
        Thu, 30 May 2019 03:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186100;
        bh=T4dd8ApveJOaVaQZYHfqP1ICixbz55uiW5XkeUbLFtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KId+aGUTkdoeUgcjNBjXwev5F3/ZH92mhLldOLmvVzoUlQn6Zr/KRUavooKqCnq9W
         D9zrtZpfDXxi6m+uQZjh5xFpjbkyGpu7EwySRuHnYJEyBknCiLpC5jphSxSR4EeFy6
         rrueFF39NNwhXVUzhv0ppbiwe3QsgPQF0hhcCH5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Sun peng Li <Sunpeng.Li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 236/346] drm/amd/display: Prevent cursor hotspot overflow for RV overlay planes
Date:   Wed, 29 May 2019 20:05:09 -0700
Message-Id: <20190530030552.998746142@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6752bea8b03e77c98be7d8d25b0a9d86a00b3cf7 ]

[Why]
The actual position for the cursor on the screen is essentially:

x_out = x - x_plane - x_hotspot
y_out = y - y_plane - y_hotspot

The register values for cursor position and cursor hotspot need to be
greater than zero when programmed, but we also need to subtract off
the plane position to display the cursor at the correct position.

Since we don't want x or y to be less than zero, we add the plane
position as a positive value to x_hotspot or y_hotspot. However, what
this doesn't take into account is that the hotspot registers are limited
by the maximum cursor size.

On DCN10 the cursor hotspot regitsers are masked to 0xFF, so they have
a maximum value of 0-255. Values greater this will wrap, causing the
cursor to display in the wrong position.

In practice this means that for sufficiently large plane positions, the
cursor will be drawn twice on the screen, and can cause screen flashes
or p-state WARNS depending on what the wrapped value is.

So we need a way to remove the value from x_plane and y_plane without
exceeding the maximum cursor size.

[How]
Subtract as much as x_plane/y_plane as possible from x and y and place
the remainder in the cursor hotspot register.

The value for x_hotspot and y_hotspot can still wrap around but it
won't happen in a case where the cursor is actually enabled.

The cursor plane needs to intersect at least one pixel of the plane's
rectangle to be enabled, so the cursor position + hotspot provided by
userspace must always be strictly less than the maximum cursor size for
the cursor to actually be enabled.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Sun peng Li <Sunpeng.Li@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c    | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index a684b38332ac3..2ab05a4e8ed4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2658,9 +2658,15 @@ static void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		.rotation = pipe_ctx->plane_state->rotation,
 		.mirror = pipe_ctx->plane_state->horizontal_mirror
 	};
-
-	pos_cpy.x_hotspot += pipe_ctx->plane_state->dst_rect.x;
-	pos_cpy.y_hotspot += pipe_ctx->plane_state->dst_rect.y;
+	uint32_t x_plane = pipe_ctx->plane_state->dst_rect.x;
+	uint32_t y_plane = pipe_ctx->plane_state->dst_rect.y;
+	uint32_t x_offset = min(x_plane, pos_cpy.x);
+	uint32_t y_offset = min(y_plane, pos_cpy.y);
+
+	pos_cpy.x -= x_offset;
+	pos_cpy.y -= y_offset;
+	pos_cpy.x_hotspot += (x_plane - x_offset);
+	pos_cpy.y_hotspot += (y_plane - y_offset);
 
 	if (pipe_ctx->plane_state->address.type
 			== PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
-- 
2.20.1



