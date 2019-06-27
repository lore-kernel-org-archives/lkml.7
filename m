Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1C1C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A00205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfF0HrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:47:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfF0HrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:47:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1D3A0223FB14CDAE4233;
        Thu, 27 Jun 2019 15:47:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Jun 2019 15:46:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <harry.wentland@amd.com>, <tianci.yin@amd.com>,
        <tao.zhou1@amd.com>, <leo.liu@amd.com>, <ray.huang@amd.com>,
        <Jack.Xiao@amd.com>, <Hawking.Zhang@amd.com>,
        <kenneth.feng@amd.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variable 'psp_enabled'
Date:   Thu, 27 Jun 2019 07:53:50 +0000
Message-ID: <20190627075350.86800-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/nv.c: In function 'nv_common_early_init':
drivers/gpu/drm/amd/amdgpu/nv.c:471:7: warning:
 variable 'psp_enabled' set but not used [-Wunused-but-set-variable]

It's not used since inroduction in
commit c6b6a42175f5 ("drm/amdgpu: add navi10 common ip block (v3)")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index af20ffb55c54..8b9fa3db8daa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -468,7 +468,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 
 static int nv_common_early_init(void *handle)
 {
-	bool psp_enabled = false;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	adev->smc_rreg = NULL;
@@ -485,10 +484,6 @@ static int nv_common_early_init(void *handle)
 
 	adev->asic_funcs = &nv_asic_funcs;
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP) &&
-	    (amdgpu_ip_block_mask & (1 << AMD_IP_BLOCK_TYPE_PSP)))
-		psp_enabled = true;
-
 	adev->rev_id = nv_get_rev_id(adev);
 	adev->external_rev_id = 0xff;
 	switch (adev->asic_type) {



