Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9631ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51372168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569949071;
	bh=l62JA0cwp5myrRm3ZVR1pkjHrtwy9H/0KLao1eRcjkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lahP/m1hoGhudGm8jr5/a869HuAoh4LGl51lLL6BxsC4XY0c7qEi6wzzGprLbsCg4
	 aaUZYUfZ/ACjKb30514rGfvWfRNGKepwlS5ekxUh2Cjnbusw9LCQjjQleZafZlKKyO
	 K/vxk+GOSVtRxNFGIDgoslr/w2YNFYn88VPIf6dc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbfJAQ5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731382AbfJAQlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:41:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A502205C9;
        Tue,  1 Oct 2019 16:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948110;
        bh=l62JA0cwp5myrRm3ZVR1pkjHrtwy9H/0KLao1eRcjkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2WdY5b7ceQu2zXVhrOYEGRtcU2r0tHwkfQ1Gn39ZwzmiSxCgxAXrZBrtY+uDv8pJQ
         TcsIiPDU8SzQyyB3jRLp77MSRH9X6AcDaKYOO8QSl0PbsIJdtlJqrnNXDTKrIWiuGy
         CEgonstOSZFgxhj6hje/LSYcAMkL6fvB4tFkmaiQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 18/63] drm/amdgpu: Fix KFD-related kernel oops on Hawaii
Date:   Tue,  1 Oct 2019 12:40:40 -0400
Message-Id: <20191001164125.15398-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164125.15398-1-sashal@kernel.org>
References: <20191001164125.15398-1-sashal@kernel.org>
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

[ Upstream commit dcafbd50f2e4d5cc964aae409fb5691b743fba23 ]

Hawaii needs to flush caches explicitly, submitting an IB in a user
VMID from kernel mode. There is no s_fence in this case.

Fixes: eb3961a57424 ("drm/amdgpu: remove fence context from the job")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index fe393a46f8811..5eed2423dbb5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -141,7 +141,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	/* ring tests don't use a job */
 	if (job) {
 		vm = job->vm;
-		fence_ctx = job->base.s_fence->scheduled.context;
+		fence_ctx = job->base.s_fence ?
+			job->base.s_fence->scheduled.context : 0;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
-- 
2.20.1

