Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11098C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEE123B6A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfE2PHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:07:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48809 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2PHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:07:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hW0Aw-0004FY-R3; Wed, 29 May 2019 15:07:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Oak Zeng <Oak.Zeng@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdkfd: fix null pointer dereference on dev
Date:   Wed, 29 May 2019 16:07:34 +0100
Message-Id: <20190529150734.18120-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer dev is set to null yet it is being dereferenced when
checking dev->dqm->sched_policy.  Fix this by performing the check
on dev->dqm->sched_policy after dev has been assigned and null
checked.  Also remove the redundant null assignment to dev.

Addresses-Coverity: ("Explicit null dereference")
Fixes: 1a058c337676 ("drm/amdkfd: New IOCTL to allocate queue GWS")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index aab2aa6c1dee..ea82828fdc76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1572,10 +1572,9 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
 {
 	int retval;
 	struct kfd_ioctl_alloc_queue_gws_args *args = data;
-	struct kfd_dev *dev = NULL;
+	struct kfd_dev *dev;
 
-	if (!hws_gws_support ||
-		dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
+	if (!hws_gws_support)
 		return -EINVAL;
 
 	dev = kfd_device_by_id(args->gpu_id);
@@ -1583,6 +1582,8 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
 		pr_debug("Could not find gpu id 0x%x\n", args->gpu_id);
 		return -EINVAL;
 	}
+	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
+		return -EINVAL;
 
 	mutex_lock(&p->mutex);
 	retval = pqm_set_gws(&p->pqm, args->queue_id, args->num_gws ? dev->gws : NULL);
-- 
2.20.1

