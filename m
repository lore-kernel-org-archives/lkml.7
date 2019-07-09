Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D12BC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3700721537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfGIJLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 05:11:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfGIJLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 05:11:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 63CBFAB9524C5EBB45FF;
        Tue,  9 Jul 2019 17:11:10 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 9 Jul 2019
 17:11:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Philip.Yang@amd.com>, <Felix.Kuehling@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] drm/amdgpu: Fix build without CONFIG_HMM_MIRROR
Date:   Tue, 9 Jul 2019 17:10:48 +0800
Message-ID: <20190709091048.35260-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_HMM_MIRROR is not set, building may fails:

In file included from drivers/gpu/drm/amd/amdgpu/amdgpu.h:72:0,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:40:
drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h:69:20: error: field mirror has incomplete type
  struct hmm_mirror mirror;

Fixes: 7590f6d211ec ("drm/amdgpu: Prepare for hmm_range_register API change")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
index 281fd9f..b14f175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
@@ -65,8 +65,10 @@ struct amdgpu_mn {
 	struct rw_semaphore	lock;
 	struct rb_root_cached	objects;
 
+#if defined(CONFIG_HMM_MIRROR)
 	/* HMM mirror */
 	struct hmm_mirror	mirror;
+#endif
 };
 
 #if defined(CONFIG_HMM_MIRROR)
-- 
2.7.4


