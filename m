Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47191C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163F720C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367908;
	bh=Z4ZAmPjOotVqEMjpuTB9BtsExFQxt9B9UmAqTG49QSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n9EX/5C4lCNMNiy6PtOWG22PrdVa6fpMPh2laU2bzAX9RAChbUEwbffNUabEpKAU5
	 IbcXoutTlnKYkEZziVNqjr1pwQu0rQCpy20oxjp9lMZTVT0ZnxoRrwR/nuySm5l9RB
	 NZwfRdqghzMO425FnYR15OI3fBwwX6Nl3AWODvak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbfB1Pbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387475AbfB1PJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610B3218CD;
        Thu, 28 Feb 2019 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366551;
        bh=Z4ZAmPjOotVqEMjpuTB9BtsExFQxt9B9UmAqTG49QSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CxNGAYHJOabZEHqOyfY5qga5idU2TI1V+5RdSmWkeWxo7RWpdFmjz+4PJ08fvJpnK
         cusbM90HNug3rK1Q8trpgzk9eHGQvlwS2GwgbQ8nebPze13+iJ/nRc5aODRT3illww
         6qjkkyS+zYNUCs6WQbxD+qQFs5liXh4MzGXSNgAE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 37/81] drm/amdgpu: Transfer fences to dmabuf importer
Date:   Thu, 28 Feb 2019 10:07:29 -0500
Message-Id: <20190228150813.10256-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

[ Upstream commit 6e11ea9de9576a644045ffdc2067c09bc2012eda ]

amdgpu only uses shared-fences internally, but dmabuf importers rely on
implicit write hazard tracking via the reservation_object.fence_excl.
For example, the importer use the write hazard for timing a page flip to
only occur after the exporter has finished flushing its write into the
surface. As such, on exporting a dmabuf, we must either flush all
outstanding fences (for we do not know which are writes and should have
been exclusive) or alternatively create a new exclusive fence that is
the composite of all the existing shared fences, and so will only be
signaled when all earlier fences are signaled (ensuring that we can not
be signaled before the completion of any earlier write).

v2: reservation_object is already locked by amdgpu_bo_reserve()
v3: Replace looping with get_fences_rcu and special case the promotion
of a single shared fence directly to an exclusive fence, bypassing the
fence array.
v4: Drop the fence array ref after assigning to reservation_object

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107341
Testcase: igt/amd_prime/amd-to-i915
References: 8e94a46c1770 ("drm/amdgpu: Attach exclusive fence to prime exported bo's. (v5)")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Reviewed-by: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 59 ++++++++++++++++++++---
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
index e45e929aaab5b..90a5970af4b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
@@ -38,6 +38,7 @@
 #include "amdgpu_gem.h"
 #include <drm/amdgpu_drm.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-fence-array.h>
 
 static const struct dma_buf_ops amdgpu_dmabuf_ops;
 
@@ -189,6 +190,48 @@ amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
 	return ERR_PTR(ret);
 }
 
+static int
+__reservation_object_make_exclusive(struct reservation_object *obj)
+{
+	struct dma_fence **fences;
+	unsigned int count;
+	int r;
+
+	if (!reservation_object_get_list(obj)) /* no shared fences to convert */
+		return 0;
+
+	r = reservation_object_get_fences_rcu(obj, NULL, &count, &fences);
+	if (r)
+		return r;
+
+	if (count == 0) {
+		/* Now that was unexpected. */
+	} else if (count == 1) {
+		reservation_object_add_excl_fence(obj, fences[0]);
+		dma_fence_put(fences[0]);
+		kfree(fences);
+	} else {
+		struct dma_fence_array *array;
+
+		array = dma_fence_array_create(count, fences,
+					       dma_fence_context_alloc(1), 0,
+					       false);
+		if (!array)
+			goto err_fences_put;
+
+		reservation_object_add_excl_fence(obj, &array->base);
+		dma_fence_put(&array->base);
+	}
+
+	return 0;
+
+err_fences_put:
+	while (count--)
+		dma_fence_put(fences[count]);
+	kfree(fences);
+	return -ENOMEM;
+}
+
 /**
  * amdgpu_gem_map_attach - &dma_buf_ops.attach implementation
  * @dma_buf: Shared DMA buffer
@@ -220,16 +263,16 @@ static int amdgpu_gem_map_attach(struct dma_buf *dma_buf,
 
 	if (attach->dev->driver != adev->dev->driver) {
 		/*
-		 * Wait for all shared fences to complete before we switch to future
-		 * use of exclusive fence on this prime shared bo.
+		 * We only create shared fences for internal use, but importers
+		 * of the dmabuf rely on exclusive fences for implicitly
+		 * tracking write hazards. As any of the current fences may
+		 * correspond to a write, we need to convert all existing
+		 * fences on the reservation object into a single exclusive
+		 * fence.
 		 */
-		r = reservation_object_wait_timeout_rcu(bo->tbo.resv,
-							true, false,
-							MAX_SCHEDULE_TIMEOUT);
-		if (unlikely(r < 0)) {
-			DRM_DEBUG_PRIME("Fence wait failed: %li\n", r);
+		r = __reservation_object_make_exclusive(bo->tbo.resv);
+		if (r)
 			goto error_unreserve;
-		}
 	}
 
 	/* pin buffer into GTT */
-- 
2.19.1

