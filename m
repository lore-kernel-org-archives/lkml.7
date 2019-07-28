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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C815FC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986622075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LufTr581"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfG1L2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:28:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37860 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfG1L21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:28:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so51065501wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=4V0uhU4/h95u0kDZ/b4u9pdh78z3YrDuWCpr9O5FaDY=;
        b=LufTr581YX+oLVflDvVHPNoF+1vvxQhQwoMrvmZUnfT1vzfnUl7r657HA58NuwKEWv
         wDzx6M6DGzoMUm4zpzgwqQru83fZjTB44irazU401sEWr/dIo+zeyDIGbA5FXWybvhy4
         EgNNX7FDl6hJ3pyrKVuhz0M2IBw6QSwJegmUResVKDT3xM/4eG8wsPLJowdpDlTnyXKe
         R8A99gih+AjNGULg8oP1yqjEeb42VFmPCZbEykz204qpVW0Fd9AQR1Wa2f/ydfYTMmsZ
         +3R9nT1UTIXsTyEihQVKeIDpEQ09893yWkWIYhJAWq+193HB4cLohcKXfNcQO2Oo5YOh
         GESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=4V0uhU4/h95u0kDZ/b4u9pdh78z3YrDuWCpr9O5FaDY=;
        b=tPHi8pr39UUsuumolpCtYJYENjVPEe6fgONn+daks8vqb2UcfyTtDChG0lYRvosN+6
         bc0snWAF0qxWRYqb42w02RFOYn9GODk3HrCx9PxQoEdwKmfcbXeY1YcqsRhlKxBAhvj1
         ZdUYWLzexFG/X2CiymTyrAf9zjFwKd0s36sD58gRSeFc7PfuoU2EbDtLx5fbF814wNR7
         P5O2mJZc/spdmwhdYrcgF1VCt7vUDBctso5x3SDuMGQ83zxup+opSISMf7FFTvJh1o/L
         av5YeDATBMIQ+hozTv/CGrVYUMO6kWtodVpOZydQAzh12Lgy1mUDqceowM5unAGhb7/3
         hf0Q==
X-Gm-Message-State: APjAAAWX+C7duTJsfiWOcIMdsEx8EnPuyabq1o2DGZw9BHKY878yH2hw
        rtl3Hs9qQudMJX39xJrBYhOFbdEuXlE=
X-Google-Smtp-Source: APXvYqxJ0wq6DUXB0Oh+mHulIFGm1rntTE3alBTF0oY0ELPrAXgG+z5lFYvgl7xX9PdbGpbX5BgDUQ==
X-Received: by 2002:a1c:e009:: with SMTP id x9mr93124699wmg.5.1564313305101;
        Sun, 28 Jul 2019 04:28:25 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r12sm69805174wrt.95.2019.07.28.04.28.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 04:28:24 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 3/9] habanalabs: create context in lazy mode
Date:   Sun, 28 Jul 2019 14:28:12 +0300
Message-Id: <20190728112818.30397-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190728112818.30397-1-oded.gabbay@gmail.com>
References: <20190728112818.30397-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of creating the context when the user opens the device, create the
context when the first IOCTL that needs a context is called.

This change is required to provide backward compatibility for older
user-space when the driver will require the user to create a context.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/context.c        | 29 +++++++++++++++++++++++-
 drivers/misc/habanalabs/device.c         |  5 +++-
 drivers/misc/habanalabs/habanalabs.h     |  2 ++
 drivers/misc/habanalabs/habanalabs_drv.c | 13 -----------
 4 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 771a1055e67b..3c1f7c29e908 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -198,7 +198,34 @@ struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
 
 bool hl_ctx_is_valid(struct hl_fpriv *hpriv)
 {
-	return hpriv->ctx ? true : false;
+	struct hl_device *hdev = hpriv->hdev;
+	bool valid = true;
+	int rc;
+
+	/* First thing, to minimize latency impact, check if context exists.
+	 * If so, exit immediately
+	 */
+	if (hpriv->ctx)
+		return true;
+
+	mutex_lock(&hdev->lazy_ctx_creation_lock);
+
+	/* We must check again the existence of the context. This is because
+	 * there could be competing threads in the same process that call
+	 * IOCTLs at the same time. In this case, we must protect against double
+	 * creation of a context
+	 */
+	if (!hpriv->ctx) {
+		rc = hl_ctx_create(hdev, hpriv);
+		if (rc) {
+			dev_err(hdev->dev, "Failed to create context %d\n", rc);
+			valid = false;
+		}
+	}
+
+	mutex_unlock(&hdev->lazy_ctx_creation_lock);
+
+	return valid;
 }
 
 /*
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 0c4894dd9c02..b63beb73ec76 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -58,8 +58,9 @@ static void hpriv_release(struct kref *ref)
 	/* Now the FD is really closed */
 	atomic_dec(&hdev->fd_open_cnt);
 
-	/* This allows a new user context to open the device */
+	mutex_lock(&hdev->lazy_ctx_creation_lock);
 	hdev->user_ctx = NULL;
+	mutex_unlock(&hdev->lazy_ctx_creation_lock);
 }
 
 void hl_hpriv_get(struct hl_fpriv *hpriv)
@@ -233,6 +234,7 @@ static int device_early_init(struct hl_device *hdev)
 	mutex_init(&hdev->send_cpu_message_lock);
 	mutex_init(&hdev->debug_lock);
 	mutex_init(&hdev->mmu_cache_lock);
+	mutex_init(&hdev->lazy_ctx_creation_lock);
 	INIT_LIST_HEAD(&hdev->hw_queues_mirror_list);
 	spin_lock_init(&hdev->hw_queues_mirror_lock);
 	atomic_set(&hdev->in_reset, 0);
@@ -262,6 +264,7 @@ static int device_early_init(struct hl_device *hdev)
  */
 static void device_early_fini(struct hl_device *hdev)
 {
+	mutex_destroy(&hdev->lazy_ctx_creation_lock);
 	mutex_destroy(&hdev->mmu_cache_lock);
 	mutex_destroy(&hdev->debug_lock);
 	mutex_destroy(&hdev->send_cpu_message_lock);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 475cdaa0005e..d0e55839d673 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1183,6 +1183,7 @@ struct hl_device_reset_work {
  * @cb_pool: list of preallocated CBs.
  * @cb_pool_lock: protects the CB pool.
  * @user_ctx: current user context executing.
+ * @lazy_ctx_creation_lock: lock to protect lazy creation of context
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -1261,6 +1262,7 @@ struct hl_device {
 
 	/* TODO: remove user_ctx for multiple process support */
 	struct hl_ctx			*user_ctx;
+	struct mutex			lazy_ctx_creation_lock;
 
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 678f61646ca9..b2c52e46e130 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -141,12 +141,6 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	hl_cb_mgr_init(&hpriv->cb_mgr);
 	hl_ctx_mgr_init(&hpriv->ctx_mgr);
 
-	rc = hl_ctx_create(hdev, hpriv);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to open FD (CTX fail)\n");
-		goto out_err;
-	}
-
 	hpriv->taskpid = find_get_pid(current->pid);
 
 	/*
@@ -160,13 +154,6 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	return 0;
 
-out_err:
-	filp->private_data = NULL;
-	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
-	hl_cb_mgr_fini(hpriv->hdev, &hpriv->cb_mgr);
-	mutex_destroy(&hpriv->restore_phase_mutex);
-	kfree(hpriv);
-
 close_device:
 	atomic_dec(&hdev->fd_open_cnt);
 	return rc;
-- 
2.17.1

