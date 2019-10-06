Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2678EC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE37B20862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382587;
	bh=l3BN8vqr6/zyqtmtEAZUgOrafTSH74gWX5X1bQxxev4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jbBBXzNn9ooyesuXGMZu87rM+RMXYuq0f2pGfI1QXHCHgHWGEB4FZjCMfOQE1w9Qd
	 TI5j/KG6kNTV3c0W3Sg2/LsyJr9M/zlAJznBRp9nKlFxWPeqHvijKHnFkRkKglrYot
	 qPLcb8uZ/+TLyrfRQxg2JNy7LY/XMaTfj/H/TGdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfJFRXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfJFRXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:23:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3897A2077B;
        Sun,  6 Oct 2019 17:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382584;
        bh=l3BN8vqr6/zyqtmtEAZUgOrafTSH74gWX5X1bQxxev4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xp9DojpeKGKa8Ei6ni67DNT6ZY1XhFa8FZuIQszYtaBOeo8df09Yh4sWoe78jJO1W
         MXRX0slQ/Man1KdYL78y7THpxwqcNUGcJLNgy8wQJuiXeETbo+nf9iDJbg8IBUPKLU
         bcTKfyuzTp0tYNDvXgOfFt4km9CNhU1BrRtrAJGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
        Ken Wang <Qingqing.Wang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 13/47] drm/amdgpu/si: fix ASIC tests
Date:   Sun,  6 Oct 2019 19:21:00 +0200
Message-Id: <20191006172017.587694543@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006172016.873463083@linuxfoundation.org>
References: <20191006172016.873463083@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <jdelvare@suse.de>

[ Upstream commit 77efe48a729588527afb4d5811b9e0acb29f5e51 ]

Comparing adev->family with CHIP constants is not correct.
adev->family can only be compared with AMDGPU_FAMILY constants and
adev->asic_type is the struct member to compare with CHIP constants.
They are separate identification spaces.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 62a37553414a ("drm/amdgpu: add si implementation v10")
Cc: Ken Wang <Qingqing.Wang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 327bdf13e8bc8..b0beb5e537bcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1606,7 +1606,7 @@ static void si_program_aspm(struct amdgpu_device *adev)
 			if (orig != data)
 				si_pif_phy1_wreg(adev,PB1_PIF_PWRDOWN_1, data);
 
-			if ((adev->family != CHIP_OLAND) && (adev->family != CHIP_HAINAN)) {
+			if ((adev->asic_type != CHIP_OLAND) && (adev->asic_type != CHIP_HAINAN)) {
 				orig = data = si_pif_phy0_rreg(adev,PB0_PIF_PWRDOWN_0);
 				data &= ~PLL_RAMP_UP_TIME_0_MASK;
 				if (orig != data)
@@ -1655,14 +1655,14 @@ static void si_program_aspm(struct amdgpu_device *adev)
 
 			orig = data = si_pif_phy0_rreg(adev,PB0_PIF_CNTL);
 			data &= ~LS2_EXIT_TIME_MASK;
-			if ((adev->family == CHIP_OLAND) || (adev->family == CHIP_HAINAN))
+			if ((adev->asic_type == CHIP_OLAND) || (adev->asic_type == CHIP_HAINAN))
 				data |= LS2_EXIT_TIME(5);
 			if (orig != data)
 				si_pif_phy0_wreg(adev,PB0_PIF_CNTL, data);
 
 			orig = data = si_pif_phy1_rreg(adev,PB1_PIF_CNTL);
 			data &= ~LS2_EXIT_TIME_MASK;
-			if ((adev->family == CHIP_OLAND) || (adev->family == CHIP_HAINAN))
+			if ((adev->asic_type == CHIP_OLAND) || (adev->asic_type == CHIP_HAINAN))
 				data |= LS2_EXIT_TIME(5);
 			if (orig != data)
 				si_pif_phy1_wreg(adev,PB1_PIF_CNTL, data);
-- 
2.20.1



