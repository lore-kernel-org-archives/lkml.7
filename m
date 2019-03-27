Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8CDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C2A2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710454;
	bh=50IVLKrAKNAswo9wRXBCcbOU1+WCy+mhqwxFTeLvgis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AwyL5rUo1z6JhIomqr42DeEjnZhILclumbapEz+EXCSrgb+I2wa+PEvMgslOsJXQ1
	 jVYtw9uu3JiWb2xQ3D8A6cJGziDoLhJMQ5EFRsDVWDTKk4OZp7B2Kx212LQkr5adaZ
	 FIjAB+Evk7cKY2Vv5IM4/6Kf8fVmM3kypHdXh76c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbfC0SON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389588AbfC0SOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:14:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B787620449;
        Wed, 27 Mar 2019 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710450;
        bh=50IVLKrAKNAswo9wRXBCcbOU1+WCy+mhqwxFTeLvgis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjvIgayhhHhnZZChPdd+l07tChZi63g6/JUepmajbnaqirdcZ26ZhVi7fHfsxPvOq
         AR3ggX5egRShJlwgVz6QFcJH1TlarT/1U16ZMUGvAiof98ws/+EImpAucXGlnYip6O
         TuTMlKTa0yWNUqorLfm71QRd1xTTdqlvrFPJd7ag=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 125/192] drm/amd/display: Disconnect mpcc when changing tg
Date:   Wed, 27 Mar 2019 14:09:17 -0400
Message-Id: <20190327181025.13507-125-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 77476360f173c127c191bfe8ca8113130ef283b8 ]

[Why]
This fixes an mpc programming error for the following sequence of
atomic commits when pipe split is enabled:

Commit 1: CRTC0 (plane 4, plane 3)

Pipe 0: old_plane_state = A0, new_plane_state = A1,   new_tg = T0
Pipe 1: old_plane_state = B0, new_plane_state = B1,   new_tg = T0
Pipe 2: old_plane_state = A0, new_plane_state = A1,   new_tg = T0
Pipe 3: old_plane_state = B0, new_plane_state = B1,   new_tg = T0

Commit 2: CRTC0 (plane 3), CRTC1 (plane 2)

Pipe 0: old_plane_state = A1, new_plane_state = A2,   new_tg = T0
Pipe 1: old_plane_state = B1, new_plane_state = B2,   new_tg = T1
Pipe 2: old_plane_state = A1, new_plane_state = NULL, new_tg = NULL
Pipe 3: old_plane_state = B1, new_plane_state = NULL, new_tg = NULL

In the second commit the assertion for mpcc in use is hit because
mpcc disconnect never occurs for pipe 1. This is because the stream
changes for pipe 1 and the opp_list is empty.

This sequence occurs when running the
"igt@kms_plane_multiple@atomic-pipe-A-tiling-none" test with two
displays connected.

[How]
Expand the reset condition to include:

"old_pipe_ctx->stream_res.tg != new_pipe_ctx->stream_res.tg"

...but only when the plane state is non-NULL for both old and new.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 4058b59d9bea..a0355709abd1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2336,9 +2336,10 @@ static void dcn10_apply_ctx_for_surface(
 			}
 		}
 
-		if (!pipe_ctx->plane_state &&
-			old_pipe_ctx->plane_state &&
-			old_pipe_ctx->stream_res.tg == tg) {
+		if ((!pipe_ctx->plane_state ||
+		     pipe_ctx->stream_res.tg != old_pipe_ctx->stream_res.tg) &&
+		    old_pipe_ctx->plane_state &&
+		    old_pipe_ctx->stream_res.tg == tg) {
 
 			dc->hwss.plane_atomic_disconnect(dc, old_pipe_ctx);
 			removed_pipe[i] = true;
-- 
2.19.1

