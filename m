Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373DDC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8B1206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azV7dc2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfDYRWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:22:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53247 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfDYRWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:22:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id j13so287222wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bwv4et5cUu4faqc6blPlhyIKYfhBsbfiMqT2Sv67ZlU=;
        b=azV7dc2V7nv8zLnV545xER2aN+rli+MZMvaS+tpq/65nO08rTw3iMrVUYhTHdOl6Nd
         okwIXzklNi68w89CA7OKHzsxQW2AqHf/Hs6BZVx5vNofnd+/WpagIucKRlD5kP6R2Z4w
         QV3LQTMqfAwcMP6U5z16tLBTklkF5InKP8/brGYRO/9vzeS3VeNbNIsBzgzgS6jK6F5c
         SMMAyNyh3/kxgbrHcWzsvogqCeK42PpM5Oz783Be7+9ZaolpBz2qDhhlbbeQXoOv/arC
         fFdu/7mdVUMtG0JRX8j6vN5KrWRmx51My78gDwgmmQF/06NpoJmkbCqICR+yeTqadNFO
         FbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bwv4et5cUu4faqc6blPlhyIKYfhBsbfiMqT2Sv67ZlU=;
        b=q2eoaQyaN2Kqz+nh+N/wM6s61jVEG15DDtrCbgBG3NtZhzjPg/pLyBLYhZjl7+Z+u6
         hIf4nTtO+88I3L/FaJkbaaZHCnxgsdTIDNnf4wSOEs0ciinBdREgscwVSopov64FQMBf
         jzmyAa7839jIvy/vrc7M3QXUiohZ2+2pW3i3kNstTwbsaXRdd2pOqykmbqTsioQ6QpE0
         bG5U0AkAaI3EgH7B9P3eIJ2myns10d6KohC/FDqiQcmaG041Kupf733R/JLis8WqileQ
         Wrm7EwZRNXbxFpUnwx8or+1jUwR2N7SlNFiedkpAiPt9XstXRbFw0xbW2V61z9dhAKse
         /TTA==
X-Gm-Message-State: APjAAAUXl96P/NiJinkePXotQJHd7WMjP8mvXpOetfXojp7GNd3IeNNi
        iqBx/mxo3zAJttDnDIPDsNSVXJz0
X-Google-Smtp-Source: APXvYqz7EteIkt1PinXdNJYyK68ANDqfYFXQItY39yT0oPGOUzzSOBWSj9JSbtj8W/8WBKxt6/5y8Q==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr4603942wmj.31.1556212937250;
        Thu, 25 Apr 2019 10:22:17 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id g132sm20624496wme.3.2019.04.25.10.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 10:22:16 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: rename restore to ctx_switch when appropriate
Date:   Thu, 25 Apr 2019 20:22:14 +0300
Message-Id: <20190425172214.6501-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only does renaming of certain variables and structure members,
and their accompanied comments.

This is done to better reflect the actions these variables and members
represent.

There is no functional change in this patch.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 16 ++++++++--------
 drivers/misc/habanalabs/context.c            |  4 ++--
 drivers/misc/habanalabs/device.c             |  6 +++---
 drivers/misc/habanalabs/habanalabs.h         | 17 +++++++++--------
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 02c48da0b645..c4ab694b51b5 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -601,7 +601,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 	void __user *chunks;
 	u32 num_chunks;
 	u64 cs_seq = ULONG_MAX;
-	int rc, do_restore;
+	int rc, do_ctx_switch;
 	bool need_soft_reset = false;
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
@@ -612,9 +612,9 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		goto out;
 	}
 
-	do_restore = atomic_cmpxchg(&ctx->thread_restore_token, 1, 0);
+	do_ctx_switch = atomic_cmpxchg(&ctx->thread_ctx_switch_token, 1, 0);
 
-	if (do_restore || (args->in.cs_flags & HL_CS_FLAGS_FORCE_RESTORE)) {
+	if (do_ctx_switch || (args->in.cs_flags & HL_CS_FLAGS_FORCE_RESTORE)) {
 		long ret;
 
 		chunks = (void __user *)(uintptr_t)args->in.chunks_restore;
@@ -622,7 +622,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 
 		mutex_lock(&hpriv->restore_phase_mutex);
 
-		if (do_restore) {
+		if (do_ctx_switch) {
 			rc = hdev->asic_funcs->context_switch(hdev, ctx->asid);
 			if (rc) {
 				dev_err_ratelimited(hdev->dev,
@@ -678,18 +678,18 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 			}
 		}
 
-		ctx->thread_restore_wait_token = 1;
-	} else if (!ctx->thread_restore_wait_token) {
+		ctx->thread_ctx_switch_wait_token = 1;
+	} else if (!ctx->thread_ctx_switch_wait_token) {
 		u32 tmp;
 
 		rc = hl_poll_timeout_memory(hdev,
-			(u64) (uintptr_t) &ctx->thread_restore_wait_token,
+			(u64) (uintptr_t) &ctx->thread_ctx_switch_wait_token,
 			jiffies_to_usecs(hdev->timeout_jiffies),
 			&tmp);
 
 		if (rc || !tmp) {
 			dev_err(hdev->dev,
-				"restore phase hasn't finished in time\n");
+				"context switch phase didn't finish in time\n");
 			rc = -ETIMEDOUT;
 			goto out;
 		}
diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 619ace1c4ef7..4804cdcf4c48 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -106,8 +106,8 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 
 	ctx->cs_sequence = 1;
 	spin_lock_init(&ctx->cs_lock);
-	atomic_set(&ctx->thread_restore_token, 1);
-	ctx->thread_restore_wait_token = 0;
+	atomic_set(&ctx->thread_ctx_switch_token, 1);
+	ctx->thread_ctx_switch_wait_token = 0;
 
 	if (is_kernel_ctx) {
 		ctx->asid = HL_KERNEL_ASID_ID; /* KMD gets ASID 0 */
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index a88f7be23c7f..0e0b9ec71c80 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -710,10 +710,10 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		hl_cq_reset(hdev, &hdev->completion_queue[i]);
 
-	/* Make sure the setup phase for the user context will run again */
+	/* Make sure the context switch phase will run again */
 	if (hdev->user_ctx) {
-		atomic_set(&hdev->user_ctx->thread_restore_token, 1);
-		hdev->user_ctx->thread_restore_wait_token = 0;
+		atomic_set(&hdev->user_ctx->thread_ctx_switch_token, 1);
+		hdev->user_ctx->thread_ctx_switch_wait_token = 0;
 	}
 
 	/* Finished tear-down, starting to re-initialize */
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index e8bbaf0f26c1..a624d1e1e1e5 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -615,12 +615,13 @@ struct hl_va_range {
  *                     DRAM mapping.
  * @cs_lock: spinlock to protect cs_sequence.
  * @dram_phys_mem: amount of used physical DRAM memory by this context.
- * @thread_restore_token: token to prevent multiple threads of the same context
- *				from running the restore phase. Only one thread
- *				should run it.
- * @thread_restore_wait_token: token to prevent the threads that didn't run
- *				the restore phase from moving to their execution
- *				phase before the restore phase has finished.
+ * @thread_ctx_switch_token: token to prevent multiple threads of the same
+ *				context	from running the context switch phase.
+ *				Only a single thread should run it.
+ * @thread_ctx_switch_wait_token: token to prevent the threads that didn't run
+ *				the context switch phase from moving to their
+ *				execution phase before the context switch phase
+ *				has finished.
  * @asid: context's unique address space ID in the device's MMU.
  */
 struct hl_ctx {
@@ -640,8 +641,8 @@ struct hl_ctx {
 	u64			*dram_default_hops;
 	spinlock_t		cs_lock;
 	atomic64_t		dram_phys_mem;
-	atomic_t		thread_restore_token;
-	u32			thread_restore_wait_token;
+	atomic_t		thread_ctx_switch_token;
+	u32			thread_ctx_switch_wait_token;
 	u32			asid;
 };
 
-- 
2.17.1

