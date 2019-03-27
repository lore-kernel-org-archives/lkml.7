Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFA1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D279821734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714397;
	bh=bX4pBVz/3iw4BZm1qrpNl4QIZCV1Uj/5LGwYhZDu13s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P8M2G7DoXozFygX7h6vz1BinNdpGMSp359x9p8RS4MqYv3cjMEkn9SztlA03N4VfL
	 OrG23+NZ3qiBez8/APkheJrRQDDb5LTtLQNFKYdpaLW1CVu6JKFYU2dM5rrxAc/qYV
	 QcV4LQ+JbKWZh3Z9oSoVmPwDR88FS7U8Js0bjjbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbfC0TT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388208AbfC0SHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:07:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1710217D9;
        Wed, 27 Mar 2019 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710052;
        bh=bX4pBVz/3iw4BZm1qrpNl4QIZCV1Uj/5LGwYhZDu13s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6LOScpivMLjUz2gchQAjZQ2UbWPIEHoJROOjnXpVxnylVBFBooB15JLkARkcwyrD
         tfSG8FAkyknhjqq6+VS1f0/CxAs5TejqSWpZQIBm2KbBMdoD3w6sCFkR28HMFYx8o2
         Nqn4tPTzznYiXRt7FA5WMA6gGAcKHH18KVOGBsWg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 175/262] drm/amd/display: Disconnect mpcc when changing tg
Date:   Wed, 27 Mar 2019 14:00:30 -0400
Message-Id: <20190327180158.10245-175-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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
index 41883c981789..a684b38332ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2334,9 +2334,10 @@ static void dcn10_apply_ctx_for_surface(
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

