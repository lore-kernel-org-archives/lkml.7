Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDD4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0020C20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367814;
	bh=MV4w+y/OomLFNgHsUjw1vhU0dFTnmnwuBKecyGcD4w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R5dABWQMx3a2SQBfrktSMFwe4eq26ld1U9czbTrckR9idyVa0lEpBjagznMb/sEK9
	 ukpOGcSlFqYrbEH9dMuBjmDFDhTOY6I6DyAMpwa4No47xNVaj86hTLF40OxccFIpFt
	 EtT1ALeT2y5IMCAOzGJxel2sOKAO6Lnhldt5D5G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbfB1PaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:30:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732772AbfB1PJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C951206B8;
        Thu, 28 Feb 2019 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366589;
        bh=MV4w+y/OomLFNgHsUjw1vhU0dFTnmnwuBKecyGcD4w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQ3nme5KESHcS8XZc/ls/ifeX4yL4XWOuDNA7LHIJR8/3SVgL3VoBN5p1vUMBvKQq
         weC+X9KgfYlTkLxRY1vKSs6FPaWiUdHNGZ2vI3GwBiFP3wJ82hym0X2HNgEJszhn8v
         /L1Hq3C3HLqmXghhdMQiAUv3lkevoktvjxy4EdKI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 51/81] drm/amdgpu: fix the incorrect external id for raven series
Date:   Thu, 28 Feb 2019 10:07:43 -0500
Message-Id: <20190228150813.10256-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Rui <ray.huang@amd.com>

[ Upstream commit 7e4545d372b560df10fa47281ef0783a479ce435 ]

This patch fixes the incorrect external id that kernel reports to user mode
driver. Raven2's rev_id is starts from 0x8, so its external id (0x81) should
start from rev_id + 0x79 (0x81 - 0x8). And Raven's rev_id should be 0x21 while
rev_id == 1.

Reported-by: Crystal Jin <Crystal.Jin@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 4cc0dcb1a1875..825d1cae85abd 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -705,11 +705,13 @@ static int soc15_common_early_init(void *handle)
 		break;
 	case CHIP_RAVEN:
 		if (adev->rev_id >= 0x8)
-			adev->external_rev_id = adev->rev_id + 0x81;
+			adev->external_rev_id = adev->rev_id + 0x79;
 		else if (adev->pdev->device == 0x15d8)
 			adev->external_rev_id = adev->rev_id + 0x41;
+		else if (adev->rev_id == 1)
+			adev->external_rev_id = adev->rev_id + 0x20;
 		else
-			adev->external_rev_id = 0x1;
+			adev->external_rev_id = adev->rev_id + 0x01;
 
 		if (adev->rev_id >= 0x8) {
 			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-- 
2.19.1

