Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6380CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B6A20449
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710458;
	bh=qFdjvtJsYcsGZBhr7CtXm9akzcljevN2/HpqJKk4Xio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qHuYc2czYu1lb4GWYcGAA9Bg6jId0up6ebnL5ta50wxUWf5fdZIy4YjJ1I2WJnEaB
	 z9eGHsLS1DRoGgoHa/IdSKTZOZbmbQhGvY6ItUB8oIChrHwVSn4zJ2HugUU1SFXiNb
	 QPdb9RgaOcnlf6PVqVGQaGJuBqgfKmHUxRTl1bcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389592AbfC0SOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389580AbfC0SOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:14:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1098420449;
        Wed, 27 Mar 2019 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710447;
        bh=qFdjvtJsYcsGZBhr7CtXm9akzcljevN2/HpqJKk4Xio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPACDnmKm12K2q5iwuna5P2qFbUtjqhq3/J2EKR48Jaibp17PKfhd1tV3W9VOEiOY
         jE+yReJMLwJ9cRihlRH8dlkLuZUxmzW4imlkFbuSHC2ML5aWnJnrXvjOngnrVERcVq
         N1cp/5xMddAL6oAAfcNa3iQ2715HyCXToCIEIHSI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 124/192] drm/amd/display: Don't re-program planes for DPMS changes
Date:   Wed, 27 Mar 2019 14:09:16 -0400
Message-Id: <20190327181025.13507-124-sashal@kernel.org>
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
index c5ba9128b736..c57e85f08e23 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4368,7 +4368,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
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

