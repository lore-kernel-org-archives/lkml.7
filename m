Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CB3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8853208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/32zJbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfGaM7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:59:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37654 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfGaM7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:59:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so44506450wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ANM4/Zd8QIP1dzOfHKiDuUC79smC88C4XTPFEhIROxM=;
        b=m/32zJbDqe/cP10c0PX2hhFYAA0xcR3ngSECPGvo78KqvBGNzmjaR+Iq5hsQBE0y0u
         UByXnfHGnl2J2DZ2BHrAATZN+lEvXMzbD3Umznq6WzO4Z0yP9R5Cp8oETCsYtp5o3s2y
         LARYVP6InDvM02b1F6mjUA1ppEL1+M4T5Wk/P0OQdZASdgcY/KZ16HzJo9MkEYCEJVeC
         OiIBRRFs7GOcVwNCP8fjgKZM+xEGIoMkeycTxvAwszGPDHeCslr0z40wH7s6loWgyhd8
         bXCjWJnTYN6rXy8I9drvVnJWnn84cDmLuAYik+LNUA621qHyJ42A0DWQEVqFTaaWDdTh
         4+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ANM4/Zd8QIP1dzOfHKiDuUC79smC88C4XTPFEhIROxM=;
        b=tWcWjgyhgumBBXagpzbUW89C9QMu1K4Uk//NWH8mbsKP5eZHovFCOwflLqWkDVPxEC
         zAK4PtDVirOMyR0/izwpPvziJ4FyqNSWE4yqXxLeEVVeh8hjtYuQPR2AUX1+K/rj217p
         LXHg2uySIrWsNeZDRBelEtmQXej57GNa6zhRtpgYUoa6mBszy/OCQyRESHAyky0wmcji
         s1+UDxXzdWFT8fm8gfipu95ugmG9Mw38dbOo9d+JDeYf1B9HI3wAQYF6WcgLXWm6Mv2U
         YKi8eMu5TQJOhO+NG1e6PVXQmXT8PiJyZgf52kiJ0lts6S/Hc2gZSP5m4FB2B+B+NKyT
         bjsg==
X-Gm-Message-State: APjAAAVqXKv840N3wh5pXwfRXVXc8jZyZeV6WzO6EAOveZcXkuWJGt0K
        Oi9+ZFQAaWvEdVhGuMv7aLG6weVguRE=
X-Google-Smtp-Source: APXvYqwd8Bw+HfvOdDzpxVRb84W4X57uTyByZfL4/oHHGazW6ggHo9Mn7+jrtJFLkiwDhMbyTsX3hA==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr5874721wrk.98.1564577949128;
        Wed, 31 Jul 2019 05:59:09 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c6sm69247800wma.25.2019.07.31.05.59.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:59:08 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v3 4/7] habanalabs: rename user_ctx as compute_ctx
Date:   Wed, 31 Jul 2019 15:58:58 +0300
Message-Id: <20190731125901.20709-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731125901.20709-1-oded.gabbay@gmail.com>
References: <20190731125901.20709-1-oded.gabbay@gmail.com>
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

