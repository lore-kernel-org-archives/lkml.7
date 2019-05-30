Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B814CC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A81F25A06
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191302;
	bh=WnhD0WikZCA8KsreuekS0tDjWF+ALYJdfsPjnlmuy/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fzDqVtOltMhYlgFCouvdro7qHZFGdMKvx8EcuHnE7ECSA6gihEykJ/hdsgG6LHGz5
	 ZigErF+s/tYkj0YflnFnicL8D9cC9s0E7ZOCXlQ6Lbl62BsONnNTWFfLUikMWYnWYs
	 h+o7txGE7SK0M4GCS4qJINjlrkRck8bN1Y98WrbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbfE3Elk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbfE3DMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:24 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D696C218B6;
        Thu, 30 May 2019 03:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185944;
        bh=WnhD0WikZCA8KsreuekS0tDjWF+ALYJdfsPjnlmuy/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TebdDu7gU81CHySkI9DLwP41b1oWV5kPo0DQoNI5WIXyFo3jusaefKJZ0+cXIQbrJ
         Ledud/SlZGVS8ElNElRs6YMQK+r72sBDmuChLbqxD3r5RrsO0TO/WvcB9CkuTa4p7P
         Iv3Ht5V3XbReIcx8vlACRaAV0MfP9/fC9TG87vFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Sun peng Li <Sunpeng.Li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 351/405] drm/amd/display: Set stream->mode_changed when connectors change
Date:   Wed, 29 May 2019 20:05:49 -0700
Message-Id: <20190530030558.419197146@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
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
index b14369ab151f6..0886b36c23447 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4955,8 +4955,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
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



