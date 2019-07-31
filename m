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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A30CC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE600208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHRmkQv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbfGaM7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:59:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33268 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbfGaM7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:59:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so69679384wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=aAEVmWqvALOO+JUR+K+CV/nXItdRHXcH186YESeRPnY=;
        b=HHRmkQv4jo4EmgstzOClVEgCFj3DHp5tTYJJM1ff2qJVYIChmIzDbMNa4Tr4LVIXR+
         xXfPNW2inltpQxDHUToKWg4Xj6lrL1RUOLTD1nQUwCwmnPqZqRx7JVf4+uanwjFJkgp9
         doMRCZkDOlBPul25KVIiQ8kKkdyqpPAUyKer4H7UTBDKQIzQ7fRerhhLaydCHvdBDt8Z
         mPHcXwGFJRm4Xj+bseiWViHYYa6NDpJY5uL0fH2OqyDgKtmxZPVOSl3qYZ6oVflCkvp0
         /xhpG+2ZzlETEe7PxKgBs+fmhF2Lsh82ws9cKndpYTUnUNymlrFeya+ALsswQgzcBmJH
         waQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=aAEVmWqvALOO+JUR+K+CV/nXItdRHXcH186YESeRPnY=;
        b=NWKRdNfu+uiEkflcUlAvxjRojJAqjkMVsXUTsdWkH0Bm828gq8d+gDWWVMU1Ntnosf
         SO79/VkDypZy9PcFDMUeOzOJcfF6edAseOiM+fixzzk8iYbQ/LEzvusX2glZozaKbWtr
         HJ3x2aPLQyA5vT9By5r8VAT/dl5cOhY1L2f5B1oaSSbOXCsfp5jbJhjIxSDJdF/xZiaD
         /8grGvkeJqJUqfIf7ALO6kwSIA3zNmqYb5D5wP2kq4oMYqdHaCs7Vv7iMi5Ppqh0qQ6z
         XtMicx1GH38U3GgFRoVwqc3nkVn+iI7QiDE0ZQmWqdX96BrZGce5Dz3eY/mRxoB12/3C
         kmGQ==
X-Gm-Message-State: APjAAAWu53s7CsQ1ncow8UJTvDO8z9ImwK1LKwYpqtVeNVYHePaUbiNW
        O0lOfae+CDtRG32yiVzRgN8RziTy2XQ=
X-Google-Smtp-Source: APXvYqynjDvLlszmz8deLAPk41S5MUCttXyQSuVQVZgaaCQW/FOrvxPef7x3TSFRyn9dqAFvQ8joFQ==
X-Received: by 2002:adf:f591:: with SMTP id f17mr121903876wro.119.1564577950559;
        Wed, 31 Jul 2019 05:59:10 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c6sm69247800wma.25.2019.07.31.05.59.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:59:10 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v3 5/7] habanalabs: maintain a list of file private data objects
Date:   Wed, 31 Jul 2019 15:58:59 +0300
Message-Id: <20190731125901.20709-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731125901.20709-1-oded.gabbay@gmail.com>
References: <20190731125901.20709-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new list to the driver's device structure. The list will
keep the file private data structures that the driver creates when a user
process opens the device.

This change is needed because it is useless to try to count how many FD
are open. Instead, track our own private data structure per open file and
once it is released, remove it from the list. As long as the list is not
empty, it means we have a user that can do something with our device.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v3:
- fix deadlock when changing pm mode to manual
 
 drivers/misc/habanalabs/device.c          | 132 ++++++++++------------
 drivers/misc/habanalabs/goya/goya_hwmgr.c |  25 ++--
 drivers/misc/habanalabs/habanalabs.h      |  24 ++--
 drivers/misc/habanalabs/habanalabs_drv.c  |  78 +++++++------
 4 files changed, 127 insertions(+), 132 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index ca166abee7b5..926c85ff068f 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -42,10 +42,12 @@ static void hpriv_release(struct kref *ref)
 {
 	struct hl_fpriv *hpriv;
 	struct hl_device *hdev;
+	struct hl_ctx *ctx;
 
 	hpriv = container_of(ref, struct hl_fpriv, refcount);
 
 	hdev = hpriv->hdev;
+	ctx = hpriv->ctx;
 
 	put_pid(hpriv->taskpid);
 
@@ -53,13 +55,12 @@ static void hpriv_release(struct kref *ref)
 
 	mutex_destroy(&hpriv->restore_phase_mutex);
 
-	kfree(hpriv);
-
-	/* Now the FD is really closed */
-	atomic_dec(&hdev->fd_open_cnt);
-
-	/* This allows a new user context to open the device */
+	mutex_lock(&hdev->fpriv_list_lock);
+	list_del(&hpriv->dev_node);
 	hdev->compute_ctx = NULL;
+	mutex_unlock(&hdev->fpriv_list_lock);
+
+	kfree(hpriv);
 }
 
 void hl_hpriv_get(struct hl_fpriv *hpriv)
@@ -229,14 +230,14 @@ static int device_early_init(struct hl_device *hdev)
 
 	hl_cb_mgr_init(&hdev->kernel_cb_mgr);
 
-	mutex_init(&hdev->fd_open_cnt_lock);
 	mutex_init(&hdev->send_cpu_message_lock);
 	mutex_init(&hdev->debug_lock);
 	mutex_init(&hdev->mmu_cache_lock);
 	INIT_LIST_HEAD(&hdev->hw_queues_mirror_list);
 	spin_lock_init(&hdev->hw_queues_mirror_lock);
+	INIT_LIST_HEAD(&hdev->fpriv_list);
+	mutex_init(&hdev->fpriv_list_lock);
 	atomic_set(&hdev->in_reset, 0);
-	atomic_set(&hdev->fd_open_cnt, 0);
 	atomic_set(&hdev->cs_active_cnt, 0);
 
 	return 0;
@@ -266,6 +267,8 @@ static void device_early_fini(struct hl_device *hdev)
 	mutex_destroy(&hdev->debug_lock);
 	mutex_destroy(&hdev->send_cpu_message_lock);
 
+	mutex_destroy(&hdev->fpriv_list_lock);
+
 	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
 
 	kfree(hdev->hl_chip_info);
@@ -277,8 +280,6 @@ static void device_early_fini(struct hl_device *hdev)
 
 	if (hdev->asic_funcs->early_fini)
 		hdev->asic_funcs->early_fini(hdev);
-
-	mutex_destroy(&hdev->fd_open_cnt_lock);
 }
 
 static void set_freq_to_low_job(struct work_struct *work)
@@ -286,9 +287,13 @@ static void set_freq_to_low_job(struct work_struct *work)
 	struct hl_device *hdev = container_of(work, struct hl_device,
 						work_freq.work);
 
-	if (atomic_read(&hdev->fd_open_cnt) == 0)
+	mutex_lock(&hdev->fpriv_list_lock);
+
+	if (!hdev->compute_ctx)
 		hl_device_set_frequency(hdev, PLL_LOW);
 
+	mutex_unlock(&hdev->fpriv_list_lock);
+
 	schedule_delayed_work(&hdev->work_freq,
 			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
 }
@@ -338,7 +343,7 @@ static int device_late_init(struct hl_device *hdev)
 	hdev->high_pll = hdev->asic_prop.high_pll;
 
 	/* force setting to low frequency */
-	atomic_set(&hdev->curr_pll_profile, PLL_LOW);
+	hdev->curr_pll_profile = PLL_LOW;
 
 	if (hdev->pm_mng_profile == PM_AUTO)
 		hdev->asic_funcs->set_pll_profile(hdev, PLL_LOW);
@@ -387,38 +392,26 @@ static void device_late_fini(struct hl_device *hdev)
  * @hdev: pointer to habanalabs device structure
  * @freq: the new frequency value
  *
- * Change the frequency if needed.
- * We allose to set PLL to low only if there is no user process
- * Returns 0 if no change was done, otherwise returns 1;
+ * Change the frequency if needed. This function has no protection against
+ * concurrency, therefore it is assumed that the calling function has protected
+ * itself against the case of calling this function from multiple threads with
+ * different values
+ *
+ * Returns 0 if no change was done, otherwise returns 1
  */
 int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq)
 {
-	enum hl_pll_frequency old_freq =
-			(freq == PLL_HIGH) ? PLL_LOW : PLL_HIGH;
-	int ret;
-
-	if (hdev->pm_mng_profile == PM_MANUAL)
+	if ((hdev->pm_mng_profile == PM_MANUAL) ||
+			(hdev->curr_pll_profile == freq))
 		return 0;
 
-	ret = atomic_cmpxchg(&hdev->curr_pll_profile, old_freq, freq);
-	if (ret == freq)
-		return 0;
-
-	/*
-	 * in case we want to lower frequency, check if device is not
-	 * opened. We must have a check here to workaround race condition with
-	 * hl_device_open
-	 */
-	if ((freq == PLL_LOW) && (atomic_read(&hdev->fd_open_cnt) > 0)) {
-		atomic_set(&hdev->curr_pll_profile, PLL_HIGH);
-		return 0;
-	}
-
 	dev_dbg(hdev->dev, "Changing device frequency to %s\n",
 		freq == PLL_HIGH ? "high" : "low");
 
 	hdev->asic_funcs->set_pll_profile(hdev, freq);
 
+	hdev->curr_pll_profile = freq;
+
 	return 1;
 }
 
@@ -449,19 +442,8 @@ int hl_device_set_debug_mode(struct hl_device *hdev, bool enable)
 		goto out;
 	}
 
-	mutex_lock(&hdev->fd_open_cnt_lock);
-
-	if (atomic_read(&hdev->fd_open_cnt) > 1) {
-		dev_err(hdev->dev,
-			"Failed to enable debug mode. More then a single user is using the device\n");
-		rc = -EPERM;
-		goto unlock_fd_open_lock;
-	}
-
 	hdev->in_debug = 1;
 
-unlock_fd_open_lock:
-	mutex_unlock(&hdev->fd_open_cnt_lock);
 out:
 	mutex_unlock(&hdev->debug_lock);
 
@@ -568,6 +550,7 @@ int hl_device_resume(struct hl_device *hdev)
 static void device_kill_open_processes(struct hl_device *hdev)
 {
 	u16 pending_total, pending_cnt;
+	struct hl_fpriv	*hpriv;
 	struct task_struct *task = NULL;
 
 	if (hdev->pldm)
@@ -575,32 +558,30 @@ static void device_kill_open_processes(struct hl_device *hdev)
 	else
 		pending_total = HL_PENDING_RESET_PER_SEC;
 
-	pending_cnt = pending_total;
-
-	/* Flush all processes that are inside hl_open */
-	mutex_lock(&hdev->fd_open_cnt_lock);
-
-	while ((atomic_read(&hdev->fd_open_cnt)) && (pending_cnt)) {
-
-		pending_cnt--;
-
-		dev_info(hdev->dev,
-			"Can't HARD reset, waiting for user to close FD\n");
+	/* Giving time for user to close FD, and for processes that are inside
+	 * hl_device_open to finish
+	 */
+	if (!list_empty(&hdev->fpriv_list))
 		ssleep(1);
-	}
 
-	if (atomic_read(&hdev->fd_open_cnt)) {
-		task = get_pid_task(hdev->compute_ctx->hpriv->taskpid,
-					PIDTYPE_PID);
+	mutex_lock(&hdev->fpriv_list_lock);
+
+	/* This section must be protected because we are dereferencing
+	 * pointers that are freed if the process exits
+	 */
+	list_for_each_entry(hpriv, &hdev->fpriv_list, dev_node) {
+		task = get_pid_task(hpriv->taskpid, PIDTYPE_PID);
 		if (task) {
-			dev_info(hdev->dev, "Killing user processes\n");
+			dev_info(hdev->dev, "Killing user process\n");
 			send_sig(SIGKILL, task, 1);
-			msleep(100);
+			usleep_range(1000, 10000);
 
 			put_task_struct(task);
 		}
 	}
 
+	mutex_unlock(&hdev->fpriv_list_lock);
+
 	/* We killed the open users, but because the driver cleans up after the
 	 * user contexts are closed (e.g. mmu mappings), we need to wait again
 	 * to make sure the cleaning phase is finished before continuing with
@@ -609,19 +590,18 @@ static void device_kill_open_processes(struct hl_device *hdev)
 
 	pending_cnt = pending_total;
 
-	while ((atomic_read(&hdev->fd_open_cnt)) && (pending_cnt)) {
+	while ((!list_empty(&hdev->fpriv_list)) && (pending_cnt)) {
+		dev_info(hdev->dev,
+			"Waiting for all unmap operations to finish before hard reset\n");
 
 		pending_cnt--;
 
 		ssleep(1);
 	}
 
-	if (atomic_read(&hdev->fd_open_cnt))
+	if (!list_empty(&hdev->fpriv_list))
 		dev_crit(hdev->dev,
 			"Going to hard reset with open user contexts\n");
-
-	mutex_unlock(&hdev->fd_open_cnt_lock);
-
 }
 
 static void device_hard_reset_pending(struct work_struct *work)
@@ -677,13 +657,16 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		/* This also blocks future CS/VM/JOB completion operations */
 		hdev->disabled = true;
 
-		/*
-		 * Flush anyone that is inside the critical section of enqueue
+		/* Flush anyone that is inside the critical section of enqueue
 		 * jobs to the H/W
 		 */
 		hdev->asic_funcs->hw_queues_lock(hdev);
 		hdev->asic_funcs->hw_queues_unlock(hdev);
 
+		/* Flush anyone that is inside device open */
+		mutex_lock(&hdev->fpriv_list_lock);
+		mutex_unlock(&hdev->fpriv_list_lock);
+
 		dev_err(hdev->dev, "Going to RESET device!\n");
 	}
 
@@ -759,12 +742,16 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		hl_cq_reset(hdev, &hdev->completion_queue[i]);
 
+	mutex_lock(&hdev->fpriv_list_lock);
+
 	/* Make sure the context switch phase will run again */
 	if (hdev->compute_ctx) {
 		atomic_set(&hdev->compute_ctx->thread_ctx_switch_token, 1);
 		hdev->compute_ctx->thread_ctx_switch_wait_token = 0;
 	}
 
+	mutex_unlock(&hdev->fpriv_list_lock);
+
 	/* Finished tear-down, starting to re-initialize */
 
 	if (hard_reset) {
@@ -1126,13 +1113,16 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Mark device as disabled */
 	hdev->disabled = true;
 
-	/*
-	 * Flush anyone that is inside the critical section of enqueue
+	/* Flush anyone that is inside the critical section of enqueue
 	 * jobs to the H/W
 	 */
 	hdev->asic_funcs->hw_queues_lock(hdev);
 	hdev->asic_funcs->hw_queues_unlock(hdev);
 
+	/* Flush anyone that is inside device open */
+	mutex_lock(&hdev->fpriv_list_lock);
+	mutex_unlock(&hdev->fpriv_list_lock);
+
 	hdev->hard_reset_pending = true;
 
 	hl_hwmon_fini(hdev);
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index a51d836542a1..641e5cb69461 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -254,11 +254,11 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 		goto out;
 	}
 
-	mutex_lock(&hdev->fd_open_cnt_lock);
+	mutex_lock(&hdev->fpriv_list_lock);
 
-	if (atomic_read(&hdev->fd_open_cnt) > 0) {
+	if (hdev->compute_ctx) {
 		dev_err(hdev->dev,
-			"Can't change PM profile while user process is opened on the device\n");
+			"Can't change PM profile while compute context is opened on the device\n");
 		count = -EPERM;
 		goto unlock_mutex;
 	}
@@ -266,24 +266,33 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 	if (strncmp("auto", buf, strlen("auto")) == 0) {
 		/* Make sure we are in LOW PLL when changing modes */
 		if (hdev->pm_mng_profile == PM_MANUAL) {
-			atomic_set(&hdev->curr_pll_profile, PLL_HIGH);
+			hdev->curr_pll_profile = PLL_HIGH;
 			hl_device_set_frequency(hdev, PLL_LOW);
 			hdev->pm_mng_profile = PM_AUTO;
 		}
 	} else if (strncmp("manual", buf, strlen("manual")) == 0) {
-		/* Make sure we are in LOW PLL when changing modes */
 		if (hdev->pm_mng_profile == PM_AUTO) {
-			flush_delayed_work(&hdev->work_freq);
+			/* Must release the lock because the work thread also
+			 * takes this lock. But before we release it, set
+			 * the mode to manual so nothing will change if a user
+			 * suddenly opens the device
+			 */
 			hdev->pm_mng_profile = PM_MANUAL;
+
+			mutex_unlock(&hdev->fpriv_list_lock);
+
+			/* Flush the current work so we can return to the user
+			 * knowing that he is the only one changing frequencies
+			 */
+			flush_delayed_work(&hdev->work_freq);
 		}
 	} else {
 		dev_err(hdev->dev, "value should be auto or manual\n");
 		count = -EINVAL;
-		goto unlock_mutex;
 	}
 
 unlock_mutex:
-	mutex_unlock(&hdev->fd_open_cnt_lock);
+	mutex_unlock(&hdev->fpriv_list_lock);
 out:
 	return count;
 }
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 53f6b238e6f2..f2ca06b2c155 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -909,6 +909,7 @@ struct hl_debug_params {
  * @ctx_mgr: context manager to handle multiple context for this FD.
  * @cb_mgr: command buffer manager to handle multiple buffers for this FD.
  * @debugfs_list: list of relevant ASIC debugfs.
+ * @dev_node: node in the device list of file private data
  * @refcount: number of related contexts.
  * @restore_phase_mutex: lock for context switch and restore phase.
  */
@@ -920,6 +921,7 @@ struct hl_fpriv {
 	struct hl_ctx_mgr	ctx_mgr;
 	struct hl_cb_mgr	cb_mgr;
 	struct list_head	debugfs_list;
+	struct list_head	dev_node;
 	struct kref		refcount;
 	struct mutex		restore_phase_mutex;
 };
@@ -1161,12 +1163,6 @@ struct hl_device_reset_work {
  * @cpu_accessible_dma_pool: KMD <-> ArmCP shared memory pool.
  * @asid_bitmap: holds used/available ASIDs.
  * @asid_mutex: protects asid_bitmap.
- * @fd_open_cnt_lock: lock for updating fd_open_cnt in hl_device_open. Although
- *                    fd_open_cnt is atomic, we need this lock to serialize
- *                    the open function because the driver currently supports
- *                    only a single process at a time. In addition, we need a
- *                    lock here so we can flush user processes which are opening
- *                    the device while we are trying to hard reset it
  * @send_cpu_message_lock: enforces only one message in KMD <-> ArmCP queue.
  * @debug_lock: protects critical section of setting debug mode for device
  * @asic_prop: ASIC specific immutable properties.
@@ -1182,6 +1178,9 @@ struct hl_device_reset_work {
  * @hl_debugfs: device's debugfs manager.
  * @cb_pool: list of preallocated CBs.
  * @cb_pool_lock: protects the CB pool.
+ * @fpriv_list: list of file private data structures. Each structure is created
+ *              when a user opens the device
+ * @fpriv_list_lock: protects the fpriv_list
  * @compute_ctx: current compute context executing.
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
@@ -1189,10 +1188,9 @@ struct hl_device_reset_work {
  *             value is saved so in case of hard-reset, KMD will restore this
  *             value and update the F/W after the re-initialization
  * @in_reset: is device in reset flow.
- * @curr_pll_profile: current PLL profile.
- * @fd_open_cnt: number of open user processes.
  * @cs_active_cnt: number of active command submissions on this device (active
  *                 means already in H/W queues)
+ * @curr_pll_profile: current PLL profile.
  * @major: habanalabs KMD major.
  * @high_pll: high PLL profile frequency.
  * @soft_reset_cnt: number of soft reset since KMD loading.
@@ -1211,7 +1209,7 @@ struct hl_device_reset_work {
  * @mmu_enable: is MMU enabled.
  * @device_cpu_disabled: is the device CPU disabled (due to timeouts)
  * @dma_mask: the dma mask that was set for this device
- * @in_debug: is device under debug. This, together with fd_open_cnt, enforces
+ * @in_debug: is device under debug. This, together with fpriv_list, enforces
  *            that only a single user is configuring the debug infrastructure.
  */
 struct hl_device {
@@ -1239,8 +1237,6 @@ struct hl_device {
 	struct gen_pool			*cpu_accessible_dma_pool;
 	unsigned long			*asid_bitmap;
 	struct mutex			asid_mutex;
-	/* TODO: remove fd_open_cnt_lock for multiple process support */
-	struct mutex			fd_open_cnt_lock;
 	struct mutex			send_cpu_message_lock;
 	struct mutex			debug_lock;
 	struct asic_fixed_properties	asic_prop;
@@ -1259,15 +1255,17 @@ struct hl_device {
 	struct list_head		cb_pool;
 	spinlock_t			cb_pool_lock;
 
+	struct list_head		fpriv_list;
+	struct mutex			fpriv_list_lock;
+
 	struct hl_ctx			*compute_ctx;
 
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
 	atomic_t			in_reset;
-	atomic_t			curr_pll_profile;
-	atomic_t			fd_open_cnt;
 	atomic_t			cs_active_cnt;
+	enum hl_pll_frequency		curr_pll_profile;
 	u32				major;
 	u32				high_pll;
 	u32				soft_reset_cnt;
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 678f61646ca9..802c6ca7c604 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -95,80 +95,78 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		return -ENXIO;
 	}
 
-	mutex_lock(&hdev->fd_open_cnt_lock);
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		return -ENOMEM;
+
+	hpriv->hdev = hdev;
+	filp->private_data = hpriv;
+	hpriv->filp = filp;
+	mutex_init(&hpriv->restore_phase_mutex);
+	kref_init(&hpriv->refcount);
+	nonseekable_open(inode, filp);
+
+	hl_cb_mgr_init(&hpriv->cb_mgr);
+	hl_ctx_mgr_init(&hpriv->ctx_mgr);
+
+	hpriv->taskpid = find_get_pid(current->pid);
+
+	mutex_lock(&hdev->fpriv_list_lock);
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't open %s because it is disabled or in reset\n",
 			dev_name(hdev->dev));
-		mutex_unlock(&hdev->fd_open_cnt_lock);
-		return -EPERM;
+		rc = -EPERM;
+		goto out_err;
 	}
 
 	if (hdev->in_debug) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't open %s because it is being debugged by another user\n",
 			dev_name(hdev->dev));
-		mutex_unlock(&hdev->fd_open_cnt_lock);
-		return -EPERM;
+		rc = -EPERM;
+		goto out_err;
 	}
 
-	if (atomic_read(&hdev->fd_open_cnt)) {
+	if (hdev->compute_ctx) {
 		dev_info_ratelimited(hdev->dev,
 			"Can't open %s because another user is working on it\n",
 			dev_name(hdev->dev));
-		mutex_unlock(&hdev->fd_open_cnt_lock);
-		return -EBUSY;
-	}
-
-	atomic_inc(&hdev->fd_open_cnt);
-
-	mutex_unlock(&hdev->fd_open_cnt_lock);
-
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv) {
-		rc = -ENOMEM;
-		goto close_device;
+		rc = -EBUSY;
+		goto out_err;
 	}
 
-	hpriv->hdev = hdev;
-	filp->private_data = hpriv;
-	hpriv->filp = filp;
-	mutex_init(&hpriv->restore_phase_mutex);
-	kref_init(&hpriv->refcount);
-	nonseekable_open(inode, filp);
-
-	hl_cb_mgr_init(&hpriv->cb_mgr);
-	hl_ctx_mgr_init(&hpriv->ctx_mgr);
-
 	rc = hl_ctx_create(hdev, hpriv);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to open FD (CTX fail)\n");
+		dev_err(hdev->dev, "Failed to create context %d\n", rc);
 		goto out_err;
 	}
 
-	hpriv->taskpid = find_get_pid(current->pid);
-
-	/*
-	 * Device is IDLE at this point so it is legal to change PLLs. There
-	 * is no need to check anything because if the PLL is already HIGH, the
-	 * set function will return without doing anything
+	/* Device is IDLE at this point so it is legal to change PLLs.
+	 * There is no need to check anything because if the PLL is
+	 * already HIGH, the set function will return without doing
+	 * anything
 	 */
 	hl_device_set_frequency(hdev, PLL_HIGH);
 
+	list_add(&hpriv->dev_node, &hdev->fpriv_list);
+	mutex_unlock(&hdev->fpriv_list_lock);
+
 	hl_debugfs_add_file(hpriv);
 
 	return 0;
 
 out_err:
-	filp->private_data = NULL;
-	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
+	mutex_unlock(&hdev->fpriv_list_lock);
+
 	hl_cb_mgr_fini(hpriv->hdev, &hpriv->cb_mgr);
+	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
+	filp->private_data = NULL;
 	mutex_destroy(&hpriv->restore_phase_mutex);
-	kfree(hpriv);
+	put_pid(hpriv->taskpid);
 
-close_device:
-	atomic_dec(&hdev->fd_open_cnt);
+	kfree(hpriv);
 	return rc;
 }
 
-- 
2.17.1

