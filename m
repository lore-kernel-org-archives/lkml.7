Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E0FC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6B621743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5z6INfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfEAJ6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 05:58:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39764 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAJ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 05:58:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id a9so24071566wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gEdBTX6l+ej85SbelOT/3IOgpG4+rcUAV0fYp4Yq4ps=;
        b=N5z6INfuWj1sRSm4TT/lVF71yWeCsVSxH9cwO9cW+/7yxg8DMF/a0rY+iegrstiAC2
         GOjjuHeW6ARH7VXTlVaYoC98BrIRBmu7QnQnToH8rnC7TLX7NvHTO8K5G7ug7waRg+vw
         pUBlVb1gV7AsJj5hpJ8OBDnYBUX6uxyP//FOIeYkaciUPEoMd/fRIjlOMaOZeEizLchb
         vVlfxk2X7Y/Ty0HlKHCkVKsOpZtS5zBTtVczhBjlhWlPPgZW/SD8R8ozbhfxPl07Fq/v
         dGyzz1ghY2U8XzStxpWTg6oYyAeMOvFp3leoVJoAry4aIzkcwAhHvmofIN0wXctidKCK
         K37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gEdBTX6l+ej85SbelOT/3IOgpG4+rcUAV0fYp4Yq4ps=;
        b=RUhp8NftXFfbXz40E9vbPGIfrHQKa76vU0CerB0niBL0zKRviG54gAwg0ojevTAipR
         mOg0B/HYTQw9tcVjvzYnPrfFxtkoNk5hy12So/RHSwGYQHPtP30spazKt4ZAjdnPdrsK
         47+xFD33EeyPRxtI+nYUfcrwQ4ZTxXDc5DeCp8c+SYJ27CSzh3xiJ4VzTC5YEtnOagTp
         E2VOuHk8t4tPmAwVc7Kh842Oimb5jrXJOWEaDLbM7CZYjqwlNXgEkN3lr/G1ZLV+wXqn
         iZp5S2hjnTpDh0RjO7E7T3TioJ9SI1wIX3yi9BH1BTylwDddK3F3Vu2CP1F3WOl4qU07
         g/FA==
X-Gm-Message-State: APjAAAXfwOq0DdmzQ9egGKy3JdOBZ57GRx7Rnxwev5Z9xoKwHTs0zU+5
        039XAIcKtgW0NvxK/1chE4M/1Jni
X-Google-Smtp-Source: APXvYqy95jTsG/AXWT7TWKsaR9atCRDCDrpeXiE8rVBEosK5HECiF0mm+jUxKiM6fNIWvYnunzHdaA==
X-Received: by 2002:adf:dcc7:: with SMTP id x7mr12691688wrm.197.1556704695913;
        Wed, 01 May 2019 02:58:15 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c18sm17683519wrb.16.2019.05.01.02.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 02:58:14 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/2] habanalabs: rename functions to improve code readability
Date:   Wed,  1 May 2019 12:58:09 +0300
Message-Id: <20190501095809.6956-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501095809.6956-1-oded.gabbay@gmail.com>
References: <20190501095809.6956-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames four functions in the ASIC-specific functions section,
so it will be easier to differentiate them from the generic kernel
functions with the same name.

This will help in future code reviews, to make sure we don't use the
kernel functions directly.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_buffer.c |  6 ++---
 drivers/misc/habanalabs/goya/goya.c      | 28 ++++++++++++----------
 drivers/misc/habanalabs/habanalabs.h     | 30 ++++++++++++------------
 drivers/misc/habanalabs/hw_queue.c       |  6 ++---
 drivers/misc/habanalabs/irq.c            |  4 ++--
 5 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
index b1ffca47d748..e495f44064fa 100644
--- a/drivers/misc/habanalabs/command_buffer.c
+++ b/drivers/misc/habanalabs/command_buffer.c
@@ -13,7 +13,7 @@
 
 static void cb_fini(struct hl_device *hdev, struct hl_cb *cb)
 {
-	hdev->asic_funcs->dma_free_coherent(hdev, cb->size,
+	hdev->asic_funcs->asic_dma_free_coherent(hdev, cb->size,
 			(void *) (uintptr_t) cb->kernel_address,
 			cb->bus_address);
 	kfree(cb);
@@ -66,10 +66,10 @@ static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
 		return NULL;
 
 	if (ctx_id == HL_KERNEL_ASID_ID)
-		p = hdev->asic_funcs->dma_alloc_coherent(hdev, cb_size,
+		p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, cb_size,
 						&cb->bus_address, GFP_ATOMIC);
 	else
-		p = hdev->asic_funcs->dma_alloc_coherent(hdev, cb_size,
+		p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, cb_size,
 						&cb->bus_address,
 						GFP_USER | __GFP_ZERO);
 	if (!p) {
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 9fc8b6e1369d..8e18c80a22e7 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -646,7 +646,7 @@ static int goya_sw_init(struct hl_device *hdev)
 	}
 
 	hdev->cpu_accessible_dma_mem =
-			hdev->asic_funcs->dma_alloc_coherent(hdev,
+			hdev->asic_funcs->asic_dma_alloc_coherent(hdev,
 					HL_CPU_ACCESSIBLE_MEM_SIZE,
 					&hdev->cpu_accessible_dma_address,
 					GFP_KERNEL | __GFP_ZERO);
@@ -681,7 +681,8 @@ static int goya_sw_init(struct hl_device *hdev)
 free_cpu_pq_pool:
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 free_cpu_pq_dma_mem:
-	hdev->asic_funcs->dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE,
+	hdev->asic_funcs->asic_dma_free_coherent(hdev,
+			HL_CPU_ACCESSIBLE_MEM_SIZE,
 			hdev->cpu_accessible_dma_mem,
 			hdev->cpu_accessible_dma_address);
 free_dma_pool:
@@ -704,7 +705,8 @@ static int goya_sw_fini(struct hl_device *hdev)
 
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 
-	hdev->asic_funcs->dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE,
+	hdev->asic_funcs->asic_dma_free_coherent(hdev,
+			HL_CPU_ACCESSIBLE_MEM_SIZE,
 			hdev->cpu_accessible_dma_mem,
 			hdev->cpu_accessible_dma_address);
 
@@ -2818,7 +2820,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 		return -EBUSY;
 	}
 
-	fence_ptr = hdev->asic_funcs->dma_pool_zalloc(hdev, 4, GFP_KERNEL,
+	fence_ptr = hdev->asic_funcs->asic_dma_pool_zalloc(hdev, 4, GFP_KERNEL,
 							&fence_dma_addr);
 	if (!fence_ptr) {
 		dev_err(hdev->dev,
@@ -2867,7 +2869,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 	}
 
 free_fence_ptr:
-	hdev->asic_funcs->dma_pool_free(hdev, (void *) fence_ptr,
+	hdev->asic_funcs->asic_dma_pool_free(hdev, (void *) fence_ptr,
 					fence_dma_addr);
 
 	goya_qman0_set_security(hdev, false);
@@ -2901,7 +2903,7 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 
 	fence_val = GOYA_QMAN0_FENCE_VAL;
 
-	fence_ptr = hdev->asic_funcs->dma_pool_zalloc(hdev, 4, GFP_KERNEL,
+	fence_ptr = hdev->asic_funcs->asic_dma_pool_zalloc(hdev, 4, GFP_KERNEL,
 							&fence_dma_addr);
 	if (!fence_ptr) {
 		dev_err(hdev->dev,
@@ -2911,7 +2913,7 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 
 	*fence_ptr = 0;
 
-	fence_pkt = hdev->asic_funcs->dma_pool_zalloc(hdev,
+	fence_pkt = hdev->asic_funcs->asic_dma_pool_zalloc(hdev,
 					sizeof(struct packet_msg_prot),
 					GFP_KERNEL, &pkt_dma_addr);
 	if (!fence_pkt) {
@@ -2955,10 +2957,10 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 	}
 
 free_pkt:
-	hdev->asic_funcs->dma_pool_free(hdev, (void *) fence_pkt,
+	hdev->asic_funcs->asic_dma_pool_free(hdev, (void *) fence_pkt,
 					pkt_dma_addr);
 free_fence_ptr:
-	hdev->asic_funcs->dma_pool_free(hdev, (void *) fence_ptr,
+	hdev->asic_funcs->asic_dma_pool_free(hdev, (void *) fence_ptr,
 					fence_dma_addr);
 	return rc;
 }
@@ -4755,12 +4757,12 @@ static const struct hl_asic_funcs goya_funcs = {
 	.cb_mmap = goya_cb_mmap,
 	.ring_doorbell = goya_ring_doorbell,
 	.flush_pq_write = goya_flush_pq_write,
-	.dma_alloc_coherent = goya_dma_alloc_coherent,
-	.dma_free_coherent = goya_dma_free_coherent,
+	.asic_dma_alloc_coherent = goya_dma_alloc_coherent,
+	.asic_dma_free_coherent = goya_dma_free_coherent,
 	.get_int_queue_base = goya_get_int_queue_base,
 	.test_queues = goya_test_queues,
-	.dma_pool_zalloc = goya_dma_pool_zalloc,
-	.dma_pool_free = goya_dma_pool_free,
+	.asic_dma_pool_zalloc = goya_dma_pool_zalloc,
+	.asic_dma_pool_free = goya_dma_pool_free,
 	.cpu_accessible_dma_pool_alloc = goya_cpu_accessible_dma_pool_alloc,
 	.cpu_accessible_dma_pool_free = goya_cpu_accessible_dma_pool_free,
 	.hl_dma_unmap_sg = goya_dma_unmap_sg,
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 687651db614c..b64594be6dbd 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -453,19 +453,19 @@ enum hl_pll_frequency {
  * @cb_mmap: maps a CB.
  * @ring_doorbell: increment PI on a given QMAN.
  * @flush_pq_write: flush PQ entry write if necessary, WARN if flushing failed.
- * @dma_alloc_coherent: Allocate coherent DMA memory by calling
- *                      dma_alloc_coherent(). This is ASIC function because its
- *                      implementation is not trivial when the driver is loaded
- *                      in simulation mode (not upstreamed).
- * @dma_free_coherent: Free coherent DMA memory by calling dma_free_coherent().
- *                     This is ASIC function because its implementation is not
- *                     trivial when the driver is loaded in simulation mode
- *                     (not upstreamed).
+ * @asic_dma_alloc_coherent: Allocate coherent DMA memory by calling
+ *                           dma_alloc_coherent(). This is ASIC function because
+ *                           its implementation is not trivial when the driver
+ *                           is loaded in simulation mode (not upstreamed).
+ * @asic_dma_free_coherent:  Free coherent DMA memory by calling
+ *                           dma_free_coherent(). This is ASIC function because
+ *                           its implementation is not trivial when the driver
+ *                           is loaded in simulation mode (not upstreamed).
  * @get_int_queue_base: get the internal queue base address.
  * @test_queues: run simple test on all queues for sanity check.
- * @dma_pool_zalloc: small DMA allocation of coherent memory from DMA pool.
- *                   size of allocation is HL_DMA_POOL_BLK_SIZE.
- * @dma_pool_free: free small DMA allocation from pool.
+ * @asic_dma_pool_zalloc: small DMA allocation of coherent memory from DMA pool.
+ *                        size of allocation is HL_DMA_POOL_BLK_SIZE.
+ * @asic_dma_pool_free: free small DMA allocation from pool.
  * @cpu_accessible_dma_pool_alloc: allocate CPU PQ packet from DMA pool.
  * @cpu_accessible_dma_pool_free: free CPU PQ packet from DMA pool.
  * @hl_dma_unmap_sg: DMA unmap scatter-gather list.
@@ -521,16 +521,16 @@ struct hl_asic_funcs {
 			u64 kaddress, phys_addr_t paddress, u32 size);
 	void (*ring_doorbell)(struct hl_device *hdev, u32 hw_queue_id, u32 pi);
 	void (*flush_pq_write)(struct hl_device *hdev, u64 *pq, u64 exp_val);
-	void* (*dma_alloc_coherent)(struct hl_device *hdev, size_t size,
+	void* (*asic_dma_alloc_coherent)(struct hl_device *hdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flag);
-	void (*dma_free_coherent)(struct hl_device *hdev, size_t size,
+	void (*asic_dma_free_coherent)(struct hl_device *hdev, size_t size,
 					void *cpu_addr, dma_addr_t dma_handle);
 	void* (*get_int_queue_base)(struct hl_device *hdev, u32 queue_id,
 				dma_addr_t *dma_handle, u16 *queue_len);
 	int (*test_queues)(struct hl_device *hdev);
-	void* (*dma_pool_zalloc)(struct hl_device *hdev, size_t size,
+	void* (*asic_dma_pool_zalloc)(struct hl_device *hdev, size_t size,
 				gfp_t mem_flags, dma_addr_t *dma_handle);
-	void (*dma_pool_free)(struct hl_device *hdev, void *vaddr,
+	void (*asic_dma_pool_free)(struct hl_device *hdev, void *vaddr,
 				dma_addr_t dma_addr);
 	void* (*cpu_accessible_dma_pool_alloc)(struct hl_device *hdev,
 				size_t size, dma_addr_t *dma_handle);
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index a1ee52cfd505..6cdaa117fc40 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -425,7 +425,7 @@ static int ext_and_cpu_hw_queue_init(struct hl_device *hdev,
 							HL_QUEUE_SIZE_IN_BYTES,
 							&q->bus_address);
 	else
-		p = hdev->asic_funcs->dma_alloc_coherent(hdev,
+		p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev,
 						HL_QUEUE_SIZE_IN_BYTES,
 						&q->bus_address,
 						GFP_KERNEL | __GFP_ZERO);
@@ -457,7 +457,7 @@ static int ext_and_cpu_hw_queue_init(struct hl_device *hdev,
 					HL_QUEUE_SIZE_IN_BYTES,
 					(void *) (uintptr_t) q->kernel_address);
 	else
-		hdev->asic_funcs->dma_free_coherent(hdev,
+		hdev->asic_funcs->asic_dma_free_coherent(hdev,
 					HL_QUEUE_SIZE_IN_BYTES,
 					(void *) (uintptr_t) q->kernel_address,
 					q->bus_address);
@@ -587,7 +587,7 @@ static void hw_queue_fini(struct hl_device *hdev, struct hl_hw_queue *q)
 					HL_QUEUE_SIZE_IN_BYTES,
 					(void *) (uintptr_t) q->kernel_address);
 	else
-		hdev->asic_funcs->dma_free_coherent(hdev,
+		hdev->asic_funcs->asic_dma_free_coherent(hdev,
 					HL_QUEUE_SIZE_IN_BYTES,
 					(void *) (uintptr_t) q->kernel_address,
 					q->bus_address);
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index 86a8ad57f1ca..ea9f72ff456c 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -222,7 +222,7 @@ int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id)
 
 	BUILD_BUG_ON(HL_CQ_SIZE_IN_BYTES > HL_PAGE_SIZE);
 
-	p = hdev->asic_funcs->dma_alloc_coherent(hdev, HL_CQ_SIZE_IN_BYTES,
+	p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, HL_CQ_SIZE_IN_BYTES,
 				&q->bus_address, GFP_KERNEL | __GFP_ZERO);
 	if (!p)
 		return -ENOMEM;
@@ -248,7 +248,7 @@ int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id)
  */
 void hl_cq_fini(struct hl_device *hdev, struct hl_cq *q)
 {
-	hdev->asic_funcs->dma_free_coherent(hdev, HL_CQ_SIZE_IN_BYTES,
+	hdev->asic_funcs->asic_dma_free_coherent(hdev, HL_CQ_SIZE_IN_BYTES,
 			(void *) (uintptr_t) q->kernel_address, q->bus_address);
 }
 
-- 
2.17.1

