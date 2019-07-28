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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAADC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 12:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206322077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 12:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGnVXM7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfG1MsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 08:48:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33862 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfG1MsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 08:48:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so58952985wrm.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=ZWKr0iY7CbtEmTy/TrGt9DwZkYWWig3GcrMMduBEHAU=;
        b=LGnVXM7+V7jBRRrv5ba27ebLTncv4Sf+5ZGTVlpnzZGvUXTWYjJKMNpQzOC5LnJdzB
         RWqHGTAJeklWHFbauoKUToJV4DutjiD6+0zmAQc11R0zR2KUFmqb0X+KotBCv99/xhhM
         nhPq7gRW9zjt5hpfe+sQoh8hK09CzxsMaHhml27DsHfkrSnNCQMR9+ozenkDryW+xp0Z
         acEvTR+comWkgzTLPzpQUFGpumWzgzzC0a9oKoqeuGxjlxbmZz3ObGQWwh9QbKk+Duts
         n8hjYcqRVve2z+4m4roLFzz/AuWsbsHruVvbMVdyUe0lHVVn5BqIzOa11tLBiSyLdjda
         Czug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ZWKr0iY7CbtEmTy/TrGt9DwZkYWWig3GcrMMduBEHAU=;
        b=b+vYMpxzMIt2Z367kjTHyCUOEuRM9wBdbsjV52XSQkjtmjzW1XlLfHsd8FT8HP1OMB
         pPxbKsHLkdYf0aP9q+irYIEuBwMrc/kS4pSyNIA40gJy1+ToDCUEzdK/pHBESUXYXWsV
         438M3W6pgwYgPg2n7IotvCecfVVi0vXvSkeJo2lfxeA375hJ9V5Xirx6ddWaMO+96/wp
         t896vMZsTIf6xGEROTii0nIup771wwnA+KOImhFpmveRaKhHjjAPdT+vaoSqbPQgO/U1
         oE1ZTAAfKFWqZpZI8T4AeYipo8Rmuq/YPdbWlCCCT9XCXUxt7nxhbCElPArZ/D8B5Zg0
         61QA==
X-Gm-Message-State: APjAAAVr58oWw1IXISQyTfQCUYGVc/vDiOlK0fLD+Jc2rqFqkBnttbdC
        nj7HmUAKbji5vOCJqUu/f2dbJHSJ3NU=
X-Google-Smtp-Source: APXvYqwnvZAX11wLOG0bM3bze9ri4P9m6uqQHxum7nxUVz0rR1cYrN5aWjrnJmoIlgNG/gOgXwB9kw==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr20939916wrx.72.1564318094651;
        Sun, 28 Jul 2019 05:48:14 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id x20sm45571265wmc.1.2019.07.28.05.48.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 05:48:14 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 9/9 v2] habanalabs: allow multiple processes to open FD
Date:   Sun, 28 Jul 2019 15:48:12 +0300
Message-Id: <20190728124812.3952-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the limitation of a single process that can open the
device.

Now, there is no limitation on the number of processes that can open the
device and have a valid FD.

However, only a single process can perform compute operations. This is
enforced by allowing only a single process to have a compute context.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
- Replace WARN with dev_crit
 
 drivers/misc/habanalabs/context.c          | 101 +++++++++++++++------
 drivers/misc/habanalabs/device.c           |  18 ++--
 drivers/misc/habanalabs/habanalabs.h       |   1 -
 drivers/misc/habanalabs/habanalabs_drv.c   |   8 --
 drivers/misc/habanalabs/habanalabs_ioctl.c |   7 +-
 5 files changed, 86 insertions(+), 49 deletions(-)

diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 57bbe59da9b6..6809a25c848f 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -56,7 +56,7 @@ void hl_ctx_do_release(struct kref *ref)
 	kfree(ctx);
 }
 
-int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
+static int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 {
 	struct hl_ctx_mgr *mgr = &hpriv->ctx_mgr;
 	struct hl_ctx *ctx;
@@ -89,9 +89,6 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 	/* TODO: remove for multiple contexts per process */
 	hpriv->ctx = ctx;
 
-	/* TODO: remove the following line for multiple process support */
-	hdev->compute_ctx = ctx;
-
 	return 0;
 
 remove_from_idr:
@@ -206,13 +203,22 @@ bool hl_ctx_is_valid(struct hl_fpriv *hpriv, bool requires_compute_ctx)
 	int rc;
 
 	/* First thing, to minimize latency impact, check if context exists.
-	 * Also check if it matches the requirements. If so, exit immediately
+	 * This is relevant for the "steady state", where a process context
+	 * already exists, and we want to minimize the latency in command
+	 * submissions. In that case, we want to see if we can quickly exit
+	 * with a valid answer.
+	 *
+	 * If a context doesn't exists, we must grab the mutex. Otherwise,
+	 * there can be nasty races in case of multi-threaded application.
+	 *
+	 * So, if the context exists and we don't need a compute context,
+	 * that's fine. If it exists and the context we have is the compute
+	 * context, that's also fine. Other then that, we can't check anything
+	 * without the mutex.
 	 */
-	if (hpriv->ctx) {
-		if ((requires_compute_ctx) && (hdev->compute_ctx != hpriv->ctx))
-			return false;
+	if ((hpriv->ctx) && ((!requires_compute_ctx) ||
+					(hdev->compute_ctx == hpriv->ctx)))
 		return true;
-	}
 
 	mutex_lock(&hdev->lazy_ctx_creation_lock);
 
@@ -222,35 +228,74 @@ bool hl_ctx_is_valid(struct hl_fpriv *hpriv, bool requires_compute_ctx)
 	 * creation of a context
 	 */
 	if (hpriv->ctx) {
-		if ((requires_compute_ctx) && (hdev->compute_ctx != hpriv->ctx))
+		if ((!requires_compute_ctx) ||
+					(hdev->compute_ctx == hpriv->ctx))
+			goto unlock_mutex;
+
+		if (hdev->compute_ctx) {
 			valid = false;
-		goto unlock_mutex;
-	}
+			goto unlock_mutex;
+		}
 
-	/* If we already have a compute context, there is no point
-	 * of creating one in case we are called from ioctl that needs
-	 * a compute context
-	 */
-	if ((hdev->compute_ctx) && (requires_compute_ctx)) {
+		/* If we reached here, it means we have a non-compute context,
+		 * but there is no compute context on the device. Therefore,
+		 * we can try to "upgrade" the existing context to a compute
+		 * context
+		 */
+		dev_dbg_ratelimited(hdev->dev,
+				"Non-compute context %d exists\n",
+				hpriv->ctx->asid);
+
+	} else if ((hdev->compute_ctx) && (requires_compute_ctx)) {
+
+		/* If we already have a compute context in the device, there is
+		 * no point of creating one in case we are called from ioctl
+		 * that needs a compute context
+		 */
 		dev_err(hdev->dev,
 			"Can't create new compute context as one already exists\n");
 		valid = false;
 		goto unlock_mutex;
-	}
+	} else {
+		/* If we reached here it is because there isn't a context for
+		 * the process AND there is no compute context or compute
+		 * context wasn't required. In any case, must create a context
+		 * for the process
+		 */
 
-	rc = hl_ctx_create(hdev, hpriv);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to create context %d\n", rc);
-		valid = false;
-		goto unlock_mutex;
+		rc = hl_ctx_create(hdev, hpriv);
+		if (rc) {
+			dev_err(hdev->dev, "Failed to create context %d\n", rc);
+			valid = false;
+			goto unlock_mutex;
+		}
+
+		dev_dbg_ratelimited(hdev->dev, "Created context %d\n",
+					hpriv->ctx->asid);
 	}
 
-	/* Device is IDLE at this point so it is legal to change PLLs.
-	 * There is no need to check anything because if the PLL is
-	 * already HIGH, the set function will return without doing
-	 * anything
+	/* If we reached here then either we have a new context, or we can
+	 * upgrade a non-compute context to a compute context. Do the upgrade
+	 * only if the caller required a compute context
 	 */
-	hl_device_set_frequency(hdev, PLL_HIGH);
+	if (requires_compute_ctx) {
+		if (hdev->compute_ctx)
+			dev_crit(hdev->dev,
+				"Compute context exists but driver is setting a new one");
+
+		dev_dbg_ratelimited(hdev->dev,
+				"Setting context %d as compute\n",
+				hpriv->ctx->asid);
+
+		hdev->compute_ctx = hpriv->ctx;
+
+		/* Device is IDLE at this point so it is legal to change PLLs.
+		 * There is no need to check anything because if the PLL is
+		 * already HIGH, the set function will return without doing
+		 * anything
+		 */
+		hl_device_set_frequency(hdev, PLL_HIGH);
+	}
 
 unlock_mutex:
 	mutex_unlock(&hdev->lazy_ctx_creation_lock);
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 2677160c01b8..e99a6d2b9893 100644
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
 
@@ -53,9 +55,6 @@ static void hpriv_release(struct kref *ref)
 
 	mutex_destroy(&hpriv->restore_phase_mutex);
 
-	/* Remove private data node from the device list. This enables
-	 * another process to open the device
-	 */
 	mutex_lock(&hdev->fpriv_list_lock);
 	list_del(&hpriv->dev_node);
 	mutex_unlock(&hdev->fpriv_list_lock);
@@ -63,7 +62,8 @@ static void hpriv_release(struct kref *ref)
 	kfree(hpriv);
 
 	mutex_lock(&hdev->lazy_ctx_creation_lock);
-	hdev->compute_ctx = NULL;
+	if (hdev->compute_ctx == ctx)
+		hdev->compute_ctx = NULL;
 	mutex_unlock(&hdev->lazy_ctx_creation_lock);
 }
 
@@ -567,6 +567,7 @@ int hl_device_resume(struct hl_device *hdev)
 static void device_kill_open_processes(struct hl_device *hdev)
 {
 	u16 pending_total, pending_cnt;
+	struct hl_fpriv	*hpriv;
 	struct task_struct *task = NULL;
 
 	if (hdev->pldm)
@@ -589,13 +590,12 @@ static void device_kill_open_processes(struct hl_device *hdev)
 	/* This section must be protected because we are dereferencing
 	 * pointers that are freed if the process exits
 	 */
-	if (!list_empty(&hdev->fpriv_list)) {
-		task = get_pid_task(hdev->compute_ctx->hpriv->taskpid,
-					PIDTYPE_PID);
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
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 6a6c71fd5eef..43123d00d046 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1412,7 +1412,6 @@ void hl_asid_fini(struct hl_device *hdev);
 unsigned long hl_asid_alloc(struct hl_device *hdev);
 void hl_asid_free(struct hl_device *hdev, unsigned long asid);
 
-int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv);
 void hl_ctx_free(struct hl_device *hdev, struct hl_ctx *ctx);
 int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx);
 void hl_ctx_do_release(struct kref *ref);
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index d990b30c0701..b21f9724a652 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -117,14 +117,6 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		goto out_err;
 	}
 
-	if (!list_empty(&hdev->fpriv_list)) {
-		dev_info_ratelimited(hdev->dev,
-			"Can't open %s because another user is working on it\n",
-			dev_name(hdev->dev));
-		rc = -EBUSY;
-		goto out_err;
-	}
-
 	list_add(&hpriv->dev_node, &hdev->fpriv_list);
 	mutex_unlock(&hdev->fpriv_list_lock);
 
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 8d84f2ac302d..452fd419a0cd 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -89,8 +89,9 @@ static int hw_events_info(struct hl_device *hdev, struct hl_info_args *args)
 	return copy_to_user(out, arr, min(max_size, size)) ? -EFAULT : 0;
 }
 
-static int dram_usage_info(struct hl_device *hdev, struct hl_info_args *args)
+static int dram_usage_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
+	struct hl_device *hdev = hpriv->hdev;
 	struct hl_info_dram_usage dram_usage = {0};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
@@ -105,7 +106,7 @@ static int dram_usage_info(struct hl_device *hdev, struct hl_info_args *args)
 	dram_usage.dram_free_mem = (prop->dram_size - dram_kmd_size) -
 					atomic64_read(&hdev->dram_used_mem);
 	dram_usage.ctx_dram_mem =
-			atomic64_read(&hdev->compute_ctx->dram_phys_mem);
+			atomic64_read(&hpriv->ctx->dram_phys_mem);
 
 	return copy_to_user(out, &dram_usage,
 		min((size_t) max_size, sizeof(dram_usage))) ? -EFAULT : 0;
@@ -225,7 +226,7 @@ static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
 
 	case HL_INFO_DRAM_USAGE:
-		rc = dram_usage_info(hdev, args);
+		rc = dram_usage_info(hpriv, args);
 		break;
 
 	case HL_INFO_HW_IDLE:
-- 
2.17.1

