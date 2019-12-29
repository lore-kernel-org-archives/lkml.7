Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0ADC2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C65520748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642997;
	bh=/JF+XF9veHgqGuS9llFwwfOop/wr3kRcPLPuSKqkHnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QLW3h4sJfMkFpLqtxA2I2NrpQi5BNND5eRyjgN+buL5oz0psfOasFTuPG68c+BbPH
	 5c2Q9Tg3yLkPPqvafU2/32gjqtPYhMrGBOmmkXxMVXuB/uHXA1mqis9IsxKiuPEKkW
	 aLPPQWqcyFxPUffVA1QGdmH0MbjrWBg0GJpsbK9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfL2RpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:45:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbfL2RpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:45:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00456206DB;
        Sun, 29 Dec 2019 17:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641511;
        bh=/JF+XF9veHgqGuS9llFwwfOop/wr3kRcPLPuSKqkHnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhWj/LUmVO9qJPmREgWl34Ir+la8quYGqBNYdIdJlTi1f0HL0M0nlJTze4MRvPAwX
         fajaEDvxNuLXseUUxTP5ImaIguQpCyYord/HPTQInBk82jgX+5FSeDrn+qmtcwK+sO
         PIg2cDW8FZe2OXywVkwBNy2Cxp4iYdvytwbpMfUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, chen gong <curry.gong@amd.com>,
        Aaron Liu <aaron.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 095/434] drm/amd/powerplay: A workaround to GPU RESET on APU
Date:   Sun, 29 Dec 2019 18:22:28 +0100
Message-Id: <20191229172707.882958211@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 4acf139ea014..58c091ab67b2 100644
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



