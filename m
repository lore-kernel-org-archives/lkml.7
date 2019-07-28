Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC3EC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19162075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agVB6vmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfG1L2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:28:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43407 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfG1L2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:28:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so58759239wru.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=w7hL5IXnKLcbjXVANCXxRSng/RzEuJy4AahwQSa/erc=;
        b=agVB6vmLMneT6lsnLVnFSEvtID9wnR0kMXvo1UoGtc4GQn45n5mpqWrPYw8kuMuJZK
         xr6sZeNJtcqJYQwzA7sR+eLphrDA7Q7+AIRzSUiTagd2Hiu87gICXrIKclUasFKiAnpw
         5Mtjmn/pNLZ8JOejLa9FKXHbSN2Wo19h9XdBTgg7NRlu9Gq9g6TqLFYyNuoc/pTRmSHQ
         JwtodBkPh/jXL9UQB1tQTT0Dygr4bJjgnNAb9RTt4fSwcdhNj7MnkPhYJCdGMmC0oGUH
         +kV8lO9OH6RJEpu9TlNSfFFR9rwyWmnzaevI/jKBbgAcVkx+i2K74NGIO+ssdHEzZFb6
         y/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=w7hL5IXnKLcbjXVANCXxRSng/RzEuJy4AahwQSa/erc=;
        b=Z24s2oqA34E6Xsr2Kddi+prZGXgKHbN7gPyM44kMjAWJXPNLUiIXEa0Lpmvnw5/Ugh
         uwkXxzsgHuDG3auedfM8RyIey5Xda6KW6dNPL/zVCi1UUbx7G9qzn0vJN9sXXCLiequp
         fuApvgzFddITbC773XvAiJZeA6cRJpY79UAiWnYfel79/TCxbaCWYAE03eKEL7p7dQM1
         fBs8Xm+DLBMul28Bpns0FAJlzEkfT86MqZi16FCQiIU0EbY6lu0kl64Yd3LcI/HUhWpE
         CTEETZgRnuve/j7wclW/3Wp6DjuV8QnWjHR/i4/xbrL9decX0tZTg1/U+MKqcO8vUmpj
         3G3g==
X-Gm-Message-State: APjAAAXX22UFThRS6Psur8iAcpDpDEaCSHm66lajn4Pkh3a2mrzg/Bw4
        KSF49LKxpmc1RhNUQMFkRKjMdIRtEMM=
X-Google-Smtp-Source: APXvYqxnoqzLpSH7Pvf42K5MJMizod8FtukiiPQ1I5kWmWymwosCgBX6HXqFSdgT/VTj48w5HEEySg==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr47125371wrq.110.1564313308910;
        Sun, 28 Jul 2019 04:28:28 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r12sm69805174wrt.95.2019.07.28.04.28.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 04:28:28 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 6/9] habanalabs: define user context as compute context
Date:   Sun, 28 Jul 2019 14:28:15 +0300
Message-Id: <20190728112818.30397-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190728112818.30397-1-oded.gabbay@gmail.com>
References: <20190728112818.30397-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the definition of the user_ctx field in the device
structure. It renames the field to "compute_context" and adds a couple of
checks:

1. When checking if a context is valid, the calling function must say it
requires a compute context. So valid now means exists + capability.

2. In context lazy creation, if the calling function requires compute
context, and one already exists, we can't create an additional compute
context.

3. When a context finishes, we remove the debug mode, if the device was
set to debug mode. The patch changes this code so the remove will happen
only if the compute context finished.

This patch is in preparation to supporting multiple processes.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_buffer.c     |  2 +-
 drivers/misc/habanalabs/command_submission.c |  4 +-
 drivers/misc/habanalabs/context.c            | 59 +++++++++++++-------
 drivers/misc/habanalabs/debugfs.c            |  4 +-
 drivers/misc/habanalabs/device.c             | 16 +++---
 drivers/misc/habanalabs/goya/goya_hwmgr.c    |  4 +-
 drivers/misc/habanalabs/habanalabs.h         |  7 +--
 drivers/misc/habanalabs/habanalabs_ioctl.c   |  7 ++-
 drivers/misc/habanalabs/memory.c             |  2 +-
 9 files changed, 63 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
index 981caa8ec068..a0409ff38d18 100644
--- a/drivers/misc/habanalabs/command_buffer.c
+++ b/drivers/misc/habanalabs/command_buffer.c
@@ -221,7 +221,7 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 		return -EBUSY;
 	}
 
-	if (!hl_ctx_is_valid(hpriv)) {
+	if (!hl_ctx_is_valid(hpriv, true)) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't execute CB IOCTL, missing a valid context\n");
 		return -EACCES;
diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 56910dee6026..c8de16a3e3ed 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -613,7 +613,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		goto out;
 	}
 
-	if (!hl_ctx_is_valid(hpriv)) {
+	if (!hl_ctx_is_valid(hpriv, true)) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't execute CS IOCTL, missing a valid context\n");
 		return -EACCES;
@@ -765,7 +765,7 @@ int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	u64 seq = args->in.seq;
 	long rc;
 
-	if (!hl_ctx_is_valid(hpriv)) {
+	if (!hl_ctx_is_valid(hpriv, true)) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't execute WAIT_CS IOCTL, missing a valid context\n");
 		return -EACCES;
diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index a4cd47ced94d..57bbe59da9b6 100644
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
@@ -87,7 +88,9 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 
 	/* TODO: remove for multiple contexts per process */
 	hpriv->ctx = ctx;
-	hdev->user_ctx = ctx;
+
+	/* TODO: remove the following line for multiple process support */
+	hdev->compute_ctx = ctx;
 
 	return 0;
 
@@ -196,17 +199,20 @@ struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
 	return fence;
 }
 
-bool hl_ctx_is_valid(struct hl_fpriv *hpriv)
+bool hl_ctx_is_valid(struct hl_fpriv *hpriv, bool requires_compute_ctx)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	bool valid = true;
 	int rc;
 
 	/* First thing, to minimize latency impact, check if context exists.
-	 * If so, exit immediately
+	 * Also check if it matches the requirements. If so, exit immediately
 	 */
-	if (hpriv->ctx)
+	if (hpriv->ctx) {
+		if ((requires_compute_ctx) && (hdev->compute_ctx != hpriv->ctx))
+			return false;
 		return true;
+	}
 
 	mutex_lock(&hdev->lazy_ctx_creation_lock);
 
@@ -215,22 +221,37 @@ bool hl_ctx_is_valid(struct hl_fpriv *hpriv)
 	 * IOCTLs at the same time. In this case, we must protect against double
 	 * creation of a context
 	 */
-	if (!hpriv->ctx) {
-		rc = hl_ctx_create(hdev, hpriv);
-		if (rc) {
-			dev_err(hdev->dev, "Failed to create context %d\n", rc);
+	if (hpriv->ctx) {
+		if ((requires_compute_ctx) && (hdev->compute_ctx != hpriv->ctx))
 			valid = false;
-			goto unlock_mutex;
-		}
+		goto unlock_mutex;
+	}
 
-		/* Device is IDLE at this point so it is legal to change PLLs.
-		 * There is no need to check anything because if the PLL is
-		 * already HIGH, the set function will return without doing
-		 * anything
-		 */
-		hl_device_set_frequency(hdev, PLL_HIGH);
+	/* If we already have a compute context, there is no point
+	 * of creating one in case we are called from ioctl that needs
+	 * a compute context
+	 */
+	if ((hdev->compute_ctx) && (requires_compute_ctx)) {
+		dev_err(hdev->dev,
+			"Can't create new compute context as one already exists\n");
+		valid = false;
+		goto unlock_mutex;
+	}
+
+	rc = hl_ctx_create(hdev, hpriv);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to create context %d\n", rc);
+		valid = false;
+		goto unlock_mutex;
 	}
 
+	/* Device is IDLE at this point so it is legal to change PLLs.
+	 * There is no need to check anything because if the PLL is
+	 * already HIGH, the set function will return without doing
+	 * anything
+	 */
+	hl_device_set_frequency(hdev, PLL_HIGH);
+
 unlock_mutex:
 	mutex_unlock(&hdev->lazy_ctx_creation_lock);
 
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
index efeeaa2dc915..5400e65ba5fa 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -63,7 +63,7 @@ static void hpriv_release(struct kref *ref)
 	kfree(hpriv);
 
 	mutex_lock(&hdev->lazy_ctx_creation_lock);
-	hdev->user_ctx = NULL;
+	hdev->compute_ctx = NULL;
 	mutex_unlock(&hdev->lazy_ctx_creation_lock);
 }
 
@@ -295,7 +295,7 @@ static void set_freq_to_low_job(struct work_struct *work)
 
 	mutex_lock(&hdev->lazy_ctx_creation_lock);
 
-	if (!hdev->user_ctx)
+	if (!hdev->compute_ctx)
 		hl_device_set_frequency(hdev, PLL_LOW);
 
 	mutex_unlock(&hdev->lazy_ctx_creation_lock);
@@ -589,7 +589,7 @@ static void device_kill_open_processes(struct hl_device *hdev)
 	}
 
 	if (!list_empty(&hdev->fpriv_list)) {
-		task = get_pid_task(hdev->user_ctx->hpriv->taskpid,
+		task = get_pid_task(hdev->compute_ctx->hpriv->taskpid,
 					PIDTYPE_PID);
 		if (task) {
 			dev_info(hdev->dev, "Killing user processes\n");
@@ -754,9 +754,9 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
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
@@ -787,7 +787,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 			goto out_err;
 		}
 
-		hdev->user_ctx = NULL;
+		hdev->compute_ctx = NULL;
 
 		rc = hl_ctx_init(hdev, hdev->kernel_ctx, true);
 		if (rc) {
@@ -964,7 +964,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto mmu_fini;
 	}
 
-	hdev->user_ctx = NULL;
+	hdev->compute_ctx = NULL;
 
 	rc = hl_ctx_init(hdev, hdev->kernel_ctx, true);
 	if (rc) {
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index 8522c6e0a25e..0d83660b2860 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -256,9 +256,9 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 
 	mutex_lock(&hdev->lazy_ctx_creation_lock);
 
-	if (hdev->user_ctx) {
+	if (hdev->compute_ctx) {
 		dev_err(hdev->dev,
-			"Can't change PM profile while user context is opened on the device\n");
+			"Can't change PM profile while compute context is opened on the device\n");
 		count = -EPERM;
 		goto unlock_mutex;
 	}
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 589eb40bb95d..6a6c71fd5eef 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1181,7 +1181,7 @@ struct hl_device_reset_work {
  * @fpriv_list: list of file private data structures. Each structure is created
  *              when a user opens the device
  * @fpriv_list_lock: protects the fpriv_list
- * @user_ctx: current user context executing.
+ * @compute_ctx: current compute context executing.
  * @lazy_ctx_creation_lock: lock to protect lazy creation of context
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
@@ -1259,8 +1259,7 @@ struct hl_device {
 	struct list_head		fpriv_list;
 	struct mutex			fpriv_list_lock;
 
-	/* TODO: remove user_ctx for multiple process support */
-	struct hl_ctx			*user_ctx;
+	struct hl_ctx			*compute_ctx;
 	struct mutex			lazy_ctx_creation_lock;
 
 	atomic64_t			dram_used_mem;
@@ -1422,7 +1421,7 @@ int hl_ctx_put(struct hl_ctx *ctx);
 struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq);
 void hl_ctx_mgr_init(struct hl_ctx_mgr *mgr);
 void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr);
-bool hl_ctx_is_valid(struct hl_fpriv *hpriv);
+bool hl_ctx_is_valid(struct hl_fpriv *hpriv, bool requires_compute_ctx);
 
 int hl_device_init(struct hl_device *hdev, struct class *hclass);
 void hl_device_fini(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 60b18af66283..8d84f2ac302d 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -104,7 +104,8 @@ static int dram_usage_info(struct hl_device *hdev, struct hl_info_args *args)
 				prop->dram_base_address);
 	dram_usage.dram_free_mem = (prop->dram_size - dram_kmd_size) -
 					atomic64_read(&hdev->dram_used_mem);
-	dram_usage.ctx_dram_mem = atomic64_read(&hdev->user_ctx->dram_phys_mem);
+	dram_usage.ctx_dram_mem =
+			atomic64_read(&hdev->compute_ctx->dram_phys_mem);
 
 	return copy_to_user(out, &dram_usage,
 		min((size_t) max_size, sizeof(dram_usage))) ? -EFAULT : 0;
@@ -208,7 +209,7 @@ static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 		return -EBUSY;
 	}
 
-	if (!hl_ctx_is_valid(hpriv)) {
+	if (!hl_ctx_is_valid(hpriv, false)) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't execute INFO IOCTL, missing a valid context\n");
 		return -EACCES;
@@ -253,7 +254,7 @@ static int hl_debug_ioctl(struct hl_fpriv *hpriv, void *data)
 		return -EBUSY;
 	}
 
-	if (!hl_ctx_is_valid(hpriv)) {
+	if (!hl_ctx_is_valid(hpriv, true)) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't execute DEBUG IOCTL, missing a valid context\n");
 		return -EACCES;
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index fddbca623bd2..c55243b918c5 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1154,7 +1154,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 		return -EBUSY;
 	}
 
-	if (!hl_ctx_is_valid(hpriv)) {
+	if (!hl_ctx_is_valid(hpriv, true)) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't execute MEMORY IOCTL, missing a valid context\n");
 		return -EACCES;
-- 
2.17.1

