Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F00AC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB55223CB
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSuLXbuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfHGIwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:52:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38212 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfHGIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:52:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so57807667wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 01:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JV7hH1pgfjZ9d+HA6zEghhOBITBR93qI64GMKKSzuDk=;
        b=uSuLXbuo/E2qWK2qtM/OMh+8vCLopUn/bGTIjZzKxKO0f9Z8KVeO50Wfoay96MyQPk
         yhQsgq3fVRYaqeVa68o4Vqv31XhJhBJyd/Suor9JrnBh8dWo/G4GjYp92DooW7R7KwCI
         rkZDJ3KgC11GkqPOABg3wlJtmIFOv3K+39Rs53h6C3gxP02iLeqz1rJelRhd9aIKbwLJ
         zg4GzjbbWDXZZa7Oh137qd68oxGEFp0DoT16TbJEZ2k1vCCtKBI7GOT5hjhsAWtziHKY
         9EVxCoSD088T/9bJYw0rPR2Tj13YOi6cFrXa3TflXVrqL0xMRECxIED3G5aB2snly+eX
         WjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JV7hH1pgfjZ9d+HA6zEghhOBITBR93qI64GMKKSzuDk=;
        b=nAg+rqkXphaZJCgWWb8Z+7UZ+xxoS/AJ08m8eYhbz8dByLqPCbApl93fjgnGz/At1k
         LZLBylQgND3/Bc8ogkmbJxnx8DA3sMNPeq3fZdqyN8iLhPVlKyXEo0BNF0gCchRPN77c
         b0NzdGCYSe5Tvl6EmaZXAUHFXUXHUMW7n9f1WM2UKmn8SDj13W1l5d6VRGxKbXyW7iJh
         R1Bh7CATpCAlP1yV0XLzSBzAL0JynEsW55NsDqsOrLPUAf3RC1jv43GYP4pTo81H61Yf
         EAhtRJFTY36WOLJUqXxFpQDzKlLZe6kSy5tv2zn9DoQgjlq+vS93fwsQ6NEPzIaGGHyT
         ljPg==
X-Gm-Message-State: APjAAAWb554mRHgtgxayM3Vf2S6h1qEWh2iI3+YkvhTEdCsaMkmpzcLx
        8nojqKgGVQDe4gY27zPGVCOgR16C504=
X-Google-Smtp-Source: APXvYqwMOukLR5PxkSYvIc8TBUL1jfSUBVol9YPjvmr1W1DiUmRB97hZaRZPuabb+6ra4BhZ49WXLg==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr9668156wma.164.1565167943992;
        Wed, 07 Aug 2019 01:52:23 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id x24sm88519035wmh.5.2019.08.07.01.52.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 01:52:23 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Ben Segal <bpsegal20@gmail.com>
Subject: [PATCH 2/2] habanalabs: fix completion queue handling when host is BE
Date:   Wed,  7 Aug 2019 11:52:17 +0300
Message-Id: <20190807085217.28488-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807085217.28488-1-oded.gabbay@gmail.com>
References: <20190807085217.28488-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Segal <bpsegal20@gmail.com>

This patch fix the CQ irq handler to work in hosts with BE architecture.
It adds the correct endian-swapping macros around the relevant memory
accesses.

Signed-off-by: Ben Segal <bpsegal20@gmail.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/irq.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index ea9f72ff456c..199791b57caf 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -80,8 +80,7 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 	struct hl_cs_job *job;
 	bool shadow_index_valid;
 	u16 shadow_index;
-	u32 *cq_entry;
-	u32 *cq_base;
+	struct hl_cq_entry *cq_entry, *cq_base;
 
 	if (hdev->disabled) {
 		dev_dbg(hdev->dev,
@@ -90,29 +89,29 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 		return IRQ_HANDLED;
 	}
 
-	cq_base = (u32 *) (uintptr_t) cq->kernel_address;
+	cq_base = (struct hl_cq_entry *) (uintptr_t) cq->kernel_address;
 
 	while (1) {
-		bool entry_ready = ((cq_base[cq->ci] & CQ_ENTRY_READY_MASK)
+		bool entry_ready = ((le32_to_cpu(cq_base[cq->ci].data) &
+					CQ_ENTRY_READY_MASK)
 						>> CQ_ENTRY_READY_SHIFT);
 
 		if (!entry_ready)
 			break;
 
-		cq_entry = (u32 *) &cq_base[cq->ci];
+		cq_entry = (struct hl_cq_entry *) &cq_base[cq->ci];
 
-		/*
-		 * Make sure we read CQ entry contents after we've
+		/* Make sure we read CQ entry contents after we've
 		 * checked the ownership bit.
 		 */
 		dma_rmb();
 
-		shadow_index_valid =
-			((*cq_entry & CQ_ENTRY_SHADOW_INDEX_VALID_MASK)
+		shadow_index_valid = ((le32_to_cpu(cq_entry->data) &
+					CQ_ENTRY_SHADOW_INDEX_VALID_MASK)
 					>> CQ_ENTRY_SHADOW_INDEX_VALID_SHIFT);
 
-		shadow_index = (u16)
-			((*cq_entry & CQ_ENTRY_SHADOW_INDEX_MASK)
+		shadow_index = (u16) ((le32_to_cpu(cq_entry->data) &
+					CQ_ENTRY_SHADOW_INDEX_MASK)
 					>> CQ_ENTRY_SHADOW_INDEX_SHIFT);
 
 		queue = &hdev->kernel_queues[cq->hw_queue_id];
@@ -122,8 +121,7 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 			queue_work(hdev->cq_wq, &job->finish_work);
 		}
 
-		/*
-		 * Update ci of the context's queue. There is no
+		/* Update ci of the context's queue. There is no
 		 * need to protect it with spinlock because this update is
 		 * done only inside IRQ and there is a different IRQ per
 		 * queue
@@ -131,7 +129,8 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 		queue->ci = hl_queue_inc_ptr(queue->ci);
 
 		/* Clear CQ entry ready bit */
-		cq_base[cq->ci] &= ~CQ_ENTRY_READY_MASK;
+		cq_entry->data = cpu_to_le32(le32_to_cpu(cq_entry->data) &
+						~CQ_ENTRY_READY_MASK);
 
 		cq->ci = hl_cq_inc_ptr(cq->ci);
 
-- 
2.17.1

