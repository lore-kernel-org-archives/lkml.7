Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165E1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D325A2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368668;
	bh=BVcqPrLL44npZx+5H8LlHov+wp51HvVv+pcHGACAg7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qq0+bjeekY2oBT0xRSnrp+ygfgVxyExobT2L/UyFBDyAoLKndPLS02aYPJk2P2yfx
	 k7OStNlJ7XViImbWiDP9FJEGj6PHYPuhTA+rfIoOmuvLy9JdLsjDUBu/d/rbBTJKIu
	 mX4GynixPYv32sviMINBCgt+jWSKKRs7sw3La11U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbfDDJE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbfDDJEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:04:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FBAF2147C;
        Thu,  4 Apr 2019 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368664;
        bh=BVcqPrLL44npZx+5H8LlHov+wp51HvVv+pcHGACAg7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e3AnE/wEFdGbD42qyhb76xrv+uijwmLbIKksCHso1w5JIkZT2yCeJDaEALVaN9YJh
         dzMlrJ2In8E8NsZarRKCQ34LhimmlX0i7BYZk+rI26rKtupVD43o5Ono9Kxb7eTKqC
         s989UQ/hPdhpplu71hXPx9axe1ztkghPBIrKwfU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 123/187] drm/amd/display: Disconnect mpcc when changing tg
Date:   Thu,  4 Apr 2019 10:47:40 +0200
Message-Id: <20190404084609.031490097@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



