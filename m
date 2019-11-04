Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B5DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E22421D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfKDNUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:20:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729091AbfKDNUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:20:20 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A4006B8CACFE10F20411;
        Mon,  4 Nov 2019 21:20:14 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 21:20:05 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Jammy.Zhou@amd.com>, <tianci.yin@amd.com>, <sam@ravnborg.org>,
        <luben.tuikov@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 7/7] drm/amdgpu: remove set but not used variable 'mc_shared_chmap'
Date:   Mon, 4 Nov 2019 21:27:26 +0800
Message-ID: <1572874046-30996-8-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
References: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: In function
‘gfx_v8_0_gpu_early_init’:
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:1713:6: warning: variable
‘mc_shared_chmap’ set but not used [-Wunused-but-set-variable]

Fixes: 0bde3a95eaa9 ("drm/amdgpu: split gfx8 gpu init into sw and hw parts")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index e4c645d..80b7958 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1710,7 +1710,7 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 static int gfx_v8_0_gpu_early_init(struct amdgpu_device *adev)
 {
 	u32 gb_addr_config;
-	u32 mc_shared_chmap, mc_arb_ramcfg;
+	u32 mc_arb_ramcfg;
 	u32 dimm00_addr_map, dimm01_addr_map, dimm10_addr_map, dimm11_addr_map;
 	u32 tmp;
 	int ret;
@@ -1850,7 +1850,6 @@ static int gfx_v8_0_gpu_early_init(struct amdgpu_device *adev)
 		break;
 	}
 
-	mc_shared_chmap = RREG32(mmMC_SHARED_CHMAP);
 	adev->gfx.config.mc_arb_ramcfg = RREG32(mmMC_ARB_RAMCFG);
 	mc_arb_ramcfg = adev->gfx.config.mc_arb_ramcfg;
 
-- 
2.7.4

