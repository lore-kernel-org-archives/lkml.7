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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4BBC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6C5204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH2H0sZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfESRM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:12:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55274 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfESRM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:12:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id i3so10975065wml.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EFKYpxqjUgA8HzBjiRCRwuGMXowQ2+hz3v8LScRXBnk=;
        b=XH2H0sZvvAQy/qBRtlQscFZeOSj54hKcB57GEOQbYorOgNMmEyyUy1+3lpu5Hh5mPY
         k5k3/VDSYnUv2FZrHGLAxtY57c3GFYJXx6/2YcFBd74XcVVp7yJi3sbmigns5JS3sv1X
         nziYkoPMEDPP0caS76UCI+RZ+SdZBV2d/hNpYsd07+sBBbc0aRA/+hXBsLXlI1et+DeG
         n9DpdcoEsvocotRXhKnmRslqezZ2G3X8OxmAQQBDXMKNQaL4v+MqwRPTv6KP2J+9iKuH
         IPTo1oIYap7QrsBNeA+HVDHF+C4JZIZ0qEcrJZzAWAV5uMNDLsmrj9tHK0k8YkEJf2eO
         +qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EFKYpxqjUgA8HzBjiRCRwuGMXowQ2+hz3v8LScRXBnk=;
        b=bsLv24rlL9Q7JzBC7qXvEzsPR3maiGkr6GtNZ002D6hOAE2YJdfLqjY1eaXpZJjkTG
         A3gAi4pq8CrLL0FOrOwaKxa9f9QS+suLHews/UlpsQDHqELL3UBCzpSowN1GFbAHhB4c
         Bqw9LG449/Xj5vJyk4VTeU2deH0H3hgIOmnTc/OXLzB8LOKymLTuYPEBVasnIV5jEhKv
         Sk/anbS34RcxfAl8RtzlYLOyqz/U50cF/su+VIkXqRVMCuN1iDC0ZIWma1sS/2mLeJ46
         SNGTynAex34qDjqH/p+tuxxZKphO5L5mzW7GSxjRlzpubmIhbHvxU1QBMPzR7VyjnBws
         BY5w==
X-Gm-Message-State: APjAAAXokvEgDjKHyJBt2LcHL4Ll1Ryhe3jNXM1dWfCRbGt1+j0mxapw
        cp8K+MsuMjChdO6mmWuF92AxGVq3
X-Google-Smtp-Source: APXvYqwH90bJYZgc5/3UxmkH9HSBXjCEauN9/++rWvVnzze+b1QnrrHaZSJh34VdL3I6q0Mg5rxl1Q==
X-Received: by 2002:a05:600c:10ca:: with SMTP id l10mr14088433wmd.23.1558264364289;
        Sun, 19 May 2019 04:12:44 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id s3sm26612570wre.97.2019.05.19.04.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 04:12:43 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/2] habanalabs: support device memory memset > 4GB
Date:   Sun, 19 May 2019 14:12:40 +0300
Message-Id: <20190519111241.23359-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to the goya memset function to perform memset to
device memory with size larger then 4GB. In this case, we need to use
multiple LIN_DMA packets because a single packet supports up to 4GB.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 49 ++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index be27ec6cf5fd..6ee5db697ca5 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4478,36 +4478,47 @@ void *goya_get_events_stat(struct hl_device *hdev, u32 *size)
 	return goya->events_stat;
 }
 
-static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u32 size,
+static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size,
 				u64 val, bool is_dram)
 {
 	struct packet_lin_dma *lin_dma_pkt;
 	struct hl_cs_job *job;
 	u32 cb_size, ctl;
 	struct hl_cb *cb;
-	int rc;
+	int rc, lin_dma_pkts_cnt;
 
-	cb = hl_cb_kernel_create(hdev, PAGE_SIZE);
+	lin_dma_pkts_cnt = DIV_ROUND_UP_ULL(size, SZ_2G);
+	cb_size = lin_dma_pkts_cnt * sizeof(struct packet_lin_dma) +
+						sizeof(struct packet_msg_prot);
+	cb = hl_cb_kernel_create(hdev, cb_size);
 	if (!cb)
-		return -EFAULT;
+		return -ENOMEM;
 
 	lin_dma_pkt = (struct packet_lin_dma *) (uintptr_t) cb->kernel_address;
 
-	memset(lin_dma_pkt, 0, sizeof(*lin_dma_pkt));
-	cb_size = sizeof(*lin_dma_pkt);
-
-	ctl = ((PACKET_LIN_DMA << GOYA_PKT_CTL_OPCODE_SHIFT) |
-			(1 << GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT) |
-			(1 << GOYA_PKT_LIN_DMA_CTL_WO_SHIFT) |
-			(1 << GOYA_PKT_CTL_RB_SHIFT) |
-			(1 << GOYA_PKT_CTL_MB_SHIFT));
-	ctl |= (is_dram ? DMA_HOST_TO_DRAM : DMA_HOST_TO_SRAM) <<
-			GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
-	lin_dma_pkt->ctl = cpu_to_le32(ctl);
+	do {
+		memset(lin_dma_pkt, 0, sizeof(*lin_dma_pkt));
+
+		ctl = ((PACKET_LIN_DMA << GOYA_PKT_CTL_OPCODE_SHIFT) |
+				(1 << GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT) |
+				(1 << GOYA_PKT_LIN_DMA_CTL_WO_SHIFT) |
+				(1 << GOYA_PKT_CTL_RB_SHIFT) |
+				(1 << GOYA_PKT_CTL_MB_SHIFT));
+		ctl |= (is_dram ? DMA_HOST_TO_DRAM : DMA_HOST_TO_SRAM) <<
+				GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
+		lin_dma_pkt->ctl = cpu_to_le32(ctl);
+
+		lin_dma_pkt->src_addr = cpu_to_le64(val);
+		lin_dma_pkt->dst_addr = cpu_to_le64(addr);
+		if (lin_dma_pkts_cnt > 1)
+			lin_dma_pkt->tsize = cpu_to_le32(SZ_2G);
+		else
+			lin_dma_pkt->tsize = cpu_to_le32(size);
 
-	lin_dma_pkt->src_addr = cpu_to_le64(val);
-	lin_dma_pkt->dst_addr = cpu_to_le64(addr);
-	lin_dma_pkt->tsize = cpu_to_le32(size);
+		size -= SZ_2G;
+		addr += SZ_2G;
+		lin_dma_pkt++;
+	} while (--lin_dma_pkts_cnt);
 
 	job = hl_cs_allocate_job(hdev, true);
 	if (!job) {
@@ -4522,7 +4533,7 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u32 size,
 	job->user_cb_size = cb_size;
 	job->hw_queue_id = GOYA_QUEUE_ID_DMA_0;
 	job->patched_cb = job->user_cb;
-	job->job_cb_size = job->user_cb_size + sizeof(struct packet_msg_prot);
+	job->job_cb_size = job->user_cb_size;
 
 	hl_debugfs_add_job(hdev, job);
 
-- 
2.17.1

