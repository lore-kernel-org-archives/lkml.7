Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A965C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19E02086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdpj7QmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404040AbfFKFva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:51:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46289 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403903AbfFKFuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:50:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so11405346wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 22:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/lVkLaRAqiXFSI1BN0UpH0mWB/FtWqA7YsYlfE1WfA8=;
        b=Qdpj7QmScKpvMwm6vE5Ut1XHOn7VuJYImJhFLtiyi/Z4PiFpksci4cCpjtzSaI+b9e
         UtT05h88B4pRMp79DkJNSR9OUXGsJFw/6RD2wvv3e6/lAe8Bwp2SSqEQHvPLs+MR7Vma
         mo5Rlo6RRRwuntDgafsR1Q5nvzThdoLEtziMO5Iuy4OZL6QsGZ/F9ZV2Opbnhik8T3WC
         t6KyeCyX6DThK1bCyzx0CMoWdNMRXPtDz0B76LlcSd3pP+WzJGFHUflh4i8nXv2lWpcy
         bs49ZRFr+S+ptwcKcepTw7t40PD4r37l5soQMV1C8jmyaaA83ohuJ53NBienF4OQL2kZ
         odLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/lVkLaRAqiXFSI1BN0UpH0mWB/FtWqA7YsYlfE1WfA8=;
        b=PEDAYsR5OOABuXPh0l4XmSe8KF60d3V66NhESz6FM3yZWDCZFi3qGNWpKmLs6f1rBR
         ybMvR9YgEZ6XytZIHZ/9ss0IiPkXIYOwAPdGuEQN6saQU8t2MQkqYhUZm7jmvk44qt9C
         2qmzjcgkyGSLTHKzzR40RF0FzugBS8hJBuzk9LOop67pIn0xgsh1AytHstM5xIw2qsSj
         bfcr7f6ZhA2Ot5tPYJb5zZSIKBVKwO1pH5mpdJrKZ2h6Iioh3Q6EsZVLoBcU5eCsZVmO
         NGIGjNQX+ummERhIOQ207qLz8hTJkjly2uujPB69meEgVI92V9CWZaef2mMYcwKRKURc
         QD/Q==
X-Gm-Message-State: APjAAAU/TSfVYvWGIxe+BpcgsOqe4z1sU4h9YRWpt1+eBEt4qUs5/1Vt
        3VWQSI0ULD3rpD6Xi2S0yIuXreVll14=
X-Google-Smtp-Source: APXvYqzxVannx7B9jNhgvKL2AqpEsLcc+WmFqX3r/ZUGSa3XyIA/66suChxEuGQ8A8+wecY0nD8Img==
X-Received: by 2002:a05:6000:146:: with SMTP id r6mr34999253wrx.237.1560232254169;
        Mon, 10 Jun 2019 22:50:54 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j8sm11968056wrr.64.2019.06.10.22.50.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 22:50:53 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 5/8] habanalabs: set Goya CPU to use ASIC MMU
Date:   Tue, 11 Jun 2019 08:50:42 +0300
Message-Id: <20190611055045.15945-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611055045.15945-1-oded.gabbay@gmail.com>
References: <20190611055045.15945-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch configures the Goya CPU to actually go through the MMU for
translation. The configuration is done after the configuration of the
relevant MMU mappings.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 4e41f2669e6d..9f1f47770afa 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -986,9 +986,9 @@ int goya_init_cpu_queues(struct hl_device *hdev)
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_3, upper_32_bits(eq->bus_address));
 
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_8,
-			lower_32_bits(hdev->cpu_accessible_dma_address));
+			lower_32_bits(VA_CPU_ACCESSIBLE_MEM_ADDR));
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_9,
-			upper_32_bits(hdev->cpu_accessible_dma_address));
+			upper_32_bits(VA_CPU_ACCESSIBLE_MEM_ADDR));
 
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_5, HL_QUEUE_SIZE_IN_BYTES);
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_4, HL_EQ_SIZE_IN_BYTES);
@@ -3011,7 +3011,13 @@ static void goya_dma_pool_free(struct hl_device *hdev, void *vaddr,
 void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
 					dma_addr_t *dma_handle)
 {
-	return hl_fw_cpu_accessible_dma_pool_alloc(hdev, size, dma_handle);
+	void *vaddr;
+
+	vaddr = hl_fw_cpu_accessible_dma_pool_alloc(hdev, size, dma_handle);
+	*dma_handle = (*dma_handle) - hdev->cpu_accessible_dma_address +
+			VA_CPU_ACCESSIBLE_MEM_ADDR;
+
+	return vaddr;
 }
 
 void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
@@ -4667,6 +4673,14 @@ static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev)
 		}
 	}
 
+	goya_mmu_prepare_reg(hdev, mmCPU_IF_ARUSER_OVR, HL_KERNEL_ASID_ID);
+	goya_mmu_prepare_reg(hdev, mmCPU_IF_AWUSER_OVR, HL_KERNEL_ASID_ID);
+	WREG32(mmCPU_IF_ARUSER_OVR_EN, 0x7FF);
+	WREG32(mmCPU_IF_AWUSER_OVR_EN, 0x7FF);
+
+	/* Make sure configuration is flushed to device */
+	RREG32(mmCPU_IF_AWUSER_OVR_EN);
+
 	goya->device_cpu_mmu_mappings_done = true;
 
 	return 0;
@@ -4702,6 +4716,9 @@ void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev)
 	if (!goya->device_cpu_mmu_mappings_done)
 		return;
 
+	WREG32(mmCPU_IF_ARUSER_OVR_EN, 0);
+	WREG32(mmCPU_IF_AWUSER_OVR_EN, 0);
+
 	if (!(hdev->cpu_accessible_dma_address & (PAGE_SIZE_2MB - 1))) {
 		if (hl_mmu_unmap(hdev->kernel_ctx, VA_CPU_ACCESSIBLE_MEM_ADDR,
 				PAGE_SIZE_2MB))
-- 
2.17.1

