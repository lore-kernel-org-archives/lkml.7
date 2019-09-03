Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927C8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE3C23789
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528006;
	bh=99vI5vKcRGeRvP/ZZt4/CfY7lB6MsEgoUTllPFqFQXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v/ib6kk4Sn+N3bHpANX7N91ICA6IWkb9cML0N45NcYT7Ur5jHfUI6namvIl8GQnQG
	 ydUYc2iaGRgZU4eAvoMvFIphdOjZSVbZU9iQzyONRjVYLy9aeeKDCWwdUsCLFLRfIa
	 hHhbgAhL42Z2vLuSe9Zpgh6CFZs1ngwAKlkK04mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfICQ0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730669AbfICQ0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:26:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E647F23789;
        Tue,  3 Sep 2019 16:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567527994;
        bh=99vI5vKcRGeRvP/ZZt4/CfY7lB6MsEgoUTllPFqFQXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dp6fYkyIwKb9eqAotN4S9ZjF3u/UOnXnkQYx8CEwIRlQ4NBV5hESYAsve3r7sA7mW
         /BSJ0hpsHS+ZtWsk2HVaqngz7BLT/GrcUgCjIYTNx7T7PgxiRXMfdWxBovtAIR8fEc
         mlq81XCbAF2u7p8g+M9aaxnQhSGGGJ4oVDx4GVkw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Zhao <yuzhao@google.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 044/167] drm/amdgpu: validate user pitch alignment
Date:   Tue,  3 Sep 2019 12:23:16 -0400
Message-Id: <20190903162519.7136-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit 89f23b6efef554766177bf51aa754bce14c3e7da ]

Userspace may request pitch alignment that is not supported by GPU.
Some requests 32, but GPU ignores it and uses default 64 when cpp is
4. If GEM object is allocated based on the smaller alignment, GPU
DMA will go out of bound.

Cc: stable@vger.kernel.org # v4.2+
Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 686a26de50f91..6e67814d33e29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -527,6 +527,16 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	struct amdgpu_framebuffer *amdgpu_fb;
 	int ret;
+	struct amdgpu_device *adev = dev->dev_private;
+	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
+	int pitch = mode_cmd->pitches[0] / cpp;
+
+	pitch = amdgpu_align_pitch(adev, pitch, cpp, false);
+	if (mode_cmd->pitches[0] != pitch) {
+		DRM_DEBUG_KMS("Invalid pitch: expecting %d but got %d\n",
+			      pitch, mode_cmd->pitches[0]);
+		return ERR_PTR(-EINVAL);
+	}
 
 	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
 	if (obj ==  NULL) {
-- 
2.20.1

