Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C61C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BCD2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVv+Q1zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfD2LyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:54:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46072 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2LyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:54:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so15549247wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 04:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hTlAYkqUJVcd5qp1ARHHpavwgTPY9c+QQ/GLw3lnEQ0=;
        b=BVv+Q1zxd9TtrRdH8FXoNo9vMB7XYlZ/cg9u0xcO0bzyCPVqNR6Cx0w17Uu/dtV1Et
         P6EEM/pMKw7TZhZRb02j1xB3piOLKmVJ5YDv2JcetHwQ3or1Nq1jwhZmIR2dDVZUmnnH
         Sb/FwT0jnY5xnf30a0yr+hajCFkQb4dF+uo91MOedhOdYrVV2khQuiWuWNAoG3MTyj2Y
         K5SGvDYubE3WL33VMjgMGOQoCBkUzMzwi6w9sMOyDhq6Z3y10VsrQRJ7PYQ9zp7J0wcw
         HeAsMJC4dfdFjTR39gRSXR2LpG0NilGbYCCnbuGQ3xMyLqU+agaVSOjFY0boKwA913k5
         EWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hTlAYkqUJVcd5qp1ARHHpavwgTPY9c+QQ/GLw3lnEQ0=;
        b=PchgR/z0UUP4ACfz7Ihn+SikjMMdUsr19KF371no6jz+V/QfgUYisVUNGnhLJLrbOq
         H5SACtqalYohwsFXANrOBYaJ2pq/YCSU38bXrZQ+bRgFv0t7PtpRMJKwgdm4+zMBcLm0
         utbuM7JurcHxxE9fdF8V8MXYCNLqCjxXFvAaew0DA08ZV7JwbeHd2RZlaUDKNUP/xIN5
         1t7NoVlXOFoAX/xBIEyucj87eZQ45JoZfD+LNKbGA40aWl4HSRd7dOwzSZC3e/GH24CX
         Bvfe6pmvM9OcyVrCRkMVCjSQ5tuYyyp0ji0IhBucs8XOmxa0XyrQUxAbM0ubI4Jb54z+
         TAMQ==
X-Gm-Message-State: APjAAAWrHfULRDmw76eQVkEynNtLKVoyaah+o5V7L0zn6h+VsXkAXLZj
        62EYYsJBT1iB+A0wbS29Z6flMx2z
X-Google-Smtp-Source: APXvYqzx85sX7KLrWYnWdyJyG1gXwZVsZu0Fqo0CxmTGLTglgmzdvC8KghFa6rY3b+r4JO/LoI/ykg==
X-Received: by 2002:adf:f14e:: with SMTP id y14mr24250249wro.276.1556538848152;
        Mon, 29 Apr 2019 04:54:08 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h16sm9527141wrb.31.2019.04.29.04.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 04:54:07 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 2/2] habanalabs: Use single pool for CPU accessible host memory
Date:   Mon, 29 Apr 2019 14:54:02 +0300
Message-Id: <20190429115402.8156-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429115402.8156-1-oded.gabbay@gmail.com>
References: <20190429115402.8156-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The device's CPU accessible memory on host is managed in a dedicated
pool, except for 2 regions - Primary Queue (PQ) and Event Queue (EQ) -
which are allocated from generic DMA pools.
Due to address length limitations of the CPU, the addresses of all these
memory regions must have the same MSBs starting at bit 40.
This patch modifies the allocation of the PQ and EQ to be also from the
dedicated pool, to ensure compliance with the limitation.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h       | 12 +++++++
 drivers/misc/habanalabs/hw_queue.c         | 40 ++++++++++++++++------
 drivers/misc/habanalabs/include/armcp_if.h |  8 -----
 drivers/misc/habanalabs/irq.c              | 10 +++---
 4 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 65717e4055da..687651db614c 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -321,6 +321,18 @@ struct hl_cs_job;
 #define HL_EQ_LENGTH			64
 #define HL_EQ_SIZE_IN_BYTES		(HL_EQ_LENGTH * HL_EQ_ENTRY_SIZE)
 
+#define HL_CPU_PKT_SHIFT		5
+#define HL_CPU_PKT_SIZE			(1 << HL_CPU_PKT_SHIFT)
+#define HL_CPU_PKT_MASK			(~((1 << HL_CPU_PKT_SHIFT) - 1))
+#define HL_CPU_MAX_PKTS_IN_CB		32
+#define HL_CPU_CB_SIZE			(HL_CPU_PKT_SIZE * \
+					 HL_CPU_MAX_PKTS_IN_CB)
+#define HL_CPU_CB_QUEUE_SIZE		(HL_QUEUE_LENGTH * HL_CPU_CB_SIZE)
+
+/* KMD <-> ArmCP shared memory size (EQ + PQ + CPU CB queue) */
+#define HL_CPU_ACCESSIBLE_MEM_SIZE	(HL_EQ_SIZE_IN_BYTES + \
+					 HL_QUEUE_SIZE_IN_BYTES + \
+					 HL_CPU_CB_QUEUE_SIZE)
 
 /**
  * struct hl_hw_queue - describes a H/W transport queue.
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index ef3bb6951360..a1ee52cfd505 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -415,14 +415,20 @@ void hl_hw_queue_inc_ci_kernel(struct hl_device *hdev, u32 hw_queue_id)
 }
 
 static int ext_and_cpu_hw_queue_init(struct hl_device *hdev,
-					struct hl_hw_queue *q)
+				struct hl_hw_queue *q, bool is_cpu_queue)
 {
 	void *p;
 	int rc;
 
-	p = hdev->asic_funcs->dma_alloc_coherent(hdev,
-				HL_QUEUE_SIZE_IN_BYTES,
-				&q->bus_address, GFP_KERNEL | __GFP_ZERO);
+	if (is_cpu_queue)
+		p = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
+							HL_QUEUE_SIZE_IN_BYTES,
+							&q->bus_address);
+	else
+		p = hdev->asic_funcs->dma_alloc_coherent(hdev,
+						HL_QUEUE_SIZE_IN_BYTES,
+						&q->bus_address,
+						GFP_KERNEL | __GFP_ZERO);
 	if (!p)
 		return -ENOMEM;
 
@@ -446,8 +452,15 @@ static int ext_and_cpu_hw_queue_init(struct hl_device *hdev,
 	return 0;
 
 free_queue:
-	hdev->asic_funcs->dma_free_coherent(hdev, HL_QUEUE_SIZE_IN_BYTES,
-			(void *) (uintptr_t) q->kernel_address, q->bus_address);
+	if (is_cpu_queue)
+		hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
+					HL_QUEUE_SIZE_IN_BYTES,
+					(void *) (uintptr_t) q->kernel_address);
+	else
+		hdev->asic_funcs->dma_free_coherent(hdev,
+					HL_QUEUE_SIZE_IN_BYTES,
+					(void *) (uintptr_t) q->kernel_address,
+					q->bus_address);
 
 	return rc;
 }
@@ -474,12 +487,12 @@ static int int_hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 
 static int cpu_hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 {
-	return ext_and_cpu_hw_queue_init(hdev, q);
+	return ext_and_cpu_hw_queue_init(hdev, q, true);
 }
 
 static int ext_hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 {
-	return ext_and_cpu_hw_queue_init(hdev, q);
+	return ext_and_cpu_hw_queue_init(hdev, q, false);
 }
 
 /*
@@ -569,8 +582,15 @@ static void hw_queue_fini(struct hl_device *hdev, struct hl_hw_queue *q)
 
 	kfree(q->shadow_queue);
 
-	hdev->asic_funcs->dma_free_coherent(hdev, HL_QUEUE_SIZE_IN_BYTES,
-			(void *) (uintptr_t) q->kernel_address, q->bus_address);
+	if (q->queue_type == QUEUE_TYPE_CPU)
+		hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
+					HL_QUEUE_SIZE_IN_BYTES,
+					(void *) (uintptr_t) q->kernel_address);
+	else
+		hdev->asic_funcs->dma_free_coherent(hdev,
+					HL_QUEUE_SIZE_IN_BYTES,
+					(void *) (uintptr_t) q->kernel_address,
+					q->bus_address);
 }
 
 int hl_hw_queues_create(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index c8f28cadc335..1f1e35e86d84 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -300,14 +300,6 @@ enum armcp_pwm_attributes {
 	armcp_pwm_enable
 };
 
-#define HL_CPU_PKT_SHIFT		5
-#define HL_CPU_PKT_SIZE			(1 << HL_CPU_PKT_SHIFT)
-#define HL_CPU_PKT_MASK			(~((1 << HL_CPU_PKT_SHIFT) - 1))
-#define HL_CPU_MAX_PKTS_IN_CB		32
-#define HL_CPU_CB_SIZE			(HL_CPU_PKT_SIZE * \
-					 HL_CPU_MAX_PKTS_IN_CB)
-#define HL_CPU_ACCESSIBLE_MEM_SIZE	(HL_QUEUE_LENGTH * HL_CPU_CB_SIZE)
-
 /* Event Queue Packets */
 
 struct eq_generic_event {
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index e69a09c10e3f..86a8ad57f1ca 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -284,8 +284,9 @@ int hl_eq_init(struct hl_device *hdev, struct hl_eq *q)
 
 	BUILD_BUG_ON(HL_EQ_SIZE_IN_BYTES > HL_PAGE_SIZE);
 
-	p = hdev->asic_funcs->dma_alloc_coherent(hdev, HL_EQ_SIZE_IN_BYTES,
-				&q->bus_address, GFP_KERNEL | __GFP_ZERO);
+	p = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
+							HL_EQ_SIZE_IN_BYTES,
+							&q->bus_address);
 	if (!p)
 		return -ENOMEM;
 
@@ -308,8 +309,9 @@ void hl_eq_fini(struct hl_device *hdev, struct hl_eq *q)
 {
 	flush_workqueue(hdev->eq_wq);
 
-	hdev->asic_funcs->dma_free_coherent(hdev, HL_EQ_SIZE_IN_BYTES,
-			(void *) (uintptr_t) q->kernel_address, q->bus_address);
+	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
+					HL_EQ_SIZE_IN_BYTES,
+					(void *) (uintptr_t) q->kernel_address);
 }
 
 void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q)
-- 
2.17.1

