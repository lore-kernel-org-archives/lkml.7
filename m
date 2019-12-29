Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87132C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E087206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577643186;
	bh=bnwaV+APOXVAf6E6I0r67RmxP57wiQx1xRomaYSLgvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rTAzJDP8emROFVr4ZKc32ugcK1ZHtVrza78xJC7t7YtdVc7OY7S9MAkVDjZShLSbN
	 4wowaEeQiSM+FVbh3Tg2PAeXpbDsiLdjBUK2nHuQ9dykuEYUUWoNQmJ06eciuxhsUq
	 9EqdN6a4ZZdt1VOSmiWQvyTAQ9AHlOac524Bvmj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbfL2SNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfL2R2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:28:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 717E4222D9;
        Sun, 29 Dec 2019 17:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640527;
        bh=bnwaV+APOXVAf6E6I0r67RmxP57wiQx1xRomaYSLgvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpdyGQ7cWUO6qtOBTCv/GLjRNv5Hpec9XOki6pgIEazCVDnRwgmf0gKJfE9zjTspd
         L7IVRDd9hb9axCb+En/MVBqpAb+W8my+R2NBLzpIslHUNJBFw+1eHovPzK53Qpgq/v
         WI8cX+OvytWW/dqUBmzDwJ3lBXN3xfOreBfH0SME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <david1.zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 031/219] drm/amdgpu: grab the id mgr lock while accessing passid_mapping
Date:   Sun, 29 Dec 2019 18:17:13 +0100
Message-Id: <20191229162513.096198571@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 6817bf283b2b851095825ec7f0e9f10398e09125 ]

Need to make sure that we actually dropping the right fence.
Could be done with RCU as well, but to complicated for a fix.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Chunming Zhou <david1.zhou@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 49fe5084c53d..69fb90d9c485 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -700,10 +700,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_
 		id->oa_base != job->oa_base ||
 		id->oa_size != job->oa_size);
 	bool vm_flush_needed = job->vm_needs_flush;
-	bool pasid_mapping_needed = id->pasid != job->pasid ||
-		!id->pasid_mapping ||
-		!dma_fence_is_signaled(id->pasid_mapping);
 	struct dma_fence *fence = NULL;
+	bool pasid_mapping_needed;
 	unsigned patch_offset = 0;
 	int r;
 
@@ -713,6 +711,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_
 		pasid_mapping_needed = true;
 	}
 
+	mutex_lock(&id_mgr->lock);
+	if (id->pasid != job->pasid || !id->pasid_mapping ||
+	    !dma_fence_is_signaled(id->pasid_mapping))
+		pasid_mapping_needed = true;
+	mutex_unlock(&id_mgr->lock);
+
 	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
 	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
 			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
@@ -752,9 +756,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_
 	}
 
 	if (pasid_mapping_needed) {
+		mutex_lock(&id_mgr->lock);
 		id->pasid = job->pasid;
 		dma_fence_put(id->pasid_mapping);
 		id->pasid_mapping = dma_fence_get(fence);
+		mutex_unlock(&id_mgr->lock);
 	}
 	dma_fence_put(fence);
 
-- 
2.20.1



