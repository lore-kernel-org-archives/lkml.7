Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF941C04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7913A206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207220;
	bh=bTMDjl5OERlZhmnbj15r+fyRb5JYDrqCCHTDy+GWvlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fN6PK0ES0YPboMUOsYYR7WAgKQr75OyueGCCGEd1BrwDGZf2+qg6PXlsDEKUS1xcn
	 4MHIUZLapwQ7OkEs3ztTnCSflbH9X0vtkL7IZ6lBP4yNJUTltIIf681JJdV5nNvZ5r
	 +PW0kRD3d2RWzKbaeQeoPKMTgijVhd40Ym3a2gMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfEGFdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfEGFda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:33:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D8720C01;
        Tue,  7 May 2019 05:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207209;
        bh=bTMDjl5OERlZhmnbj15r+fyRb5JYDrqCCHTDy+GWvlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWeB0TFRZhc/wNfPlgDfKsQBdQB0YsrXHFlinlS6ULAQmUIX40r3ZK9hizZhpWIW7
         22RMZLxEQgJcCysUIMfz0T4qoEhDsla3J9GRNPUImlZH2PFKzCEiUuHuTRvYpkXTxV
         Wn43PmqkmDgzUxa+E2auwaZN7oG8RxEto2cmCw4w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     wentalou <Wentao.Lou@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 27/99] drm/amdgpu: shadow in shadow_list without tbo.mem.start cause page fault in sriov TDR
Date:   Tue,  7 May 2019 01:31:21 -0400
Message-Id: <20190507053235.29900-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
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

[ Upstream commit b575f10dbd6f84c2c8744ff1f486bfae1e4f6f38 ]

shadow was added into shadow_list by amdgpu_bo_create_shadow.
meanwhile, shadow->tbo.mem was not fully configured.
tbo.mem would be fully configured by amdgpu_vm_sdma_map_table until calling amdgpu_vm_clear_bo.
If sriov TDR occurred between amdgpu_bo_create_shadow and amdgpu_vm_sdma_map_table,
amdgpu_device_recover_vram would deal with shadow without tbo.mem.start.

Signed-off-by: Wentao Lou <Wentao.Lou@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7ff3a28fc903..5336b2c9b615 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3150,6 +3150,7 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 
 		/* No need to recover an evicted BO */
 		if (shadow->tbo.mem.mem_type != TTM_PL_TT ||
+		    shadow->tbo.mem.start == AMDGPU_BO_INVALID_OFFSET ||
 		    shadow->parent->tbo.mem.mem_type != TTM_PL_VRAM)
 			continue;
 
-- 
2.20.1

