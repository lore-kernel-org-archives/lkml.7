Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CB8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7AC2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369312;
	bh=1XBMWzmyoaSDiyIN1So87avbBwSH5uN/ymx2n/0Gkbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DPyGRJhecg2xizLjvoSTEy9W69G3cZMDVUaMjo1l9YBpG36CqAHD/hjpOlYnj3XgY
	 uTJLlrtX4F70qAzC3fAxcJUAVQxyR9/PY1+VBVdct6O7TV/3b8r/IjvKJ9fS6oIkat
	 KWCm0x2VuWDrbm8grSPwax9GsHL406MAKuefxi04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbfDDJPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387403AbfDDJPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:15:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFF1E2054F;
        Thu,  4 Apr 2019 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369307;
        bh=1XBMWzmyoaSDiyIN1So87avbBwSH5uN/ymx2n/0Gkbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNcFoQ0BSfBb+F4b9lo6HwBBj9laoOQ1hQw0aRJMnk2ADMZsGjCZl2qFsy+fJPqw8
         YFcRkDB7vJqNUNd2kRlf3K+s+uGO4jEhjTqDxRi9Y2OqQ/oCpVJ3N0NwpiOq0/OWm+
         iaTfC7Ks6vgWxwLJ2gOk3kJcBYLblUJTImnaxMeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Sun peng Li <Sunpeng.Li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 161/246] drm/amd/display: Dont re-program planes for DPMS changes
Date:   Thu,  4 Apr 2019 10:47:41 +0200
Message-Id: <20190404084624.807062146@linuxfoundation.org>
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



