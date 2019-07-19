Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73953C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B40420659
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509009;
	bh=KRO6ik8YCwyJSLKtk18n9C4vouT18tTYNZvnBVby8cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BQZhBmo8S++CzHqMr6132yIRlLAuolCVrkUAj8l2K1UCM+w3qddpHLFMZktIckCis
	 Y7ER1P0N5A+L4NiOxhXtNw85o3he2nLXjKcpGVTpn30mzNpCsQelaokKKy7Hx5++/I
	 0HoIwyhaZz8Bs+POOQvYZoA7vXfipoA86QumG9Tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfGSED1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbfGSEDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:03:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5601D21882;
        Fri, 19 Jul 2019 04:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509004;
        bh=KRO6ik8YCwyJSLKtk18n9C4vouT18tTYNZvnBVby8cI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zW01BLgWru7UFvu02T5bMxlxkrif/1zx5SK5rXlS3ulKxBl+epTUGGedCU5o9PRZ5
         7146awWltHFsGTU60kjbq0hRGXUS4+uajV8yrtlsOKOi5NbcwkCbjSJHwYgNuchC2y
         q+fmn5sx6ZEJ6aRYenoqgs0rrwm+ePlH9Wle8yJ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.1 015/141] drm/amdgpu: Reserve shared fence for eviction fence
Date:   Fri, 19 Jul 2019 00:00:40 -0400
Message-Id: <20190719040246.15945-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Kuehling <Felix.Kuehling@amd.com>

[ Upstream commit dd68722c427d5b33420dce0ed0c44b4881e0a416 ]

Need to reserve space for the shared eviction fence when initializing
a KFD VM.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 1921dec3df7a..c7de68c495b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -909,6 +909,9 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	amdgpu_bo_sync_wait(vm->root.base.bo, AMDGPU_FENCE_OWNER_KFD, false);
 	if (ret)
 		goto wait_pd_fail;
+	ret = reservation_object_reserve_shared(vm->root.base.bo->tbo.resv, 1);
+	if (ret)
+		goto reserve_shared_fail;
 	amdgpu_bo_fence(vm->root.base.bo,
 			&vm->process_info->eviction_fence->base, true);
 	amdgpu_bo_unreserve(vm->root.base.bo);
@@ -922,6 +925,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 
 	return 0;
 
+reserve_shared_fail:
 wait_pd_fail:
 validate_pd_fail:
 	amdgpu_bo_unreserve(vm->root.base.bo);
-- 
2.20.1

