Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE6EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72752217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909332;
	bh=BJUL/fC5NXpEvSqYmaHLYBsDsUSf9XCm3DWQQw8Kd9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cpw51HcdwZi1VM56AFDayeEDqAOFAFF5YbFGD1n+bOIoduxQWI1LfAeQyg+BDB0eq
	 /9R5YM1i0reLhwjrV7jId1ei5dvntu78O+anQlQhGtYa8L38XzLDzdjZXV7Dz9Nfhd
	 D7E+z5Zn6ze3OpxhlOEhS7peDeku7XTRdWsL9Ino=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfC3B2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730539AbfC3B2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:28:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2B42217F5;
        Sat, 30 Mar 2019 01:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909328;
        bh=BJUL/fC5NXpEvSqYmaHLYBsDsUSf9XCm3DWQQw8Kd9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z9ExKVPTZE7GlkhKogFNH1r5YsjxtY+OJ3A5/5xRpbLL4Lt5NfyM3n7R3BqbAEO/s
         qsCf8Ga1BJpRjfLtPlYZ3jNr0RlteUZM9O4QX61sA82itXzh+rLqZigiJR0P7d9rKi
         KB5Yp04ZxKZABBeIQTcz15arKF8BYC5vMQ9DwzuE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     wentalou <Wentao.Lou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 04/25] drm/amdgpu: psp_ring_destroy cause psp->km_ring.ring_mem NULL
Date:   Fri, 29 Mar 2019 21:28:21 -0400
Message-Id: <20190330012842.32091-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012842.32091-1-sashal@kernel.org>
References: <20190330012842.32091-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wentalou <Wentao.Lou@amd.com>

[ Upstream commit 14d20ec7f31ef96a2e7dcf7880b13dde1d473b56 ]

psp_ring_destroy inside psp_load_fw cause psp->km_ring.ring_mem NULL.
Call Trace occurred when psp_cmd_submit.
should be psp_ring_stop instead.

Reviewed-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
Signed-off-by: Wentao Lou <Wentao.Lou@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3a9b48b227ac..a7208ca0bfe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -546,7 +546,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	struct psp_context *psp = &adev->psp;
 
 	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset) {
-		psp_ring_destroy(psp, PSP_RING_TYPE__KM);
+		psp_ring_stop(psp, PSP_RING_TYPE__KM); /* should not destroy ring, only stop */
 		goto skip_memalloc;
 	}
 
-- 
2.19.1

