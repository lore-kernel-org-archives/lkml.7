Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA39ECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FD420700
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384254;
	bh=kJPCE82rI93/+BFjcENy+vQCcMAun9/PciZCTpTNdVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JvBswQxw4sOU3f3D40QKh7XWwOSgsR8MJaZrZooCSEmkg/Y2zmPRxt9A/RHZmfX0c
	 XNhfxEZLyRP2v5jpo1Js9U5ItxotNvj6MVY+S/DXTIdLD8cSEfPNclJZAaq/YH4uXZ
	 8Wxxdqj9fS1JvCR1WvUYhTYXc728h+LOFT8oFAT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfJFRkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730289AbfJFRkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:40:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9852053B;
        Sun,  6 Oct 2019 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383608;
        bh=kJPCE82rI93/+BFjcENy+vQCcMAun9/PciZCTpTNdVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hah6bNepqhWg0TLaOjCkDIHU5Gms2+JiPdumr+GwSr14I8cQ9djKEC+I3r6lQvtho
         PS8bGRkkXqFZjh+dYlqnkpJZuBj6hNEkDp/FDYq2Wv99EIaGI8OXbbW9vf2h+jCgLD
         QSGYnPwRES9aHSCPtZKPdlZAX+W0ZBP78wXcRUkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bayan Zabihiyan <bayan.zabihiyan@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 029/166] drm/amd/display: Fix frames_to_insert math
Date:   Sun,  6 Oct 2019 19:19:55 +0200
Message-Id: <20191006171215.490909135@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 7c20171a3b6da..a53666ff6cf89 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -435,6 +435,12 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
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
@@ -887,8 +893,8 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 	struct core_freesync *core_freesync = NULL;
 	unsigned long long nominal_field_rate_in_uhz = 0;
 	unsigned int refresh_range = 0;
-	unsigned int min_refresh_in_uhz = 0;
-	unsigned int max_refresh_in_uhz = 0;
+	unsigned long long min_refresh_in_uhz = 0;
+	unsigned long long max_refresh_in_uhz = 0;
 
 	if (mod_freesync == NULL)
 		return;
@@ -915,7 +921,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		min_refresh_in_uhz = nominal_field_rate_in_uhz;
 
 	if (!vrr_settings_require_update(core_freesync,
-			in_config, min_refresh_in_uhz, max_refresh_in_uhz,
+			in_config, (unsigned int)min_refresh_in_uhz, (unsigned int)max_refresh_in_uhz,
 			in_out_vrr))
 		return;
 
@@ -931,15 +937,15 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
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
@@ -950,17 +956,18 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
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



