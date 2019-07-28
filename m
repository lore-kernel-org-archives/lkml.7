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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4C9C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B162075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgcPaYwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfG1L22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:28:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54498 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfG1L20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:28:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so51392370wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Aex8/bjQHQ2mMrv5wJYf1+paawvY2AFIWalPtjXVtVs=;
        b=HgcPaYwaE3g1jQHwYXlOsjN43bLWeN6FkO9LOKfuAT+LnrESRZTErgxw9/sFk4BBkK
         h7zBvjX67vA3IoUTGkIl53zH0gYupfkAd2jb+HMAZWfE5+7lBaa7d0a/DiO4Ve9x/I5X
         hiOWdRTfYfsfjWhrjpaPPzBf3280gab0eh/HLtN19IjPpKXyQGHXnCdtMoHgWyPIWT9r
         LnchIh6m0QtWloGBETLya7VMe0C6SgdTTxAir9WX7Z/E/925/sc0pP/y8DapjmVO5bs+
         HVUOiYtc+I8RrLcDqrubAkTgcTAPjN52+D8oeSqb6ZjNpZGmdtIklwfO8mFEgeLsl5x6
         gcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Aex8/bjQHQ2mMrv5wJYf1+paawvY2AFIWalPtjXVtVs=;
        b=qq0MVBU6hFYvcOo164Ih9qxmtGWVO2b3Xb9Fsnu2Ium+3GRj6H5zUMXjEmHu+DcDpq
         aD0/013YypGxGOHHdUGiOHw0kROxMbpbk36uEmqpO5sQhCYIPKI6IPRZ4jKW/QAApm6O
         /4kMCo2cA8oZf6YJcs1W6uIGn9lhHcbmSPLaCNSuuBpb1MktuNXnfvNf/5blkuMGeI27
         uHjmkmdCAtz2sA0XzmU1Jp0A5qUEJ1GQsgduXbfC1dAUcs4DQE8lZ5tkBdv/G9QyilQ6
         XhV79+GGLN+Hjf2ouN0sCQBa6e9buAzFF1NaWVKPHkVipE1o3gzlRbXq2A9N5TPnD7T7
         ARAQ==
X-Gm-Message-State: APjAAAVMTOBeUVP/cM50pBihKuhQ37Km9TrR8Oil4f0rwzNb8ZqYVeQX
        jHqrcnzMSqo1XSfQwghf+P3pF797kVc=
X-Google-Smtp-Source: APXvYqyACGHLD0JCEe9aJjC2/9KBUZ0RoJQaOUxaKMrquehbJU5+c2ZZCi9kguv9rqZcGL6bqPcJ5g==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr97611563wmh.68.1564313303787;
        Sun, 28 Jul 2019 04:28:23 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r12sm69805174wrt.95.2019.07.28.04.28.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 04:28:23 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 2/9] habanalabs: verify context is valid in IOCTLs
Date:   Sun, 28 Jul 2019 14:28:11 +0300
Message-Id: <20190728112818.30397-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190728112818.30397-1-oded.gabbay@gmail.com>
References: <20190728112818.30397-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds to most IOCTL operations a check of whether the calling
process has a valid context.

This is in preparation for when contexts will be created by the user and
not the driver.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_buffer.c     |  6 ++++++
 drivers/misc/habanalabs/command_submission.c | 12 ++++++++++++
 drivers/misc/habanalabs/context.c            |  7 ++++++-
 drivers/misc/habanalabs/habanalabs.h         |  5 +++--
 drivers/misc/habanalabs/habanalabs_ioctl.c   | 12 ++++++++++++
 drivers/misc/habanalabs/memory.c             |  6 ++++++
 6 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
index e495f44064fa..981caa8ec068 100644
--- a/drivers/misc/habanalabs/command_buffer.c
+++ b/drivers/misc/habanalabs/command_buffer.c
@@ -221,6 +221,12 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 		return -EBUSY;
 	}
 
+	if (!hl_ctx_is_valid(hpriv)) {
+		dev_err_ratelimited(hdev->dev,
+			"Can't execute CB IOCTL, missing a valid context\n");
+		return -EACCES;
+	}
+
 	switch (args->in.op) {
 	case HL_CB_OP_CREATE:
 		rc = hl_cb_create(hdev, &hpriv->cb_mgr, args->in.cb_size,
diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index f4e2c2ad0057..56910dee6026 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -613,6 +613,12 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		goto out;
 	}
 
+	if (!hl_ctx_is_valid(hpriv)) {
+		dev_err_ratelimited(hdev->dev,
+			"Can't execute CS IOCTL, missing a valid context\n");
+		return -EACCES;
+	}
+
 	do_ctx_switch = atomic_cmpxchg(&ctx->thread_ctx_switch_token, 1, 0);
 
 	if (do_ctx_switch || (args->in.cs_flags & HL_CS_FLAGS_FORCE_RESTORE)) {
@@ -759,6 +765,12 @@ int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	u64 seq = args->in.seq;
 	long rc;
 
+	if (!hl_ctx_is_valid(hpriv)) {
+		dev_err_ratelimited(hdev->dev,
+			"Can't execute WAIT_CS IOCTL, missing a valid context\n");
+		return -EACCES;
+	}
+
 	rc = _hl_cs_wait_ioctl(hdev, hpriv->ctx, args->in.timeout_us, seq);
 
 	memset(args, 0, sizeof(*args));
diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 1d8390418234..771a1055e67b 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -85,7 +85,7 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 	hl_hpriv_get(hpriv);
 	ctx->hpriv = hpriv;
 
-	/* TODO: remove for multiple contexts */
+	/* TODO: remove for multiple contexts per process */
 	hpriv->ctx = ctx;
 	hdev->user_ctx = ctx;
 
@@ -196,6 +196,11 @@ struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
 	return fence;
 }
 
+bool hl_ctx_is_valid(struct hl_fpriv *hpriv)
+{
+	return hpriv->ctx ? true : false;
+}
+
 /*
  * hl_ctx_mgr_init - initialize the context manager
  *
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index e41800e68578..475cdaa0005e 100644
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
@@ -1422,6 +1422,7 @@ int hl_ctx_put(struct hl_ctx *ctx);
 struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq);
 void hl_ctx_mgr_init(struct hl_ctx_mgr *mgr);
 void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr);
+bool hl_ctx_is_valid(struct hl_fpriv *hpriv);
 
 int hl_device_init(struct hl_device *hdev, struct class *hclass);
 void hl_device_fini(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 07127576b3e8..60b18af66283 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -208,6 +208,12 @@ static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 		return -EBUSY;
 	}
 
+	if (!hl_ctx_is_valid(hpriv)) {
+		dev_err_ratelimited(hdev->dev,
+			"Can't execute INFO IOCTL, missing a valid context\n");
+		return -EACCES;
+	}
+
 	switch (args->op) {
 	case HL_INFO_HW_IP_INFO:
 		rc = hw_ip_info(hdev, args);
@@ -247,6 +253,12 @@ static int hl_debug_ioctl(struct hl_fpriv *hpriv, void *data)
 		return -EBUSY;
 	}
 
+	if (!hl_ctx_is_valid(hpriv)) {
+		dev_err_ratelimited(hdev->dev,
+			"Can't execute DEBUG IOCTL, missing a valid context\n");
+		return -EACCES;
+	}
+
 	switch (args->op) {
 	case HL_DEBUG_OP_ETR:
 	case HL_DEBUG_OP_ETF:
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 42d237cae1dc..fddbca623bd2 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1154,6 +1154,12 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 		return -EBUSY;
 	}
 
+	if (!hl_ctx_is_valid(hpriv)) {
+		dev_err_ratelimited(hdev->dev,
+			"Can't execute MEMORY IOCTL, missing a valid context\n");
+		return -EACCES;
+	}
+
 	if (!hdev->mmu_enable)
 		return mem_ioctl_no_mmu(hpriv, args);
 
-- 
2.17.1

