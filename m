Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F7BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB64620449
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbfGZOBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:01:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388063AbfGZOBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:01:19 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4C8AA138C88EDF28DD48;
        Fri, 26 Jul 2019 22:01:13 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 22:01:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oded.gabbay@gmail.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] drm/amdkfd: remove set but not used variable 'pdd'
Date:   Fri, 26 Jul 2019 22:00:54 +0800
Message-ID: <20190726140054.31388-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c: In function restore_process_worker:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:949:29: warning:
 variable pdd set but not used [-Wunused-but-set-variable]

It is not used since
commit 5b87245faf57 ("drm/amdkfd: Simplify kfd2kgd interface")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 8f1076c..240bf68 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1042,7 +1042,6 @@ static void restore_process_worker(struct work_struct *work)
 {
 	struct delayed_work *dwork;
 	struct kfd_process *p;
-	struct kfd_process_device *pdd;
 	int ret = 0;
 
 	dwork = to_delayed_work(work);
@@ -1051,16 +1050,6 @@ static void restore_process_worker(struct work_struct *work)
 	 * lifetime of this thread, kfd_process p will be valid
 	 */
 	p = container_of(dwork, struct kfd_process, restore_work);
-
-	/* Call restore_process_bos on the first KGD device. This function
-	 * takes care of restoring the whole process including other devices.
-	 * Restore can fail if enough memory is not available. If so,
-	 * reschedule again.
-	 */
-	pdd = list_first_entry(&p->per_device_data,
-			       struct kfd_process_device,
-			       per_device_list);
-
 	pr_debug("Started restoring pasid %d\n", p->pasid);
 
 	/* Setting last_restore_timestamp before successful restoration.
-- 
2.7.4


