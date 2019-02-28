Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCE1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9A720C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367741;
	bh=WL+ctsMxJivo1IpC+iyz+XlXQndVw9IZtDO8Rn6S6QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y1CjdZdlj0TM4UDoBheqV6375LW2xD2lFUNVaEgxOEkJkByvj8GHNOq5Sl89hP/Cf
	 ouYtecr+JvMGzNXjkoMFewmJpKm/4mgQkEn6OujlyhLd6/4friHGHiiHWdFdPl5dhz
	 d77eFX+MpQBuTnciCSNMDcndkDOWXedsX4FKEa+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbfB1P3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:29:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387788AbfB1PKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:10:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8F58218C3;
        Thu, 28 Feb 2019 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366647;
        bh=WL+ctsMxJivo1IpC+iyz+XlXQndVw9IZtDO8Rn6S6QY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YsSYsMuCCNKPYf6xH+QUNwauLdGxTmIhulbDi1FVQwR81/55gfAT2Vw2dK3w5qiV5
         U/jUprAOltPIa1M9wcQ/tlxTUsgfmcfxv+piZhyGHoEyBFlhZq6fROMgZMfwvop06y
         8xqvPHs7Slel2eGUa5s+GzFn29yMW+4JHOT3qu8c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philip Yang <Philip.Yang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 71/81] drm/amdgpu: use spin_lock_irqsave to protect vm_manager.pasid_idr
Date:   Thu, 28 Feb 2019 10:08:03 -0500
Message-Id: <20190228150813.10256-71-sashal@kernel.org>
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
index 62df4bd0a0fc2..16c83155ef5ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3405,14 +3405,15 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, unsigned int pasid,
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

