Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0E1C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F89D20673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344523;
	bh=YhMxZFoY6IL1aOj/xsge9Nvb1sMx8PA81BVaG9x7qes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uc4+pRZ7GDiyhT+ppu7tuLMIKsaJUQFEcMGOuR7BMIkErI2hyN5UcKBqby/33wyzT
	 8sW02CgWcOjKc2fTFI6xDXuCrhJ5K1NzML9G9RhlCBZ7iqhi8A5hMrUsbv2UsVi3MS
	 tFpJkOoReyzhG5bMLrGadaMx/fgGgKCkjAofd7oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632876AbfIXQnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409852AbfIXQmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:42:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 115B4217F4;
        Tue, 24 Sep 2019 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343365;
        bh=YhMxZFoY6IL1aOj/xsge9Nvb1sMx8PA81BVaG9x7qes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iw9cy7aldZbXmWlIU8gSG8xe7tHvB0CqlwjC9RpvuVvTGI0vAOFuwa75L41lTKcnn
         6LqbRxz2NcM8dO0bjSRrE6lrwWAoYCr1Zk94AKWX/2OxP/hvbkFuvVgVAhsOHGP1gu
         SDUeQr40oWJwy3SI0EDGPcoJz9iwhf9PBunYp09o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.3 20/87] drm/amd/display: Use proper enum conversion functions
Date:   Tue, 24 Sep 2019 12:40:36 -0400
Message-Id: <20190924164144.25591-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164144.25591-1-sashal@kernel.org>
References: <20190924164144.25591-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit d196bbbc28fab82624f7686f8b0da8e8644b6e6a ]

clang warns:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:336:8:
warning: implicit conversion from enumeration type 'enum smu_clk_type'
to different enumeration type 'enum amd_pp_clock_type'
[-Wenum-conversion]
                                        dc_to_smu_clock_type(clk_type),
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:421:14:
warning: implicit conversion from enumeration type 'enum
amd_pp_clock_type' to different enumeration type 'enum smu_clk_type'
[-Wenum-conversion]
                                        dc_to_pp_clock_type(clk_type),
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are functions to properly convert between all of these types, use
them so there are no longer any warnings.

Fixes: a43913ea50a5 ("drm/amd/powerplay: add function get_clock_by_type_with_latency for navi10")
Fixes: e5e4e22391c2 ("drm/amd/powerplay: add interface to get clock by type with latency for display (v2)")
Link: https://github.com/ClangBuiltLinux/linux/issues/586
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 592fa499c9f86..9594c154664fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -334,7 +334,7 @@ bool dm_pp_get_clock_levels_by_type(
 		}
 	} else if (adev->smu.funcs && adev->smu.funcs->get_clock_by_type) {
 		if (smu_get_clock_by_type(&adev->smu,
-					  dc_to_smu_clock_type(clk_type),
+					  dc_to_pp_clock_type(clk_type),
 					  &pp_clks)) {
 			get_default_clock_levels(clk_type, dc_clks);
 			return true;
@@ -419,7 +419,7 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
 			return false;
 	} else if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->get_clock_by_type_with_latency) {
 		if (smu_get_clock_by_type_with_latency(&adev->smu,
-						       dc_to_pp_clock_type(clk_type),
+						       dc_to_smu_clock_type(clk_type),
 						       &pp_clks))
 			return false;
 	}
-- 
2.20.1

