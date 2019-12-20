Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD87C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A4120663
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576852783;
	bh=3CFxgb1XYfVRl4xlSUpQXa/2v8fVOtiV7dJcNuwG3bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NnrteQ7ijyBDYZs/zkdKg5igPQassSJBQ25vJI73nP2FG46GN7LIP7AKlhKqjm1a0
	 IchNIC30YYVmyLHLOVhuz5quGLhfSHM6BXFG7oWV+ErxueU4DgH9snWKad4i/XrZlQ
	 uSnfHVY1pWPro/DQwBRkKmaTdTNsvkFsiHczXCJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLTOaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:30:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbfLTOaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:30:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1023B222C2;
        Fri, 20 Dec 2019 14:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852200;
        bh=3CFxgb1XYfVRl4xlSUpQXa/2v8fVOtiV7dJcNuwG3bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OyeQAaiGbJnTIpqiC3/FDOIUZX5W5bar7SIHnHB8M5CPeRqS0muMwfu0otystF90G
         L2f+RpOfkCXMORDbRhX6Q4IDuP2cXjIgQHhkeUSBmH7oSYVnvCw9yk4Ohcc1LNq5ht
         vQP7S0o8SLBTmCf7woNMTDZI71BKhT/1RpJt7Pmo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guchun Chen <guchun.chen@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 04/52] drm/amdgpu: add check before enabling/disabling broadcast mode
Date:   Fri, 20 Dec 2019 09:29:06 -0500
Message-Id: <20191220142954.9500-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142954.9500-1-sashal@kernel.org>
References: <20191220142954.9500-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit 6e807535dae5dbbd53bcc5e81047a20bf5eb08ea ]

When security violation from new vbios happens, data fabric is
risky to stop working. So prevent the direct access to DF
mmFabricConfigAccessControl from the new vbios and onwards.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 38 ++++++++++++++++------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 5850c8e34caac..97d11d7923514 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -261,23 +261,29 @@ static void df_v3_6_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 {
 	u32 tmp;
 
-	/* Put DF on broadcast mode */
-	adev->df_funcs->enable_broadcast_mode(adev, true);
-
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_DF_MGCG)) {
-		tmp = RREG32_SOC15(DF, 0, mmDF_PIE_AON0_DfGlobalClkGater);
-		tmp &= ~DF_PIE_AON0_DfGlobalClkGater__MGCGMode_MASK;
-		tmp |= DF_V3_6_MGCG_ENABLE_15_CYCLE_DELAY;
-		WREG32_SOC15(DF, 0, mmDF_PIE_AON0_DfGlobalClkGater, tmp);
-	} else {
-		tmp = RREG32_SOC15(DF, 0, mmDF_PIE_AON0_DfGlobalClkGater);
-		tmp &= ~DF_PIE_AON0_DfGlobalClkGater__MGCGMode_MASK;
-		tmp |= DF_V3_6_MGCG_DISABLE;
-		WREG32_SOC15(DF, 0, mmDF_PIE_AON0_DfGlobalClkGater, tmp);
-	}
+	if (adev->cg_flags & AMD_CG_SUPPORT_DF_MGCG) {
+		/* Put DF on broadcast mode */
+		adev->df_funcs->enable_broadcast_mode(adev, true);
+
+		if (enable) {
+			tmp = RREG32_SOC15(DF, 0,
+					mmDF_PIE_AON0_DfGlobalClkGater);
+			tmp &= ~DF_PIE_AON0_DfGlobalClkGater__MGCGMode_MASK;
+			tmp |= DF_V3_6_MGCG_ENABLE_15_CYCLE_DELAY;
+			WREG32_SOC15(DF, 0,
+					mmDF_PIE_AON0_DfGlobalClkGater, tmp);
+		} else {
+			tmp = RREG32_SOC15(DF, 0,
+					mmDF_PIE_AON0_DfGlobalClkGater);
+			tmp &= ~DF_PIE_AON0_DfGlobalClkGater__MGCGMode_MASK;
+			tmp |= DF_V3_6_MGCG_DISABLE;
+			WREG32_SOC15(DF, 0,
+					mmDF_PIE_AON0_DfGlobalClkGater, tmp);
+		}
 
-	/* Exit broadcast mode */
-	adev->df_funcs->enable_broadcast_mode(adev, false);
+		/* Exit broadcast mode */
+		adev->df_funcs->enable_broadcast_mode(adev, false);
+	}
 }
 
 static void df_v3_6_get_clockgating_state(struct amdgpu_device *adev,
-- 
2.20.1

