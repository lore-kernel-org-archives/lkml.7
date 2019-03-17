Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B075CC10F05
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE2C21738
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYmcnyyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCQT7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:59:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38099 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfCQT7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so14761513wrm.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N8k6Xio/wZQp66Oa/L8yITZ1faKLJ8d+TtmJedkqx0U=;
        b=KYmcnyyq3CRh2Z2McmnMqMcWWakv/a4vpDQPa8PN+HhSVPfvXwuwGQc87fgluIfD4Y
         HfHgGYjJfcmnVl55Eeaho7kMcjFzVs2iFUZFMz7X8ZVn2AqqUR5cI65xEC3vCHlTMKEL
         iiHvRGxuYEYEPyL3Bqh+X4yD2Yq/0xx+t38qW8pIDKbgucAY/NJo0uk9uPMIyhNiMy/K
         MThVQNegPMIKkE9IO6gUCid944bj63g/ijUzJhOY3A4YwnekicpR3zI6oVoPQluM5pla
         11+GCJJ27KWwG6nafMTjdOngCA+uMB+pK34RJ2pt0MBWzJ1YaO3gE3gGTAeZTtYzT5wD
         6VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N8k6Xio/wZQp66Oa/L8yITZ1faKLJ8d+TtmJedkqx0U=;
        b=cCk+niwI8H/ufDCfHCYI95cCtsrlAdDipwVSpnta7PaXjsrvTHM6X9ZMekc/64UFYN
         wRQ3qd5rUd2fSV99KwysaKZsAlS9zqPrDhSKJhL/BFdCtRU3pmpf4mQLMwOkm6GKpUH3
         NFDok6+zvHAiGuZDUVLBZQLe1c9ZNffUmlQm1/WAtiGg7e/x+MUDq8ZZTz9Yf1etVkaI
         QRWgXEnTT62jzKlX2VlUSg3f/3M3e2jFj+gFLHm4HFvAweAnzIK8egsEY7yV/fqtsBK0
         +1F4Tz0Y3JSN4pU30/LxOkdtNOX0f4xQieDfnk75li998fFrrka5WYS1Icv379yBczSL
         Qj6w==
X-Gm-Message-State: APjAAAWL0KaB5D4qqd64qiArcz1ud5WevjQAtHKR7vasTxkn6C3oRsW5
        861AgMJqZTuqHuIB54muYVvvqejQ
X-Google-Smtp-Source: APXvYqwN/lNMzvsiYgG/vCllra2Q40fYwJOpLYjnTec4CuV1fFrom45eUwtdAfM7FJ9NAmBzsBORog==
X-Received: by 2002:a5d:6a0c:: with SMTP id m12mr9499954wru.57.1552852777577;
        Sun, 17 Mar 2019 12:59:37 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:36 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 02/15] habanalabs: rename goya_non_fatal_events array to all events
Date:   Sun, 17 Mar 2019 21:59:14 +0200
Message-Id: <20190317195927.26238-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goya_non_fatal_events array actually contains all the possible events
the driver can receive from the F/W. Therefore, use a proper name
for the array.

The patch also adds missing event Ids to the goya_async_event_id enum.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c                      | 8 +++-----
 drivers/misc/habanalabs/include/goya/goya_async_events.h | 9 +++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0185f11c5577..3dfac5393269 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -176,9 +176,7 @@ static u64 goya_mmu_regs[GOYA_MMU_REGS_NUM] = {
 	mmMME_WBC_CONTROL_DATA
 };
 
-#define GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE 121
-
-static u32 goya_non_fatal_events[GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE] = {
+static u32 goya_all_events[] = {
 	GOYA_ASYNC_EVENT_ID_PCIE_IF,
 	GOYA_ASYNC_EVENT_ID_TPC0_ECC,
 	GOYA_ASYNC_EVENT_ID_TPC1_ECC,
@@ -4627,8 +4625,8 @@ static int goya_soft_reset_late_init(struct hl_device *hdev)
 	 * Unmask all IRQs since some could have been received
 	 * during the soft reset
 	 */
-	return goya_unmask_irq_arr(hdev, goya_non_fatal_events,
-			sizeof(goya_non_fatal_events));
+	return goya_unmask_irq_arr(hdev, goya_all_events,
+					sizeof(goya_all_events));
 }
 
 static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
diff --git a/drivers/misc/habanalabs/include/goya/goya_async_events.h b/drivers/misc/habanalabs/include/goya/goya_async_events.h
index 497937a17ee9..bb7a1aa3279e 100644
--- a/drivers/misc/habanalabs/include/goya/goya_async_events.h
+++ b/drivers/misc/habanalabs/include/goya/goya_async_events.h
@@ -9,7 +9,9 @@
 #define __GOYA_ASYNC_EVENTS_H_
 
 enum goya_async_event_id {
+	GOYA_ASYNC_EVENT_ID_PCIE_CORE = 32,
 	GOYA_ASYNC_EVENT_ID_PCIE_IF = 33,
+	GOYA_ASYNC_EVENT_ID_PCIE_PHY = 34,
 	GOYA_ASYNC_EVENT_ID_TPC0_ECC = 36,
 	GOYA_ASYNC_EVENT_ID_TPC1_ECC = 39,
 	GOYA_ASYNC_EVENT_ID_TPC2_ECC = 42,
@@ -23,6 +25,8 @@ enum goya_async_event_id {
 	GOYA_ASYNC_EVENT_ID_MMU_ECC = 63,
 	GOYA_ASYNC_EVENT_ID_DMA_MACRO = 64,
 	GOYA_ASYNC_EVENT_ID_DMA_ECC = 66,
+	GOYA_ASYNC_EVENT_ID_DDR0_PARITY = 69,
+	GOYA_ASYNC_EVENT_ID_DDR1_PARITY = 72,
 	GOYA_ASYNC_EVENT_ID_CPU_IF_ECC = 75,
 	GOYA_ASYNC_EVENT_ID_PSOC_MEM = 78,
 	GOYA_ASYNC_EVENT_ID_PSOC_CORESIGHT = 79,
@@ -72,6 +76,7 @@ enum goya_async_event_id {
 	GOYA_ASYNC_EVENT_ID_MME_WACSD = 142,
 	GOYA_ASYNC_EVENT_ID_PLL0 = 143,
 	GOYA_ASYNC_EVENT_ID_PLL1 = 144,
+	GOYA_ASYNC_EVENT_ID_PLL2 = 145,
 	GOYA_ASYNC_EVENT_ID_PLL3 = 146,
 	GOYA_ASYNC_EVENT_ID_PLL4 = 147,
 	GOYA_ASYNC_EVENT_ID_PLL5 = 148,
@@ -81,6 +86,7 @@ enum goya_async_event_id {
 	GOYA_ASYNC_EVENT_ID_PSOC = 160,
 	GOYA_ASYNC_EVENT_ID_PCIE_FLR = 171,
 	GOYA_ASYNC_EVENT_ID_PCIE_HOT_RESET = 172,
+	GOYA_ASYNC_EVENT_ID_PCIE_PERST = 173,
 	GOYA_ASYNC_EVENT_ID_PCIE_QID0_ENG0 = 174,
 	GOYA_ASYNC_EVENT_ID_PCIE_QID0_ENG1 = 175,
 	GOYA_ASYNC_EVENT_ID_PCIE_QID0_ENG2 = 176,
@@ -144,8 +150,11 @@ enum goya_async_event_id {
 	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_U16_0 = 330,
 	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_U16_1 = 331,
 	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_U16_2 = 332,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_U16_3 = 333,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_U16_4 = 334,
 	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_05_SW_RESET = 356,
 	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_10_VRHOT_ICRIT = 361,
+	GOYA_ASYNC_EVENT_ID_FAN = 425,
 	GOYA_ASYNC_EVENT_ID_TPC0_CMDQ = 430,
 	GOYA_ASYNC_EVENT_ID_TPC1_CMDQ = 431,
 	GOYA_ASYNC_EVENT_ID_TPC2_CMDQ = 432,
-- 
2.17.1

