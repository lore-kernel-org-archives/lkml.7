Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD9EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D2F206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713143;
	bh=kNxeRssS15Mu3XzNbNieKFZGtWnkMtZdrUFNMnw2dTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=olz25wIqPigtYsiOgfKRl8wmPtwJBYAZ4E0ez86g6hkeNJxApWQysxsITWkNeIVWG
	 sxCarjPNu8nxFt3qvErCDet/TbZ3co9FnVwsfca9rgilqX7c3KYjTREmSGRPU0n6w7
	 WO0RH1uHf1+QVqhofyliqbRwPr2KsPebQT/+2UtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389819AbfC0SPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389266AbfC0SPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1FF6217F9;
        Wed, 27 Mar 2019 18:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710516;
        bh=kNxeRssS15Mu3XzNbNieKFZGtWnkMtZdrUFNMnw2dTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mlh6LRvTRrF2SNIBiTfRyo7wCYibrGF5CRu2m6H2Gp6hYDEE/M0dC5HYfQMlV+MZE
         HGsMlKXoI9e0MP5aEmzE3zWeYGiRB1J4HGYg8O0wBAlLveO1WM0ccu1LQEIMe8pvH6
         jPA6b6ZFviRQ+PwacLCHcuxE30Y/ADiip7Wq8MR8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 153/192] drm/amd/display: Enable vblank interrupt during CRC capture
Date:   Wed, 27 Mar 2019 14:09:45 -0400
Message-Id: <20190327181025.13507-153-sashal@kernel.org>
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
index c57e85f08e23..2b8b892eb846 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4390,10 +4390,22 @@ static int amdgpu_dm_atomic_commit(struct drm_device *dev,
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
 	/* Add check here for SoC's that support hardware cursor plane, to
 	 * unset legacy_cursor_update */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 6a6d977ddd7a..36a0bed9af07 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -51,6 +51,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name,
 {
 	struct dm_crtc_state *crtc_state = to_dm_crtc_state(crtc->state);
 	struct dc_stream_state *stream_state = crtc_state->stream;
+	bool enable;
 
 	enum amdgpu_dm_pipe_crc_source source = dm_parse_crc_source(src_name);
 
@@ -65,28 +66,27 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name,
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
 
 	*values_cnt = 3;
 	/* Reset crc_skipped on dm state */
-- 
2.19.1

