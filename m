Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91754C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D26C20651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqAfxiem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfG3Jrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:47:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36603 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbfG3Jrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:47:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so65099721wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ANM4/Zd8QIP1dzOfHKiDuUC79smC88C4XTPFEhIROxM=;
        b=eqAfxiem3ogDGvKAo9etBm7g6c7HbeT0GJdPC+AkY/dqIxnKC/qmxbm8ljy97WXyDB
         uatToE1f5hnYmItmR5EvFN+No3NU+vLjWIxfl+upXA6xqEjMtKHNa1U0EfzOaP00lkfm
         NT958XuKBel6VAOEJ0RKikooRozV/xu56Pt+yUU8IafmoH5sL22zltnIhUcORZdcPhcW
         IPqZ6Kh1oxrFXal53u4Q+VFpzoDlPZESV+cRVmbL4uQ/AQxfy9lrz4ktzuVvVyVm6Olw
         HGkj6OjgaA6/n6ktH6czfE1jUaHjmU24NfJbd9KgU5EM6rhqReArX2UUHu8ZAJ0xsfwC
         HP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ANM4/Zd8QIP1dzOfHKiDuUC79smC88C4XTPFEhIROxM=;
        b=fQ9GYph29NcBsCjapL2WXIqE4pyV/IG6lwW5cMqYSOMx4Mah6BbqMrzbkVZddOsMKg
         Y0UQR3KXyVLqcurrOjf5/+mYOGp4qdRGeuwNSa7wQnBwXyRn6PG27A5IsgauHuQEtr23
         44rjZ2pZQ1g35sZZKeS5vbaMnl9l03cazxRHb5LIpNO4MZfuLT3LSCMIm71u/7AnXJ9e
         ohq3lgVley63RqlD9uB57dwlEVSBIeOgo10e2suSCJXhb8eEV4nDSyspxDI7PA49nCJ/
         W6ehqT754y89uQReAi3xjqgJFGAP+D5ucQsGPClOc5mKwSAp+AXq5togh029QnJe9Qr7
         nV3Q==
X-Gm-Message-State: APjAAAU5hU5cGuEbhuorctFTw4mzPO2jKVdq+iOnK0I1Ri/3BaloK4V/
        pvJZX/rnnjWuo4ZGjGi2aicgoXtMzE8=
X-Google-Smtp-Source: APXvYqzGeFdrHQ7JXe+MbNyD49YNYTXq2YlUXCrgxJNKps7JemZhZwVyuO4kWMLUvhspLwn25oeM1Q==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr5410355wrw.138.1564480053204;
        Tue, 30 Jul 2019 02:47:33 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k124sm105967360wmk.47.2019.07.30.02.47.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 02:47:32 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v2 4/7] habanalabs: rename user_ctx as compute_ctx
Date:   Tue, 30 Jul 2019 12:47:21 +0300
Message-Id: <20190730094724.18691-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730094724.18691-1-oded.gabbay@gmail.com>
References: <20190730094724.18691-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames the "user_ctx" field in the device structure to
"compute_ctx". This better reflects the meaning of this context.

In addition, we also check in the ctx_fini() that the debug mode should be
disabled only if the context being destroyed is the compute context. This
has no effect right now as we only have a single process and a single
context, but this makes the code more ready for multiple process support.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/context.c    | 13 ++++++++-----
 drivers/misc/habanalabs/debugfs.c    |  4 ++--
 drivers/misc/habanalabs/device.c     | 14 +++++++-------
 drivers/misc/habanalabs/habanalabs.h |  9 ++++-----
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 1d8390418234..bc0dec57a983 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -26,12 +26,13 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 		dma_fence_put(ctx->cs_pending[i]);
 
 	if (ctx->asid != HL_KERNEL_ASID_ID) {
-		/*
-		 * The engines are stopped as there is no executing CS, but the
+		/* The engines are stopped as there is no executing CS, but the
 		 * Coresight might be still working by accessing addresses
 		 * related to the stopped engines. Hence stop it explicitly.
+		 * Stop only if this is the compute context, as there can be
+		 * only one compute context
 		 */
-		if (hdev->in_debug)
+		if ((hdev->in_debug) && (hdev->compute_ctx == ctx))
 			hl_device_set_debug_mode(hdev, false);
 
 		hl_vm_ctx_fini(ctx);
@@ -85,9 +86,11 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 	hl_hpriv_get(hpriv);
 	ctx->hpriv = hpriv;
 
-	/* TODO: remove for multiple contexts */
+	/* TODO: remove for multiple contexts per process */
 	hpriv->ctx = ctx;
-	hdev->user_ctx = ctx;
+
+	/* TODO: remove the following line for multiple process support */
+	hdev->compute_ctx = ctx;
 
 	return 0;
 
diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index 18e499c900c7..2b9bc1c41d40 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -370,7 +370,7 @@ static int mmu_show(struct seq_file *s, void *data)
 	if (dev_entry->mmu_asid == HL_KERNEL_ASID_ID)
 		ctx = hdev->kernel_ctx;
 	else
-		ctx = hdev->user_ctx;
+		ctx = hdev->compute_ctx;
 
 	if (!ctx) {
 		dev_err(hdev->dev, "no ctx available\n");
@@ -533,7 +533,7 @@ static bool hl_is_device_va(struct hl_device *hdev, u64 addr)
 static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr,
 				u64 *phys_addr)
 {
-	struct hl_ctx *ctx = hdev->user_ctx;
+	struct hl_ctx *ctx = hdev->compute_ctx;
 	u64 hop_addr, hop_pte_addr, hop_pte;
 	u64 offset_mask = HOP4_MASK | OFFSET_MASK;
 	int rc = 0;
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index d1bc8f4ed5bb..ca166abee7b5 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -59,7 +59,7 @@ static void hpriv_release(struct kref *ref)
 	atomic_dec(&hdev->fd_open_cnt);
 
 	/* This allows a new user context to open the device */
-	hdev->user_ctx = NULL;
+	hdev->compute_ctx = NULL;
 }
 
 void hl_hpriv_get(struct hl_fpriv *hpriv)
@@ -590,7 +590,7 @@ static void device_kill_open_processes(struct hl_device *hdev)
 	}
 
 	if (atomic_read(&hdev->fd_open_cnt)) {
-		task = get_pid_task(hdev->user_ctx->hpriv->taskpid,
+		task = get_pid_task(hdev->compute_ctx->hpriv->taskpid,
 					PIDTYPE_PID);
 		if (task) {
 			dev_info(hdev->dev, "Killing user processes\n");
@@ -760,9 +760,9 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		hl_cq_reset(hdev, &hdev->completion_queue[i]);
 
 	/* Make sure the context switch phase will run again */
-	if (hdev->user_ctx) {
-		atomic_set(&hdev->user_ctx->thread_ctx_switch_token, 1);
-		hdev->user_ctx->thread_ctx_switch_wait_token = 0;
+	if (hdev->compute_ctx) {
+		atomic_set(&hdev->compute_ctx->thread_ctx_switch_token, 1);
+		hdev->compute_ctx->thread_ctx_switch_wait_token = 0;
 	}
 
 	/* Finished tear-down, starting to re-initialize */
@@ -793,7 +793,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 			goto out_err;
 		}
 
-		hdev->user_ctx = NULL;
+		hdev->compute_ctx = NULL;
 
 		rc = hl_ctx_init(hdev, hdev->kernel_ctx, true);
 		if (rc) {
@@ -970,7 +970,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto mmu_fini;
 	}
 
-	hdev->user_ctx = NULL;
+	hdev->compute_ctx = NULL;
 
 	rc = hl_ctx_init(hdev, hdev->kernel_ctx, true);
 	if (rc) {
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index e41800e68578..53f6b238e6f2 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -905,7 +905,7 @@ struct hl_debug_params {
  * @hdev: habanalabs device structure.
  * @filp: pointer to the given file structure.
  * @taskpid: current process ID.
- * @ctx: current executing context.
+ * @ctx: current executing context. TODO: remove for multiple ctx per process
  * @ctx_mgr: context manager to handle multiple context for this FD.
  * @cb_mgr: command buffer manager to handle multiple buffers for this FD.
  * @debugfs_list: list of relevant ASIC debugfs.
@@ -916,7 +916,7 @@ struct hl_fpriv {
 	struct hl_device	*hdev;
 	struct file		*filp;
 	struct pid		*taskpid;
-	struct hl_ctx		*ctx; /* TODO: remove for multiple ctx */
+	struct hl_ctx		*ctx;
 	struct hl_ctx_mgr	ctx_mgr;
 	struct hl_cb_mgr	cb_mgr;
 	struct list_head	debugfs_list;
@@ -1182,7 +1182,7 @@ struct hl_device_reset_work {
  * @hl_debugfs: device's debugfs manager.
  * @cb_pool: list of preallocated CBs.
  * @cb_pool_lock: protects the CB pool.
- * @user_ctx: current user context executing.
+ * @compute_ctx: current compute context executing.
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -1259,8 +1259,7 @@ struct hl_device {
 	struct list_head		cb_pool;
 	spinlock_t			cb_pool_lock;
 
-	/* TODO: remove user_ctx for multiple process support */
-	struct hl_ctx			*user_ctx;
+	struct hl_ctx			*compute_ctx;
 
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
-- 
2.17.1

