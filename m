Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349ADC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1326C215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfICGSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:18:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfICGSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:18:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 92518136F1EDB68BA3F9;
        Tue,  3 Sep 2019 14:18:05 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 3 Sep 2019 14:17:59 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <zhongjiang@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: remove the redundant null check
Date:   Tue, 3 Sep 2019 14:15:05 +0800
Message-ID: <1567491305-18320-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_remove and kfree has taken the null check in account.
hence it is unnecessary to check it. Just remove the condition.
No functional change.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 5652cc7..cb94627 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1077,8 +1077,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 
 	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
 
-	if (fences)
-		kfree(fences);
+	kfree(fences);
 
 	return 0;
 }
@@ -1103,8 +1102,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 void amdgpu_debugfs_preempt_cleanup(struct amdgpu_device *adev)
 {
-	if (adev->debugfs_preempt)
-		debugfs_remove(adev->debugfs_preempt);
+	debugfs_remove(adev->debugfs_preempt);
 }
 
 #else
-- 
1.7.12.4

