Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0A7C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED7B24696
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012081;
	bh=R3MtLN1Rj4wCOGDlYX0wo0g3yFmfhogzVgnOrcaB29Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FwgCNZrOjJ+si9YieyM5QmAqDi7VYZSn1TxsKFBX7gHNz9ABMxqHDv3blPFBVcduC
	 //k1558hJKs0GDy4tXx2YJZstj+u+n89rZWZ/oSOjmnFzxHOIdixiV52y/Y6OlONJ9
	 ZNUFVUQ5HiPZshgz6vINk+AO/Fg409IzhNYQpqPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfLJVIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:08:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfLJVH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:07:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A522468E;
        Tue, 10 Dec 2019 21:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012075;
        bh=R3MtLN1Rj4wCOGDlYX0wo0g3yFmfhogzVgnOrcaB29Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdn1ehEhzZgeJSGnJm49W5hpc9b23gpjFBw+FoDcPqLXu4kfALMKe2Drrw9T5Mu6i
         n7IGjLTINvjEsVRN+4fN83xmwbIdov16JsBI/T4z6joLE/wQ/lgRfZCuUtBfUEHzQI
         XWXLp1A46Z18+vXK5fxeXGH1641Hh03xeUo5AUK4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     chen gong <curry.gong@amd.com>, Aaron Liu <aaron.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 055/350] drm/amd/powerplay: A workaround to GPU RESET on APU
Date:   Tue, 10 Dec 2019 16:02:40 -0500
Message-Id: <20191210210735.9077-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chen gong <curry.gong@amd.com>

[ Upstream commit 068ad870bbd8f4f2c5b2fd4977a4f3330c9988f4 ]

Changes to function "smu_suspend" in amdgpu_smu.c is a workaround.

We should get real information about if baco is enabled or not, while we
always consider APU SMU feature as enabled in current code.

I know APU do not support baco mode for GPU reset, so I use
"adev->flags" to skip function "smu_feature_is_enabled".

Signed-off-by: chen gong <curry.gong@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 4acf139ea0140..58c091ab67b26 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1344,7 +1344,10 @@ static int smu_suspend(void *handle)
 	int ret;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
-	bool baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
+	bool baco_feature_is_enabled = false;
+
+	if(!(adev->flags & AMD_IS_APU))
+		baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
 
 	ret = smu_system_features_control(smu, false);
 	if (ret)
-- 
2.20.1

