Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A8EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4E0218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366555;
	bh=PfBOmO2EZdFKvGjLQOEzQDiu8VhFGAG7zTdi6f0gHSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U2qWTSB0/p5oZaY++5gQXGzuHtO1Dk69gv4Lu8bIwSV4SGfwGR9QVphyC2SBx0vRG
	 9VvadxO0eSmbtkZ0tKorxDmPOzieEjB/CRz8cvFuDTjXlpb4uP0tyfKeKTfgLPwmk0
	 pI7uCj9cNVlVWp5hZGSuQfo3nZw3D1WDKM3vsogQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbfB1PJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:09:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387438AbfB1PJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9040D206B8;
        Thu, 28 Feb 2019 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366544;
        bh=PfBOmO2EZdFKvGjLQOEzQDiu8VhFGAG7zTdi6f0gHSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQ2pztOLrfREOvkKEIIvkXZBtoyN3ANXr2kdeoQ0u0QAlF87ycPOA1C05DJ2Hdtmo
         bg3oLyKCr71XYRF4nfBjAbZWCmiyhxQRpdKuuH18KUFFTEcZPobA3Kx2d8yBVlQzkX
         +u49opH5syX8bBoXHkqqpXLunXAGDeKF7G1Sw35k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 32/81] drm/amdgpu: Add missing power attribute to APU check
Date:   Thu, 28 Feb 2019 10:07:24 -0500
Message-Id: <20190228150813.10256-32-sashal@kernel.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit dc14eb12f6bb3e779c5461429c1889a339c67aab ]

Add missing power_average to visible check for power
attributes for APUs.  Was missed before.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 59cc678de8c15..bbac15fd8caac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1671,7 +1671,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		effective_mode &= ~S_IWUSR;
 
 	if ((adev->flags & AMD_IS_APU) &&
-	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
+	    (attr == &sensor_dev_attr_power1_average.dev_attr.attr ||
+	     attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
 	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr))
 		return 0;
-- 
2.19.1

