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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76127C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9FF2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIWW8wr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfG1L2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:28:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35947 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfG1L2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:28:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so58865257wrs.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=XltJx2S4zsiQPcyOzWcjR9ipdIg5sqE++mN8RPi5NcE=;
        b=YIWW8wr8cIWq4OJC/b58Rzxv34vJmFNFHIq4T8uhdG/Idi6TyNXG9wUtoN3hsWICNy
         +qJUvO1P5KF7p7jBQCiy9668Rg3hS66bqbRJjOtQrrCJ47ghKDlamV2X7mWHHl8dzr+t
         gL+Qw8ltmKGzPHo03qFn4sHWQFtkon8rOIopcITHhpDztATkjNmrr3lXAdOngQh5TQUh
         wzs3LcZzagPXteiaNgC1shDqXraTvrlQakpGyTaPCYQvLHewwFNDn6LnsswYG6Ams5/G
         k5NTM7pIyMBdmHUchF7aUNMYXt8WLmSrAyojXF2X1HTzuQ2s6Ii346rOxIl7f1rDkteV
         6Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=XltJx2S4zsiQPcyOzWcjR9ipdIg5sqE++mN8RPi5NcE=;
        b=lrkM4jyklbLbyXkTTFuj1iwLcE2wz2BDVAjX5t43IWXO90n4B49tEHSR5QKebE4PcK
         +BUcOJN4oT4vf8x2mEE2FYMZovNgu1G05k9/32gjdWDfTjQJtNSc+qOuODdvEEPbXbN6
         g9tL4eAm9ctTjwgD7NRp+/3Vi5cA/2hgfmcZhGVfThlcCLj8vV0GSBmPnJJC6lgnyN4y
         UdWJH6CAt0os3y6xznGJLPUqQ+F/kx4HIsnfvQwYrl9M+Em6V8cludCjiKHN93AABF3P
         Xm3g0HbVujmUOMlP+DYs48knzXVOFbeUrf6zTGOoHmgFHDTv/TFvI9YNIVGIcnCbLswm
         m/0A==
X-Gm-Message-State: APjAAAXMhVQlfUOaen9jFgPIObC0/Mxek1ilQzUjCuIyIGeUrnH+EY9p
        6OqPoUo6c9f6OQ78rlqzoMuGg0GlrD4=
X-Google-Smtp-Source: APXvYqxvXkQx4Gf2DXgT5MfSGWxjqpVHMfW93TM8q6lVCSxN8+itsUktabZpzS0bDQP1NR1zxgQjCg==
X-Received: by 2002:a5d:50d1:: with SMTP id f17mr60840116wrt.124.1564313307665;
        Sun, 28 Jul 2019 04:28:27 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r12sm69805174wrt.95.2019.07.28.04.28.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 04:28:27 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 5/9] habanalabs: maintain a list of file private data objects
Date:   Sun, 28 Jul 2019 14:28:14 +0300
Message-Id: <20190728112818.30397-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190728112818.30397-1-oded.gabbay@gmail.com>
References: <20190728112818.30397-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new list to the driver's device structure. The list will
keep the file private data structures that the driver creates when a user
process opens the device.

This change is needed because it is useless to try to count how many FD
are open. Instead, save the private data structure and once it is
released, remove it from the list. As long as the list is not empty, it
means we have a user that can do something with our device.

This is also needed in preparation for when the user will open a context.
When that happens, we can remove the restriction of denying a user to
open the device if the list is not empty.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c         | 40 +++++++++++++-----------
 drivers/misc/habanalabs/habanalabs.h     | 20 ++++++------
 drivers/misc/habanalabs/habanalabs_drv.c | 11 +++----
 3 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index a791a1b58215..efeeaa2dc915 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -53,10 +53,14 @@ static void hpriv_release(struct kref *ref)
 
 	mutex_destroy(&hpriv->restore_phase_mutex);
 
-	kfree(hpriv);
+	/* Remove private data node from the device list. This enables
+	 * another process to open the device
+	 */
+	mutex_lock(&hdev->fpriv_list_lock);
+	list_del(&hpriv->dev_node);
+	mutex_unlock(&hdev->fpriv_list_lock);
 
-	/* Now the FD is really closed */
-	atomic_dec(&hdev->fd_open_cnt);
+	kfree(hpriv);
 
 	mutex_lock(&hdev->lazy_ctx_creation_lock);
 	hdev->user_ctx = NULL;
@@ -230,15 +234,15 @@ static int device_early_init(struct hl_device *hdev)
 
 	hl_cb_mgr_init(&hdev->kernel_cb_mgr);
 
-	mutex_init(&hdev->fd_open_cnt_lock);
 	mutex_init(&hdev->send_cpu_message_lock);
 	mutex_init(&hdev->debug_lock);
 	mutex_init(&hdev->mmu_cache_lock);
 	mutex_init(&hdev->lazy_ctx_creation_lock);
 	INIT_LIST_HEAD(&hdev->hw_queues_mirror_list);
 	spin_lock_init(&hdev->hw_queues_mirror_lock);
+	INIT_LIST_HEAD(&hdev->fpriv_list);
+	mutex_init(&hdev->fpriv_list_lock);
 	atomic_set(&hdev->in_reset, 0);
-	atomic_set(&hdev->fd_open_cnt, 0);
 	atomic_set(&hdev->cs_active_cnt, 0);
 
 	return 0;
@@ -269,6 +273,8 @@ static void device_early_fini(struct hl_device *hdev)
 	mutex_destroy(&hdev->debug_lock);
 	mutex_destroy(&hdev->send_cpu_message_lock);
 
+	mutex_destroy(&hdev->fpriv_list_lock);
+
 	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
 
 	kfree(hdev->hl_chip_info);
@@ -280,8 +286,6 @@ static void device_early_fini(struct hl_device *hdev)
 
 	if (hdev->asic_funcs->early_fini)
 		hdev->asic_funcs->early_fini(hdev);
-
-	mutex_destroy(&hdev->fd_open_cnt_lock);
 }
 
 static void set_freq_to_low_job(struct work_struct *work)
@@ -444,19 +448,19 @@ int hl_device_set_debug_mode(struct hl_device *hdev, bool enable)
 		goto out;
 	}
 
-	mutex_lock(&hdev->fd_open_cnt_lock);
+	mutex_lock(&hdev->fpriv_list_lock);
 
-	if (atomic_read(&hdev->fd_open_cnt) > 1) {
+	if (!list_is_singular(&hdev->fpriv_list)) {
 		dev_err(hdev->dev,
 			"Failed to enable debug mode. More then a single user is using the device\n");
 		rc = -EPERM;
-		goto unlock_fd_open_lock;
+		goto unlock_fpriv_list_lock;
 	}
 
 	hdev->in_debug = 1;
 
-unlock_fd_open_lock:
-	mutex_unlock(&hdev->fd_open_cnt_lock);
+unlock_fpriv_list_lock:
+	mutex_unlock(&hdev->fpriv_list_lock);
 out:
 	mutex_unlock(&hdev->debug_lock);
 
@@ -573,9 +577,9 @@ static void device_kill_open_processes(struct hl_device *hdev)
 	pending_cnt = pending_total;
 
 	/* Flush all processes that are inside hl_open */
-	mutex_lock(&hdev->fd_open_cnt_lock);
+	mutex_lock(&hdev->fpriv_list_lock);
 
-	while ((atomic_read(&hdev->fd_open_cnt)) && (pending_cnt)) {
+	while ((!list_empty(&hdev->fpriv_list)) && (pending_cnt)) {
 
 		pending_cnt--;
 
@@ -584,7 +588,7 @@ static void device_kill_open_processes(struct hl_device *hdev)
 		ssleep(1);
 	}
 
-	if (atomic_read(&hdev->fd_open_cnt)) {
+	if (!list_empty(&hdev->fpriv_list)) {
 		task = get_pid_task(hdev->user_ctx->hpriv->taskpid,
 					PIDTYPE_PID);
 		if (task) {
@@ -604,18 +608,18 @@ static void device_kill_open_processes(struct hl_device *hdev)
 
 	pending_cnt = pending_total;
 
-	while ((atomic_read(&hdev->fd_open_cnt)) && (pending_cnt)) {
+	while ((!list_empty(&hdev->fpriv_list)) && (pending_cnt)) {
 
 		pending_cnt--;
 
 		ssleep(1);
 	}
 
-	if (atomic_read(&hdev->fd_open_cnt))
+	if (!list_empty(&hdev->fpriv_list))
 		dev_crit(hdev->dev,
 			"Going to hard reset with open user contexts\n");
 
-	mutex_unlock(&hdev->fd_open_cnt_lock);
+	mutex_unlock(&hdev->fpriv_list_lock);
 
 }
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 6354fc88ef8a..589eb40bb95d 100644
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
  * @user_ctx: current user context executing.
  * @lazy_ctx_creation_lock: lock to protect lazy creation of context
  * @dram_used_mem: current DRAM memory consumption.
@@ -1190,7 +1189,6 @@ struct hl_device_reset_work {
  *             value is saved so in case of hard-reset, KMD will restore this
  *             value and update the F/W after the re-initialization
  * @in_reset: is device in reset flow.
- * @fd_open_cnt: number of open user processes.
  * @cs_active_cnt: number of active command submissions on this device (active
  *                 means already in H/W queues)
  * @curr_pll_profile: current PLL profile.
@@ -1212,7 +1210,7 @@ struct hl_device_reset_work {
  * @mmu_enable: is MMU enabled.
  * @device_cpu_disabled: is the device CPU disabled (due to timeouts)
  * @dma_mask: the dma mask that was set for this device
- * @in_debug: is device under debug. This, together with fd_open_cnt, enforces
+ * @in_debug: is device under debug. This, together with fpriv_list, enforces
  *            that only a single user is configuring the debug infrastructure.
  */
 struct hl_device {
@@ -1240,8 +1238,6 @@ struct hl_device {
 	struct gen_pool			*cpu_accessible_dma_pool;
 	unsigned long			*asid_bitmap;
 	struct mutex			asid_mutex;
-	/* TODO: remove fd_open_cnt_lock for multiple process support */
-	struct mutex			fd_open_cnt_lock;
 	struct mutex			send_cpu_message_lock;
 	struct mutex			debug_lock;
 	struct asic_fixed_properties	asic_prop;
@@ -1260,6 +1256,9 @@ struct hl_device {
 	struct list_head		cb_pool;
 	spinlock_t			cb_pool_lock;
 
+	struct list_head		fpriv_list;
+	struct mutex			fpriv_list_lock;
+
 	/* TODO: remove user_ctx for multiple process support */
 	struct hl_ctx			*user_ctx;
 	struct mutex			lazy_ctx_creation_lock;
@@ -1268,7 +1267,6 @@ struct hl_device {
 	u64				timeout_jiffies;
 	u64				max_power;
 	atomic_t			in_reset;
-	atomic_t			fd_open_cnt;
 	atomic_t			cs_active_cnt;
 	enum hl_pll_frequency		curr_pll_profile;
 	u32				major;
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index a781aa936160..d990b30c0701 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -99,7 +99,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	if (!hpriv)
 		return -ENOMEM;
 
-	mutex_lock(&hdev->fd_open_cnt_lock);
+	mutex_lock(&hdev->fpriv_list_lock);
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
 		dev_err_ratelimited(hdev->dev,
@@ -117,7 +117,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		goto out_err;
 	}
 
-	if (atomic_read(&hdev->fd_open_cnt)) {
+	if (!list_empty(&hdev->fpriv_list)) {
 		dev_info_ratelimited(hdev->dev,
 			"Can't open %s because another user is working on it\n",
 			dev_name(hdev->dev));
@@ -125,9 +125,8 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		goto out_err;
 	}
 
-	atomic_inc(&hdev->fd_open_cnt);
-
-	mutex_unlock(&hdev->fd_open_cnt_lock);
+	list_add(&hpriv->dev_node, &hdev->fpriv_list);
+	mutex_unlock(&hdev->fpriv_list_lock);
 
 	hpriv->hdev = hdev;
 	filp->private_data = hpriv;
@@ -146,7 +145,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	return 0;
 
 out_err:
-	mutex_unlock(&hdev->fd_open_cnt_lock);
+	mutex_unlock(&hdev->fpriv_list_lock);
 	kfree(hpriv);
 	return rc;
 }
-- 
2.17.1

