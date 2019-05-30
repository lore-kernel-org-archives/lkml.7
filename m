Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58254C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B3124A58
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186681;
	bh=RzkQDFObNYcIiIPGLQTQZaZDCTqXgUmZqo1AGSEvEqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LJ0VsNO39Fu/J04qDwViZZPclP6YGZMEvBau15/R65fMmOqxMD9Ycd8hGBYQcoOjj
	 8TaYjyS5r0dscIErWQdJpGi1giWLQryPwZv14cuqtTLIFDZ6pZIAALeJ+HNRaNdSgM
	 Aa+SORMdhBEL43DFQIkawVemiAYuR+QBfDHFr81g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbfE3DYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731474AbfE3DSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:18:15 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5318624763;
        Thu, 30 May 2019 03:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186294;
        bh=RzkQDFObNYcIiIPGLQTQZaZDCTqXgUmZqo1AGSEvEqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8C1QCqV6sBXb5MKflp2HSQ6PetrV9DKLANQe3MCYpOK4JRll8t0APx74nC+HYJdB
         ydF5RsYUWrmHcZClPuZUiTLjpyWk1JkaedLOHzKIRh/DNTJ6WEMIt6/E24f4AzEJyC
         UuoMVOHQv43X6TtWwEPiAe8Dn0yayaxjPOOYfpFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Sun peng Li <Sunpeng.Li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 254/276] drm/amd/display: Set stream->mode_changed when connectors change
Date:   Wed, 29 May 2019 20:06:52 -0700
Message-Id: <20190530030541.032695304@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b9952f93cd2cf5fca82b06a8179c0f5f7b769e83 ]

[Why]
The kms_plane@plane-position-covered-pipe-*-planes subtests can produce
a sequence of atomic commits such that neither active_changed nor
mode_changed but connectors_changed.

When this happens we remove the old stream from the context and add
a new stream but the new stream doesn't have mode_changed=true set.

This incorrect programming sequence causes CRC mismatches to occur in
the test.

The stream->mode_changed value should be set whenever a new stream
is created.

[How]
A new stream is created whenever drm_atomic_crtc_needs_modeset is true.
We previously covered the active_changed and mode_changed conditions
for the CRTC but connectors_changed is also checked within
drm_atomic_crtc_needs_modeset.

So just use drm_atomic_crtc_needs_modeset directly to determine the
mode_changed flag.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Sun peng Li <Sunpeng.Li@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 76ee2de43ea66..dac7978f5ee1f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4369,8 +4369,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 static void amdgpu_dm_crtc_copy_transient_flags(struct drm_crtc_state *crtc_state,
 						struct dc_stream_state *stream_state)
 {
-	stream_state->mode_changed =
-		crtc_state->mode_changed || crtc_state->active_changed;
+	stream_state->mode_changed = drm_atomic_crtc_needs_modeset(crtc_state);
 }
 
 static int amdgpu_dm_atomic_commit(struct drm_device *dev,
-- 
2.20.1



