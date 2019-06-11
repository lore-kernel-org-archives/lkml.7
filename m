Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E288CC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E242089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyzgLG06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404047AbfFKFvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:51:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38649 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390485AbfFKFuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:50:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so11448798wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 22:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4zBKFHoIg15/9/uWxHB8RusJhUniU4+YU9+6RV52dnE=;
        b=VyzgLG06PJguGa21NCzXgYbQZS5lQgbtdpZr17vF4Z4e6jaVbGYEM2z3BbkAlw/uzx
         CFrWN0YNCfNjX8aZgUc491q2vb+uZYHnzzEHWOrz0wzenx/Q7EEN/EmHmF4UgZAPGSSG
         tOVcL2cs2Iuf8WrgcM62quaIC0Cvsb5CG0TEUupNw5Si1nTKRiOGsbcCRA9P3UyK9DC1
         fMoV4jpLKfciUCosmzs7B+nKy2OHptXBDJAMo1DvefsNlNXa7JK137QTCKZypyy891Qy
         +mcdh0Ob8OUlBnP/LQelX/SUjrASuJxo8e9+METHjRyCupK3vfcVsa9A40e/I72bdyZ3
         dRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4zBKFHoIg15/9/uWxHB8RusJhUniU4+YU9+6RV52dnE=;
        b=tHWZy+xJplESB+jVMcPpVqNp4Tu1CzqUYYxwr3JfYL94qvsbwK5rD07VEzxAip/0br
         NO4ZzO/zI/3hP6hj4XiLnLvxUwgWd33PBiy1yZUCUfNrtLpkL28386y1//Wk9ai+TF2x
         fUPYYRq67oi/bN7VTZ/fi0/uAHJUmXXHPtV+zTJYHLt+TmlreISZVGLNxEaCLS9KO3md
         gRwlUU8QsidpdwuQXop8A3FHnYGEnmgP6RiuvUzt3/NujRvZEvzHtehgDNzkm0fKwZJC
         eYHYv6Znj9qu+FcnNEw323OafRVgKW/5fWI96JNe7LP90qnEo31YweVkJFQ3pIZl2top
         bEYg==
X-Gm-Message-State: APjAAAVPu6CxZBdRKvK5t1rK3Mm2cZNyq55e97NH2rCsEuxAdH9DWlxx
        hsQ7vqpLf4aiz2Q4TM/WD7TnvePhTRc=
X-Google-Smtp-Source: APXvYqyVHCheapYM1kx4Q9Uwcj5Oq1IX8b/hA0zT+wSKZShSOJsilnQjRReQChBKwdlA7P8X/xQ8HA==
X-Received: by 2002:a5d:4a90:: with SMTP id o16mr25238298wrq.13.1560232250436;
        Mon, 10 Jun 2019 22:50:50 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j8sm11968056wrr.64.2019.06.10.22.50.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 22:50:49 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/8] habanalabs: de-couple MMU and VM module initialization
Date:   Tue, 11 Jun 2019 08:50:39 +0300
Message-Id: <20190611055045.15945-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611055045.15945-1-oded.gabbay@gmail.com>
References: <20190611055045.15945-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch initializes the MMU S/W structures before the VM S/W
structures, instead of doing that as part of the VM S/W initialization.

This is done because we need to configure some MMU mappings for the kernel
context, before the VM is initialized. The VM initialization can't be
moved earlier because it depends on the size of the DRAM, which is
retrieved from the device CPU. Communication with the device CPU will
require the MMU mappings to be configured and hence the de-coupling.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 23 ++++++++++++++++++++---
 drivers/misc/habanalabs/memory.c | 13 +------------
 drivers/misc/habanalabs/mmu.c    |  6 +-----
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 4df8ef88ce2d..0c4894dd9c02 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -745,6 +745,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 
 	if (hard_reset) {
 		hl_vm_fini(hdev);
+		hl_mmu_fini(hdev);
 		hl_eq_reset(hdev, &hdev->event_queue);
 	}
 
@@ -772,6 +773,13 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 			goto out_err;
 		}
 
+		rc = hl_mmu_init(hdev);
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed to initialize MMU S/W after hard reset\n");
+			goto out_err;
+		}
+
 		/* Allocate the kernel context */
 		hdev->kernel_ctx = kzalloc(sizeof(*hdev->kernel_ctx),
 						GFP_KERNEL);
@@ -943,11 +951,18 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto cq_fini;
 	}
 
+	/* MMU S/W must be initialized before kernel context is created */
+	rc = hl_mmu_init(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to initialize MMU S/W structures\n");
+		goto eq_fini;
+	}
+
 	/* Allocate the kernel context */
 	hdev->kernel_ctx = kzalloc(sizeof(*hdev->kernel_ctx), GFP_KERNEL);
 	if (!hdev->kernel_ctx) {
 		rc = -ENOMEM;
-		goto eq_fini;
+		goto mmu_fini;
 	}
 
 	hdev->user_ctx = NULL;
@@ -995,8 +1010,6 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto out_disabled;
 	}
 
-	/* After test_queues, KMD can start sending messages to device CPU */
-
 	rc = device_late_init(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "Failed late initialization\n");
@@ -1042,6 +1055,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 			"kernel ctx is still alive on initialization failure\n");
 free_ctx:
 	kfree(hdev->kernel_ctx);
+mmu_fini:
+	hl_mmu_fini(hdev);
 eq_fini:
 	hl_eq_fini(hdev, &hdev->event_queue);
 cq_fini:
@@ -1146,6 +1161,8 @@ void hl_device_fini(struct hl_device *hdev)
 
 	hl_vm_fini(hdev);
 
+	hl_mmu_fini(hdev);
+
 	hl_eq_fini(hdev, &hdev->event_queue);
 
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 693877e37fd8..42d237cae1dc 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1657,17 +1657,10 @@ int hl_vm_init(struct hl_device *hdev)
 	struct hl_vm *vm = &hdev->vm;
 	int rc;
 
-	rc = hl_mmu_init(hdev);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to init MMU\n");
-		return rc;
-	}
-
 	vm->dram_pg_pool = gen_pool_create(__ffs(prop->dram_page_size), -1);
 	if (!vm->dram_pg_pool) {
 		dev_err(hdev->dev, "Failed to create dram page pool\n");
-		rc = -ENOMEM;
-		goto pool_create_err;
+		return -ENOMEM;
 	}
 
 	kref_init(&vm->dram_pg_pool_refcount);
@@ -1693,8 +1686,6 @@ int hl_vm_init(struct hl_device *hdev)
 
 pool_add_err:
 	gen_pool_destroy(vm->dram_pg_pool);
-pool_create_err:
-	hl_mmu_fini(hdev);
 
 	return rc;
 }
@@ -1724,7 +1715,5 @@ void hl_vm_fini(struct hl_device *hdev)
 		dev_warn(hdev->dev, "dram_pg_pool was not destroyed on %s\n",
 				__func__);
 
-	hl_mmu_fini(hdev);
-
 	vm->init_done = false;
 }
diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index 10aee3141444..87968f32e718 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -385,12 +385,8 @@ static void dram_default_mapping_fini(struct hl_ctx *ctx)
  * @hdev: habanalabs device structure.
  *
  * This function does the following:
- * - Allocate max_asid zeroed hop0 pgts so no mapping is available.
- * - Enable MMU in H/W.
- * - Invalidate the MMU cache.
  * - Create a pool of pages for pgt_infos.
- *
- * This function depends on DMA QMAN to be working!
+ * - Create a shadow table for pgt
  *
  * Return: 0 for success, non-zero for failure.
  */
-- 
2.17.1

