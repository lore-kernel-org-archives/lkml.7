Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE21C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC23206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013342;
	bh=osEMQ+qjmPG568bwq3Y3oZd6+35Cqc6/K7SPM9SAm24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mMVLk9DY4dUd0O3zA/QnE0XIdym+acCh6DFrPcEft4LZ+mXFIGyoZj3MQFdx1dJa5
	 sh+oKGBNphFkhZl6KiOacjMcYFnfUITmAaSX2ylNZpVkYCZbmrox73QOoQ7VR8eXXh
	 3Aogz0thGqUMEUeZnR9e/4JTDrpL4g/4LfQOs0lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfLJVKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:10:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbfLJVKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 674B8246B6;
        Tue, 10 Dec 2019 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012208;
        bh=osEMQ+qjmPG568bwq3Y3oZd6+35Cqc6/K7SPM9SAm24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYsMBrNUu4O6C739L78hFjOmDIrMbkl1orucS7TJCA0dHrdL34hC7zarEIo9Kuol9
         FRjOier54+NlUano2ImIwidcpO9bdtfaC1xSVIjn7eyGO3+EM03riGZdeJMBo/aaF5
         GWYpyVujBsQ4/+wUY702Nte8YPymU71B8Xz9U2vc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhan liu <zhan.liu@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 160/350] drm/amd/display: setting the DIG_MODE to the correct value.
Date:   Tue, 10 Dec 2019 16:04:25 -0500
Message-Id: <20191210210735.9077-121-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhan liu <zhan.liu@amd.com>

[ Upstream commit 967a3b85bac91c55eff740e61bf270c2732f48b2 ]

[Why]
This patch is for fixing Navi14 HDMI display pink screen issue.

[How]
Call stream->link->link_enc->funcs->setup twice. This is setting
the DIG_MODE to the correct value after having been overridden by
the call to transmitter control.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index efc1d30544bb6..067f5579f4523 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2769,6 +2769,15 @@ void core_link_enable_stream(
 					CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
 					COLOR_DEPTH_UNDEFINED);
 
+		/* This second call is needed to reconfigure the DIG
+		 * as a workaround for the incorrect value being applied
+		 * from transmitter control.
+		 */
+		if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
+			stream->link->link_enc->funcs->setup(
+				stream->link->link_enc,
+				pipe_ctx->stream->signal);
+
 #ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 		if (pipe_ctx->stream->timing.flags.DSC) {
 			if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
-- 
2.20.1

