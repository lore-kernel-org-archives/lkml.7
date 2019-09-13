Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CEEC4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F09620644
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="dNNHULGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbfIMJck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:32:40 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:36584 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387770AbfIMJcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:32:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 5B3913F58A;
        Fri, 13 Sep 2019 11:32:31 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=dNNHULGc;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SJPszWSLs_C6; Fri, 13 Sep 2019 11:32:29 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id D31EF3F4D5;
        Fri, 13 Sep 2019 11:32:27 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 880A6360221;
        Fri, 13 Sep 2019 11:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568367147; bh=+gqEjDMVRRxJpdrCVBfIMbPfYpR7zyotcVVYvs8w/Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNNHULGcSysjEpuosNRDO9H1gcQHvEt+eLL3sXYBKyiU4HOHfzczDfmwwjoC8BJlF
         vOvdwr6Qc8HRfxQz7h5JaljSJWbwlBTpPTsYqKiufOOGcFT60Ly5YCTSSz1bSX0V1Z
         kjaliHjPRHOtdCS3Byq9Z+mP0Ci1aDeHFb3vTGtw=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 2/7] drm/ttm: Allow the driver to provide the ttm struct vm_operations_struct
Date:   Fri, 13 Sep 2019 11:32:08 +0200
Message-Id: <20190913093213.27254-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913093213.27254-1-thomas_os@shipmail.org>
References: <20190913093213.27254-1-thomas_os@shipmail.org>
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c    | 1 +
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 6 +++---
 include/drm/ttm/ttm_bo_driver.h | 6 ++++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 20ff56f27aa4..7d11be0bb48c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1751,6 +1751,7 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
 	mutex_lock(&ttm_global_mutex);
 	list_add_tail(&bdev->device_list, &glob->device_list);
 	mutex_unlock(&ttm_global_mutex);
+	bdev->vm_ops = &ttm_bo_vm_ops;
 
 	return 0;
 out_no_sys:
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 76eedb963693..03f702c296cf 100644
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
@@ -449,7 +449,7 @@ int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
 	if (unlikely(ret != 0))
 		goto out_unref;
 
-	vma->vm_ops = &ttm_bo_vm_ops;
+	vma->vm_ops = bdev->vm_ops;
 
 	/*
 	 * Note: We're transferring the bo reference to
@@ -481,7 +481,7 @@ int ttm_fbdev_mmap(struct vm_area_struct *vma, struct ttm_buffer_object *bo)
 
 	ttm_bo_get(bo);
 
-	vma->vm_ops = &ttm_bo_vm_ops;
+	vma->vm_ops = bo->bdev->vm_ops;
 	vma->vm_private_data = bo;
 	vma->vm_flags |= VM_MIXEDMAP;
 	vma->vm_flags |= VM_IO | VM_DONTEXPAND;
diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index 6f536caea368..c1cc0c408e27 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -452,6 +452,9 @@ extern struct ttm_bo_global {
  * @driver: Pointer to a struct ttm_bo_driver struct setup by the driver.
  * @man: An array of mem_type_managers.
  * @vma_manager: Address space manager
+ * @vm_ops: Pointer to the struct vm_operations_struct used for this
+ * device's VM operations. The driver may override this before the first
+ * mmap() call.
  * lru_lock: Spinlock that protects the buffer+device lru lists and
  * ddestroy lists.
  * @dev_mapping: A pointer to the struct address_space representing the
@@ -470,6 +473,7 @@ struct ttm_bo_device {
 	struct ttm_bo_global *glob;
 	struct ttm_bo_driver *driver;
 	struct ttm_mem_type_manager man[TTM_NUM_MEM_TYPES];
+	const struct vm_operations_struct *vm_ops;
 
 	/*
 	 * Protected by internal locks.
@@ -498,6 +502,8 @@ struct ttm_bo_device {
 	bool no_retry;
 };
 
+extern const struct vm_operations_struct ttm_bo_vm_ops;
+
 /**
  * struct ttm_lru_bulk_move_pos
  *
-- 
2.20.1

