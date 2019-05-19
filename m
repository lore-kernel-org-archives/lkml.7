Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F41BC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7291F20449
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVlQhWxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfESSTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 14:19:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40464 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfESSTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 14:19:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id 15so6778653wmg.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UWIwA4BOBfLVy7P2Ysfvi1FMBIPshq56DPWmogprASA=;
        b=NVlQhWxMgOtRkJzQkbPQN6JGt6YqktghV1uSgSiYGNgxGZt3YI/ZtqBn1HZ0rp5QTz
         dR2qJvH8fVzoGzcKtLc0xXdnTXF4nOJjQ85/s75TaCWq+tSbhuR/t2X4BLrIvm4rTNBi
         x8ov48EoZ5tsxugbXkwBzfOhF/rF03KH7ptBKPwHcheHo1yWV3KYDGsUuuSHgpd4sdVp
         Om8xS95lCk+N1YwvZDuY+fNZuyh080Evyx0QaMQkUVC/dIOlrjO7E2Je4WV5OfVEzWPm
         66xqkuiP/lyY+yQ4/nubcJ9WLvSeWUOiV9Vq/naRVCERkD+VvNGDgKu97+io+TaSNby0
         7iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UWIwA4BOBfLVy7P2Ysfvi1FMBIPshq56DPWmogprASA=;
        b=b2zGoagE4FtJVzOZz89KwT9HJD0nSVcsoEdln2qbRuw2REAqqyid983e6ZnKWLnqtw
         d/DMaC4jnrCecEfru54SnGkHph3T9UxZAwu3L0hmptZ1EElIlovizCc9qPUCAH56GPfe
         iB+sf2yfYPOCwfJm+k/6bdRzEQv2aZxIcEyCWe0ESm6kk9IVDu2NeidIcoGYCljDGKnL
         HAsqOTel0JwO+8Od6ncCXhk0N02YBvDQZ/vSjlFZaa77qeGUXvFOzEktnPgnZZjdn/qW
         4BCEn+Yq2p+076wUsbUmwNiUSBc9mNjH487kk6qKv2PRZEyleUI/TIakR1tdjzy/saBa
         LrUg==
X-Gm-Message-State: APjAAAXoXjYWbnESASWBaaYGOJSFbZ9+EO3r9q3sRWGsNS57RPvXb1if
        HR5Ts6/61NhiKfLFntqxKj3oYgZ2
X-Google-Smtp-Source: APXvYqxl9OGaDM9U37kFUIV7OCFQu3VVky5clmktcBUEMjsRB6Qg05oWE1a8NkAs5q3C93QYaHNWvw==
X-Received: by 2002:a1c:6783:: with SMTP id b125mr8112101wmc.79.1558264365331;
        Sun, 19 May 2019 04:12:45 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id s3sm26612570wre.97.2019.05.19.04.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 04:12:44 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/2] habanalabs: don't limit packet size for device CPU
Date:   Sun, 19 May 2019 14:12:41 +0300
Message-Id: <20190519111241.23359-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519111241.23359-1-oded.gabbay@gmail.com>
References: <20190519111241.23359-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a limitation on the maximum packet size that is read by
the device CPU as that limitation is not needed.

Therefore, the patch also removes an elaborate calculation that is based
on this limitation which is also not needed now. Instead, use a fixed
value for the memory pool size of the packets.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/firmware_if.c | 12 ------------
 drivers/misc/habanalabs/goya/goya.c   |  2 +-
 drivers/misc/habanalabs/habanalabs.h  | 12 ++----------
 3 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index 0cbdfa0d7fba..cc8168bacb24 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -85,12 +85,6 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 	u32 tmp;
 	int rc = 0;
 
-	if (len > HL_CPU_CB_SIZE) {
-		dev_err(hdev->dev, "Invalid CPU message size of %d bytes\n",
-			len);
-		return -ENOMEM;
-	}
-
 	pkt = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev, len,
 								&pkt_dma_addr);
 	if (!pkt) {
@@ -181,9 +175,6 @@ void *hl_fw_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
 {
 	u64 kernel_addr;
 
-	/* roundup to HL_CPU_PKT_SIZE */
-	size = (size + (HL_CPU_PKT_SIZE - 1)) & HL_CPU_PKT_MASK;
-
 	kernel_addr = gen_pool_alloc(hdev->cpu_accessible_dma_pool, size);
 
 	*dma_handle = hdev->cpu_accessible_dma_address +
@@ -195,9 +186,6 @@ void *hl_fw_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
 void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 					void *vaddr)
 {
-	/* roundup to HL_CPU_PKT_SIZE */
-	size = (size + (HL_CPU_PKT_SIZE - 1)) & HL_CPU_PKT_MASK;
-
 	gen_pool_free(hdev->cpu_accessible_dma_pool, (u64) (uintptr_t) vaddr,
 			size);
 }
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 6ee5db697ca5..e0fc511acaec 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -655,7 +655,7 @@ static int goya_sw_init(struct hl_device *hdev)
 		goto free_dma_pool;
 	}
 
-	hdev->cpu_accessible_dma_pool = gen_pool_create(HL_CPU_PKT_SHIFT, -1);
+	hdev->cpu_accessible_dma_pool = gen_pool_create(ilog2(32), -1);
 	if (!hdev->cpu_accessible_dma_pool) {
 		dev_err(hdev->dev,
 			"Failed to create CPU accessible DMA pool\n");
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 9b1c03f1ab32..0462b7727da7 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -320,18 +320,10 @@ struct hl_cs_job;
 #define HL_EQ_LENGTH			64
 #define HL_EQ_SIZE_IN_BYTES		(HL_EQ_LENGTH * HL_EQ_ENTRY_SIZE)
 
-#define HL_CPU_PKT_SHIFT		5
-#define HL_CPU_PKT_SIZE			(1 << HL_CPU_PKT_SHIFT)
-#define HL_CPU_PKT_MASK			(~((1 << HL_CPU_PKT_SHIFT) - 1))
-#define HL_CPU_MAX_PKTS_IN_CB		32
-#define HL_CPU_CB_SIZE			(HL_CPU_PKT_SIZE * \
-					 HL_CPU_MAX_PKTS_IN_CB)
-#define HL_CPU_CB_QUEUE_SIZE		(HL_QUEUE_LENGTH * HL_CPU_CB_SIZE)
-
-/* KMD <-> ArmCP shared memory size (EQ + PQ + CPU CB queue) */
+/* KMD <-> ArmCP shared memory size (EQ + PQ + 2MB for packets) */
 #define HL_CPU_ACCESSIBLE_MEM_SIZE	(HL_EQ_SIZE_IN_BYTES + \
 					 HL_QUEUE_SIZE_IN_BYTES + \
-					 HL_CPU_CB_QUEUE_SIZE)
+					 SZ_2M)
 
 /**
  * struct hl_hw_queue - describes a H/W transport queue.
-- 
2.17.1

