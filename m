Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B432AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFB42133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367804;
	bh=tkjufyYbcfRV9gYcN7g4+97w+Jt7TnNn3O4Wfh9WKVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lyUDtrgNujaNMdKPS0KprCP0ekirUIuKWW8uScozR+UhIj3vOE2O1Dbk9xin6Ll9O
	 aST/+VIP+FPX2r4IVKcyRldlv3C8G/KzI6iE/7+0mobn6JK+WKO2+YZ09dDQ2VrV4S
	 //pbZ/nRfzyoCeVJJx6I9tftS2Hs/rBSzGPzreKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbfB1PJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:09:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387584AbfB1PJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF0F2206B8;
        Thu, 28 Feb 2019 15:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366585;
        bh=tkjufyYbcfRV9gYcN7g4+97w+Jt7TnNn3O4Wfh9WKVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+EZ3r8AyN5+qdk6QJ/CJXJQ+d/eRgW1rFJ+xoPL5bD5xtiUdPAa2xHtmxMmj4acp
         BShKs509Jq4CxQMjylUqAXOERhhueiFzVP9qbpxNGmySkcepSeUfKpXm9WcBkwiUp1
         ONjHyXZdUeRC8HBScm5QA4uCR/mb3z8GhTvBodu0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jay Cornwall <Jay.Cornwall@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 50/81] drm/amdgpu: Implement doorbell self-ring for NBIO 7.4
Date:   Thu, 28 Feb 2019 10:07:42 -0500
Message-Id: <20190228150813.10256-50-sashal@kernel.org>
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

From: Jay Cornwall <Jay.Cornwall@amd.com>

[ Upstream commit 12292519d919ecde92e7e7c8acbcdb9f0c7c6013 ]

Fixes doorbell reflection on Vega20.

Change-Id: I0495139d160a9032dff5977289b1eec11c16f781
Signed-off-by: Jay Cornwall <Jay.Cornwall@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index f8cee95d61cc1..7d5cbadbe1cbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -92,7 +92,20 @@ static void nbio_v7_4_enable_doorbell_aperture(struct amdgpu_device *adev,
 static void nbio_v7_4_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
 							bool enable)
 {
+	u32 tmp = 0;
 
+	if (enable) {
+		tmp = REG_SET_FIELD(tmp, DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_EN, 1) |
+		      REG_SET_FIELD(tmp, DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_MODE, 1) |
+		      REG_SET_FIELD(tmp, DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_SIZE, 0);
+
+		WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_LOW,
+			     lower_32_bits(adev->doorbell.base));
+		WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_HIGH,
+			     upper_32_bits(adev->doorbell.base));
+	}
+
+	WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_CNTL, tmp);
 }
 
 static void nbio_v7_4_ih_doorbell_range(struct amdgpu_device *adev,
-- 
2.19.1

