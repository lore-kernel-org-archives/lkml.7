Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877FDC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571B62189D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127266;
	bh=Qy8p0t2orEtpqAiJVyCKiKQTIy0DM+ggYlbtmfpPT8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s9qWp7jZAy6gqMwvxi13p+PnACLgEZpzhzUTie/JHLZq8m/U+OZRgf0ovpKku010e
	 U6GMu6qhMBXc2im7byFxWuGqgZ9iyEfh/xO6mPUS8gGywWY9UvJGZb4sJJWF321dcP
	 4/ZK4QxR7RMopj8YOYBqhETj9wiPCrL79TdH0/KE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfHFVeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:34:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfHFVeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:34:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA2E216F4;
        Tue,  6 Aug 2019 21:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127261;
        bh=Qy8p0t2orEtpqAiJVyCKiKQTIy0DM+ggYlbtmfpPT8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aFfuMDYLUPE59dEQ8uL2O2xuaH5IMyfZfW9KNljx78r5tH92bD4XjfGyWv+ETCMSb
         4UMGthAs41iegKbukmzR5Byxf3ZFg8lG1JwhPW1Jdbf8bWh0TkE3ylRcoiE+psN4KH
         nQUjZEv94jEhv9hzCo9iEP1CViS8dyNLmcpQfl9s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <david1.zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 31/59] drm/amdgpu: fix error handling in amdgpu_cs_process_fence_dep
Date:   Tue,  6 Aug 2019 17:32:51 -0400
Message-Id: <20190806213319.19203-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 67d0859e2758ef992fd32499747ce4b1038a63c0 ]

We always need to drop the ctx reference and should check
for errors first and then dereference the fence pointer.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Chunming Zhou <david1.zhou@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2f6239b6be6fe..fe028561dc0e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1093,29 +1093,27 @@ static int amdgpu_cs_process_fence_dep(struct amdgpu_cs_parser *p,
 			return r;
 		}
 
-		fence = amdgpu_ctx_get_fence(ctx, entity,
-					     deps[i].handle);
+		fence = amdgpu_ctx_get_fence(ctx, entity, deps[i].handle);
+		amdgpu_ctx_put(ctx);
+
+		if (IS_ERR(fence))
+			return PTR_ERR(fence);
+		else if (!fence)
+			continue;
 
 		if (chunk->chunk_id == AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES) {
-			struct drm_sched_fence *s_fence = to_drm_sched_fence(fence);
+			struct drm_sched_fence *s_fence;
 			struct dma_fence *old = fence;
 
+			s_fence = to_drm_sched_fence(fence);
 			fence = dma_fence_get(&s_fence->scheduled);
 			dma_fence_put(old);
 		}
 
-		if (IS_ERR(fence)) {
-			r = PTR_ERR(fence);
-			amdgpu_ctx_put(ctx);
+		r = amdgpu_sync_fence(p->adev, &p->job->sync, fence, true);
+		dma_fence_put(fence);
+		if (r)
 			return r;
-		} else if (fence) {
-			r = amdgpu_sync_fence(p->adev, &p->job->sync, fence,
-					true);
-			dma_fence_put(fence);
-			amdgpu_ctx_put(ctx);
-			if (r)
-				return r;
-		}
 	}
 	return 0;
 }
-- 
2.20.1

