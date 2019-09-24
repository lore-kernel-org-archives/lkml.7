Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8C7C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4F021D6C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343609;
	bh=V5BW3Dan/eBvQD7BOHMpiAzvf6bQmdaJ66dFqU73JmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WEG1xPrjNe+kpo/TDuS7ROdpt3myy3bc4my3DwvYN7GzvM2Cj35ypA9jGFhAbNwCg
	 5vpP9LwU1E+Mc2/zslnwSsEMpz4dPCY/gMHFSbwyL5gykdZklNjX4DbqLjncxN5aia
	 ctdsWrjGhDgEZVLnSWaq4l+lKtjBlq+gpQtVR6q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410127AbfIXQqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406112AbfIXQqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:46:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DE2C21906;
        Tue, 24 Sep 2019 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343602;
        bh=V5BW3Dan/eBvQD7BOHMpiAzvf6bQmdaJ66dFqU73JmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t0N55C38qtpTQtnDGraF6npd4kGC8Mu6ndPOP6cJBIkS6TCenZSsVcNEZX7jFJpi1
         FGxnLIFkyni2tKoneEB5t4fIM4O+VMMy/bEVGYWzv3hBfG1Mijv7qNB0ci5TXwfjtA
         oqLT8Ks7j0C1E4KXRGKXWoCXzmdXFK8cekq68YHo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bayan Zabihiyan <bayan.zabihiyan@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 23/70] drm/amd/display: Fix frames_to_insert math
Date:   Tue, 24 Sep 2019 12:45:02 -0400
Message-Id: <20190924164549.27058-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164549.27058-1-sashal@kernel.org>
References: <20190924164549.27058-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bayan Zabihiyan <bayan.zabihiyan@amd.com>

[ Upstream commit a463b263032f7c98c5912207db43be1aa34a6438 ]

[Why]
The math on deciding on how many
"frames to insert" sometimes sent us over the max refresh rate.
Also integer overflow can occur if we have high refresh rates.

[How]
Instead of clipping the  frame duration such that it doesn’t go below the min,
just remove a frame from the number of frames to insert. +
Use unsigned long long for intermediate calculations to prevent
integer overflow.

Signed-off-by: Bayan Zabihiyan <bayan.zabihiyan@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/modules/freesync/freesync.c   | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 19b1eaebe4840..000a9db9dad82 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -433,6 +433,12 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 		/* Either we've calculated the number of frames to insert,
 		 * or we need to insert min duration frames
 		 */
+		if (last_render_time_in_us / frames_to_insert <
+				in_out_vrr->min_duration_in_us){
+			frames_to_insert -= (frames_to_insert > 1) ?
+					1 : 0;
+		}
+
 		if (frames_to_insert > 0)
 			inserted_frame_duration_in_us = last_render_time_in_us /
 							frames_to_insert;
@@ -885,8 +891,8 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 	struct core_freesync *core_freesync = NULL;
 	unsigned long long nominal_field_rate_in_uhz = 0;
 	unsigned int refresh_range = 0;
-	unsigned int min_refresh_in_uhz = 0;
-	unsigned int max_refresh_in_uhz = 0;
+	unsigned long long min_refresh_in_uhz = 0;
+	unsigned long long max_refresh_in_uhz = 0;
 
 	if (mod_freesync == NULL)
 		return;
@@ -913,7 +919,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		min_refresh_in_uhz = nominal_field_rate_in_uhz;
 
 	if (!vrr_settings_require_update(core_freesync,
-			in_config, min_refresh_in_uhz, max_refresh_in_uhz,
+			in_config, (unsigned int)min_refresh_in_uhz, (unsigned int)max_refresh_in_uhz,
 			in_out_vrr))
 		return;
 
@@ -929,15 +935,15 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		return;
 
 	} else {
-		in_out_vrr->min_refresh_in_uhz = min_refresh_in_uhz;
+		in_out_vrr->min_refresh_in_uhz = (unsigned int)min_refresh_in_uhz;
 		in_out_vrr->max_duration_in_us =
 				calc_duration_in_us_from_refresh_in_uhz(
-						min_refresh_in_uhz);
+						(unsigned int)min_refresh_in_uhz);
 
-		in_out_vrr->max_refresh_in_uhz = max_refresh_in_uhz;
+		in_out_vrr->max_refresh_in_uhz = (unsigned int)max_refresh_in_uhz;
 		in_out_vrr->min_duration_in_us =
 				calc_duration_in_us_from_refresh_in_uhz(
-						max_refresh_in_uhz);
+						(unsigned int)max_refresh_in_uhz);
 
 		refresh_range = in_out_vrr->max_refresh_in_uhz -
 				in_out_vrr->min_refresh_in_uhz;
@@ -948,17 +954,18 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 	in_out_vrr->fixed.ramping_active = in_config->ramping;
 
 	in_out_vrr->btr.btr_enabled = in_config->btr;
+
 	if (in_out_vrr->max_refresh_in_uhz <
 			2 * in_out_vrr->min_refresh_in_uhz)
 		in_out_vrr->btr.btr_enabled = false;
+
 	in_out_vrr->btr.btr_active = false;
 	in_out_vrr->btr.inserted_duration_in_us = 0;
 	in_out_vrr->btr.frames_to_insert = 0;
 	in_out_vrr->btr.frame_counter = 0;
 	in_out_vrr->btr.mid_point_in_us =
-			in_out_vrr->min_duration_in_us +
-				(in_out_vrr->max_duration_in_us -
-				in_out_vrr->min_duration_in_us) / 2;
+				(in_out_vrr->min_duration_in_us +
+				 in_out_vrr->max_duration_in_us) / 2;
 
 	if (in_out_vrr->state == VRR_STATE_UNSUPPORTED) {
 		in_out_vrr->adjust.v_total_min = stream->timing.v_total;
-- 
2.20.1

