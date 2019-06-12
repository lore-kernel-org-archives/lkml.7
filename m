Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3FFC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34532208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmwopensource.org header.i=@vmwopensource.org header.b="HEcT6FRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405834AbfFLGnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:43:13 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:45115 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405238AbfFLGnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:43:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 980A43F77E;
        Wed, 12 Jun 2019 08:43:07 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=vmwopensource.org header.i=@vmwopensource.org header.b=HEcT6FRl;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=vmwopensource.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 82HW1eMRicMf; Wed, 12 Jun 2019 08:42:55 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 99D7D3F73B;
        Wed, 12 Jun 2019 08:42:55 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 64AC5361DE1;
        Wed, 12 Jun 2019 08:42:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vmwopensource.org;
        s=mail; t=1560321775;
        bh=0OCS847VhF4p4ZkW88dxoqjOEDCCvJZwECAtiDuXG38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEcT6FRl96Oti2vfo1au7HaYQIZd1ikUUWFZsInKGH+8hBQXO5C9golKJiRFTaVlg
         evxHIXgPLCaPw3eleCg+RttlucGwrJBA6O2PqTeP40bZRbsnTGRLsu6L17HfE4s8Cf
         uMbPOvU2dD4CsaI0y6XnkcoN1q6BByhUOXfzCsFs=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thellstrom@vmwopensource.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org, nadav.amit@gmail.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v5 4/9] drm/ttm: Allow the driver to provide the ttm struct vm_operations_struct
Date:   Wed, 12 Jun 2019 08:42:38 +0200
Message-Id: <20190612064243.55340-5-thellstrom@vmwopensource.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190612064243.55340-1-thellstrom@vmwopensource.org>
References: <20190612064243.55340-1-thellstrom@vmwopensource.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Add a pointer to the struct vm_operations_struct in the bo_device, and
assign that pointer to the default value currently used.

The driver can then optionally modify that pointer and the new value
can be used for each new vma created.

Cc: "Christian König" <christian.koenig@amd.com>

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c    | 1 +
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 6 +++---
 include/drm/ttm/ttm_bo_driver.h | 6 ++++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index c7de667d482a..6953dd264172 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1739,6 +1739,7 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
 	mutex_lock(&ttm_global_mutex);
 	list_add_tail(&bdev->device_list, &glob->device_list);
 	mutex_unlock(&ttm_global_mutex);
+	bdev->vm_ops = &ttm_bo_vm_ops;
 
 	return 0;
 out_no_sys:
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 6dacff49c1cc..196e13a0adad 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -395,7 +395,7 @@ static int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
 	return ret;
 }
 
-static const struct vm_operations_struct ttm_bo_vm_ops = {
+const struct vm_operations_struct ttm_bo_vm_ops = {
 	.fault = ttm_bo_vm_fault,
 	.open = ttm_bo_vm_open,
 	.close = ttm_bo_vm_close,
@@ -448,7 +448,7 @@ int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
 	if (unlikely(ret != 0))
 		goto out_unref;
 
-	vma->vm_ops = &ttm_bo_vm_ops;
+	vma->vm_ops = bdev->vm_ops;
 
 	/*
 	 * Note: We're transferring the bo reference to
@@ -480,7 +480,7 @@ int ttm_fbdev_mmap(struct vm_area_struct *vma, struct ttm_buffer_object *bo)
 
 	ttm_bo_get(bo);
 
-	vma->vm_ops = &ttm_bo_vm_ops;
+	vma->vm_ops = bo->bdev->vm_ops;
 	vma->vm_private_data = bo;
 	vma->vm_flags |= VM_MIXEDMAP;
 	vma->vm_flags |= VM_IO | VM_DONTEXPAND;
diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index c9b8ba492f24..a2d810a2504d 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -442,6 +442,9 @@ extern struct ttm_bo_global {
  * @driver: Pointer to a struct ttm_bo_driver struct setup by the driver.
  * @man: An array of mem_type_managers.
  * @vma_manager: Address space manager
+ * @vm_ops: Pointer to the struct vm_operations_struct used for this
+ * device's VM operations. The driver may override this before the first
+ * mmap() call.
  * lru_lock: Spinlock that protects the buffer+device lru lists and
  * ddestroy lists.
  * @dev_mapping: A pointer to the struct address_space representing the
@@ -460,6 +463,7 @@ struct ttm_bo_device {
 	struct ttm_bo_global *glob;
 	struct ttm_bo_driver *driver;
 	struct ttm_mem_type_manager man[TTM_NUM_MEM_TYPES];
+	const struct vm_operations_struct *vm_ops;
 
 	/*
 	 * Protected by internal locks.
@@ -488,6 +492,8 @@ struct ttm_bo_device {
 	bool no_retry;
 };
 
+extern const struct vm_operations_struct ttm_bo_vm_ops;
+
 /**
  * struct ttm_lru_bulk_move_pos
  *
-- 
2.20.1

