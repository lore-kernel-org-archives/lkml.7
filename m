Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A65C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC47208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329184;
	bh=U+cyCcziatGq/08m7GKny1aPtLXVy5eQ03V9n6zg9Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2EI6Icm9lI67ZiCtqp+WSBwylTNPJER4MwpLAoHnIo3O6sV6TVjUJVLtR6o/rVYFI
	 FoNb5k2sYB9mXuNDK9//uiDosKfUx8M1dqQKyAPYUAM0ngQxccgrOT+GWv2NUro+5/
	 bgmYZ6x0cZCWo74eir5NLP8xwZxiKjSvTVPLBwPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfD0Bjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbfD0Bjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ACF92146E;
        Sat, 27 Apr 2019 01:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329181;
        bh=U+cyCcziatGq/08m7GKny1aPtLXVy5eQ03V9n6zg9Aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNL62Nf2qMByzuYP6sd4VoiUx0x5cnfS4OMxt9PO0rokKDkVuOK222TDs99tP2x6a
         187pjQ21YvjWnU1cuqtPJ7zkVlRpa7JuRlOWV4IL8toSLsB7Dl0vYcqcuVCjNyKM3G
         HVthiLFYu8CwlLLr5uFOaQWENlKUuD9hYiXmOCC4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     wentalou <Wentao.Lou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 40/79] drm/amdgpu: amdgpu_device_recover_vram always failed if only one node in shadow_list
Date:   Fri, 26 Apr 2019 21:37:59 -0400
Message-Id: <20190427013838.6596-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wentalou <Wentao.Lou@amd.com>

[ Upstream commit 1712fb1a2f6829150032ac76eb0e39b82a549cfb ]

amdgpu_bo_restore_shadow would assign zero to r if succeeded.
r would remain zero if there is only one node in shadow_list.
current code would always return failure when r <= 0.
restart the timeout for each wait was a rather problematic bug as well.
The value of tmo SHOULD be changed, otherwise we wait tmo jiffies on each loop.

Signed-off-by: Wentao Lou <Wentao.Lou@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7ff3a28fc903..d55dd570a702 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3158,11 +3158,16 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 			break;
 
 		if (fence) {
-			r = dma_fence_wait_timeout(fence, false, tmo);
+			tmo = dma_fence_wait_timeout(fence, false, tmo);
 			dma_fence_put(fence);
 			fence = next;
-			if (r <= 0)
+			if (tmo == 0) {
+				r = -ETIMEDOUT;
 				break;
+			} else if (tmo < 0) {
+				r = tmo;
+				break;
+			}
 		} else {
 			fence = next;
 		}
@@ -3173,8 +3178,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 		tmo = dma_fence_wait_timeout(fence, false, tmo);
 	dma_fence_put(fence);
 
-	if (r <= 0 || tmo <= 0) {
-		DRM_ERROR("recover vram bo from shadow failed\n");
+	if (r < 0 || tmo <= 0) {
+		DRM_ERROR("recover vram bo from shadow failed, r is %ld, tmo is %ld\n", r, tmo);
 		return -EIO;
 	}
 
-- 
2.19.1

