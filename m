Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D844EC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9641121743
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXiPzTER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfHJM3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 08:29:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33785 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHJM3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:29:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so100705540wru.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=spJElzY7kjLhrjMT5WS/OhSTdJ8Bv/vXy8bGwAmPiFM=;
        b=IXiPzTERXFLCOyyOgrt3dYXmfqObi+rHWIJpmnh9zdJGzeUCHrnwHPf7i8P7ceWlVh
         akibYEptevg66CZtKvLrvu6ckMEyawyAmcxvldxQpEAWigcFMY+jbUo328g7h6hd2Tfy
         9BK9GSbfu2GgwWPnJjXCwAMEOFxmskKdo0C3ClYvM56SvfDuBrvRrVjArj8XPR119g1x
         g/52fqrCZeXLB0nEIVKWo5a5B5Je3nFr+jNsXTzuleC/LMjCZAn7xd86wN8CbX9TWOYx
         bncI47MSjXHPKOd2VfTpRL79wCk1XPt1/pLNbDSjVqELG57389tpMvREAgPLlmSIdJgV
         OmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=spJElzY7kjLhrjMT5WS/OhSTdJ8Bv/vXy8bGwAmPiFM=;
        b=mhyMGQQh7kQwQhqeRdpGhYTb/JO6XuU9wG4TUNB0zXd+l2tdgg7Yz/RRWqQT9InFhu
         9LmnfPK+JeK8y9tIhWOj8kSwTzR3V5HQ9ahgYChxrJ6a5iLASIpmiqhoG69rPDFezSBJ
         x8RYhRm3IetwEXCkl8ffeEdnP9o9yvcZO6XNG8d6uAIX+xWu6b0zSpfS9uuTsqfIXmgU
         Ha3S4F/NneNATLzTnc4bNBUb1KgaWPkO16KgeDsO5L/4b50UM1ashPUi3JAAZk+oM+Fr
         KBy3eSOTH1uJ9y0F9E05fq7dhUPN4KFaXiclkOEVEtId+0JQ5LfeaqjYu7UV3rJVIsaR
         tZSQ==
X-Gm-Message-State: APjAAAXLQaOwKLcWLxXmg7jAoXl7rWAnkhqQ0PXx3u2MPe7U0lnldz3v
        SEnrl+y58Nk86emILDkWXbPT4GZJi+8=
X-Google-Smtp-Source: APXvYqxG0xfOllIE/MkSGeHZmstQsSReVx0FWbTAwUH1ZuUVHR6I6huxny/Rk2+55KK5O2HgbIc6DQ==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr29868296wrq.110.1565440188921;
        Sat, 10 Aug 2019 05:29:48 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k9sm48340057wrd.46.2019.08.10.05.29.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 05:29:48 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/2] habanalabs: fix endianness handling for internal QMAN submission
Date:   Sat, 10 Aug 2019 15:29:45 +0300
Message-Id: <20190810122946.28641-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PQs of internal H/W queues (QMANs) can be located in different memory
areas for different ASICs. Therefore, when writing PQEs, we need to use
the correct function according to the location of the PQ. e.g. if the PQ
is located in the device's memory (SRAM or DRAM), we need to use
memcpy_toio() so it would work in architectures that have separate
address ranges for IO memory.

This patch makes the code that writes the PQE to be ASIC-specific so we
can handle this properly per ASIC.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Tested-by: Ben Segal <bpsegal20@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c  |  7 ++++---
 drivers/misc/habanalabs/goya/goyaP.h |  2 +-
 drivers/misc/habanalabs/habanalabs.h |  9 +++++++--
 drivers/misc/habanalabs/hw_queue.c   | 14 +++++---------
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e8b1142910e0..b39b9c98fe1d 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2729,9 +2729,10 @@ void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 				GOYA_ASYNC_EVENT_ID_PI_UPDATE);
 }
 
-void goya_flush_pq_write(struct hl_device *hdev, u64 *pq, u64 exp_val)
+void goya_pqe_write(struct hl_device *hdev, __le64 *pqe, struct hl_bd *bd)
 {
-	/* Not needed in Goya */
+	/* The QMANs are on the SRAM so need to copy to IO space */
+	memcpy_toio((void __iomem *) pqe, bd, sizeof(struct hl_bd));
 }
 
 static void *goya_dma_alloc_coherent(struct hl_device *hdev, size_t size,
@@ -5048,7 +5049,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.resume = goya_resume,
 	.cb_mmap = goya_cb_mmap,
 	.ring_doorbell = goya_ring_doorbell,
-	.flush_pq_write = goya_flush_pq_write,
+	.pqe_write = goya_pqe_write,
 	.asic_dma_alloc_coherent = goya_dma_alloc_coherent,
 	.asic_dma_free_coherent = goya_dma_free_coherent,
 	.get_int_queue_base = goya_get_int_queue_base,
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index f8c611883dc1..d7f48c9c41cd 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -177,7 +177,7 @@ int goya_late_init(struct hl_device *hdev);
 void goya_late_fini(struct hl_device *hdev);
 
 void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi);
-void goya_flush_pq_write(struct hl_device *hdev, u64 *pq, u64 exp_val);
+void goya_pqe_write(struct hl_device *hdev, __le64 *pqe, struct hl_bd *bd);
 void goya_update_eq_ci(struct hl_device *hdev, u32 val);
 void goya_restore_phase_topology(struct hl_device *hdev);
 int goya_context_switch(struct hl_device *hdev, u32 asid);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 6a4c64b97f38..ce83adafcf2d 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -441,7 +441,11 @@ enum hl_pll_frequency {
  * @resume: handles IP specific H/W or SW changes for resume.
  * @cb_mmap: maps a CB.
  * @ring_doorbell: increment PI on a given QMAN.
- * @flush_pq_write: flush PQ entry write if necessary, WARN if flushing failed.
+ * @pqe_write: Write the PQ entry to the PQ. This is ASIC-specific
+ *             function because the PQs are located in different memory areas
+ *             per ASIC (SRAM, DRAM, Host memory) and therefore, the method of
+ *             writing the PQE must match the destination memory area
+ *             properties.
  * @asic_dma_alloc_coherent: Allocate coherent DMA memory by calling
  *                           dma_alloc_coherent(). This is ASIC function because
  *                           its implementation is not trivial when the driver
@@ -510,7 +514,8 @@ struct hl_asic_funcs {
 	int (*cb_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
 			u64 kaddress, phys_addr_t paddress, u32 size);
 	void (*ring_doorbell)(struct hl_device *hdev, u32 hw_queue_id, u32 pi);
-	void (*flush_pq_write)(struct hl_device *hdev, u64 *pq, u64 exp_val);
+	void (*pqe_write)(struct hl_device *hdev, __le64 *pqe,
+			struct hl_bd *bd);
 	void* (*asic_dma_alloc_coherent)(struct hl_device *hdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flag);
 	void (*asic_dma_free_coherent)(struct hl_device *hdev, size_t size,
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index e3b5517897ea..5f5673b74985 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -290,23 +290,19 @@ static void int_hw_queue_schedule_job(struct hl_cs_job *job)
 	struct hl_device *hdev = job->cs->ctx->hdev;
 	struct hl_hw_queue *q = &hdev->kernel_queues[job->hw_queue_id];
 	struct hl_bd bd;
-	u64 *pi, *pbd = (u64 *) &bd;
+	__le64 *pi;
 
 	bd.ctl = 0;
-	bd.len = __cpu_to_le32(job->job_cb_size);
-	bd.ptr = __cpu_to_le64((u64) (uintptr_t) job->user_cb);
+	bd.len = cpu_to_le32(job->job_cb_size);
+	bd.ptr = cpu_to_le64((u64) (uintptr_t) job->user_cb);
 
-	pi = (u64 *) (uintptr_t) (q->kernel_address +
+	pi = (__le64 *) (uintptr_t) (q->kernel_address +
 		((q->pi & (q->int_queue_len - 1)) * sizeof(bd)));
 
-	pi[0] = pbd[0];
-	pi[1] = pbd[1];
-
 	q->pi++;
 	q->pi &= ((q->int_queue_len << 1) - 1);
 
-	/* Flush PQ entry write. Relevant only for specific ASICs */
-	hdev->asic_funcs->flush_pq_write(hdev, pi, pbd[0]);
+	hdev->asic_funcs->pqe_write(hdev, pi, &bd);
 
 	hdev->asic_funcs->ring_doorbell(hdev, q->hw_queue_id, q->pi);
 }
-- 
2.17.1

