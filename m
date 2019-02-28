Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C45C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BAA206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367399;
	bh=03JR7IwOxgBw8gTx3JJURDbxXf1SWfw7LbklhDXanGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mAHi5xC6q7+dCQFEQmvIs64wvSDvAjKzhfBqrb5SXyxJVth/lbLrH7n60zxeshDvr
	 A/t0m5LucZdU7qn0jnlc0FbWWzYWl9xcaEnSDc3FqkDFZ/FA8dulgKfaNOMnmXK6rD
	 qZufzlpMl3yxB/hzgxJMu46R5U27TnRMMWaKscDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbfB1PXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:23:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388410AbfB1PNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC0B218D8;
        Thu, 28 Feb 2019 15:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366804;
        bh=03JR7IwOxgBw8gTx3JJURDbxXf1SWfw7LbklhDXanGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5wKMNy6NRdiXTCXRL+e/5I7Vylk5FfOjO+4/4mErLze/keI+61b24VXTJDAnxsyD
         ksq9TCQg2TLgdhhBnyNuplM5jnU1KqSiQNhQ8aa2I+f4oXfze2+HqvYzAF+w0gPh1T
         mcbhKwyoxGhXID704LXQBaKxVSS1mUl4Im54FFPE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philip Yang <Philip.Yang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 57/64] drm/amdgpu: use spin_lock_irqsave to protect vm_manager.pasid_idr
Date:   Thu, 28 Feb 2019 10:10:58 -0500
Message-Id: <20190228151105.11277-57-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 0a5f49cbf9d6ad3721c16f8a6d823363ea7a160f ]

amdgpu_vm_get_task_info is called from interrupt handler and sched timeout
workqueue, we should use irq version spin_lock to avoid deadlock.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6a84526e20e09..49fe5084c53dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3011,14 +3011,15 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, unsigned int pasid,
 			 struct amdgpu_task_info *task_info)
 {
 	struct amdgpu_vm *vm;
+	unsigned long flags;
 
-	spin_lock(&adev->vm_manager.pasid_lock);
+	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
 
 	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
 	if (vm)
 		*task_info = vm->task_info;
 
-	spin_unlock(&adev->vm_manager.pasid_lock);
+	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
 }
 
 /**
-- 
2.19.1

