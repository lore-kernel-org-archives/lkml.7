Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA76AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9689820693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369749;
	bh=CBEz42kDGgw31r0lh+g2GSN1SAYIsGPmG/vWSlw4owI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UmCvWornz0hf+1x0IYtBBA/5IsOqv+SXv36Blrde8nLirzKzD5Q6L62zHarjRGVaM
	 JzCMdDXlW02D/gPBu7Une8xaEC7+zTYEuvG2FFmMWAVfe1g82Em9d53y4TOjDqKu8h
	 JST/c/DFE7n+/rKzU9akFYPW8vTp5tw3ZHAT2J3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbfDDJW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387747AbfDDJQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD82F20652;
        Thu,  4 Apr 2019 09:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369363;
        bh=CBEz42kDGgw31r0lh+g2GSN1SAYIsGPmG/vWSlw4owI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIyVRjnJxfiyhGoiJw8OAqSxCZjOyr82sUPONcKqeHasMs68CuWFS0kfh2H5cmLfW
         C6f9+3zMAXF5ZqL9Dk859RwEtdU/DYr0dOa5vaYkfGLfsjj33m5VHfBb1YjskVVmoC
         Lxibb9g/Q3I0Tc29fvwEW5bpFuUSnxT/k0AkG3sI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Sun peng Li <Sunpeng.Li@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 195/246] drm/amd/display: Enable vblank interrupt during CRC capture
Date:   Thu,  4 Apr 2019 10:48:15 +0200
Message-Id: <20190404084626.014597145@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 428da2bdb05d76c48d0bd8fbfa2e4c102685be08 ]

[Why]
In order to read CRC events when CRC capture is enabled the vblank
interrput handler needs to be running for the CRTC. The handler is
enabled while there is an active vblank reference.

When running IGT tests there will often be no active vblank reference
but the test expects to read a CRC value. This is valid usage (and
works on i915 since they have a CRC interrupt handler) so the reference
to the vblank should be grabbed while capture is active.

This issue was found running:

igt@kms_plane_multiple@atomic-pipe-b-tiling-none

The pipe-b is the only one in the initial commit and was not previously
active so no vblank reference is grabbed. The vblank interrupt is
not enabled and the test times out.

[How]
Keep a reference to the vblank as long as CRC capture is enabled.
If userspace never explicitly disables it then the reference is
also dropped when removing the CRTC from the context (stream = NULL).

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Reviewed-by: Sun peng Li <Sunpeng.Li@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 42 +++++++++----------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0040605cace8..83c8a0407537 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4997,10 +4997,22 @@ static int amdgpu_dm_atomic_commit(struct drm_device *dev,
 	 */
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		struct dm_crtc_state *dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+		struct dm_crtc_state *dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
-		if (drm_atomic_crtc_needs_modeset(new_crtc_state) && dm_old_crtc_state->stream)
+		if (drm_atomic_crtc_needs_modeset(new_crtc_state)
+		    && dm_old_crtc_state->stream) {
+			/*
+			 * CRC capture was enabled but not disabled.
+			 * Release the vblank reference.
+			 */
+			if (dm_new_crtc_state->crc_enabled) {
+				drm_crtc_vblank_put(crtc);
+				dm_new_crtc_state->crc_enabled = false;
+			}
+
 			manage_dm_interrupts(adev, acrtc, false);
+		}
 	}
 	/*
 	 * Add check here for SoC's that support hardware cursor plane, to
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index f088ac585978..26b651148c67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -66,6 +66,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 {
 	struct dm_crtc_state *crtc_state = to_dm_crtc_state(crtc->state);
 	struct dc_stream_state *stream_state = crtc_state->stream;
+	bool enable;
 
 	enum amdgpu_dm_pipe_crc_source source = dm_parse_crc_source(src_name);
 
@@ -80,28 +81,27 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 		return -EINVAL;
 	}
 
+	enable = (source == AMDGPU_DM_PIPE_CRC_SOURCE_AUTO);
+
+	if (!dc_stream_configure_crc(stream_state->ctx->dc, stream_state,
+				     enable, enable))
+		return -EINVAL;
+
 	/* When enabling CRC, we should also disable dithering. */
-	if (source == AMDGPU_DM_PIPE_CRC_SOURCE_AUTO) {
-		if (dc_stream_configure_crc(stream_state->ctx->dc,
-					    stream_state,
-					    true, true)) {
-			crtc_state->crc_enabled = true;
-			dc_stream_set_dither_option(stream_state,
-						    DITHER_OPTION_TRUN8);
-		}
-		else
-			return -EINVAL;
-	} else {
-		if (dc_stream_configure_crc(stream_state->ctx->dc,
-					    stream_state,
-					    false, false)) {
-			crtc_state->crc_enabled = false;
-			dc_stream_set_dither_option(stream_state,
-						    DITHER_OPTION_DEFAULT);
-		}
-		else
-			return -EINVAL;
-	}
+	dc_stream_set_dither_option(stream_state,
+				    enable ? DITHER_OPTION_TRUN8
+					   : DITHER_OPTION_DEFAULT);
+
+	/*
+	 * Reading the CRC requires the vblank interrupt handler to be
+	 * enabled. Keep a reference until CRC capture stops.
+	 */
+	if (!crtc_state->crc_enabled && enable)
+		drm_crtc_vblank_get(crtc);
+	else if (crtc_state->crc_enabled && !enable)
+		drm_crtc_vblank_put(crtc);
+
+	crtc_state->crc_enabled = enable;
 
 	/* Reset crc_skipped on dm state */
 	crtc_state->crc_skip_count = 0;
-- 
2.19.1



