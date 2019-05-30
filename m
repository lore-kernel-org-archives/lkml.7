Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D5EC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4C225095
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189237;
	bh=A61OVX+qhxljkiOkU0eMW39eESdk+BXN3QoFqUVRpco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x5Y6sLYec5ZA2udrlmCD8/t6sql5II8m/7pwf8WafPnSjqnJOu5aaUlGSL0m6o5Aw
	 h8CIoacm5pfHa6bVrgvrF7nDGKXg+7M4HaADGYGThxKMfdxh7oKFYMnOzU/IToHuvv
	 Qp5ec83i/eewUvNlxsW4ayjsSXvbf9xUH4QCgyOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfE3EHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731136AbfE3DRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:30 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCFD323B5C;
        Thu, 30 May 2019 03:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186249;
        bh=A61OVX+qhxljkiOkU0eMW39eESdk+BXN3QoFqUVRpco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gO3EX1Q1N7deQkUi1JSq5EED1ulNKwp7N5vOi32i3+gC7z3k+pOGOz9DE3iQ4QxSV
         JCFmvGCrFkSGHHehkQBTaVppv6DbJl7OKBryvxzOfbNyF03L/Og/d4HRwD9j7lxYwq
         mc3LWpzc9LRwjf6dGwdvj4f5zqv4qQCJ28xIM2Xk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <david1.zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 168/276] drm/amdgpu: fix old fence check in amdgpu_fence_emit
Date:   Wed, 29 May 2019 20:05:26 -0700
Message-Id: <20190530030535.911897710@linuxfoundation.org>
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

[ Upstream commit 3d2aca8c8620346abdba96c6300d2c0b90a1d0cc ]

We don't hold a reference to the old fence, so it can go away
any time we are waiting for it to signal.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Chunming Zhou <david1.zhou@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 24 ++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 7056925eb3860..869ff624b108c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -136,8 +136,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_fence *fence;
-	struct dma_fence *old, **ptr;
+	struct dma_fence __rcu **ptr;
 	uint32_t seq;
+	int r;
 
 	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
 	if (fence == NULL)
@@ -153,15 +154,24 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
 
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
+	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
+		struct dma_fence *old;
+
+		rcu_read_lock();
+		old = dma_fence_get_rcu_safe(ptr);
+		rcu_read_unlock();
+
+		if (old) {
+			r = dma_fence_wait(old, false);
+			dma_fence_put(old);
+			if (r)
+				return r;
+		}
+	}
+
 	/* This function can't be called concurrently anyway, otherwise
 	 * emitting the fence would mess up the hardware ring buffer.
 	 */
-	old = rcu_dereference_protected(*ptr, 1);
-	if (old && !dma_fence_is_signaled(old)) {
-		DRM_INFO("rcu slot is busy\n");
-		dma_fence_wait(old, false);
-	}
-
 	rcu_assign_pointer(*ptr, dma_fence_get(&fence->base));
 
 	*f = &fence->base;
-- 
2.20.1



