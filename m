Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EB5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CA1206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714412;
	bh=PV+ZNkfna2MH+a+qrrQ54e+h3H+BE59K0deX1cA54vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LlflY+w5IutZWtnHaGvog6Ut20CoSFXvMiDp0uLR9SMO/YjXkSriW/PNeYbsvLs/N
	 c7C9vvfBO2h2fQ1YAzMG4lr6cElvCjZMgKIYHn2q12TO1xvoFTj/knxXqMrUFgU0vA
	 1dbthLlLYFJ57ZjAeIMzDX/3XV3HzUXIPxTKwaS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbfC0SH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388165AbfC0SHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:07:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADC52063F;
        Wed, 27 Mar 2019 18:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710044;
        bh=PV+ZNkfna2MH+a+qrrQ54e+h3H+BE59K0deX1cA54vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jiuOP88uKK9shC8pDY8B7DqVlQUaQJrz+Vv9JJy++u+QHfou9l4WFVZtK9zNkRVnQ
         rlFbMT1Jq5fnrC0PFOHZytiM9JToztQxEeNxamdWvo4WNQiLrw1jipP+qcwmFoY/L5
         JX43bGZG1srTMzDHVro6HaH9TlOlpiSUDRGD2C3o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 171/262] drm/amd/display: Don't re-program planes for DPMS changes
Date:   Wed, 27 Mar 2019 14:00:26 -0400
Message-Id: <20190327180158.10245-171-sashal@kernel.org>
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

[ Upstream commit 5062b797db4103218fa00ee254417b8ecaab7401 ]

[Why]
There are opt1c lock warnings and CRTC read timeouts when running the
"igt@kms_plane@plane-position-hole-dpms-pipe-*" tests. These are
caused by trying to reprogram planes that are not in the current
context.

DPMS off removes the stream from the context. In this case:

new_crtc_state->active_changed = true
new_crtc_state->mode_changed = false

The planes are reprogrammed before the stream is removed from the
context because stream_state->mode_changed = false.

For DPMS adds the stream and planes back to the context:

new_crtc_state->active_changed = true
new_crtc_state->mode_changed = false

The planes are also reprogrammed here before the stream is added to the
context because stream_state->mode_changed = true. They were not
previously in the current context so warnings occur here.

[How]
Set stream_state->mode_changed = true when
new_crtc_state->active_changed = true too.

This prevents reprogramming before the context is applied in DC. The
programming will be done after the context is applied.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Sun peng Li <Sunpeng.Li@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6d77fd966dbd..0040605cace8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4975,7 +4975,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 static void amdgpu_dm_crtc_copy_transient_flags(struct drm_crtc_state *crtc_state,
 						struct dc_stream_state *stream_state)
 {
-	stream_state->mode_changed = crtc_state->mode_changed;
+	stream_state->mode_changed =
+		crtc_state->mode_changed || crtc_state->active_changed;
 }
 
 static int amdgpu_dm_atomic_commit(struct drm_device *dev,
-- 
2.19.1

